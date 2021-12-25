# [Linux中的DRM](https://www.cnblogs.com/mao0504/p/5619107.html)



如果在搜索引擎离搜索 DRM 映入眼帘的尽是Digital Rights Managemen，也就是数字版权加密保护技术。

这当然不是我们想要的解释。在类unix世界中还有一个DRM即The Direct Rendering Manager，它是DRI(Direct Rendering Infrastructure)框架的一个组件。而DRI的作用是为类Unix系统提供高效视频加速（很重要的用途是可以对3D渲染提供加速效果）。

DRI是由以下2个部分组成的（这2个在linux即可以编译进内核，也可以以模块形式存在）：

1、通用的DRM驱动。

2、支持特定显卡的驱动。



# DRM - Direct Rendering Manager

DRM是一个内核级的设备驱动，既可以编译到内核中也可以作为标准模块进行加载。DRM最初是在FreeBSD中出现的，后来被移植到Linux系统中，并成为Linux系统的标准部分。

DRM可以直接访问DRM clients的硬件。DRM驱动用来处理DMA，内存管理，资源锁以及安全硬件访问。为了同时支持多个3D应用，3D图形卡硬件必须作为一个共享资源，因此需要锁来提供互斥访问。DMA传输和AGP接口用来发送图形操作的buffers到显卡硬件，因此要防止客户端越权访问显卡硬件。



Linux DRM层用来支持那些复杂的显卡设备，这些显卡设备通常都包含可编程的流水线，非常适合3D图像加速。内核中的DRM层，使得这些显卡驱动在进行内存管理，中断处理和DMA操作中变得更容易，并且可以为上层应用提供统一的接口。

# DRM代码位置 

因为Linux kernel内部接口和数据结构可能随时发生变化，所以DRI模块要针对特定的内核版本进行编译。kernel 2.6.26之后的版本，DRM(DRI kernel模块)源码存放在kernel/drivers/gpu/drm中；在这之前的版本，源码在kernel/drivers/char/drm目录中。

每一个3D硬件加速驱动都包含一个内核模块，并且都需要使用DRM支持代码。



# DRI - Direct Rendering Infrastructure 

DRI并不是一个软件模块。相反DRI是由一系列的软件模块组成。引入DRI的目的是为了3D图形加速，DRI是一个软件[架构](http://lib.csdn.net/base/16)，用来协调linux kernel，X windows系统，3D图形硬件以及OpenGL渲染引擎之间的工作。



# DRM支持DRI的方式

DRM以三种方式支持DRI

1. DRM提供到显卡硬件的同步访问。Direct rendering system有多个实体（比如X server，多个direct-rendering客户端，以及kernel）竞争访问显卡硬件。PC类的显卡在多个实体访问显卡硬件时会使用锁。DRM为每个显卡设备提供了一个锁，来同步硬件的访问。比如X server正在执行2D渲染，此direct-rendering客户端执行一个软件回调，这个软件回调会读写frame buffer。对于一些高端卡来说，由于硬件内部本身会对访问命令做排序，因此并不需要使用这个锁。
2. DRM在访问显卡硬件时，强制执行DRI安全测策略。X server以root权限运行，在访问显卡的framebuffer和MMIO区域时，会用/dev/mem映射这些区域。direct-rendering 客户端，并不是运行在root权限的，但是仍然需要类似的映射。DRM设备接口允许客户端创建这些映射，但是必须遵守以下限制： *仅当客户端连接到X server时才能映射这些区域，这就迫使direct-rendering客户端遵守正常的X server安全策略。 * 仅当客户端能够打开/dev/drm?时才可以映射这些区域。这允许系统管理员可以配置direct rendering访问，仅可信的用户才能访问。 * 客户端只能映射X server允许映射的区域。
3. DRM提供了一个通用的DMA引擎。大部分现代PC类计算机的显卡硬件提供command FIFO的DMA访问。DMA 访问比MMIO访问有更好的吞吐量性能。对于这些显卡，DRM 提供的DMA引擎包含下面的features: * 

# DRM和DRI关系 

![img](http://img.blog.csdn.net/20140214104709437?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQva2lja3h4eA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

早期的Direct Rendering Infrastructure



![img](http://img.blog.csdn.net/20140214110604453?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQva2lja3h4eA==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)

当前的Direct Rendering Infrastructure



我们可以看出DRM是DRI的一个组成部分，DRI同时还包含kms以及OPenGLES DRI driver部分。