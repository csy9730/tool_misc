# 深入PCI与PCIe之一：硬件篇

[![老狼](https://picx.zhimg.com/v2-86ea4b8b7df16d9c219613abc03b1ee5_l.jpg?source=172ae18b)](https://www.zhihu.com/people/mikewolfwoo)

[老狼](https://www.zhihu.com/people/mikewolfwoo)[](https://www.zhihu.com/question/510340037)

2021 年度新知答主

1,578 人赞同了该文章

> PCI总线和设备树是X86硬件体系内很重要的组成部分，几乎所有的外围硬件都以这样或那样的形式连接到PCI设备树上。虽然Intel为了方便各种IP的接入而提出IOSF总线，但是其主体接口(primary interface)还依然是PCIe形式。我们下面分成两部分介绍PCI和他的继承者PCIe（PCI express）：第一部分是历史沿革和硬件架构；第二部分是软件界面和UEFI中的PCI/PCe。

自PC在1981年被IBM发明以来，主板上都有扩展槽用于扩充计算机功能。现在最常见的扩展槽是PCIe插槽，实际上在你看不见的计算机主板芯片内部，各种硬件控制模块大部分也是以PCIe设备的形式挂载到了一颗或者几颗PCI/PCIe设备树上。固件和操作系统正是通过枚举设备树们才能发现绝大多数即插即用（PNP）设备的。那究竟什么是PCI呢？

## **PCI/PCIe的历史**

在我们看PCIe是什么之前，我们应该要了解一下PCIe的祖先们，这样我们才能对PCIe的一些设计有了更深刻的理解，并感叹计算机技术的飞速发展和工程师们的不懈努力。

**1. ISA** (Industry Standard Architecture)

**2. MCA** (Micro Channel Architecture)

**3. EISA** (Extended Industry Standard Architecture)

**4. VLB** (VESA Local Bus)

**5. PCI** (Peripheral Component Interconnect)

**6. PCI-X** (Peripheral Component Interconnect eXtended)

**7. AGP** (Accelerated Graphics Port)

**8. PCI Express** (Peripheral Component Interconnect Express)

科技的每一步前进都是为了解决前一代中出现的问题，这里的问题就是速度。作为扩展接口，它主要用于外围设备的连接和扩展，而外围设备吞吐速度的提高，往往会倒推接口速度的提升。第一代ISA插槽出现在第一代IBM PC XT机型上（**1981**），作为现代PC的盘古之作，8位的ISA提供了4.77MB/s的带宽（或传输率）。到了**1984**年，IBM就在PC AT上将带宽提高了几乎一倍，16位ISA第二代提供了8MB/s的传输率。但其对传输像图像这种数据来说还是杯水车薪。

IBM自作聪明在PS/2产品线上引入了MCA总线，迫使其他几家PC兼容机厂商联合起来捣鼓出来EISA。因为两者都期待兼容ISA，导致速度没有多大提升。真正的高速总线始于VLB，它绑定自己的频率到了当时486 CPU内部总线频率：33MHz。而到了奔腾时代，内部总线提高到了66MHz，给VLB带来了严重的兼容问题，造成致命一击。

Intel在**1992**年提出PCI（Peripheral Component Interconnect）总线协议，并召集其它的小伙伴组成了名为 PCI-SIG (PCI Special Interest Group)（PCI 特殊兴趣组J）的企业联盟。从那以后这个组织就负责PCI和其继承者们（PCI-X和PCIe的标准制定和推广。

不得不点赞下这种开放的行为，相对IBM当时的封闭，合作共赢的心态使得PCI标准得以广泛推广和使用。有似天雷勾动地火，统一的标准撩拨起了外围设备制造商的创新，从那以后各种各样的PCI设备应运而生，丰富了PC的整个生态环境。

PCI总线标准初试啼声就提供了133MB/s的带宽(33MHz时钟，每时钟传送32bit)。这对当时一般的台式机已经是超高速了，但对于服务器或者视频来说还是不够。于是AGP被发明出来专门连接北桥与显卡，而为服务器则提出PCI-X来连接高速设备。

**2004**年，Intel再一次带领小伙伴革了PCI的命。PCI express（PCIe，注意官方写法是这样，而不是PCIE或者PCI-E）诞生了，其后又经历了两代，现在是第三代(gen3，3.0)，gen4有望在2017年公布，而gen5已经开始起草中。

下面这个大表列出所有的速度比较。其中一些x8,x16的概念后面细节部分有介绍。

![img](https://pic2.zhimg.com/80/v2-5154c841c8034b967b41aac42755c9f5_720w.webp)



从下面的主频变化图中，大家可能注意到更新速度越来越快。

![img](https://pic2.zhimg.com/80/v2-738f3b198d9606bec2cf9f09b4ba17e1_720w.webp)

## **PCI和PCIe架构**

**1。PCI架构**

一个典型的桌面系统PCI架构如下图：

![img](https://pic4.zhimg.com/80/v2-4e65325c72f0a1c6c6164bdc0480ceeb_720w.webp)



如图，桌面系统一般只有一个Host Bridge用于隔离处理器系统的存储器域与PCI总线域，并完成处理器与PCI设备间的数据交换。每个Host Bridge单独管理独立的总线空间，包括PCI Bus, PCI I/O, PCI Memory, and PCI
Prefetchable Memory Space。桌面系统也一般只有一个Root Bridge，每个Root Bridge管理一个Local Bus空间，它下面挂载了一颗PCI总线树，在同一颗PCI总线树上的所有PCI设备属于同一个PCI总线域。一颗典型的PCI总线树如图：

![img](https://pic3.zhimg.com/80/v2-8019075041788ae2cc2810cb80be24aa_720w.webp)



从图中我们可以看出 PCI 总线主要被分成三部分：

**1. PCI 设备**。符合 PCI 总线标准的设备就被称为 PCI 设备，PCI 总线架构中可以包含多个 PCI 设备。图中的 Audio、LAN 都是一个 PCI 设备。PCI 设备同时也分为主设备和目标设备两种，主设备是一次访问操作的发起者，而目标设备则是被访问者。

**2. PCI 总线**。PCI 总线在系统中可以有多条，类似于树状结构进行扩展，每条 PCI 总线都可以连接多个 PCI 设备/桥。上图中有两条 PCI 总线。

**3. PCI 桥**。当一条 PCI 总线的承载量不够时，可以用新的 PCI 总线进行扩展，而 PCI 桥则是连接 PCI 总线之间的纽带。

服务器的情况要复杂一点，举个例子，如Intel志强第三代四路服务器，共四颗CPU，每个CPU都被划分了共享但区隔的Bus, PCI I/O, PCI Memory范围，其构成可以表示成如下图：

![img](https://pic4.zhimg.com/80/v2-2e430393cb6da69680ed29392f16be23_720w.webp)



可以看出，只有一个Host Bridge，但有四个Root Bridge，管理了四颗单独的PCI树，树之间共享Bus等等PCI空间。

在某些时候，当服务器连接入大量的PCI bridge或者PCIe设备后，Bus数目很快就入不敷出了，这时就需要引入Segment的概念，扩展PCI Bus的数目。如下例：

![img](https://pic2.zhimg.com/80/v2-6120bf97769e5475bfc19dea4205d371_720w.webp)



如图，我们就有了两个Segment，每个Segment有自己的bus空间，这样我们就有了512个Bus数可以分配，但其他PCI空间因为只有一个Host Bridge所以是共享的。会不会有更复杂的情况呢? 在某些大型服务器上，会有多个Host bridge的情况出现，这里我们就不展开了。

PCI标准有什么特点吗？

**1. 它是个并行总线**。在一个时钟周期内32个bit（后扩展到64）同时被传输。引脚定义如下：

![img](https://pic1.zhimg.com/80/v2-bf70576db45c42fc9575532637054420_720w.webp)



地址和数据在一个时钟周期内按照协议，分别一次被传输。

**2. PCI空间与处理器空间隔离。**PCI设备具有独立的地址空间，即PCI总线地址空间，该空间与存储器地址空间通过Host bridge隔离。处理器需要通过Host bridge才能访问PCI设备，而PCI设备需要通过Host bridge才能主存储器。在Host bridge中含有许多缓冲，这些缓冲使得处理器总线与PCI总线工作在各自的时钟频率中，彼此互不干扰。Host bridge的存在也使得PCI设备和处理器可以方便地共享主存储器资源。处理器访问PCI设备时，必须通过Host bridge进行地址转换；而PCI设备访问主存储器时，也需要通过Host bridge进行地址转换。

深入理解PCI空间与处理器空间的不同是理解和使用PCI的基础。

**3.扩展性强。**PCI总线具有很强的扩展性。在PCI总线中，Root Bridge可以直接连出一条PCI总线，这条总线也是该Root bridge所管理的第一条PCI总线，该总线还可以通过PCI桥扩展出一系列PCI总线，并以Root bridge为根节点，形成1颗PCI总线树。在同一条PCI总线上的设备间可以直接通信，并不会影响其他PCI总线上设备间的数据通信。隶属于同一颗PCI总线树上的PCI设备，也可以直接通信，但是需要通过PCI桥进行数据转发。

**2。PCIe架构**

PCI后期越来越不能适应高速发展的数据传输需求，PCI-X和AGP走了两条略有不同的路径，PCI-x不断提高时钟频率，而AGP通过在一个时钟周期内传输多次数据来提速。随着频率的提高，PCI并行传输遇到了干扰的问题：高速传输的时候，并行的连线直接干扰异常严重，而且随着频率的提高，干扰（EMI）越来越不可跨越。

> 乱入一个话题，经常有朋友问我为什么现在越来越多的通讯协议改成串行了，SATA/SAS，PCIe，USB，QPI等等，经典理论不是并行快吗？一次传输多个bit不是效率更高吗？从PCI到PCIe的历程我们可以一窥原因。

PCIe和PCI最大的改变是由并行改为串行，通过使用差分信号传输（differential transmission），如图

![img](https://pic2.zhimg.com/80/v2-4491752697f63101aa294e0f147a8ad9_720w.webp)



相同内容通过一正一反镜像传输，干扰可以很快被发现和纠正，从而可以将传输频率大幅提升。加上PCI原来基本是半双工的（地址/数据线太多，不得不复用线路），而串行可以全双工。综合下来，如果如果我们从频率提高下来得到的收益大于一次传输多个bit的收益，这个选择就是合理的。我们做个简单的计算:

**PCI传输:** 33MHz x 4B = 133MB/s

**PCIe 1.0 x1:** 2.5GHz x 1b = 250MB/s (知道为什么不是2500M / 8=312.5MB吗？)

速度快了一倍!我们还得到了另外的好处，例如布线简单，线路可以加长（甚至变成线缆连出机箱！），多个lane还可以整合成为更高带宽的线路等等。

PCIe还在很多方面和PCI有很大不同：

**1. PCI是总线结构，而PCIe是点对点结构**。一个典型的PCIe系统框图如下：

![img](https://pic4.zhimg.com/80/v2-710e375e3faea0c7103ebf4e3f82b957_720w.webp)



一个典型的结构是一个root port和一个endpoint直接组成一个点对点连接对，而Switch可以同时连接几个endpoint。一个root port和一个endpoint对就需要一个单独的PCI bus。而PCI是在同一个总线上的设备共享同一个bus number。过去主板上的PCI插槽都公用一个PCI bus，而现在的PCIe插槽却连在芯片组不同的root port上。

**2. PCIe的连线是由不同的lane来连接的**，这些lane可以合在一起提供更高的带宽。譬如两个1lane可以合成2lane的连接，写作x2。两个x2可以变成x4，最大直到x16，往往给带宽需求最大的显卡使用。

**3. PCI配置空间从256B扩展为4k**，同时提供了PCIe memory map访问方式，我们在软件部分会详细介绍。

**4.PCIe提供了很多特殊功能**，如Complete Timeout(CTO)，MaxPayload等等几十个特性，而且还在随着PCIe版本的进化不断增加中，对电源管理也提出了单独的State（L0/L0s/L1等等）。这些请参见PCIe 3.0 spec，本文不再详述。

**5. 其他**VC的内容，和固件理解无关，本文不再提及。INT到MSI的部分会在将来介绍PC中断系统时详细讲解。



PCIe 1.0和2.0采用了8b/10b编码方式，这意味着每个字节（8b）都用10bit传输，这就是为什么2.5GHz和5GHz时钟，每时钟1b数据，结果不是312.5MB/s和625MB/s而是250MB/s和500MB/s。PCIe 3.0和4.0采用128b/130b编码，减小了浪费（overhead），所以才能在8GHz时钟下带宽达到1000MB/s（而不是800MB/s）。即将于今年发布的PCIe 4.0还会将频率提高一倍，达到16GHz，带宽达到2GB/s每Lane。

![img](https://pic3.zhimg.com/80/v2-b9b5416c8d06f090e42ffeace2d57a6e_720w.webp)



## **后记**

对于一般用户来说，PCIe对用户可见的部分就是主板上大大小小的PCIe插槽了，有时还和PCI插槽混在一起，造成了一定的混乱，其实也很好区分：

![img](https://pic3.zhimg.com/80/v2-d929eba435900f04444ac4dd7a7a660a_720w.webp)



如图，PCI插槽都是等长的，防呆口位置靠上，大部分都是纯白色。PCIe插槽大大小小，最小的x1，最大的x16，防呆口靠下。各种PCIe插槽大小如下：

![img](https://pic4.zhimg.com/80/v2-85d997ae15577e8e04cfc5d7e1b448cf_720w.webp)



**常见问题**：

Q:我主板上没有x1的插槽，我x1的串口卡能不能插在x4的插槽里。

A: 可以，完全没有问题。除了有点浪费外，串口卡也将已x1的方式工作。

Q:我主板上只有一个x16的插槽，被我的显卡占据了。我还有个x16的RAID卡可以插在x8的插槽内吗？

A: 你也许会惊讶，但我的答案同样是：可以！你的RAID卡将以x8的方式工作。实际上来说，你可以将任何PCIe卡插入任何PCIe插槽中! PCIe在链接training的时候会动态调整出双方都可以接受的宽度。最后还有个小问题，你根本插不进去！呵呵，有些主板厂商会把PCIe插槽尾部开口，方便这种行为，不过很多情况下没有。这时怎么办？你懂的。。。。

Q: 我的显卡是PCIe 3.0的，主板是PCIe2.0的，能工作吗？

A: 可以，会以2.0工作。反之，亦然。

Q: 我把x16的显卡插在主板上最长的x16插槽中，可是benchmark下来却说跑在x8下，怎么回事?！

A: 主板插槽x16不见得就连在支持x16的root port上，最好详细看看主板说明书，有些主板实际上是x8。有个主板原理图就更方便了。

Q: 我新买的SSD是Mini PCIe的，Mini PCIe是什么鬼？

A: Mini PCIe接口常见于笔记本中，为54pin的插槽。多用于连接wifi网卡和SSD，注意不要和mSATA弄混了，两者完全可以互插，但大多数情况下不能混用（除了少数主板做了特殊处理），主板设计中的防呆设计到哪里去了！请仔细阅读主板说明书。另外也要小心不要和m.2(NGFF)搞混了，好在卡槽大小不一样。

PCI系列二： [深入PCI与PCIe之二：软件篇 - 知乎专栏](https://zhuanlan.zhihu.com/p/26244141)

欢迎大家关注本专栏和用微信扫描下方二维码加入微信公众号"UEFIBlog"，在那里有最新的文章。同时欢迎大家给本专栏和公众号投稿！

![img](https://pic3.zhimg.com/80/v2-45479ebdd2351fcdcfb0771bd06fff3a_720w.webp)

用微信扫描二维码加入UEFIBlog公众号

编辑于 2017-10-28 21:12



[电脑硬件](https://www.zhihu.com/topic/19598606)

[PCI](https://www.zhihu.com/topic/19618064)

[固件](https://www.zhihu.com/topic/19700304)