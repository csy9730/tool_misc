# Linux重要目录详解



/ 根目录，第一层目录，所有其他目录的根，一般根目录下只存放目录。包括：/bin,

/boot, /dev, /etc, /home, /lib, /mnt, /opt, /proc, /root, /sbin, /sys, /tmp, /usr, /var.

**我们先来简单介绍各个目录的作用：**

/bin:/usr/bin: 可执行二进制文件的目录，如常用的命令ls、tar、mv、cat等。

/boot： 放置linux系统启动时用到的一些文件。/boot/vmlinuz为linux的内核文件，以及/boot/gurb。建议单独分区，分区大小100M即可

/dev： 存放linux系统下的设备文件，访问该目录下某个文件，相当于访问某个设备，常用的是挂载光驱mount /dev/cdrom /mnt。

/etc： 系统配置文件存放的目录，不建议在此目录下存放可执行文件，重要的配置文件有/etc/inittab、/etc/fstab、/etc/init.d、/etc/X11、/etc/sysconfig、/etc/xinetd.d修改配置文件之前记得备份。注：/etc/X11存放与x windows有关的设置。

/home： 系统默认的用户家目录，新增用户账号时，用户的家目录都存放在此目录下，~表示当前用户的家目录，~test表示用户test的家目录。建议单独分区，并设置较大的磁盘空间，方便用户存放数据

/lib:/usr/lib:/usr/local/lib： 系统使用的函数库的目录，程序在执行过程中，需要调用一些额外的参数时需要函数库的协助，比较重要的目录为/lib/modules。

/lost+fount： 系统异常产生错误时，会将一些遗失的片段放置于此目录下，通常这个目录会自动出现在装置目录下。如加载硬盘于/disk 中，此目录下就会自动产生目录/disk/lost+found

/mnt:/media： 光盘默认挂载点，通常光盘挂载于/mnt/cdrom下，也不一定，可以选择任意位置进行挂载。

/opt： 给主机额外安装软件所摆放的目录。如：FC4使用的Fedora 社群开发软件，如果想要自行安装新的KDE 桌面软件，可以将该软件安装在该目录下。以前的 Linux 系统中，习惯放置在 /usr/local 目录下

/proc： 此目录的数据都在内存中，如系统核心，外部设备，网络状态，由于数据都存放于内存中，所以不占用磁盘空间，比较重要的目录有/proc/cpuinfo、/proc/interrupts、/proc/dma、/proc/ioports、/proc/net/*等

/root： 系统管理员root的家目录，系统第一个启动的分区为/，所以最好将/root和/放置在一个分区下。

/sbin:/usr/sbin:/usr/local/sbin： 放置系统管理员使用的可执行命令，如fdisk、shutdown、mount等。与/bin不同的是，这几个目录是给系统管理员root使用的命令，一般用户只能"查看"而不能设置和使用。

/tmp： 一般用户或正在执行的程序临时存放文件的目录,任何人都可以访问,重要数据不可放置在此目录下

/srv： 服务启动之后需要访问的数据目录，如www服务需要访问的网页数据存放在/srv/www内

/usr： 应用程序存放目录，/usr/bin 存放应用程序， /usr/share 存放共享数据，/usr/lib 存放不能直接运行的，却是许多程序运行所必需的一些函数库文件。/usr/local:存放软件升级包。/usr/share/doc: 系统说明文件存放目录。/usr/share/man: 程序说明文件存放目录，使用 man ls时会查询/usr/share/man/man1/ls.1.gz的内容建议单独分区，设置较大的磁盘空间

/var： 放置系统执行过程中经常变化的文件，如随时更改的日志文件 /var/log，/var/log/message： 所有的登录文件存放目录，/var/spool/mail： 邮件存放的目录， /var/run: 程序或服务启动

**再来详细介绍一些重要的目录：**

**/etc** **目录**

