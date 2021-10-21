# CODESYS相关介绍

[![liyanfasd](https://pic2.zhimg.com/v2-5a0b6dc43f182b943fb8c66ffedba574_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/liyanfasd)

[liyanfasd](https://www.zhihu.com/people/liyanfasd)

天道酬勤度数载 厚积薄发看今朝



40 人赞同了该文章

德国**CODESYS**控股集团于1994年在德国巴伐利亚州成立，下设有德国欧德神思(**CODESYS**)有限公司和德国3S智能软件系统方案有限公司，多年来专注于自动化软件的研发和工业信息技术的专业化服务。



**CODESYS**技术优势：

CODESYS软件工具是一款基于先进的.NET架构和 IEC 61131-3国际编程标准的、面向工业4.0及物联网应用的软件开发平台。CODESYS软件平台的独特优势是用户使用此单一软件工具套件就可以实现一个完整的工业自动化解决方案，即在CODESYS软件平台下可以实现：逻辑控制（PLC）、运动控制（Motion Control）及CNC控制、人机界面（HMI）、基于Web Service的网络可视化编程和远程监控、冗余控制（Redundancy）和安全控制（Safety）等。

1. **标准化**

符合 IEC 61131-3国际标准（即提供六种编程语言）和 IEC 61508（安全标准）。

**2. 开放式、可重构的、组件化平台架构**

CODESYS可以向用户共享其全球领先的自动化开发平台中间件`CODESYS Automation Platform`，并倾力支持和帮助用户开发出拥有自主知识产权的开发环境。

基于.NET架构，CODESYS软件由各种组件化的功能件（编译器、调试器、运动控制、CNC、总线配置等）组成；用户可以根据自己的实际需求进行裁剪，并完全支持用户基于CODESYS公司提供的强大中间件产品和标准构建开发出封装有自主知识产权的功能组件和库。

**3. 良好的可移植性和强大的通信功能**

CODESYS完全支持EtherCAT、CANopen、Profibus、Modbus等主流的现场总线

CODESYS Runtime System可以运行在各种主流的CPU上，如ARM、X86，并支持Linux、Windows、VxWorks、QNX等操作系统或无操作系统的架构。

**4. 强大的运动控制和CNC功能**

支持单轴和轴组控制、CNC控制、机器人控制

**5. 支持第三方开发工具和应用程序**

具有OPC、OPC UA等功能



**CODESYS**产品种类和解决方案非常齐全，其中主要包括：

### 1. **面向工程应用编程的工具软件（CODESYS** Engineering**)**

**CODESYS** Engineering系统架构如下所示，

![img](https://pic1.zhimg.com/80/v2-bb225da4ca7dbad04091381ed0db9620_1440w.jpg)

#### 1.1 CODESYS Development System

CODESYS Development System也可称之为CODESYS IDE开发环境，是一款符合IEC 61131-3标准的全球领先的控制系统编程开发平台。该开发平台主要包括IEC 61131-3编辑器、配置器、编译器、调试器等功能模块。

#### 1.2 CODESYS Automation Platform

CODESYS IDE开发环境有CODESYS集团的logo，若想去掉IDE中的CODESYS logo加上自己公司的商标，可以考虑购买CODESYS Automation Platform，其支持用户定制化开发CODESYS上位机编程环境，经过客户的二次开发后，用户可以拥有自主知识产权的上位机。国内的汇川的InoProShop(CODESYS V3)、固高的OtoStudio(CODESYS V2.3)；国外的倍福的TwinCAT3、KEBA的KeMotion，都是基于CODESYS Automation Platformm深度定制、二次开发，形成了自己独特风格的IDE。

#### 1.3 CODESYS Professional Developer Edition

CODESYS Professional Developer Edition是CODESYS专业版的集成开发环境的附属产品。通过集成附加组件的形式，实现对CODESYS IDE的功能扩展。其主要包括：CODESYS SVN（版本管理器）、CODESYS UML（统一建模语言编辑器）、CODESYS Test Manager（自动化测试工具）、CODESYS Profiler（动态代码分析工具）、CODESYS Static Analysis（静态代码分析工具）。

#### 1.4 CODESYS Application Composer

CODESYS Application Composer是一种用于创建由循环功能块组成的应用程序的开发工具。使用该应用程序设计设计器，可以借助现有的应用程序模块高效地进行控制应用程序设计。

#### 1.5 C-Intergration

对于很多OEM客户而言，如果客户为应用程序开发人员，且对IEC 61131-3标准的编程语言不熟悉，则OEM客户可以通过附件组件C-Intergration，用C语言对功能块进行开发，并轻松地将此代码集成到IEC 61131-3项目中。

### 2. **工业级实时操作系统内核**（**CODESYS** Runtime）

**CODESYS** Runtime系统架构如下所示，

![img](https://pic3.zhimg.com/80/v2-55a6ca7172847ddeca009e405381c286_1440w.jpg)

#### 2.1 CODESYS Runtime Toolkit

想必这个大家都较为熟悉，国内很多公司和高校购买了CODESYS Runtime Toolkit。上面我们了解了CODESYS IDE、AP（Automation Platform）等，只有这些是远远不够的，为了使硬件设备可以使用基于IEC 61131-3标准的编程环境进行编程，必须在对应的硬件设备上移植CODESYS Runtime System，通过在硬件平台上移植Runtime，可以将任何嵌入式设备或基于PC的设备转变为符合IEC 61131-3标准的工业控制器。当然，从上图系统架构图蓝色方框可以推断出，CODESYS Runtime也支持二次开发功能。

#### 2.2 CODESYS PLCHandler

PLCHandler提供了第三方客户端和基于CODESYS开发的PLC之间建立通讯的功能，PLCHandler封装了完整的底层通讯协议，并提供了API接口。

#### 2.3 CODESYS OPC Server

略过

#### 2.4 CODESYS OPC UA Server

略过

#### 2.5 CODESYS Redundancy

两个 独立的工业控制器在不间断和同步的情况下，同时执行相同的IEC 61131-3应用程序。一旦出现意外情况，冗余从控制器自动切换成冗余主控制器，设备控制不会因此而中断或暂停。

#### 2.6 CODESYS Multicore

Multicore的特性是从V3.5 SP12版本开始支持的，其多核方案可以使得多CPU设备的性能发挥更佳。

### 3. **面向行业的工业云开发平台软件**（**CODESYS** Automation Server）

### 4. **可视化编程开发平台**（**CODESYS** Visualization）

#### 4.1 CODESYS TargetVisu

在CODESYS中创建的可视化界面可以显示在配备有CODESYS TargetVisu的控制器上，无需任何其它的硬件，可视化界面直接显示在控制器的内置或外置显示器上。当然，若想实现显控一体，要求控制器的性能尽可能高，CPU核数尽可能多，最好用V3.5 SP12及以上版本的CODESYS Runtime。

#### 4.2 CODESYS WebVisu

显示在标准浏览器上的可视化界面，便于远程监视。

#### 4.3 CODESYS HMI

在上位的CODESYS开发系统中可以直接创建可视化界面，并通过CODESYS HMI显示在外置的专用显示设备上，通过CODESYS Data Server可以实现显示设备与控制器的通讯。

### 5. **数控与机器人控制模块**（**CODESYS** SoftMotion CNC+Robotics）

CODESYS Motion+CNC架构图，

![img](https://pic2.zhimg.com/80/v2-10685dd21a69bd3fcb5e14e2cdd8c665_1440w.jpg)

CODESYS的运动控制是其在同类竞争对手中的一个最突出的竞争优势。CODESYS将运动控制与逻辑控制合二为一，集成在IEC 61131-3标准的CODESYS Development System和CODESYS Runtime运行软件中，形成了CODESYS SoftMotion（CNC + Robotics）工具包软件。从单轴运动到复杂CNC控制和机器人应用，都可以使用CODESYS SoftMotion（CNC + Robotics）来编程实现。

CODESYS SoftMotion（CNC + Robotics）技术特点，

运动控制编程独立于总线和驱动器；

支持在集成的编辑器中设计电子凸轮；

支持集成的DIN 66025编辑器（支持G代码，M代码，H代码）来规划和编辑复杂的动作；

通过使用PLCopen Motion Part 4 和轴组编辑器来开发多轴机器人控制器;

具备丰富的运动控制算法库，包括几何数据处理，样条曲线计算，CNC刀具补偿等；

包含丰富的运动学变换库以支持不同工业机器人的开发；

支持在线的CAM编辑器和CNC编辑器，机器操作员可以图形化的方式创建和编辑CNC程序。

### 6. **现场总线协议栈**（**CODESYS** Fieldbus）

除了基于IEC 61131-3的控制器开发功能外，CODESYS还提供了广泛的现场总线的支持，如Profibus、Profinet、EtherCAT、CANopen、Modbus、IO-Link等。当然，所有的现场总线协议栈需要购买才能使用。

### 7. **安全控制器开发平台**（**CODESYS** Safety）

CODESYS Safety为制造商开发了基于IEC 61508 SIL2和SIL3标准的安全控制器提供了完整的解决方案。使用CODESYS Safety，可大大减少制造商的开发成本并提高认证效率。CODESYS公司在安全控制器方面具有丰富的专业知识和多年的经验，可以为安全控制器制造商在安全软件方面提供有力的支持。





本人不才，工作中涉及到CODESYS Runtime中组件的二次开发和CODESYS Development System的使用，遂牛刀小试，写成文章，后面陆续发布的文章，主要侧重点在CODESYS Runtime中组件的二次开发方面，与同道中人相互交流，与君共勉。



后面陆续发布的文章列表如下（持续更新中...），

1. CODESYS Runtime Toolkit简介。
2. CODESYS Runtime在控制器上的移植。
3. 如何用CODESYS Runtime Toolkit IoDrvTemplate模板在自主控制器上开发自定义的I/O Driver。
4. 如何用CODESYS Runtime Toolkit CmpTemplate模块在自主控制器上开发自定义的组件。
5. 如何将CODESYS任务配置为外部事件触发，提高系统响应速度。
6. 如何在CODESYS中开发一主多从架构的程序，可在CODESYS IDE进行统一的管理和监视。
7. 如何在 CODESYS IDE中开发PLC Shell命令。
8. 多个控制器在同一网络中如何有效识别的问题。

发布于 2018-11-13

工业机器人

赞同 40