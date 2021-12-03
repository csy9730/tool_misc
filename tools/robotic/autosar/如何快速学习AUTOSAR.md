# 如何快速学习AUTOSAR?

[![Demu](https://pica.zhimg.com/v2-36ca4466b5fa40ff116cd80a6e29250c_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/young_)

[Demu](https://www.zhihu.com/people/young_)

汽车控制与人工智能



95 人赞同了该文章

做汽车电子领域，但是没有软件基础，如何学习AUTOSAR呢？估计很多刚开始接触AUTOSAR的同学都有类似的疑问，简单分享下AUTOSAR的概览和学习技巧，希望能帮助到大家。

关于AUTOSAR的背景和架构信息，这里就不详细展开了。大家可以参看：

[AUTOSAR的分层架构](https://link.zhihu.com/?target=http%3A//mp.weixin.qq.com/s%3F__biz%3DMzA3NDQ4MjIzNA%3D%3D%26mid%3D2247483958%26idx%3D1%26sn%3D206f4d3cab3dc3504bd696cba8dad119%26chksm%3D9f7e5563a809dc75c79ccaa75e851b7fd4ab0d3bee402eb73b11fa9676525e70d07aa036912d%26scene%3D21%23wechat_redirect) 一文了解。今天我们重点讲讲如何快速学习AUTOSAR架构的方法。

**如何获取规范文档？**

从2003年成立以来，AUTOSAR目前已经更新到AUTOSAR 4.4.0 release版本，后台回复“AUTOSAR”可以获取。当然，你也可以从官网获取最新的规范文档，网址：[https://www.autosar.org/standards](https://link.zhihu.com/?target=https%3A//www.autosar.org/standards)。

2018年，为了迎合未来汽车智能化、网联化的需求，AUTOSAR联盟推出了一个全新的平台，将AP加入到原有的AUTOSAR平台中，形成自适应AUTOSAR平台（AUTOSAR Adaptive Platform，AP），并于2018年10月迎来了适用于面向量产的首次发布，另外还将原有平台更名为经典AUTOSAR平台（AUTOSAR Classic Platform)和自适应平台AUTOSAR(AUTOSAR Adaptive Platform)，行业内大家习惯叫CP（Classic Platform）和AP（Adaptive Platform），下次有人提到CP还是AP的时候，可不要说没听过。AP目前国内了解的人非常少，如果你想做吃螃蟹的人，可以提前自己定位学习。AUTOSAR官网有规范材料。后台回复“AP”和“CP”获取规范文档。后续有机会，Demu大叔也研究研究AP，再跟大家分享。如果有非常了解的同学，也欢迎投稿和大家一起分享。

![img](https://pic3.zhimg.com/80/v2-d63930e9caead867f8649bfea406944a_1440w.jpg)



**基本概念**


Software Component (SW-C)：软件组件

Virtual Functional Bus (VFB)：虚拟功能总线

Runtime Environment (RTE)：运行环境（实时环境）

Basic Software（BSW）:基础软件

Methodology principle：方法论原理

Mode Management：[模式管理](https://www.zhihu.com/search?q=模式管理&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A90018253})

Memory Abstraction：存储抽象

Runnables：可运行实体



**文档命名规则**



EXP: 即Explaination"解释"，详细介绍论题

MMOD: 即Meta Model"元模型",介绍 AUTOSAR元模型

MOD: 即Model"建模",介绍建模的原理

RS: 即Requirement Specification"[需求规范](https://www.zhihu.com/search?q=需求规范&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A90018253})", 详细介绍需求

SRS: 即Softeware Requirement Specification"[软件需求规范](https://www.zhihu.com/search?q=软件需求规范&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A90018253})", 描述所有软件模块的规范

SWS: 即Softeware Specification"[软件规范](https://www.zhihu.com/search?q=软件规范&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A90018253})", 介绍软件模块设计和实现的规范

TPS: 即Template Specification"[模板规范](https://www.zhihu.com/search?q=模板规范&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A90018253})", 详细介绍元模型

TR: 即Technical Specification"[技术规范](https://www.zhihu.com/search?q=技术规范&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A90018253})",详细介绍技术规范



**你的工作内容**



有了以上了解，拿到规范文档后，你会发现内容简直太多了，多到不可能有哪位大神能将其完全拜读。那怎么去掌握个中精要呢？

你需要明确你的工作内容在整个产品生命周期的位置。简单介绍下几个流程概念。

![img](https://pic3.zhimg.com/80/v2-609e7b5b58a41f6c80791d026975930a_1440w.jpg)

圈内的同学比较了解上面提到的几个名词，研究AUTOSAR的工程师在OEM、TIER1和TIER2都会有分布，各自角色不同，研究重点也不同。我们按产品开发流程的顺序大致梳理：

1. 整车厂以EE架构设计和应用层功能设计为主，所以如果你身在OEM中，你只需要着重了解AUTOSAR的方法论和基于方法论的SWC设计即可。这两点说着简单，其实并非我们想象中那么简单。方法论本身就是非常宏观的概念，想要把控产品流程，能为TIER1提供明确需求文档，这本身就要对功能和下游工作十分了解，才能有高质量的输出；
2. TIER1涉及AUTOSAR的工作分工就比较多了。
   如果你是系统工程师，着重研究功能算法的实现，那么你需要对SWC的升级了如指掌，深入理解；如果你是软件架构工程师，对于上游OEM提供的需求文档要有宏观概念，所以也要对方法论和SWC审计十分了解；
   如果你是基础软件工程师，需要整个团队协同实现：底层驱动工程师要深入学习芯片的抽象层MCAL应用；BSW[协议栈工程师](https://www.zhihu.com/search?q=协议栈工程师&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A90018253})要熟悉OS，ComStack，DiagStack，Memory Stack，WgdStack等协议栈应用细节；复杂驱动工程师，要对AUTOSAR针对CDRV的接口定义方式等深入研究；
   如果[集成工程师](https://www.zhihu.com/search?q=集成工程师&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A90018253})，要十分清楚RTE的运行集成和相关应用配置；
3. TIER2要深入研究的内容和TIER1的BSW工程师侧重内容相似，主要围绕芯片MCAL和基础软件协议栈展开。
4. 除了以上三类产品开发流程上的角色外，其实还有一个重要角色的存在：工具供应商。了解了AUTOSAR架构和实现过程后，大家可能会看到很多arxml格式的配置文件的制作都离不开工具的支持，以及编译环境、建模工具等，都离不开一直走在超前道路上的工具供应商。

画张简图大致说明一下AUTOSAR的开发流程。

![img](https://pic2.zhimg.com/80/v2-23aaef88dbcf29f90847d8826577d13d_1440w.jpg)

（高清图后台回复“AutoSAR开发流程”获取）

了解了AUTOSAR的开发流程，结合你在整个产品开发流程中所处的位置，就可以精准地定位你的学习重点了，然后就可以选取其中的文档仔细研究。当然，说到这里，其实还有一个非常重要的前提——拥有扎实的C语言功底。如果你的工作岗位不是[软件工程师](https://www.zhihu.com/search?q=软件工程师&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A90018253})，你的C语言积累可能在大学没毕业就还给老师了。这种情况下，想要成为一名优秀的软件工程师，你可能需要在8小时外自己多花些时间和精力补补，网上有很多高级语言的学习材料，自己不要懈怠才好。

希望大家能找到方法，学有所成，早日成长为各自领域的专家，为[民族工业](https://www.zhihu.com/search?q=民族工业&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A90018253})的发展贡献自己的力量。

欢迎关注微信公众号“汽车控制与人工智能”。

![img](https://pic1.zhimg.com/80/v2-a33fdd2acd0e2752d9792d49be883c04_1440w.jpg)







编辑于 2019-11-04 12:25

autosar

汽车电子控制

汽车电子

赞同 95

3 条评论

分享