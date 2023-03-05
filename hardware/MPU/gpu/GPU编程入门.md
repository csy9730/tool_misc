# GPU编程入门

[![Keepin](https://pic4.zhimg.com/v2-331087a42dec3682e7cdc1d688897661_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/lovely-65-92)

[Keepin](https://www.zhihu.com/people/lovely-65-92)

GPU高性能计算



12 人赞同了该文章

> 最近有人问我关于GPU编程入门开发的一些问题，由于本人更多从事的是HPC的高性能优化事项，因此对于GPU编程还是比较熟悉的。大学期间并没有高性能或者类似于异构开发的经验，毕业后第一份工作需要，而学习了OpenGLES开始入门GPU编程，算是对自学OpenGLES开发有一些经验，因此就在此整理下GPU编程入门的一些注意点以及个人觉得不错的小技巧

## **一、GPU编程**

最初GPU是一个图形专用的加速器，从早期的2D加速到3D加速，从专用图形加速到通用计算，GPU的功能越来越强大。由于GPU涉及到很多的图形相关技术，并不是抽象出几个简单的接口就能满足业务开发需求，因此比较主流的是一些标准化的编程接口。例如OpenGL/ES、OpenCL、vulkan、directx、cuda、metal等API。这些API可以认为是一种工业标准。每个厂商胜场的GPU都会根据自身的应用场景与技术竞争力去支持这些API中的一个或者多个。因此想要做GPU编程，首先需要了解至少一个编程API。

## **二、编程API选择**

OpenGL/ES，这里指的是OpenGL和OpenGLES。OpenGLES是OpenGL的嵌入式端版本，主要用于嵌入式端设备，手机也可以归入到嵌入式设备。对于与选择OpenGL开发的话，因此如果选择的开发平台是嵌入式设备的话，选择OpenGLES，如果选择PC端开发的话就选择OpenGL。类似于高通、联发科、海思的平台都对OpenGLES的支持很到位。苹果的ios早期对OpenGLES支持也很好，不过随着苹果重新设计了一套GPU编程API即metal，OpenGLES在IOS上已经慢慢被遗弃，官方不在原声支持，虽然有第三方的SDK，但是如果做高性能优化，已经不再是首选了。

OpenCL，这个编程API是苹果贡献的，是一个专门用于通用计算的GPU编程API，个人认为OpenCL作为通用计算加速的GPU开发API算是比较简单容易上手的。而且kernel采用的主要是c和c++开发（用c就完全满足了）。c基本是大学的必修课了，因此也很容易上手。不过可能是因为OpenCL是苹果贡献的原因，而且苹果还拥有OpenCL的一些商标版权，因此谷歌生产的安卓手机统一没有OpenCL，如果要用OpenCL需要到高通的开发者网站下载一些支持包。

vulkan，vulkan是新的API，以后很有可能在会替代OpenGL成为GPU开发的主流编程API（当然苹果系列的产品可能并不是最好的方式，对于用能力的公司，安卓机用vulkan，苹果机器用metal，微软的机器用directx或者cuda）。

directx，是微软的一套编程API标准，主要用于pc端。对于pc端游戏开发，选择这个API更合适。

cuda是英伟达的一套开发套件，主要用c来开发。对于选择英伟达GPU的情况，可以选择cuda开发。

metal是苹果针对自家产品设计的一套API，相对来说，初学者还是不建议直接上手metal，而且metal也算是比较新的API，能找到的资料也不如其他API。

综上，对于初学者来说，可以根据需要做一些选择。

## 三、入门的简单案例

对于入门最好的方式就是找一些资料和测试案例来入手，然后根据需要做一些修改，来实现入门的目的。当然最好选择见到易懂的小项目，这里主要列举几个本人用过的测试案例，也还算是比较简单易懂的。

1、安卓端和OpenGLES：测试案例可以选择[https://github.com/learnopengles/Learn-OpenGLES-Tutorials](https://github.com/learnopengles/Learn-OpenGLES-Tutorials)，[https://github.com/ARM-software/opengl-es-sdk-for-android](https://github.com/ARM-software/opengl-es-sdk-for-android)

2、安卓端和OpenCL：OpenCL相对来说资料会少一些，目前一些卷积神经网络推理框架也选择OpenCL，但是总体较为复杂，所以我推荐下载高通的Adreno GPU SDK，内置有几个opencl的测试案例。不过需要先注册账号，然后选择下载Adreno GPU SDK

3、vulkan：[https://github.com/LunarG/VulkanSamples](https://github.com/LunarG/VulkanSamples)，这个支持的平台还比较多，不过为了测试方便，建议直接用ubuntu算是比较方便的了

一些基础的话也可以查看相关的官方资料，特别的OpenGLES可以找一本叫做OpenGLES中文指南的文档，对入门也很有帮助：

OpenGLES,[https://www.khronos.org/opengles/resources](https://www.khronos.org/opengles/resources)

OpenCL,[https://www.khronos.org/opencl/resources](https://www.khronos.org/opencl/resources)

Vulkan,[https://www.khronos.org/vulkan/](https://www.khronos.org/vulkan/)