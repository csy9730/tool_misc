# MIPI自学笔记

[![IEEE1364](https://pic3.zhimg.com/d859faa3b38799fa85b5644f48352063_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/tao-guan-fu)

[IEEE1364](https://www.zhihu.com/people/tao-guan-fu)

人在江湖身不由己



228 人赞同了该文章

## **前言**

经常听到MIPI这个接口，并且在实际的摄像头项目中也用到了，但是每次去网上搜关于MIPI的资料的时候总是觉得特别混乱，看了网上挺多资料，也没屡清楚这个接口到底是怎么回事，所以对看到的资料加以整理和删减，抓住主线，终于觉得看的稍微懂了一些。考虑到最近忙于工作，专栏荒废，于是自己做的笔记添加一些自己的语句，写成一篇文章，滥竽充数一番。

为了保证主线清晰，本文只介绍了CSI、D-PHY主线，如果你想了解其他更多信息，可以以本文最后扩展阅读链接为入口，找到你要的信息。

## **一、名词解释**

MIPI（移动行业处理器接口）是Mobile Industry Processor Interface的缩写。MIPI是MIPI联盟发起的为移动应用处理器制定的开放标准。

目的是把手机内部的接口如摄像头、显示屏接口、射频/基带接口等标准化，从而减少手机设计的复杂程度和增加设计灵活性。

## **二、技术标准**

MIPI并不是一个单一的接口或协议，而是包含了一套协议和标准，以满足各种子系统独特的要求。MIPI的标准异常复杂，包含非常多的应用领域。下图是其目前的整个的系统框图。

![img](https://pic4.zhimg.com/80/v2-c9f61a2ac741022990a5e6fa61b698b3_720w.jpg)

目前MIPI的标准主要包含下面六大领域：

Physical layer

Multimedia

Chip-to-chip or interprocessor communications (IPC)

Control/data

Debug/trace and software

我们主要关注和学习多媒体这个类下面的标准。其技术标准包含以下内容。

![img](https://pic3.zhimg.com/80/v2-9d48185c42434ee1f214eae8b2a44c32_720w.jpg)

主要分为三层：应用层、协议层和物理层。应用于摄像头、显示器等设备的接口。其中摄像头接口CSI(Camera Serial Interface)、显示接口DSI(Display Serial Interface)是我们关注和学习的重点。CSI和DSI结构很像，以摄像头接口CSI为学习主线，这样可以保证逻辑清晰。

## **三、技术细节**

**3.1 CSI概述**

CSI协议分为三层：

1.应用层(ApplicationLayer),主要描述了上层数据流中的数据编码和解析。CSI-2 规范中规定了像素数据到字节的映射（Mappingof pixel values to bytes）。

2.协议层(Protocol Layer),包含了几个不同的子层，每个子层都有各自的明确职责。主要包括，像素/字节打包/解包层（Pixel/Byte Packing/UnpackingLayer），Low Level Protocol Layer(LLP)，通道管理（LaneManagement）层。

3.物理层(PHYLayer),定义了传输介质 (electrical conductors，导体),输入/输出电路信号的电气特性（electricalparameters）和时钟机制（时序）。即如何从串行位流(Bit Stream)中获取“0”和“1”信号。规范中的这一部分记录了传输介质的特性，并依据时钟和数据通道之间发信号和产生时钟的关系规定了电学参数。

CSI分为CSI2和CSI3。他们的组成如下图：

![img](https://pic3.zhimg.com/80/v2-e92b842057768699a91db69c1f98e766_720w.jpg)

我们只看相对更为常见的CSI2。CSI2的物理又两个标准，C-PHY和D-PHY。在DSI里面，物理层也会用到D-PHY，所以接下来的学习中我们只看D-PHY。

**3.2物理层协议之D-PHY**

本节主要参考 MIPI® Alliance Specification for D-PHY，version 1.1

**3.2.1Lane模块**

介绍D_PHY之前，先讲清楚什么是Lane这个概念。

Lane的原意是“航道”，我们可以理解为在两个不同芯片之间完成信息运输的通道。这是MIPI里面的基本信息传输单元。两块使用MIPI连接的芯片，中间使用差分信号对进行连接，收发端各有一个Lane模块，完成数据收发。Lane模块，加上中间的连线，组成了完整的数据数据传输通道。在复杂的通信协议的物理层里面，我们就不能像理解简单协议那样，只看到在两个收发双方之间的连线，而是要更加关注收发芯片里面负责收发的模块，这是整个协议物理层核心。下图就是一个完整的双向数据传输Lane模块（MIPI里面管这个叫Universal Lane ）的示意图：

![img](https://pic2.zhimg.com/80/v2-122ce356191604987a839c1bb81eecad_720w.jpg)

Universal Lane里面有一对高速收发器（HS-TX、HS-RS）、一对低功耗（Low Power）收发器（LP-RX、LP-TX）、低功耗竞争检测器（LP-CD）和Lane的控制逻辑组成。其他类型的lane都是在这个基础做一定的简化，比如单向数据传输通道就只有接收器或者发送器，再比如时钟lane也是只有接收器或者发送器，是的，时钟也是一种lane。

**3.2.2 D_PYH参数**

D-PHY支持三种不同类型的数据通道:单向时钟通道，单向数据通道和双向数据通道。

D-PHY采用1对源同步的差分时钟和1～4对差分数据线来进行数据传输。数据传输采用DDR方式，即在时钟的上下边沿都有数据传输。

![img](https://pic2.zhimg.com/80/v2-33ba6ec77690cfd4ccbdbf21ab72207d_720w.jpg)

由于Lane有高速和低功耗两种收发器，所以D-PHY的物理层支持HS(HighSpeed)和LP(Low Power)两种工作模式。HS模式下采用低压差分信号，功耗较大，但是可以传输很高的数据速率（数据速率为80M～1Gbps），支持100mV到300mV的电压范围；LP模式下采用单端信号，数据速率很低（<10Mbps），但是相应的功耗也很低，支持0V到1.2V信号电平。两种模式的结合保证了MIPI总线在需要传输大量数据（如图像） 时可以高速传输，而在不需要大数据量传输时又能够减少功耗。下图是HS和LP模式下的信号电平示意图。

![img](https://pic3.zhimg.com/80/v2-52278ccc1cc8044f908c22c484a6339e_720w.jpg)

简单总结一下，D-PHY的物理层参数如下表中间列所示：

![img](https://pic3.zhimg.com/80/v2-740cbc5d2c387a12886e39b34b9cdca6_720w.jpg)

**3.2.3 D-PHY操作模式**

> 这部分有点复杂，硬件狗基本可以跳过

数据Lane的三种操作模式，在高速传输的时候叫 Burst Mode，在低功耗模式下有Control mode和Escape mode。在正常的操作时，数据通道处于高速模式或者控制模式。

接下来就分别说明这三种模式：

**1.高速模式（Burst Mode）**

高速模式最主要的模式，用来传输图像。在高速模式下，通道状态是差分的0或者1，也就是线对内P比N高时，定义为1，P比N低时，定义为0，此时典型的线上电压为差分200MV。下面展示了Burst模式下的传输时序。

![img](https://pic2.zhimg.com/80/v2-8c4d9ddfab3fcbe0aca3469d5d560ec9_720w.jpg)

**2.控制模式（Control mode）**

在控制模式下，高电平典型幅值为1.2V，此时P和N上的信号不是差分信号而是相互独立的，当P为1.2V，N也为1.2V时，MIPI协议定义状态为LP11，同理，当P为1.2V，N为0V时，定义状态为LP10，依此类推，控制模式下可以组成LP11，LP10，LP01，LP00四个不同的状态。

MIPI协议规定控制模式4个不同状态组成的不同时序代表着将要进入或者退出高速模式等；比如LP11-LP01-LP00序列后，进入高速模式。

**3.逃避模式（Escape mode）**

Escape mode是数据Lane在LP状态下的一种特殊操作。在这种模式下，可以进入一些额外的功能：LPDT, ULPS(超低功耗状态), Trigger。一旦进入Escape mode模式，发送端必须发送1个8-bit的命令来响应请求的动作。

Lane的各个模式列举如下表:

![img](https://pic4.zhimg.com/80/v2-f684a52e40ddb031c5428c0ca3c62dcf_720w.jpg)

Lane的各个状态转换关系如下图：

![img](https://pic3.zhimg.com/80/v2-426e22f155cd9d675d668a6239211ef2_720w.jpg)

**3.2.4 MIPI电路设计**

**a.信号规范**

MIPI的走线有多对差分对组成，要求差分阻抗100欧，50欧的单端阻抗。在共模模式下（就是前面提到的LP11,LP00）要求各自25欧（这一点其实没搞懂）。

在高速传输时，直流和交流的spec如下表：

![img](https://pic3.zhimg.com/80/v2-2093358a9f98b299d94c0ad4290709fa_720w.jpg)

![img](https://pic1.zhimg.com/80/v2-bfcf6c22affdbb8bf636e075e585d1b0_720w.jpg)

在低功耗模式下

![img](https://pic2.zhimg.com/80/v2-79a411a8066a31084e3e0318d06933d9_720w.jpg)

**b. D-PHY Layout**

1.等长

MIPI因为一种高速差分信号的[接口](https://link.zhihu.com/?target=http%3A//www.hqchip.com/app/1039)，为了保证信号的同步和一致性，必须保证MIPI DP/DN保持等长，无论是线对与线对之间（pair to pair)还是单组信号的DP/DN之间，一般需要遵守的长度规则如下：

camera pair to pair 100mil 单组之间：25mil

LCD pair to pair 200mil 单组之间 60mil

> 说明：
> 我其实并没有看到物理层的规范对等长的具体要求，这里只是参考网上的资料

2.等距

在MIPI走线时，一般需要保持DP/DN在走线的过程中保持等距，保证一定的耦合程度，但是需要弄清楚的时，等长的优先级是高于等距的。且在走线时，线对之间要保持2W的距离。

3.参考层

MIPI走线应该保持连续的参考层，且最好是地层，如果这个条件实在无法满足的话，必须保证参考层的宽度可以达到4W， 且为了防止ESD以及干扰等因素，MIPI走线最好走内层。

4.打孔换层

MIPI尽量少打过孔，且必须注意的时，在打孔换层的时候必须DP/DN同时打孔换层，同时在周围多打地孔，保证信号的回流；

5.远离干扰

远离RF以及开关电源等干扰源

6.传输线阻抗要求

MIPI具有阻抗的要求，一般需要达到差分阻抗为100ohm；

**3.3 CSI-2协议层**

CSI-2协议层允许多数据流 (CSI-2 TX)共用一个主机处理器端 CSI-2 接收信号接口 （CSI-2 RX）。协议层就可以描述有多少数据流被标记并组合在一起,指定了多数据流怎样被标记和交叉存取，因此每个数据流可以在SOC处理器CSI-2接收器中被正确的重建，才能把各个数据流正确地恢复出来。

**1.像素/字节打包/解包层（Pixel/Byte Packing/UnpackingLayer）**

CSI-2支持多种像素格式图像应用，包括从6位到24位每个像素的数据格式。在发射端，数据由本层被发送到LLP层（Low Level Protocol）前，本层将应用层传来的数据由像素打包成字节数据；在接收端，执行相反过程，将LLP层发来的数据解包，由字节转成像素，然后才发送到应用层。8位每像素的数据在本层被传输时不会被改变。

**2.LLP（Low LevelProtocol）层**

LLP层包括，为串行数据在传输开始（SoT）到传输结束（EoT）之间传输事件，和传输数据到下一层，建立位级和字节级同步的方法。LLP最小数据粒度是一字节。LLP层也包括，每字节中各位数值分布解释，即“端”（Endian）分布。

**3.通道管理（LaneManagement）层**

为性能不断提升，CSI-2是通道可扩展的。数据通道数目可以是1，2，3，4，这个依赖于应用中的带宽需求。接口发送端分配（“distributor”功能）输出数据流到一个或更多通道。在接收端，接口从通道收集字节并将之合并（“merger”功能）成为重新组合的数据流，恢复原始数据流序列。

数据在协议层是以数据包的形式存在。在接口发送端，添加包头和可选择的错误校验信息，一起以数据包的形式通过LLP层来传输数据。在接收端，LLP层将包头剥离，由接收者按照相应逻辑解析数据包，得到有效数据。错误校验信息可以用来检测收到的数据完整性。

## **四、技术扩展**

**4.1 DSI简介**

**4.1.1 名词解释**

DCS (DisplayCommandSet)：DCS是一个标准化的命令集，用于命令模式的显示模组。

• DSI, CSI(DisplaySerialInterface, CameraSerialInterface)

• DSI 定义了一个位于处理器和显示模组之间的高速串行接口。

• CSI 定义了一个位于处理器和摄像模组之间的高速串行接口。

• D-PHY：提供DSI和CSI的物理层定义

**4.1.2 DSI分层结构**

DSI分四层，对应D-PHY、DSI、DCS规范、分层结构图如下：
• PHY 定义了传输媒介，输入/输出电路和和时钟和信号机制。
• Lane Management层：发送和收集数据流到每条lane。
• Low Level Protocol层：定义了如何组帧和解析以及错误检测等。
• Application层：描述高层编码和解析数据流。

![img](https://pic3.zhimg.com/80/v2-6d778d6241abe9a828b3b6ff894b73c2_720w.jpg)

**4.1.3 Command和Video模式**
• DSI兼容的外设支持Command或Video操作模式，用哪个模式由外设的构架决定
• Command模式是指采用发送命令和数据到具有显示缓存的控制器。主机通过命令间接的控制外设。Command模式采用双向接口
• Video模式是指从主机传输到外设采用时实象素流。这种模式只能以高速传输。为减少复杂性和节约成本，只采用Video模式的系统可能只有一个单向数据路径

## **五、参考来源**



MIPI官网







欢迎大家关注我的知乎专栏《**电子工程师有多无聊**》

有钱的大爷，麻烦您顺道打个赏钱！

编辑于 2019-11-19

软件接口

接口设计

软件接口设计

赞同 228