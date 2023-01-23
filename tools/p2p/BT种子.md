#  BT种子

本词条由[“科普中国”科学百科词条编写与应用工作项目](https://baike.baidu.com/science) 审核 。

一种[电脑](https://baike.baidu.com/item/电脑/124859)“.[torrent](https://baike.baidu.com/item/torrent/6640021)”文件，装有BT（BitTorrent）下载必须的文件信息，作用相当于[HTTP](https://baike.baidu.com/item/HTTP/243074)下载里的[URL](https://baike.baidu.com/item/URL)链接。

一个用户要利用[BitTorrent协议](https://baike.baidu.com/item/BitTorrent协议/10961364)下载[文件](https://baike.baidu.com/item/文件/24602116)之前，先要从某个网站下载一个包含该文件相关信息的“.torrent”文件。

该种子文件包含一个称为“追踪器（tracker）”的[服务器](https://baike.baidu.com/item/服务器/100571)节点（因特网上有很多追踪器）的地址，该追踪器负责维护参与一个特定文件分发的所有对等方的信息。 [1] 

- 中文名

  BT种子

- 外文名

  bit torrent seed

- 类  型

  下载内链

- 扩展名

  .torrent

- 大  小

  10-200KB

- 发明者

  [布莱姆·科恩](https://baike.baidu.com/item/布莱姆·科恩/6406546)（Bram Cohen）

## 目录

1. 1 [相关概念](https://baike.baidu.com/item/BT种子#1)
2. ▪ [P2P](https://baike.baidu.com/item/BT种子#1_1)
3. ▪ [BitTorrent协议](https://baike.baidu.com/item/BT种子#1_2)

1. 2 [简介](https://baike.baidu.com/item/BT种子#2)
2. 3 [文件结构](https://baike.baidu.com/item/BT种子#3)
3. 4 [使用方法](https://baike.baidu.com/item/BT种子#4)

1. ▪ [下载资源](https://baike.baidu.com/item/BT种子#4_1)
2. ▪ [发布资源](https://baike.baidu.com/item/BT种子#4_2)

## 相关概念

[编辑](javascript:;)[ 语音](javascript:;)

### P2P

Peer to Peer点对点网络，简称 P2P，是指网络用户之间可以直接通信的网络结构。简单的说，[P2P](https://baike.baidu.com/item/P2P/139810)直接将人们联系起来，让人们通过[互联网](https://baike.baidu.com/item/互联网/199186)直接交互。使得网络上的沟通变得容易、更直接共享和交互，真正地消除中间环节。P2P使用户可以直接连接到其他用户的计算机，而不是像过去那样连接到[服务器](https://baike.baidu.com/item/服务器/100571)去浏览与下载。P2P另一个重要特点是改变互联网现在的以大网站为中心的状态，重返“非中心化”，把权力交还给用户。 [2] 

### BitTorrent协议

[BitTorrent](https://baike.baidu.com/item/BitTorrent/142795)（简称 BT，比特洪流）是一个多点下载的的 P2P文件共享软件。它由程序员 Bram Cohen使用 [Python](https://baike.baidu.com/item/Python/407313)语言编写，并且还是代码开源的[专利](https://baike.baidu.com/item/专利/927670)软件，可以自由地下载和传播。它采用高效的软件分发系统和点对点技术共享大体积文件（如一部电影或电视节目），使多个用户同时下载一个文件的时候，他们之间互相为对方提供自己所拥有的文件部分的下载。这样就把文件下载的带宽开销分摊到每个用户那里，理论上 BT下载可以支持无限多个用户来下载同一个文件。因此，BT被人们称之为“群集、散布、集中”的[文件传输协议](https://baike.baidu.com/item/文件传输协议/1874113)。目前，各种支持 BT下载的软件层出不穷，BT技术已经被广泛的应用于文件下载中。

一般来说一个BT文件发布系统由以下几个部分组成：

（1）一个普通的web 服务器；

（2）一个静态元信息文件，即BT种子文件( 以.torrent 结尾, 包含了文件的基本属性)；

（3）一个追踪器（Tracker）；Tracker实际上是一台服务器，它负责帮助peer之间相互建立连接；

（4）BT客户端(peer，系统的核心部分，用于实现下载策略)；

（5）一个被下载文件的拥有者（seed）。 [3] 

## 简介

[编辑](javascript:;)[ 语音](javascript:;)

种子是一个形象的比喻。BT下载的原理从某种意义上说就像春天种下一粒种子，到了秋天就会收获万粒稻菽一样的滚雪球般的越来越大。于是人们就把发出的下载文件叫做种子。而种子文件就是记载下载文件的存放位置、大小、下载服务器的地址、发布者的地址等数据的一个索引文件。这个种子文件并不是你最终要下载的东西（如电影，[软件](https://baike.baidu.com/item/软件/12053)等等），但是有了种子文件，你就能高速下载到你需要的文件。种子文件的扩展名是：*.torrent。

BT种子可称为比特流种子，主要是因为很多下载软件解析种子后下载速度很快。

BT首先在上传者端把一个文件分成了Z个部分，甲在服务器随机下载了第N个部分，乙在服务器随机下载了第M个部分，这样甲的BT就会根据情况到乙的电脑上去拿乙已经下载好的M部分，乙的BT就会根据情况去到甲的电脑上去拿甲已经下载好的N部分，这样就不但减轻了服务器端的[负荷](https://baike.baidu.com/item/负荷/11010944)，也加快了用户方（甲乙）的下载速度，效率也提高了，更同样减少了地域之间的限制。比如说丙要连到服务器去下载的话可能才几K，但是要是到甲和乙的电脑上去拿就快得多了。所以说用的人越多，下载的人越多，大家也就越快，BT的优越性就在这里。而且，在你下载的同时，你也在上传（别人从你的电脑上拿那个文件的某个部分），所以说在享受别人提供的下载的同时，你也在贡献。

BT把提供完整文件的档案称为种子（SEED），正在下载的人称为客户（Client），某一个文件有多少种子多少客户是可以看到的，只要有一个种子，就可以放心地下载，一定能抓完。当然，种子越多、客户越多的文件抓起来的速度会越快，下载以后的种子可能会因目标文件不存在而失效。

BT 是通过BT种子文件进行下载部署的，BT种子文件放在一个普通的网络服务器上，它包含了要共享的文件的信息，包括文件名、大小、文件的分块信息和一个指向追踪器的超级链接[Url](https://baike.baidu.com/item/Url/110640)。被下载文件的拥有者也可以看成这个文件的“原始”下载者。要求文件下载的用户通过BT客户端软件分解.torrent 文件，取得文件的信息和指向追踪器服务器的 Url，同 Tracker进行通讯。 [4] 

## 文件结构

[编辑](javascript:;)[ 语音](javascript:;)

BT种子文件（.torrent）的具体文件结构如下： [4] 

全部内容必须都为Bencoding编码类型。整个文件为一个字典结构，包含如下关键字：

**announce**： tracker 服务器的 URL（字符串）；

**announce-list**（可选）：备用 tracker 服务器列表（列表）；

**creation date**（可选）：种子创建的时间，Unix 标准时间格式，从 1970 1 月1 日 00：00：00 到创建时间的秒数（[整数](https://baike.baidu.com/item/整数/1293937)）；

**comment**（可选）：备注（字符串） created by（可选）：创建人或创建程序的信息（字符串）；

**info**：一个字典结构，包含文件的主要信息。分为二种情况，单文件结构或多文件结构。

单文件info结构如下：

**length**：文件长度，单位字节（整数）；

**md5sum**（可选）：长 32 个字符的文件的 MD5 校验和，BT 不使用这个值，只是为了兼容一些程序所保留!（字符串）；

**name**：文件名（字符串）；

**piece length**：每个块的大小，单位字节（整数）， 块长一般来说是 2 的权值；

**pieces**：每个块的 20 个字节的 SHA1 Hash 的值（二进制格式）。

多文件info结构如下：

**files**：一个字典结构；

**length**：文件长度，单位字节（整数）；

**md5sum**（可选）：与单文件结构中相同；

**path**：文件的路径和名字，是一个列表结构，如\test\test。txt 列表为l4：test8test。txte；

**name**：最上层的目录名字（字符串）；

**piece length**：与单文件结构中相同；

**pieces**：与单文件结构中相同。

## 使用方法

[编辑](javascript:;)[ 语音](javascript:;)

### 下载资源

首先，客户端用户访问BT发布站点，通过站点上的信息找到想要的资源文件。其中Bt发布站点上显示[共享文件](https://baike.baidu.com/item/共享文件/3638070)的信息和每个文件的共享用户信息，并为每个文件提供一个种子文件的下载链接。

客户端下载了该种子后，与BT种子文件中的跟踪服务器（Tracker）通讯。跟踪服务器首先记录该客户端的用户信息，同时将其它共享用户的信息提供给该客户端，该客户端根据这些信息与其他共享用户的客户端软件发生[通讯](https://baike.baidu.com/item/通讯/22176439)，从其中找出下载速率最快的40~50个客户端进行下载；其中每个客户端都按照种子文件中的规定对文件进行分块。文件的上传和下载都是按块进行的。

当客户端软件完成一个文件分块的下载后，就可以进行该块的上传。

随着参与下载的用户数量的增加，下载速度加速。

完成整个共享文件的下载后客户端就只上传，不下载，成为共享文件的种子；在一些人气很旺的下载中，原始下载者经常可以在较短的时间内退出上传，由其它已经下载到整个文件的下载者继续提供上传。

[![图1 通信连接过程](https://bkimg.cdn.bcebos.com/pic/0824ab18972bd407aac2d21c75899e510eb309cd?x-bce-process=image/resize,m_lfit,w_440,limit_1/format,f_auto)](https://baike.baidu.com/pic/BT种子/2665329/0/0824ab18972bd407aac2d21c75899e510eb309cd?fr=lemma&ct=single)图1 通信连接过程

部分完成的用户开始退出，当某个种子的所有用户均结束下载或上传后，该种子可用生命期结束。

Tracker即时接收所有peer信息，并且给每个peer一份随机的peers列表。Tracker通过 [HTTP](https://baike.baidu.com/item/HTTP/243074) GET参数获得信息，然后返回一个Bencoding编码后的信息。peer每隔一段时间连一次Tracker，告知自己的进度，并和那些已经直接连接上的peer进行数据的上传下载。这些连接遵循BitTorrent peer协议，通过[TCP](https://baike.baidu.com/item/TCP/33012)协议进行通信。seed和tracker，peers之间通讯连接的步骤如图1。 [5] 

### 发布资源

上面讲过，同一个资源，[下载](https://baike.baidu.com/item/下载/2270927)的人越多，下载的速度也就越快。经常用BT下载的电脑，一般都默认共享了不止一个资源，因此想办法让拥有你想要的资源的那些电脑连入网络，就是很有必要的。具体办法就是发布一个大家也都需要的资源，这也充分体现了BT下载模式最重要的精神——分享。

要想发布一个资源，要经过2个步骤：制作种子文件、传播种子文件。当然还要把该种子文件对应的资源所在电脑开机连入网络一段时间，具体时间不定，主要看该种子下载的情况，最好至少要保证有一部分人下载成功。

用户发布一个 BT 种子文件的具体步骤如下：

（1）选择一个BT发布站点，这个站点运行普通的网络服务器端程序，如 [Apache](https://baike.baidu.com/item/Apache/6265)、IIS 等。通过网站帮助信息找到Tracer的Url。

（2）用要发布的完整文件和Tracker的URL创建一个种子文件（.torrent 文件）；

（3）将种子文件上传到网络服务器上；

（4）在网络服务器的网页上发布种子文件（.torrent 文件）链接和对这个文件的一些简单的描述；

（5）发布用户（seed）提供完整的文件。 [5] 

词条图册[更多图册](https://baike.baidu.com/pic/BT种子/2665329?fr=lemma)

[![概述图册](https://bkimg.cdn.bcebos.com/pic/fc1f4134970a304efe5a4d80d2c8a786c9175c54?x-bce-process=image/resize,m_lfit,w_235,h_235,limit_1/format,f_auto)概述图册(1)](https://baike.baidu.com/pic/BT种子/2665329/1/fc1f4134970a304efe5a4d80d2c8a786c9175c54?fr=lemma)

- 参考资料

  1.[ ](https://baike.baidu.com/item/BT种子#ref_[1]_147660)谢钧 谢希仁．计算机网络教程（第四版）：人民邮电出版社，2014年9月第四版：2752.[ ](https://baike.baidu.com/item/BT种子#ref_[2]_147660)[基于BitTorrent种子的内容分发算法 ](https://baike.baidu.com/reference/2665329/6926CE8OTiTnzRlVhWV8qjaHGF1LO0pTtjxXICV0A3IUUvTRQL3GC6F-7o9aFlby-kc46gCMEOjZsP4Fqx0Mlx-zsQQwNvtpOWg1IMvKXG6ecDiIMein) ．中国知网[引用日期2019-06-27]3.[ ](https://baike.baidu.com/item/BT种子#ref_[3]_147660)[BitTorrent模型原理分析 ](https://baike.baidu.com/reference/2665329/022870LWsMvFuABLoNuisDGfOpyau5hp8RNpFP0iF1jlrVde_Z0suMoPa7E6I0-UBBIcbIuMyOOXirLo8oCpHzTxS3ctaReOyYTyjzC3PSeufLv5WrHS) ．中国知网[引用日期2019-06-27]4.[ ](https://baike.baidu.com/item/BT种子#ref_[4]_147660)[BitTorrent种子质量评估与检索系统设计 ](https://baike.baidu.com/reference/2665329/e524uAo5OLdFRYj-zekq_z1LLSnfOZR2lRzW0DXHFrdac1uf7yNfC1UH58zLgvSIo375G7NyuzNw0uQ_klp2jydIw4tQbVSDscDw04Df-00qNiDSYow) ．中国知网[引用日期2019-06-27]5.[ ](https://baike.baidu.com/item/BT种子#ref_[5]_147660)[BitTorrent对等网文件共享系统关键技术研究 ](https://baike.baidu.com/reference/2665329/f167XQmuMS9f7IEpXAgUFIZcpgAyEnPkLV4MtRBGLwktei1GyPtOxFfZfJZ3BuvvHpUnx7kgt-X9RMqTkconHghMCbY4Do-Z0hyDEDLqv9Bk4BRlAyU) ．中国知网[引用日期2019-06-27]