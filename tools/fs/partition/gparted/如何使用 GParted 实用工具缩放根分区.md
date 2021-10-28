# 如何使用 GParted 实用工具缩放根分区

[Linux中国](https://www.zhihu.com/org/linuxzhong-guo)[](https://www.zhihu.com/question/48510028)

已认证的官方帐号

关注

15 人赞同了该文章

> 在这篇文章中，我们将教你如何使用 GParted 缩放在 Linux 上的活动根分区。
> -- Magesh Maruthamuthu（作者）

今天，我们将讨论磁盘分区。这是 Linux 中的一个好话题。这允许用户来重新调整在 Linux 中的活动 root 分区。

在这篇文章中，我们将教你如何使用 GParted 缩放在 Linux 上的活动根分区。

比如说，当我们安装 Ubuntu 操作系统时，并没有恰当地配置，我们的系统仅有 30 GB 磁盘。我们需要安装另一个操作系统，因此我们想在其中制作第二个分区。

虽然不建议重新调整活动分区。然而，我们要执行这个操作，因为没有其它方法来释放系统分区。

> 注意：在执行这个动作前，确保你备份了重要的数据，因为如果一些东西出错（例如，电源故障或你的系统重启)，你可以得以保留你的数据。

## **Gparted 是什么**

[GParted](https://gparted.org/) 是一个自由的分区管理器，它使你能够缩放、复制和移动分区，而不丢失数据。通过使用 GParted 的 Live 可启动镜像，我们可以使用 GParted 应用程序的所有功能。GParted Live 可以使你能够在 GNU/Linux 以及其它的操作系统上使用 GParted，例如，Windows 或 Mac OS X 。

## `1) 使用 df 命令检查磁盘空间利用率`

我只是想使用 `df` 命令向你显示我的分区。`df` 命令输出清楚地表明我仅有一个分区。

```text
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/sda1        30G  3.4G 26.2G  16% /
none            4.0K     0  4.0K   0% /sys/fs/cgroup
udev            487M  4.0K  487M   1% /dev
tmpfs           100M  844K   99M   1% /run
none            5.0M     0  5.0M   0% /run/lock
none            498M  152K  497M   1% /run/shm
none            100M   52K  100M   1% /run/user
```

## `2) 使用 fdisk 命令检查磁盘分区`

我将使用 `fdisk` 命令验证这一点。

```text
$ sudo fdisk -l
[sudo] password for daygeek:

Disk /dev/sda: 33.1 GB, 33129218048 bytes
255 heads, 63 sectors/track, 4027 cylinders, total 64705504 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x000473a3

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *        2048    62609407    31303680   83  Linux
/dev/sda2        62611454    64704511     1046529    5  Extended
/dev/sda5        62611456    64704511     1046528   82  Linux swap / Solaris
```

## `3) 下载 GParted live ISO 镜像`

使用下面的命令来执行下载 GParted live ISO。

```text
$ wget https://downloads.sourceforge.net/gparted/gparted-live-0.31.0-1-amd64.iso
```

## `4) 使用 GParted Live 安装介质启动你的系统`

使用 GParted Live 安装介质（如烧录的 CD/DVD 或 USB 或 ISO 镜像）启动你的系统。你将获得类似于下面屏幕的输出。在这里选择 “GParted Live (Default settings)” ，并敲击回车按键。



![img](https://pic4.zhimg.com/80/v2-de75a35424400eb9942346354957d2db_1440w.jpg)



## `5) 键盘选择`

默认情况下，它选择第二个选项，按下回车即可。



![img](https://pic2.zhimg.com/80/v2-745d8eb601be7086e834c813f098dd1d_1440w.jpg)



## `6) 语言选择`

默认情况下，它选择 “33” 美国英语，按下回车即可。



![img](https://pic4.zhimg.com/80/v2-a19df26f8a9221586545cf7cf36f2607_1440w.jpg)



## `7) 模式选择（图形用户界面或命令行)`

默认情况下，它选择 “0” 图形用户界面模式，按下回车即可。



![img](https://pic3.zhimg.com/80/v2-0d5208d628c55cf35fd8c913231fec66_1440w.jpg)



## `8) 加载 GParted Live 屏幕`

现在，GParted Live 屏幕已经加载，它显示我以前创建的分区列表。



![img](https://pic3.zhimg.com/80/v2-71cdba14c87d52e27606b168c8c7c656_1440w.jpg)



## `9) 如何重新调整根分区大小`

选择你想重新调整大小的根分区，在这里仅有一个分区，所以我将编辑这个分区以便于安装另一个操作系统。



![img](https://pic3.zhimg.com/80/v2-48bea8d5a33d3e586f5b33cbf8e7c726_1440w.jpg)



为做到这一点，按下 “Resize/Move” 按钮来重新调整分区大小。



![img](https://pic2.zhimg.com/80/v2-ee99c5776eec52d1f15dee525f9da551_1440w.jpg)



现在，在第一个框中输入你想从这个分区中取出的大小。我将索要 “10GB”，所以，我添加 “10240MB”，并让该对话框的其余部分为默认值，然后点击 “Resize/Move” 按钮。



![img](https://pic3.zhimg.com/80/v2-9e594793a0c38bb1caa4f72e8880fc82_1440w.jpg)



它将再次要求你确认重新调整分区的大小，因为你正在编辑活动的系统分区，然后点击 “Ok”。



![img](https://pic1.zhimg.com/80/v2-cc789fe5105d74be6513bb4d4dc90f64_1440w.jpg)



分区从 30GB 缩小到 20GB 已经成功。也显示 10GB 未分配的磁盘空间。



![img](https://pic2.zhimg.com/80/v2-fd483eadd8dd43dc47e06fd2b154f505_1440w.jpg)



最后点击 “Apply” 按钮来执行下面剩余的操作。



![img](https://pic3.zhimg.com/80/v2-0c0b7b5e8aece06ef8f246e68c321f8a_1440w.jpg)



`e2fsck` 是一个文件系统检查实用程序，自动修复文件系统中与 HDD 相关的坏扇道、I/O 错误。



![img](https://pic4.zhimg.com/80/v2-f74cc2662f814117eba670e1f6a366eb_1440w.jpg)



`resize2fs` 程序将重新调整 ext2、ext3 或 ext4 文件系统的大小。它可以被用于扩大或缩小一个位于设备上的未挂载的文件系统。



![img](https://pic2.zhimg.com/80/v2-9e3d245ba6e5305cb925b404faf4c541_1440w.jpg)



`e2image` 程序将保存位于设备上的关键的 ext2、ext3 或 ext4 文件系统的元数据到一个指定文件中。



![img](https://pic2.zhimg.com/80/v2-9a30658163dc58621e7cbaee573851bd_1440w.jpg)



所有的操作完成，关闭对话框。



![img](https://pic1.zhimg.com/80/v2-91cfcc47712c052055819fdb9853e48c_1440w.jpg)



现在，我们可以看到未分配的 “10GB” 磁盘分区。



![img](https://pic4.zhimg.com/80/v2-4f3d791f049e1dc04ffca31e06af6ea7_1440w.jpg)



重启系统来检查这一结果。



![img](https://pic1.zhimg.com/80/v2-5267ce91fac6032729ee02e7b8356f04_1440w.jpg)



## `10) 检查剩余空间`

重新登录系统，并使用 `fdisk` 命令来查看在分区中可用的空间。是的，我可以看到这个分区上未分配的 “10GB” 磁盘空间。

```text
$ sudo parted /dev/sda print free
[sudo] password for daygeek: 
Model: ATA VBOX HARDDISK (scsi)
Disk /dev/sda: 32.2GB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags: 

Number  Start   End     Size    Type     File system  Flags
        32.3kB  10.7GB  10.7GB           Free Space
 1      10.7GB  32.2GB  21.5GB  primary  ext4         boot
```

------

via: [https://www.2daygeek.com/how-to-resize-active-primary-root-partition-in-linux-using-gparted-utility/](https://www.2daygeek.com/how-to-resize-active-primary-root-partition-in-linux-using-gparted-utility/)

作者：[Magesh Maruthamuthu](https://www.2daygeek.com/author/magesh/) 译者：[robsean](https://github.com/robsean) 校对：[wxy](https://github.com/wxy) 选题：[lujun9972](https://github.com/lujun9972)

本文由 [LCTT](https://github.com/LCTT/TranslateProject) 原创编译，[Linux中国](https://linux.cn/) 荣誉推出

发布于 2019-06-15

[硬盘分区](https://www.zhihu.com/topic/19581919)