# 一文理解 YUV

[![贾小昆](https://pica.zhimg.com/v2-baa03c62e935fd7b0f84f252fafd08f8_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/zywu-43)

[贾小昆](https://www.zhihu.com/people/zywu-43)



万物之中，希望至美。



120 人赞同了该文章

一般的视频采集芯片输出的码流一般都是 YUV 格式数据流，后续视频处理也是对 YUV 数据流进行编码和解析。所以，了解 YUV 数据流对做视频领域的人而言，至关重要。

在介绍 YUV 格式之前，首先介绍一下我们熟悉的 RGB 格式。

## **RGB**

RGB 分别表示红（R）、绿（G）、蓝（B），也就是三原色，将它们以不同的比例叠加，可以产生不同的颜色。

比如一张 1920 * 1280 的图片，代表着有 1920 * 1280 个像素点。如果采用 RGB 编码方式，每个像素点都有红、绿、蓝三个原色，其中每个原色占用 8 个字节，每个像素占用 24 个字节。

那么，一张 1920 * 1280 大小的图片，就占用 1920 * 1280 * 3 / 1024 / 1024 = 7.03MB 存储空间。

## **YUV**

YUV 编码采用了明亮度和色度表示每个像素的颜色。

其中 Y 表示明亮度（Luminance、Luma），也就是灰阶值。

U、V 表示色度（Chrominance 或 Chroma），描述的是色调和饱和度。

YCbCr 其实是 YUV 经过缩放和偏移的翻版。其中 Y 与 YUV 中的 Y 含义一致,Cb,Cr 同样都指色彩，只是在表示方法上不同而已。YCbCr 其中 Y 是指亮度分量，Cb 指蓝色色度分量，而 Cr 指红色色度分量。

## **YUV 优点**

对于 YUV 所表示的图像，Y 和 UV 分量是分离的。如果只有 Y 分量而没有 UV 分离，那么图像表示的就是黑白图像。彩色电视机采用的就是 YUV 图像，**解决与和黑白电视机的兼容问题，使黑白电视机也能接受彩色电视信号**。

人眼对色度的敏感程度低于对亮度的敏感程度。主要原因是视网膜杆细胞多于视网膜锥细胞，其中视网膜杆细胞的作用就是识别亮度，视网膜锥细胞的作用就是识别色度。所以，眼睛对于亮度的分辨要比对颜色的分辨精细一些。

利用这个原理，可以把色度信息减少一点，人眼也无法查觉这一点。

所以，并不是每个像素点都需要包含了 Y、U、V 三个分量，根据不同的采样格式，可以每个 Y 分量都对应自己的 UV 分量，也可以几个 Y 分量共用 UV 分量。**相比 RGB，能够节约不少存储空间。**

## **YUV 采样格式**

YUV 图像的主流采样方式有如下三种：

- YUV 4:4:4 采样
- YUV 4:2:2 采样
- YUV 4:2:0 采样

### **YUV 4:4:4**

YUV 4:4:4 表示 Y、U、V 三分量采样率相同，即每个像素的三分量信息完整，都是 8bit，每个像素占用 3 个字节。

如下图所示：



![img](https://pic3.zhimg.com/80/v2-a210bb73a7e4d9abfc84716798aab63e_720w.jpg)



```java
四个像素为： [Y0 U0 V0] [Y1 U1 V1] [Y2 U2 V2] [Y3 U3 V3]
采样的码流为： Y0 U0 V0 Y1 U1 V1 Y2 U2 V2 Y3 U3 V3
映射出的像素点为：[Y0 U0 V0] [Y1 U1 V1] [Y2 U2 V2] [Y3 U3 V3]
```

可以看到这种采样方式与 RGB 图像大小是一样的。

### **YUV 4:2:2**

YUV 4:2:2 表示 UV 分量的采样率是 Y 分量的一半。

如下图所示：

![img](https://pic4.zhimg.com/80/v2-a99ba29d8f672a04128e98fd8be847ab_720w.jpg)

```java
四个像素为： [Y0 U0 V0] [Y1 U1 V1] [Y2 U2 V2] [Y3 U3 V3]
采样的码流为： Y0 U0 Y1 V1 Y2 U2 Y3 U3
映射出的像素点为：[Y0 U0 V1]、[Y1 U0 V1]、[Y2 U2 V3]、[Y3 U2 V3]
```

其中，每采样一个像素点，都会采样其 Y 分量，而 U、V 分量都会间隔采集一个，映射为像素点时，第一个像素点和第二个像素点共用了 U0、V1 分量，以此类推。从而节省了图像空间。

比如一张 1920 * 1280 大小的图片，采用 YUV 4:2:2 采样时的大小为：

> (1920 * 1280 * 8 + 1920 * 1280 * 0.5 * 8 * 2 ) / 8 / 1024 / 1024 = 4.68M

可以看出，比 RGB 节省了三分之一的存储空间。

### **YUV 4:2:0**

YUV 4:2:0 并不意味着不采样 V 分量。它指的是对每条扫描线来说，只有一种色度分量以 2:1 的采样率存储，相邻的扫描行存储不同的色度分量。也就是说，如果第一行是 4:2:0，下一行就是 4:0:2，在下一行就是 4:2:0，以此类推。

如下图所示：

![img](https://pic3.zhimg.com/80/v2-6811dfa7e2f914eee232b490a496e80e_720w.jpg)

```java
图像像素为：
[Y0 U0 V0]、[Y1 U1 V1]、 [Y2 U2 V2]、 [Y3 U3 V3]
[Y5 U5 V5]、[Y6 U6 V6]、 [Y7 U7 V7] 、[Y8 U8 V8]

采样的码流为：
Y0 U0 Y1 Y2 U2 Y3 
Y5 V5 Y6 Y7 V7 Y8

映射出的像素点为：
[Y0 U0 V5]、[Y1 U0 V5]、[Y2 U2 V7]、[Y3 U2 V7]
[Y5 U0 V5]、[Y6 U0 V5]、[Y7 U2 V7]、[Y8 U2 V7]
```

其中，每采样一个像素点，都会采样 Y 分量，而 U、V 分量都会隔行按照 2:1 进行采样。

一张 1920 * 1280 大小的图片，采用 YUV 4:2:0 采样时的大小为：

> (1920 * 1280 * 8 + 1920 * 1280 * 0.25 * 8 * 2 ) / 8 / 1024 / 1024 = 3.51M

相比 RGB，节省了一半的存储空间。

## **YUV 存储格式**

YUV 数据有两种存储格式：平面格式（planar format）和打包格式（packed format）。

- planar format：先连续存储所有像素点的 Y，紧接着存储所有像素点的 U，随后是所有像素点的 V。
- packed format：每个像素点的 Y、U、V 是连续交错存储的。

因为不同的采样方式和存储格式，就会产生多种 YUV 存储方式，这里只介绍基于 YUV422 和 YUV420 的存储方式。

### **YUYV**

YUYV 格式属于 YUV422，采用打包格式进行存储，Y 和 UV 分量按照 2:1 比例采样，每个像素都采集 Y 分量，每隔一个像素采集它的 UV 分量。

> Y0 U0 Y1 V0 Y2 U2 Y3 V2

Y0 和 Y1 共用 U0 V0 分量，Y2 和 Y3 共用 U2 V2 分量。

### **UYVY**

UYVY 也是 YUV422 采样的存储格式中的一种，只不过与 YUYV 排列顺序相反。

> U0 Y0 V0 Y1 U2 Y2 V2 Y3

### **YUV 422P**

YUV422P 属于 YUV422 的一种，它是一种 planer 模式，即 Y、U、V 分别存储。

### **YUV420P 和 YUV420SP**

YUV420P 是基于 planar 平面模式进行存储，先存储所有的 Y 分量，然后存储所有的 U 分量或者 V 分量。

![img](https://pic3.zhimg.com/80/v2-cb7e35268a89e09d2ca7b75a383d03b2_720w.jpg)

同样，YUV420SP 也是基于 planar 平面模式存储，与 YUV420P 的区别在于它的 U、V 分量是按照 UV 或者 VU 交替顺序进行存储。

![img](https://pic3.zhimg.com/80/v2-ab706465d4a728f68c29946c04a7fa02_720w.jpg)

### **YU12 和 YU21**

YU12 和 YV12 格式都属于 YUV 420P 类型，即先存储 Y 分量，再存储 U、V 分量，区别在于：YU12 是先 Y 再 U 后 V，而 YV12 是先 Y 再 V 后 U 。

### **NV21 和 NV21**

NV12 和 NV21 格式都属于 YUV420SP 类型。它也是先存储了 Y 分量，但接下来并不是再存储所有的 U 或者 V 分量，而是把 UV 分量交替连续存储。

NV12 是 IOS 中有的模式，它的存储顺序是先存 Y 分量，再 UV 进行交替存储。

NV21 是 安卓 中有的模式，它的存储顺序是先存 Y 分量，在 VU 交替存储。

## **YUV 与 RGB 转换**

YUV 与 RGB 之间的转换，就是将 图像所有像素点的 R、G、B 分量和 Y、U、 分量相互转换。

有如下转换公式：

![img](https://pic3.zhimg.com/80/v2-5cadb349c867fb8c1fcdebc2081bdcea_720w.jpg)

![img](https://pic3.zhimg.com/80/v2-7cb7c3b35a16cf92039f455e3eb88582_720w.jpg)

## **参考**

[https://zh.wikipedia.org/wiki/YUV](https://link.zhihu.com/?target=https%3A//zh.wikipedia.org/wiki/YUV)

[https://glumes.com/post/ffmpeg/understand-yuv-format/](https://link.zhihu.com/?target=https%3A//glumes.com/post/ffmpeg/understand-yuv-format/)

[https://blog.csdn.net/MrJonathan/article/details/17718761](https://link.zhihu.com/?target=https%3A//blog.csdn.net/MrJonathan/article/details/17718761)

[http://www.fourcc.org/pixel-format/yuv-i420/](https://link.zhihu.com/?target=http%3A//www.fourcc.org/pixel-format/yuv-i420/)

[https://msdn.microsoft.com/zh-cn/library/ms867704.aspx](https://link.zhihu.com/?target=https%3A//msdn.microsoft.com/zh-cn/library/ms867704.aspx)

编辑于 2020-11-19

音视频

Android

赞同 120