# OpenVG

本词条缺少**概述图**，补充相关内容使词条更完整，还能快速升级，赶紧来编辑吧！

OpenVG（全写Open Vector Graphics），OpenVG™ 是针对诸如Flash和SVG的矢量图形算法库提供底层[硬件加速](https://baike.baidu.com/item/硬件加速/5702432)界面的免授权费、跨平台应用程序接口API。OpenVG 现仍处于发展阶段，其初始目标主要面向需要高质量矢量图形算法加速技术的便携手持设备，用以在小屏幕设备上实现动人心弦的用户界面和文本显示效果，并支持硬件加速以在极低的处理器功率级别下实现流畅的交互性能。





- 中文名

  [矢量](https://baike.baidu.com/item/矢量)图形[算法](https://baike.baidu.com/item/算法)标准

- 外文名

  Open Vector Graphics

- 简    写

  OpenVG

- 领    域

  计算机

## 目录

1. 1 [名词解释](https://baike.baidu.com/item/OpenVG/7922699#1)
2. 2 [来历](https://baike.baidu.com/item/OpenVG/7922699#2)
3. 3 [优缺点](https://baike.baidu.com/item/OpenVG/7922699#3)
4. ▪ [优点](https://baike.baidu.com/item/OpenVG/7922699#3_1)
5. ▪ [缺点](https://baike.baidu.com/item/OpenVG/7922699#3_2)
6. 4 [模块组成](https://baike.baidu.com/item/OpenVG/7922699#4)



## 名词解释

OpenVG 是针对诸如

Flash

和

SVG

的

矢量

图形

算法

库提供底层硬件支持界面的免授权费、跨平台

应用程序接口

API

。OpenVG 现仍处于发展阶段，其初始目标主要面向需要高质量

矢量

图形

算法

技术的便携手持设备，用以在小屏幕设备上实现动人心弦的用户界面和文本显示效果，并支持硬件实现，这样可以在在极低的处理器功率级别下实现流畅的交互性能。通常在640x480的显示分辨率上都可以达到最好的效果。

[![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAMAAAAoyzS7AAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAAZQTFRF9fX1AAAA0VQI3QAAAAxJREFUeNpiYAAIMAAAAgABT21Z4QAAAABJRU5ErkJggg==)](https://baike.baidu.com/pic/OpenVG/7922699/0/3853ad1b8ffc4e058718bf6f?fr=lemma&ct=single)



## 来历

在过去，由于[嵌入式](https://baike.baidu.com/item/嵌入式/575465)系统上并没有绘制2D[矢量](https://baike.baidu.com/item/矢量)图形的统一规格，因此在创作2D矢量图形的相关内容时，各家业者（如：[Adobe](https://baike.baidu.com/item/Adobe)、Macromedia）都会开发[自己](https://baike.baidu.com/item/自己/32946)专属的2D API来进行底层的绘制。这样的作法必须仰赖CPU进行大量的运算，对电力的消耗是一大考验；再者，当开发者欲移植到不同的平台时，可能又得多花一份力气。有鉴于此，2004年第四季，Khronos组织首先提出适合于硬体加速(hardware-accelerated)的2D[矢量](https://baike.baidu.com/item/矢量)图形处理标准函式库—OpenVG。

OpenVG规格由Khronos组织所主导，结合多家行动装置大厂及图学组织，包括[Nokia](https://baike.baidu.com/item/Nokia)、[Motorola](https://baike.baidu.com/item/Motorola)、Bitboys、Hybrid Graphics、[Symbian](https://baike.baidu.com/item/Symbian)、[Sun](https://baike.baidu.com/item/Sun) Microsystems、3Dlabs等公司，目标在于规范适合[嵌入式系统](https://baike.baidu.com/item/嵌入式系统)上简单、轻便且低阶的2D[矢量](https://baike.baidu.com/item/矢量)图形绘图功能。藉由公开、标准、统一的规格，不但硬体制造商可依据其规格设计出2D[矢量](https://baike.baidu.com/item/矢量)图形硬体加速器，同时也能加快2D矢量图形展现技术与硬体加速器垂直整合的速度。说穿了，OpenVG的目的就是在提供硬体抽象层，达到跨平台的功能，使得使用OpenVG APIs开发的应用程式，在不同平台执行时，皆可取得2D[矢量](https://baike.baidu.com/item/矢量)图形硬体加速的功能。



## 优缺点



### 优点

可以在较低的CPU频率下实现较好的效果, 大部分[flash](https://baike.baidu.com/item/flash)运算都由HW完成.即使主CPU不到100Mhz，也有可能播放swf文件。

如果可以搭配2D[矢量](https://baike.baidu.com/item/矢量)图形展现模块, 减少HW加速受限于[主频](https://baike.baidu.com/item/主频)的影响,效果更好。



### 缺点

因为是标准[算法](https://baike.baidu.com/item/算法)，对内存的需求较高，内存越大，效果越好，内存较小时可能会有限制，建议最小64M DRAM。



## 模块组成

\1. Coordinate Systems and Transformations (Image drawing uses a 3x3 perspective transformation matrix)

\2. Paths

\3. Images

\4. Image Filters

\5. Paint (gradient and pattern)

\6. Blending and Masking

\7. Higher-level Geometric Primitives

\8. Image Warping