# 除了ZYNQ还有哪些内嵌ARM硬核的FPGA？

[![王超](https://picx.zhimg.com/v2-3de9419ade815124f7c1b3f58714fde3_l.jpg?source=172ae18b)](https://www.zhihu.com/people/wangchao149)

[王超](https://www.zhihu.com/people/wangchao149)

43 人赞同了该文章

## 软核和硬核

**内嵌处理器硬核的FPGA**，即SoC FPGA，是在芯片设计之初，就在内部的硬件电路上添加了硬核处理器，是纯硬件实现的，不会消耗FPGA的逻辑资源，硬核处理器和FPGA逻辑在一定程度上是相互独立的，简单的说，就是SoC FPGA就是把一块ARM处理器和一块FPGA芯片封装成了一个芯片。

更多介绍可以查看：[FPGA硬核和软核处理器的区别](https://zhuanlan.zhihu.com/p/136767162)

### 1.Xilinx的ZYNQ-7000系列

Xilinx发明的FPGA颠覆了半导体世界，创立了Fabless（无晶圆厂）的半导体模式。Zynq®-7000 系列集成了 ARM Cortex-A9 处理器，同时具有**ARM软件的可编程性**和**FPGA 的硬件可编程性**，不仅可实现重要分析与硬件加速，同时还在单个器件上高度集成 **CPU、DSP、ASSP 以及混合信号功能**。

ZYNQ芯片内部框图



![img](https://pic4.zhimg.com/80/v2-b51613a53e779504cfd032061a989067_720w.webp)



准确的说，ZYNQ并不能说是一个嵌入式ARM硬核的FPGA，官方对其称呼是**可扩展处理平台**。Zynq-7000可扩展处理平台是采用赛灵思新一代FPGA（Artix-7与Kintex-7FPGA）所采用的同一28nm可编程技术的最新产品系列。可编程逻辑可由用户配置，并通过“互连”模块连接在一起，这样可以提供用户自定义的任意逻辑功能，从而扩展处理系统的性能及功能。



![img](https://pic2.zhimg.com/80/v2-9907c04d640ee886a6d41ea3d00027c5_720w.webp)



ZYNQ芯片资源主要分为两个部分：PL和PS，PL即可编程逻辑部分，指的是FPGA部分。PS即可编程系统部分，指的是ARM处理器部分，两者之间可以通过总线进行通信。对于一个不熟悉FPGA的嵌入式软件工程师来说，完全可以把它当做ARM MPU来使用，使用例程中搭建好的硬件环境，在SDK中开发。如果在进行软件调试时，发现某些算法太慢，速度上不去，可以用FPGA的逻辑部分把这部分进行优化，一般情况下快个一二十倍是没问题的。从FPGA逻辑部分到ARM软件开发，可以完全在Xilinx自家的开发环境里切换。



![img](https://pic4.zhimg.com/80/v2-e3686da5353426492a7d3f297751ceeb_720w.webp)



PYNQ系列是ZYNQ的升级版，简单的理解就是：Python + ZYNQ的意思。至于Python是如何控制硬件的，



![img](https://pic1.zhimg.com/80/v2-c1a57cec0e226f4d1380c6cf223c968c_720w.webp)



有了Python的加持，可以非常方便的进行FPGA开发，可以充分利用Python的灵活性和FPGA的硬件资源，可以简化图像处理和人工智能的算法设计。



![img](https://pic4.zhimg.com/80/v2-4b6d1da7719387b9ce9949dd9c841017_720w.webp)



### 2.Altera的Cyclone V系列

2015年12月，**Intel斥资167亿美元收购了Altera公司** 。作为FPGA市场的二把手，既然Xilinx推出了ZYNQ，那Altera也得跟上老大的脚步啊！相比于Xilinx的SoC FPGA系列，Altera的内嵌ARM硬核的FPGA系列就比较多了，这里我整理了一个表格：



![img](https://pic2.zhimg.com/80/v2-b917c629a1d4248a64a73659297bc4cd_720w.webp)



Altera® Arria® V GT FPGA开发套件，官方售价$3,995



![img](https://pic4.zhimg.com/80/v2-303da929788226528f4ac53c716a1d03_720w.webp)



整体来看，可能是ZYNQ的生态做得比较好，ZYNQ还是挺多资料的，而Altera的SoC FPGA资料不是很多。

### 3.Microsemi的SmartFusion系列

FPGA领域，大家比较熟知的就是以上两个厂商了，不过以上两家主流的FPGA都是基于SRAM工艺的，即芯片外部需要搭配一片SPI Flash用于存储程序，这样就会有一个问题，如果只是进行程序下载而没有进行程序固化，就会导致**掉电数据丢失**的问题，而且由于读写外部器件需要时间，所以**上电不能立刻启动**。而Microsemi的FPGA都是基于Flash结构的，即芯片内部有Flash可以用于程序存储，不用区分程序下载和程序固化，**掉电数据不会丢失**，上电立刻启动。Microsemi的主要市场在医疗机构、军工航空、汽车和工业控制领域。

Microsemi大家可能不太熟悉，说到Microsemi，我们不得不提一下它的历史，最开始Microsemi 是做功率电子器件的，Actel是做基于Flash结构FPGA芯片的，2010年，Microsemi收购了Actel，2018年，Microchip又收购了Microsemi，所以现在的第三大FPGA厂商应该是MicroChip。



![img](https://pic4.zhimg.com/80/v2-29132b053bae44987a0c18feb872d737_720w.webp)



2019 FPGA市场份额占有率 | 数据来源：MRFR



![img](https://pic3.zhimg.com/80/v2-ff4db3d7c8840414f80664d6738038a6_720w.webp)



相比于Xilinx和Altra的FPGA内嵌的ARM Cortex-A系列MPU处理器，Microsemi的FPGA就显得比较LOW了，基于130nm工艺，主要有两个系列SmartFusion和SmartFusion 2，即一代和二代，都是内嵌的ARM Cortex-M3硬核，和**STM32内嵌的是同一个内核**，外设也都是比较常用的，如UART、SPI、IIC、EPROM、RTC等等。所以这个芯片的使用对于有单片机基础的朋友来说，比较**容易上手**。FPGA部分和ARM部分相互独立，可以通过APB总线来进行数据交换。

SmartFusion第一代FPGA内部框图



![img](https://pic4.zhimg.com/80/v2-26294707fb3067bb819b99cd294f3603_720w.webp)



### 总结

可能是Xilinx ZYNQ的生态做得比较好，网络上的工具、文档资料、社区支持、相关书籍支持都很到位，而Altera的资料就不那么好找了。

发布于 2020-04-27 18:51

[现场可编辑逻辑门阵列（FPGA）](https://www.zhihu.com/topic/19570427)

[ARM](https://www.zhihu.com/topic/19553303)

[Altera](https://www.zhihu.com/topic/19603854)