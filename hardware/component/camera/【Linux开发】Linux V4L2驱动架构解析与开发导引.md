# [【Linux开发】Linux V4L2驱动架构解析与开发导引](https://www.cnblogs.com/huty/p/8518231.html)



Linux V4L2驱动架构解析与开发导引

Andrew按：众所周知，linux中可以采用灵活的多层次的驱动架构来对接口进行统一与抽象，最低层次的驱动总是直接面向硬件的，而最高层次的驱动在linux中被划分为“面向字符设备、面向块设备、面向网络接口”三大类来进行处理，前两类驱动在文件系统中形成类似文件的“虚拟文件”，又称为“节点node”，这些节点拥有不同的名称代表不同的设备，在目录/dev下进行统一管理，系统调用函数如open、close、read等也与普通文件的操作有相似之处，这种接口的一致性是由VFS（虚拟文件系统层）抽象完成的。面向网络接口的设备仍然在UNIX/Linux系统中被分配代表设备的名称（如eth0），但是没有映射入文件系统中，其驱动的调用方式也与文件系统的调用open、read等不同。

video4linux2(V4L2)是Linux内核中关于视频设备的中间驱动层，向上为Linux应用程序访问视频设备提供了通用接口，向下为linux中设备驱动程序开发提供了统一的V4L2框架。在Linux系统中，V4L2驱动的视频设备（如摄像头、图像采集卡）节点路径通常为/dev中的videoX，V4L2驱动对用户空间提供“字符设备”的形式，主设备号为81，对于视频设备，其次设备号为0-63。除此之外，次设备号为64-127的Radio设备，次设备号为192-223的是Teletext设备,次设备号为224-255的是VBI设备。由V4L2驱动的Video设备在用户空间通过各种ioctl调用进行控制，并且可以使用mmap进行内存映射。

linux内核概略架构（source：《Linux Device Drivers  Edition 3》chaper1）

​                      （上传不了，看官去翻书...）

V4l2在linux中的驱动架构（Edit By Andrew）：

