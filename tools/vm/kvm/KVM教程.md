# [Kvm教程](https://wiki.ubuntu.org.cn/index.php?title=Kvm)

## 目录

- [1 友情连接](https://wiki.ubuntu.org.cn/Kvm教程#.E5.8F.8B.E6.83.85.E8.BF.9E.E6.8E.A5)
- [2 KVM 与 vbox的区别](https://wiki.ubuntu.org.cn/Kvm教程#KVM_.E4.B8.8E_vbox.E7.9A.84.E5.8C.BA.E5.88.AB)
- [3 关于kvm](https://wiki.ubuntu.org.cn/Kvm教程#.E5.85.B3.E4.BA.8Ekvm)
- [4 相关连接](https://wiki.ubuntu.org.cn/Kvm教程#.E7.9B.B8.E5.85.B3.E8.BF.9E.E6.8E.A5)
- 5 基本知识
  - [5.1 安装准备](https://wiki.ubuntu.org.cn/Kvm教程#.E5.AE.89.E8.A3.85.E5.87.86.E5.A4.87)
  - [5.2 安装kvm](https://wiki.ubuntu.org.cn/Kvm教程#.E5.AE.89.E8.A3.85kvm)
  - [5.3 创建虚拟镜像](https://wiki.ubuntu.org.cn/Kvm教程#.E5.88.9B.E5.BB.BA.E8.99.9A.E6.8B.9F.E9.95.9C.E5.83.8F)
  - [5.4 安装虚拟机系统](https://wiki.ubuntu.org.cn/Kvm教程#.E5.AE.89.E8.A3.85.E8.99.9A.E6.8B.9F.E6.9C.BA.E7.B3.BB.E7.BB.9F)
  - [5.5 使用虚拟机最简单的命令](https://wiki.ubuntu.org.cn/Kvm教程#.E4.BD.BF.E7.94.A8.E8.99.9A.E6.8B.9F.E6.9C.BA.E6.9C.80.E7.AE.80.E5.8D.95.E7.9A.84.E5.91.BD.E4.BB.A4)
- 6 使用
  - [6.1 文件共享](https://wiki.ubuntu.org.cn/Kvm教程#.E6.96.87.E4.BB.B6.E5.85.B1.E4.BA.AB)
  - [6.2 快照模式（-snapshot）](https://wiki.ubuntu.org.cn/Kvm教程#.E5.BF.AB.E7.85.A7.E6.A8.A1.E5.BC.8F.EF.BC.88-snapshot.EF.BC.89)
  - [6.3 高速网络（-net nic,model=virtio -net user）](https://wiki.ubuntu.org.cn/Kvm教程#.E9.AB.98.E9.80.9F.E7.BD.91.E7.BB.9C.EF.BC.88-net_nic.2Cmodel.3Dvirtio_-net_user.EF.BC.89)
  - [6.4 高速虚拟](https://wiki.ubuntu.org.cn/Kvm教程#.E9.AB.98.E9.80.9F.E8.99.9A.E6.8B.9F)
  - [6.5 使用“母镜像”功能](https://wiki.ubuntu.org.cn/Kvm教程#.E4.BD.BF.E7.94.A8.E2.80.9C.E6.AF.8D.E9.95.9C.E5.83.8F.E2.80.9D.E5.8A.9F.E8.83.BD)
  - [6.6 镜像格式转换，镜像信息查询](https://wiki.ubuntu.org.cn/Kvm教程#.E9.95.9C.E5.83.8F.E6.A0.BC.E5.BC.8F.E8.BD.AC.E6.8D.A2.EF.BC.8C.E9.95.9C.E5.83.8F.E4.BF.A1.E6.81.AF.E6.9F.A5.E8.AF.A2)
  - [6.7 使用SPICE(需要12.04以上版本)](https://wiki.ubuntu.org.cn/Kvm教程#.E4.BD.BF.E7.94.A8SPICE.28.E9.9C.80.E8.A6.8112.04.E4.BB.A5.E4.B8.8A.E7.89.88.E6.9C.AC.29)
- [7 与vbox的冲突（不用ose，用官方下载的4.X可独立正常使用）](https://wiki.ubuntu.org.cn/Kvm教程#.E4.B8.8Evbox.E7.9A.84.E5.86.B2.E7.AA.81.EF.BC.88.E4.B8.8D.E7.94.A8ose.EF.BC.8C.E7.94.A8.E5.AE.98.E6.96.B9.E4.B8.8B.E8.BD.BD.E7.9A.844.X.E5.8F.AF.E7.8B.AC.E7.AB.8B.E6.AD.A3.E5.B8.B8.E4.BD.BF.E7.94.A8.EF.BC.89)

## 友情连接

[Kvm_网络桥接方案](https://wiki.ubuntu.com.cn/Kvm_网络桥接方案)

[Kvm简单教程](https://wiki.ubuntu.com.cn/Kvm简单教程)

## KVM 与 vbox的区别

vbox 是由 qemu 改写而成，包含大量 qemu 代码。

- 可以使用于"不支持"虚拟化技术的cpu。
- 值得说的一点：vbox 在图形方面比较好，能进行2D 3D加速。
- 但cpu控制不理想（估计是因为图形支持的缘故）。
- 操作上有独立的图形界面，易于上手。

kvm 是linux内核包含的东西，使用qemu作为上层管理（命令行）。

- 要求cpu 必须支持虚拟化。
- 性能：作为服务器很好，可是图形能力十分的差。即使放电影，图像也是像刷油漆一样，一层一层的。
- cpu使用率控制很好。 
- 控制上比较简洁，功能比较丰富：比如使用 “无敌功能”所有更改指向内存，你的镜像永远保持干净。 “母镜像”功能让你拥有n个独立快照点。 还有很多参数。另外，kvm作为内核级的虚拟机，刚开始发展关注的公司比较多——但是还没有达到商业应用的水平。

总体而言：在支持 虚拟化的情况下，vbox 和 kvm 的性能差不多，主要是面向对象不同：kvm适用于服务器，vbox适用于桌面应用。

## 关于kvm

- kvm是开源软件，全称是kernel-based virtual machine（基于内核的虚拟机）。
- 是x86架构且硬件支持虚拟化技术（如 intel VT 或 AMD-V）的linux [全虚拟化] 解决方案。
- 它包含一个为处理器提供底层虚拟化 可加载的核心模块kvm.ko（kvm-intel.ko 或 kvm-AMD.ko)。
- kvm还需要一个经过修改的QEMU软件（qemu-kvm），作为虚拟机上层控制和界面。
- kvm能在不改变linux或windows镜像的情况下同时运行多个虚拟机，（ps：它的意思是多个虚拟机使用同一镜像）并为每一个虚拟机配置个性化硬件环境（网卡、磁盘、图形适配器……）。
- 在主流的linux内核，如2.6.20以上的内核均包含了kvm核心。

## 相关连接

KVM官方地址： http://kvm.qumranet.com/kvmwiki

KVM的Changelog: http://kvm.qumranet.com/kvmwiki/ChangeLog, 可以知道最新的版本是多少，做了那些改变。

KVM下载地址在sourceforge.net上： [http://sourceforge.net/project/showfile](https://sourceforge.net/project/showfile) ... _id=180599

KVM的Howto文档： http://www.linux-kvm.org/page/HOWTO

Kqemu: [http://sourceforge.net/projects/kqemu/](https://sourceforge.net/projects/kqemu/)

Qemu: http://fabrice.bellard.free.fr/qemu/index.html

## 基本知识

qemu 全称Quick Emulator。是独立虚拟软件，能独立运行虚拟机（根本不需要kvm）。kqemu是该软件的加速软件。kvm并不需要qemu进行虚拟处理，只是需要它的上层管理界面进行虚拟机控制。虚拟机依旧是由kvm驱动。 所以，大家不要把概念弄错了，盲目的安装qemu和kqemu。qemu使用模拟器

### 安装准备

查看你的硬件是否支持虚拟化。 命令：

```
 egrep '(vmx|svm)' /proc/cpuinfo 
```

要有 vmx 或 svm 的标识才行。总的说来，AMD在虚拟化方面作得更好一些。 使用intel cpu的朋友还需要进入bios进行设置——因为我的是AMD，所以设置方法不敢乱说。

### 安装kvm

打开新立得软件库，安装kvm。系统会自动安装相关的软件包，包括qemu-kvm。什么kvm－AMD 或 kvm－intel模式系统都自动处理好了。 注：过去的文章提到要设置内核模式，现在已经不需要了. ps:新立得软件库 是什么东西？Ubuntu下的软件包管理器，相当于apt-get的图形化界面。

### 创建虚拟镜像

命令（先cd 到你要保存镜像的位置）：

```
 kvm-img create xxx.img 2G
```

由于是要安装xp精简系统，2G已经足够大了（安装下来只要700M）。xxx  代表名字，想取什么都可以。最好是连续的英文.默认格式为raw，当然你可以自己设定，比如（-f qcow2）加在 create  后面即可。（.img这个后缀是我随便编的，kvm对后缀名没有要求） 其它格式如下：

```
 Supported formats: cow qcow vmdk cloop dmg bochs vpc vvfat qcow2 parallels nbd host_cdrom host_floppy host_device raw tftp ftps ftp https http
```

### 安装虚拟机系统

命令（先cd 到你要保存镜像的位置）：

```
 kvm -drive file=xxxx.img -cdrom /path/to/boot-media.iso -boot d -m 512
```

说明几点：/path/to/boot-media.iso 只是个举例。具体为你的系统盘镜像位置。－m 为虚拟机内存大小，单位是M，默认（不写这个选项）为128M。当然，自己看着给吧。 建议如果虚拟的是xp系统，把页面缓存给关了。老版本的kvm使用-hda xxx.img参数指定镜像，如无法使用-drive，请使用-hda参数，-hda参数不带“file=”

### 使用虚拟机最简单的命令

命令（先cd 到你要保存镜像的位置）：

```
kvm -m 1024 -drive file=xxx.img
```

由于默认内存是128M，所以不得不指定一下，要不连-m 1024都可以省了。此时是没有声卡的，当然也可加上声音选项。cpu默认是一颗，网络默认启动（为net－内部端口映射）（可以上网，但是主机识别不了，它也无法连接主机）。 你可以使用：

```
kvm -m 1024 -drive file=/xxx/xxx/xxx.img 
```

你也可以把它作为桌面“创建启动器”的命令使用。每次轻轻一点就可使用了。

## 使用

命令：

```
kvm --help
```

命令：

```
kvm-img --help
```

看看具体的选项说明，需要什么功能就在“最简单命令”后面加就是了——特别简单、功能又很多。用的满意了，可以做成“程序启动器”。或者打开gedit，把命令保存进去，把文件名改为xxx.sh。再把属性改为“可执行”，要用就点击。 比如：kvm -m 1024 -hda xxx.img -xxx xx -xxxx xxx -xxxxxx -xxx

### 文件共享

我们希望虚拟机能和主机对一些文件夹进行共享操作。类似于vbox的共享文件夹。 首先安装 samba 。这是linux的共享功能软件，支持windows系统的访问。记住不是samba4 然后，新建一个文件夹，属性。共享选项，把所有选项开启。应用。接受系统的权限的更改。

好了，默认在虚拟机的网上邻居，就能找见了。没有？看看整个网络（侧边任务）。 简单吧，kvm早已升级了。根本不需要什么配置。

关于权限：你是否有“无法访问，权限不够……”的问题？主机无法修改共享文件“你不是该文件的创建者”？ 那是因为linux的权限相当的严格，必须要放权别人才能访问、修改。 如果上级文件夹（无论哪个）不让读取（比如： 其它；文件夹访问 无），那么就会出现无法访问的情况。你要设置上级文件夹权限为（其它；文件夹访问 访问文件）就可以了，不必完全放权。

因为安全考虑，我的用户文件夹（其它；文件夹访问 无）。所以一开始就出了权限问题。我的解决办法是使用命令： sudo gnome-open /home/ 在home中再新建一个文件夹，在属性上，把创建者改为非root（改为经常使用的普通用户），组群：sambashare。权限全为：创建和删除。

经测试，外网虽然能显示共享文件夹，却无法访问——保证只有虚拟机可以访问。（我使用了ufw防火墙）

windows虚拟机在共享文件夹中创建的文件，主机是无法更改的。要设置权限： 我的电脑－打开－工具－文件夹选项－查看 把“使用简单的文件共享”选项去掉。在文件（夹）属性——安全：知道怎么弄了吧。

linux的文件夹系统权限作的十分的好。比如你把其它非受权文件夹的链接复制到共享文件夹，依然无法访问。windows那种权限的随意性，看见就想哭。

多说一点：我的电脑右键，可以把共享文件夹设置为网络硬盘。相当于移动硬盘，可以方便的安装软件，保存资料。


 ***\** 相对于samba的高速共享（限于档案传输,主机架设FTP服务器开启上传速度达samba十倍以上，用完即可停止FTP）**

sudo apt-get install vsftpd


 FTP根目录权限为755，开启上传，可以在FTP根目录里面添加一个所有人可写的目录即可 sudo gedit /etc/vsftpd.conf //编辑vsftpd.conf文件,内容如下

```ini

listen=YES

listen_port=21

anonymous_enable=YES

no_anon_password=YES

write_enable=YES

anon_upload_enable=YES

anon_mkdir_write_enable=YES

local_enable=YES

local_umask=022

dirmessage_enable=YES

xferlog_enable=YES

connect_from_port_20=YES

ftpd_banner=Welcome to myFTP Website

chroot_local_user=YES

chroot_list_file=/etc/vsftpd.chroot_list

secure_chroot_dir=/var/run/vsftpd

pam_service_name=vsftpd

rsa_cert_file=/etc/ssl/certs/ssl-cert-snakeoil.pem

anon_world_readable_only=No

local_root=/yourFTPdir #这里自定义你的FTP根目录

anon_root=/yourFTP/dir #这里自定义你的FTP根目录

rsa_private_key_file=/etc/ssl/private/ssl-cert-snakeoil.key
```



- - - - -  配置到此，下面启动FTP服务器

sudo service vsftpd start

或

sudo /etc/init.d/vsftpd start

在虚拟机中如XP：用资源管理器打开 [ftp://你的主机IP](ftp://你的主机IP) 即可上传下载

### 快照模式（-snapshot）

```
-snapshot       write to temporary files instead of disk image files
```

意思是不更改镜像文件，启动后的所有改动均不会往镜像文件上写。临时文件存放在内存中了，具体是cached。 同样的功能，在vbox要独立安装软件。效率可想而知…… 在命令后面空格加上：

```
-snapshot
```

即可

### 高速网络（-net nic,model=virtio -net user）

虚拟网络模块的性能差异

```
虚拟网络模块     网络传输速度（ssh）     客户机操作系统     网络状态
rtl8029    200-300KB/s    SLES10SP2 (kernel 2.6.16-60)    不稳定
e1000    4.8-5.4MB/s    SLES10SP2 (kernel 2.6.16-60)    稳定
virtio    10.6-11.1MB/s    SLES11 (kernel 2.6.27-19)    稳定
```

驱动下载地址：

```
http://sourceforge.net/projects/kvm/files/
```

名字是 kvm-driver-disc 的 NETKVM-20081229.iso

具体可能有变化，使用命令：

```
kvm -m 1024 -drive file=xp.img -cdrom /home/cat650/linux/kvm/NETKVM-20081229.iso  -enable-kvm -net nic,model=virtio -net user
```

其中：-cdrom是加载光驱的意思。网络默认设置是 （-net nic -net user） 这里由于要指定virtio模块所以要把命令加上。然后自动安装驱动就行了。听说速度接近真实网卡——明显是为打造虚拟服务器配置的。 以后在启动虚拟机命令后面加上-net nic,model=virtio -net user就可以了。

### 高速虚拟

VirtIO paravirtual 是 Linux 虚拟机平台上统一的虚拟 IO  接口驱动。通常主机为了让客户机像在真实环境中一样运行，需要为客户机创建各式各样的虚拟设备，如磁盘，网卡，显卡，时钟，USB  等。这些虚拟设备大大降低了客户机的性能。如果客户机不关注这些硬件设备，就可以用统一的虚拟设备代替他们，这样可以大大提高虚拟机的性能。这个统一的标准化接口在 Linux 上就是 VirtIO 。需要注意的是 VirtIO 运行在 kernel 2.6.24 以上的版本中才能发挥它的性能优势。另外  KVM 项目组也发布了 Windows 平台上的 VirtIO 驱动，这样 windows 客户机的网络性能也可以大大提高了。

```
下载地址：http://www.linux-kvm.org/page/WindowsGuestDrivers/Download_Drivers
```

viostor是磁盘的虚拟驱动。

```
带图片的参考：http://www.linux-kvm.org/page/WindowsGuestDrivers/viostor/installation
```

命令：把-hda xxx.img 替换为-drive file=/home/cat650/virt/xp.img,if=virtio,boot=on 意思是使用virtio磁盘系统，并作为启动盘（默认是boot=off，作为附加的第二硬盘）。第一次使用的时候记得挂载viostorXXXX.img，来安装驱动。

### 使用“母镜像”功能

要求，镜像格式为 qcow2  。作用：在“母镜像”的基础上，建立一个新的镜像。虚拟机操作这个新镜像时不会对“母镜像”进行任何更改（只读“母镜像”），新镜像只保存由于操作产生的与“母镜像”的数据差异（大小很小）。由此实现超越“快照”“还原点”（数量没有限制）。 命令（先cd 到你要保存镜像的位置）：

```
kvm-img create -f qcow2  -b xp.img xp.test  或者：kvm-img create -f qcow2 -o backing_file=xp.img xp.test
```

其中xp.img是“母镜像”（参数 -b xxx），xp.test是新镜像——只能用 qcow2 格式。 新镜像的使用：正常使用即可。

### 镜像格式转换，镜像信息查询

能转换的格式有：raw,qcow2,qcow,cow,vmdk,cloop 如果你记不清你创建的镜像是什么格式的，可以使用命令（先cd 到你要保存镜像的位置）：

```
kvm-img info xxx.img
```

关于格式的优缺点，请参看高级篇

转换命令（先cd 到你要保存镜像的位置）：

```
kvm-img convert -f raw -O qcow2 xp.img xp.qco
```

注意：-O是字母o的大写。

这条命令举例的意思是：把名为xp.img格式为raw的镜像转换成新镜像xp.qco格式为qcow2 其它格式"vmdk"是 VMware 3 / 4 兼容镜像格式。

使用过程中更换光盘及ISO
 按 ctrl+art+2 进入qemu-shell
 info block //得到光驱信息 ide1-cd0
 eject ide1-cd0 //弹出光驱
 chang ide1-cd0 /home/PATH/xxx.iso //更换光盘镜像
 按 ctrl+art+1 返回系统可看到更换后的光盘


 快捷键：
 Ctrl-Alt-f 全屏
 Ctrl-Alt-n 切换虚拟终端'n'.标准的终端映射如下: * n=1 : 目标系统显示 * n=2 : 临视器 * n=3 : 串口
 Ctrl-Alt 抓取鼠标和键盘
 在虚拟控制台中,我们可以使用Ctrl-Up, Ctrl-Down, Ctrl-PageUp 和 Ctrl-PageDown在屏幕中进行移动.
 在模拟时,如果我们使用`-nographic'选项,我们可以使用Ctrl-a h来得到终端命令:
 Ctrl-a h 打印帮助信息
 Ctrl-a x 退出模拟 Ctrl-a s 将磁盘信息保存入文件(如果为-snapshot)
 Ctrl-a b 发出中断
 Ctrl-a c 在控制台与监视器进行切换
 Ctrl-a Ctrl-a 发送Ctrl-a

### 使用SPICE(需要12.04以上版本)

1.  `apt-get install xserver-xorg-video-qxl spice-client` //可以使用spice的半虚拟化图形主机驱动和连接工具

下载客机qxl驱动： [http://spice-space.org/download.html](https://www.spice-space.org/download.html) //客机 qxl 视频驱动，用于开启spice的windows客机的视频驱动，下载 spice-guest-tools-0.1.exe 这个东东

使用集成spice的KVM

1.启动KVM虚拟机 kvm -smp 4 -m 1516 -drive  file=/yourpath/xp.img,cache=writeback,if=virtio -boot c -vga qxl  --full-screen -net nic,model=virtio,macaddr=28-55-26-66-58-D6 -net user  -localtime -soundhw ac97 -usb -usbdevice tablet -spice  port=3636,disable-ticketing

2.使用spicec进行连接（spice的连接命令spicec） spice -h localhost -p 3636

PS： 进入后需要安装 spice-guest-tools-0.1.exe 这个客机的 qxl 显卡驱动，你会发现原来看视频刷屏的现象没有了，甚至可以玩一把全屏的植物大战僵尸（不开3D加速）。鼠标移动也很到位。 现在可以用 shift+F11 来让使用spice的KVM虚拟机实现全屏的切换。

## 与vbox的冲突（不用ose，用官方下载的4.X可独立正常使用）

当你安装了 virtual box 然后又安装kvm，那么当你再次打开开virtual box 的时候，vmbox就会报错。

1.查看相关正在运行的mod

lsmod | grep kvm

2.停止模块运行

如果你的cpu是AMD：sudo rmmod kvm-amd

如果是Intel：sudo rmmod kvm

3.卸载模块

如果你的cpu是AMD：sudo modprobe -r kvm-amd

如果你的cpu是Intel：sudo modprobe -r kvm-intel

sudo modprobe -r kvm

4.完全卸载

sudo aptitude purge kvm qemu-kvm


 sudo apt-get remove kvm qemu-kvm