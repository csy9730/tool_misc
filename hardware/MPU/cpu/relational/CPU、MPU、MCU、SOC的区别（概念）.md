# CPU、MPU、MCU、SOC的区别（概念）

时间：2017-06-22 17:11:37

关键字： [CPU](https://www.21ic.com/tags/CPU)    [MCU](https://www.21ic.com/tags/MCU)    [单片机](https://www.21ic.com/tags/单片机)   

**[导读]** 1、CPU(Central Processing Unit)，是一台计算机的运算核心和控制核心。CPU由运算器、控制器和寄存器及实现它们之间联系的数据、控制及状态的总线构成。差不多所有的CPU的运作原理可分为四个阶段：提取(Fetch)、解



 1、CPU(Central Processing Unit)，是一台计算机的运算核心和控制核心。CPU由运算器、控制器和寄存器及实现它们之间联系的数据、控制及状态的总线构成。差不多所有的CPU的运作原理可分为四个阶段：提取(Fetch)、解码(Decode)、执行(Execute)和写回(Writeback)。 CPU从存储器或高速缓冲存储器中取出指令，放入指令寄存器，并对指令译码，并执行指令。所谓的计算机的可编程性主要是指对CPU的编程。

2、MPU (Micro Processor Unit)，叫微处理器(不是微控制器)，通常代表一个功能强大的CPU(暂且理解为增强版的CPU吧),但不是为任何已有的特定计算目的而设计的芯片。这种芯片往往是个人计算机和高端工作站的核心CPU。Intel X86，ARM的一些Cortex-A芯片如飞思卡尔i.MX6、全志A20、TI AM335X等都属于MPU。

MPU就是把很多CPU集成在一起并行处理数据的芯片。通俗来说，MCU集成了RAM，ROM等设备；MPU则不集成这些设备，是高度集成的通用结构的中央处理器矩阵，也可以认为是去除了集成外设的MCU。

3、MCU(Micro Control Unit)，叫微控制器，是指随着大规模集成电路的出现及其发展，将计算机的CPU、RAM、ROM、定时计数器和多种I/O接口集成在一片芯片上，形成芯片级的芯片，比如51，AVR、Cortex-M这些芯片，内部除了CPU外还有RAM、ROM，可以直接加简单的外围器件(电阻，电容)就可以运行代码了。而如x86、ARM这些MPU就不能直接放代码了，它只不过是增强版的CPU，所以得添加RAM，ROM。

4、SOC(System on Chip)，指的是片上系统，MCU只是芯片级的芯片，而SOC是系统级的芯片，它既MCU(51，avr)那样有内置RAM、ROM同时又像MPU那样强大，不单单是放简单的代码，可以放系统级的代码，也就是说可以运行操作系统(将就认为是MCU集成化与MPU强处理力各优点二合一)。