![img](https://pic002.cnblogs.com/images/2012/462822/2012111422002715.jpg) 

​     可以看到从视频输入输入硬件的整个驱动链被抽象成3个层次：

1、  最底层是直接面向硬件的，驱动框架由v4l2提供。值得注意的是，往往该层驱动需要总线驱动的支持，比如常见的USB2.0总线。

2、  中间层便是v4l2。这是v4l的第二版，由Bill Dirks最开始开发，最终被收入标准内核驱动树。

3、  上层是linux内核三大驱动模块之一的“字符设备驱动层”，因此最终视频设备以文件系统中/dev目录下的字符设备的面目出现，并被应用程序使用。

V4L2的是V4L的第二个版本。原来的V4L被引入到Linux内核2.1.x的开发周期后期。Video4Linux2修正了一些设计缺陷，并开始出现在2.5.X内核，并在内核2.6.38之后，取消了对第一个版本v4l的支持。Video4Linux2驱动程序包括Video4Linux1应用的兼容模式，但实际上，支持是不完整的，并建议V4L2的设备使用V4L2的模式。现在，该项目的DVB-Wiki托管在LinuxTV（---><http://linuxtv.org/wiki/index.php/Main_Page>）的网站上。

要想了解 V4l2 有几个重要的文档是必须要读的：

1、源码Documentation/video4linux目录下的V4L2-framework.txt和videobuf

2、V4L2的官方API文档V4L2 API Specification

3、源码drivers/media/video目录下的sample程序vivi.c（虚拟视频驱动程序，此代码模拟一个真正的视频设备V4L2 API）。

V4l2可以支持多种设备,它可以有以下几种接口:

\1. 视频采集接口(video capture interface):这种应用的设备可以是高频头或者摄像头.V4L2的最初设计就是应用于这种功能的.

\2. 视频输出接口(video output interface):可以驱动计算机的外围视频图像设备--像可以输出电视信号格式的设备.

\3. 直接传输视频接口(video overlay interface):它的主要工作是把从视频采集设备采集过来的信号直接输出到输出设备之上,而不用经过系统的CPU.

\4. 视频间隔消隐信号接口(VBI interface):它可以使应用可以访问传输消隐期的视频信号.

\5. 收音机接口(radio interface):可用来处理从AM或FM高频头设备接收来的音频流.

 

Andrew附：值得注意的是，内核底层驱动程序的支持情况往往是我们关心的。推荐这篇博文《Linux 下摄像头驱动支持情况》 <http://weijb0606.blog.163.com/blog/static/131286274201063152423963/>   这里做一个简要的总结：

1、  由于在内核2.6.38版本之后就已经完全支持v4l2，且抛弃了第一版。如今（2012-11）的内核版本已到3.3.6，且几乎所有的视频设备驱动都已过渡到新版，因此在开发程序的时候应该按照v4l2的版本API标准来开发。

2、  一般市场上容易买到的“免驱”摄像头就是符合UVC标准的，内核都可以支持。

3、  其他种类的如中星微的ZC3XX、Sunplus系列等，GSPCA一般能支持，内核也是自带的。

4、  内核支持的所有种类的视频设备驱动，都可以在文件系统目录/lib/modules/kernel%uname –r/kernel/driver/meida/video下找到。或者在编译内核时，一一列举。

相关网站：

http://linuxtv.org

<http://linuxtv.org/wiki/index.php/Main_Page>  linuxTV网站是V4L- (DVB) Digital Video Broadcasting的维护者。

<http://www.ideasonboard.org/uvc/> linux UVC驱动主页

<http://mxhaard.free.fr/spca5xx.html> gspca驱动主页

 

 

===========一些v4l2驱动层细节==========

——注意这些细节不是应用程序调用的，而是编写驱动程序需要了解的，或者是关于v4l2本身的一些细节。

关于编写应用程序的一些细节移步“ <http://www.cnblogs.com/andrew-wang/archive/2012/11/14/2770701.html>  ”。

 

所有的v4l2驱动程序有以下结构：

​      1) 每个设备包含设备状态的实例结构。

​      2) 子设备的初始化和命令方式(如果有).

​      3) 创建V4L2的设备节点 (/dev/videoX, /dev/vbiX and /dev/radioX)和跟踪设备节点的具体数据。

​      4)文件句柄特定的结构，包含每个文件句柄数据;

​      5) 视频缓冲处理。

V4L2 驱动核心

V4L2 的驱动源码在drivers/media/video目录下，主要核心代码有：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

