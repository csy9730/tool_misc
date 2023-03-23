# SoC芯片初窥！SoC设计方法学与实现（总结·上篇）

[![Trustintruth](https://picx.zhimg.com/v2-b88d1bd56e12dc73d8c2d8381419893a_l.jpg?source=172ae18b)](https://www.zhihu.com/people/suo-yi-xin-90)

[Trustintruth](https://www.zhihu.com/people/suo-yi-xin-90)[](https://www.zhihu.com/question/48510028)![img](https://pic1.zhimg.com/v2-4812630bc27d642f7cafcd6cdeca3d7a.jpg?source=88ceefae)

电子科技大学 集成电路工程硕士

56 人赞同了该文章

本文总结自教材《SoC设计方法与实现》

[![img](https://picx.zhimg.com/v2-eea5b7e7f0de22f0839472f8b0bb68e9_720w.jpg?source=b555e01d)SoC设计方法与实现（第3版）京东¥39.80去购买](https://union-click.jd.com/jdc?e=jdext-1304527045657862144-0&p=AyIGZRheEgMSA10ZWhcyEgRVHFgSBxA3EUQDS10iXhBeGlcJDBkNXg9JHUlSSkkFSRwSBFUcWBIHEBgMXgdIMmt1Dx4ddlkQZzcYM0tcZFw0ZhlhUGILWStbHAIQD1QaWxIBIgdUGlsRBxEEUxprJQIXNwd1g6O0yqLkB4%2B%2FjcePwitaJQIVBlcSWhcHGwJSHF4lAhoDZc31gdeauIyr%2FsOovNLYq46cqca50ytrJQEiXABPElAeEgVUHl8WBBMCURxfEwsVBFUeXgkDIgdUGlgTCxAFURo1EAMTBlUZXxUHEmlXGloVBhQFVRlTJQIiBGVFNRRREgVTHFtFbEhRFlBcS0FEaVATWxYDGjdXGloXAA%3D%3D)

本系列主要对课本知识总结，设计方法由板级向片上系统的转移。

[Trustintruth：SoC芯片初窥！SoC设计方法学与实现（总结·上篇补充）13 赞同 · 0 评论文章![img](https://pic4.zhimg.com/v2-ba7c695ff780613d4b217febf9dee49b_180x120.jpg)](https://zhuanlan.zhihu.com/p/276278807)

[Trustintruth：SoC芯片初窥！SoC设计方法学与实现（总结·中篇）58 赞同 · 8 评论文章![img](https://pic4.zhimg.com/v2-ba7c695ff780613d4b217febf9dee49b_180x120.jpg)](https://zhuanlan.zhihu.com/p/303261465)

[Trustintruth：SoC芯片初窥！SoC设计方法学与实现（总结·下篇）16 赞同 · 0 评论文章![img](https://pic4.zhimg.com/v2-ba7c695ff780613d4b217febf9dee49b_180x120.jpg)](https://zhuanlan.zhihu.com/p/317527501)

## 一.基础概念

首先说一说什么是芯片，通常所说的芯片是指集成电路，他是微电子产业的主要产品。在集成电路的发展中，为了适应技术发展与市场需求，产业结构发生了三次大变革，从最初的以生产为导向的初级阶段，到Foundry与fabless设计公司的崛起，再到“四业分离”的IC产业。集成电路产业链一般是这样：

![img](https://pic2.zhimg.com/80/v2-4117faa27e0fb753ae2c5b0336e416ed_720w.webp)

说完了集成电路，再来说SoC。SoC即系统级芯片，对他的定义为包括一个或多个计算引擎（微处理器/微控制器/数字信号处理器），至少10万门的逻辑和相当数量的存储器。现在的SoC中，要在芯片上整体实现CPU、DSP、数字电路，模拟电路、存储器及片上可编程逻辑等多种电路。SoC可以分为两类，一种是专用集成电路向系统级的发展，即专用SoC；另一种是通用SoC，将MCU、DSP、RAM、I/O等集成在芯片上。

在SoC的理念中，IP是构成SoC的基本单元，所谓的IP就是满足特定规范，并能在设计中复用的功能模块。

## 二.SoC设计流程

SoC通常被称为系统级芯片，或者片上系统，作为一个完整的系统，其包括了硬件和软件两个部分。

![img](https://pic4.zhimg.com/80/v2-be472c13dc7df5d3e608501694b36e03_720w.webp)

而基于标准单元的SoC芯片设计流程，包括以下步骤

![img](https://pic3.zhimg.com/80/v2-0a48c03a26cb778049efe7f4271703e2_720w.webp)

1. 硬件设计定义说明：硬件设计定义说明描述芯片总体结构、规则参数、模块划分、使用的总线，以及各个模块的详细定义。
2. 模块设计及IP复用：根据硬件设计所划分出的功能模块，确定需要重新设计的部分和可以重复用的IP核
3. 顶层模块集成：将各个不同模块，包括新设计的模块整合在一起，形成一个完整的设计。通常使用硬件描述语言对电路进行描述。
4. 前仿真：也叫RTL级仿真，功能仿真。通过HDL仿真器验证电路逻辑功能是否有效，即HDL描述是否符合设计所定义的功能期望。在前仿通常与具体电路电路实现无关。
5. 逻辑综合：使用EDA工具将硬件描述语言设计的电路自动转换为特定工艺下的网表，即从RTL级的HDL描述通过编译产生符合约束条件的门级网表。
6. 版图布局规划：确定设计中的各个模块在版图上的位置，主要包括I/O规划，模块放置，供电设计。布局布线的挑战是保证布线能够走通且行能满足的情况下，如何最大限度的减少芯片面积。
7. 功耗分析：决定了是否前面的设计进行改进版图布局规划之后，需要对电源网络进行功耗分析，确定电源引脚位和电源线宽度。
8. 单元布局优化：每个标准单元的摆放位置确定，并根据摆放位置进行优化。
9. 静态时序分析：提取电路中的所有路径的延时信息的分析，找到违背时序约束的错误。
10. 形式验证：是逻辑功能上的等效性检查，他不要输入测试向量，而是根据电路的结构判断两个设计在逻辑功能上是否相等。
11. 可测性设计插入：为了方便测试，逻辑电路采用扫描链的可测试结构，对于芯片的输入输出端口采用边界扫描的可测性结构。
12. 时钟树综合
13. 布线设计
14. 寄生参数提取：提取版图上内部所互联所产生的寄生电阻和电容值。
15. 后仿真：门级仿真，时序仿真，利用布局布线后获得的精准延迟等参数和网表，来确定网表功能和时序是否正确。
16. ECO修改：工程修改命令
17. 物理验证。

## 三.SoC设计与EDA工具

首先这些工具主要是为了设计，验证综合，可测性设计，布局布线物理验证参数提取等，主要针对就是上一部分的步骤。

SoC的设计趋势是从RTL向电子系统级（ESL）发展，协助工程师进行系统级设计，结构定义，算法开发，软硬件协同设计。常见的硬件协同设计验证工具有Mentor的Seamless和ARM公司的SoC Designer。

验证是主要是验证原始描述的正确性，验证设计的逻辑功能是否满足设计规范的性能指标等，可以分为静态验证和动态验证两种。电路级仿真工具有SPICE、NanoSim；逻辑仿真工具就比较常见，有VCS、ModelSim，形式验证有Synopsys的Formality等

逻辑综合主要就是Synopsys的RTL综合工具Design Compiler。

发布于 2020-11-01 16:24

[数字电路](https://www.zhihu.com/topic/19588724)

[微电子](https://www.zhihu.com/topic/19579527)

[芯片（集成电路）](https://www.zhihu.com/topic/19583435)