# SoC和CPU的区别



[菜鸟Jon](https://blog.csdn.net/csdnmgq) 2019-05-30 11:32:20 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes.png) 4468 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect.png) 收藏 9

分类专栏： [计算机理论与基础](https://blog.csdn.net/csdnmgq/category_8990075.html)



## SoC和CPU的区别

------

原文：<http://www.360doc.com/content/18/0511/21/10211009_753202773.shtml> 

　　SOC（System on Chip），指的是片上系统，MCU只是芯片级的芯片，而SOC是系统级的芯片，它既MCU（51，avr）那样有内置RAM，ROM同时又像MPU（arm）那样强大的不单单是放简单的代码，可以放系统级的代码，也就是说可以运行操作系统（将就认为是MCU集成化与MPU强处理力各优点二合一）。

　　SOC，是个整体的设计方法概念，它指的是一种芯片设计方法，集成了各种功能模块，每一种功能都是由硬件描述语言设计程序，然后在SOC内由电路实现的；每一个模块不是一个已经设计成熟的ASIC“器件”，只是利用芯片的一部分资源去实现某种传统的功能。

　　这种功能是没有限定的，可以是存储器，当然也可以是处理器，如果这片SOC的系统目标就是处理器，那么做成的SOC就是一个MCU；

![img](https://img-blog.csdnimg.cn/20190529105017138.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NzZG5tZ3E=,size_16,color_FFFFFF,t_70)

 

　　CPU（Central Processing Unit），是一台计算机的运算核心和控制核心。CPU由运算器、控制器和寄存器及实现它们之间联系的数据、控制及状态的总线构成。差不多所有的CPU的运作原理可分为四个阶段：提取（Fetch）、解码（Decode）、执行（Execute）和写回（Writeback）。 CPU从存储器或高 速 缓冲存储器中取出指令，放入指令寄存器，并对指令译码，并执行指令。所谓的计算机的可编程性主要是指对CPU的编程。

　　CPU就是中央处理单元，它负责把数据读入计算并输出。所以，无论什么时候谈到CPU，一定是数据的处理和计算部分，这是必须要满足的基本要求。

　　之所以你们会发生混淆，是因为你们不知道，除了数据处理，还有什么其他部分。简单来说，CPU除了内部的Cache和指令存储器和一些缓冲，就没有什么可供存储数据和指令的了。所以，对于程序来说，运行时候需要的代码数据都是在内存里面的，CPU从内存里面把数据和代码取出来放到Cache里面，再从Cache里取出需要的数据。

　　同样，内存容量是有限的，如果找不到数据，就要从硬盘里面或者nandflash进行数据读取，或者直接读取，或者拷贝到DDR里面再进行读取，这取决于这些硬件的结构了

　　但是，每种架构CPU的指令是固定的，指令不会区分什么具体的DDR或者nand的架构，所以，我们需要内存控制器、硬盘控制器、nand控制器，也就是所谓的外围IP，通常，如果Cache不命中，如果需要从内存读取数据，这条访问指令就会被内存控制器获取，它进行分析后会把相应的数据从内存颗粒里面读出来发回给CPU。如果是nand的，它有自己的寄存器，可以通过对寄存器操作来实现数据的读取，这些数据仍然由控制器送给CPU。类似还有网络控制器之类的，CPU的命令都是要由这些控制器去具体实施的。

　　一个CPU的外部端口都会有地址总线和数据总线，我们选择一种总线，把CPU和这些外围IP连起来，让CPU可以和这些IP进行通讯，完成数据的计算和输入输出，这样就变成了一个具有实际意义的系统了。

![img](https://img-blog.csdnimg.cn/20190529105043993.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2NzZG5tZ3E=,size_16,color_FFFFFF,t_70)

## 　　**SoC和CPU的区别：**

　　o - 介词，小写

　　SC- 名词，大写

　　1.1 SoC（System on Chip）： 称为系统级芯片，也称为片上系统，意指它是一个产品，是一个有专有目标的集成电路，其中包含完整系统并嵌入软件的全部内容。

　　1.2 CPU = 运算器 + 控制器，现在几乎没有纯粹的CPU了，都是SoC.

　　1.3 芯片的发展从CPU 到SoC

　　1.4 外设（外部设备）：即除CPU之外的其他部件，如LCD控制器，UART，Nand控制器。。.CPU通过外部总线将各种外部设备连接起来构成SoC.

　　1.5. 比如ARM公司生产的就是CPU，他将自己的所生产的CPU设计卖给其他公司，而其他公司就根据ARM提供的CPU自己添加上自己所需要的各种外设控制器，这就是SoC.

　　1.6. 不同的公司所用的控制器不一定是相同的，因为不同的公司需要的性能不一样，就会想半导体公司定制他需要的控制器。

　　1.7. 日常工作生活中，惯说的CPU说的就是SoC，就像内存有NandFlash和普通内存一样。

　　1.8. 我们学习裸机程序就是学习CPU和各种外设控制器间的相互操作。

