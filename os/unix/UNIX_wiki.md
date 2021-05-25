# UNIX

维基百科，自由的百科全书

（重定向自[Unix](https://zh.wikipedia.org/w/index.php?title=Unix&redirect=no)）





跳到导航

跳到搜索

| [![Unix history-simple.svg](https://upload.wikimedia.org/wikipedia/commons/thumb/7/77/Unix_history-simple.svg/300px-Unix_history-simple.svg.png)](https://zh.wikipedia.org/wiki/File:Unix_history-simple.svg)Unix和类Unix系统演化 |                                                              |
| :----------------------------------------------------------- | ------------------------------------------------------------ |
| [开发者](https://zh.wikipedia.org/wiki/软件设计师)           | [贝尔实验室](https://zh.wikipedia.org/wiki/贝尔实验室)的[肯·汤普逊](https://zh.wikipedia.org/wiki/肯·汤普逊)，[丹尼斯·里奇](https://zh.wikipedia.org/wiki/丹尼斯·里奇)，[布莱恩·柯林汉](https://zh.wikipedia.org/wiki/布萊恩·柯林漢)，[道格拉斯·麦克罗伊](https://zh.wikipedia.org/wiki/道格拉斯·麥克羅伊)，[乔伊·欧桑纳](https://zh.wikipedia.org/wiki/喬伊·歐桑納) |
| [编程语言](https://zh.wikipedia.org/wiki/编程语言)           | [C语言](https://zh.wikipedia.org/wiki/C语言)和[汇编语言](https://zh.wikipedia.org/wiki/組合語言) |
| 操作系统家族                                                 | Unix                                                         |
| 运作状态                                                     | 当前                                                         |
| 源码模式                                                     | 历史上是[闭源代码](https://zh.wikipedia.org/wiki/专有软件)，但某些Unix计划（包括[BSD](https://zh.wikipedia.org/wiki/BSD)家族和[illumos](https://zh.wikipedia.org/wiki/Illumos)）是[开源软件](https://zh.wikipedia.org/wiki/开源软件) |
| 初始版本                                                     | 开发起于1969年 [内部](https://zh.wikipedia.org/wiki/Research_Unix)首次出版手册于1971年11月[[1\]](https://zh.wikipedia.org/wiki/UNIX#cite_note-reader-1) 在贝尔实验室外宣布于1973年10月[[2\]](https://zh.wikipedia.org/wiki/UNIX#cite_note-2) |
| 支持的[语言](https://zh.wikipedia.org/wiki/自然语言)         | 英语                                                         |
| [内核](https://zh.wikipedia.org/wiki/内核)类别               | 多种：[单体内核](https://zh.wikipedia.org/wiki/单体内核)，[微内核](https://zh.wikipedia.org/wiki/微內核)，[混合内核](https://zh.wikipedia.org/wiki/混合內核) |
| 默认[用户界面](https://zh.wikipedia.org/wiki/用户界面)       | [命令行界面](https://zh.wikipedia.org/wiki/命令行界面)和[图形用户界面](https://zh.wikipedia.org/wiki/图形用户界面)（[X窗口系统](https://zh.wikipedia.org/wiki/X視窗系統)） |
| [许可证](https://zh.wikipedia.org/wiki/软件许可证)           | 各种：某些版本是[专有软件](https://zh.wikipedia.org/wiki/专有软件)，另一些是[自由软件](https://zh.wikipedia.org/wiki/自由软件)/[开源软件](https://zh.wikipedia.org/wiki/开源软件) |
| 官方网站                                                     | [opengroup.org/unix](http://opengroup.org/unix)              |

**UNIX**（非复用信息和计算机服务，英语：Uniplexed Information and Computing Service，UnICS），一种多用户、多进程的计算机[操作系统](https://zh.wikipedia.org/wiki/操作系统)，源自于从20世纪70年代开始在美国[AT&T](https://zh.wikipedia.org/wiki/AT%26T)公司的[贝尔实验室](https://zh.wikipedia.org/wiki/贝尔实验室)开发的[AT&T](https://zh.wikipedia.org/wiki/AT%26T) Unix。

## 目录



- [1简介](https://zh.wikipedia.org/wiki/UNIX#簡介)
- 2历史
  - [2.1初创期](https://zh.wikipedia.org/wiki/UNIX#初创期)
  - [2.2发展期](https://zh.wikipedia.org/wiki/UNIX#发展期)
  - [2.31127部门的解散](https://zh.wikipedia.org/wiki/UNIX#1127部門的解散)
  - [2.4现况](https://zh.wikipedia.org/wiki/UNIX#现况)
- [3文化](https://zh.wikipedia.org/wiki/UNIX#文化)
- [4标准](https://zh.wikipedia.org/wiki/UNIX#标准)
- [5自由的类Unix系统](https://zh.wikipedia.org/wiki/UNIX#自由的类Unix系统)
- [6参考文献](https://zh.wikipedia.org/wiki/UNIX#参考文献)
- [7外部链接](https://zh.wikipedia.org/wiki/UNIX#外部链接)

## 简介[[编辑](https://zh.wikipedia.org/w/index.php?title=UNIX&action=edit&section=1)]

UNIX操作系统，是一个强大的多用户、多任务操作系统，支持多种处理器架构，按照操作系统的分类，属于分时操作系统，最早由肯·汤普逊、丹尼斯·里奇和道格拉斯·麦克罗伊于1969年在AT&T的贝尔实验室开发。目前它的商标权由国际开放标准组织所拥有，只有符合单一UNIX规范的UNIX系统才能使用UNIX这个名称，否则只能称为类UNIX（UNIX-like）。

Unix的前身为1964年开始的[Multics](https://zh.wikipedia.org/wiki/Multics)，1965年时，[贝尔实验室](https://zh.wikipedia.org/wiki/贝尔实验室)加入一项由[通用电气](https://zh.wikipedia.org/wiki/通用电气)和[麻省理工学院](https://zh.wikipedia.org/wiki/麻省理工学院)合作的计划；该计划要创建一套多用户、多任务、多层次（multi－user、multi－processor、multi－level）的MULTICS操作系统。贝尔实验室参与了这个操作系统的研发，但因为开发速度太慢，1969年贝尔实验室决定退出这个计划。贝尔实验室的工程师，[肯·汤普逊](https://zh.wikipedia.org/wiki/肯·汤普逊)和[丹尼斯·里奇](https://zh.wikipedia.org/wiki/丹尼斯·里奇)，在此时自行开发了Unix。

此后的10年，Unix在学术机构和大型企业中得到了广泛的应用，当时的UNIX拥有者[AT&T](https://zh.wikipedia.org/wiki/AT%26T)公司以低廉甚至免费的许可将Unix源码授权给学术机构做研究或教学之用，许多机构在此源码基础上加以扩展和改进，形成了所谓的“Unix变种”，这些变种反过来也促进了Unix的发展，其中最著名的变种之一是由[加州大学柏克莱分校](https://zh.wikipedia.org/wiki/加州大學柏克萊分校)开发的[伯克利软件套件](https://zh.wikipedia.org/wiki/柏克萊軟件套件)(BSD)产品。

后来[AT&T](https://zh.wikipedia.org/wiki/AT%26T)意识到了Unix的商业价值，不再将Unix源码授权给学术机构，并对之前的Unix及其变种声明了著作权权利。BSD在Unix的历史发展中具有相当大的影响力，被很多商业厂家采用，成为很多商用Unix的基础。其不断增大的影响力终于引起了AT&T的关注，于是开始了一场持久的著作权官司，这场官司一直打到AT&T将自己的Unix系统实验室卖掉，新接手的[Novell](https://zh.wikipedia.org/wiki/Novell)采取了一种比较开明的做法，允许柏克莱分校自由发布自己的Unix变种，但是前提是必须将来自于AT&T的代码完全删除，于是诞生了4.4 BSD Lite版，由于这个版本不存在法律问题，4.4 BSD Lite成为了现代柏克莱软件包的基础版本。尽管后来，非商业版的Unix系统又经过了很多演变，但其中有不少最终都是创建在BSD版本上（[Linux](https://zh.wikipedia.org/wiki/Linux)、[Minix](https://zh.wikipedia.org/wiki/Minix)等系统除外）。所以从这个角度上，4.4 BSD又是所有自由版本Unix的基础，它们和[System V](https://zh.wikipedia.org/wiki/System_V)及Linux等共同构成Unix操作系统这片璀璨的星空。

BSD使用主版本加次版本的方法标识，如4.2、4.3BSD，在原始版本的基础上还有派生版本，这些版本通常有自己的名字，如4.3BSD-Net/1，4.3BSD-Net/2等。BSD在发展中也逐渐派生出3个主要的分支：[FreeBSD](https://zh.wikipedia.org/wiki/FreeBSD)、[OpenBSD](https://zh.wikipedia.org/wiki/OpenBSD)和[NetBSD](https://zh.wikipedia.org/wiki/NetBSD)。

此后的几十年中，Unix仍在不断变化，其著作权所有者不断变更，授权者的数量也在增加。Unix的著作权曾经为[AT&T](https://zh.wikipedia.org/wiki/AT%26T)所有，之后[Novell](https://zh.wikipedia.org/wiki/Novell)拥有获取了Unix，再之后Novell又将著作权出售给了[圣克鲁兹作业](https://zh.wikipedia.org/wiki/聖克魯茲作業)，但不包括知识产权和专利权（这一事实双方尚存在争议）。有很多大公司在获取了Unix的授权之后，开发了自己的Unix产品，比如IBM的[AIX](https://zh.wikipedia.org/wiki/AIX)、惠普的[HP-UX](https://zh.wikipedia.org/wiki/HP-UX)、SCO的[Openserver](https://zh.wikipedia.org/w/index.php?title=Openserver&action=edit&redlink=1)、SUN的[Solaris](https://zh.wikipedia.org/wiki/Solaris)（被Oracle收购）和SGI的[IRIX](https://zh.wikipedia.org/wiki/IRIX)。

Unix因为其安全可靠，高效强大的特点在服务器领域得到了广泛的应用。直到GNU/Linux流行开始前，Unix也是科学计算、大型机、超级计算机等所用操作系统的主流。现在其仍然被应用于一些对稳定性要求极高的数据中心之上。

## 历史[[编辑](https://zh.wikipedia.org/w/index.php?title=UNIX&action=edit&section=2)]

### 初创期[[编辑](https://zh.wikipedia.org/w/index.php?title=UNIX&action=edit&section=3)]

Unix最初受到[Multics](https://zh.wikipedia.org/wiki/Multics)计划的启发。Multics是由[麻省理工学院](https://zh.wikipedia.org/wiki/麻省理工学院)、[通用电气](https://zh.wikipedia.org/wiki/通用电气)和AT&T底下的[贝尔实验室](https://zh.wikipedia.org/wiki/贝尔实验室)合作进行的操作系统项目，被设计运行在[GE-645](https://zh.wikipedia.org/w/index.php?title=GE-645&action=edit&redlink=1)大型主机上。但是由于整个目标过于庞大，糅合了太多的特性，Multics虽然发布了一些产品，但是性能都很低，AT&T最终撤出了投入Multics项目的资源，退出这项合作计划。

贝尔实验室最初参与Multics计划的部门为计算器技术研发部门（Computing Techniques Research Department），部门主管为[道格拉斯·麦克罗伊](https://zh.wikipedia.org/wiki/道格拉斯·麥克羅伊)，其下的工程师，原有[丹尼斯·里奇](https://zh.wikipedia.org/wiki/丹尼斯·里奇)、[布莱恩·柯林汉](https://zh.wikipedia.org/wiki/布萊恩·柯林漢)、[道格拉斯·麦克罗伊](https://zh.wikipedia.org/wiki/道格拉斯·麥克羅伊)、[麦克·列斯克](https://zh.wikipedia.org/w/index.php?title=麦克·列斯克&action=edit&redlink=1)（Mike Lesk）与[乔伊·欧桑纳](https://zh.wikipedia.org/wiki/喬伊·歐桑納)（Joe Ossanna）等人，为了Multics计划，他们又召募了[肯·汤普逊](https://zh.wikipedia.org/wiki/肯·汤普逊)加入其中。[肯·汤普逊](https://zh.wikipedia.org/wiki/肯·汤普逊)进入Multics计划不久，计划就中止了，但因为机器仍然保留在贝尔实验室，他继续在GE-645上开发软件。[肯·汤普逊](https://zh.wikipedia.org/wiki/肯·汤普逊)在GE-645上，写出了一个仿真器，可以让一个文件系统与内存分页机制运作起来。他同时也写了一个程序语言[Bon](https://zh.wikipedia.org/w/index.php?title=Bon&action=edit&redlink=1)，编写了一个太空旅行游戏。经过实际运行后，他发现游戏速度很慢而且耗费昂贵，每次运行会花费75美元。在GE-645被搬走后，肯·汤普逊在实验室中寻找没人使用的机器，找到了几台[PDP-7](https://zh.wikipedia.org/wiki/PDP-7)。丹尼斯·里奇的帮助下，汤普逊用[PDP-7](https://zh.wikipedia.org/wiki/PDP-7)的汇编语言重写了这个游戏，并使其在[DEC](https://zh.wikipedia.org/wiki/DEC) PDP-7上运行起来。这次经历加上Multics项目的经验，促使汤普逊开始在DEC PDP-7上研究如何开发操作系统。

1969年，肯·汤普逊提议在PDP-7上开发一个新的阶层式操作系统的计划。Multics的原有成员，加上Rudd Canady，都投入这个计划。肯·汤普逊发现要编写驱动程序来驱动文件系统，进行测试，并不容易，于是开发了一个[壳层](https://zh.wikipedia.org/wiki/殼層)（shell）与一些驱动程序，做出一个操作系统的雏形。在团队合作下，Multics的许多功能都被采纳，重新实现，最终做出了一个[分时多任务](https://zh.wikipedia.org/w/index.php?title=分时多任务&action=edit&redlink=1)操作系统，成为第一版UNIX。因为Multics来自“MULTiplexed Information and Computing System”的缩写，在1970年，那部PDP-7却只能支持两个用户，[彼得·纽曼](https://zh.wikipedia.org/w/index.php?title=彼得·纽曼&action=edit&redlink=1)（Peter G. Neumann）戏称他们的系统其实是:“UNiplexed Information and Computing System”，缩写为“UNICS”。于是这个项目被称为**UnICS**（**Un**iplexed **I**nformation and **C**omputing **S**ystem）。

因为PDP-7的性能不佳，肯·汤普逊与丹尼斯·里奇决定把第一版UNIX移植到[PDP-11/20](https://zh.wikipedia.org/wiki/PDP-11)的机器上，开发第二版UNIX。在性能提升后，真正可以提供多人同时使用，[布莱恩·柯林汉](https://zh.wikipedia.org/wiki/布萊恩·柯林漢)提议将它的名称改为**UNIX**。

第一版UNIX是用PDP-7汇编语言编写的，一些应用是由叫做[B语言](https://zh.wikipedia.org/wiki/B语言)的[解释型语言](https://zh.wikipedia.org/wiki/解释型语言)和汇编语言混合编写的。在进行系统编程时不够强大，所以汤普逊和里奇对其进行了改造，并于1971年共同发明了[C语言](https://zh.wikipedia.org/wiki/C语言)。1973年汤普逊和里奇用C语言重写了Unix，形成第三版UNIX。在当时，为了实现最高效率，系统程序都是由汇编语言编写，所以汤普逊和里奇此举是极具大胆创新和革命意义的。用C语言编写的Unix代码简洁紧凑、易移植、易读、易修改，为此后Unix的发展奠定了坚实基础。

### 发展期[[编辑](https://zh.wikipedia.org/w/index.php?title=UNIX&action=edit&section=4)]

1974年，汤普逊和里奇合作在ACM通信上发表了一篇关于UNIX的文章，这是UNIX第一次出现在贝尔实验室以外。此后UNIX被政府机关，研究机构，企业和大学注意到，并逐渐流行开来。

1975年，UNIX发布了4、5、[6](https://zh.wikipedia.org/wiki/Version_6_Unix)三个版本。1978年，已经有大约600台计算机在运行UNIX。1979年，[版本7](https://zh.wikipedia.org/wiki/Version_7_Unix)发布，这是最后一个广泛发布的研究型UNIX版本。20世纪80年代相继发布的8、9、10版本只授权给了少数大学。此后这个方向上的研究导致了[九号计划](https://zh.wikipedia.org/wiki/貝爾實驗室九號計劃)的出现，这是一个新的[分布式操作系统](https://zh.wikipedia.org/wiki/分布式操作系统)。

1982年，AT&T基于版本7开发了[UNIX System Ⅲ](https://zh.wikipedia.org/w/index.php?title=UNIX_System_Ⅲ&action=edit&redlink=1)的第一个版本，这是一个商业版本仅供出售。为了解决混乱的UNIX版本情况，AT&T综合了其他大学和公司开发的各种UNIX，开发了[UNIX System V Release 1](https://zh.wikipedia.org/wiki/System_V#SVR1)。

这个新的UNIX商业发布版本不再包含源代码，所以加州大学柏克莱分校继续开发BSD UNIX，作为UNIX System III和V的替代选择。BSD对UNIX最重要的贡献之一是[TCP/IP](https://zh.wikipedia.org/wiki/TCP/IP)。BSD有8个主要的发行版中包含了TCP/IP：4.1c、4.2、4.3、4.3-Tahoe、4.3-Reno、Net2、4.4以及4.4-lite。这些发布版中的TCP/IP代码几乎是现在所有系统中TCP/IP实现的前辈，包括AT&T System V UNIX和[Microsoft](https://zh.wikipedia.org/wiki/Microsoft) [Windows](https://zh.wikipedia.org/wiki/Windows)。

其他一些公司也开始为其自己的小型机或工作站提供商业版本的UNIX系统，有些选择System V作为基础版本，有些则选择了BSD。BSD的一名主要开发者，[比尔·乔伊](https://zh.wikipedia.org/wiki/比尔·乔伊)，在BSD基础上开发了[SunOS](https://zh.wikipedia.org/wiki/SunOS)，并最终创办了[昇陽公司](https://zh.wikipedia.org/wiki/升阳)。

1991年，一群BSD开发者（Donn Seeley、Mike Karels、Bill Jolitz和Trent Hein）离开了加州大学，创办了[Berkeley Software Design, Inc](https://zh.wikipedia.org/w/index.php?title=Berkeley_Software_Design,_Inc&action=edit&redlink=1) (BSDI)。BSDI是第一家在便宜常见的[Intel](https://zh.wikipedia.org/wiki/Intel)平台上提供全功能商业BSD UNIX的厂商。后来Bill Jolitz离开了BSDI，开始了386BSD的工作。386BSD被认为是[FreeBSD](https://zh.wikipedia.org/wiki/FreeBSD)、[OpenBSD](https://zh.wikipedia.org/wiki/OpenBSD)和[NetBSD](https://zh.wikipedia.org/wiki/NetBSD)、[DragonFlyBSD](https://zh.wikipedia.org/wiki/DragonFlyBSD)的先辈。

AT&T继续为UNIX System V增加了文件锁定，系统管理，作业控制，流和远程文件系统。1987到1989年，AT&T决定将[Xenix](https://zh.wikipedia.org/wiki/Xenix)（微软开发的一个x86-pc上的UNIX版本），BSD，SunOS和System V融合为System V Release 4（SVR4）。这个新发布版将多种特性融为一体，结束了混乱的竞争局面。

1993年以后，大多数商业UNIX发行商都基于SVR4开发自己的UNIX变体了。

### 1127部门的解散[[编辑](https://zh.wikipedia.org/w/index.php?title=UNIX&action=edit&section=5)]

根据一项 [报导](http://www.unixreview.com/documents/s=9846/ur0508l/ur0508l.html) 指出，当年负责研发UNIX与后续维护工作的贝尔实验室1127部门已于2005年8月正式宣告解散。肯·汤普逊已退休，现居[加州](https://zh.wikipedia.org/wiki/加州)；[丹尼斯·里奇](https://zh.wikipedia.org/wiki/丹尼斯·里奇)调到别的部门；而Douglas McIlroy则在[达特茅斯学院](https://zh.wikipedia.org/wiki/達特茅斯學院)担任教授。

### 现况[[编辑](https://zh.wikipedia.org/w/index.php?title=UNIX&action=edit&section=6)]

UNIX System V Release 4发布后不久，AT&T就将其所有UNIX权利出售给了[Novell](https://zh.wikipedia.org/wiki/Novell)。Novell期望以此来对抗微软的[Windows NT](https://zh.wikipedia.org/wiki/Windows_NT)，但其核心市场受到了严重伤害，1993年Novell将SVR4的商标权利出售给了[X/OPEN](https://zh.wikipedia.org/wiki/X/Open)公司，后者成为定义UNIX标准的机构。1996年，X/OPEN和OSF/1合并，创建了[国际开放标准组织](https://zh.wikipedia.org/wiki/國際開放標準組織)，由它公布的“[单一UNIX规范](https://zh.wikipedia.org/wiki/單一UNIX規範)”定义着具有什么特征的操作系统可以冠上UNIX之名，相对地，不符合这些标准但与Unix有类似性的操作系统只能称为“类Unix”([unix-like](https://zh.wikipedia.org/wiki/Unix-like))。

UNIX代码[著作权](https://zh.wikipedia.org/wiki/著作權)则由Novell售给[圣克鲁兹作业](https://zh.wikipedia.org/wiki/聖克魯茲作業)，2001年这家公司的商标与UNIX产品和业务都出售给了Caldera Systems，交易完成后，Caldera又被重命名为[SCO Group](https://zh.wikipedia.org/wiki/SCO_Group)。

截止到2020年6月，目前除类UNIX系统（BSD、GNU）外，仍有Oracle [Solaris](https://zh.wikipedia.org/wiki/Solaris)，[IBM AIX](https://zh.wikipedia.org/wiki/IBM_AIX)，[HP-UX](https://zh.wikipedia.org/wiki/HP-UX)，[MINIX](https://zh.wikipedia.org/wiki/MINIX)等符合标准的UNIX系统[[3\]](https://zh.wikipedia.org/wiki/UNIX#cite_note-3)。而原System V Unix则随着“1127”部门的解散而停止更新。[[4\]](https://zh.wikipedia.org/wiki/UNIX#cite_note-4)

## 文化[[编辑](https://zh.wikipedia.org/w/index.php?title=UNIX&action=edit&section=7)]

参见：[Unix哲学](https://zh.wikipedia.org/wiki/Unix哲学)

UNIX不仅仅是一个操作系统，更是一种生活方式。经过几十年的发展，UNIX在技术上日臻成熟的过程中，它独特的设计哲学和美学也深深地吸引了一大批技术人员，他们在维护、开发、使用UNIX的同时，UNIX也影响了他们的思考方式和看待世界的角度。

UNIX重要的设计原则：

- 简洁至上（[KISS原则](https://zh.wikipedia.org/wiki/KISS原则)）
- 提供机制而非策略

## 标准[[编辑](https://zh.wikipedia.org/w/index.php?title=UNIX&action=edit&section=8)]

从1980年代开始，[POSIX](https://zh.wikipedia.org/wiki/POSIX)，一个开放的操作系统标准就在制定中，[IEEE](https://zh.wikipedia.org/wiki/IEEE)制定的POSIX标准（ISO/IEC 9945）现在是UNIX系统的基础部分。

## 自由的类Unix系统[[编辑](https://zh.wikipedia.org/w/index.php?title=UNIX&action=edit&section=9)]

参见：[类Unix系统](https://zh.wikipedia.org/wiki/类Unix系统)

1984年，[Richard Stallman](https://zh.wikipedia.org/wiki/Richard_Stallman)发起了[GNU](https://zh.wikipedia.org/wiki/GNU)项目，目标是创建一个完全自由且向下兼容UNIX的操作系统。这个项目不断发展壮大，包含了越来越多的内容。现在，GNU项目的产品，如[Emacs](https://zh.wikipedia.org/wiki/Emacs)、[GCC](https://zh.wikipedia.org/wiki/GCC)等已经成为各种其它自由发布的类UNIX系统中的核心角色。

1990年，[Linus Torvalds](https://zh.wikipedia.org/wiki/Linus_Torvalds)决定编写一个自己的[Minix](https://zh.wikipedia.org/wiki/Minix)内核，初名为Linus' Minix，意为Linus的Minix内核，后来改名为[Linux](https://zh.wikipedia.org/wiki/Linux)。此内核于1991年正式发布，并逐渐引起人们的注意。当时GNU操作系统仍未完成，GNU系统软件集与Linux内核结合后，GNU软件构成了这个POSIX兼容操作系统GNU/Linux的基础。今天[GNU/Linux](https://zh.wikipedia.org/wiki/GNU/Linux)已经成为发展最为活跃的自由／开放源码的类Unix操作系统。

1994年，受到GNU工程的鼓舞，BSD走上了复兴的道路。BSD的开发也走向了几个不同的方向，并最终导致了[FreeBSD](https://zh.wikipedia.org/wiki/FreeBSD)、[NetBSD](https://zh.wikipedia.org/wiki/NetBSD)、[OpenBSD](https://zh.wikipedia.org/wiki/OpenBSD)和[DragonFlyBSD](https://zh.wikipedia.org/wiki/DragonFlyBSD)等基于BSD的操作系统的出现。

## 参考文献[[编辑](https://zh.wikipedia.org/w/index.php?title=UNIX&action=edit&section=10)]

1. **^** [McIlroy, M. D.](https://zh.wikipedia.org/w/index.php?title=Doug_McIlroy&action=edit&redlink=1) [A Research Unix reader: annotated excerpts from the Programmer's Manual, 1971–1986](http://www.cs.dartmouth.edu/~doug/reader.pdf) (PDF) (Technical report). CSTR. Bell Labs. 1987 [2020-03-09]. 139. （原始内容[存档](https://web.archive.org/web/20171111151817/http://www.cs.dartmouth.edu/~doug/reader.pdf) (PDF)于2017-11-11）.
2. **^** Ritchie, D. M.; Thompson, K. [The UNIX Time-Sharing System](https://web.archive.org/web/20150611114359/https://www.bell-labs.com/usr/dmr/www/cacm.pdf) (PDF). Communications of the ACM. 1974, **17** (7): 365–375 [2020-03-09]. （[原始内容](https://www.bell-labs.com/usr/dmr/www/cacm.pdf) (PDF)存档于2015-06-11）.
3. **^** 张春晓. UNIX从入门到精通. 北京: 清华大学出版社. 2013: 4–11. [ISBN 9787302307358](https://zh.wikipedia.org/wiki/Special:网络书源/9787302307358) **（中文）**.
4. **^** [贝尔实验室UNIX开发组正式解散](http://linux.kutx.cn/linux/35/linux17488.htm).

## 外部链接[[编辑](https://zh.wikipedia.org/w/index.php?title=UNIX&action=edit&section=11)]

- [UNIX的完整历史](http://www.levenez.com/unix/)[Archived](https://www.webcitation.org/5vLcAHDQ6?url=http://www.levenez.com/unix/) 2010-12-29 at WebCite
- [UNIX第7版手册](http://plan9.bell-labs.com/7thEdMan/)（[页面存档备份](https://web.archive.org/web/20081019172747/http://plan9.bell-labs.com/7thEdMan/)，存于[互联网档案馆](https://zh.wikipedia.org/wiki/互联网档案馆)）