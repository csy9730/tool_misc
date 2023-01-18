# Vmware ESXi 是免费吗？一文弄懂vSphere功能特性及ESXi与vSphere到底有什么区别和联系。

[![小辣椒高效Office](https://pic1.zhimg.com/v2-84c311f9235b1da27cc3af1ce7b643c2_l.jpg?source=172ae18b)](https://www.zhihu.com/people/tmtony)

[小辣椒高效Office](https://www.zhihu.com/people/tmtony)

77 人赞同了该文章



目录

收起

一、对VMware vSphere及ESXi的相关疑问

1、Vmware vSphere 有些什么功能？

2、ESXi 是否真正免费？

3、 ESXi 和 vSphere 到底有什么区别，可能有不少人比较混乱，有时我也弄得比较迷糊

4、VMware vsphere、VMware vsphere Hypervisor、ESXi、VMware vCenter Server 这几个到底是什么？有什么关联及区别？

二、VMware vSphere 新版 7.0或以上新特性（含 ESXi）

三、ESXi只是vSphere里的一个组件，ESXi Free(免费)版本是指VMware vSphere Hypervisor

四、先了解VMware服务器虚拟化产品的简单发展历程。

五、VMware vSphere的简介

1、VMware vSphere简单介绍：

2、核心组件

3、主要优点

4、其它特性

5、架构示意图

六、VMware vSphere Hypervisor介绍及与ESXi区别及联系

以下内容摘自百度知道，写得很不错, 很抱歉当时复制到记事本时 忘记记下原作者网址了 :(

1) VMware vSphere Hypervisor 是以前的 VMware ESXi Single Server 或免费的 ESXi

2) VMware vSphere Hypervisor 是 vSphere 产品线的免费版本。

3) VMware vSphere 以多种版本提供，其中包括专门为小型企业设计的若干选项。

4) VMware vSphere Hypervisor 免费提供，以帮助各种规模的公司体验虚拟化的基本优势。

5) VMware vSphere Hypervisor 可以无缝地升级到更高级的 vSphere 版本。

七、vSphere的组成部分：

1、VMware ESXi:

2、VMware vCenter Server：

3、VMware vSphere Client:

4、付费情况：

5、小结：

八、网上其它相关资料：

九、更官方的解释：

Vmware ESXi 相信不少玩家都玩过，之前比较稳定的版本是 6.7 ，现在又升到了7.0，但我相信也有不少玩家，对以下问题均有疑问：

## 一、对VMware vSphere及ESXi的相关疑问

### 1、Vmware vSphere 有些什么功能？

### 2、ESXi 是否真正免费？

### 3、 ESXi 和 vSphere 到底有什么区别，可能有不少人比较混乱，有时我也弄得比较迷糊

### 4、VMware vsphere、VMware vsphere Hypervisor、ESXi、VMware vCenter Server 这几个到底是什么？有什么关联及区别？

所以自己从各网站收集各种回答并整理写了这篇文章，当作笔记备忘



## 二、VMware vSphere 新版 7.0或以上新特性（含 ESXi）

可参考这篇文章：

