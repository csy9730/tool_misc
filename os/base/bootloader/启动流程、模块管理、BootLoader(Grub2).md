# 启动流程、模块管理、BootLoader(Grub2)

![img](https://upload.jianshu.io/users/upload_avatars/4809537/0a5dc0a62be1.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[Zhang21](https://www.jianshu.com/u/f13278e94ecb)关注

0.3062017.06.09 14:41:00字数 9,282阅读 6,607

系统启动是一项非常复杂的程序，因为内核得先检测硬件并加载适当的驱动程序后，接下来则必须要调用程序来准备好系统运行的环境，让用户能够顺利操作主机系统。

如果你能够理解开机的原理，那么将有助于你在系统出问题时能够快速修复系统。而且还能够顺利的配置多重操作系统的多重引导问题。

为了多重引导，就不能不学grub2这个Linux下优秀的引导装载程序（boot loader）。而且在系统运作期间，你也要学会管理内核模块。



## 1、Linux的启动流程分析

如果想要多重开机，如果root密码忘记，如果/etc/fstab设置错误等，如何解决？

#### 1.1、启动流程一览

目前各大Linux distributions使用的主流 boot loader为grub2，早期是grub1或LILO。

以个人Linux主机为例，当按下电源后，电脑硬件会主动读取BIOS或UEFI BIOS来载入硬件信息及进行硬件系统的自我测试。之后系统会主动去读取第一个可开机的设备（由BIOS设置），此时就可以读入引导装载程序。

引导装载程序可以指定使用哪个内核文件来启动，并实际加载内核到内存当中解压缩与执行，此时内核就可以在内存中运行，并检测所有硬件信息与加载适当的驱动程序来使这部主机运行。等到内核检测硬件与加载驱动程序完毕后，操作系统已在你的PC上面跑起来了。

主机系统运行后，Linux才会调用外部程序开始准备软件执行的环境，并实际加载系统运行所需的软件程序。最后系统就会开始等待你的登录与操作。

**系统启动过程如下：**

> 1，加载BIOS的硬件信息与进行自检，并依据设置取得第一个可启动的设备（硬盘，光盘，U盘）；
>
> 2，读取并执行第一个启动设备内MBR（主引导分区）的 boot loader（如grub2）；
>
> 3，依据 boot loader的设置加载Kernel，Kernel会开始检测硬件与加载驱动程序；
>
> 4，在硬件驱动成功后，Kernel会主动调用systemd进程（原来的init进程），并以default.targert流程开机；
>
> systemd执行sysinit.target初始化系统及basic.target准备作业系统；
>
> systemd启动multi-user.target下的本机与服务器服务；
>
> systemd执行multi-user.target下的/etc/rc.d/rc.local文件；
>
> systemd执行multi-user.target下的getty.target及登录服务；
>
> systemd执行graphical需要的服务

#### 1.2、BIOS，boot loader与Kernel加载

**BIOS**：不论传统的BIOS还是UEFI BIOS都会被称为BIOS；

**MBR**：虽然分割表有传统MBR以及新式的GPT，不过GPT也保留一块相容的MBR的区块，因此，底下的说明在安装boot loader的部分，都简称MBR。总之，MBR就代表该磁盘最前面可安装boot loader的那个区块。

**BIOS，开机自检与MBR/GPT**

由于不同的操作系统的文件格式各不相同，因此我们必须要以一个开机管理程序来处理核心文件载入（load）的问题，因此这个开机管理程序就被称为 boot loader。boot loader安装在开机装置的第一个扇区（sector）内，也就是我们一直谈论的MBR。

只要BIOS能够检测到你的磁盘（无论SATA还是IDE接口），那它就有办法通过INT 13 这条信道来读取该磁盘的第一个扇区内的MBR，这样boot loader也就能够被执行。

> Tips：
>
> 我们知道每科硬盘的最前面区块含有MBR或GPT分割表的提供loader的区块，那么如果我的主机上面有两个硬盘，系统会去哪个硬盘的最前面区块读取boot loader呢？这个就要看BIOS的设定了。
>
> 基本上，我们常常讲的 "系统的MBR" 其实指的是第一个开机装置的MBR才对。需要注意。

**Boot Loader的功能**

loader最主要的功能是要认识操作系统的文件格式并载入内核到内存中去执行，由于不同的操作系统的文件格式不一致，因此每种作业系统都有自己的boot loader。

多重操作系统？必须要使用自己的loader才能够载入属于自己的操作系统内核；但系统的MBR只有一个，那么怎么样同时在一台主机上面安装Linux和Windows呢？

其实**每个文件系统（filesystem）**或**分区（partition**）都会**保留一块开机磁区（boot sector）**提供作业系统安装boot loader，而通常操作系统默认会安装一份loader到他根目录所在的文件系统的boot sector上。



![img](https://upload-images.jianshu.io/upload_images/4809537-b8c0b7d8ee9647c6.png?imageMogr2/auto-orient/strip|imageView2/2/w/323/format/webp)

boot sector与操作系统的关系

如图所示，**每个操作系统都会安装一套boot loader到它自己的文件系统中**。Linux安装时，可以选择将boot loader安装到MBR去，也可以选择不安装。Windows默认将MBR和boot sector都安装boot loader。所以，你会发现安装多重操作系统时，你的MBR常常会被不同的操作系统的boot loader所覆盖。

虽然各个操作系统都可以安装一份boot loader到他们的boot sector中，这样操作系统可以通过自己的boot loader来载入核心。可问题是MBR只有一个，要如何执行boot sector内的loader呢？

boot loader的主要功能是：

> 提供选单，使用者可以选择不同的开机项目，这也是多重开机的功能；
>
> 载入核心文档，直接指向可开机的程序区段来开始作业系统；
>
> 转交其他loader，将开机管理功能转交给其他loader负责；

由于具有控制权转交的功能，因此可以载入其他boot sector内的loader。不过Windows的loader默认不具有控制权转交功能，因此不能使用Windows的loader来载入Linux的loader，所以为什么需要先装Windows再装Linux。





![img](https://upload-images.jianshu.io/upload_images/4809537-7fdf28ebc49e8483.png?imageMogr2/auto-orient/strip|imageView2/2/w/370/format/webp)

引导装载程序菜单功能与控制权转交示意图

> 选单一：MBR(grub2) --> kernel file --> booting；
>
> 选单二：MBR(grub2) --> boot sector(Windows loader) --> Windows kernel --> booting；
>
> 选单三：MBR(grub2) --> boot sector(grub2) --> kernel file --> booting；

**加载内核检测硬件与initramfs的功能**

当由boot loader的管理而开始读取内核文件后，Linux就会将内核解压缩到内存中，并利用内核的功能开始测试与驱动各周边设备。此时，Linux内核会以自己的功能重新侦测一次硬件，而不一定会使用BIOS检测的硬件。

一般来说，内核文件放置在/boot里，并取名为/boot/vmlinuz。



![img](https://upload-images.jianshu.io/upload_images/4809537-656e01d2e4c9c6c6.png?imageMogr2/auto-orient/strip|imageView2/2/w/722/format/webp)

Linux内核模块放置在/lib/modules/ 目录内（**/lib不可与/放置于不同的分区**），因为在开机过程中内核必须要先挂载根目录，这样才能够读取内核模块来载入驱动程序。



一般来说，非必要的功能且可以编译成模块的内核功能，目前的Linux distributions都会将它编译成模块。如USB，SATA等设备的驱动程序通常都是以模块的方式存在的。

但是，内核根本不认识SATA磁盘，所以需要载入SATA磁盘的驱动，否则根本就无法挂载根目录。但是SATA的驱动在/lib/modules内，你根本无法挂载 /目录 又怎么读取到/lib/modules内的驱动呢？



这时候就需要通过虚拟文件系统来解决了。**虚拟文件系统（Initial RAM Disk(Filesystem)）**，一般的文件名为/boot/initrd或/boot/initramfs。它能够通过boot loader来载入到内存中，然后这个文档会被解压缩并且在内存中模拟成一个根目录，且此模拟在内存中的文件系统能够提供一支可执行的程序，通过该程序来载入开机过程中所需要的核心模块，通常这些模块就是USB，RAID，LVM，SCSI等文件系统与磁盘的驱动程序。



![img](https://upload-images.jianshu.io/upload_images/4809537-90b77fda5f247238.png?imageMogr2/auto-orient/strip|imageView2/2/w/750/format/webp)

BIOS与boot loader及内核载入流程

在核心完整载入后，你的主机应该就开始正常的运作了，接下来就要开始执行系统的第一支进程：systemd！

#### 1.3、第一个进程systemd及使用default.target进入开机程序分析

在内核载入完毕，硬件检测驱动载入后，此时内核就会主动呼叫第一个进程--systemd（PID为1）。systemd最主要的功能就是准备软件执行的环境（包括系统主机名、网络、语系、文件系统格式及其他服务的启动）。所有的动作都会通过systemd的预设启动服务集合，亦即/etc/systemd/system/default.target来规划。另外，systemd已经舍弃沿用多年的system V的runlevel了哦！

**常见的操作环境target与相同的runlevel等级**

过去的system V使用的是runlevel（执行等级）的概念来启动系统，systemd也与runlevel相结合。



![img](https://upload-images.jianshu.io/upload_images/4809537-e00c916e2fe7fc2f.png?imageMogr2/auto-orient/strip|imageView2/2/w/788/format/webp)

对应关系



![img](https://upload-images.jianshu.io/upload_images/4809537-d51cca52c04e4199.png?imageMogr2/auto-orient/strip|imageView2/2/w/717/format/webp)

对应关系

**systemd的处理流程**

当我们取得了/etc/systemd/system/default.target这个预设操作界面的设置之后，系统会到/usr/lib/systemd/system/这个目录下去取得multi-user.target或graphical.target之一。

假设我们使用的是graphical.target，接下来systemd回去找两个地方的设置：

> **/etc/systemd/system/graphical.target.wants/ ：**使用者设置载入的unit；
>
> **/usr/lib/systemd/system/graphical.target.wants/：**系统预设载入的unit；



![img](https://upload-images.jianshu.io/upload_images/4809537-85e8bb2ca9cdde55.png?imageMogr2/auto-orient/strip|imageView2/2/w/732/format/webp)

/usr/lig/systemd/system/graphical.target

上图表示graphical.target必须要完成multi-user.target之后才能进行，进行完graphical.target之后，还得要display-manager.service才行。那通过同样的方式，我们来看看multi-user.target的启动需要载入那些项目。



![img](https://upload-images.jianshu.io/upload_images/4809537-855c67d67d34308e.png?imageMogr2/auto-orient/strip|imageView2/2/w/745/format/webp)

/usr/lib/systemd/system/multi-user.target



![img](https://upload-images.jianshu.io/upload_images/4809537-1cd985588cf4cb36.png?imageMogr2/auto-orient/strip|imageView2/2/w/814/format/webp)

如上，multi-user.target需要在basic运行完毕后才能载入上诉许多unit哩。

**Tips：**

> 要知道系统的服务启用流程，最简单可使用“ systemctl list-dependencies graphcial.target”，如果想要知道背后的设定意义，那就分别找出/etc与/usr/lib下面的wants文件，当然还有Requires这个设定值。

基本上Centos7.x开机流程是这样：

> 1，local-fs.target+swap.target：这两个主要挂载本机/etc/fstab里面与相关内存交换空间；
>
> 2，sysinit.target：主要检测硬件，载入所需的内核模块等；
>
> 3，basic.target：载入主要的硬件驱动与防火墙相关任务；
>
> 4，multi-user.target：载入其他一般系统或网络服务载入；
>
> 5，graphical.target：载入图形界面相关服务。

####  

#### 1.4、systemd执行sysinit.target初始化系统，basic.target准备系统

基本上，可以把sysinit.target这些服务分成几大类：

> 特殊文件系统设备的挂载；
>
> 特殊文件系统的启用；
>
> 开机过程的信息传输与动画执行；
>
> 日志文件的使用；
>
> 载入额外内核模块；
>
> 设定终端机（console）字形；
>
> 启动动态设备管理员；



**不论使用哪种操作环境来使用系统，这个sysinit.target都是必要的工作。**



basic.target这个项目，它主要启动的服务有：

> 载入alsa音效驱动；
>
> 载入firewalld防火墙；
>
> 载入CPU的微指令功能；
>
> 启动与设置SELinux的安全文本；
>
> 将目前的开机所产生的信息写入/var/log/dmesg中；
>
> 由/etc/sysconfig/modules/*.modules及/etc/rc.modules载入管理员指定的模块；
>
> 载入systemd支援的timer功能；

在这个阶段完成后，系统已经可以顺利运作。就差一堆你需要的登录服务、网络服务、认证服务等。



#### 1.5、systemd启动multi-user.target下的服务

一般来说，服务的启动脚本设置都放置于一下目录：

> **/usr/lib/systemd/system**  （系统默认服务启动脚本）  
>
> **/etc/systemd/system**  （管理员自己开发与设置的脚本）  



使用者针对主机的服务的各项unit若要enable的话，就是将它放到/etc/systemd/system/multi-user.target.wants/目录下面去做个连接，这样就可以在开机时会自动启动它。



![img](https://upload-images.jianshu.io/upload_images/4809537-db858fb646621c0f.png?imageMogr2/auto-orient/strip|imageView2/2/w/870/format/webp)

mongod开机自启详细



**相容的system V的rc-local.service**

老版的Linux里，系统完成开机后还想要让系统额外执行某些程序，可以将该程序或脚本放入到/etc/rc.d/rc.local下去。

新版Linux的systemctl机制中，建议直接写一个systemd的启动脚本文件到/etc/systemd/system下，然后用systemctl enable启动它。

但是放置到/etc/rc.d/rc.local下的脚本systemd也支持，那就是rc-local.service这个服务。这个服务不需要启动，它会判断/etc/rc.d/rc.local是否具有可执行的权限来判断要不要启动这个服务。



![img](https://upload-images.jianshu.io/upload_images/4809537-48934cff0df3f7fd.png?imageMogr2/auto-orient/strip|imageView2/2/w/726/format/webp)

/etc/rc.d/rc.local



**提供tty界面与登入的服务**

能不能提供登录服务也是multi-user.target底下的内容，包括systemd-logind.service，systemd-user-sessions.service等服务。

如果getty服务先启动完毕，你会发现有可用的终端尝试让你登录系统。问题是，如果systemd-logind.service或systemd-user-sessions.service服务未启动完毕的话，那么你还是无法登录系统的。这就能解释为什么我们在刚开机时可能输入了正确的账号密码却无法登录系统。



#### 1.6、systemd启动graphical.target底下的服务

graphical.target，systemd就会开始载入用户管理服务与图形界面管理员（window display manager，DM）等，启动图形界面来让用户以图形的界面登录系统。



![img](https://upload-images.jianshu.io/upload_images/4809537-e32bb36dbac929f3.png?imageMogr2/auto-orient/strip|imageView2/2/w/623/format/webp)

graphical.target启动依赖





![img](https://upload-images.jianshu.io/upload_images/4809537-aca6a855927cc601.png?imageMogr2/auto-orient/strip|imageView2/2/w/608/format/webp)

multi-user.target启动依赖

graphical.target相较于multi-user.target多的那几项大多数是图形界面账号管理的功能，gdm.service是让使用者利用图形界面登录的服务。



#### 1.7、开机过程中会用到的主要配置文件

基本上，systemd有自己的配置文件处理方式，不过为了相容于system V，很多的服务脚本文件还是会读取位于/etc/sysconfig/ 下的配置文件。



**关于模块：/etc/modprobe.d/\*.conf以及/etc/modules-load.d/\*.conf**

有两个地方可以处理模块载入问题：

> /etc/modules-load.d/*.conf    #单纯要内核载入模块的位置；
>
> /etc/modprobe.d/*.conf    #可以加上模块参数的位置；

如果你有某些特定的参数要处理时，就得要在这两者进行。

**/etc/sysconfig/\***



![img](https://upload-images.jianshu.io/upload_images/4809537-dd705a26a7184e08.png?imageMogr2/auto-orient/strip|imageView2/2/w/856/format/webp)

/etc/sysconfig/

**authconfig：**

> 规范使用者的身份认证机制，包括是否使用本机的/etc/passwd，/etc/shadow等，以及/etc/shadow密码记录使用何种加密算法等。使用“authconfig-tui指令来修改较佳！”

**cpupower：**

> 如果有启动cpupower.service这个服务，他就会读取这个配置文件。主要是Linux核心如何操作CPU的原则。

**firewalld，iptables-config，ip6tables-config，ebtables-config：**

> 与防火墙服务启动的参数有关。

**network-scripts/：**

> 主要用于网卡配置。





## 2、内核与内核模块

在开机过程中，是否能够成功的驱动我们主机的硬件设备，是内核（Kernel）的工作！而内核一般都是压缩档，因此在使用内核之前，得先将它解压缩后，才能加载到内存中。

目前的内核都是具有可读取模块化驱动程序的功能，即所谓的“modules”（模块化）功能，所谓的模块化可以将它想象出一个插件，该插件可能由硬件开发厂商提供或我们的内核本来就支持。

内核与内核模块放在哪？

> 内核：/boot/vmlinuz；
>
> 内核解压缩所需RAMDisk：/boot/initramfs（/boot/initramsfs-$Version）；
>
> 核心模块：/lib/modules/$version/kernel或/lib/modules/$(uname -r)/kernel；
>
> 核心原始码：/usr/src/linux或/usr/src/kernels/（要安装了才会有，默认不安装）



如果内核被顺利加载到系统中，会有以下几个信息被记录下来

> 内核版本：/proc/version；
>
> 系统内核功能：/proc/sys/kernel/



问题来了，如果我有一个新硬件，偏偏我的操作系统不支持，怎么办？

> 重新编译内核，并加入最新的硬件驱动程序源码；
>
> 将该硬件的驱动程序编译成为模块，在启动时加载该模块。

####  

#### 2.1、内核模块与依赖性

核心模块放在/lib/modules/$(uname -r)/kernel中，里面分成这几个目录

> arch：与硬件平台有关的项目，如CPU的等级；
>
> crypto：核心所支持的加密技术，如md5或des等；
>
> drivers：一些硬件驱动程序，如显卡网卡等；
>
> fs：内核所支持的filesystem，如vfat，nfs等；
>
> lib：一些函数库；
>
> net：与网络有关的各项协定资料，防火墙模块等；
>
> sound：与音效有关模块组



Linux提供了一些模块组依赖性解决方案，那就是检查/lib/modules/$(uanme -r)/modules.dep这个文件，它记录了在核心支援的模块的各项依赖性。利用depmod命令即可。



![img](https://upload-images.jianshu.io/upload_images/4809537-58230bd8ae03c51c.png?imageMogr2/auto-orient/strip|imageView2/2/w/716/format/webp)

depmod命令

Kernel内核模块扩展名一定是以.ko结尾的。



#### 2.2、内核模块的查看

> lsmod    #查看目前内核加载了多少模块



![img](https://upload-images.jianshu.io/upload_images/4809537-fe48c5ebf2c98c70.png?imageMogr2/auto-orient/strip|imageView2/2/w/616/format/webp)

lsmod

显示内容有：

> 模块名称（Module）；
>
> 模块的大小（Size）；
>
> 模块是否被其他模块所使用的（Used by）；    #如上，nf_nat_masquerade_ipv4先被载入后，ipt_MASQUERADE才能进一步载入系统。

使用modinfo命令查询模块信息



![img](https://upload-images.jianshu.io/upload_images/4809537-0d13b1aa69f63f25.png?imageMogr2/auto-orient/strip|imageView2/2/w/729/format/webp)

modinfo命令

####  

#### 2.3、内核模块的加载如删除

如何手动加载模块？

使用 **modprobe** 这个命令来载入模块，因为modprobe会主动去搜寻modules.dep的内容，先克服模块的依赖性才决定需要载入的模块有哪些。

insmod命令则完全有用户自行加载一个完整文件名的模块，并不会主动分析模块依赖性。使用rmmod删除这个模块。



![img](https://upload-images.jianshu.io/upload_images/4809537-ad1b30a6d27b6e64.png?imageMogr2/auto-orient/strip|imageView2/2/w/721/format/webp)

insmod



![img](https://upload-images.jianshu.io/upload_images/4809537-fc9a8e9c7a6bcda5.png?imageMogr2/auto-orient/strip|imageView2/2/w/717/format/webp)

rmmod



使用insmod或rmmod命令的问题是，你必须自行找到模块的完整文件名才行，万一模块有依赖性的问题时，你将无法直接加载或删除该模块。所以，建议使用modprobe命令。



![img](https://upload-images.jianshu.io/upload_images/4809537-16a4e074849d0649.png?imageMogr2/auto-orient/strip|imageView2/2/w/721/format/webp)

modprobe

####  



## 3、Boot Loader：Grub2

BootLoader是加载内核的重要工具，没有BootLoader，Kernel根本无法被载入系统。

Centos7已将沿用多年的BootLoader从grub换成了grub2。



#### 3.1、BootLoader的两个stage

我们知道，MBR是整个磁盘的第一个sector内的一个区块，充其量整个大小也才446Byte。即使是GPT也没有很大的磁区来储存loader的资料。所以Linux将boot loader的程序代码执行与设置值加载分成两个阶段（stage）来执行。

**Stage1：执行boot loader主程序**

> 第一阶段执行boot loader的主程序，这个主程序必须要被安装在开机区，亦即是MBR或boot sector。但因为MBR实在太小了，所以MBR或boot sector通常仅安装boot loader的最小主程序，并没有安装loader的相关配置文件。

**Stage2：主程序加载配置文件**

> 第二阶段为通过boot loader加载所有配置文件与相关的环境参数配置文件包括文件系统定义与主要配置文件grub.cfg），一般来说，配置文件都在/boot下。



**与grub2有关的文件都放在/boot/grub2：**



![img](https://upload-images.jianshu.io/upload_images/4809537-900783f638b775ac.png?imageMogr2/auto-orient/strip|imageView2/2/w/720/format/webp)

/boot/grub2

####  

#### 3.2、grub2的配置文件/boot/grub2/grub.cfg

grub2功能挺多的：

> 认识与支援较多的文件系统，并且可以使用grub2的主程序直接在文件系统中查找内核文件名；
>
> 启动的时候，可以自行编辑与修改启动设置选项，类似bash的命令模式；
>
> 可以动态查找配置文件，而不需要在修改配置文件后重新安装grub。即只需修改/boot/grub2/grub.cfg里面的设置就行，下次开机就生效。
>
> \#其实这三点就是Stage1，2分别安装在MBR与文件系统中的原因。



**硬盘与分割槽在grub2中的代号**

grub2是如何识别磁盘的呢？



![img](https://upload-images.jianshu.io/upload_images/4809537-3a5618f3aacaec5f.png?imageMogr2/auto-orient/strip|imageView2/2/w/517/format/webp)

跟/dev/sda1不相同。其实只要注意这几个东西就行：

> 硬盘代号以小括号（）包起来；
>
> 硬盘以hd表示，后面会接一组数字；
>
> 以“查找顺序”为硬盘的编号，而不是依照电缆的排序；
>
> 第一个查找的硬盘为0号，第二个为1号，以此类推；
>
> 每块硬盘的第一个分区代号为1，依序类推；

所以说，第一个查找到的磁盘为“hd0”，而该磁盘的第一个分区为（hd0，1）。



![img](https://upload-images.jianshu.io/upload_images/4809537-c6b6573501e32fe0.png?imageMogr2/auto-orient/strip|imageView2/2/w/763/format/webp)

硬盘代号



**/boot/grub2/grub.cfg配置文件**

不要随便改动grub.cfg配置文件。



![img](https://upload-images.jianshu.io/upload_images/4809537-28c3eedb5546aa50.png?imageMogr2/auto-orient/strip|imageView2/2/w/717/format/webp)

在grub.cfg开始部分，大多是环境设置与预设值等，比较重要的默认由哪个选项开机（set default）以及默认的秒数（set timeout），再则就是每个选单的设定，在menuentry这个设置值后的项目。包括了--class，--unrestricted等制定项目，之后通过{ }将选单会用到的资料框起来。grub2会载入模块。



![img](https://upload-images.jianshu.io/upload_images/4809537-bb7141b34bbbb6b2.png?imageMogr2/auto-orient/strip|imageView2/2/w/727/format/webp)

比较重要的三个项目：

> set root='hd0，gpt2'   #这root是指grub2配置文件所在的那个设备；
>
> linux16/vmlinuz-xxxxx/centos-root = xxx    #这是Linux内核文件以及内核执行时所下达的参数；
>
> initrd16/initramfs-3.10...    #这是initramfs所在的文件名

####  

#### 3.3、grub2配置文件维护/etc/default/grub与/etc/grub.d

**通过/etc/default/grub这个主要环境配置文件与/etc/grub.d/目录内相关配置文件来处理grub.cfg比较妥当。**

------

**/etc/default/grub主要环境配置文件**



![img](https://upload-images.jianshu.io/upload_images/4809537-289cef26570416b8.png?imageMogr2/auto-orient/strip|imageView2/2/w/789/format/webp)

/etc/default/grub

几个重要的设定选项：

> 倒数时间参数：GRUB_TIMEOUT；
>
> 是否隐藏菜单选项：GRUB_TIMEOUT_STYLE；
>
> 信息输出的终端机模式：GRUB_TERMINAL_OUTPUT；    #主要有console，serial，gfxterm，vga_text等；
>
> 默认开机选项：GRUB_DEFAULT    #能使用的值包括有saved，数字，title名，ID名等；
>
> 内核的额外参数功能：GRUB_CMDLINE_LINUX    #如果你的核心在启动的时候还需要加入额外的参数，那就在这里加入吧。
>
> \#GRUB_CMDLINE_LINUX="..... crashkernel=auto rhgb quiet *elevator=deadline*"

这些主要环境设置完毕后，必须要使用 **grub2-mkconfig** 来重建grub.cfg才行。但不必重启系统，是不是很方便了！

> grub2-mkconfig  -o  /boot/grub2/grub.cfg



自己额外设定的项目，就是写入/etc/default/grub就行了。

> 假设你需要(1)开机选单等待40 秒钟、 (2)预设用第一个选单开机、 (3)选单请显示出来不要隐藏、 (4)核心外带『elevator=deadline』的参数值， 那应该要如何处理grub.cfg 呢？



![img](https://upload-images.jianshu.io/upload_images/4809537-ed4eec7d15c1e74d.png?imageMogr2/auto-orient/strip|imageView2/2/w/725/format/webp)

自定义



**选单建置的脚本/etc/grub.d/\***

其实grub2-mkconfig会去分析/etc/grub.d/*里面的文件，然后执行该文件的来构建grub.cfg的啦。一般来说，/etc/grub.d/*下会有这些文件存在：



![img](https://upload-images.jianshu.io/upload_images/4809537-1f284035426bf5fa.png?imageMogr2/auto-orient/strip|imageView2/2/w/579/format/webp)

/etc/grub.d/

> 00_header：主要在建立初始的显示项目，包括需要载入的模块分析、屏幕终端格式，倒数秒数、菜单隐藏等，大部分在/etc/default/grub里所设置的便是，都会在这个脚本中被利用来重建grub.cfg；
>
> 10_linux：根据分析/boot下的文件，尝试找到正确的linux内核与读取这个内核需要的文件系统模块与参数等，都在这个脚本运行后找到并设置到grub.cfg中；
>
> 30_os-prober：这个脚本默认会到系统上找其他的partition里面可能包含的操作系统，然后将该操作系统做成选项来处理就是了；
>
> 40_custom：如果你还有其他想要自己手动加上去的选单项目，或者是其他需求，那么建议在这里补充。



所以，一般来说，我们会修改的仅有40_custom这个文件。我们知道，menuentry就是一个选项，那后续的项目有哪些呢？常见有这几项：

> 直接指定内核开机；
>
> 通过chainloader的方式移交loader的控制权；

####  

#### 3.4、initramfs的重要性 与 建立initramfs文件

initramfs内所包含的模块大多是与开机过程有关，而主要以文件系统及硬盘模块（USB、SCSI等）为主。

一般来说，需要initramfs的时刻为：

> 根目录所在磁盘为SATA、USB或SCSI等连接；
>
> 根目录所在磁盘文件系统为LVM、RAID等特殊格式；
>
> 根目录所在文件系统为非传统Linux认识的文件系统时；
>
> 其他必须要在内核加载时提供的模块；
>
> \#早期的IDE硬盘没有initramfs也可开机（Linux内核能直接识别），但自从SATA硬盘后，没有initramfs就无法开机，因为内核无法识别需要先载入SCSI模块来驱动。



一般来说，各distribution提供的内核都会附上initramfs文件，但如果有需要想重制initramfs文件的话，可以使用 dracut（Centos7）/mkinitrd（老版） 来处理。

> **dracut**



![img](https://upload-images.jianshu.io/upload_images/4809537-1c5af54f1e21a139.png?imageMogr2/auto-orient/strip|imageView2/2/w/728/format/webp)

dracut





![img](https://upload-images.jianshu.io/upload_images/4809537-d122681bda0d1e88.png?imageMogr2/auto-orient/strip|imageView2/2/w/718/format/webp)

dracut

####  

#### 3.5、测试与安装grub2

如果Linux主机使用的本来就是grub2就不用安装了。

首先，必须要使用grub-install将一些文件复制到/boot/grub2里面去。



![img](https://upload-images.jianshu.io/upload_images/4809537-fa2ba2b7f160fdb7.png?imageMogr2/auto-orient/strip|imageView2/2/w/728/format/webp)

grub2-install

基本上，grub2-install大概仅能安装grub2主程序到boot sector中去，如果后面的设备是整个系统（/dev/sda...），那loader程序才会写入到MBR里去。

> 如果是从其他boot loader转成grub2时，得先使用grub2-install安装grub2配置文件；
>
> 如果安装到分区时，可能需要加上额外的许多参数才能顺利安装；
>
> 开始编辑/etc/default/grub及/etc/grub.d/*这几个重要文件；
>
> 使用grub2-mkconfig -o /boot/grub2/grub.cfg来建立开机的配置文件



依据3.3 小节的第一个练习，我们的测试机目前为40 秒倒数，且有一个强制进入图形界面的『 My graphical CentOS7 』选单！现在我们想要多加两个选单，一个是回到MBR 的chainloader，一个是使用/dev/vda4 的chainloader，该如何处理？

修改40_custom 成为这样：



![img](https://upload-images.jianshu.io/upload_images/4809537-59f45dc9662c7e1b.png?imageMogr2/auto-orient/strip|imageView2/2/w/715/format/webp)

####  

#### 3.6、开机前的额外功能修改

开机的默认选项，还可以进行grub2的修改功能。



![img](https://upload-images.jianshu.io/upload_images/4809537-78f9253c75376635.png?imageMogr2/auto-orient/strip|imageView2/2/w/1011/format/webp)

grub2开机画面



由于默认选项没有隐藏，因此直接看到了五个选项。同时会读秒。选项部分的画面其实就是menuentry后面的文字。现在知道如何修改menuentry后面的文字了吧。点击“Goto MBR”与“Goto /dev/vda4”又会重新回到选项，因为这两个都是我们自定义的重新读取选项文件。

有一个 **'e'（edit）**，这是grub2支援修改指令。这是很有用的功能，如你刚刚将grub.cfg的内容写错了，导致无法开机。我们就可以查阅menuentry选项并加以修改哦。

按'e'进入以下画面：



![img](https://upload-images.jianshu.io/upload_images/4809537-e8b10c4dea72f6db.png?imageMogr2/auto-orient/strip|imageView2/2/w/1023/format/webp)

grub2额外的命令编辑模式





![img](https://upload-images.jianshu.io/upload_images/4809537-01b5241ede644154.png?imageMogr2/auto-orient/strip|imageView2/2/w/796/format/webp)

####  

#### 3.7、关于开机画面与终端机画面的图形显示方式

如果想让开机画面使用图形显示方式，例如使用中文来显示你的画面。



![img](https://upload-images.jianshu.io/upload_images/4809537-bdbb2e92521ad0d1.png?imageMogr2/auto-orient/strip|imageView2/2/w/722/format/webp)



![img](https://upload-images.jianshu.io/upload_images/4809537-7a687146f0bb6945.png?imageMogr2/auto-orient/strip|imageView2/2/w/701/format/webp)

效果图

####  

#### 3.8、为个别选项加上密码

使用者可以在开机过程中与grub2内选择进入某个选项，以及进入grub命令模式去修改选项的参数资料等。如何让某些密码控制grub2的所有功能，某些密码则只能进入个别选项开机呢？这就牵涉到grub2的账号机制了。



**grub2的账号、密码与选项的设置**

grub2有点在模拟Linux的账号管理方案。在grub2中，有针对两种身份进行密码设置：

**superusers**：设置系统管理员与相关参数还有密码等，使用这个密码的用户，可在grub2内具有所有修改的权限。但一旦设置了这个superusers参数，则所有的指令修改竟会被变成受限制的！

**users**：设置一般账号的相关参数与密码，可以设置多个用户。使用这个密码的用户可以选择要进入某些选项 。不过，选项也得要搭配相对的账号才行。

> 假设你的系统有三个各别的操作系统，分别安装在(hd0,1), (hd0,2), (hd0,3) 当中。假设(hd0,1) 是所有人都可以选择进入的系统， (hd0,2) 是只有系统管理员可以进入的系统，(hd0,3)则是另一个一般用户与系统管理员可以进入的系统。
>
> 另外，假设系统管理员的帐号/密码设定为 zhang/abcd1234， 而一般帐号为 user/dcba4321 ，那该如何设定？
>
> 如果依据上述的说明，其实没有用到Linux 的linux16 与initrd16 的项目，只需要chainloader 的项目而已！

因此，整个grub.cfg 会有点像底下这样喔：



![img](https://upload-images.jianshu.io/upload_images/4809537-ce97fb5d36eff705.png?imageMogr2/auto-orient/strip|imageView2/2/w/716/format/webp)

如上所示，你得要使用superusers来指定那个账号是管理员。另外，这个账号与Linux实体账号无关。这仅是用啦判断密码所代表的意思。而密码的给予有两种语法：

> password_pbkdf2，帐号使用grub2-mkpasswd-pbkdf2所产生的密码；
>
> password帐号没加密的明文；



有了帐号密码之后，再来就是个别选项上 **是否要取消限制（--unrestricted）** 或者是给予 **哪个用户（--users）**的设定项目。所有的系统管理员所属的密码应该是能够修改所有的选项。

**grub2密码设置的文件位置与加密的密码**

还记得/etc/grub.d/*里面的文件吗，那些数字顺序就是grub.cfg的来源顺序。因此最早被读的应该是00_header（不建议修改），自己可以建一个名为01_users的文件，然后将账号密码参数写进去。



![img](https://upload-images.jianshu.io/upload_images/4809537-c6c46ff4c217f572.png?imageMogr2/auto-orient/strip|imageView2/2/w/738/format/webp)

向01_users中添加账户和密码



接下来看看每个menuentry要如何修改？

**为个别的选项设置账号密码的使用模式**

根据之前的设置，目前我们的Linux系统选项有五个：

> 来自/etc/grub.d/10_linux这个文件主动检测的两个menuentry；
>
> 来自/etc/grub.d/40_custom这个自己设定的三个menuentry；

假设我们在40_custom里面增加一个可以进入救援模式（rescue）的环境，并放置到最后一个选项中，同时仅有知道dmtsai的密码才能使用。



![img](https://upload-images.jianshu.io/upload_images/4809537-c4a0a51efd8464b3.png?imageMogr2/auto-orient/strip|imageView2/2/w/722/format/webp)

修改完了不要忘了重建一下grub.cfg啰。重新开机测试一下结果。



![img](https://upload-images.jianshu.io/upload_images/4809537-1124d7b5c35a356c.png?imageMogr2/auto-orient/strip|imageView2/2/w/700/format/webp)

默认的选项环境

选项4,5会需要输入账号密码



![img](https://upload-images.jianshu.io/upload_images/4809537-4e93403529d87a1f.png?imageMogr2/auto-orient/strip|imageView2/2/w/303/format/webp)

需要输入账号密码的环境



![img](https://upload-images.jianshu.io/upload_images/4809537-5d3ac195177e3927.png?imageMogr2/auto-orient/strip|imageView2/2/w/785/format/webp)

Problem



## 

## **4、开机过程的问题解决**

很多时候，我们可能做了某些操作导致系统无法正常开机，这时可以进入rescue模式去处理。

####  

#### 4.1、忘记root密码的解决之道

**其实在Linux环境中root密码忘记时还可以挽救。只要能够进入并挂载 " / "，然后重设root密码就可以了。**

只是在新版的systemd管理机制中，默认的rescue模式无法直接取得root权限，还是得要使用root密码才能登录rescue环境。不过还是可以通过一个名为 **"rd.break"** 的内核参数来处理。

需要注意，rd.break是在Ram Disk里面的操作系统状态，因此不能直接取得原本的Linux系统操作环境。所以还需要chroot的支援。可能由于SELinux的问题，你还得加上某些特殊流程才能顺利搞定root密码的救援。

现在来操作一下吧！进入开机grub时按e进入编辑模式，在 linux16那一行末尾使用这个参数。



![img](https://upload-images.jianshu.io/upload_images/4809537-ccc7e466e9f62f21.png?imageMogr2/auto-orient/strip|imageView2/2/w/758/format/webp)

加上rd.break参数

改完之后不要返回，直接按 [ ctrl + x ]开始开机。

开机完成后会出现如下画面，此时你应该是在RAM Disk的环境，并不是原本的环境。因此根目录下面的东西和你原本的系统无关哦！而且，你的系统应该会被挂载到/sysroot目录下。



![img](https://upload-images.jianshu.io/upload_images/4809537-f28d00e05a89f1a5.png?imageMogr2/auto-orient/strip|imageView2/2/w/653/format/webp)

接下来这样做：



![img](https://upload-images.jianshu.io/upload_images/4809537-ad6c6695f8862d71.png?imageMogr2/auto-orient/strip|imageView2/2/w/751/format/webp)

echo的内容是你重置后的密码

需要了解的：

> chroot 目录：代表将你的根目录 “暂时” 切换到chroot之后的目录。如上就是/sysroot将会被作为暂时的根目录。
>
> /.autorelabel：在rd.break的RAM Disk环境下，系统是没有SELinux的，而你刚刚更改了/etc/shadow（密码修改）所以这个文件的SELinux安全文本的特性会被取消。如果你没有让系统于开机时自动回复SELinux的安全文本，你的系统将无法登录（在SELinux为Enforcing模式下）。加上./autorelabel就是要让系统在开机的时候自动使用默认的SELinux type重新写入SELinux安全文本到每个文件去。

####  

#### 4.2、直接开机就以root执行bash的方法

**还可以在开机后直接取得系统根目录后，让系统给一个bash给我们用。方法就是将rd.break参数改为 init=/bin/bash 即可。不需要root密码而有root权限。**



**重点：**

> Linux不可随意关键，否则容易造成文件系统错误或是其他无法开机的问题；
>
> 开机流程主要是：BIOS、MBR、Loader、Kernel+initramfs、systemd；
>
> Loader具有提供选项，加载内核文件，转交控制权给其他loader等功能；
>
> boot loader可以安装在MBR或者是每个分割槽的boot sector区域中；
>
> initramfs可以提供内核在开机过程中所需要的最重要的模块，通常与磁盘和文件系统有关的模块；
>
> systemd的配置文件主要来自/etc/systemd/system/default.target项目；
>
> 额外的设备与模块对应，可写入/etc/modprobe.d/*.conf中；
>
> 内核模块的管理可使用lsmod，modinfo，rmmod，insmod，modprobe等命令；
>
> modprobe主要参考/lib/modules/$（uname -r）/modules.dep的设置来载入与卸载内核模块；
>
> grub2的配置文件与相关文件系统大多放在/boot/grub2目录下，配置文件为grub.cfg；
>
> grub2对磁盘的代号设置与Linux不同，主要通过检查的顺序来给予设置。如（hd0）及（hd0，1）等；
>
> grub.cfg内每个选项与menuentry有关，而直接指定内核开机时，至少需要Linux16及initrd16两个项目；
>
> grub.cfg内设置loader控制权移交时，最重要者为chainloader+1这项；
>
> 若想要重建initramfs，可使用dracut或mkinitrd处理；
>
> 重新安装grub2到MBR货boot sector时，可利用grub2-install来处理；
>
> 若想进入救援模式（rescue），可与开机选项过程中，在linux16的选项后面加入“rd.break”或"init=/bin/bash”等方式来就如救援模式；
>
> 我们可以对grub2的个别选项给予不同的密码；