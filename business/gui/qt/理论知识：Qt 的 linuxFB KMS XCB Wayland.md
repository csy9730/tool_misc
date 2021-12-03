# 理论知识：Qt 的 linuxFB KMS XCB Wayland



[archerLea](https://blog.csdn.net/deggfg) 2018-08-07 11:19:23 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes.png) 5968 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect.png) 收藏 20

分类专栏： [QT5](https://blog.csdn.net/deggfg/category_7812612.html) [显示](https://blog.csdn.net/deggfg/category_7913920.html)

版权

[![img](https://img-blog.csdnimg.cn/20201014180756919.png?x-oss-process=image/resize,m_fixed,h_64,w_64)QT5](https://blog.csdn.net/deggfg/category_7812612.html)同时被 2 个专栏收录![img](https://csdnimg.cn/release/blogv2/dist/pc/img/newArrowDown1White.png)

8 篇文章0 订阅

订阅专栏

[![img](https://img-blog.csdnimg.cn/20201014180756922.png?x-oss-process=image/resize,m_fixed,h_64,w_64)显示](https://blog.csdn.net/deggfg/category_7913920.html)

2 篇文章0 订阅

订阅专栏

#### linuxFB

- 直接往FrameBuffer写数据
- 只支持软件渲染（software-rendered），所以没有gpu的片子选这个
- 某些配置会使显示性能受到抑制
- 命令行可使用命令`QT_QPA_PLATFORM=linuxfb:fb=/dev/fb1` 和 `-platform linuxfb`使qt程序运行在该plugin上
- 另外指定fb用`fb=/dev/fbN`，分配显示区大小`size=<width>x<height>`，物理大小`mmSize=<width>x<height>`，设定便宜`offset=<width>x<height>`，有关于屏幕消影（blinking cursor）和闪烁光标（screen blanking）的控制`nographicsmodeswitch`

------

#### KMS

一个试验性的平台plugin，利用内核的 modesetting 和 drm（Direct Rendering Manager）机制。**依赖内核的配置和 drm**

------

#### XCB

- 用于平常的桌面linux平台
- 一些嵌入式平台使用该plugin需要提供一些必要的开发文件
- 在x桌面下，有些设备不支持egl和 opengl因为EGL的实现不适配Xlib，这种情况下编译出来的XCB plugin将不支持EGL，也意味着 Qt Quick 2 和其他以 OpenGL 为基础的应用程序将不能在该这个平台上成功运行（**这就是我们的程序为什么没有在imx6ul的xcb平台下运行成功的原因**）。此时，他能支持那些以软件渲染（software-rendered）的程序运行，例如 QWidget。
- **作为一个通用的规则，XCB是不建议在嵌入式平台上使用的**，eglfs能更好的展现较高的性能和支持硬件加速能力

------

#### Wayland

- 轻量级的视窗系统
- 一个关于client可以与显示server连通的协议
- Qt 提供了Wayland的相关插件使得Qt 应用程序与wayland显示进行连通

------

**说明：**看到这里，会发现缺了个关键plugin的介绍：`eglfs`，这个之前有个介绍，这里就不一一说明。记住嵌入式linux平台开发，特别是带GPU的soc，用这个最好，至于实际的使用中的功能点以后慢慢补齐，有了方向，其他需要的是汗水。