![复制代码](https://common.cnblogs.com/images/copycode.gif)

```
v4l2-dev.c                  //linux版本2视频捕捉接口,主要结构体 video_device 的注册
v4l2-common.c               //在Linux操作系统体系采用低级别的操作一套设备structures/vectors的通用视频设备接口。
                            //此文件将替换videodev.c的文件配备常规的内核分配。
v4l2-device.c               //V4L2的设备支持。注册v4l2_device
v4l22-ioctl.c               //处理V4L2的ioctl命令的一个通用的框架。
v4l2-subdev.c               //v4l2子设备
v4l2-mem2mem.c              //内存到内存为Linux和videobuf视频设备的框架。设备的辅助函数，使用其源和目的地videobuf缓冲区。

头文件linux/videodev2.h、media/v4l2-common.h、media/v4l2-device.h、media/v4l2-ioctl.h、media/v4l2-dev.h、media/v4l2-ioctl.h等。
```

![复制代码](https://common.cnblogs.com/images/copycode.gif)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

V4l2相关结构体

 1.V4l2_device

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

![复制代码](https://common.cnblogs.com/images/copycode.gif)

```
 struct V4l2_device{
    /* DEV-> driver_data指向这个结构。 注：DEV可能是空的，如果没有父设备是如同ISA设备。 */
      struct device *dev;
    /* 用于跟踪注册的subdevs */
      struct list_head subdevs;
    /*锁定此结构体;可以使用的驱动程序以及如果这个结构嵌入到一个更大的结构。 */
      spinlock_t lock;
    /* 独特的设备名称，默认情况下，驱动程序姓名+总线ID */
      char name[V4L2_DEVICE_NAME_SIZE];
    /*报告由一些子设备调用的回调函数。 */
      void (*notify)(struct v4l2_subdev *sd,
                    unsigned int notification, void *arg);

}；
```

![复制代码](https://common.cnblogs.com/images/copycode.gif)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

v4l2_device注册和注销     

```
 v4l2_device_register(struct device *dev, struct v4l2_device *v4l2_dev); 
```

​     第一个参数‘dev’通常是一个pci_dev的struct device的指针，但它是ISA设备或一个设备创建多个PCI设备时这是罕见的DEV为NULL，因此makingit不可能联想到一个特定的父母v4l2_dev。 您也可以提供一个notify（）回调子设备，可以通过调用通知你的事件。取决于你是否需要设置子设备。一个子设备支持的任何通知必须在头文件中定义 .

注册时将初始化 v4l2_device 结构体. 如果 dev->driver_data字段是空, 它将连接到 v4l2_dev.

```
v4l2_device_unregister(struct v4l2_device *v4l2_dev);
```

注销也将自动注销设备所有子设备。

2.video_device   (进行视频编程时v4l的最重要也是最常用功能)

​      在/dev目录下的设备节点使用的 struct video_device（v4l2_dev.h）创建。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

![复制代码](https://common.cnblogs.com/images/copycode.gif)

```
struct video_device
     {
         /*设备操作函数 */
         const struct v4l2_file_operations *fops;
         /* 虚拟文件系统 */
         struct device dev;        /* v4l 设备 */
         struct cdev *cdev;        /* 字符设备 */
         struct device *parent;        /*父设备 */
         struct v4l2_device *v4l2_dev;    /* v4l2_device parent */
        /* 设备信息 */
         char name[32];
         int vfl_type;
         /* 'minor' is set to -1 if the registration failed */
         int minor;
         u16 num;
         /* use bitops to set/clear/test flags */
         unsigned long flags;
         /*属性来区分一个物理设备上的多个索引 */
         int index;
         /* V4L2 文件句柄 */
         spinlock_t        fh_lock;   /*锁定所有的 v4l2_fhs */
         struct list_head    fh_list; /* List of struct v4l2_fh */
         int debug;                   /* Activates debug level*/
         /* Video standard vars */
         v4l2_std_id tvnorms;         /* Supported tv norms */
         v4l2_std_id current_norm;    /* Current tvnorm */
         /* 释放的回调函数 */
         void (*release)(struct video_device *vdev);
         /* 控制的回调函数 */
         const struct v4l2_ioctl_ops *ioctl_ops;
     }
```

![复制代码](https://common.cnblogs.com/images/copycode.gif)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

   动态分配：

```
 struct video_device *vdev = video_device_alloc();
```

   结构体配置：

​         fops：设置这个v4l2_file_operations结构，file_operations的一个子集。v4l2_dev: 设置这个v4l2_device父设备

​         name:

​         ioctl_ops：使用v4l2_ioctl_ops简化的IOCTL，然后设置v4l2_ioctl_ops结构。

​         lock：如果你想要做的全部驱动程序锁定就保留为NULL。否则你给它一个指针指向一个mutex_lock结构体和任何v4l2_file_operations被调用之前核心应该释放释放锁。

​         parent：一个硬件设备有多个PCI设备，都共享相同v4l2_device核心时，设置注册使用NULL v4l2_device作为父设备结构。

​         flags：可选的。设置到V4L2_FL_USE_FH_PRIO如你想让框架处理VIDIOC_G/ S_PRIORITY的ioctl。这就需要您使用结构v4l2_fh。这个标志最终会消失，一旦所有的驱动程序使用的核心优先处理。但现在它必须明确设定。

   如果使用v4l2_ioctl_ops，那么你应该设置。unlocked_ioctlvideo_ioctl2在v4l2_file_operations结构。

注册/注销 video_device：

```
   video_register_device(struct video_device *vdev, int type, int nr);

    __video_register_device(struct video_device *vdev, int type, int nr,int warn_if_nr_in_use)
```

​        参数：

​           vdev：我们要注册的视频设备结构。

​           type：设备类型注册

​           nr：设备号（0==/dev/video0，1??== /dev/video1，...-1==释放第一个）

​           warn_if_nr_in_use：如果所需的设备节点号码已经在使用另一个号码代替选择。

   

​       注册程式分配次设备号和设备节点的数字根据请求的类型和注册到内核新设备节点。如果无法找到空闲次设备号或设备节点编号，或者如果设备节点注册失败，就返回一个错误。

```
 video_unregister_device(struct video_device *vdev);
```

3.v4l2_subdev 子设备结构体

​          每个子设备驱动程序必须有一个v4l2_subdev结构。这个结构可以独立简单的设备或者如果需要存储更多的状态信息它可能被嵌入在一个更大的结构。由于子设备可以做很多不同的东西，你不想结束一个巨大的OPS结构其中只有少数的OPS通常执行，函数指针进行排序按类别，每个类别都有其自己的OPS结构。顶层OPS结构包含的类别OPS结构，这可能是NULL如果在subdev驱动程序不支持任何从该类别指针。

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

![复制代码](https://common.cnblogs.com/images/copycode.gif)

```
struct v4l2_subdev {
     #if defined(CONFIG_MEDIA_CONTROLLER)
         struct media_entity entity;
     #endif

         struct list_head list;
         struct module *owner;
         u32 flags;
         struct v4l2_device *v4l2_dev;
         const struct v4l2_subdev_ops *ops;

         /* 从驱动程序中不要调用这些内部操作函数！ */
         const struct v4l2_subdev_internal_ops *internal_ops;
         /*这个subdev控制处理程序。可能是NULL。 */
         struct v4l2_ctrl_handler *ctrl_handler;
         /* 名字必须是唯一 */
         char name[V4L2_SUBDEV_NAME_SIZE];
         /* 可用于到类似subdevs组，值是驱动程序特定的 */
         u32 grp_id;
         /* 私有数据的指针 */
         void *dev_priv;
         void *host_priv;
         /* subdev 设备节点*/
         struct video_device devnode;
         /* 事件的数量在打开的时候被分配 */
         unsigned int nevents;
      };
```

![复制代码](https://common.cnblogs.com/images/copycode.gif)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 4.v4l2_buffer 缓冲区结构体

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

![复制代码](https://common.cnblogs.com/images/copycode.gif)

```
struct v4l2_buffer {
    __u32            index;
    enum v4l2_buf_type      type;
    __u32            byteSUSEd;
    __u32            flags;
    enum v4l2_field        field;
    struct timeval        timestamp;
    struct v4l2_timecode    timecode;
    __u32            sequence;

    /* memory location */
    enum v4l2_memory        memory;
    union {
        __u32           offset;
        unsigned long   userptr;
    } m;
    __u32            length;
    __u32            input;
    __u32            reserved;
};
```

![复制代码](https://common.cnblogs.com/images/copycode.gif)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

   V4L2核心API提供了一套标准方法的用于处理视频缓冲器（称为“videobuf”）。这些方法允许驱动程序以一致的方式来实现read()，mmap()和overlay()。目前使用的设备上的视频缓冲器，支持scatter/gather方法（videobuf-dma-SG），线性存取的DMA的（videobuf-DMA-contig），vmalloc分配的缓冲区，主要用于在USB驱动程序（DMA缓冲区的方法videobuf-vmalloc）。

   videobuf层的功能为一种V4L2驱动和用户空间之间的粘合层。它可以处理存储视频帧缓冲区的分配和管理。有一组可用于执行许多标准的POSIX I / O系统调用的功能，包括read（），poll（）的，happily，mmap（）。另一套功能可以用来实现大部分的V4L2的ioctl（）调用相关的流式I/ O的，包括缓冲区分配，排队和dequeueing，流控制。驱动作者使用videobuf规定了一些设计决定，但回收期在驱动器和一个V4L2的用户空间API的贯彻实施在减少代码的形式。

   关于videobuf的层的更多信息,请参阅Documentation/video4linux/videobuf

 

Sample驱动源码分析：vivi.c 虚拟视频驱动程序

​                      ----- 此代码模拟一个真正的视频设备V4L2 API (位于drivers/media/video目录下)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

![复制代码](https://common.cnblogs.com/images/copycode.gif)

```
  入口：+int __init vivi_init(void)

                 + vivi_create_instance(i) /*创建设备*//**/。

                         + 分配一个vivi_dev的结构体 /*它嵌套这结构体v4l2_device 和video_device*/

                         + v4l2_device_register(NULL, &dev->v4l2_dev);/*注册vivi_dev中的V4l2_device*/

                         + 初始化视频的DMA队列

                         + 初始化锁

                         + video_device_alloc(); 动态分配video_device结构体

                         + 构建一个video_device结构体 vivi_template 并赋给上面分配的video_device

                                static struct video_device vivi_template = {

                                          . name        = "vivi",

                                          .fops           = &vivi_fops,

                                          .ioctl_ops     = &vivi_ioctl_ops,

                                          .minor        = -1,

                                          .release    = video_device_release,

                                          .tvnorms              = V4L2_STD_525_60,

                                          .current_norm         = V4L2_STD_NTSC_M,

                                 };

                       + video_set_drvdata(vfd, dev);设置驱动程序专有数据

                       + 所有控件设置为其默认值

                       + list_add_tail(&dev->vivi_devlist, &vivi_devlist);添加到设备列表

          + 构建 v4l2_file_operations 结构体vivi_fops 并实现.open .release .read .poll .mmap函数

                            ----- .ioctl 用标准的v4l2控制处理程序

          + 构建 v4l2_ioctl_ops结构体 vivi_ioctl_ops

                             static const struct v4l2_ioctl_ops vivi_ioctl_ops = {

                                        .vidioc_querycap      = vidioc_querycap,

                                        .vidioc_enum_fmt_vid_cap  = vidioc_enum_fmt_vid_cap,

                                        .vidioc_try_fmt_vid_cap   = vidioc_try_fmt_vid_cap,

                                        .vidioc_s_fmt_vid_cap     = vidioc_s_fmt_vid_cap,

                                        .vidioc_reqbufs       = vidioc_reqbufs,

                                        .vidioc_querybuf      = vidioc_querybuf,

                                        .vidioc_qbuf          = vidioc_qbuf,

                                        .vidioc_dqbuf         = vidioc_dqbuf,

                                        .vidioc_s_std         = vidioc_s_std,

                                        .vidioc_enum_input    = vidioc_enum_input,

                                        .vidioc_g_input       = vidioc_g_input,

                                        .vidioc_s_input       = vidioc_s_input,

                                        .vidioc_queryctrl     = vidioc_queryctrl,

                                        .vidioc_g_ctrl        = vidioc_g_ctrl,

                                        .vidioc_s_ctrl        = vidioc_s_ctrl,

                                        .vidioc_streamon      = vidioc_streamon,

                                        .vidioc_streamoff     = vidioc_streamoff,

                             #ifdef CONFIG_VIDEO_V4L1_COMPAT

                                       .vidiocgmbuf          = vidiocgmbuf,

                           #endif

                       };

           + int vivi_open(struct file *file)

                     + vivi_dev *dev = video_drvdata(file);  访问驱动程序专用数据

                     + 分配+初始化句柄（vivi_fh）数据

                     + 重置帧计数器

                     + videobuf_queue_vmalloc_init(); 初始化视频缓冲队列

                     + 开启一个新线程用于开始和暂停

           + 实现自定义的v4l2_ioctl_ops 函数
```

![复制代码](https://common.cnblogs.com/images/copycode.gif)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

注* 本文撰写主要参考了linux公社的文章《Android设备驱动之——V4L2》