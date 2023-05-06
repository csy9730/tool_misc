# MIT6.828-神级OS课程-要是早遇到，我还会是这种 five 系列

[![一丁点儿](https://pic1.zhimg.com/v2-fb6eaee6cdfd39b6f7a370e39333340b_l.jpg?source=172ae18b)](https://www.zhihu.com/people/dee-201)

[一丁点儿](https://www.zhihu.com/people/dee-201)

凡我不能创造的，我就不能理解。

3,759 人赞同了该文章

## MIT6.828 Operating System Engineering

花了两个月多的时间，终于把 MIT6.828 的课程跟完了。刚接触这个课程时，就有一种感觉：哇，好神奇！ 这个课程真的是循序渐进，一步一步在你的脑海里建立起 OS 的大厦框架。从 Lab1 的手把手教学到 Lab6 的放任你自由，很好地对学生的学习进行了引导。学完这个课程后，你也就拥有了一个属于你自己的完整的内核雏形！

当然这个课程需要一些基础，如汇编语言、操作系统、计算机组成原理以及体系结构等。毕竟操作系统是一门比较底层且考察综合性计算机知识的课程。但这都不是重点，我一直认为，以边学边做的方式来学习一门课程是最好的方式之一（为什么是之一呢，怕被喷...嘻嘻）。只要能坚持下来，最后你会体会到，你已经能从一个与之前完全不同的角度理解计算机！现在微内核概念这么火，鸿蒙就被宣传为微内核全场景OS，难道不想从原理上真正理解一下微内核OS吗？ 没错，6.828 这个课程就是引导我们实现了一个微内核操作系统。

没想到这个内容能被这么多人看到，还挺激动的。不过点赞收藏 1:5 是什么情况，大家不要收藏退出一气呵成啊~如果真的对计算机底层比较感兴趣的话，一定要去 try 一下啊。

## 1. 简介

课程评价：**神级课程——要是早遇到，我还会是这种 five（废物） 系列**

课程网址：[6.828: Operating System Engineering](https://link.zhihu.com/?target=https%3A//pdos.csail.mit.edu/6.828/2018/schedule.html)，一直跟着其 schedule 走就可以啦。

xv6 讲义：[a simple, Unix-like teaching operating system](https://link.zhihu.com/?target=https%3A//pdos.csail.mit.edu/6.828/2018/xv6/book-rev11.pdf)，讲义中会将每个部分的实现讲得十分详细，在代码编写时遇到不太清晰的概念时，可以多参考讲义。

我的实现环境：

- 虚拟机（VMware Workstation 和 VirtualBox 均可）
- Ubuntu16.04
- qemu，最好使用 MIT 给的 patch 版本（Lab6 用到 pacth 版本的qemu 较多）。安装方法也可参考[Tools Used in 6.828](https://link.zhihu.com/?target=https%3A//pdos.csail.mit.edu/6.828/2018/tools.html) 链接
- 工具链 [Tools Used in 6.828](https://link.zhihu.com/?target=https%3A//pdos.csail.mit.edu/6.828/2018/tools.html)

环境搭建网络上教程很多，这里我就不再赘述，大家可自行百度（搜索以下关键词），包括：

- VMware 或 VirtualBox 安装
- Ubuntu虚拟机
- qemu安装：英文教程参考上文给出的[工具链的链接](https://link.zhihu.com/?target=https%3A//pdos.csail.mit.edu/6.828/2018/tools.html)， 中文教程可参考网络上的博文（[QEMU模拟器安装](https://link.zhihu.com/?target=https%3A//www.cnblogs.com/gatsby123/p/9746193.html)）

## 2. xv6

学习6.828时，你会发现经常遇到 xv6 和 JOS这两个名词，不明白它们两者之间的关系，在完成实验时思路就会不是很清晰。xv6 是一个类Unix的教学操作系统（MIT基于Unix v6 的重新实现），而 JOS 是在xv6的基础上改写，让我们能在其上进行实验的 OS。 所以，实际上当我们遇到不会实现的实验或不清晰实现的过程时，可以去参考 xv6 相应部分的源码。

Homework 实现：完整实现代码。[Github_SmallPond/MIT6.828_OS](https://link.zhihu.com/?target=https%3A//github.com/SmallPond/MIT6.828_OS/tree/master/xv6-public)

- [MIT6.828_Homework_Shell_MIT_6.828](https://link.zhihu.com/?target=https%3A//blog.csdn.net/Small_Pond/article/details/90544379)
- [MIT6.828_HW2_Boot_xv6_MIT6.828](https://link.zhihu.com/?target=https%3A//blog.csdn.net/Small_Pond/article/details/90665444)
- [MIT6.828_HW3_XV6 System calls](https://link.zhihu.com/?target=https%3A//blog.csdn.net/Small_Pond/article/details/91345372)
- [MIT6.828_HW4_xv6 lazy page allocation](https://link.zhihu.com/?target=https%3A//blog.csdn.net/Small_Pond/article/details/91346550)
- [MIT6.828_HW5_xv6 CPU alarm](https://link.zhihu.com/?target=https%3A//blog.csdn.net/Small_Pond/article/details/92838818)
- [MIT6.828_HW6_Threads and Locking](https://link.zhihu.com/?target=https%3A//blog.csdn.net/Small_Pond/article/details/92838852)
- [MIT6.828_HW7_xv6 locking](https://link.zhihu.com/?target=https%3A//blog.csdn.net/Small_Pond/article/details/93200120)
- [MIT6.828_HW8_User-level threads](https://link.zhihu.com/?target=https%3A//blog.csdn.net/Small_Pond/article/details/94600772)
- [MIT6.828_HW9_barriers](https://link.zhihu.com/?target=https%3A//blog.csdn.net/Small_Pond/article/details/94968225)
- [MIT6.828_HW10_Bigger file for xv6](https://link.zhihu.com/?target=https%3A//blog.csdn.net/Small_Pond/article/details/95009224)
- [MIT6.828_HW11_xv6 log](https://link.zhihu.com/?target=https%3A//blog.csdn.net/Small_Pond/article/details/95210975)

## 3. JOS

---------------2020.12.11 碎碎念--------------------

有同学问我发生肾么事了，为什么下面的链接无法访问了。是因服务器到期，新服务器正在备案中，以下链接就暂时无法访问了。

2020.12.24 网站已经可以正常访问~

我康了一下，这篇文章目前赞同:收藏的数据是2460:8090，希望大家觉得有帮助就双击一下屏幕啦，谢谢大家~

---------------2020.12.11 碎碎念--------------------

JOS是828课程的主要实验部分，以下是我实验过程中记下的笔记，包含我的实现思路以及代码。 不过有些重复的细节，我就没有记录，可以参考我的完整实现代码。[Github_SmallPond/MIT6.828_OS](https://link.zhihu.com/?target=https%3A//github.com/SmallPond/MIT6.828_OS)

- Lab1 启动PC

- - [LAB_1_Part1_PC Bootstrap](https://link.zhihu.com/?target=https%3A//www.dingmos.com/index.php/archives/3/)
  - [LAB_1_Part2_The Boot Loader](https://link.zhihu.com/?target=https%3A//www.dingmos.com/index.php/archives/3/)
  - [LAB1_Part3_The Kernel](https://link.zhihu.com/?target=https%3A//www.dingmos.com/index.php/archives/4/)

- Lab2 内存管理

- - [LAB2_Part1_Physical Page Management](https://link.zhihu.com/?target=https%3A//www.dingmos.com/index.php/archives/5/)
  - [LAB2_Part2_Virtual Memory](https://link.zhihu.com/?target=https%3A//www.dingmos.com/index.php/archives/6/)
  - [LAB2_Part3_Kernel Address Space(内核地址空间)](https://link.zhihu.com/?target=https%3A//www.dingmos.com/index.php/archives/7/)

- Lab3 用户级环境（用户进程）

- - [LAB3_User-Level Environments_PartA_User Environments and Exception Handling](https://link.zhihu.com/?target=https%3A//www.dingmos.com/index.php/archives/8/)
  - [LAB3_User-Level Environments_PartB Page Faults, Breakpoints Exceptions, and System Calls](https://link.zhihu.com/?target=https%3A//www.dingmos.com/index.php/archives/9/)

- Lab4 抢占式多任务

- - [LAB4_Preemptive Multitasking_PartA Multiprocessor Support and Cooperative Multitasking](https://link.zhihu.com/?target=https%3A//www.dingmos.com/index.php/archives/10/)
  - [LAB4_Preemptive Multitasking_PartB Copy-on-Write Fork](https://link.zhihu.com/?target=https%3A//www.dingmos.com/index.php/archives/11/)
  - [LAB4_Preemptive Multitasking_PartC Preemptive Multitasking and IPC](https://link.zhihu.com/?target=https%3A//www.dingmos.com/index.php/archives/12/)

- Lab5 文件系统, Spawn and Shell

- - [Lab5_File system, Spawn and Shell](https://link.zhihu.com/?target=https%3A//www.dingmos.com/index.php/archives/13/)

- Lab6 网卡驱动

- - [Lab6_Network Driver](https://link.zhihu.com/?target=https%3A//www.dingmos.com/index.php/archives/14/)

## 4. 参考文献

1. [MIT 6.828 JOS 操作系统学习笔记/fatsheep9146](https://link.zhihu.com/?target=https%3A//www.cnblogs.com/fatsheep9146/category/769143.html)，刚入门时参考，包括环境搭建。博文写得十分详细，可惜貌似只写到了 Lab2。
2. [clpsz/mit-jos-2014](https://link.zhihu.com/?target=https%3A//github.com/clpsz/mit-jos-2014)，此大神放出了自己到 Lab4 的代码，其文档提及了一些细节，很有帮助。
3. [Unknown Unknown](https://link.zhihu.com/?target=https%3A//buweilv.github.io/categories/OS/)，过程较详细（相当于对官方文档做了一遍翻译），英语不好可以参考这边，但我还是建议以官方文档为主，毕竟英语还是要学好呀。这位大神做到了LAB5，但不包括HW。
4. [bysui的博客](https://link.zhihu.com/?target=https%3A//blog.csdn.net/bysui/article/category/6232831), 这位大神完成了全部的实验，但是我在后面才发现这么好的资源！

我的课程能顺利完成，少不了各位大佬记录下的实验过程，由衷感谢以上各位大神。同时希望我也能帮到后来的学习者~

## **5. 计算机底层系列**

[一丁点儿：实践出真知-计组-红白机模拟器31 赞同 · 2 评论文章![img](https://pic4.zhimg.com/v2-743af696a7e2ad3cad25ae33c60484ab_ipico.jpg)](https://zhuanlan.zhihu.com/p/406252623)

[一丁点儿：计算机是如何启动的？从未上电到操作系统启动781 赞同 · 52 评论文章![img](https://pic1.zhimg.com/v2-7bb77423f487df75348782f6e58abac8_180x120.jpg)](https://zhuanlan.zhihu.com/p/166522447)

[一丁点儿：从门电路开始构建一台简易计算机34 赞同 · 1 评论文章![img](https://pic2.zhimg.com/v2-ee9fa32291b3b49c107601024e4571d1_180x120.jpg)](https://zhuanlan.zhihu.com/p/342061553)





编辑于 2022-08-16 09:25



[操作系统](https://www.zhihu.com/topic/19552686)

[微内核](https://www.zhihu.com/topic/19615172)

[操作系统内核](https://www.zhihu.com/topic/19627055)