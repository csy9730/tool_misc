# LXC－Linux Container 简介                            

​                                【编者的话】这是关于Linux容器介绍的第二篇，[上一篇文章](http://dockone.io/article/8433)深入介绍了内核的控制组（cgroup），这个功能让你可以隔离，限制以及监控选择的用户空间的应用，在这篇文章中，将会更深入的介绍进程隔离，即通过LXC（Linux容器，Linux Container）来进行进程隔离。

容器相当于你运行了一个接近于裸机的虚拟机。这项技术始于2008年，LXC的大部分功能来自于Solaris容器（又叫做Solaries  Zones）以及之前的FreeBSD jails技术。  LXC并不是创建一个成熟的虚拟机，而是创建了一个拥有自己进程程和网络空间的虚拟环境，使用命名空间来强制进程隔离并利用内核的控制组（cgroups）功能，该功能可以限制，计算和隔离一个或多个进程的CPU，内存，磁盘I / O和网络使用情况。 您可以将这种用户空间框架想像成是`chroot`的高级形式。



> `chroot` 是一个改变当前运行进程以及其子进程的根目录的操作。一个运行在这种环境的程序无法访问根目录外的文件和命令。

注意：LXC使用命名空间来强制进程隔离，同时利用内核的控制组来计算以及限制一个或多个进程的CPU，内存，磁盘I / O和网络使用。

但容器究竟是什么？简短的答案是容器将软件应用程序与操作系统分离，为用户提供干净且最小的Linux环境，与此同时在一个或多个隔离的“容器”中运行其他所有内容。容器的目的是启动一组有限数量的应用程序或服务（通常称为微服务），并使它们在独立的沙盒环境中运行。

​	[![1.png](http://dockone.io/uploads/article/20190706/4db26d0e1162aa7a8f61fd387d465f26.png)](http://dockone.io/uploads/article/20190706/4db26d0e1162aa7a8f61fd387d465f26.png)


*图1 对比在传统环境以及容器环境运行的应用*

这种隔离可防止在给定容器内运行的进程监视或影响在另一个容器中运行的进程。此外，这些集装箱化服务不会影响或干扰主机。能够将分散在多个物理服务器上的许多服务合并为一个的想法是数据中心选择采用该技术的众多原因之一。

容器有以下几个特点：

- 安全性：容器里可以运行网络服务，这可以限制安全漏洞或违规行为造成的损害。那些成功利用那个容器的一个或多个应用的安全漏洞的入侵者将会被限制在只能在那个容器中做一些操作。
- 隔离性：容器允许在同一物理机器上部署一个或多个应用程序，即使这些应用程序必须在不同的域下运行，每个域都需要独占访问其各自的资源。例如，通过将每个容器关联的不同IP地址，在不同容器中运行的多个应用程序可以绑定到同一物理网络接口。
- 虚拟化和透明性：容器为系统提供虚拟化环境，这个环境可以隐藏或限制系统底层的物理设备或系统配置的可见性。容器背后的一般原则是避免更改运行应用程序的环境，但解决安全性或隔离问题除外。



### 使用LXC的工具

对于大多数现代Linux发行版，内核都启用了控制组，但您很可能仍需要安装LXC工具。

如果您使用的是Red Hat或CentOS，则需要先安装EPEL仓库。对于其他发行版，例如Ubuntu或Debian，只需键入：

```
$ sudo apt-get install lxc
```


 现在，在开始使用这些工具之前，您需要配置您的环境。在此之前，您需要验证当前用户是否同时在/ etc / subuid和/ etc / subgid中定义了uid和gid：

```
$ cat /etc/subuid
petros:100000:65536
$ cat /etc/subgid
petros:100000:65536
```


 如果`~/.config/lxc directory`不存在，则创建该目录，并且把配置文件`/etc/lxc/default.conf`复制到`~/.config/lxc/default.conf.`，将以下两行添加到文件末尾：

```
lxc.id_map = u 0 100000 65536
lxc.id_map = g 0 100000 65536
```


 结果如下：

```
$ cat ~/.config/lxc/default.conf
lxc.network.type = veth
lxc.network.link = lxcbr0
lxc.network.flags = up
lxc.network.hwaddr = 00:16:3e:xx:xx:xx
lxc.id_map = u 0 100000 65536
lxc.id_map = g 0 100000 65536
```


 将以下命令添加到`/etc/lxc/lxc-usernet`文件末尾（把第一列换成你的username）：

```
petros veth lxcbr0 10
```


 最快使这些配置生效的方法是重启节点或者将用户登出再登入。

重新登录后，请验证当前是否已加载veth网络驱动程序：

```
$ lsmod|grep veth
veth                   16384  0
```


 如果没有，请输入：

```
$ sudo modprobe veth
```


 现在您可以使用LXC工具集来下载，运行，管理Linux容器。

接下来，下载容器镜像并将其命名为“example-container”。当您键入以下命令时，您将看到一长串许多Linux发行版和版本支持的容器：

```
$ sudo lxc-create -t download -n example-container
```


 将会有三个弹出框让您分别选择发行版名称（distribution），版本号（release）以及架构（architecture）。请选择以下三个选项：

```
Distribution: ubuntu
Release: xenial
Architecture: amd64
```


 选择后点击`Enter`，rootfs将在本地下载并配置。出于安全原因，每个容器不附带OpenSSH服务器或用户帐户。同时也不会提供默认的root密码。要更改root密码并登录，必须在容器目录路径中运行lxc-attach或chroot（在启动之后）。

启动容器：

```
$ sudo lxc-start -n example-container -d
```


`-d`选项表示隐藏容器，它会在后台运行。如果您想要观察boot的过程，只需要将`-d`换成`-F`。那么它将在前台运行，登录框出现时结束。

你可能会遇到如下错误：

```
$ sudo lxc-start -n example-container -d
lxc-start: tools/lxc_start.c: main: 366 The container
failed to start.
lxc-start: tools/lxc_start.c: main: 368 To get more details,
run the container in foreground mode.
lxc-start: tools/lxc_start.c: main: 370 Additional information
can be obtained by setting the --logfile and --logpriority
options.
```


 如果你遇到了，您需要通过在前台运行lxc-start服务来调试它：

```
$ sudo lxc-start -n example-container -F
lxc-start: conf.c: instantiate_veth: 2685 failed to create veth
pair (vethQ4NS0B and vethJMHON2): Operation not supported
lxc-start: conf.c: lxc_create_network: 3029 failed to
create netdev
lxc-start: start.c: lxc_spawn: 1103 Failed to create
the network.
lxc-start: start.c: __lxc_start: 1358 Failed to spawn
container "example-container".
lxc-start: tools/lxc_start.c: main: 366 The container failed
to start.
lxc-start: tools/lxc_start.c: main: 370 Additional information
can be obtained by setting the --logfile and --logpriority
options.
```


 从以上示例，你可以看到模块`veth`没有被引入，在引入之后，将会解决这个问题。

之后，打开第二个terminal窗口，验证容器的状态。

```
$ sudo lxc-info -n example-container
Name:           example-container
State:          RUNNING
PID:            1356
IP:             10.0.3.28
CPU use:        0.29 seconds
BlkIO use:      16.80 MiB
Memory use:     29.02 MiB
KMem use:       0 bytes
Link:           vethPRK7YU
TX bytes:      1.34 KiB
RX bytes:      2.09 KiB
Total bytes:   3.43 KiB
```


 也可以通过另一种方式来查看所有安装的容器，运行命令：

```
$ sudo lxc-ls -f
NAME         STATE   AUTOSTART GROUPS IPV4      IPV6
example-container RUNNING 0         -      10.0.3.28 -
```


 但是问题是你仍然不能登录进去，你只需要直接attach到正在运行的容器，创建你的用户，使用`passwd`命令改变相关的密码。

```
$ sudo lxc-attach -n example-container
root@example-container:/#
root@example-container:/# useradd petros
root@example-container:/# passwd petros
Enter new UNIX password:
Retype new UNIX password:
passwd: password updated successfully
```


 更改密码后，您将能够从控制台直接登录到容器，而无需使用`lxc-attach`命令：

```
$ sudo lxc-console -n example-container
```


 如果要通过网络连接到此运行容器，请安装OpenSSH服务器：

```
root@example-container:/# apt-get install openssh-server
```


 抓取容器的本地IP地址：

```
root@example-container:/# ip addr show eth0|grep inet
inet 10.0.3.25/24 brd 10.0.3.255 scope global eth0
inet6 fe80::216:3eff:fed8:53b4/64 scope link
```


 然后在主机的新的控制台窗口中键入：

```
$ ssh 10.0.3.25
```


 瞧！您现在可以SSH到正在运行的容器并键入您的用户名和密码。

在主机系统上，而不是在容器内，可以观察在启动容器后启动和运行的LXC进程：

```
$ ps aux|grep lxc|grep -v grep
root       861  0.0  0.0 234772  1368 ?        Ssl  11:01
↪0:00 /usr/bin/lxcfs /var/lib/lxcfs/
lxc-dns+  1155  0.0  0.1  52868  2908 ?        S    11:01
↪0:00 dnsmasq -u lxc-dnsmasq --strict-order
↪--bind-interfaces --pid-file=/run/lxc/dnsmasq.pid
↪--listen-address 10.0.3.1 --dhcp-range 10.0.3.2,10.0.3.254
↪--dhcp-lease-max=253 --dhcp-no-override
↪--except-interface=lo --interface=lxcbr0
↪--dhcp-leasefile=/var/lib/misc/dnsmasq.lxcbr0.leases
↪--dhcp-authoritative
root      1196  0.0  0.1  54484  3928 ?        Ss   11:01
↪0:00 [lxc monitor] /var/lib/lxc example-container
root      1658  0.0  0.1  54780  3960 pts/1    S+   11:02
↪0:00 sudo lxc-attach -n example-container
root      1660  0.0  0.2  54464  4900 pts/1    S+   11:02
↪0:00 lxc-attach -n example-container
```


 要停止容器，请键入（在主机）：

```
$ sudo lxc-stop -n example-container
```


 停止后，验证容器的状态：

```
$ sudo lxc-ls -f
NAME         STATE   AUTOSTART GROUPS IPV4 IPV6
example-container STOPPED 0         -      -    -

$ sudo lxc-info -n example-container
Name:           example-container
State:          STOPPED
```


 要彻底销毁容器 - 即从主机system—type清除它：

```
$ sudo lxc-destroy -n example-container
Destroyed container example-container
```


 销毁后，可以验证是否已将其删除：

```
$ sudo lxc-info -n example-container
example-container doesn't exist

$ sudo lxc-ls -f
$
```


 注意：如果您尝试销毁正在运行的容器，该命令将失败并告知您容器仍在运行：

```
$ sudo lxc-destroy -n example-container
example-container is running
```


 在销毁容器前必须先停止它。

### 高级配置

有时，可能需要配置一个或多个容器来完成一个或多个任务。 LXC通过让管理员修改位于/var/lib/ lxc中的容器配置文件来简化这一过程：

```
$ sudo su
# cd /var/lib/lxc
# ls
example-container
```


 容器的父目录将包含至少两个文件：1）容器配置文件和2）容器的整个rootfs：

```
# cd example-container/
# ls
config  rootfs
```


 假设您想要在主机系统启动时自动启动名称为`example-container`的容器。那么您需要将以下行添加到容器的配置文件｀/ var / lib / lxc / example-container / config｀的尾部：

```
# Enable autostart
lxc.start.auto = 1
```


 重新启动容器或重新启动主机系统后，您应该看到如下内容：

```
$ sudo lxc-ls -f
NAME              STATE   AUTOSTART GROUPS IPV4      IPV6
example-container RUNNING 1         -      10.0.3.25 -
```


 注意 `AUTOSTART` 字段现在被设置为“1”。

如果在容器启动时，您希望容器绑定装载主机上的目录路径，请将以下行添加到同一文件的尾部：

```
# 将挂载系统路径绑定到本地路径
lxc.mount.entry = /mnt mnt none bind 0 0
```


 通过上面的示例，当容器重新启动时，您将看到容器本地的 / mnt目录可访问的主机/ mnt目录的内容。

### 特权与非特权容器

您经常会发现在与LXC相关的内容中讨论特权容器和非特权容器的概念。但它们究竟是什么呢？这个概念非常简单，并且LXC容器可以在任一配置下运行。

根据设计，无特权容器被认为比特权容器更安全，更保密。无特权容器运行时，容器的root UID映射到主机系统上的非root  UID。这使得攻击者即使破解了容器，也难以获得对底层主机的root权限。简而言之，如果攻击者设法通过已知的软件漏洞破坏了您的容器，他们会立即发现自己无法获取任何主机权限。

特权容器可能使系统暴露于此类攻击。这就是为什么我们最好在特权模式下运行尽量少的容器。确定需要特权访问的容器，并确保付出额外的努力来定期更新并以其他方式锁定它们。

### 然而，Docker又是什么呢？

我花了相当多的时间谈论Linux容器，但是Docker呢？它是生产中部署最多的容器解决方案。自首次推出以来，Docker已经风靡Linux计算世界。 Docker是一种Apache许可的开源容器化技术，旨在自动化在容器内创建和部署微服务这类重复性任务。  Docker将容器视为非常轻量级和模块化的虚拟机。最初，Docker是在LXC之上构建的，但它已经远离了这种依赖，从而带来了更好的开发人员和用户体验。与LXC非常相似，Docker继续使用内核`cgroup`子系统。该技术不仅仅是运行容器，还简化了创建容器，构建映像，共享构建的映像以及对其进行版本控制的过程。

Docker主要关注于：

- 可移植性：Docker提供基于镜像的部署模型。这种类型的可移植性允许更简单的方式在多个环境中共享应用程序或服务集合（以及它们的所有依赖）。
- 版本控制：单个Docker镜像由一系列组合层组成。每当镜像被更改时，都会创建一个新层。例如，每次用户指定命令（例如运行或复制）时，都会创建一个新层。 Docker将重用这些层用于新的容器构建。分层到Docker是它自己的版本控制方法。
- 回滚：再次，每个Docker镜像都有很多层。如果您不想使用当前运行的层，则可以回滚到以前的版本。这种敏捷性使软件开发人员可以更轻松地持续集成和部署他们的软件技术。
- 快速部署：配置新硬件通常需要数天时间。并且，安装和配置它的工作量和开销是非常繁重的。使用Docker，您可以在几秒钟将镜像启动并运行，相比于之前，节省了大量的时间。当你使用完一个容器时，你可以轻松地销毁它。


从本质上说，Docker和LXC都非常相似。它们都是用户空间和轻量级虚拟化平台，它们利用cgroup和命名空间来管理资源隔离。但是，两者之间也存在许多明显的差异。

#### 进程管理

Docker将容器限制为单个进程运行。如果您的应用程序包含X个并发进程，Docker将要求您运行X个容器，每个容器都有自己单独的进程。 LXC不是这样，LXC运行具有传统init进程的容器，反过来，可以在同一容器内托管多个进程。例如，如果要托管LAMP（Linux +  Apache + MySQL + PHP）服务器，每个应用程序的每个进程都需要跨越多个Docker容器。

#### 状态管理

Docker被设计为无状态，意味着它不支持持久存储。有很多方法可以解决这个问题，但同样，只有在进程需要时才需要它。创建Docker镜像时，它将包含只读层。这不会改变。在运行时，如果容器的进程对其内部状态进行任何更改，则将保持内部状态和镜像的当前状态之间的差异，直到对Docker镜像进行提交（创建新层）或直到容器被删除，差异也会消失。

#### 可移植性

在讨论Docker时，这个词往往被过度使用——因为它是Docker相对于LXC的最重要的优势。  Docker从应用程序中抽象出网络，存储和操作系统细节方面做得更好。这样就形成了一个真正独立于配置的应用程序，保证应用程序的环境始终保持不变，无论启用它的机器配置环境如何。

Docker旨在使开发人员和系统管理员都受益。它已成为许多DevOps（开发人员+维护人员）工具链中不可或缺的一部分。开发人员可以专注于编写代码，而无需担心最终托管它的系统是什么。使用Docker，无需安装和配置复杂数据库，也无需担心在不兼容的语言工具链版本之间切换。 Docker为维护人员提供了更多的灵活性，通常可以减少托管一些较小和更基本的应用程序所需的物理系统数量。  Docker简化了软件交付。新功能和错误/安全修复程序可以快速到达客户，无需任何麻烦，意外或停机。

### 总结

为了基础设施安全性和系统稳定性而隔离进程并不像听起来那么痛苦。 Linux内核提供了所有必要的工具，使简单易用的用户空间应用程序【如LXC（甚至Docker）】能够在隔离的沙盒环境中管理操作系统的微实例及其本地服务。

在本系列的第三部分中，我将讲述如何使用Kubernetes的容器编排。

**原文链接：[Everything You Need to Know about Linux Containers, Part II: Working with Linux Containers (LXC)](https://www.linuxjournal.com/content/everything-you-need-know-about-linux-containers-part-ii-working-linux-containers-lxc)**

==============================================================================
 译者介绍
 Grace，程序员，研究生毕业于SUNY at Stony Brook，目前供职于Linktime Cloud Company，对大数据技术以及数据可视化技术感兴趣。                                                                

​                                                                                                                                

​                                                                                                                                            

​                                    [ **0**](javascript:;)                                                                    

​                                                                                                                                                     分享                                                                                                             *2019-03-03*                                

​                                                    

## 