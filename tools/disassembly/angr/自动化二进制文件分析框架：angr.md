# 自动化二进制文件分析框架：angr

[![AI Fuzz](https://pic1.zhimg.com/v2-1b76d0dcc836e8daf5f7e227c8fc78c6_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/mrsk)

[AI Fuzz](https://www.zhihu.com/people/mrsk)





168 人赞同了该文章

作者：

[@刘巍然-学酥](https://www.zhihu.com/people/d543743c88797978a0a8c453f8768974)



链接：[知乎专栏](https://zhuanlan.zhihu.com/p/25150055)

## 前言

各位知友新年快乐！

今天收到私信，我这个接近半年没有更新的专栏竟然被知乎的编辑们推荐到了App端「发现」页面的「专栏」项目中了。我个人其实感觉挺羞愧难当的。虽然下半年也完成了不少Black Hat、DEF CON视频的翻译工作，无奈手头上的事情实在太多，没能静下心来好好撰写分析文章。不过现在好啦，手上的事情基本处理完了，我也能抽出时间踏踏实实读一读材料，尽量为知友们带来高质量的国际黑客大会演讲分析。

今天为大家带来的视频来自Black Hat 2015，题目为：应用静态二进制分析方法寻找固件中的漏洞和后门（Using Static Binary Analysis To Find Vulnerabilities And Backdoors In Firmware）。之所以分析这个视频，是因为我非常认同此种研究：依托高校，解决实际问题，同时在顶级安全会议和顶级黑客会议上报告。我认为这才是安全应有的态度，理论和实践本身是不分家的，理论和实践的结合会做出更棒的成果！

视频YouTube链接：[https://www.youtube.com/watch?v=Fi_S2F7ud_g](https://link.zhihu.com/?target=https%3A//www.youtube.com/watch%3Fv%3DFi_S2F7ud_g)

演讲者：加州大学圣巴巴拉分校（UC Santa Barbara）教授Christophe Hauser、加州大学圣巴巴拉分校（UC Santa Barbara）博士研究生Yan Shoshitaishvili

关键字：嵌入式设备固件、静态分析、二进制分析

## 固件和固件中的后门

嵌入式设备越来越多地出现在人们的日常生活之中。所谓嵌入式设备，简单地说就是一个可独立完成特定工作的设备，或者说是一个微型计算机。最经典的嵌入式设备就是日常生活中的手机了。当然，不光智能手机属于嵌入式设备，以前的哪些非智能手机，甚至是最早的大哥大，都可以看作是嵌入式设备。

和计算机类似，嵌入式设备也有硬件部分和软件部分。嵌入式设备的硬件部分就是设备本身，而软件部分就是「固件」。为什么起了这么个名字呢？因为嵌入式设备的固件一般存储在EROM（可擦写只读存储器）或EEPROM（电可擦可编程只读存储器）中。

注意，这两种存储器都包含同一个关键字：「只读」。当写入到此类存储器后，固件只能被读取、或被擦除后重写，但是不能修改。这也是为什么如手机、路由器等典型嵌入式设备总有一个功能为：恢复出厂设置。所谓恢复出厂设置，就是把手机的全部内容擦除，把手机重置为存储在固件中的出厂设置。

不过，我们总会听到一种说法：刷一下固件。一般刷固件就是把EROM或EEPROM中存储的固件删除，再重写入一个新的固件。之前的很多手机都可以通过刷固件的方式实现各种神奇的功能，比如清除系统应用程序什么的。本质上，刷固件相当于把嵌入式设备的软件系统完全替换。软件系统都被完全替换了，系统应用程序自然而然也就被替换了。

什么是固件中的后门呢？固件后门是指，固件的开发人员或者恶意攻击者，可以利用所谓的后门，在未得到用户授权的条件下控制或完全控制设备。

听起来比较抽象，我们举个例子：一般来说，手机用户需要自行设置手机的解锁口令（比如密码、九宫格什么的），只有正确输入解锁口令才能解锁手机。然而，手机的固件中存在一个后门：只要输入一个特殊的口令就可以直接解锁手机。更隐蔽的方法可能是：按10次Home键，按3次增加音量键，再按2次减小音量键，就可以解锁手机。这就是所谓的后门了。

后门可能不仅仅是解锁手机这么简单。如果汽车、门禁系统有后门，那可就糟糕了。举几个例子：

- 如果门禁系统有后门，攻击者可以通过后门打开门禁。当然，后门还可能是另一种形式：攻击者给门禁发送一个特殊的指令，门禁告诉攻击者用户那些时候开门了。这样一来，攻击者就可以把握用户的动向，判断用户是否在家。
- 如果智能电报有后门，攻击者或许可以篡改电表数字，让用户支付更多的电费。攻击者或许还可以知道用户用电量的趋势。如果某时刻用电量大，则判断用户在家；如果长时间用电量低，则判断用户出远门了。

分析固件的后门还有一个难题：一般来说设备厂商不会公开固件的源代码。如果有源代码的话，后门的分析可能还简单一些。但是，我们可能只能从二进制文件入手分析固件的后门了。

我们知道，源代码要经过编译、链接等操作，最终生成二进制可执行文件：

![img](https://pic1.zhimg.com/80/v2-c1e84c3aebb18dfecf13571de2573518_1440w.jpg)

但在生成二进制文件的过程中，代码中的变量名、变量类型、函数名等会被完全剔除。由于存储固件的存储器空间有限，编译器有时候还会对代码进行优化，甚至从汇编语言的层面上进行优化。这使得逆向工程会变得非常困难。即使实现了二进制文件的逆向工程，源代码可能也和天书没什么区别…

那么，如果不能对固件的二进制文件实施逆向，就无法分析后门了吗？答案是否定的。

## 静态二进制分析与动态二进制分析

一般来说，二进制文件有两种分析方法：静态分析、动态分析。

![img](https://pic1.zhimg.com/80/v2-9becc1cb3a15e396fb0d36027b89d4d0_1440w.jpg)

静态分析是指：直接阅读二进制编码。虽然固件已经被编译为二进制文件，但毕竟二进制文件本身还在，如果能弄明白二进制文件在做什么，肯定能判断固件是否存在后门。因此，静态分析的特点是：覆盖全面。

但是，静态分析有它的缺点。如前面所说，二进制文件本身并不好理解，甚至像天书一样。因此，静态分析想得到精确的结果，则需要进行长时间的分析，使分析时间变长。如果分析时间有限，静态分析得出的结论可能是不准确的。结论可能会是这样的：**这个固件可能存在后门**。这个结论没错，但是没什么卵用。静态分析的优缺点可见下图的幻灯片：

![img](https://pic1.zhimg.com/80/v2-734ccaf45b4b489b70ecb6a4aa02cc6c_1440w.jpg)

动态分析不阅读二进制代码，而是直接把固件扔到实际环境下执行：**试试各种口令，看看能不能碰到一个万能口令**。很明显，如果试出来了，那么不仅能判断固件有后门，还能判断后门是什么。但是，由于设备的输入信息可以是任意的，因此动态分析不可能做到面面俱到。也就是说，分析结果虽然非常准确，但不能全面覆盖。动态分析的优缺点可见下图的幻灯片：

![img](https://pic1.zhimg.com/80/v2-0cf471fac2e84c0aa9d7e349faaf4428_1440w.jpg)

另外，我在网上找到了科罗拉多大学计算机科学家Mario Barrenechea的一个课件，课件中详细讲解了静态分析、动态分析这两种程序分析手段。知友们可参考此课件了解相关的知识：[https://www.cs.colorado.edu/~kena/classes/5828/s12/presentation-materials/barrenecheamario.pdf](https://link.zhihu.com/?target=https%3A//www.cs.colorado.edu/~kena/classes/5828/s12/presentation-materials/barrenecheamario.pdf)。

我们的问题是：能否克服静态分析或者动态分析的缺点，实现一个比较好的二进制文件自动化分析工具呢？

## 基本实现思想

Christophe Hauser与Yan Shoshitaishvili解决的问题是：应用静态分析方法，寻找「认证旁路」这类特殊的后门。所谓认证旁路，就是后门可以不执行固件中的身份认证算法，从而直接控制设备。

传统的认证旁路检测思路如下图所示：

![img](https://pic3.zhimg.com/80/v2-cc483bd00593b33a88b450a910707f86_1440w.jpg)

控制流图中一般存在一个「认证过程」，程序执行时先通过认证，认证通过后达到「认证通过」状态，进行后续操作；否则，达到「认证失败」状态，不允许进行后续操作。所谓后门，就是幻灯片左边的程序分支：应用后门可以绕过认证过程，直接达到「认证通过」状态。这种方法的问题是：从二进制程序中找到「认证过程」很麻烦。

我们换个思路，能否不找「认证过程」，而是找「认证通过」状态，通过「认证通过」状态回溯「认证过程」呢？答案是肯定的。实际上，这便是Christophe Hauser与Yan Shoshitaishvili的核心创新点：

![img](https://pic2.zhimg.com/80/v2-02716148a1635e6d52d54682282ca5dd_1440w.jpg)

如何寻找认证通过状态呢？因为认证通过的目的是允许用户执行一些操作，因此我们可以先从功能上定义，哪些操作可以认为是认证通过后才允许执行的。这些操作就可以作为「认证通过」状态。这些操作包括但不限于：

- 执行特定的系统服务，如唤醒系统、重启、关机等
- 访问特定的文件
- 访问特定的内存地址，甚至访问特定的寄存器地址
- 执行特定的代码，如向周边设备发送「请求数据」命令

![img](https://pic1.zhimg.com/80/v2-679052abfbbd60a3259c19f4cbe6d1bc_1440w.jpg)

得到「认证通过」状态后，以此状态为出发点对程序进行针对性的分析，从而找到漏洞。

## 二进制自动化分析工具：angr

Christophe Hauser与Yan Shoshitaishvili所在的团队开发了二进制自动化分析工具angr，实现了上述思路，做到了固件认证旁路的自动化分析。当然了，他们的分析工具用到了很多比较复杂的技术，如符号执行（Symbolic Execution）、值-集分析（Value-Set Analysis）等。这些虽然是已经存在的技术，但是对非专业人士来说相对比较复杂。感兴趣的知友们需要阅读Christophe Hauser与Yan Shoshitaishvili发表的论文。我在专栏的最后会给出论文题目。

![img](https://pic2.zhimg.com/80/v2-4e2200717397d0d9404a7ad2d0850fc5_1440w.jpg)

先来看看效果吧，Yan编写了一个包含后门的小程序：一般情况下，正确输入用户名和口令后，输入特定的口令，程序才会打印「认证通过」。但是，当输入特定的口令时，程序会直接打印「认证通过」。这个特定的口令直接写在了程序内部，并硬编码到了二进制可执行文件中。

![img](https://pic2.zhimg.com/80/v2-d327be0b2a29ba0313e306e147ef261d_1440w.jpg)

随后，Yan用angr的图形化操作界面，简单地点了点鼠标，就完成了此二进制文件的分析，找到了这个特定的口令：Welcom to the admin console, trusted user。

![img](https://pic2.zhimg.com/80/v2-e0ef74d741ac3278644b4dcf5432ccd9_1440w.jpg)

当然了，实际二进制文件的控制流图会非常复杂，后门可能不仅仅是特殊口令这么简单了。\

![img](https://pic1.zhimg.com/80/v2-2090eb958779787b302d35066f469018_1440w.jpg)

Yan用angr直接对bash的二进制文件进行分析。只分析bash的初始化过程就消耗了大量的时间。

![img](https://pic3.zhimg.com/80/v2-87090bb632d0857bc2b849b295273226_1440w.jpg)

为实现对任意二进制文件的快速分析，Yan等人综合应用了多种静态分析方法。这些方法的深入分析已经超过了我的理解能力… 感兴趣的知友真的需要阅读论文了。哎，不得不说，现在做安全也要读文献啦，其实是个好消息。



Yan等人把angr用在了哪里呢？他们把angr用到了DARPA网络大挑战（DAPRA Cyber Grand Challenge）中，并获胜（官方网址：[http://archive.darpa.mil/CyberGrandChallenge_CompetitorSite/](https://link.zhihu.com/?target=http%3A//archive.darpa.mil/CyberGrandChallenge_CompetitorSite/)）。可能有些知友不了解这个所谓的DAPRA Cyber Grand Challenge。这个比赛的宗旨是构建自动化工具，实现攻击和防御功能。可别小看这个比赛，Cyber Grand Challenge属于Grand Challenge的一部分，组织方是那个缩写Defense Advanced Research Projects Agency（DAPRA），这个组织隶属于美国国防部…

> The DARPA Grand Challenge is a prize competition for American autonomous vehicles, funded by the Defense Advanced Research Projects Agency, the most prominent research organization of the United States Department of Defense. Congress has authorized DARPA to award cash prizes to further DARPA's mission to sponsor revolutionary, high-payoff research that bridges the gap between fundamental discoveries and military use.（来源：[DARPA Grand Challenge](https://link.zhihu.com/?target=https%3A//en.wikipedia.org/wiki/DARPA_Grand_Challenge)）

![img](https://pic3.zhimg.com/80/v2-fbfba4e3d922f0a8e591c5edfcf1b2fa_1440w.jpg)

因为angr实在是太优秀了，Yan等人分别在Black Hat 2015和DEF CON 24上讲解了angr。下方连接为DEF CON 24的演讲稿：[https://media.defcon.org/DEF%20CON%2024/DEF%20CON%2024%20presentations/DEFCON-24-Shellphish-Cyber%20Grand%20Shellphish-UPDATED.pdf](https://link.zhihu.com/?target=https%3A//media.defcon.org/DEF%20CON%2024/DEF%20CON%2024%20presentations/DEFCON-24-Shellphish-Cyber%20Grand%20Shellphish-UPDATED.pdf)。

与此同时，团队还在信息安全旗舰会议NDSS 2015、NDSS 2016、Security and Privacy 2016上分别介绍了angr的各个组成部分和功能。

最令人欣慰的是，在Black Hat 2015结束后，团队把angr开源了！整个工程用Python撰写，代码量约为60000行。angr的官方网址为：[http://angr.io](https://link.zhihu.com/?target=http%3A//angr.io)。

![img](https://pic3.zhimg.com/80/v2-f6251aeb9b094b8172f9c0a12d8519da_1440w.jpg)

最后，我分别给出与angr相关的学术论文，它们是：

- NDSS 2015：Firmalice - Automatic Detection of Authentication Bypass Vulnerabilities in Binary Firmware（[http://101.96.8.164/www.cs.ucsb.edu/~chris/research/doc/ndss15_firmalice.pdf](https://link.zhihu.com/?target=http%3A//101.96.8.164/www.cs.ucsb.edu/~chris/research/doc/ndss15_firmalice.pdf)）。

- NDSS 2016：Driller: Augmenting Fuzzing Through Selective Symbolic Execution（[https://www.internetsociety.org/sites/default/files/blogs-media/driller-augmenting-fuzzing-through-selective-symbolic-execution.pdf](https://link.zhihu.com/?target=https%3A//www.internetsociety.org/sites/default/files/blogs-media/driller-augmenting-fuzzing-through-selective-symbolic-execution.pdf)）

- Security and Privacy 2016：SoK: (State of) The Art of War: Offensive Techniques in Binary Analysis（

  SOK: (State of) The Art of War: Offensive Techniques in Binary Analysis

  ）

编辑于 2017-02-12 18:11

二进制

信息安全

逆向工程

赞同 168

15 条评论

分享