| 目录                                                  | 描述                                                         |
| ----------------------------------------------------- | ------------------------------------------------------------ |
| **/etc/rc /etc/rc.d****/etc/rc\*.d**                  | 启动、或改变运行级时运行的scripts或scripts的目录.            |
| /etc/hosts                                            | 本地域名解析文件                                             |
| **/etc/sysconfig/network**                            | IP、掩码、网关、主机名配置                                   |
| **/etc/resolv.conf**                                  | DNS服务器配置                                                |
| **/etc/fstab**                                        | 开机自动挂载系统，所有分区开机都会自动挂载                   |
| **/etc/inittab**                                      | 设定系统启动时Init进程将把系统设置成什么样的runlevel及加载相关的启动文件配置 |
| **/etc/exports**                                      | 设置NFS系统用的配置文件路径                                  |
| **/etc/init.d**                                       | 这个目录来存放系统启动脚本                                   |
| **/etc/profile****,** /etc/csh.login,  /etc/csh.cshrc | **全局系统环境配置变量**                                     |
| **/etc/issue**                                        | 认证前的输出信息，默认输出版本内核信息                       |
| /etc/motd                                             | 设置认证后的输出信息，                                       |
| /etc/mtab                                             | 当前安装的文件系统列表.由scripts初始化，并由mount 命令自动更新.需要一个当前安装的文件系统的列表时使用，例如df 命令 |
| **/etc/group**                                        | 类似/etc/passwd ，但说明的不是用户而是组.                    |
| **/etc/passwd**                                       | 用户数据库，其中的域给出了用户名、真实姓名、家目录、加密的口令和用户的其他信息. |
| **/etc/shadow**                                       | 在安装了影子口令软件的系统上的影子口令文件.影子口令文件将/etc/passwd 文件中的加密口令移动到/etc/shadow 中，而后者只对root可读.这使破译口令更困难. |
| **/etc/sudoers**                                      | 可以sudo命令的配置文件                                       |
| **/etc/syslog.conf**                                  | 系统日志参数配置                                             |
| /etc/login.defs                                       | 设置用户帐号限制的文件                                       |
| /etc/securetty                                        | 确认安全终端，即哪个终端允许root登录.一般只列出虚拟控制台，这样就不可能(至少很困难)通过modem或网络闯入系统并得到超级用户特权. |
| /etc/printcap                                         | 类似/etc/termcap ，但针对打印机.语法不同.                    |
| /etc/shells                                           | 列出可信任的shell.chsh 命令允许用户在本文件指定范围内改变登录shell.提供一台机器FTP服务的服务进程ftpd 检查用户shell是否列在 /etc/shells 文件中，如果不是将不允许该用户登录. |
| /etc/xinetd.d                                         | 如果服务器是通过xinetd模式运行的，它的脚本要放在这个目录下。有些系统没有这个目录，比如Slackware，有些老的版本也没有。在Redhat Fedora中比较新的版本中存在。 |
| /etc/opt/                                             | /opt/的配置文件                                              |
| /etc/X11/                                             | [X_Window系统](http://zh.wikipedia.org/wiki/X_Window系统)(版本11)的配置文件 |
| /etc/sgml/                                            | [SGML](http://zh.wikipedia.org/wiki/SGML)的配置文件          |
| /etc/xml/                                             | [XML](http://zh.wikipedia.org/wiki/XML)的配置文件            |
| **/etc/skel/**                                        | 默认创建用户时，把该目录拷贝到家目录下                       |

 

**/usr** **目录****：**默认软件都会存于该目录下；包含绝大多数的用户工具和应用程序。

| 目录         | 描述                                                         |
| ------------ | ------------------------------------------------------------ |
| /usr/X11R6   | 存放X-Windows的目录；                                        |
| /usr/games   | 存放着XteamLinux自带的小游戏；                               |
| /usr/doc     | Linux技术文档；                                              |
| /usr/include | 用来存放Linux下开发和编译应用程序所需要的头文件；            |
| /usr/lib     | 存放一些常用的动态链接共享库和静态档案库；                   |
| /usr/man     | 帮助文档所在的目录；                                         |
| /usr/src     | Linux开放的源代码，就存在这个目录，爱好者们别放过哦；        |
| /usr/bin/    | 非必要[可执行文件](http://zh.wikipedia.org/wiki/可执行文件) (在[单用户模式](http://zh.wikipedia.org/w/index.php?title=单用户模式&action=edit&redlink=1)中不需要)；面向所有用户。 |
| /usr/lib/    | /usr/bin/和/usr/sbin/中二进制文件的[库](http://zh.wikipedia.org/wiki/库)。 |
| /usr/sbin/   | 非必要的系统二进制文件，例如：大量[网络服务](http://zh.wikipedia.org/wiki/网络服务)的[守护进程](http://zh.wikipedia.org/wiki/守护进程)。 |
| /usr/share/  | 体系结构无关（共享）数据。                                   |
| /usr/src/    | [源代码](http://zh.wikipedia.org/wiki/源代码),例如:内核源代码及其头文件。 |
| /usr/X11R6/  | [X Window系统](http://zh.wikipedia.org/wiki/X_Window系统)版本 11, Release 6. |
| /usr/local/  | 本地数据的第三层次，具体到本台主机。通常而言有进一步的子目录，例如：bin/、lib/、share/.这是提供给一般用户的/usr目录，在这里安装一般的应用软件； |

 

**/var** **目录**

| 目录                     | 描述                                                         |
| ------------------------ | ------------------------------------------------------------ |
| /var/log/message         | 日志信息，按周自动轮询                                       |
| /var/spool/cron/root     | 定时器配置文件目录，默认按用户命名                           |
| /var/log/secure          | 记录登陆系统存取信息的文件，不管认证成功还是认证失败都会记录 |
| /var/log/wtmp            | 记录登陆者信息的文件，last,who,w命令信息来源于此             |
| /var/spool/clientmqueue/ | 当邮件服务未开启时，所有应发给系统管理员的邮件都将堆放在此   |
| /var/spool/mail/         | 邮件目录                                                     |
| /var/tmp                 | 比/tmp 允许的大或需要存在较长时间的临时文件. (虽然系统管理员可能不允许/var/tmp 有很旧的文件.) |
| /var/lib                 | 系统正常运行时要改变的文件.                                  |
| /var/local               | /usr/local 中安装的程序的可变数据(即系统管理员安装的程序).注意，如果必要，即使本地安装的程序也会使用其他/var 目录，例如/var/lock . |
| /var/lock                | 锁定文件.许多程序遵循在/var/lock 中产生一个锁定文件的约定，以支持他们正在使用某个特定的设备或文件.其他程序注意到这个锁定文件，将不试图使用这个设备或文件. |
| /var/log/                | 各种程序的Log文件，特别是login  (/var/log/wtmp log所有到系统的登录和注销) 和syslog (/var/log/messages 里存储所有核心和系统程序信息. /var/log 里的文件经常不确定地增长，应该定期清除. |
| /var/run                 | 保存到下次引导前有效的关于系统的信息文件.例如， /var/run/utmp 包含当前登录的用户的信息. |
| /var/cache/              | 应用程序缓存数据。这些数据是在本地生成的一个耗时的I/O或计算结果。应用程序必须能够再生或恢复数据。缓存的文件可以被删除而不导致数据丢失。 |

 

**/proc** **目录**

| 目录              | 描述                                                         |
| ----------------- | ------------------------------------------------------------ |
| **/proc/meminfo** | 查看内存信息                                                 |
| **/proc/loadavg** | 还记得 top 以及 uptime 吧？没错！上头的三个平均数值就是记录在此！ |
| **/proc/uptime**  | 就是用 uptime 的时候，会出现的资讯啦！                       |
| **/proc/cpuinfo** | 关于处理器的信息，如类型、厂家、型号和性能等。               |
| /proc/cmdline     | 加载 kernel 时所下达的相关参数！查阅此文件，可了解系统是如何启动的！ |
| /proc/filesystems | 目前系统已经加载的文件系统罗！                               |
| /proc/interrupts  | 目前系统上面的 IRQ 分配状态。                                |
| /proc/ioports     | 目前系统上面各个装置所配置的 I/O 位址。                      |
| /proc/kcore       | 这个就是内存的大小啦！好大对吧！但是不要读他啦！             |
| /proc/modules     | 目前我们的 Linux 已经加载的模块列表，也可以想成是驱动程序啦！ |
| /proc/mounts      | 系统已经挂载的数据，就是用 mount 这个命令呼叫出来的数据啦！  |
| /proc/swaps       | 到底系统挂加载的内存在哪里？呵呵！使用掉的 partition 就记录在此啦！ |
| /proc/partitions  | 使用 fdisk -l 会出现目前所有的 partition 吧？在这个文件当中也有纪录喔！ |
| /proc/pci         | 在 PCI 汇流排上面，每个装置的详细情况！可用 lspci 来查阅！   |
| /proc/version     | 核心的版本，就是用 uname -a 显示的内容啦！                   |
| /proc/bus/*       | 一些汇流排的装置，还有 U盘的装置也记录在此喔！               |

 

**/dev** **目录：****设备文件分为两种：块设备文件(b)和字符设备文件(c)**

| 目录           | 描述                        |
| -------------- | --------------------------- |
| /dev/hd[a-t]   | IDE设备                     |
| /dev/sd[a-z]   | SCSI设备                    |
| /dev/fd[0-7]   | 标准软驱                    |
| /dev/md[0-31]  | 软raid设备                  |
| /dev/loop[0-7] | 本地回环设备                |
| /dev/ram[0-15] | 内存                        |
| /dev/null      | 无限数据接收设备,相当于黑洞 |
| /dev/zero      | 无限零资源                  |
| /dev/tty[0-63] | 虚拟终端                    |
| /dev/ttyS[0-3] | 串口                        |
| /dev/lp[0-3]   | 并口                        |
| /dev/console   | 控制台                      |
| /dev/fb[0-31]  | framebuffer                 |
| /dev/cdrom     | => /dev/hdc                 |
| /dev/modem     | => /dev/ttyS[0-9]           |
| /dev/pilot     | => /dev/ttyS[0-9]           |
| /dev/random    | 随机数设备                  |
| /dev/urandom   | 随机数设备                  |

[好文要顶](javascript:void(0);) [关注我](javascript:void(0);) [收藏该文](javascript:void(0);) [![img](https://common.cnblogs.com/images/icon_weibo_24.png)](javascript:void(0);) [![img](https://common.cnblogs.com/images/wechat.png)](javascript:void(0);)