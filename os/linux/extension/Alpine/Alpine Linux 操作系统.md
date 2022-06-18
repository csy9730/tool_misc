# Alpine Linux 操作系统

[![img](https://upload.jianshu.io/users/upload_avatars/14929498/5e9bae0c-3e53-45ed-a6ca-25077c1177e3.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)](https://www.jianshu.com/u/e0a7508707be)

[无剑_君](https://www.jianshu.com/u/e0a7508707be)关注

0.2582019.11.02 08:17:19字数 1,022阅读 8,320

# 一、Alpine Linux 简介

  Alpine Linux 是一款独立的非商业性的通用 Linux 发行版，关注于安全性、简单性和资源效率。
  Alpine Linux 围绕 musl libc 和 busybox 构建。这使得它比传统的 GNU/Linux 发行版更小，更节省资源。一个容器只需不超过 8 MB 的空间。而在磁盘中的最小安装仅要大约 130 MB 的存储空间。尽管体积很小，Apline 提供了完整的 Linux 环境，其存储库中还包含了大量的软件包备选。除此之外，Alpine 还对软件包进行了缩减和拆分，以使用户能够对安装内容有更精确的控制，进一步帮助减少安装体积并提高效率。
  Alpine Linux 设计清晰而简练。它采用自有的名为 apk 的包管理器，以 OpenRC 作为初始化（init）系统，安装由脚本驱动。其提供的 Linux 环境简单、清晰且没有任何「噪音」。然后，用户可以基于此添加项目所需的软件包。因此，在各种应用场景下，Alpine 的设计都不会为用户带来麻烦。
  Alpine Linux 在设计时注重安全性。内核采用了一个非官方的 grsecurity/PaX 移植版本（3.8 版本已终止对 grsecuiry 移植版本的支持），并且所有用户空间的二进制文件被编译为位置独立可执行文件（Position Independent Executables）并启用堆栈粉碎保护。这些积极的安全功能可有效防止某些种类的 0-day 攻击。
官网：[https://www.alpinelinux.org/](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.alpinelinux.org%2F)

特点：
1、小巧：基于musl libc 和 busybox，和 busybox一样小巧，最小的Docker镜像只有5MB。
2、安全：面向安全的轻量发行版
3、简单：提供APK包管理工具，软件的搜索、安装、删除、升级都非常方便。
4、适合容器使用：由于小巧、功能完备，非常适合作为容器的基础镜像。
不同版本：
STANDARD：最小的可启动镜像，需要网络才能安装。
EXTENDED：包括最常用的软件包。适用于路由器和服务器。从RAM运行。扩展版本，带有更多软件包。
NETBOOT：netboot的内核、initramfs和modloop。
MINI ROOT FILESYSTEM：最小系统版本，仅包含内核，只用于构建Docker镜像。
VIRTUAL：与STANDARD类似，但更小，更适合虚拟系统使用。
XEN：内置XEN Hypervisor支持。
RASPBERRY PI：带有树莓派内核的版本。
GENERIC ARM：带有ARM内核，带有uboot加载器。

# 二、系统安装

安装文档：[https://wiki.alpinelinux.org/wiki/Install_Alpine_on_VMware](https://links.jianshu.com/go?to=https%3A%2F%2Fwiki.alpinelinux.org%2Fwiki%2FInstall_Alpine_on_VMware)

1. 下载iso镜像（STANDARD）

   ![img](https://upload-images.jianshu.io/upload_images/14929498-c5eaaaab3efff080.png?imageMogr2/auto-orient/strip|imageView2/2/w/635/format/webp)

   下载iso镜像

2. 创建vmware虚拟机

   ![img](https://upload-images.jianshu.io/upload_images/14929498-b7182c3fba392a29.png?imageMogr2/auto-orient/strip|imageView2/2/w/497/format/webp)

   创建vmware虚拟机

   ![img](https://upload-images.jianshu.io/upload_images/14929498-709ee22bac796dc6.png?imageMogr2/auto-orient/strip|imageView2/2/w/499/format/webp)

   创建vmware虚拟机

   ![img](https://upload-images.jianshu.io/upload_images/14929498-e03dcb013eee20af.png?imageMogr2/auto-orient/strip|imageView2/2/w/495/format/webp)

   创建vmware虚拟机

   ![img](https://upload-images.jianshu.io/upload_images/14929498-53679501a816b1ed.png?imageMogr2/auto-orient/strip|imageView2/2/w/495/format/webp)

   创建vmware虚拟机

1. 系统安装

   ![img](https://upload-images.jianshu.io/upload_images/14929498-20dced3688f1c3ff.png?imageMogr2/auto-orient/strip|imageView2/2/w/709/format/webp)

   选择镜像

   ![img](https://upload-images.jianshu.io/upload_images/14929498-251c3ef386ede862.png?imageMogr2/auto-orient/strip|imageView2/2/w/388/format/webp)

   启动虚拟机

   ![img](https://upload-images.jianshu.io/upload_images/14929498-7d177423562d6921.png?imageMogr2/auto-orient/strip|imageView2/2/w/785/format/webp)

   启动

进入终端之后，输入root默认无密登陆，然后执行"setup-alpine"命令，在终端上启动他的安装程序。



![img](https://upload-images.jianshu.io/upload_images/14929498-5d5686e366d51fe9.png?imageMogr2/auto-orient/strip|imageView2/2/w/752/format/webp)

登录系统



系统设置:



```csharp
[root@localhost ~]# setup-alpine
```

1）键盘布局:us



![img]()

键盘布局:us



![img]()

键盘布局:us



2）网络设置
主机名：localhost
直接回车（默认）
网卡名：eth0
直接回车（默认）



![img]()

网络设置


3）root密码设置

![img]()

root密码设置

4）时区设置Asia/Shanghai



![img]()

时区：Asia/Shanghai



![img]()

代理默认



5）image模式选择
软件仓库的地址-默认选 f，会自动检测最快的镜像站点。
image模式选择：
r:随机的
f:在已有的选择最快的
e:手动修改配置文件



![img](https://upload-images.jianshu.io/upload_images/14929498-803e9c36bcf06ba6.png?imageMogr2/auto-orient/strip|imageView2/2/w/692/format/webp)

image模式



![img](https://upload-images.jianshu.io/upload_images/14929498-530ed69165616eb1.png?imageMogr2/auto-orient/strip|imageView2/2/w/677/format/webp)

选择f


注：必须能够连到外网，也就是网络配置正确，否则没有列表。
6）软件安装选择

软件安装选择:
选择安装openssh 服务器。



![img](https://upload-images.jianshu.io/upload_images/14929498-356b7c0e6fe220e3.png?imageMogr2/auto-orient/strip|imageView2/2/w/762/format/webp)

openssh


选择NTP客户端(用来调整系统时钟)的类型，保持默认的chrony即可，回车。
7）磁盘格式化
因为Alpine Linux可以运行在内存里，这里的默认选项是不使用硬盘，所以要手动键入sda。
以何种方式安装系统，这里需要键入"sys"，表示把整个系统安装在硬盘上。

![img](https://upload-images.jianshu.io/upload_images/14929498-4fa992cb768f769c.png?imageMogr2/auto-orient/strip|imageView2/2/w/783/format/webp)

磁盘格式化


向导让你确认选择的sda磁盘上的数据会全部丢失，虚拟机磁盘，初始肯定是没数据的，键入"y"确认。

![img](https://upload-images.jianshu.io/upload_images/14929498-6bf3e84f7a3f5a89.png?imageMogr2/auto-orient/strip|imageView2/2/w/720/format/webp)

磁盘格式化


8）添加账号
在重启之前，我们先给系统添加个非root帐号。因为root帐号不能用SSH终端登录，所以要添加个的帐号。



```bash
localhost:~# adduser admin
localhost:~# reboot
```

![img](https://upload-images.jianshu.io/upload_images/14929498-7a8c553f6aacd570.png?imageMogr2/auto-orient/strip|imageView2/2/w/444/format/webp)

添加用户

1. root用户SSH登录



```bash
localhost:~# vi /etc/ssh/sshd_config
# 修改
#PermitRootLogin prohibit-password
PermitRootLogin yes
# 重启sshd
localhost:~# /etc/init.d/sshd restart
```

# 三、包管理器

1. 包管理器
   Alpine Linux自带的apk包管理器十分好用，而且软件包更新速度很快，一般search和add两个命令就能搞定软件包依赖问题



```bash
#查询openssh相关的软件包
localhost:~# apk search wget
#安装一个软件包
localhost:~# apk add  wget
#删除已安装的xxx软件包
localhost:~# apk del  wget
#获取更多apk包管理的命令参数
localhost:~# apk --help   
#更新软件包索引文件
localhost:~# apk update    
```



3人点赞



[操作系统](https://www.jianshu.com/nb/34029991)