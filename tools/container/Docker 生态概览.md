# [Docker 生态概览](https://www.cnblogs.com/sparkdev/p/8998546.html)

Docker 和容器技术的发展可谓是日新月异，本文试图以全局的视角来梳理一下 docker 目前的生态圈。既然是概览，所以不会涉及具体的技术细节。

Docker 自从发布以来发生了很多的变化，并且有些方面的变化还非常大。对于技术爱好者来说，我们喜欢酷毙新的功能，喜欢旧功能的改善。但对于生产环境中的使用者来说，其实不太喜欢这种频繁的变化！不管怎样，我们都有必要理清 docker 生态系统中的众多概念及它们之间的关系，以及 docker 自诞生至今(2018 年)的里程碑性事件。

# 百花齐放的容器技术

虽然 docker 把容器技术推向了巅峰，但容器技术却不是从 docker 诞生的。实际上，容器技术连新技术都算不上，因为它的诞生和使用确实有些年头了。下面的一串名称肯能有的你都没有听说过，但它们的确都是容器技术的应用：

- Chroot Jail
- FreeBSD Jails
- Linux VServer
- Solaris Containers
- OpenVZ
- Process Containers
- LXC
- Warden
- LMCTFY
- Docker
- RKT

**Chroot Jail**
就是我们常见的 chroot 命令的用法。它在 1979 年的时候就出现了，被认为是最早的容器化技术之一。它可以把一个进程的文件系统隔离起来。

**The FreeBSD Jail**
Freebsd Jail 实现了操作系统级别的虚拟化，它是操作系统级别虚拟化技术的先驱之一。

**Linux VServer**
使用添加到 Linux 内核的系统级别的虚拟化功能实现的专用虚拟服务器。

**Solaris Containers**
它也是操作系统级别的虚拟化技术，专为 X86 和 SPARC 系统设计。Solaris 容器是系统资源控制和通过 "区域" 提供边界隔离的组合。

**OpenVZ**
OpenVZ 是一种 Linux 中操作系统级别的虚拟化技术。 它允许创建多个安全隔离的 Linux 容器，即 VPS。

**Process Containers**
Process 容器由 Google 的工程师开发，一般被称为 cgroups。

**LXC**
LXC 又叫 Linux 容器，这也是一种操作系统级别的虚拟化技术，允许使用单个 Linux 内核在宿主机上运行多个独立的系统。

**Warden**
在最初阶段，Warden 使用 LXC 作为容器运行时。 如今已被 CloudFoundy 取代。

**LMCTFY**
LMCTY 是 Let me contain that for you 的缩写。它是 Google 的容器技术栈的开源版本。
Google 的工程师一直在与 docker 的 libertainer 团队合作，并将 libertainer 的核心概念进行抽象并移植到此项目中。该项目的进展不明，估计会被 libcontainer 取代。

**Docker**
Docker 是一个可以将应用程序及其依赖打包到几乎可以在任何服务器上运行的容器的工具。

**RKT**
RKT 是 Rocket 的缩写，它是一个专注于安全和开放标准的应用程序容器引擎。

正如我们所看到的，docker 并不是第一个容器化技术，但它的确是最知名的一个。Docker 诞生于 2013 年，并获得了快速的发展，下图展示了当前 docker 平台中的组成部分(此图来自互联网)：

