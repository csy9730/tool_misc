# Soc & IP

#### SoC开发方案和MCU方案
SoC免开发方案，SoC定制开发方案和MCU方案。对于没有MCU的设备，模组通过GPIO口控制设备，称为SoC方案。如果需要免开发方案无法满足要求，需要定制，就是SoC定制开发。
#### soc
感觉soc工程师的要求是博学，对模电，数电，功耗，面积，架构等都要了解。ip开发可能会比较专，比如对通信算法，图像-处理算法等特定领域的了解要非常深入，当然这取决于具体ip的性质。soc工作没有太深入的理论，是纯粹的工程工作，只要有时间有钱，总能做出来。soc的挑战，或者说技术水平的高低，是能否在很短时间内做出正确无bug的产品，time to market。



#### IP
IP即Intellectual property 的缩写，在半导体领域中，知名IP供应商主要有ARM，Synopsys，Cadence，Imagination Technologies，Wave Computing， Broadcom等，他们为客户提供了模拟/数字等各类IP核，形式多种多样，如CPU、GPU、USB、PCIe和SerDes等模块。

在现代SoC设计技术的理念中，IP（Intellectual Property）是构成SoC的基本单元。这里的IP可以理解为满足特定的规范和要求，并且能够在设计中反复进行复用的功能模块，通常称其为IP核(IP Core)。SoC由于集成了一个完整的系统，通常具有非常大的规模，因此以IP核为基础进行设计，可以缩短设计所需的周期。

通俗地来讲，IP就是某个设计好的模块，IP vendor会把IP卖给芯片设计厂商。不同vendor可能会以不同形式交付这个模块，有的只交付RTL代码，有的会连着一些后端文件一起交付以方便芯片设计公司做物理实现。

一般来说，稍大一点的SoC芯片都会包括很多第三方IP，有些IP甚至一两家vendor垄断了，比如USB PHY或者PCIe MAC，很多公司都是用的Synopsys的。ARM、Synopsys和Cadence都是IP vendor，基本上自己不做芯片。很多公司既是IP vendor又自己开发芯片，比如这两年比较火的寒武纪。稍大一点的公司，比如AMD、NV、海思，都有很多有竞争力的IP，但是只自己用，不卖。