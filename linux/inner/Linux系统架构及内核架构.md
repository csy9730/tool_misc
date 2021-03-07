# Linux系统架构及内核架构

[![img](https://upload.jianshu.io/users/upload_avatars/6120676/5c563cc5-5964-4f78-99d5-4b7fd839afdf?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)](https://www.jianshu.com/u/2d8a8096b581)

[lijincheng](https://www.jianshu.com/u/2d8a8096b581)关注

2017.05.20 17:05:56字数 208阅读 4,369

\1. linux系统架构如下图所示：



![img](https://upload-images.jianshu.io/upload_images/6120676-de29d6622451cc8a.png?imageMogr2/auto-orient/strip|imageView2/2/w/514/format/webp)

linux系统架构由硬件、kernel、系统调用、shell、c库、应用程序组成。



\2. 内核架构



![img](https://upload-images.jianshu.io/upload_images/6120676-efbcea90ac75e3cb.png?imageMogr2/auto-orient/strip|imageView2/2/w/823/format/webp)

什么叫linux？ Linux是一种自由和开放[源码](https://link.jianshu.com/?t=http://www.2cto.com/ym/)的类Unix操作系统，遵循GPL协定，内核是操作系统的核心，具有很多最基本功能，它负责管理系统的进程、[内存](https://link.jianshu.com/?t=http://product.yesky.com/catalog/219/)、设备[驱动](https://link.jianshu.com/?t=http://drivers.yesky.com/)程序、文件和[网络](https://link.jianshu.com/?t=http://product.yesky.com/net/)系统，决定着系统的性能和稳定性。由Linus Torvalds 负责更新和维护。

Linux 内核组成：内存管理、进程管理、设备驱动程序、文件系统和网络管理等，各个组成部分的关系如图：



![img](https://upload-images.jianshu.io/upload_images/6120676-f69f19887743718e.png?imageMogr2/auto-orient/strip|imageView2/2/w/576/format/webp)

下载内核网址为：https://www.kernel.org/