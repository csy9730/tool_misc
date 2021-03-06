# 为Android安装BusyBox —— 完整的bash shell



大家是否有过这样的经历，在命令行里输入adb shell，然后使用命令操作你的手机或模拟器，但是那些命令都是常见Linux命令的阉割缩水版，用起来很不爽。是否想过在Android上使用较完整的shell呢？用BusyBox吧。不论使用adb连接设备使用命令行还是在手机上直接用terminal emulator都可以。

一、什么是BusyBox ？

BusyBox 是标准 Linux 工具的一个单个可执行实现。BusyBox 包含了一些简单的工具，例如 cat 和 echo，还包含了一些更大、更复杂的工具，例如 grep、find、mount 以及 telnet。有些人将 BusyBox 称为 Linux 工具里的瑞士军刀.简单的说BusyBox就好像是个大工具箱，它集成压缩了 Linux 的许多工具和命令。（摘自百度百科）

二、在Android上安装BusyBox

准备：

0. 先要把手机给Root了，具体教程这里就不提供了，网上有很多。

1. 下载BusyBox的binary，打开这个地址 [busybox](http://www.busybox.net/downloads/binaries) ，选择最新版本，然后下载对应你的设备架构的版本，这里我下载了busybox-armv6l，下面将以这个文件名为示例。

![img](https://pic002.cnblogs.com/images/2011/231332/2011031215274263.png)

2. 需要有一个命令行的环境，在电脑上使用adb或在手机上使用terminal emulator。

3. 连接手机和电脑，手机的USB Mode设置成None（仅充电），并且开启USB调试模式。

安装：

1. 将busybox-armv6l重命名为busybox

2. 将busybox传入手机的SD卡，可以使用下面的命令或自己想其他办法。

打开terminal（Linux，Mac）或cmd（Windows）

```
adb ``push` `~/Desktop/busybox /mnt/sdcard
```

其中的~/Desktop请根据自己的情况替换成正确的路径

3. 输入以下命令，为了在/system目录写入文件

```
adb shell``su``mount -o remount,rw -t yaffs2 /dev/block/mtdblock3 /``system
```

使用 ls 检查一下 /system 里是否有 xbin 目录，没有的话输入 mkdir xbin 创建，因为本示例是要把busybox安装到 /system/xbin 。

4. 复制 busybox 文件到 /system/xbin，并为其分配“可执行”的权限

```
cp /mnt/sdcard/busybox /``system``/xbin``chmod` `755 busybox
```

5. 这时就可以使用 busybox 的命令了，例如以前没有清屏的clear命令，现在只需输入 busybox clear 就可以实现清屏功能，使用完整版的 ls 只需输入 busybox ls 。

但是每次前面都加上个busybox太麻烦了，所以我们还要继续完成安装。

在 /system/xbin 下输入

```
busybox --install .
```

如果想安装到别的目录，则把点替换成别的路径。

至此就安装完成了，比较一下原来的 ls 命令和 busybox 里的 ls 命令。

![img](https://pic002.cnblogs.com/images/2011/231332/2011031215564763.png)

**常见错误：**

\1. 如果安装时出现这样的错误，

busybox: /bin/zcat: No such file or directory

busybox: /sbin/zcip: Invalid cross-device link

说明没有输入安装路径，正确的示例 busybox --install /system/xbin

\2. 如果出现这样的错误，

cp: /system/xbin/busybox: Read-only file system

说明没有正确输入上面第三步的mount命令。

**小技巧：**

\1. busybox 里有 ash 和 hush 还有 sh 这几种 shell，在命令行输入 ash 或 hush，可以像在 bash 里那样，通过按上下键选择刚才输入的命令。

\2. android系统本身就有ls命令，busybox里也有ls，输入ls时调用的是android的ls，那么想用busybox的ls就要每次都在前面加个busybox吗？不用，使用alias命令可以搞定。

```
alias ls=``'busybox ls'
```

同样的，cp、mv等二者都有的命令都可以这样搞定。也可以通过修改 /init.rc 来解决。