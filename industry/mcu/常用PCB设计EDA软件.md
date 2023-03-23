# 常用PCB设计EDA软件

[![博锐电路PCB](https://pic1.zhimg.com/v2-0557383b08b93b5d8bc2bd1dd3c2ea48_l.jpg?source=172ae18b)](https://www.zhihu.com/people/lcy82995688)

[博锐电路PCB](https://www.zhihu.com/people/lcy82995688)

EDA工具层出不穷，目前进入我国并具有广泛影响的EDA软件有：EWB、PSPICE、OrCAD、PCAD、Protel、Viewlogic、Mentor、Graphics、Synopsys、LSIlogic、Cadence、MicroSim等等。这些工具都有较强的功能，一般可用于几个方面，例如很多软件都可以进行电路设计与仿真，同时以可以进行PCB自动布局布线，可输出多种网表文件与第三方软件接口。下面按主要功能或主要应用场合，分为电路设计与仿真工具、**[PCB设计](https://link.zhihu.com/?target=https%3A//www.brpcb.com/)**软件、IC设计软件、PLD设计工具及其它EDA软件，进行简单介绍。

### 1、电子电路设计与仿真工具

电子电路设计与仿真工具包括SPICEPSPICE；EWB；Matlab；SystemView；MMICAD等。下面简单介绍前三个软件。

（1）SPICE（Simulation Program with Integrated CircuitEmphasis） 是由美国加州大学推出的电路分析仿真软件，是20世纪80年代世界上应用最广的电路设计软件，1998年被定为美国国家标准。1984年，美国MicroSim公司推出了基于SPICE的微机版PSPICE（PersonalSPICE）。现在用得较多的是PSPICE6.2，可以说在同类产品中，它是功能最为强大的模拟和数字电路混合仿真EDA软件，在国内普遍使用。最新推出了PSPICE9.1版本。它可以进行各种各样的电路仿真、激励建立、温度与噪声分析、模拟控制、波形输出、数据输出、并在同一窗口内同时显示模拟与数字的仿真结果。无论对哪种器件哪些电路进行仿真，都可以得到精确的仿真结果，并可以自行建立元器件及元器件库。

（2）EWB（Electronic Workbench）软件 是Interactive ImageTechnologies Ltd 在20世纪90年代初推出的电路仿真软件。目前普遍使用的是EWB5.2，相对于其它EDA软件，它是较小巧的软件（只有16M）。但它对模数电路的混合仿真功能却十分强大，几乎100%地仿真出真实电路的结果，并且它在桌面上提供了万用表、示波器、信号发生器、扫频仪、逻辑分析仪、数字信号发生器、逻辑转换器和电压表、电流表等仪器仪表。它的界面直观，易学易用。它的很多功能模仿了SPICE的设计，但分析功能比PSPICE稍少一些。

（3）MATLAB产品族 它们的一大特性是有众多的面向具体应用的工具箱和仿真块，包含了完整的函数集用来对图像信号处理、控制系统设计、神经网络等特殊应用进行分析和设计。它具有数据采集、报告生成和MATLAB语言编程产生独立CC++代码等功能。MATLAB产品族具有下列功能：数据分析；数值和符号计算；工程与科学绘图；控制系统设计；数字图像信号处理；财务工程；建模、仿真、原型开发；应用开发；图形用户界面设计等。MATLAB产品族被广泛地应用于信号与图像处理、控制系统设计、通讯系统仿真等诸多领域。开放式的结构使MATLAB产品族很容易针对特定的需求进行扩充，从而在不断深化对问题的认识同时，提高自身的竞争力。

### 2、PCB设计软件

PCB（PrintedCircuit Board）设计软件种类很多，如Protel； OrCAD；Viewlogic； PowerPCB； Cadence PSD；MentorGraphices的Expedition PCB；Zuken CadStart； WinboardWindraftIvex-SPICE；PCB Studio； TANGO等等。目前在我国用得最多应属Protel，下面仅对此软件作一介绍。

Protel是PROTEL公司在20世纪80年代末推出的CAD工具，是PCB设计者的首选软件。它较早在国内使用，普及率最高，有些高校的电路专业还专门开设Protel课程，几乎所在的电路公司都要用到它。Altium Designer是原Protel软件开发商Altium公司推出的一体化的电子产品开发系统，主要运行在Windows操作系统。这套软件通过把原理图设计、电路仿真、PCB绘制编辑、拓扑逻辑自动布线、信号完整性分析和设计输出等技术的完美融合，为设计者提供了全新的设计解决方案，使设计者可以轻松进行设计，熟练使用这一软件使电路设计的质量和效率大大提高。最高版本为：Altium Designer 22。

![img](https://pic2.zhimg.com/80/v2-9ccf628551af3d22a5f0803a74450cf9_720w.webp)

### 3、IC设计软件

IC设计工具很多，其中按市场所占份额排行为Cadence、Mentor Graphics和Synopsys。这三家都是ASIC设计领域相当有名的软件供应商。其它公司的软件相对来说使用者较少。中国华大公司也提供ASIC设计软件（熊猫2000）；另外近来出名的Avanti公司，是原来在Cadence的几个华人工程师创立的，他们的设计工具可以全面和Cadence公司的工具相抗衡，非常适用于深亚微米的IC设计。下出按用途对IC设计软件作一些介绍。

（1）设计输入工具 这是任何一种EDA软件必须具备的基本功能。像Cadence的composer,viewlogic的viewdraw,硬件描述语言VHDL、Verilog HDL是主要设计语言，许多设计输 入工具都支持HDL。另外像ActiveHDL和其它的设计输入方法，包括原理和状态机输入方法，设计FPGACPLD的工具大都可作为IC设计的输入手段，如Xilinx、Altera等公司提供的开发工具，Modelsim FPGA等。

（2）设计仿真工作 我们使用[EDA](https://link.zhihu.com/?target=https%3A//www.brpcb.com/pcb.html)工具的一个最大好处是可以验证设计是否正确，几乎每个公司的EDA 产品都有仿真工具。VerilogXL、NCverilog用于Verilog仿真，Leapfrog用于VHDL仿真，Analog Artist用于模拟电路仿真。Viewlogic的仿真器有：viewsim门级电路仿真器，speedwaveVHDL仿真器，VCSverilog仿真器。Mentor Graphics有其子公司Model Tech 出品的VHDL和Verilog双仿真器：Model Sim。Cadence、Synopsys用的是VSS（VHDL仿真器）。现在的趋势是各大EDA公司都逐渐用HDL仿真器作为电路验证的工具。

（3）综合工具 综合工具可以把HDL变成门级网表。这方面Synopsys工具占有较大的优势，它的Design Compile是作综合的工业标准，它还有另外一个产品叫Behavior Compiler，可以提供更高级的综合。另外最近美国又出了一家软件叫Ambit，说是比Synopsys的软件更有效，可以综合50万门的电路，速度更快。今年初Ambit被Cadence公司收购，为此Cadence放弃了它原来的综合软件Synergy。随着FPGA设计的规模越来越大，各EDA公司又开发了用于FPGA设计的综合软件，比较有名的有：Synopsys的FPGA Express,Cadence的Synplity，Mentor的Leonardo，这三家的FPGA综合软件占了市场的绝大部分。

（4）布局和布线 在IC设计的布局布线工具中，[Cadence](https://link.zhihu.com/?target=https%3A//www.brpcb.com/)软件是比较强的，它有很多产品，用于标准单元、门阵列已可实现交互布线。最有名的是Cadence spectra，它原来是用于PCB布线的，后来Cadence把它用来作IC的布线。其主要工具有：Cell3，Silicon Ensemble标准单元布线器；Gate Ensemble门阵列布线器；Design Planner布局工具。其它各EDA软件开发公司也提供各自的布局布线工具。

（5）物理验证工具 物理验证工具包括版图设计工具、版图验证工具、版图提取工具等等。这方面Cadence也是很强的，其Dracula、Virtuso、Vampire等物理工具有很多的使用者。

（6）模拟电路仿真器 前面讲的仿真器主要是针对数字电路的，对于模拟电路的仿真工具，普遍使用SPICE，这是唯一的选择。只不过是选择不同公司的SPICE，像MiceoSim的PSPICE、Meta Soft的HSPICE等等。HSPICE现在被Avanti公司收购了。在众多的SPICE中，最好最准的当数HSPICE，作为IC设计，它的模型最多，仿真的精度也最高。

### 4、PLD设计工具

PLD（Programmable Logic Device）是一种由用户根据需要而自行构造逻辑功能的数字集成电路。目前主要有两大类型：CPLD（Complex PLD）和FPGA（Field Programmable Gate Array）。它们的基本设计方法是借助于EDA软件，用原理图、状态机、布尔表达式、硬件描述语言等方法，生成相应的目标文件，最后用编程器或下载电缆，由目标器件实现。生产PLD的厂家很多，但最有代表性的PLD厂家为Altera、Xilinx和Lattice 公司。

PLD的开发工具一般由器件生产厂家提供，但随着器件规模的不断增加，软件的复杂性也随之提高，目前由专门的软件公司与器件生产厂家合作，推出功能强大的设计软件。下面介绍主要器件生产厂家和开发工具。

（1）ALTERA 20世纪90年代以后发展很快。主要产品有：MAX30007000、FELX6K10K、APEX20K、ACEX1K、Stratix等。其开发工具？MAX+PLUS II是较成功的PLD开发平台，最新又推出了Quartus II开发软件。Altera公司提供较多形式的设计输入手段，绑定第三方VHDL综合工具，如：综合软件FPGA Express、Leonard Spectrum，仿真软件ModelSim。

（2）ILINX FPGA的发明者。产品种类较全，主要有；XC95004000、Coolrunner（XPLA3）、Spartan、Vertex等系列，其最大的VertexII Pro器件已达到800万门。开发软件为Foundation和ISE。通常来说，在欧洲用Xilinx的人多，在日本和亚太地区用ALTERA的人多，在美国则是平分秋色。全球PLDFPGA产品60%以上是由Altera和Xilinx提供的。可以讲Altera和Xilinx共同决定了PLD技术的发展方向。

（3）LatticeVantis Lattice是ISP（InSystem Programmability）技术的发明者，ISP技术极大地促进了PLD产品的发展，与ALTERA和XILINX相比，其开发工具比Altera和Xilinx略逊一筹。中小规模PLD比较有特色，大规模PLD的竞争力还不够强（Lattice没有基于查找表技术的大规模FPGA），1999年推出可编程模拟器件，1999年收购Vantis（原AMD子公司），成为第三大可编程逻辑器件供应商。2001年12月收购Agere公司（原Lucent微电子部）的FPGA部门。主要产品有ispLSI200050008000，MACH45。

（4）ACTEL 反熔丝（一次性烧写）PLD的领导得，由于反熔丝PLD抗辐射、耐高低温、功耗低、速度快，所以在军品和宇航级上有较大优势。ALTERA和XILINX则一般不涉足军品和宇航级市场。

（5）Quicklogic专业PLDFPGA公司，以一次性反熔丝工艺为主，在中国地区销售量不大。

（6）Lucent 主要特点是有不少用于通讯领域的专用IP核，但PLDFPGA不是Lucent的主要业务，在中国地区使用的人很少。

（7）ATMEL 中小规模PLD做得不错。ATMEL也做了一些与Altera和Xilinx兼容的片子，但在品质上与原厂家还是有一些差距，在高可靠性产品中使用较少，多用在低端产品上。

（8）Clear Logic 生产与一些着名PLDFPGA大公司兼容的芯片，这种芯片可将用户的设计一次性固化，不可编程，批量生产时的成本较低。

（9）WSI 生产PSD（单片机可编程外围芯片）产品。这是一种特殊的PLD，如最新的PSD8xx、PSD9xx集成了PLD、EPROM、Flash，并支持ISP（在线编程），集成度高，主要用于配合单片机工作。

PLD（可编程逻辑器件）是一种可以完全替代74系列及GAL、PLA的新型电路 ，只要有数字电路基础，会使用计算机，就可以进行PLD的开发。PLD的在线编程能力和强大的开发软件，使工程师可以在几天，甚至几分钟内就可完成以往几周才能完成的工作，并可将数百万门的复杂设计集成在一颗 芯片内。PLD技术在发达国家已成为电子工程师必备的技术。

### 5、其它EDA软件

（1）VHDL语言 超高速集成电路硬件描述语言（VHSIC Hardware Deseription Languagt，简称VHDL），是IEEE的一项标准设计语言。它源于美国国防部提出的超高速集成电路（Very High Speed Integrated Circuit，简称VHSIC）计划，是ASIC设计和PLD设计的一种主要输入工具。

（2）Veriolg HDL 是Verilog公司推出的硬件描述语言，在ASIC设计方面与VHDL语言平分秋色。

（3）其它EDA软件如专门用于微波电路设计和电力载波工具、[PCB](https://link.zhihu.com/?target=https%3A//www.brpcb.com/)制作和工艺流程控制等领域的工具。

发布于 2022-11-06 22:04・IP 属地河北