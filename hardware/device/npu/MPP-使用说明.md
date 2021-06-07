# [MPP-使用说明](https://www.cnblogs.com/xue0708/p/10088451.html)



**1、介绍**

MPP是瑞芯微提供的媒体处理软件平台，适用于瑞芯微芯片系列。它屏蔽了有关芯片的复杂底层处理，屏蔽了不同芯片的差异，为使用者提供了统一的视频媒体统一接口。

具体提供的功能：

视频编码：H264、MJPEG、VP8

视频解码：H265、H264、VP9、VP8、MJPEG、MPEG-4、MPEG-2、VC1

视频处理：视频拷贝、色彩空间转换等

**2、系统架构**

**![img](https://img2018.cnblogs.com/blog/1279278/201812/1279278-20181209103406454-531110161.png)**

Hardware：硬件层，视频编解码硬件加速模块；

Kernel driver：内核驱动层，Linux内核的编码器硬件驱动设备；

MPP层：MPP层屏蔽了不同操作系统和不同芯片平台的差异，为使用者提供统一的MPI接口，包括MPI模块，OSAL模块，NAL模块以及编解码模块（video decoder、video encoder）、视频处理模块（video process）；

操作系统层：MPP的运行平台；

应用层：MPP层通过MPI对接各种中间件软件，如ffmpeg、gstreamer；

**3、编译安装**

源代码下载地址：[https://github.com/rockchip-linux/mpp](https://github.com/rockchip-linux/mpp)

下载命令：`git clone -b release https://github.com/rockchip-linux/mpp.git`

MPP源代码编译脚本为cmake，建议使用2.8.12。首先配置build/linux/arm/目录下arm.linux.cross.cmake里的工具链，再运行make-Makefiles.bash脚本，通过cmake生成Makefile，最后make即可。

**4、使用测试**

**编码器：**

编码器demo为mpi_enc_test系列程序，包括单线程mpi_enc_test，多实例mpi_enc_multi_test。

进入到mpp/test文件夹，直接运行mpi_enc_test：

![img](https://img2018.cnblogs.com/blog/1279278/201812/1279278-20181209132420082-2039680600.png)

-i：输入文件；

-o：输出文件；

-w：图像宽度（强制要求参数）；

-h：图像高度（强制要求参数）；

-f：输入文件类型；

-t：输出码流类型（强制要求参数）；

-n：编码帧数；

**解码器：**

解码器为mpi_dec_test系列程序，包括单线程的mpi_dec_test，多线程的mpi_dec_mt_test，多实例的mpi_dec_multi_test。

直接运行mpi_dec_test：

![img](https://img2018.cnblogs.com/blog/1279278/201812/1279278-20181209133620665-1166516497.png)

-i：输入文件（强制要求参数）；

-o：输出文件；

-w：图像宽度；

-h：图像高度；

-t：码流类型（强制要求参数）；

-f：输出帧类型；

-n：输出帧数；

**其它工具：**

mpp_info_test：读取和打印MPP库的版本信息。

mpp_buffer_test：测试内核的内存分配器是否正常。

mpp_mem_test：测试C库的内存分配器是否正常。

mpp_runtime_test：测试一些软硬件运行时环境是否正常。

mpp_platform_test：读取和测试芯片平台信息是否正常。

 

关山难越，谁悲失路之人； 萍水相逢，尽是他乡之客。



分类: [MPP](https://www.cnblogs.com/xue0708/category/1356736.html)

标签: [媒体处理、编解码](https://www.cnblogs.com/xue0708/tag/媒体处理、编解码/)