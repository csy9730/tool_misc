# AUTOSAR架构软件结构简介

[![末离](https://pic3.zhimg.com/v2-ab72399b1b636fc68b242d62f325278b_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/mo-chi-54)

[末离](https://www.zhihu.com/people/mo-chi-54)





163 人赞同了该文章

近年随着汽车电子化、智能化发展，汽车CAN总线上搭载的ECU日益增多。各汽车制造商车型因策略不同ECU数目略有不同，但据统计平均一台车约为25个模块，某些高端车型则高达百余个。同时娱乐信息系统作为「人类第三屏」，交互体验正不断扩展，加上车联网程度的逐步加深，整车系统的**通信数据量正在以量级增长**。

汽车电子领域迫切需要有一种全新的整车软件设计标准来应对愈加复杂的电子设计。为此，在2003年**欧洲宝马**为首几家OEM巨头与一些**Tier1**成立AUTOSAR联盟，致力于为汽车工业开发一套支持分布式的、功能驱动的汽车电子软件开发方法和电子控制单元上的**软件架构标准化方案**，也就是我们常听到的AUTOSAR（**AUT**omotive **O**pen **S**ystem **AR**chitecture）。

![img](https://pic3.zhimg.com/80/v2-362efd081a7529df167231a462306d32_1440w.jpg)

整车软件系统可通过[AUTOSAR架构](https://www.zhihu.com/search?q=AUTOSAR架构&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A25219257})对**车载网络、系统内存**及**总线的诊断功能**进行深度管理，它的出现有利于整车电子系统软件的更新与交换，并改善了系统的可靠性和稳定性。

目前支持AUTOSAR标准的工具和软件供应商都已经推出了相应的产品，提供需求管理，系统描述，软件构件算法模型验证，软件构建算法建模，软件构件代码生成，RTE生成，ECU配置以及基础软件和操作系统等服务，帮助OEM实现无缝的[系统软件](https://www.zhihu.com/search?q=系统软件&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A25219257})架构开发流程。

## **AUTOSAR的分层设计**

AUTOSAR计划目标主要有三个：

1. 建立独立于硬件的[分层软件](https://www.zhihu.com/search?q=分层软件&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A25219257})架构
2. 为实施应用提供方法论，包括制定无缝的[软件架构](https://www.zhihu.com/search?q=软件架构&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A25219257})堆叠流程并将应用软件整合至ECU
3. 制定各种车辆应用接口规范，作为应用软件整合标准，以便软件构件在不同汽车平台复用



![img](https://pic2.zhimg.com/80/v2-e5a5fefffb52befc66586ee6fee84fb5_1440w.png)

AUTOSAR整体框架为

[分层式设计](https://www.zhihu.com/search?q=分层式设计&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A25219257})

，以中间件

RTE(Runtime Environment)

为界，隔离上层的

应用层（Application Layer）

与下层的

[基础软件](https://www.zhihu.com/search?q=基础软件&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A25219257})（Basic Software）。



## **软件组件SWC VFB与RTE**

应用层中的功能由**各软件组件（SWC）**实现，组件中封装了部分或者全部汽车电子功能，包括对其具体功能的实现以及对应描述，如控制大灯，空调等部件的运作，但与汽车硬件系统没有连接。

在设计开发阶段中，软件组件通信层面引入了一个新的概念，**虚拟功能总线VFB**（Virtual Functional Bus），它是对AUTOSAR所有通信机制的抽象，利用VFB，开发工程师将软件组件的通信细节抽象，只需要通过AUTOSAR所定义的接口进行描述，即能够实现软件组件与其他组件以及硬件之间的通信，甚至ECU内部或者是与其他ECU之间的数据传输。

![img](https://pic4.zhimg.com/80/v2-975cbb535978b788ac2f53ecfbdad09f_1440w.png)

因此软件组件只需向VFB发送输出信号，VFB将信息传输给目标组建的输入端口，这样的方式使得在硬件定义之前，即可完成功能软件的验证，而不需要依赖于传统的硬件系统。

![img](https://pic4.zhimg.com/80/v2-502f116f9228f5c70618e1c430718307_1440w.png)

中间件RTE与**面向对象OO（object oriented）**的编程思想非常接近，所有ECU所对应的RTE都是特定的，它负责着[软件构件](https://www.zhihu.com/search?q=软件构件&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A25219257})间以及软件构件与基础软件之间的通信。对于软件构件来说，基础软件不能够直接访问，必须通过RTE进入。**因而RTE也被理解成是VFB的接口实现。**

![img](https://pic1.zhimg.com/80/v2-acded0cce6f7816f3b51a0c9229996a0_1440w.png)

而**构件之间**及**构件与基础软件**的通信关系如图所示：

![img](https://pic3.zhimg.com/80/v2-5d42963ee17a3c0f1a3f01c95fcf490e_1440w.jpg)

值得注意的是，AUTOSAR软件构件**无法直接访问**基础软件中的操作系统OS，因而在应用程序中就不存在「task」的概念，且不能动态创建线程，因此并行的任务由RTE直接管理调入的「构件运行实体」来实现。每个软件构件也许会有一个或者多个运行实体，但是一个运行实体只对应一个入口。

## **基础软件层 BSW**

基础软件则被抽象为四层：

![img](https://pic1.zhimg.com/80/v2-66675c3d2d58238447bd0841bc4b3ab8_1440w.jpg)

- 服务层（Services Layer）
- ECU抽象层（ECU Abstraction Layer）
- 微控制器抽象层（Microcontroller Abstraction Layer）
- 复杂驱动（Complex Device Drivers）

**服务层**包含RTOS、通信与网络管理、内存管理、诊断服务、状态管理、[程序监控](https://www.zhihu.com/search?q=程序监控&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A25219257})等服务；

**ECU抽象层**中封装了微控制器层及外围设备的驱动，并对微控制器内外设的访问进行了统一，实现了[软件应用层](https://www.zhihu.com/search?q=软件应用层&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A25219257})与硬件系统的分离。

**微控制器抽象层**位于基础软件的最底层，包含了访问微控制器的驱动（如I/O驱动、ADC驱动等），做到了上层软件与微控制器的分离，以便应用的后续的移植复用。

**复杂驱动**由于其严格的时序为应用层通过RTE访问硬件提供支持。

AUTOSAR软件架构的提出与推广将有效缩短OEM研发与测试新架构车型的时间，未来也将会有越来越多的企业与供应商加入到AUTOSAR无缝解决方案的制定中，一定程度上将提高不同车型平台的软件复用性，从而整体市场的研发成本与开发周期。

编辑于 2017-02-13 19:48

汽车电子

通信协议

汽车总线