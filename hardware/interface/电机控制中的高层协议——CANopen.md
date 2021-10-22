# 电机控制中的高层协议——CANopen

[![只是学电的](https://pic4.zhimg.com/bd114b4a16162d3720ac8ff47047f6a9_xs.jpg)](https://www.zhihu.com/people/xing--91)

[只是学电的](https://www.zhihu.com/people/xing--91)



电气工程硕士



62 人赞同了该文章

接着上一篇的CAN总线的话题继续，电机控制里面用到CANopen协议比较多。

我们说从OSI 网络模型的角度来看同，现场总线网络一般只实现了**第****1****层**（ 物理层），**第****2****层**（数据链路层）、**第****7****层**（应用层）。 为什么不见3，4，5，6层呢？

因为现场总线**通常只包括一个网段，**因此不需要第3层（传输层）和第4层（网络层），也不需要第 5 层（会话层）第 6 层（描述层）的作用。

在实际的设计中，物理层和数据链路层，这两层**完全由硬件实现**，设计人员无需为此开发相关软件（Software）或固件（Firmware）。同时，由于**CAN****只定义物理层和数据链路层， 没有规定应用层，本身并不完整，需要一个高层协议来定义****CAN报文中的 11/29 位标识符、8 字节数据的使用。**

而且，基于CAN总线的工业自动化应用中，越来越需要一个开放的、标准化的高层协议： 这个协议应该可以支持各种CAN 厂商设备的互用性、互换性，并且希望它能够实现在CAN网络中提供标准的、统一的系统通讯模式，提供设备功能描述方式，执行网络管理功能。

今天我要介绍给大家的是基于CAN 的高层协议： CAL 协议和基于CAL 协议扩展的 CANopen 协议。CANopen协议是 **CAN-in-Automation(CiA)****定义的标准之一**， 并且在发布后不久就获得了广泛的承认。 **尤其是在欧洲，****CANopen** **协议被认为是在基于** **CAN** **的工业系统中占领导地位的标准。**

**CiA官网：CAN in Automation (CiA): Controller Area Network (CAN)**

在 OSI 模型中，CAN标准、CANopen 协议之间的关系如下图所示：

![img](https://pic4.zhimg.com/80/v2-d49139a7c0ceb7b5e9b01eb73d593547_1440w.png)

大多数重要的设备类型，例如数字和模拟的输入输出模块、驱动设备、操作设备、

控制器

、可编程控制器或编码器，都在称为“设备描述”的协议中进行描述；“设备描述” 定义了不同类型的标准设备及其相应的功能。 依靠 CANopen 协议的支持，可以对不同厂商的设备通过总线进行配置。

**CAL** **协议**

CAL（ CAN Application Layer）协议是目前基于CAN的高层通讯协议中的一种【见附1】，最早由 Philips 医疗设备部门制定。现在 CAL 由独立的 CAN 用户和制造商集团 **CiA**（ CAN in Automation） 协会负责管理、发展和推广。

CAL（CAN Application Layer）协议是目前基于CAN的高层通讯协议中的

一种

，最早由 Philips医疗设备部门制定。现在CAL由独立的CAN 用户和制造商集团 CiA（CAN in Automation） 协会负责管理、 发展和推广。

CAL 提供了**4** **种应用层服务功能**：


1.CMS (CAN-based Message Specification)

CMS 提供了一个开放的、面向对象的环境，用于实现用户的应用。CMS 提供基于变量、事件、域类型的对象，以设计和规定一个设备（节点）的功能如何被访问（例如，如何上载下载超过8字节的一组数据（域），并且有终止传输的功能）。CMS 从 MMS (Manufacturing Message Specification)继承而来。MMS 是OSI 为工业设备的远程控制和监控而制定的应用层规范。


2.NMT (Network ManagemenT)
提供网络管理（如初始化、启动和停止节点，侦测失效节点） 服务。这种服务是采用主从通讯模式（所以只有一个 NMT 主节点）来实现的。


\3. DBT (DistriBuTor)
**提供动态分配** **CAN ID**（正式名称为 COB-ID， Communication Object Identifier）服务。这种服务是采用主从通讯模式（所以只有一个 DBT 主节点）来实现的。


\4. LMT (Layer ManagemenT)
LMT 提供修改层参数的服务： 一个节点（ LMT Master） 可以设置另外一个节点（ LMT Slave）的某层参数（如改变一个节点的 NMT 地址，或改变 CAN 接口的位定时和波特率）。

## **CANopen**

CAL 提供了所有的网络管理服务和报文传送协议，

但并没有定义 

CMS 

对象的内容或者正在通讯的对

象的类型

（它只定义了how，没有定义what）。而这正是 CANopen 切入点。


CANopen 是在 CAL 基础上开发的， 使用了 CAL 通讯和服务协议子集， 提供了分布式控制系统的一种实现方案。 CANopen 在保证网络节点互用性的同时允许节点的功能随意扩展：或简单或复杂。
**CANopen** **的核心概念是设备对象字典** （OD：Object Dictionary），在其它现场总线 （ Profibus， Interbus-S）系统中也使用这种设备描述形式。

注意：对象字典不是 CAL 的一部分，而是在CANopen中实现的。



**总结**

基于 CAN 总线的 CANopen 网络通讯具有以下特点：

1. 使用对象字典（ OD： Object Dictionary）对设备功能进行标准化的描述。z 使用 ASCII 文档： 电子数据文档（ EDS） 和设备配置文件（ DCF） 对设备及其配置进行标准化的描述。
2. CANopen 网络的数据交换和系统管理基于 CAL 中 CMS 服务。

参考资料：《CANopen： high-level protocol for CAN-bus》

**高校里面电机控制目前大多使用的控制器是TI公司的28335，下面就具体看看 Introduction to the Controller Area Network (CAN)**

## **The CAN Bus**



![img](https://pic3.zhimg.com/80/v2-52d5a61df1c36c8ec5b47c1ef87fa602_1440w.png)

The

 

data link and physical signaling layers

, which are normally transparent to a system operator,

 

are included in any controller that implements the CAN protocol，

such as TI's TMS320LF2812 3.3-V DSP with integrated CAN controller.



Connection to the physical medium is then implemented through a line **transceiver （收发器）**such as TI's **SN65HVD230** 3.3-V CAN transceiver to form a system node .[SN65HVD230 中文资料](https://link.zhihu.com/?target=http%3A//www.docin.com/p-260610422.html)

The two signal lines of the bus, CANH and CANL, in the quiescent recessive state, are **passively biased to** **≈ 2.5 V.** The dominant state on the bus takes CANH ≈ 1 V higher to ≈ 3.5 V, and takes CANL ≈ 1 V lower to ≈ 1.5 V, creating a typical 2-V differential signal.



![img](https://pic2.zhimg.com/80/v2-60f4f04142dd489e1527a6bd815150dd_1440w.png)

The CAN standard defines a communication network that links all the nodes connected to a bus and enables them to talk with one another. There may or may not be a central control node, and nodes may be added at any time, even while the network is operating (hot-plugging).



具体使用28335如何开发eCAN可以参考一下帖子。

[如何利用CANopen控制伺服电机？ - 电子技术](https://www.zhihu.com/question/51340422)

[【TI博客大赛】TMS320F28335之eCAN](https://link.zhihu.com/?target=http%3A//bbs.ednchina.com/BLOG_ARTICLE_3008950.HTM)

————————————————————————

**附1：一些可使用的 CAN 高层协议：**

制定组织 主要高层协议

CiA CAL 协议
CiA CANOpen 协议
ODVA DeviceNet 协议
Honeywell SDS 协议
Kvaser CANKingdom 协议】

**附2：标准CAN和扩展CAN**

标准 CAN 的标志符长度是 **11** 位，而扩展格式 CAN 的标志符长度可达 **29** 位。

CAN 协议的 2.0A 版本规定 CAN 控制器必须有一个 11 位的标志符。同时，在2.0B 版本中规定， CAN 控制器的标志符长度可以是 11 位或 29 位。遵循 CAN2.0B 协议的 CAN 控制器可以发送和接收11位标识符的标准格式报文或29位标识符的扩展格式报文。 如果禁止 CAN2.0B则CAN 控制器只能发送和接收11位标识符的标准格式报文，而忽略扩展格式的报文结构，但不会出现错误。

**附3：CiA简介**

CiA 全称为“CAN in Automation-国际用户和厂商协会，在德国 Erlangen 注册。CiA 总部位于 Erlangen，并由 CiA 董事会建立各个办事处。
1992 年，为促进CAN以及 CAN 协议的发展，欧洲的一些公司组成一个商业协会，提供 CAN的技术，产品以及市场信息。到 2002 年 6 月时， 共有约 400 家公司加入了这个协会，协作开发和支持各类 CAN 高层协议。**经过近十年的发展，该协会已经为全球应用 CAN 技术的权威。**

编辑于 2016-10-12

CAN总线

电气工程

电机

赞同 62