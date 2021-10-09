# [JTAG、JLINK、ULINK、ST-LINK的联系和区别](https://www.cnblogs.com/neverguveip/p/9457262.html)

## 一、 JTAG
JTAG用的计算机的并口，JTAG也是一种国际标准测试协议（IEEE 1149.1兼容），主要用于芯片内部测试。现在多数的高级器件都支持JTAG协议,如DSP、FPGA器件等。
标准的JTAG接口是4线：TMS、TCK、TDI、TDO,分别为模式选择、时钟、数据输入和数据输出线。
相关JTAG引脚的定义为：TCK为测试时钟输入；TDI为测试数据输入，数据通过TDI引脚输入JTAG接口；TDO为测试数据输出，数据通过TDO引脚从JTAG接口输出；TMS为测试模式选择，TMS用来设置JTAG接口处于某种特定的测试模式；TRST为测试复位，输入引脚，低电平有效。

## 二、JLINK
J-Link是针对ARM设计的一个小型USB到JTAG转换盒。它通过USB连接到运行Windows的PC主机。J-Link无缝集成到IAR Embedded Workbench for ARM中，它完全兼容 PNP(即插即用)：
- (1) 支持所有ARM7和ARM9体系;
- (2) 下载速度高达50KB/秒;
- (3) 无需外接电源(USB取电);
- (4) 最高JTAG速度达8MHz;
- (5) 自动速度识别;
- (6) 固件可升级;
- (7) 20脚标准JTAG连接器;
- (8) 带USB连线和20脚的扁平线缆;
- (9) 可以用于KEIL ，IAR ，ADS 等平台 速度，效率，功能均比ULINK强。

 J-LINK仿真器V8版，其仿真速度和功能远非简易的并口WIGGLER调试器可比。J-LINK支持ARM7、ARM9、ARM11、Cortex-M3核心，支持ADS、IAR、KEIL开发环境。V8.0版本除拥有上一版本V7.0的全部功能外，软硬件上都有改进：
（1）V8.0版的SWD硬件接口支持1.2-5.0V的目标板，V7.0只能支持3.3V的目标板。
（2）V8.0使用双色LED可以指示更多的工作状态，V7.0只有1个LED指示灯。
（3）V8.0增强了JTAG驱动能力，提高了目标板的兼容性。
（4）优化了固件结构，使应用程序区扩大一J-Link ARM主要特点。

## 三、ULINK
ULINK——ULINK2是ARM公司最新推出的配套RealView MDK使用的仿真器，是ULink仿真器的升级版本。ULINK2不仅具有ULINK仿真器的所有功能，还增加了串行调试（SWD）支持，返回时钟支持和实时代理等功能。开发工程师通过结合使用RealView MDK的调试器和ULINK2，可以方便的在目标硬件上进行片上调试(使用on-chip JTAG，SWD和OCDS)、Flash编程。

## 四、ST-LINK
ST-LINK /V2指定的SWIM标准接口和JTAG / SWD标准接口，其主要功能有：
- (1)编程功能：可烧写FLASH ROM、EEPROM、AFR等;
- (2)仿真功能：支持全速运行、单步调试、断点调试等各种调试方法，可查看IO状态，变量数据等;
- (3)仿真性能：采用USB2.0接口进行仿真调试，单步调试，断点调试，反应速度快;
- (4)编程性能：采用USB2.0接口，进行SWIM / JTAG / SWD下载，下载速度快;

## 五、直接区别简述
JLINK的功能要比JTAG强大，因为JTAG用的是并行口，所以在使用的时候不方便，而且功能也不如JLINK，。ULINK是KEIL公司开发的仿真器，专用于KEIL 平台下使用，ADS,iar 下不能使用。JLINK 是通用的开发工具，可以用于KEIL ，IAR ，ADS 等平台 速度，效率，功能均比ULINK强，ULINK和ULINK2的功能和速度也没有JLINK强大。看过一些帖子，普遍说，JLINK比ST-LINK调试时稳定。但是ST-LINK可以支持STM8的调试。



分类: [工程实践](https://www.cnblogs.com/neverguveip/category/1275409.html)