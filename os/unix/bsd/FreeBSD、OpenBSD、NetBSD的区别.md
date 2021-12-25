# FreeBSD、OpenBSD、NetBSD的区别

[曹帅军](https://www.jianshu.com/u/f9dd544da438)关注

0.7252019.02.26 16:02:21字数 3,236阅读 2,708

[原文链接](http://www.361way.com/unix-bsd/1513.html)

## 概述

一直unix在我心目中的地位都很高，unix的稳定性和完整性是windows和linux所无法匹敌的。而且从另一种意义上说，linux其实也算是从unix里的一个分支。我曾有幸安装过AIX，不过当时对unix/linux系统了解还少，仅仅只在会装的程序。受致于硬件环境的局限，以致无缘再使用。而HP－unix也一样，都是只对自己的cpu硬件进行支持。而平民化了的unix里比较出名的当数BSD家族了。就连风光无限的苹果也是从这个分支里演变出来的。

BSD家族里出名的又数FreeBSD、OpenBSD、NetBSD，具体三者之间有何区别和联系，下面看下出自“站长之家”一篇不错的对比评测：

暂时忘记Windows和Linux吧，不太出名的BSD也许才是你所需要的。

如果提到Web或者阅读一本计算机杂志就不可能不涉及到Linux，它是由Linus Torvalds和其他人共同开发的伟大的操作系统。但是尽管Linux占据了最重要的位置，ISP和系统管理员们也经常选择BSD里的一种作为操作系统，BSD是一类建立在代码共享基础上的操作系统，在过去的20多年里，美国的顶尖学院都一直在对它进行研究。

BSD究竟是什么呢？如果你在寻找一个非Windows操作系统，又为什么应该考虑使用它们呢？ 学术渊源BSD是Berkeley Software Distribution的缩写，这是一个由加州大学伯克利分校开发的软件集合。最初BSD只是作为AT&T的Unix早期版本的附加软件包出现，后来它就逐渐地发展为一个完整的，高度复杂的具有Unix风格的操作系统——它第一个集成了网络功能。

通过追求完美主义的学术机构的努力以及经过挑剔的几代学生的测试，BSD也许是最健壮、最安全和最值得信赖的操作系统。对以BSD为基础的操作系统来说运行几年无需维护或重启是很平常的事情。由于BSD是在代码公开的环境下发展起来的，因而它对所有的顾客（包括那些想把它植入商业产品的软件开发商）都是完全免费的。来自BSD的网络代码几乎是所有现代操作系统的中心部分，包括Linux、OS/2以及Windows 95以来几乎每个Windows版本。

## 秘密武器

如果BSD真是那么优秀，为什么他们没有像Linux那样成为市场的领先者呢？这其中最重要的原因就是文化。许多Linux开发商把他们自己看作软件革命者。但是学术团体（BSD真正扎根的地方）的成员们更注重于结果而不是让这个产品出名。BSD在系统管理员和ISP用户中也有一批忠实的追随者，但是这些人通常更喜欢把他们的BSD作为秘密武器，而不是到处宣扬他们正在使用这种操作系统。

结果，没有多少人认识到BSD的各个版本或为像Yahoo!一样的大型网站的基础，而且还对IBM InterJet和Maxtor的网络存储服务器这些高可靠性的嵌入式系统提供了有利的支持。BSD的一个变种NetBSD被认为是全世界最轻便的操作系统，它可以在不同的CPU（种类超过64个）和几百种不同品牌和型号的计算机上运行。

现在，共有5个流行的BSD操作系统，其中的三个——FreeBSD，NetBSD 和OpenBSD——得到了BSD的授权，操作系统和源代码都是免费的，任何人都可以用于任何目的。其余的两个BSD/OS和Mac OS X是商业产品，它们以开放的BSD代码为基础，具有特殊的优势和与众不同的技术。在本文中，我们将讨论免费的版本。至于对BSD/OS和Mac OS X以及建立在Linux General Public License基础上的BSD授权的优势的讨论，参见我们站点上的其它文章“More about BSD”。

## BSD家族大观 1.FreeBSD

FreeBSD是从386BSD的基础上发展起来的，而386BSD是由伯克利的计算机科学家Bill Jolitz 开发的针对Intel 80386芯片的一种BSD版本。因为这个原因，FreeBSD在32位体系的x86机器上总是运行得最好。在免费的BSD中，它与PC兼容机配合得最好，而且支持的PC兼容的外部设备的数量也最多。尽管FreeBSD也可以运行在Alpha处理器上，向其他体系结构的移植也在进行当中，但是你更应该把它看作是主要针对x86系统的操作系统。

在免费的BSD中，FreeBSD是名声最大的，它具有最强大的开发队伍，收到的反馈信件也最多，还拥有最多数量的用户。它还可能是所有免费操作系统中最容易安装的——尤其当你想通过Internet而不是购买光盘进行安装的话。

Linux的发行商经常把他们的拷贝弄得很难通过Internet安装。毕竟，他们的业务决定于光盘的销售。而FreeBSD就不是这样了：它的所有要求就是两张软盘（在FreeBSD Web站点上用工具和映射文件很容易创建）和速度适宜的网络连接。从第一张软盘开始启动，然后插入第二张。安装程序会帮助你选择配置选项，从网上下载整个系统并把所有的东西正确地安装好。而那些想要光盘的人也可以从Wind River Systems的FreeBSD Mall 那儿或者从Cheap Bytes那里得到。你也可以在FreeBSD Web站点上用一个ISO映射文件制作光盘。

FreeBSD另外一个强大之处在于它有广泛的应用软件支持——超过5800种免费程序都可以供你立即下载并添加在FreeBSD的系统上。事实上，所有你需要用来建立一个工作站或者一个商业服务器的软件都已经随FreeBSD安装或者可以随后自行添加进系统里。

此外，像OpenBSD和NetBSD一样，FreeBSD事实上能够运行所有针对Linux、SCO Unix或者Intel版本的Solaris 的程序。同Linux一样，FreeBSD使用X Window系统以及所有针对那个协议开发的的桌面和图形用户界面，包括KDE、GNOME和为这两者所写的程序。

最后，FreeBSD对新用户来说具有最多的参考资料。FreeBSD Handbook 为新的顾客提供了极好的使用说明。许多出版公司都推出了针对初级和高级用户所写的指导书。

简而言之，FreeBSD对Linux来说是一个强大的挑战者，它也许能提供出众的稳定性，安装的简易性和方便。

## BSD家族大观 2.OpenBSD

OpenBSD是另外一个免费BSD的派生物，被称为世界上最安全的操作系统。OpenBSD的主页（www. [openbsd.org](http://openbsd.org/)）报告说OpenBSD“在默认安装情况下四年内没有一个小的安全漏洞”，它的意思是说（其实任何人都知道）在过去的四年内发布的OpenBSD版本没有一个被来自Internet的袭击攻破。（当然，你也可以使得任何操作系统——包括OpenBSD——变得易受攻击，如果你没有正确配置服务器或者运行那些导致入侵者进入的不安全软件。） OpenBSD也完全集成了密码安全软件以保证数据安全。

OpenBSD并不是集成Unix组件功能最多的代表，它也不是运行最快的。但是在这些领域里，它也不是太差的。这个操作系统很小，但效率很高，它能在老的只有16MB内存的486机器上运行得很好——要知道这样一个硬件配置是不能运行Windows 2000的。其它的操作系统都没有任何一个享有OpenBSD在安全问题上创造的高可靠性纪录。一些远程根目录问题一般每个月都会发生在Microsoft的操作系统上，比如说Windows 2000。而最近发行的许多Linux已经成为Ramen蠕虫一类病毒的攻击对象。

像FreeBSD和NetBSD一样，OpenBSD也有很多应用软件支持，它包含了许多免费软件包的定制版本。它的软件库没有FreeBSD中的那么大，但是包含了大多数你想给Unix服务器或者工作站安装的工具。OpenBSD的x86版本也能够运行针对FreeBSD、Linux和Solaris创建的程序。OpenBSD支持10种计算机体系结构——比FreeBSD还多，但是没有NetBSD多。从OpenBSD自身或者Cheap Bytes那儿就可以得到OpenBSD光盘。然而，你却得不到ISO映射文件，因为开发组更愿意通过出售CD的方式作为对他们努力的支持。你可以通过网络来安装操作系统，只不过安装者的用户界面没有FreeBSD那么美观而已。 在这三种免费BSD中，OpenBSD的开发成员最少并且对Unix新手
来说是最难学的。但是如果你确实需要一个牢靠的网络防火墙或者服务器的话，OpenBSD正是合适的选择。

## BSD家族大观 3. NetBSD

NetBSD
NetBSD也是免费BSD的一种，它是基于BSD的最轻便的操作系统。目前能够在46种之多的不同硬件构架上运行（他们正在努力使之能够适应更多的构架），从原始的基于68K的Macintosh或者Amiga一直到AMD还没有发表的x86-64 Hammer结构，NetBSD都能够很好地运行。

这种便携性使得NetBSD成为嵌入式系统（在其它设备中运行的，看不见的计算机）的最佳选择。因为编写从一个平台到另一个平台的代码最容易暴露缺陷（否则的话是不会引人注意的），而来自NetBSD的代码却是少有的健壮；OpenBSD（最初是针对NetBSD对象设计的）和FreeBSD在过去都曾借鉴过它。NetBSD也是许多独立类型硬件的操作系统的选择，包括老的Sun工作站。

像FreeBSD和OpenBSD一样，NetBSD有一个巨大的应用软件库（比FreeBSD少而比OpenBSD多），并且能够运行针对Linux和其它版本Unix编译的商业程序。从Wasabi Systems，Cheap Bytes和其它一些NetBSD Web站点列出来的资源那儿我们可以得到NetBSD光盘。你可以下载ISO光盘映射文件，也可以通过FTP进行安装。

看完了“站上之家”的评论，个人也想再啰嗦几句：

如果服务器生产环境使用，个人比较推荐使用FreeBSD。另外FreeBSD有三个比较出名的分支，感觉有必要介绍下：

- [FreeNAS](http://www.freenas.org/) is an open source storage platform based on FreeBSD and supports sharing across Windows, Apple, and UNIX-like systems.
- [PC-BSD](http://www.pcbsd.org/) is a FreeBSD derivative with a graphical installer and impressive desktop tools aimed at ease of use for the casual computer user.
- [pfSense](http://www.pfsense.org/) is a free, open source customized distribution of FreeBSD tailored for use as a firewall and router.
  以上是来自freeBSD官网对三者的介绍。

如是是出于安全方面的考量，openbsd是个不错的选择。不过openbsd的支持包比较少，所以比较适合做为防火墙使用。
NetBSD对硬件支持是最多的。所以一些较老旧的硬件在转不到所支持的系统驱动时，可以旧物利用，装下NetBSD。



![img](https://upload-images.jianshu.io/upload_images/8654368-024a058cea046a67.jpg?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

BSD家族树



[原文链接](http://www.361way.com/unix-bsd/1513.html)