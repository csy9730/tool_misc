# [UVC和V4L2的关系（转载）](https://www.cnblogs.com/y4247464/p/10629220.html)

- UVC是一种usb视频设备驱动。用来支持usb视频设备，凡是usb接口的摄像头都能够支持
- V4L2是Linux下的视频采集框架。用来统一接口，向应用层提供API

**UVC：**

USB video class（又称为USB video device class or UVC）就是[USB](http://en.wikipedia.org/wiki/Universal_Serial_Bus) [device class](http://en.wikipedia.org/wiki/Universal_serial_bus#Device_classes)视频产品在不需要安装任何的驱动程序下即插即用，包括[摄像头](http://zh.wikipedia.org/wiki/網路攝影機)、数字[摄影机](http://zh.wikipedia.org/wiki/攝影機)、模拟视频转换器、[电视卡](http://zh.wikipedia.org/w/index.php?title=電視卡&action=edit&redlink=1)及[静态视频相机](http://zh.wikipedia.org/w/index.php?title=靜態影像相機&action=edit&redlink=1)。

最新的UVC版本为UVC 1.5，由[USB-IF](http://zh.wikipedia.org/wiki/USB-IF)（[USB Implementers Forum](http://en.wikipedia.org/wiki/USB_Implementers_Forum)）定义包括基本协议及负载格式 

这个链接是Linux中对UVC支持的相关描述

**V4L2：**

Video4Linux或V4L是一个[视频截取](http://zh.wikipedia.org/w/index.php?title=視訊擷取&action=edit&redlink=1)及设备输出[API](http://zh.wikipedia.org/wiki/应用程序接口)，以及[Linux](http://zh.wikipedia.org/wiki/Linux)的驱动程序框架，支持很多[USB](http://zh.wikipedia.org/wiki/通用串行總線)[摄像头](http://zh.wikipedia.org/wiki/摄像头)、[电视调谐卡](http://zh.wikipedia.org/w/index.php?title=電視調諧卡&action=edit&redlink=1)以及其他设备。Video4Linux与[Linux内核](http://zh.wikipedia.org/wiki/Linux内核)紧密集成

**两者之间的关系**

简单的讲V4L2就是用来管理UVC设备的并且能够提供视频相关的一些**应用程序接口**。那么这些API怎么使用或者能被谁使用呢。在Linux系统上有很多的开源软件能够支持V4L2。常见的有FFmpeg、opencv、Skype、Mplayer等等。

 

**这样一个UVC能够进行视频显示的话应该满足三个条件：**

　　1、 UVC的camera硬件支持

　　2 、UVC驱动支持，包括USB设备驱动以及v4l2的支持

　　3、 上层的应用程序支持

linux UVC驱动是为了全面的支持UVC设备。它包括V4L2内核驱动程序和用户空间工具补丁。这个视频设备或者USB视频类的USB设备类的定义定义了在USB上的视频流的功能。UVC类型的外设只需要一个通用的驱动支持就能够正常工作，就像USB 大容量存储设备一样。

UVC的linux  kernel驱动程序和支持的硬件设备都在这里有相关的描述：http://www.ideasonboard.org/uvc/。

 

**判断一个摄像头是否属于UVC规范可以使用如下方法：**

　　1 使用lsusb命令或其他硬件信息查看工具，找出摄像头的设备号（Vendor ID）和产品号（Product ID）。

　　2 查找是否有视频类借口信息

lsusb -d VID：PID -v | grep "14 Video"

如果兼容UVC，则会输出类似信息

bFunctionClass 14 Video

bInterfaceClass 14 Video

bInterfaceClass 14 Video

bInterfaceClass 14 Video

如果没有以上信息，则是non-UVC设备。

 

转载自：

## [UVC&V4L2的关系](https://www.cnblogs.com/liusiluandzhangkun/p/8688742.html)



分类: [项目](https://www.cnblogs.com/y4247464/category/1428876.html)