![img](https://images2018.cnblogs.com/blog/952033/201805/952033-20180506161404132-2044228888.png)

Docker 立于系统基础架构之上并为应用程序提供支撑。它由称为 containerd 的行业标准容器运行时组件，称为 docker swarm 的本地编排工具，以及开源的 docker community 版本和提供商业管理服务的 docker enterprise 版组成。

# 与 docker 相关的重要概念

**Docker & LXC**
Docker 的第一个执行环境是 LXC，但从版本 0.9 开始 LXC 被 libcontainer 取代。

**Docker & libcontainer**
Libcontainer 为 docker 封装了 Linux 提供的基础功能，如 cgroups，namespaces，netlink 和 netfilter 等，如下图所示(此图来自互联网)：

![img](https://images2018.cnblogs.com/blog/952033/201805/952033-20180506161604802-519268400.jpg)

**2015 - Docker ＆ runC**
2015 年，docker 发布了 runC，一个轻量级的跨平台的容器运行时。 这基本上就是一个命令行小工具，可以直接利用 libcontainer 运行容器，而无需通过 docker engine。runC 的目标是使标准容器在任何地方都可用。

**Docker & The Open Containers Initiative(OCI)**
OCI 是一个轻量级的开放式管理架构，由 docker，CoreOS 和容器行业的其他领导厂商于 2015 年建立。它维护一些项目，如 runC ，还有容器运行时规范和镜像规范。OCI 的目的是围绕容器行业制定标准，比如使用 docker 创建的容器可以在任何其他容器引擎上运行。

**2016 - Docker & containerd**
2016年，Docker 分拆了 containerd，并将其捐赠给了社区。将这个组件分解为一个单独的项目，使得 docker 将容器的管理功能移出 docker 的核心引擎并移入一个单独的守护进程(即 containerd)。

**Docker Components**
分拆完 containerd 后，docker 各组件的关系如下图所示(此图来自互联网)：

![img](https://images2018.cnblogs.com/blog/952033/201805/952033-20180506161733019-302685852.png)

至此，docker 从一个单一的软件演变成了一套相互独立的组件和项目。

**Docker 如何运行一个容器？**

1. Docker 引擎创建容器映像
2. 将容器映像传递给 containerd
3. containerd 调用 containerd-shim
4. containerd-shim 使用 runC 来运行容器
5. containerd-shim 允许运行时(本例中为 runC)在启动容器后退出

该模型带来的最大好处是在升级 docker 引擎时不会中断容器的运行。

**2017 - 容器成为主流**
2017 年是容器成为主流技术的一年，这就是为什么 docker 在 Linux 之外支持众多平台的原因（Docker for Mac，Docker for Windows，Docker for AWS，GCP 等）。

当容器技术被大众接受后，Docker 公司意识到需要新的生产模型，这就是为什么它开始 Moby 项目。

# Moby Project

Moby 项目开启了实现协作和生产的新篇章。它是一个开源项目，旨在推进软件的容器化。Moby 项目提供了数十个乐高积木一样的组件以及将它们组装成定制的基于容器的系统的框架。

Docker 生产模型像任何其他常见的单个开源项目一样开始(此图来自互联网)：

![img](https://images2018.cnblogs.com/blog/952033/201805/952033-20180506161953590-1198283921.png)

进而将单个项目拆分为不同的开放组件(此图来自互联网)：

![img](https://images2018.cnblogs.com/blog/952033/201805/952033-20180506162030145-1664272291.png)

然后进化到可以共享这些组件以及组件集合(assembly)的模型(此图来自互联网)：

![img](https://images2018.cnblogs.com/blog/952033/201805/952033-20180506162057003-1056638649.png)

最终达到能够提供更多关于组件和通用组件集合的协作的模型(此图来自互联网)：

![img](https://images2018.cnblogs.com/blog/952033/201805/952033-20180506162131635-436116215.png)

下面我们就来介绍一些 Moby 项目中的组件。

**Containerd**
Containerd 是 docker 基于行业标准创建的核心容器运行时。它可以用作 Linux 和 Windows 的守护进程，并管理整个容器生命周期。

**Linuxkit**
Linuxkit 是 Moby 项目中的另一个组件，它是为容器构建安全、跨平台、精简系统的工具。目前已经支持的本地 hypervisor 有 hyper-v 和 vmware。支持的云平台有 AWS、Azure 等。

**Infrakit**
Infrakit 也是 Moby 项目的一部分。它是创建和管理声明式、不可变和自我修复基础架构的工具包。
Infrakit 旨在自动化基础架构的设置和管理，以支持分布式系统和更高级别的容器编排系统。Infrakit 对于像 Docker Swarm 和 Kubernetes 这样的编排工具或跨越 AWS 等公共云创建自动缩放群集的用例很有用。

**Libnetwork**
Libnetwork 是用 Go 语言实现的容器网络管理项目。它的目标是定义一个容器网络模型(CNM)，
并为应用程序提供一致的编程接口以及网络抽象。这样就可以满足容器网络的 "可组合" 需求。

**Docker & Docker Swarm**
Docker Swarm 是一个在 docker 引擎中构建的编排工具。从 docker 1.12 开始它就作为一个独立的工具被原生包含在 docker engine 中。我们可以使用 docker cli 通过 docker swarm 创建群集，并部署和管理应用程序和服务。下图描述了 docker swarm 在 docker 体系中的作用(此图来自互联网)：

![img](https://images2018.cnblogs.com/blog/952033/201805/952033-20180506162317442-1116217226.png)

**Docker＆Kubernetes**
在 docker swarm 与 kubernetes 的竞争中，显然是 kubernetes 占据了优势。所以 docker 紧急掉头，开始原生的支持与 kubernetes 的集成。这可是 2017 年容器界的一大新闻啊！至此，docker 用户和开发人员可以自由地选择使用 kubernetes 或是 swarm 执行容器的编排工作。我们可以认为 docker 与 kubernetes 联姻了(此图来自互联网)：

![img](https://images2018.cnblogs.com/blog/952033/201805/952033-20180506162351968-1460613952.png)

新的支持 kubernetes 集成的 docker 版本将允许用户把他们的 docker compose 应用程序部署为 kubernetes 本地 pod 和服务。Kubernetes 是一款非常强大且逐渐被大众认可的本地编排工具(此图来自互联网)：

![img](https://images2018.cnblogs.com/blog/952033/201805/952033-20180506162422186-2036947839.png)

希望大家没有被文中众多的名称和概念搞糊涂，让我们以下图来结束本文，它展示了从 2013 年到 2017 年从 docker hub 拉取镜像次数的趋势：

![img](https://images2018.cnblogs.com/blog/952033/201805/952033-20180506162456326-1601155581.png)

 

**参考：**
[An Overall View On Docker Ecosystem — Containers, Moby, Swarm, Linuxkit, containerd, Kubernetes](https://medium.com/devopslinks/an-overall-view-on-docker-ecosystem-containers-moby-swarm-linuxkit-containerd-kubernetes-5e4972a6a1e8)

作者：[sparkdev](http://www.cnblogs.com/sparkdev/)

出处：http://www.cnblogs.com/sparkdev/

本文版权归作者和博客园共有，欢迎转载，但未经作者同意必须保留此段声明，且在文章页面明显位置给出原文连接，否则保留追究法律责任的权利。

分类: [Docker](https://www.cnblogs.com/sparkdev/category/927855.html)

标签: [docker](https://www.cnblogs.com/sparkdev/tag/docker/)