# Beremiz

[Beremiz](https://beremiz.org/)是一个免费、开源的软PLC控制系统，由法国人Edouard Tisserant开发[ 4 ] ^{[4]}[4]，主要开发语言是Python。出于对传统PLC壁垒森严的不满，Tisserant倡导了开源项目Beremiz，他也是CANfestival的作者。

　　Beremiz项目始于2005年，雏形只是一个编辑器，随后其它功能逐渐加入从而形成了一个完整的软PLC开发环境，其功能特点如下：

　　1. 支持多任务，多任务可配置不同的优先级，任务运行方式可以是周期式或中断触发式
　　2. 支持ST、梯形图等五种标准PLC编程语言
　　3. 提供IEC 61131-3标准规定的基本函数（定时器、比较、数学运算、类型转换、位操作、字符串等上百个函数）
　　4. 可扩展Modbus、CANopen、EtherCAT总线通讯模块（需自己移植到所选平台）
　　5. 支持C和Python语言，用户可以在PLC中调用C程序或者调用Python程序，也可以在Python中调用C程序
　　6. 支持仿真，但是不支持在线调试
　　7. 具有可视化界面（HMI），变量值可直观显示为图表

　　Beremiz的工作方式为：用户使用PLC语言编写应用程序，不管用户采用ST语言还是梯形图或者其它PLC语言，Beremiz都将其翻译成C语言，这是由MatIEC组件完成的。随后，gcc编译器将生成的C语言程序与总线通信程序一起编译链接得到二进制目标文件（Linux下是so文件，Windows下则是dll文件）。再之后，二进制目标文件被下载到目标设备上，目标设备上预先安装了runtime，runtime对目标文件进行调用完成相应的控制功能。

　　Beremiz的IDE和runtime两个部分的开发语言都是Python。只要可以运行Python的操作系都可以运行Beremiz，即其可在Windows、Linux、Mac OS等多种操作系统上运行，当然前提必须得有操作系统。Beremiz的任务调度完全依赖于操作系统，这意味着它的实时性受到操作系统的影响很大，因此最好选择实时操作系统，例如Xenomai、WinCE。

　　Beremiz衍生出了一些软件控制方案，例如OpenPLC、KOSMOS，在这些衍生物里更多的功能插件被加了进来，例如运动控制函数、总线通信函数、配置插件。

　　选择Python进行开发是因为这种语言简单易用，但是Python在工业控制领域很少使用，因为它无法提供实时性（受内存分配等因素影响）。即便如此，对Beremiz runtime的实时性进行了分析，并与CoDeSys runtime做了对比，结果表明Beremiz的实时性反而还优于CoDeSys。这可能是由于核心程序被翻译成C代码的原因，Python编写的runtime只是负责调用。这篇[文章](https://www.cnblogs.com/Xjng/p/5120853.html)比较了C和用Python调用C的性能，性能差距并不是特别悬殊。

　　Beremiz的介绍资料很少，并且其中一部分还是由俄文和法文撰写的，缺少深入探讨内部原理的文献。

### download
[https://bitbucket.org/automforge/beremiz](https://bitbucket.org/automforge/beremiz)