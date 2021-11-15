# ARM CMSIS标准概述及快速入门
[许豆](https://www.zhihu.com/people/xu-dou-61)

专注嵌入式软硬件开发~



16 人赞同了该文章

CMSIS的创建是为了帮助行业实现标准化，减少了客户学习曲线，开发成本，缩短产品上市时间。

再来看看CMSIS是什么，有哪些工具提供及快速入门~

CMSIS：（Cortex Microcontroller Software Interface Standard）翻译成中文就是ARM Cortex 微控制器/处理器软件接口标准。

CMSIS基于Arm Cortex处理器的微控制器的独立于供应商的硬件抽象层（英文原文为：a vendor-independent hardware abstraction layer for microcontrollers that are based on Arm® Cortex® processors. --来自ARM官网）

CMSIS提供了到处理器（Cortex M,Cortex A5/A7/A9）和外围设备，实时操作系统和中间件组件的接口，以下图表为CMSIS提供的组件。

![img](https://pic1.zhimg.com/80/v2-f6406a69f7457b6a52256e83e6fbbc68_720w.jpg)

比如CMSIS-NN用于在Cortex M上进行**神经网络学习，CMSIS-**RTOSv1用于实时操作系统的通用API以及基于RTX的参考实现，**CMSIS-**Core（M）用于Cortex-M处理器内核和外围设备的标准化API。

![img](https://pic2.zhimg.com/80/v2-70c47a706f708990fb45e13bf469b0d1_720w.jpg)

Arm根据Apache 2.0许可免费提供CMSIS 。

CMSIS 标准中最主要的为**CMSIS-Core（M）层**，它包括了：

**内核函数层**：其中包含用于访问内核寄存器的名称、地址定义，主要由 ARM 公司提供。

**设备外设访问层**：提供了片上的核外外设的地址和中断定义，主要由芯片生产商提供。可见 CMSIS 层位于硬件层与操作系统或用户层之间，提供了与芯片生产商无关的硬件抽象层，可以为接口外设、实时操作系统提供简单的处理器软件接口，屏蔽了硬件差异，这对软件的移植是有极大的好处的。

以下ARM :: CMSIS目录中存在与CMSIS-Core（Cortex-M）相关的文件：

![img](https://pic2.zhimg.com/80/v2-f7de1ff8a919bfcc81becff1323a64fd_720w.png)

基于每个组件的详细应用以及示例程序可参考以下链接。

[Overviewarm-software.github.io/CMSIS_5/Core/html/index.html](https://arm-software.github.io/CMSIS_5/Core/html/index.html)

参考资料：

[https://developer.arm.com/tools-and-software/embedded/cmsis](https://developer.arm.com/tools-and-software/embedded/cmsis)

[https://github.com/ARM-software/CMSIS_5](https://github.com/ARM-software/CMSIS_5)

[https://arm-software.github.io/CMSIS_5/General/html/index.html](https://arm-software.github.io/CMSIS_5/General/html/index.html)

编辑于 2019-10-07

ARM

嵌入式开发

嵌入式系统

赞同 16