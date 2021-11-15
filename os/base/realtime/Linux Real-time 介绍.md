# Linux Real-time 介绍

[![陈鑫 JasonChen](https://pic2.zhimg.com/v2-203bc7c7ea4d128b485693745cbd4d43_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/xiao-xin-11-56)

[陈鑫 JasonChen](https://www.zhihu.com/people/xiao-xin-11-56)



上海傅利叶智能科技有限公司 算法研发经理



29 人赞同了该文章

> **写作说明：**
> \- 本文写作出于对现有市面上的大部分 Linux 的实时操作系统补丁做比较，用于选择合适的实时操作系统补丁。同时也是用于个人做一个总结，加速后续的开发。
> \- 本文主要用于比较了 Xenomai, RTAI, Vxworks。

## 实时系统

一般嵌入式系统分为两种：**前后台系统**和**实时系统**。

### **1. 前后台系统**

- 早期嵌入式开发没有嵌入式操作系统的概念 ，直接操作裸机，在裸机上写程序，比如用51单片机基本就没有操作系统的概念。通常把程序分为两部分：**前台系统** 和 **后台系统**。
- 简单的小系统通常是前后台系统，这样的程序包括一个死循环和若干个中断服务程序：应用程序是一个无限循环，循环中调用API函数完成所需的操作，这个大循环就叫做后台系统。中断服务程序用于处理系统的异步事件，也就是前台系统。前台是中断级，后台是任务级。

![img](https://pic1.zhimg.com/80/v2-ccc75ebf094bf449530e7c3e73134da8_1440w.jpg)Back-fore Ground System Work Flow

### **2. RTOS 系统**

- RTOS全称为：**Real Time OS**，就是实时操作系统，强调的是：**实时性**。

- 实时操作系统又分为**硬实时**和**软实时**。

- - **硬实时**要求在规定的时间内必须完成操作 ，硬实时系统不允许超时。
  - 在**软实时**里面处理过程超时的后果就没有那么严格。

- 在实时操作系统中，我们可以把要实现的功能划分为多个任务，每个任务负责实现其中的一部分，每个任务都是一个很简单的程序，通常是一个死循环。

- RTOS操作系统：

- - FreeRTOS，UCOS，RTX，RT-Thread，DJYOS等。

- RTOS操作系统的核心内容在于：**实时内核**。

**2.1 可剥夺型内核**

- RTOS的内核负责管理所有的任务，**内核决定了运行哪个任务，何时停止当前任务切换到其他任务，这个是内核的多任务管理能力**。多任务管理给人的感觉就好像芯片有多个CPU，多任务管理实现了CPU资源的最大化利用，多任务管理有助于实现程序的模块化开发，能够实现复杂的实时应用。
- 可剥夺内核顾名思义就是可以剥夺其他任务的CPU使用权，它总是运行就绪任务中的优先级最高的那个任务。

![img](https://pic1.zhimg.com/80/v2-9282f634e056aa8f6a98b97eb6936d98_1440w.jpg)Real-time System Work Flow

### 3. 各个实时补丁比较

参考文献：

[Performance Comparison of VxWorks, Linux, RTAI and Xenomai in a Hard Real-time Applicationieeexplore.ieee.org/document/4382787](https://link.zhihu.com/?target=https%3A//ieeexplore.ieee.org/document/4382787)

目前给 Linux 打实时补丁，主要有两个开源的 Linux 扩展：RTAI[[1\]](https://zhuanlan.zhihu.com/p/147563274#ref_1)[[2\]](https://zhuanlan.zhihu.com/p/147563274#ref_2) 和 Xenomai[[3\]](https://zhuanlan.zhihu.com/p/147563274#ref_3)。这两个开源补丁使用类似的设计思想，通过添加一个额外的插件来跟 Linux 一起工作。下面是两个实时补丁的架构图。

![img](https://pic4.zhimg.com/80/v2-48be27fe6a65f9576bf1bddec27140ef_1440w.jpg)The Structure of Xenomai and RTAI

两者都是基于 ADEOS 这个**微内核（nanokernel）**[[4\]](https://zhuanlan.zhihu.com/p/147563274#ref_4)[[5\]](https://zhuanlan.zhihu.com/p/147563274#ref_5)进行的开发。ADEOS 将 Linux 的硬件层抽象出来，提供了统一的接口。同时，ADEOS 也对系统的中断进行了统一的管理。因而，Xenomai 和 RTAI 可以使用这个 ADEOS 作为一个通信的媒介，完成对 Linux 的硬件的控制。不同于 Xenomai 的是，RTAI 把中断的处理主导权放在自身，而 Xenomai 是使用 ADEOS 的中断处理。

文中对 VxWorks, Xenomai, RTAI, Linux 使用 `acqloop()` 做了比较，并得出以下结果：

![img](https://pic3.zhimg.com/80/v2-0fbe96fae494bbb40682a674a5bad612_1440w.jpg)

![img](https://pic3.zhimg.com/80/v2-84df582ee4e5d5978d307820e8acc672_1440w.jpg)

![img](https://pic3.zhimg.com/80/v2-31f2757b9ad957422365918c0bcc7ca2_1440w.jpg)

> **思考：**
> \- 可以看到，RTAI 和 Xenomai 的性能还是很强的，延时基本在 us 级，在实际使用时，可以根据具体需要进行选择。

### 4. RTAI 安装

参考：

[安装RTAI5.2 基于Ubuntu18.04和4.14.111 内核blog.foool.net/2019/09/%E5%AE%89%E8%A3%85rtai5-2-%E5%9F%BA%E4%BA%8Eubuntu18-04%E5%92%8C4-14-111-%E5%86%85%E6%A0%B8/](https://link.zhihu.com/?target=http%3A//blog.foool.net/2019/09/%E5%AE%89%E8%A3%85rtai5-2-%E5%9F%BA%E4%BA%8Eubuntu18-04%E5%92%8C4-14-111-%E5%86%85%E6%A0%B8/)



## 参考

1. [^](https://zhuanlan.zhihu.com/p/147563274#ref_1_0)RTAI Home page, [Online]. Available: http:// www.rtai.org
2. [^](https://zhuanlan.zhihu.com/p/147563274#ref_2_0) P. Cloutier, P. Mantegazza, S. Papacharalambous, I. Soanes, S. Hughes, and K. Yaghmour, in DIAPM-RTAI position paper, Nov. 2000, RTSS 2000—Real Time Operating System Workshop, 2000.
3. [^](https://zhuanlan.zhihu.com/p/147563274#ref_3_0) Xenomai home page, [Online]. Available: http://www.Xenomai.org.
4. [^](https://zhuanlan.zhihu.com/p/147563274#ref_4_0) ADEOS home page, [Online]. Available: http://www.adeos.org.
5. [^](https://zhuanlan.zhihu.com/p/147563274#ref_5_0)Karim Yaghmour Opersys Inc., Adaptive Domain Environment for Operating Systems, 2001. [Online]. Available: http://www.opersys.com/ ftp/pub/Adeos/adeos.ps.

编辑于 2020-06-11

Linux

实时系统

机器人

赞同 29

1 条评论

分享