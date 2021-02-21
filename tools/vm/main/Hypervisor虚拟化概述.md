# Hypervisor虚拟化概述

虚拟化测试已有5年了，在VmWare虚拟化平台(Windows和Linux操作系统)和OpenStack 虚拟化平台(RedHat，Linux操作系统)上都部署过虚拟机。相信你也在Linux服务器和Window上安装过操作系统。**然而在虚拟化平台和物理服务器上安装操作系统或应用有什么不同？**

![img](https://upload-images.jianshu.io/upload_images/7749898-f86cb43142ca01f5.jpeg?imageMogr2/auto-orient/strip|imageView2/2/w/1147/format/webp)

虚拟化前后的运行情况对比

物理服务器只能部署单操作系统(或者说是只能运行单操作系统，[笔记本上同时安装过Windows和Linux操作系统](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fqingfenggege%2Farticle%2Fdetails%2F80392067)，只不过二者只能运行一个)，应用程序部署在操作系统中，通过操作系统来进行硬件资源的调用。

在虚拟化环境下，物理服务器的CPU、内存、硬盘和网卡等硬件资源被虚拟化并受Hypervisor的调度，多个操作系统在Hypervisor的协调下可以共享这些虚拟化后的硬件资源，同时每个操作系统又可以保存彼此的独立性。

根据Hypervisor所处层次的不同和Guest OS对硬件资源的不同使用方式，**Hypervisor虚拟化被分为两种类型：Bare-metal虚拟化方式（“裸机”虚拟化）和Host OS虚拟化方式(基于操作系统的虚拟化，宿主型虚拟化)**。

![img](https://upload-images.jianshu.io/upload_images/7749898-e64e912ed5d4aa1e.jpeg?imageMogr2/auto-orient/strip|imageView2/2/w/700/format/webp)

Host OS与Bare-metal类型的Hypervisor

**Host OS类型**将Hypervisor虚拟化层安装在传统的操作系统中，虚拟化软件以应用程序进程形式运行在Windows和Linux等主机操作系统中。典型的宿主型Hypervisor有VMware Workstation和VirtualBox。在Hypervisor虚拟化环境下，部署在物理服务器上的系统称为Host OS，而部署在Hypervisor上的虚拟机操作系统称为Guest OS。Hypervisor的安装：在物理服务器上安装Linux操作系统然后在操作系统上安装Hypervisor，然后部署虚拟机(Guest OS)后通过Hypervisor来共享资源。

**Bare-metal类型**的Hypervisor虚拟化环境中无须完整的Host OS，直接将Hypervisor部署在裸机上并将裸机服务器的硬件资源虚拟化，也可以将Hypervisor理解为仅对硬件资源进行虚拟和调度的薄操作系统，其并不提供常规Host OS的功能，常见的Bare-metal类型(裸机)Hypervisor有IBM的PowerVM、VMware的ESX Sevrer、Citrix的XenServer、Microsoft的Hyper-V以及开源的KVM等虚拟化软件。

虚拟化技术又分为全虚拟化（Full Virtualization，FV）、准虚拟化（Para Virtualization，PV）和主机操作系统虚拟化（Host OS Virtualization），其中PV和FV基于Bare-metal类型Hypervisor的虚拟化技术，而主机操作系统虚拟化基于Host OS类型Hypervisor的虚拟化技术。

![img](https://upload-images.jianshu.io/upload_images/7749898-77d1c409641f872f.jpeg?imageMogr2/auto-orient/strip|imageView2/2/w/836/format/webp)

X86权限层级架构

**虚拟化技术中一个关键性的难题便是物理CPU的虚拟化**。在X86架构的服务器体系中，存在一种称为保护环(Protection Ring)或层级保护域（Hierarchical Protected Domain）的CPU指令特权架构，如上图所示。运行在X86架构上的操作系统（Operating System，OS）被设计为具有直接访问和控制硬件资源的权限。X86架构使用0、1、2和3四个权限Ring来控制管理硬件访问权限，其中用户应用程序运行在Ring3权限中。OS因为需要直接访问物理硬件资源而在Ring0中执行。X86架构下的这种层级授权机制也会被应用到虚拟机中。在虚拟环境中，Guest OS也需要具有Ring0权限才能访问硬件资源，但在实际中Guest OS却不能像传统Host OS一样直接获取Ring0权限，而是需要通过一系列的复杂方法才能获取Ring0权限，这些复杂的方法需要通过Hypervisor来完成，正是CPU指令赋权方法的复杂性，最终使得X86架构服务器底层虚拟化变得极为复杂。

**CPU虚拟化的关键就在于如何对Guest OS的请求指令赋予不同层级的权限**，而全虚拟化和准虚拟化也正是基于这种对Guest OS指令不同的赋权方法来进行划分的。

1) 在全虚拟化技术中，Guest OS之间通过Hypervisor来分享底层硬件资源。全虚拟化中，Hypervisor具备Ring0权限，Guest OS具备Ring1权限，如下图所示。

![img](https://upload-images.jianshu.io/upload_images/7749898-7b20b5c7003bf44e.jpeg?imageMogr2/auto-orient/strip|imageView2/2/w/831/format/webp)

全虚拟化

**全虚拟化中的Guest OS机器指令集被Hypervisor通过二进制转换方式转换为主机（Host OS）机器语言。**当Guest OS(虚拟机)发出诸如访问设备驱动之类的授权指令请求时，Hypervisor便会发起对设备驱动访问的跟踪，由于Guest OS与Host OS间的差异被Hypervisor的转换机制屏蔽，因此要成为Guest OS的操作系统通常无须人为修改定制便可直接运行在虚拟机中，而如Windows这类非开源的商业操作系统在全虚拟化方式下也能正常运行，但是由于Hypervisor对Guest OS指令集的转换，使得全虚拟化方式的性能在一定程度上受其影响。

![img](https://upload-images.jianshu.io/upload_images/7749898-1bf6c2877d0d1bf9.jpeg?imageMogr2/auto-orient/strip|imageView2/2/w/831/format/webp)

Intel的Intel-VT全虚拟化技术

为了改善全虚拟化中Hypervisor二进制指令集转换对Guest OS性能的影响，CPU芯片制造商，如Intel和AMD，也在不断改进CPU对虚拟化的支持，从而降低硬件层面的虚拟化负载。在Intel的Intel-VT虚拟化技术出现后，全虚拟化性能问题得到了极大改善，并能与准虚拟化技术相媲美（准虚拟化技术通常被认为具有更高的性能）。上图所示基于Intel-VT虚拟化技术的全虚拟化，注意Hypervisor处于Ring-1层级，而Guest OS处于Ring0层级。

**2) 在准虚拟化中，当Guest OS执行授权指令时，指令会被一种称为hypercall的系统API调用传递到Hypervisor(而不是像全虚拟化一样先转换为Host OS的指令集)**， Hypervisor接收到来自Guest OS的hypercall之后，直接访问硬件资源并将结果返回给Guest OS，下图为XenServer的准虚拟化。

![img](https://upload-images.jianshu.io/upload_images/7749898-6d0ac0341a78fb27.jpeg?imageMogr2/auto-orient/strip|imageView2/2/w/1029/format/webp)

XenServer准虚拟化

在准虚拟化中，由于Guest OS可以直接控制访问CPU和内存等硬件资源，而不需经过中间的转换机制，因此准虚拟化在性能上要优于全虚拟化。但是，准虚拟化有个不切合实际的缺陷，需要更改客户机操作系统以使其能够使用hypercall这个系统API。因此，与全虚拟化不同，准虚拟化下Guest OS仅支持部分操作系统，像Windows这类商业非开源的操作系统将不能在准虚拟化的客户机上运行。为了支持准虚拟化，即使是Linux这类开源系统，也需要修改接近20%的内核代码。总体来说，准虚拟化不仅支持的Guest OS有限，而且对Guest OS进行内核级别的修改也需要专业的技术能力和大量的修改工作。

VMware的早期虚拟化软件采用的是全虚拟化方式，不过在VMware漫长的商业进化过程中，准虚拟化方式也慢慢被VMwrae支持，其原理图如下。

![img](https://upload-images.jianshu.io/upload_images/7749898-041a38b0261fbc8f.jpeg?imageMogr2/auto-orient/strip|imageView2/2/w/830/format/webp)

VmWare准虚拟化

**3) 主机操作系统（Host OS）虚拟化是操作系统本身提供Hypervisor功能的虚拟化方式**，原理图如下。

![img](https://upload-images.jianshu.io/upload_images/7749898-cecfb8fb8901826e.jpeg?imageMogr2/auto-orient/strip|imageView2/2/w/999/format/webp)

Host OS虚拟化

在Host OS虚拟化中，由于虚拟机实例之间不成熟的资源管理，以及性能和安全方面的问题，几乎很少使用主机操作系统虚拟化方式，例如，当运行Hypervisor的Host OS出现安全问题时，全部Guest OS都会受到影响。如果想要在个人PC上运行多个操作系统，使用Host OS的虚拟化方式是没有任何问题的，其中最为流行的当属VMware Workstation系列产品。

**4) 基于容器的虚拟化技术并不依赖传统的Hypervisor虚拟化引擎**，而是在Host OS中配置虚拟服务器环境（Virtual Server Environment，VSE），即无须在Host OS中配置Hypervisor，并且在容器虚拟化中，仅有Guest OS被仿真模拟，原理图如下。

![img](https://upload-images.jianshu.io/upload_images/7749898-ddd2073d608f1cfb.jpeg?imageMogr2/auto-orient/strip|imageView2/2/w/1000/format/webp)

容器虚拟化

由于容器虚拟化技术抛弃了较为复杂的，针对全部硬件资源进行虚拟化的Hypervisor，且是仅针对Guest OS的虚拟化，因此基于容器的虚拟化是一种“更轻”的虚拟化方式，也具有更好的性能。但是，这种基于容器的虚拟化技术在过去很少用于服务器虚拟化中，因为和Host OS虚拟化一样，在过去，容器虚拟化技术对虚拟机实例之间的资源和安全管理都不如Hypervisor虚拟化。

随着Docker等容器技术的发展，新的容器资源管理技术也不断涌现和成熟，如Mesos、CoreOS、Kubernetes、Swarm和Rocket等容器生态圈技术的发展，使得容器虚拟化技术在发展势头上有赶超OpenStack等主流开源云计算项目的趋势。

笔记整理来自山金孝的《OpenStack高可用集群（上册）：原理与架构》8.4章节，如有侵权请通知删除。