# [Ubuntu: 软件库(software repositories) ](https://www.cnblogs.com/sparkdev/p/10489017.html)

Linux 生态下，几乎每个发行版都有自己的软件库(software repositories)，Ubuntu 当然也不例外。Ubuntu 提供了四个不同的软件库，分别是 main、restricted、universe 和 multiverse：

![img](https://img2018.cnblogs.com/blog/952033/201903/952033-20190307131200927-146781993.png)

本文主要介绍它们之间的区别。本文的演示环境为 Ubuntu Desktop 18.04。

# Main 库

Main 库由 Ubuntu 官方支持，其中的软件都是开源免费的。Ubuntu 的默认安装中的所有开源软件都在 main 库中，另外还有一些比较重要的服务器软件也被包含在 main 库中。在 Ubuntu 发行版的生命周期中，main 库中的软件会有安全更新，严重的问题会被修复。

Main 库是 Ubuntu 最重要的软件库，Ubuntu 官方(实际上是 Canonical 公司)承诺在发行版的生命周期中，这里面的每一个软件包都会收到安全补丁和严重问题的修复补丁。比如对于 Ubuntu LTS(长期支持版)来说，支持周期为五年，就是保证在五年内会有安全更新。而这里的安全更新，实际上就是对 main 库中的包进行安全更新。之所以会有这样的保证，也是因为 main 库中的软件都是开源软件，Ubuntu 自己的开发人员就可以修复这些问题而无需依赖第三方。

在 Ubuntu Desktop 中通过 GUI 工具管理软件时，可以在软件的详细信息处看到该软件属于哪个库，比如下图中的 Vim 属于 main 库：

![img](https://img2018.cnblogs.com/blog/952033/201903/952033-20190307131338003-71348484.png)

# Restricted 库

Restricted 库中包含 Ubuntu 官方支持的闭源软件(Closed-Source)，主要是一些硬件驱动程序。比如运行一些游戏程序，需要安装 NVIDIA 或 AMD 的图形驱动程序来获得最佳的图形硬件性能。这些驱动程序可以通过 Ubuntu 中的其他驱动管理工具来启用。

Ubuntu 官方将在承诺的支持期内为这些闭源的驱动程序和固件包提供支持。他们致力于让这些驱动程序继续工作，解决任何严重的问题，并堵住任何的安全漏洞。当然，Ubuntu 自己无法做到这一点——当出现问题时，他们必须等待硬件制造商发布新的驱动程序或更新有问题的驱动程序。因为代码不是开源的，所以 Ubuntu 官方无法自己修复它，这就是为什么这里只包含关键的硬件驱动程序的原因(没有其他的封闭源软件得到官方支持)。

# Universe 库

Universe 库中存放的是由社区维护的开源软件。我们在 GUI 工具 Ubuntu Software 中看到的软件多数都来自 universe 库：

![img](https://img2018.cnblogs.com/blog/952033/201903/952033-20190307131506149-680297294.png)

这些软件包要么是自动从最新版本的 Debian 库中导入的，要么是由 Ubuntu 社区上传和维护的。
Ubuntu 不为 universe 库中的软件提供官方支持或更新。即便不能收更新，universe 库中的软件通常也能够运行的很好。所以我们基本上可以放心的使用 universe 库中的软件！
但是，在服务器系统上，需要我们考虑安装的服务器软件是 main 库的一部分还是 universe 库的一部分。如果它来自 universe 库，您需要关注其安全性更新。如果发现漏洞，您需要自己更新该服务器软件。

同样在 Ubuntu Software 中，可以在软件的详细信息处看到该软件是否属于 universe 库，比如下图中的 plan 程序就属于 universe 库：

![img](https://img2018.cnblogs.com/blog/952033/201903/952033-20190307131559120-1746478814.png)

# Multiverse 库

Multiverse 库是不受 ubuntu 官方支持的软件、闭源软件和专利授权软件聚集的地方。这是哪些有争议的东西存在的地方。它包括像 Adobe Flash 插件这样的闭源软件，和那些依赖于闭源软件的包，比如 Skype 的插件。它还包括受法律限制的开源软件，例如侵犯专利的音频和视频播放软件。这里不包括 DVD 播放软件——开源的 libdvdcss DVD 播放库存在严重的法律问题。

Ubuntu 不会在主发行版发布的同时发布这些包，但是我们却可以从这里提供的内容获得便利。在其他 Linux 发行版中，这里的内容通常可以在第三方存储库中找到，比如 Fedora 的 RPM Fusion、openSUSE 的 Packman 等。
和 universe 库一样，Multiverse 也是一个由社区支持的库，因此这里不会保证有安全更新。

# Download Server

Ubuntu 官方提供了上述库的下载服务器，但是对于全球的使用者来说使用默认的服务器并不一定是最好的选择。我们可以指定一个地理位置上比较近或者是认为下载速度比较快的服务器：

![img](https://img2018.cnblogs.com/blog/952033/201903/952033-20190307131717897-144032027.png)

总结这样下载更新文件的速度可能会有比较大的提升。

# 配置文件

我们在 GUI 工具中配置的 Download Server 信息都保存在配置文件 /etc/apt/sources.list 和 /etc/apt/sources.list.d 目录下的文件中。/etc/apt/sources.list 中一般保存 Ubuntu 库的配置信息，比如：

```
deb http://cn.archive.ubuntu.com/ubuntu/ bionic main restricted
```

这行信息指明 Ubuntu bionic(18.04) 版本的 main 库和 restricted 库的服务器地址为 http://cn.archive.ubuntu.com/ubuntu/。
如果要添加第三方软件库的信息，可以在 /etc/apt/sources.list.d 目录下创建 .list 文件，把源信息写入到文件中就可以了。

或者我们不使用 GUI 工具，直接编辑配置文件 /etc/apt/sources.list，把其中指定的默认的库的 Download Server 修改为指定的服务器。修改后运行下面的命令，然后就可以使用新指定的服务器安装包了：

```
$ sudo apt-get update
```

# Other Softwares

还有一些软件提供了自己的库和下载服务器，它们被显示为 "Other Software"，比如下图中显示的 docker 和 vscode：

![img](https://img2018.cnblogs.com/blog/952033/201903/952033-20190307131857800-260979151.png)

在我们安装这些软件前，需要先添加其下载服务器已经库信息：

![img](https://img2018.cnblogs.com/blog/952033/201903/952033-20190307131932888-924177427.png)

当然，你也可以通过编辑配置文件或者是通过命令完成同样的任务。

**参考：**
[What's the Difference Between Main, Restricted, Universe, and Multiverse on Ubuntu?](https://www.howtogeek.com/194247/whats-the-difference-between-main-restricted-universe-and-multiverse-on-ubuntu/)

作者：[sparkdev](http://www.cnblogs.com/sparkdev/)

出处：http://www.cnblogs.com/sparkdev/

本文版权归作者和博客园共有，欢迎转载，但未经作者同意必须保留此段声明，且在文章页面明显位置给出原文连接，否则保留追究法律责任的权利。

标签: [ubuntu](https://www.cnblogs.com/sparkdev/tag/ubuntu/)