[小辣椒高效Office：Esxi 7.0新特性及如何从Vmware虚拟机服务器从 Esxi 6.7 升级到Esxi 7.0过程5 赞同 · 7 评论文章](https://zhuanlan.zhihu.com/p/458197535)

## 三、ESXi只是vSphere里的一个组件，ESXi Free(免费)版本是指VMware vSphere Hypervisor

如果模糊来讲，vSphere就是ESXI，只是叫法不同，但严格来讲两者是不同的，简单来说：

1、ESXi只是vSphere里的一个组件，vSphere 的两个核心组件是ESXi和vCenter Server，vSphere是包含了ESXi

2、VMware vSphere 有各种版本，而我们平常说的ESXi Free(免费)版本严格意义上讲：指的应该是 VMware vSphere Hypervisor 这个。



## 四、先了解VMware服务器虚拟化产品的简单发展历程。

1、Vmware 服务器虚拟化第一个产品叫ESX，该产品只有60天测试，没有官方认可的免费版。

2、后来Vmware在4.0版本的时候推出了ESXI，ESXI和ESX的版本最大的技术区别是内核的变化，ESXI更小，更安全，更重要的是ESXI可以在网上申请永久免费的license，但是两个版本的收费版功能是完全一样的。

3、从4.0版本开始VMware把ESX及ESXi产品统称为vSphere，

4、实际上VMware vSphere指的是产品系列，其中包含esxi，vcenter，cloud等等

5、VMware到5.0之后又变了， 取消了原来的ESX版本，所以现在来讲的话vSphere就是ESXI，只是两种叫法而已。一般官方文档中以称呼vSphere为主。通常VMware vSphere又称ESX，VMware vSphere Hypervisor又称ESXi。ESXi功能上比ESX少一点

6、VMware vSphere 有各种版本，更准确来讲，我们平常说的ESXi Free(免费)版本指的是 VMware vSphere Hypervisor 这个。



## 五、VMware vSphere的简介

VMware vSphere 是 VMware 的虚拟化平台，可将数据中心转换为包括 CPU、存储和网络资源的聚合计算基础架构。vSphere 将这些基础架构作为一个统一的运行环境进行管理，并为您提供工具来管理加入该环境的数据中心。通过直接访问并控制底层资源，VMware ESXi 可有效地对硬件进行分区，以便整合应用并降低成本。它是业界领先的高效体系架构，在可靠性、性能和支持方面树立了行业标杆。

### 1、VMware vSphere简单介绍：

VMware vSphere 是业界领先且最可靠的虚拟化平台。vSphere将应用程序和操作系统从底层硬件分离出来，从而简化了 IT操作。您现有的应用程序可以看到专有资源，而您的服务器则可以作为资源池进行管理。因此，您的业务将在简化但恢复能力极强的 IT 环境中运行。

VMware、vSphere、Essentials 和 Essentials Plus 套件专为工作负载不足 20 台服务器的 IT 环境而设计，只需极少的投资即可通过经济高效的服务器整合和业务连续性为小型企业提供企业级 IT 管理。结合使用 vSphere Essentials Plus 与 vSphere Storage Appliance软件，无需共享存储硬件即可实现业务连续性。

### 2、核心组件

VMware ESXi 安装文件可以从VMware的官方网站上直接下载（注册时需提供一个有效的邮箱），下载得到的是一个iso 文件，可以刻录成光盘或量产到U盘使用，由于ESXi 本身就是一个操作系统(Linux内核)，因此在初次安装时要用它来引导系统；

**vSphere 的两个核心组件是ESXi和vCenter Server**。

ESXi是用于创建并运行虚拟机和虚拟设备的虚拟化平台。

vCenter Server是一项服务，用于管理网络中连接的多个主机，并将主机资源池化。

ESXi是直接安装在物理机器上的，是采用Linux内核的虚拟化专用操作系统。Esxi主机是物理机器真是存在的一个物理主机（当然也可以是虚拟机），其实就是一个装了系统的电脑。ESXI是一个系统，就跟windows，linux系统一样的一个系统。

### 3、主要优点

（1）确保业务连续性和始终可用的 IT。

（2）通过集中管理功能精简 IT 管理 ，降低 IT 硬件和运营成本。

（3）提高应用程序质量。

（4）增强安全性和数据保护能力。

（5）整合硬件，以实现更高的容量利用率。

（6）提升性能，以获得竞争优势

（7）最大限度地减少所需的硬件资源，这意味着可以提高效率。

### 4、其它特性

**功能特性**

ESXi 可将多台服务器整合到较少物理设备中，从而减少对空间、电力和 IT 管理的要求，同时提升性能。

**占用空间小**

尽管 ESXi 占用空间仅为 150 MB，却可实现更多功能，同时还能最大限度地降低 Hypervisor 的安全风险。

**可靠的性能**

适应任何规模的应用。虚拟机配置最高可达 128 个虚拟 CPU、6 TB 的 RAM 和 120 台设备，以满足您的所有应用需求。咨询各项解决方案限制以确保您不会超过您环境的受支持配置。

**增强的安全性**

利用强大的加密功能保护敏感的虚拟机数据。基于角色的访问可简化管理，而广泛的日志记录和审核可以更好地落实责任，还可更加轻松地进行取证分析。

**卓越的生态系统**

获取对由硬件 OEM 供应商、技术服务合作伙伴、应用和客户机操作系统组成的广泛生态系统的支持。

**方便用户使用的体验**

利用基于 HTML5 标准的内置现代 UI 管理日常行政操作。对于需要实现运维自动化的客户，VMware 提供 vSphere 命令行界面和便于开发人员使用、基于 REST 的 API。

### 5、架构示意图

![img](https://pic4.zhimg.com/80/v2-0f8000831770b206340474e31b18dbaf_1440w.webp)



新版vSphere7.0提供了各种安装和设置选项。为确保成功部署 vSphere，应了解安装和设置选项以及任务的执行顺序。**vSphere 的两个核心组件是 ESXi和vCenter Server**。**ESXi是用于创建和运行虚拟机和虚拟设备的虚拟化平台。vCenter Server 是一种服务，充当连接到网络的ESXi 主机的中心管理员。使用vCenter Server，您可以池化和管理多个主机的资源**。您需要部署 vCenter ServerAppliance，即已针对运行 vCenter Server 和vCenter Server 组件而优化的预配置虚拟机。可以在 ESXi主机或 vCenter Server 实例上部署 vCenter Server Appliance。

![img](https://pic4.zhimg.com/80/v2-a3c09e023eb25e2d5a0ba652737bc703_1440w.webp)

## 六、VMware vSphere Hypervisor介绍及与ESXi区别及联系

### 以下内容摘自百度知道，写得很不错, 很抱歉当时复制到记事本时 忘记记下原作者网址了 :(

### 1) VMware vSphere Hypervisor 是以前的 VMware ESXi Single Server 或免费的 ESXi

免费的 ESXi（通常简称为“VMware ESXi”）的新名称。

VMware vSphere Hypervisor是基于esxi的产品 它是由vmware esxi和vmware vsphere client组成，是一个免费的产品。官网下载时，会给你一个license，你安装完client以后，注册license，就不会只试用60天了。新版更新至VMware vSphere Hypervisor 6.7（我们平常说的ESXi 6.7)，现在更新到VMware vSphere Hypervisor 7.0 (我们平常说的 ESXi 7.0) ，免费版只要注册账号就有序列号。

### 2) VMware vSphere Hypervisor 是 vSphere 产品线的免费版本。

为其授予的许可仅发挥 vSphere 的虚拟化管理程序功能，但它也可无缝地升级到更高级的 VMware vSphere 版本。

### 3) VMware vSphere 以多种版本提供，其中包括专门为小型企业设计的若干选项。

### 4) VMware vSphere Hypervisor 免费提供，以帮助各种规模的公司体验虚拟化的基本优势。

通过授予对 vSphere 基本虚拟化管理程序功能的免费使用权限，IT 专业人员可以熟悉该技术，并在他们自己的公司中证明其价值。

### 5) VMware vSphere Hypervisor 可以无缝地升级到更高级的 vSphere 版本。

只需将该免费许可证升级到所需的升级版 vSphere 许可证，即可利用高级 vSphere 功能，包括集中管理、虚拟机实时迁移、自动负载平衡、业务连续性、电源管理，以及针对虚拟机的备份和恢复功能。

简单来来说即VMware vSphere Hypervisor是vmware公司的一种免费产品，它可以升级到收费版本的VMware vsphere，VMware vsphere支持更多的功能。

可以使用评估模式来浏览 ESXi 主机的全套功能。评估模式提供了相当于 vSphere Enterprise Plus 许可证的功能集。在评估模式到期之前，必须向主机分配支持正在使用的所有功能的许可证。

例如，在评估模式下，可以使用 vSphere vMotion 技术、vSphere HA 功能、vSphere DRS 功能以及其他功能。如果要继续使用这些功能，必须分配支持它们的许可证。(tmtony)

ESXi 主机的安装版本始终以评估模式安装。ESXi Embedded 由硬件供应商预安装在内部存储设备上。它可能处于评估模式或已预授权。

评估期为 60 天，从打开 ESXi 主机时开始计算。在 60 天评估期中的任意时刻，均可从许可模式转换为评估模式。评估期剩余时间等于评估期时间减去已用时间。

例如，假设您使用了处于评估模式的 ESXi 主机 20 天，然后将 vSphere Standard Edition 许可证密钥分配给了该主机。如果将主机设置回评估模式，则可以在评估期剩余的 40 天内浏览主机的全套功能。

对于 ESXi 主机，许可证或评估期到期会导致主机与 vCenter Server 的连接断开。所有已打开电源的虚拟机将继续工作，但您无法打开任何曾关闭电源的虚拟机电源。无法更改已在使用中的功能的当前配置。无法使用在许可证过期之前一直未使用的功能。

## 七、vSphere的组成部分：

### 1、VMware ESXi:

基于linux内核的基础虚拟系统，主要使用在物理硬件上，特别是大型服务器，可以更有效利用硬件资源。在它的基础上，可以布置各种虚拟机操作系统，包括windows,linux等。

### 2、VMware vCenter Server：

有linux与windows版。主要是对ESXI物理主机进行管理的一个系统。配合适当的数据库系统，特别是在esxi主机集群中，可以通过一套或者两套vcenter server进行方便快捷的统一管理。包括管理硬件，物理资源，虚拟机操作系统。基操作主要是基于WEB页面的。当esxi服务器比较少时，vcenter可以不装。数量大时，建议一定安装，方便 管理。

### 3、VMware vSphere Client:

主要是基于windows系统的纯客户端管理工具软件，比较小，可以直接连接esxi主机或者vcenter server主机。在上面操作与管理物理主机和虚拟机操作系统。可以没有vcenter server，但这个client一定要有，才方便管理。

### 4、付费情况：

client是免费的。vcenter server以及esxi一般都是按物理主机上的CPU数量来计费的。具体费用建议上vmare官网去看看，上面有详细价格介绍。

### 5、小结：

vSphere实现计算虚拟化，由多个组件组成，ESXi只是其中一个；ESXi可直接在物理主机上安装，实现将物理资源池化，将单一专用物理资源变为共享资源。其中vSphere除ESXi之外，还包括vCenter Server，用于对多个物理服务器资源池进行管理，还集成其他多种功能，实现单一界面的统一管理；vSphere client/vSphere web client是vCenter Server与多个主机环境间的接口，以控制台方式访问虚拟机；vRealize log Insight提供管理日志。

**一句话总结就是：ESXi只是vSphere的一部分**



## 八、网上其它相关资料：

1、以前叫VMware vsphere，分ESX、ESXi，3.5以前叫另外一个名字，这个是4.0/4.1的叫法

2、现在统统叫VMware vsphere Hypervisor，也就是说取消了ESX,因为ESX的补丁太多，后来索性取消了ESX多出来的console。

3、换句话讲，现在的安装介质都一样，用序列号区分功能（有免费的序列号，但是功能最少）

4、workstation是个人版（收费） VM server是服务器版（免费、但属于windows下面的软件）

5、view是桌面虚拟化

6、thinapp是软件打包

7、大体上剩下的全部依附于其上，什么vCenter、VSA、VDR、vAPP等等

其它：

1、VMware vSphere Hypervisor（esxi）是免费

2、可免费下载、安装、激活全部功能；

3、全功能可免费试用61天

4、到期后如不重新激活授权，部分功能将被屏蔽无法使用，基本功能不受影响，用户可自行评估觉得是否购买。

你好，vSphere Hypervisor ESXi 是免费下载、安装和使用的。初次安装使用的时候会有60天的试用期，试用期间拥有Enterprise Plus级别的全功能license。60天过期后没有申请付费license的ESXi，高级功能（例如HA、vMotion等功能）将不能使用，基本功能仍然免费，在ESXi上创建的虚拟机可以继续运行。

重新安装ESXi可以刷新试用时间，需要提前备份好你的虚拟机以便重装后导入

vsphere不是免费的，官网上面的是试用版，可以有60天的试用期。

到期后就不能输入序列号，输入序列号的框框就变成「Never」。


**VMware vSphere Hypervisor**是免费版虚拟化管理程序, 只需添加一个许可证文件可无缝升级到 VMware vSphere 版本.
升级可以启用集中式管理、虚拟机实时迁移、自动负载平衡、业务连续性、电源管理以及针对虚拟机的备份和恢复功能，从而提高服务级别和运营效率。升级到付费套件或版本的原因之一在于，您可以利用名为 VMware vCenter Server 的 vSphere 管理服务器来实现集中式的管理。

**vSphere Hypervisor ESXi** 是免费下载、安装和使用的。初次安装使用的时候会有60天的试用期，试用期间拥有Enterprise Plus级别的全功能license。60天过期后没有申请付费license的ESXi，高级功能（例如HA、vMotion等功能）将不能使用，基本功能仍然免费，在ESXi上创建的虚拟机可以继续运行(小辣椒高效Office)。
重新安装ESXi可以刷新试用时间，需要提前备份好你的虚拟机以便重装后导入。

**VMware vSphere Hypervisor** 是以前的 VMware ESXi Single Server 或免费的 ESXi（通常简称为“VMware ESXi”）的新名称。VMware vSphere Hypervisor 是 vSphere 产品线的免费版本。为其授予的许可仅发挥 vSphere 的虚拟化管理程序功能，但它也可无缝地升级到更高级的 VMware vSphere 版本。VMware vSphere 以多种版本提供，其中包括专门为小型企业设计的若干选项。

**VMware vCenter Server**

VMware vCenter Server 为数据中心提供一个单一控制点。它提供基本的数据

中心服务，如访问控制、性能监控和配置功能。

## 九、更官方的解释：

VMware vSphere企业增强版与VMware免费版和基本功能版的对比（摘自正睿科技）

**简述：**很多用户对VMware虚拟化已经熟悉，它不仅能为企业节省IT成本，同时还可以满足备份、多主机管理及虚拟机可用性等应用。在这种情况下，还有企业仍在使用VMware免费版（试用或放弃更高更加可靠的企业增强版）现在就来分享VMware全功能的vSphere企业增强版与VMware免费版到底有哪些优势和区别。
**一、各种版本包含的功能对比**
**1、特性对比**
a、从免费、包含基本功能的vSphere hypervisor到VMware全功能的vSphere企业增强版，全都运行在相同的ESXi Type-1 hypervisor之上。
b、企业版在备份、多主机管理以及虚拟机具备可用性与灵活性，使用vSphere将带来更多的好处。
**2、VMware vSphere备份功能凸显**
a、在VMware vSphere的付费版本中，允许其他应用程序通过API与vSphere进行通信并管理vSphere。其中包括了备份软件(小辣椒高效Office)。
b、使用免费的vSphere Hypervisor，备份时只能把虚拟机当作物理计算机对待。你需要在每个操作系统中安装代理并使用一个完全独立的备份服务器执行备份任务。
c、完成vSphere备份有几种选择，但是这几种选择（包括VMware提供的）都需要购买能够与之通信的hypervisor付费版本。vSphere Essential套件是需要付费购买的vSphere入门级产品，它降低了备份的复杂性，减少了备份的成本。不需要手动干预就能够执行备份，将你从IT运营中解脱出来。
**注：**备份很重要，数据至少要存放在两个地方级以上。没有数据备份的公司就是在等待灾难发生。
**3、具备高可用性，高优先级**
a、虚拟化是将多台服务器整合到一个系统中。企业就可以充分利用他们已经采购的这些服务器。从而能够充分利用物理服务器，减少资源浪费。
b、很多企业将整个工作负载迁移到廉价的双路服务器上，因为可以空闲很多空间。当然考虑到很多企业业务都迁移到公有云，这种选择也无可厚非。但是，如考虑到硬件系统可能会发生故障，所以不建议将所有的业务都迁移到一台服务器上。
c、VMware vSphere Essential Plus工具包中包含了VMware高可用性特性，通过将虚拟机从发生故障的主机自动迁移出来，并在正常运转的主机上自动重启，VMware高可用性实现了对服务器故障的自动化处理。而在 vSphere Hypervisor以及vSphere Essential环境中，IT管理员必须手动识别硬件问题并手动重启虚拟机。
d、不难核算出，不管是宕机时间为几分钟或是几小时，手动解决问题的成本肯定要远超过采购vSphere Essentials Plus及更高版本的费用。
**4、可以管理多台主机，更安全**
a、vSphere Essential工具包提供了足够的软件以及许可，能够管理多达3台服务器。中小企业至少会运营两台虚拟机。（如一台服务器发生硬件故障，其他服务器将接管业务，能够保证业务的连续性。）
b、VMware vSphere Essential没有考虑故障自动切换，鉴于很多企业认为不需要采购vSphere Essential Plus工具包，因为在紧急情况下工作负载允许出现较短的停机时间。对这些企业来说，VMware vSphere Essential是正确的选择，它能够轻松管理所有的虚拟主机，访问未加锁的API，当然价格更容易接受。
c、采购VMware vSphere Essential产品价格大约只是Window Server标准版拷贝成本的50%。
**5、使用vMotion保持虚拟机的可移动性**
a、在vSphere Essentials Plus及更高的版本中提供了VMware vMotion功能。管理员使用vMotion能够在物理主机之间完成虚拟机的在线迁移。免费版不能实现。
b、虚拟机可能相当大，即使在小企业中大小为50G，100G甚至是200G的虚拟机也是非常常见的。通过1Gb的网络迁移虚拟机花费的时间相当长，尤其是网络繁忙时更是如此。小企业通常不会采购昂贵的集中存储，虚拟机通常是被存储在虚拟主机中的。关闭虚拟机，将其从中央服务器上下载下来并重新上传到一台新服务器上，这一过程会产生大量的宕机时间。而vMotion实现了该过程的自动化。
c、更为重要的是，即使是在更为糟糕的虚拟机迁移场景下?虚拟机必须停机迁移?vMotion仍旧能够将其从一台主机直接迁移至另一台主机。这大大减少了使用中间服务器所带来的传输时间以及对网络的占用。
d、大多数计划使用vMotion的小企业选择了vSphere Essentials Plus，使用vSphere Storage Appliance将虚拟主机上的本地存储转换为集中存储。采用合适的配置，vSphere Essentials 能够完成虚拟机在主机之间的在线迁移。
e、如企业要频繁的升级系统，使用vMotion的相应功能在这将更具备价值因为可以更有效的减少宕机的可能性。
**二、对比总结**
通过对比发现，VMware vSphere备份、高可用性、vMotion及集中管理等功能特性带来的价值将高于使用免费的vSphere所带来的成本节省。

纯自己备忘笔记，不知道有否理解错，如有解释错误，高手请在评论区指正，谢谢



**以上内容如果对您有些帮助，请帮忙点个赞**

**为防走丢，也请收藏及关注我们** 

**[@小辣椒高效Office](https://www.zhihu.com/people/61181a729ad96882fd24553e3f54ac6f)**



发布于 2022-01-29 10:41

[vSphere](https://www.zhihu.com/topic/19596090)

[VMware（威睿）](https://www.zhihu.com/topic/19575633)

[esxi](https://www.zhihu.com/topic/19646103)