# 半导体功能安全评估之一：理解SoC＋IP

文章来源：企鹅号 - 鲤鱼为蜜粉

[![img](https://ask.qcloudimg.com/raw/yehe-b3360f6a89f75/55moc77uas.png)](https://cloud.tencent.com/act/pro/2023spring?from=19959)

广告[关闭](javascript:;)

[2023新春采购节领8888元新春采购礼包，抢爆款2核2G云服务器95元/年起，个人开发者加享折上折立即抢购](https://cloud.tencent.com/act/pro/2023spring?from=19959)

SoC 的定义：

SoC（System on a Chip）的维基百科词条中有如下解释：

A system on chip is an integrated circuit (also known as a "chip") that integrates all components of a computer or other electronic system. These components always include a central processing unit (CPU), memory, input/output ports and secondary storage – all on a single substrate or microchip, the size of a coin.

从狭义角度讲，SoC是信息系统核心的芯片集成, 是将系统关键部件集成在一块芯片上，一般是指集成了一个完整计算机系统（或者是其他电子系统）的芯片，通常由中央处理器（CPU）、存储器、输入输出接口组成。

从广义角度讲，SoC是一个微小型系统,如果说中央处理器(CPU)是大脑，那么SoC就是包括大脑、心脏、眼睛和手的系统。所以又被称为系统级芯片，也有称片上系统, 意指它是一个产品，是一个有专用目标的集成电路，其中包含完整系统并有嵌入软件的全部内容。同时它又是一种技术，用以实现从确定系统功能开始，到软/硬件划分，并完成设计的整个过程。

这意味着，在单个芯片上，就能完成一个电子系统的功能，而这个系统在以前往往需要一个或多个电路板，以及板上的各种电子器件、芯片和互连线共同配合来实现。如果说集成电路可以比作是楼房对平房的集成，SoC可以看作是城镇对楼房的集成；宾馆、饭店、商场、超市、医院、学校、汽车站和大量的住宅，集中在一起，构成了一个小镇的功能，满足人们吃住行的基本需求。目前SoC还达不到单芯片实现一个传统的电子产品的程度，可以说现在SoC只是实现了一个小镇的功能，还不能实现一个城市的功能。



![img](https://ask.qcloudimg.com/http-save/developer-news/ty3hwps8sy.jpeg?imageView2/2/w/2560/h/7000)

在单个芯片上集成了更多配套的电路，节省了集成电路的面积，也就节省了成本，相当于小镇的能源利用率提高了；片上互联相当于小镇的快速道路，高速、低耗，原来分布在电路板上的各器件之间的信息传输，集中到同一个芯片中，相当于本来要坐长途汽车才能到达的地方，现在已经挪到小镇里面来了，坐一趟地铁或BRT就到了，这样明显速度快了很多；小镇的第三产业发达，更具有竞争力，而SoC上的软件则相当于小镇的服务业务，不单硬件好，软件也要好；同样一套硬件，今天可以用来做某件事，明天又可以用来做另一件事，类似于小镇中整个社会的资源配置和调度、利用率方面的提高。

由此可见SoC在性能、成本、功耗、可靠性，以及生命周期与适用范围各方面都有明显的优势，因此它是集成电路设计发展的必然趋势。目前在性能和功耗敏感的终端芯片领域，SoC已占据主导地位；而且其应用正在扩展到更广的领域。单芯片实现完整的电子系统，是IC 产业未来的发展方向。



![img](https://ask.qcloudimg.com/http-save/developer-news/yp7ech8csg.jpeg?imageView2/2/w/2560/h/7000)

SoC定义的基本内容主要在两方面：其一是它的构成，其二是它形成过程。系统级芯片的构成可以是

系统级芯片控制逻辑模块

微处理器/微控制器CPU 内核模块

数字信号处理器DSP模块

嵌入的存储器模块

和外部进行通讯的接口模块

含有ADC /DAC 的模拟前端模块

电源提供和功耗管理模块



![img](https://ask.qcloudimg.com/http-save/developer-news/5286efddyy.jpeg?imageView2/2/w/2560/h/7000)

对于一个无线SoC还有射频前端模块、用户定义逻辑(它可以由FPGA 或ASIC实现)以及微电子机械模块，更重要的是一个SoC 芯片内嵌有基本软件(RDOS或COS以及其他应用软件)模块或可载入的用户软件等。

系统级芯片形成或产生过程包含以下三个方面:

1) 基于单片集成系统的软硬件协同设计和验证;

2)再利用逻辑面积技术使用和产能占有比例有效提高即开发和研究IP核生成及复用技术,特别是大容量的存储模块嵌入的重复应用等;

3) 超深亚微米(VDSM) 、纳米集成电路的设计理论和技术

**IP的定义：**

在现代SoC设计技术的理念中，IP（Intellectual Property）是构成SoC的基本单元。这里的IP可以理解为满足特定的规范和要求，并且能够在设计中反复进行复用的功能模块，通常称其为IP核(IP Core)。SoC由于集成了一个完整的系统，通常具有非常大的规模，因此以IP核为基础进行设计，可以缩短设计所需的周期。

通俗地来讲，IP就是某个设计好的模块，IP vendor会把IP卖给芯片设计厂商。不同vendor可能会以不同形式交付这个模块，有的只交付RTL代码，有的会连着一些后端文件一起交付以方便芯片设计公司做物理实现。

一般来说，稍大一点的SoC芯片都会包括很多第三方IP，有些IP甚至一两家vendor垄断了，比如USB PHY或者PCIe MAC，很多公司都是用的Synopsys的。ARM、Synopsys和Cadence都是IP vendor，基本上自己不做芯片。很多公司既是IP vendor又自己开发芯片，比如这两年比较火的寒武纪。稍大一点的公司，比如AMD、NV、海思，都有很多有竞争力的IP，但是只自己用，不卖。

很多 SOC 厂商都依赖 IP 来设计和生产一款 SOC 芯片，做 SOC 的过程其本质就是寻找， 验证和整合 IP 的过程。如果能够找到满足需求的，质量可靠的，验证过的IP 会极大缩短SOC 的开发周期，这个模式在过去几十年已经非常成熟。但是对 IP 的应用模式却随着 市场需求，芯片复杂度，上市时间和成本的压力一直在发生变化，当然这也间接导致了行业内 IP 的生态发生相应的变化。从SOC 视角看，对IP 的使用可以简单的分为三种情况：

只为这一个芯片定制的IP，通常发生在企业内部

IP的选择来自于IP 平台，成熟的hardening IP。有些企业内部有自己的IP 平台，同时也会选择第三方IP 平台的产品。这类IP 的开发就是为了被大量的用户重复使用以降低成本

IP的选择来自于IP 平台，但在SOC SPEC 阶段就一起规划IP 开发，为满足用户的schedule，其研发周期几乎与SOC 同步

不同的IP 策略选择对于验证和芯片回来后的测试也会有不同的影响。

综上所述，SOC 芯片设计的各个环节都重度依赖于IP 的选择，IP 供应商和客户之间的关系也因此而越来越紧密。但是并非所有的IP都有良好的质量保证，做过充分的验证，有符合主流EDA流程需要的完整的数据和清晰的文档。

SOC 芯片流片失败有超过40% 的原因都会和IP 有关，譬如非常常见的设计本身错误，产品和需求不匹配，版本用错，有些design for reuse 的IP，会打包发布，这时候容易出现工艺用错，金属层用错。还有datasheet 和IP view 不一致，IP 自身质量不合格或者严格一点说是和SOC 自身的验证流程不匹配等等。SOC 设计师拿到IP 之后还需要再次做质量检查和验证，而SOC 集成时候检查出来的问题或者更严重的IP 本身错误原因导致的流片失败等问题都导致IP 客户的不安全感，以及SOC 厂商和IP 供应商在不得不在彼此依赖的密切合作中形成一种越来越紧张的关系。通常，对于IP 的选择会有如下几个方面的考量

\1. IP 选择

通常需要考虑的因素有如下几个方面，成本，成熟度，之前项目的经验等等，PPA 和datasheet 与当前项目需求是否吻合。如果是第一个项目试用，那么IP 的开发和SOC 的开发节奏是否能够契合也是一个很重要的考量。

对于设计服务公司而言，每次在IP 选择的这个环节都要大费周章。即便是产品公司，IP 的选择也并非一成不变，毕竟市场随时都在变化。

\2. IP 的 view

在做选择的同时也不能忽略IP view 的完整性和SOC 设计流程是否匹配。主要看是否满足SoC的设计流程以及工具的需求，这其中包括前端，后端，dft 等等。当然这是SoC 和IP vendor 双方妥协磨合的过程，通常问题不大，但出问题的地方也不是一件小事。所以，这也是做设计之前需要考量的一个方面。

\3. IP 质量检查

对于一些不太知名的，或者第一次合作的IP 厂商（包括企业内部自建IP），在把它应用于SOC 设计之前，必要的QA 环节是非常重要的，同样重要的就是QA 流程的自动化。

\4. IP 的版本跟踪

版本跟踪的重要性不言而喻。项目的重要里程碑特别是Tapeout 检查，需要和IP vendor 反复确认版本是否正确。

**几个SoC栗子：**

下图是Wu等人在2012年ASPDAC上发的一篇论文中介绍的SoC，文中有几句话对于理解SoC的原理有一定帮助。

The baseband processor including inner receiver and out receiver demodulates the received signal and stores the generated data streams of audio and video to share memory. When share memory is nearly full, an external interrupt from the baseband processor will be generated to inform the RISC processor to initial implementation of MAC layer. After MAC layer operation, 32-bit RISC processor transfers the data of share memory to SPI or SDIO interface, and then SPI or SDIO module is implemented to send data streams to video decoder.

这段话的意思是：下方的基带处理器经过一系列的运算处理后将数据存放在Share SRAM中（见Baseband Processor和32-bit RISC Processor之间RS Decoder to Share SRAM的箭头）。当SRAM快满时，baseband  processor会产生一个中断信号，发送到RISC processor，启动对MAC layer的处理，处理完后RISC processor再把数据发送到SPI 或 SDIO接口输出到video decoder。

可以简单理解为基带处理器这个IP核对接收到的信号做预处理，外部产生了一个中断信号，CPU进行中断处理，去存储器中取数据，计算完成后将数据通过总线发送到外设接口，写入外设。这就是SoC常做的事，而这个图里的SoC采用了“通道”加速器形式。"通道“的概念，可以看下阿Sa的上一篇文章      SC Semiconductors Class 3：IO, UART, SPI



![img](https://ask.qcloudimg.com/http-save/developer-news/ki5gz320hf.jpeg?imageView2/2/w/2560/h/7000)

**Block diagram of digital baseband SoC**

下图为一个更加复杂的SoC，主要由通用层（the general-purpose tier）、专用层（specialization tier）、大规模并行层（the massively parallel tier）组成（从左到右）。通用层用于控制，专用层用于加速神经网络，大规模并行层用于高能效的大规模并行计算。

从Celerity的结构中也可以看出复杂SoC设计的要点便是合理地划分模块，让每个模块都做自己擅长的事情，当模块越来越多时，模块间的互连问题便显得非常重要。



![img](https://ask.qcloudimg.com/http-save/developer-news/08xg4jvoy3.jpeg?imageView2/2/w/2560/h/7000)

**Celerity block diagram**

下面这个是TI的CC26xx，集成了射频电路和一个M0的核跑协议栈。



![img](https://ask.qcloudimg.com/http-save/developer-news/ow5j706bka.jpeg?imageView2/2/w/2560/h/7000)

下面这个是ARM9的核集成了一些音视频处理的电路，应用非常广泛。



![img](https://ask.qcloudimg.com/http-save/developer-news/1hia4o1e8x.jpeg?imageView2/2/w/2560/h/7000)

**几个问题**

如果你是SOC 厂商，在选择IP 的策略上有哪些考虑

如果你是IP 供应商，如何管理你的产品和连接你的用户，以及他们在不同时间段的不同需求

如果你是SOC 设计师，在使用IP 之前会去重复检查质量和做验证吗，分别使用什么方法和策略

如果你是IP 设计师，如何做交付质量管理和持续交付

- 发表于: 2020-03-12
- 原文链接：https://kuaibao.qq.com/s/20200312A0AHWJ00?refer=cp_1026
- 腾讯「腾讯云开发者社区」是腾讯内容开放平台帐号（企鹅号）传播渠道之一，根据[《腾讯内容开放平台服务协议》](https://om.qq.com/notice/a/20160429/047194.htm)转载发布内容。
- 如有侵权，请联系 cloudcommunity@tencent.com 删除。