# 可编程逻辑控制器[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=0&summary=/* top */ )]

维基百科，自由的百科全书


跳到导航

跳到搜索

![img](https://upload.wikimedia.org/wikipedia/commons/thumb/f/f3/Siemens_Simatic_S7-416-3.jpg/220px-Siemens_Simatic_S7-416-3.jpg)



底板上由左至右分别是：电源模块PS407 4A，处理器模块416-3，接口模块IM 460-0和通讯处理器模块CP 443-1

**可编程逻辑控制器**（programmable logic controller，简称**PLC**），一种具有[微处理器](https://zh.wikipedia.org/wiki/微处理器)的数字电子设备，用于[自动化控制](https://zh.wikipedia.org/wiki/自动控制)的[数字逻辑](https://zh.wikipedia.org/wiki/数字电路)[控制器](https://zh.wikipedia.org/wiki/控制器)，可以将控制指令随时加载存储器内存储与运行。可编程控制器由内部[CPU](https://zh.wikipedia.org/wiki/CPU)，指令及资料存储器、输入输出单元、电源模块、数字模拟等单元所模块化组合成。PLC可接收（输入）及发送（输出）多种类型的电气或电子信号，并使用他们来控制或监督几乎所有种类的[机械](https://zh.wikipedia.org/wiki/機械)与[电气](https://zh.wikipedia.org/wiki/電氣)系统。

最初的可编程序逻辑控制器只有电路逻辑控制的功能，所以被命名为可编程逻辑控制器，后来随着不断的发展，这些当初功能简单的计算机模块已经有了包括[逻辑控制](https://zh.wikipedia.org/w/index.php?title=逻辑控制&action=edit&redlink=1)，[时序控制](https://zh.wikipedia.org/w/index.php?title=时序控制&action=edit&redlink=1)、[模拟控制](https://zh.wikipedia.org/w/index.php?title=模拟控制&action=edit&redlink=1)、多机[通信](https://zh.wikipedia.org/wiki/通信)等许多的功能，名称也改为[可编程控制器](https://zh.wikipedia.org/wiki/可程式控制器)（Programmable Controller），但是由于它的简写也是PC与个人电脑（Personal Computer）的简写相冲突，也由于多年来的使用习惯，人们还是经常使用可编程逻辑控制器这一称呼，并在术语中仍沿用**PLC**这一缩写。

在可编程逻辑控制器出现之前，一般要使用成百上千的[继电器](https://zh.wikipedia.org/wiki/继电器)以及计数器才能组成具有相同功能的自动化系统，而现在，经过编程的简单的可编程逻辑控制器模块基本上已经代替了这些大型设备。可编程逻辑控制器的系统程序一般在出厂前已经初始化完毕，用户可以根据自己的需要自行编辑相应的用户程序来满足不同的自动化生产要求。

现在工业上使用可编程逻辑控制器已经相当接近于一台轻巧型电脑所构成，甚至已经出现集成[个人电脑](https://zh.wikipedia.org/wiki/個人電腦)（采用[嵌入式操作系统](https://zh.wikipedia.org/wiki/嵌入式系统)）与PLC结合架构的[可编程自动化控制器](https://zh.wikipedia.org/wiki/可程式自動化控制器)（Programmable Automation Controller，简称PAC），能透过数字或模拟输入/输出模块控制机器设备、制造处理流程及其他控制模块的电子系统。可编程逻辑控制器广泛应用于目前的工业控制领域。在工业控制领域中，PLC控制技术的应用已成为工业界不可或缺的一员。

## 目录



- [1定义与特性](https://zh.wikipedia.org/wiki/可编程逻辑控制器#定義與特性)
- [2发展历史](https://zh.wikipedia.org/wiki/可编程逻辑控制器#發展历史)
- [3PLC内部运作方式](https://zh.wikipedia.org/wiki/可编程逻辑控制器#PLC內部運作方式)
- 4硬件结构
  - [4.1电源模块](https://zh.wikipedia.org/wiki/可编程逻辑控制器#電源模組)
  - [4.2中央处理单元](https://zh.wikipedia.org/wiki/可编程逻辑控制器#中央處理單元)
  - [4.3存储器](https://zh.wikipedia.org/wiki/可编程逻辑控制器#記憶體)
  - [4.4输入/输出单元](https://zh.wikipedia.org/wiki/可编程逻辑控制器#輸入/輸出單元)
  - [4.5通信](https://zh.wikipedia.org/wiki/可编程逻辑控制器#通訊)
- [5外部设备](https://zh.wikipedia.org/wiki/可编程逻辑控制器#外部設備)
- 6程序设计
  - [6.1内部组件](https://zh.wikipedia.org/wiki/可编程逻辑控制器#內部元件)
- [7应用实例](https://zh.wikipedia.org/wiki/可编程逻辑控制器#應用實例)
- 8参考文献
  - [8.1引用](https://zh.wikipedia.org/wiki/可编程逻辑控制器#引用)
  - [8.2来源](https://zh.wikipedia.org/wiki/可编程逻辑控制器#来源)
- [9外部链接](https://zh.wikipedia.org/wiki/可编程逻辑控制器#外部連結)
- [10参见](https://zh.wikipedia.org/wiki/可编程逻辑控制器#參見)

## 定义与特性[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=1)]

PLC具有通用性强、使用方便、适应面广、可靠性高、抗干扰能力强、编程简单等特点。

[国际电工委员会](https://zh.wikipedia.org/wiki/国际电工委员会)（IEC）在其标准中将PLC定义为：

| “    | 可编程逻辑控制器是一种数字运算操作的电子系统，专为在工业环境应用而设计的。它采用一类可编程的存储器，用于其内部存储程序，执行逻辑运算、顺序控制、定时、计数与算术操作等面向用户的指令，并通过数字或模拟式输入/输出控制各种类型的机械或生产过程。可编程逻辑控制器及其有关外部设备，都按易于与工业控制系统联成一个整体，易于扩充其功能的原则设计。 | ”    |
| ---- | ------------------------------------------------------------ | ---- |
|      |                                                              |      |

[美国通用汽车公司](https://zh.wikipedia.org/wiki/通用汽车)在1968年提出了著名的“通用十条”招标指标，也是目前PLC的特点：

1. 编程方便，现场可修改程序；
2. 维修方便，采用模块化结构；
3. 可靠性高于继电器控制设备；
4. 体积小于[继电器](https://zh.wikipedia.org/wiki/继电器)控制设备；
5. 数据可直接送入[计算机](https://zh.wikipedia.org/wiki/電子計算機)；
6. 成本可与继电器控制设备竞争；
7. 输入可以是[交流](https://zh.wikipedia.org/wiki/交流電)115V；
8. 输出为交流115V，2A以上，能直接驱动[电磁阀](https://zh.wikipedia.org/wiki/电磁阀)，[接触器](https://zh.wikipedia.org/wiki/接触器)等；
9. 在扩展时，原系统只要很小变更；
10. 用户程序存储器容量能扩展。

1978年[美国电机制造协会](https://zh.wikipedia.org/w/index.php?title=美國電機製造協會&action=edit&redlink=1)（NEMA）对可编程控制器定义是[[1\]](https://zh.wikipedia.org/wiki/可编程逻辑控制器#cite_note-"機"-1)：

> 可编程控制器是一种以数字动作之电子设备，它使用可编程存储器以存储指令，运行像是逻辑、顺序、计时、计数与演算等功能，并透过数字或模拟输入输出模块，控制各种的机械或工作程序。

## 发展历史[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=2)]

![img](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/PLC%E5%A4%96%E8%A7%80.JPG/300px-PLC%E5%A4%96%E8%A7%80.JPG)



常见的可编程逻辑控制器外观

**可编程控制器**的兴起与[美国](https://zh.wikipedia.org/wiki/美國)现代工业自动化生产发展的要求密不可分的。PLC源起于1960年代，当时[美国通用汽车公司](https://zh.wikipedia.org/wiki/通用汽车)，为解决工厂生产线调整时，继电器顺序控制系统之电路修改耗时，平时检修与维护不易等问题。在可编程逻辑控制器出现之前，汽车制造业中的一般控制、顺序控制以及安全互锁逻辑控制必须完全依靠众多的[继电器](https://zh.wikipedia.org/wiki/继电器)、[定时器](https://zh.wikipedia.org/wiki/定時器)以及专门的[闭回路控制器](https://zh.wikipedia.org/w/index.php?title=閉迴路控制器&action=edit&redlink=1)来实现。它们体积庞大、有着严重的噪音，不但每年的维护工作要耗费大量的人力物力，而且[继电器](https://zh.wikipedia.org/wiki/继电器)-[接触器](https://zh.wikipedia.org/wiki/接触器)系统的排线检修等工作对维护人员的熟练度也有着很高的要求。

针对这些问题，[美国通用汽车公司](https://zh.wikipedia.org/wiki/通用汽车)在1968年向社会公开招标，要求设计一种新的系统来替换继电器系统，并提出了著名的“通用十条”招标指标。随后，美国[数字设备公司](https://zh.wikipedia.org/wiki/DEC)（DEC）根据这一设想，于1969年研制成功了第一台PDP-14控制器，并在汽车自动装配线上使用并获得成功。由于当时系统主要用于顺序控制、只能进行逻辑运算，所以被命名为**可编程逻辑控制器**（Programmable Logic Controller，PLC）。最早期的PLC只具有简易之逻辑开/关（on/off）功能，但比起传统继电器之控制方式，已具有容易修改、安装、诊断与不占空间等优点。

1970年代初期，PLC引进微处理机技术，使得PLC具有算术运算功能与多比特之数字信号输出/输入功能，并且能直接以阶梯图符号进行程序之编写。这项新技术的使用，在工业界产生了巨大的反响。[日本](https://zh.wikipedia.org/wiki/日本)在1971年从美国引进了这项技术，并很快研制成功了自己的DCS-8可编程逻辑控制器，[德](https://zh.wikipedia.org/wiki/德国)、[法](https://zh.wikipedia.org/wiki/法国)在1973年至1974年间也相继有了自己的该项技术。[中国](https://zh.wikipedia.org/wiki/中国)则于1977年研制成功自己的第一台可编程逻辑控制器，但是使用的微处理器核心为MC14500。1970年代中期，PLC功能加入远距通信、[模拟](https://zh.wikipedia.org/wiki/類比)输出输入、NC [伺服控制](https://zh.wikipedia.org/w/index.php?title=伺服控制&action=edit&redlink=1)等技术。1980年代以后更引进PLC高速[通信网络](https://zh.wikipedia.org/w/index.php?title=通訊網路&action=edit&redlink=1)功能，同时加入一些特殊输出/输入界面、[人机界面](https://zh.wikipedia.org/wiki/人机界面)、高功能[函数](https://zh.wikipedia.org/wiki/函數)指令、资料收集与分析能力等功能。

PLC之功能早已不止当初数字逻辑之运算功能，因此近年来PLC常以**可编程控制器**（*Programmable Controller*）简称之[[2\]](https://zh.wikipedia.org/wiki/可编程逻辑控制器#cite_note-2)。

## PLC内部运作方式[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=3)]

![img](https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/PLC_structure.JPG/300px-PLC_structure.JPG)



PLC内部运作架构

虽然PLC所使用之阶梯图程序中往往使用到许多继电器、计时器与计数器等名称，但PLC内部并非实体上具有这些硬件，而是以存储器与程序编程方式做逻辑控制编辑，并借由输出组件连接外部机械设备做实体控制。因此能大大减少控制器所需之硬件空间。实际上PLC运行阶梯图程序的运作方式是逐行的先将代码以扫描方式读入CPU中并最后运行控制运作。在整个的扫描过程包括三大步骤，“输入状态检查”、“程序运行”、“输出状态更新”说明如下：

- 步骤一“输入状态检查”：

PLC首先检查输入端组件所连接之各点开关或传感器状态（1或0代表开或关），并将其状态写入存储器中对应之位置Xn。

- 步骤二“程序运行”：

将阶梯图程序逐行取入CPU中运算，若程序运行中需要输入接点状态，CPU直接自存储器中查询取出。输出线圈之运算结果则存入存储器中对应之位置，暂不反应至输出端Yn。

- 步骤三“输出状态更新”：

将步骤二中之输出状态更新至PLC输出部接点，并且重回步骤一。

此三步骤称为PLC之扫描周期，而完成所需的时间称为PLC之反应时间，PLC输入信号之时间若小于此反应时间，则有误读的可能性。每次程序运行后与下一次程序运行前，输出与输入状态会被更新一次，因此称此种运作方式为输出输入端“程序结束再生”。

## 硬件结构[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=4)]

![img](https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/PLC_Hardware.JPG/300px-PLC_Hardware.JPG)



可编程逻辑控制器硬件构成

一般讲，PLC分为箱体式和模块式两种。但它们的组成是相同的，对箱体式PLC，有一块CPU板、I/O板、显示面板、存储器块、电源等，当然按CPU性能分成若干型号，并按I/O点数又有若干规格。对模块式PLC，有CPU模块、I/O模块、存储器、电源模块、底板或机架。无论哪种结构类型的PLC，都属于总线式开放型结构，其I/O能力可按用户需要进行扩展与组合。PLC的基本结构框图如下：

### 电源模块[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=5)]

有些PLC中的电源，是与CPU模块合二为一的，有些是分开的，其主要用途是为PLC各模块的集成电路提供工作电源。同时，有的还为输入电路提供24V的工作电源。电源如果为交流电源通常为220VAC或110VAC，若为直流电源常用的为24V。

### 中央处理单元[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=6)]

PLC中的[CPU](https://zh.wikipedia.org/wiki/CPU)是PLC的核心，它按PLC的系统程序赋予的功能接收并存贮用户程序和资料，用扫描的方式采集由现场输入设备送来的状态或资料，并存入规划的寄存器中，同时，诊断电源和PLC内部电路的工作状态和编程过程中的语法错误等。进入运行后，从用户程序存贮器中逐条读取指令，经分析后再按指令规定的任务产生相应的控制信号，去指挥有关的控制电路，与[个人电脑](https://zh.wikipedia.org/wiki/個人電腦)一样，主要由运算器、控制器、寄存器及实现它们之间联系的资料、控制及状态总线构成，还有周边芯片、总线界面及有关电路。它确定了进行控制的规模、工作速度、存储器容量等。

### 存储器[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=7)]

存储器主要用于存储程序及资料，是PLC不可缺少的组成单元。PLC内部会存放撰写完成编辑的程序指令及资料，通常也可使用[RAM](https://zh.wikipedia.org/wiki/隨機存取記憶體)或[EEPROM](https://zh.wikipedia.org/wiki/EEPROM)等专用存储器卡片方式扩展，但扩展能力得依各厂牌与型号有所不同。

### 输入/输出单元[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=8)]

PLC的对外功能，主要是通过各种输入/输出模块与外界联系的，按I/O点数确定模块规格及数量，I/O模块可多可少，但其最大数受CPU所能管理的基本配置的能力，即受最大的底板或机架槽数限制。I/O模块集成了PLC的I/O电路，其输入寄存器反映输入信号状态，输出点反映输出锁存器状态。

输入单元是用来链接截取输入组件的信号动作并透过内部总线将资料送进存储器由CPU处理驱动程序指令部分。PLC输入模块PLC系统的架构和输入模块产品的选择端视需要被监测的输入信号位准而定。

来自不同类型被监测的传感器与流程控制之变量信号，可以涵盖从±10mV至±10V的输入信号范围。

输出单元是用来驱动外部负载的接口，主要原理是由CPU处理以书写在PLC里的程序指令，判断驱动输出单元在进而控制外部负载，如指示灯、[电磁接触器](https://zh.wikipedia.org/wiki/電磁接觸器)、[继电器](https://zh.wikipedia.org/wiki/繼電器)、气（油）压阀等。

PLC输出模块在工业环境中用来控制制动器、气阀及马达等的PLC系统模拟输出范围包括±5V、±10V、0V到5V、0V到10V、4到20mA、或0到20mA等。

### 通信[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=9)]

现在PLC大多具有可扩展通信网络模块的功能，简单的PLC以[BUS](https://zh.wikipedia.org/w/index.php?title=BUS&action=edit&redlink=1)缆线或[RS-232](https://zh.wikipedia.org/wiki/RS-232)方式通信链接，较高端的PLC会采用[USB](https://zh.wikipedia.org/wiki/USB)或[以太网](https://zh.wikipedia.org/wiki/乙太網路)方式做通信链接。它使PLC与PLC之间、PLC与个人电脑以及其他智能设备之间能够交换信息，形成一个统一的整体，实现分散集中控制。现在几乎所有的PLC新产品都有通信网络功能，它和电脑一样具有RS-232接口，通过双绞线、同轴电缆或光缆，可以在几公里甚至几十公里的范围内交换信息。当然，PLC之间的通信网络是各厂家专用的，PLC与电脑之间的通信，一些生产厂家采用工业标准总线，并向标准通信协议靠近，这将使不同机型的PLC之间、PLC与电脑之间可以方便地进行通信与网络。

PLC通信协议规格可分为[RS-232](https://zh.wikipedia.org/wiki/RS-232)、[RS-422](https://zh.wikipedia.org/wiki/RS-422)、[RS-432](https://zh.wikipedia.org/w/index.php?title=RS-432&action=edit&redlink=1)、[RS-485](https://zh.wikipedia.org/wiki/RS-485)、[IEEE 1394](https://zh.wikipedia.org/wiki/IEEE_1394)、[IEEE-488](https://zh.wikipedia.org/wiki/IEEE-488)（GPIB），其中RS-432最为少见。目前国际中最常用的通信协议为[MODBUS](https://zh.wikipedia.org/wiki/MODBUS)-ASCII模式及MODBUS-RTU模式，此为Modicon公司所制定的[通信协议](https://zh.wikipedia.org/wiki/通訊協定)。[PROFIBUS](https://zh.wikipedia.org/wiki/PROFIBUS)则为[西门子公司](https://zh.wikipedia.org/wiki/西門子公司)所制定。日本[三菱电机](https://zh.wikipedia.org/wiki/三菱電機)则推出[CC-LINK](https://zh.wikipedia.org/wiki/CC-LINK)通信协议。

## 外部设备[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=10)]

外部设备是PLC系统不可分割的一部分，它有四大类

- 编程设备：有简易编程器和智能图形编程器，用于编程、对系统作一些设置、监控PLC及PLC所控制的系统的工作状况。编程器是PLC开发应用、监测运行、检查维护不可缺少的器件，但它不直接参与现场控制运行。
- 监控设备：资料监控器和图形监控器。直接监控资料或通过画面监控资料。
- 存储设备：有存储卡、存储磁带、软盘或只读存储器，用于永久性地存储用户资料，使用户程序不丢失，如[EPROM](https://zh.wikipedia.org/wiki/EPROM)、[EEPROM](https://zh.wikipedia.org/wiki/EEPROM)写入器等。
- 输入输出设备：用于接收信号或输出信号，一般有[条码读入器](https://zh.wikipedia.org/w/index.php?title=條碼讀入器&action=edit&redlink=1)，输入模拟量的电位器，[打印机](https://zh.wikipedia.org/wiki/印表機)等。

## 程序设计[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=11)]

![img](https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/PLC_Program_Design.jpg/300px-PLC_Program_Design.jpg)



PLC程序设计示意图

PLC的编程编程语言与一般电脑[编程语言](https://zh.wikipedia.org/wiki/程式語言)相比，具有明显的特点，它既不同于高级语言，也不同与一般的汇编语言，它既要满足易于编写，又要满足易于调试的要求。目前，还没有一种对各厂家产品都能兼容的编程语言。[IEC 61131-3](https://zh.wikipedia.org/wiki/IEC61131)是一个国际标准，它规范了PLC相关之软件硬件的标准，其最终的目的是可以让PLC的用户在不更改软件设计的状况下可以轻易更换PLC硬件。IEC 61131-3主要是提供了五种编程语言，包含：

\1. **指令表**（Instruction List，IL或Statement List，SL） ：类似汇编语言的描述文字。由指令语句系列构成，如Mitsubishi FX2的控制指令LD、LDI、AND、ANI、OR、ORI、ANB、ORB、MMP、MMS与OUT等，一般配合书写器写入程序，而书写器只能输入简单的指令，与计算机程序中的阶梯图比较起来简单许多。书写器不太直观，可读性差，特别是遇到较复杂的程序，更难读；但其优点就是不需要电脑就可以更改或察看PLC内部程序。使用书写器时，必须注意的是PLC指令中输出有优先次序，其中若有输出至相同的单元时（如Y000），输出的优先次序以地址越大优先次愈越高，一般不容易从书写器中察觉所输入的单元。

\2. **结构式文件编程语言**（Structured Text，ST）：类似[PASCAL](https://zh.wikipedia.org/wiki/PASCAL)与[C语言](https://zh.wikipedia.org/wiki/C語言)的语法，适合撰写较复杂的算法，调试上也比阶梯图要容易得多。ST语言类似于编程语言的特性，因此可利用与[微电脑](https://zh.wikipedia.org/wiki/微電腦)及个人电脑相同的程序设计技术进行阶梯式语言所难以运行的复杂计算，完成程序的创建。

![img](https://upload.wikimedia.org/wikipedia/commons/thumb/6/67/%E8%87%AA%E4%BF%9D%E6%8C%81%E8%BF%B4%E8%B7%AF.JPG/350px-%E8%87%AA%E4%BF%9D%E6%8C%81%E8%BF%B4%E8%B7%AF.JPG)



自保持回路的阶梯图，当开关ON触动后，电灯即自我保持在输出，直到开关OFF触动才会切断

\3. **阶梯图**（Ladder Programming，LAD）：类似于传统上以[继电器](https://zh.wikipedia.org/wiki/繼電器)控制接触器的[阶梯图](https://zh.wikipedia.org/wiki/電路圖)，梯形图是通过连线把PLC指令的梯形图符号连接在一起的连通图，用以表达所使用的PLC指令及其前后顺序，它与电气原理图很相似。
它的连线有两种：一为母线，另一为内部横竖线。内部横竖线把一个个梯形图符号指令连成一个指令组，这个指令组一般总是从装载（LD）指令开始，必要时再继以若干个输入指令（含LD指令），以创建逻辑条件。最后为输出类指令，实现输出控制，或为资料控制、流程控制、通信处理、监控工作等指令，以进行相应的工作。

\4. **顺序功能流程图**（Sequential Function Chart，SFC）：类似于流程设计（Flow Design），流程图中的步骤组合而完成，主要是规划动作顺序的流程图，故谓之顺序功能流程图。所谓步序式控制，即是一步一步控制，而这一步与上一步是有关连性的，有顺序性的。必须有上一个动作（STL），才会启动（SET）下一个动作（STL）。

5.**功能区块图**（Function Block Diagram，FBD）：以画电路图的方式来写PLC程序。常用的程序及回路可透过FB（功能区块）的创建轻易地重复利用。

其他一些高端的PLC还具有与电脑兼容的C语言、BASIC语言、专用的高级语言（如西门子公司的GRAPH5、三菱公司的MELSAP、富士电机的Micrex-SX系列），还有用布尔逻辑语言、通用电脑兼容的汇编语言等。

### 内部组件[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=12)]

PLC在程序设计过程中，会利用到内部存储器，规划许多顺序控制程序上常会使用到的组件，这些组件包括：输入继电器、输出继电器、补助继电器、计数器、计时器、资料寄存器等主要组件，各组件功能与使用方法，说明如下：

- 输入接点与输出接点：用于PLC与外部组件之间的状态发送。可连接外部器件，及[按钮开关](https://zh.wikipedia.org/w/index.php?title=按鈕開關&action=edit&redlink=1)、[选择开关](https://zh.wikipedia.org/w/index.php?title=選擇開關&action=edit&redlink=1)、[光电开关](https://zh.wikipedia.org/w/index.php?title=光電開關&action=edit&redlink=1)、数字开关等，使用过大电流将会造成内部接点组件损坏。
- 辅助继电器：用来取代传统顺序控制中的继电器。传统继电器包括接点与线圈二部分，但实际上PLC是以内部存储器来记忆补助继电器之状态，若线圈被驱动则将**1**写入，否则将**0**写入。
- 计数器：在程序中被用来计算重复动作的次数。
- 计时器：用来计算动作的时间长短。
- 资料寄存器：用来存储字符组之数值或字符资料（Data）。

## 应用实例[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=13)]

![img](https://upload.wikimedia.org/wikipedia/commons/thumb/3/31/A_series_PLC.jpg/250px-A_series_PLC.jpg)



三菱公司的Q系列大型PLC，以模块化设计来扩展

由于具有使用容易，节省配线人力，设计弹性等优点，已广泛的应用于各种控制系统中，在工厂自动化控制中担任核心控制任务。目前市面上之PLC种类繁多，依照制造厂商及适用场所的不同而有所差异，但是每种厂牌可依机组复杂度分为大、中、小型;而一般工厂及学校通常使用小型PLC，在工业用途通常使用大型PLC。

应用例：

- [半导体](https://zh.wikipedia.org/wiki/半導體)晶圆厂的各种自动化设备
- 大楼[电梯](https://zh.wikipedia.org/wiki/升降机)
- 停车场机械设备
- 自动化生产线
- 中央空调

## 参考文献[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=14)]

### 引用[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=15)]

1. **^** 陈双源. 機電整合導論（下冊）. [东华书局](https://zh.wikipedia.org/w/index.php?title=東華書局&action=edit&redlink=1). 1999-12-01: 12-1. [ISBN 978957483020 6](https://zh.wikipedia.org/wiki/Special:网络书源/978957483020_6).
2. **^** [这里（英文）](http://www.barn.org/FILES/historyofplc.html). [2005-10-29]. （原始内容[存档](https://web.archive.org/web/20191206080153/http://www.barn.org/FILES/historyofplc.html)于2019-12-06）.

### 来源[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=16)]

- 书籍

- 双象贸易. 《三菱可程式控制器FX2使用範例大全》. 台北: 文笙书局. 1994 **（中文（台湾））**.
- 永宏电机 编著。2000。《永宏可编程控制使用手册I-硬件篇与基础篇》。永宏电机。台北。**（繁体中文）**
- 永宏电机 编著。2000。《永宏可编程控制器使用手册II-高级篇》。永宏电机。台北。**（繁体中文）**
- 吴炳煌、黄仁清 编著。1998。《FX2可编程控制原理与实习》。高立图书。台北。**（繁体中文）**
- 廖文煇 编著。2001。《可编程控制器应用基础篇》。全华科技图书。**（繁体中文）**
- 李新涛 著。2001。《可编程控制器设计与应用》。沧海书局。**（繁体中文）**
- 陈焕荣 编著。1999。《可编程控制器与实习》。全华科技图书。**（繁体中文）**
- 彭锦铜 编著。2001。《可编程控制实习》。台科大。**（繁体中文）**
- 国立台湾大学生物产业机电工程学系 编印。《农业自动化丛书第十二辑机电集成》**（繁体中文）**
- 宓哲民、王文义、陈文耀、陈文轩 等 编著。2017。《PLC原理与应用实务（第八版）》。全华科技图书。台北。**（繁体中文）**

## 外部链接[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=17)]

- [自动化在线](https://web.archive.org/web/20110827000752/http://www.autooo.net/)
- [工控365](https://web.archive.org/web/20190531120327/http://www.gongkong365.com/)
- [PLC技术网](http://www.plcjs.com/) （[页面存档备份](https://web.archive.org/web/20201203222143/http://www.plcjs.com/)，存于[互联网档案馆](https://zh.wikipedia.org/wiki/互联网档案馆)）
- **（中文）**[央视-无人工厂来了](http://sannong.cntv.cn/2015/06/01/VIDE1433088479700134.shtml) （[页面存档备份](https://web.archive.org/web/20200820183830/http://sannong.cntv.cn/2015/06/01/VIDE1433088479700134.shtml)，存于[互联网档案馆](https://zh.wikipedia.org/wiki/互联网档案馆)）

## 参见[[编辑](https://zh.wikipedia.org/w/index.php?title=可编程逻辑控制器&action=edit&section=18)]

- [![icon](https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/8bit-dynamiclist_%28reversed%29.gif/28px-8bit-dynamiclist_%28reversed%29.gif)](https://zh.wikipedia.org/wiki/File:8bit-dynamiclist_(reversed).gif)[计算机程序设计主题](https://zh.wikipedia.org/wiki/Portal:電腦程式設計)
- [![icon](https://upload.wikimedia.org/wikipedia/commons/thumb/8/8d/Nuvola_apps_ksim.png/28px-Nuvola_apps_ksim.png)](https://zh.wikipedia.org/wiki/File:Nuvola_apps_ksim.png)[电子学主题](https://zh.wikipedia.org/wiki/Portal:电子学)
- [![icon](https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/Nuvola_apps_kcmsystem.svg/28px-Nuvola_apps_kcmsystem.svg.png)](https://zh.wikipedia.org/wiki/File:Nuvola_apps_kcmsystem.svg)[工程主题](https://zh.wikipedia.org/wiki/Portal:工程)

- [可编程自动化控制器](https://zh.wikipedia.org/wiki/可程式自動化控制器)
- [工业电脑](https://zh.wikipedia.org/wiki/工業電腦)
- [PLC放大板](https://zh.wikipedia.org/wiki/PLC放大板)
- [软PLC控制技术](https://zh.wikipedia.org/wiki/软PLC控制技术)