# DRM（Direct Rendering Manager）学习简介

置顶 何小龙 2018-11-10 19:41:56  31443  收藏 258
分类专栏： DRM (Direct Rendering Manager) 文章标签： DRM Direct Rendering Manager KMS
版权
学习DRM一年多了，由于该架构较为复杂，代码量较多，且国内参考文献较少，初学者学习起来较为困难。因此决定将自己学习的经验总结分享给大家，希望对正在学习DRM的同学有所帮助，同时交流经验。

由于本人工作中只负责Display驱动，因此分享的DRM学习经验都只局限于Display这一块，对于GPU这一块本人无能为力，如果大家有相关经验分享，还请在留言中通知一声，我会常去浏览你的博客，大家相互学习。

DRM
DRM是Linux目前主流的图形显示框架，相比FB架构，DRM更能适应当前日益更新的显示硬件。比如FB原生不支持多层合成，不支持VSYNC，不支持DMA-BUF，不支持异步更新，不支持fence机制等等，而这些功能DRM原生都支持。同时DRM可以统一管理GPU和Display驱动，使得软件架构更为统一，方便管理和维护。

DRM从模块上划分，可以简单分为3部分：libdrm、KMS、GEM


（图片来自Wiki）

libdrm
对底层接口进行封装，向上层提供通用的API接口，主要是对各种IOCTL接口进行封装。

KMS
Kernel Mode Setting，所谓Mode setting，其实说白了就两件事：更新画面和设置显示参数。
更新画面：显示buffer的切换，多图层的合成方式，以及每个图层的显示位置。
设置显示参数：包括分辨率、刷新率、电源状态（休眠唤醒）等。

GEM
Graphic Execution Manager，主要负责显示buffer的分配和释放，也是GPU唯一用到DRM的地方。

基本元素
DRM框架涉及到的元素很多，大致如下：
KMS：CRTC，ENCODER，CONNECTOR，PLANE，FB，VBLANK，property
GEM：DUMB、PRIME、fence


（图片来源：The DRM/KMS subsystem from a newbie’s point of view）

元素	说明
CRTC	对显示buffer进行扫描，并产生时序信号的硬件模块，通常指Display Controller
ENCODER	负责将CRTC输出的timing时序转换成外部设备所需要的信号的模块，如HDMI转换器或DSI Controller
CONNECTOR	连接物理显示设备的连接器，如HDMI、DisplayPort、DSI总线，通常和Encoder驱动绑定在一起
PLANE	硬件图层，有的Display硬件支持多层合成显示，但所有的Display Controller至少要有1个plane
FB	Framebuffer，单个图层的显示内容，唯一一个和硬件无关的基本元素
VBLANK	软件和硬件的同步机制，RGB时序中的垂直消影区，软件通常使用硬件VSYNC来实现
property	任何你想设置的参数，都可以做成property，是DRM驱动中最灵活、最方便的Mode setting机制
DUMB	只支持连续物理内存，基于kernel中通用CMA API实现，多用于小分辨率简单场景
PRIME	连续、非连续物理内存都支持，基于DMA-BUF机制，可以实现buffer共享，多用于大内存复杂场景
fence	buffer同步机制，基于内核dma_fence机制实现，用于防止显示内容出现异步问题
学习DRM驱动其实就是学习上面各个元素的实现及用法，如果你能掌握这些知识点，那么在编写DRM驱动的时候就能游刃有余。

目录（持续更新中）
本篇博客将作为本人DRM学习教程的目录汇总，后续我会以示例代码的形式和大家分享上述知识点的学习过程，并不断更新目录链接，敬请期待！

最简单的DRM应用程序 （single-buffer）
最简单的DRM应用程序 （double-buffer）
最简单的DRM应用程序 （page-flip）
最简单的DRM应用程序 （plane-test）
DRM应用程序进阶 （Property）
DRM应用程序进阶 （atomic-crtc）
DRM应用程序进阶 （atomic-plane）
DRM (Direct Rendering Manager) 的发展历史
DRM 驱动程序开发（开篇）
DRM 驱动程序开发（VKMS）
关于 DRM 中 DUMB 和 PRIME 名字的由来
DRM GEM 驱动程序开发（dumb）
DRM 驱动 mmap 详解：（一）预备知识
DRM 驱动 mmap 详解：（二）CMA Helper
LWN 翻译：Atomic Mode Setting 设计简介（上）
LWN 翻译：Atomic Mode Setting 设计简介（下）
翻译：Mainline Explicit Fencing
dma-buf 系列：
dma-buf 由浅入深（一） —— 最简单的 dma-buf 驱动程序
dma-buf 由浅入深（二） —— kmap / vmap
dma-buf 由浅入深（三） —— map attachment
dma-buf 由浅入深（四） —— mmap
dma-buf 由浅入深（五） —— File
dma-buf 由浅入深（六） —— begin / end cpu_access
dma-buf 由浅入深（七） —— alloc page 版本
dma-buf 由浅入深（八） —— ION 简化版
LWN 翻译：DMA-BUF cache handling: Off the DMA API map (part 1)
LWN 翻译：DMA-BUF cache handling: Off the DMA API map (part 2)

参考资料
Wiki: Direct Rendering Manager
wowotech: Linux graphic subsystem(2)_DRI介绍
Boris Brezillon: The DRM/KMS subsystem from a newbie’s point of view
线·飘零 博客园：Linux环境下的图形系统和AMD R600显卡编程(1)
Younix脏羊 CSDN博客：Linux DRM（二）基本概念和特性