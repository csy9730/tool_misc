# 可能是全网最简单的 OpenStack 安装方式

OpenStack 因为架构复杂，配置较多，一向以安装部署过程困难闻名。

使用本文介绍的基于 Kolla-Ansible 构建的操作系统镜像，用户只需执行极少命令即可完成环境的部署。

> 不想看文字的可以直接看视频

[使用Kolla快速部署OpenStack，可能是全网最简单的OpenStack安装教程_哔哩哔哩 (゜-゜)つロ 干杯~-bilibiliwww.bilibili.com![图标](https://pic4.zhimg.com/v2-81b2df22b082721d564d1baac74bc81f_180x120.jpg)](https://www.bilibili.com/video/av78684627/)

## 安装 OpenStack 可能有多麻烦

### 选择项太多

OpenStack 诞生之时，在运维自动化领域已经存在多个配置工具，不同的团队有不同的技术偏好，因此他们纷纷选择不同的工具来实现 OpenStack 的自动化安装：

- Ansible
- Puppet
- Chef
- Salt

OpenStack 可以部署在多个主流的 Linux 系统中：

- Ubuntu
- RHEL/CentOS
- SUSE/openSUSE

OpenStack 架构也很灵活，除了核心模块外，还有很多可选模块；

- Swift
- Cinder
- Neutron
- Heat
- ...

核心模块本身也有多种可选配置，比如说网络项目 Neutron，可以选择：

- Linux Bridge
- OpenvSwitch

OpenStack 是一个基于 Python 的开源项目，意味着除了从软件包安装外，还会有使用 `pip install` 从 pypi 安装 Python 模块，以及从 git 源码仓库下载源码安装的需求：

- rpm/deb 源
- pypi 源
- git 源

开源社区的工具一般比较中立，各种场景都要照顾到，也不会特意去强调哪种方式更好，所以对于新人来说，如何选择容易上手的部署方式是一个难题。

OpenStack 针对开发快速上手有一个专门的项目 `devstack`，但是由于众所周知的国情，会遇到下面的网络问题。

### 网络不给力

开源的部署工具一般都是基于软件包仓库或者是代码仓库，需要在线下载软件包或源码安装。这些仓库基本都是国外的网站。这就又涉及到几个问题：

一个是下载速度的问题，虽然近些年国内出现了很多镜像站，但是配置软件安装源在不同的操作系统中是不同的操作命令，不是所有人都能熟练完成。

也不是所有的自动化安装工具的作者（绝大部分是老外）会意识到网络会是个问题，安装文档里不会去特意去提安装源的设置，甚至不会把它们作为可配参数提取出来。

再者，随着版本的升级和时间推移，包括社区的变动，很多软件安装源的 URL 会发生变更，并不是长期保证不变的。也就是说，基于网络安装的文档是有时效性的，可能过1、2年就不具备可操作性了。

此外，即便网络状况很好，安装一切顺利，如果要反复多次搭建，每次都需要下载安装也会比较耗时间。

### 版本变化快

OpenStack 的版本发行计划是每半年 release 一个版本。听上去没那么频繁，实际上对于这种超大型的项目来说，可能你当前版本还没完全吃透呢，又来新版本了。所以，目前网上很多的安装工具和安装教程也都过时了。

这里给大家提供的是次新的 `Stein` 版本，可以体验更多的新特性。

## 安装 OpenStack 可以有多简单

下面给大家介绍的是基于 Kolla-Ansible 的容器化部署方式。

常规的安装文档中，Kolla-Ansible 本身也是需要安装部署的，它用到的 docker 容器的镜像也需要从网络上拉取，为了进一步简化操作，这里将 Kolla-Ansible 工具和镜像包和 CentOS 系统镜像一起打包，重新构建生成一个可引导的 .iso 镜像。真正做到了一键启动，离线安装，装完即用。

> 关于 Kolla 的一些细节以后会逐渐展开介绍，本文暂不涉及。

### 准备一台机器

大部分人可能没有空闲的机器专门来安装 Linux 系统，这里我们使用虚拟机也可以完成安装。

选择一个适合你的系统的虚拟机管理软件即可：

- VirtualBox （推荐）
- VMWare
- Hyper-V
- 其它

### 下载 .iso 镜像文件

微信搜索并关注公众号 `DavyCloud`，获取下载链接

### 创建虚机

先配置两个网络：

- 两个 host-only 的网络，
- 其中一个网络的地址段设置为 `10.10.10.1/24`



![img](https://pic1.zhimg.com/80/v2-a743c942087277c8cf1653888ed36b94_1440w.jpg)



新建一个虚拟机，满足以下条件：

- 内存 8GB
- 启动盘选择 `davycloud-openstack-stein.iso`
- 磁盘空间 >= 40GB
- 两个网卡分别配置两个 host-only 的网络，
- **第一块**网卡的地址段对应到 `10.10.10.1/24` 那一个



![img](https://pic1.zhimg.com/80/v2-fca6d708d765ae870e1a526fc2e38fd0_1440w.jpg)



### 修改启动选项

进入引导菜单时，有两个选项：

- 安装 Deploy 节点
- 安装 Worker 节点 （默认）

使用方向键移动光标，选择第 1 个，按下回车键开始安装系统。



![img](https://pic3.zhimg.com/80/v2-8072d783f9bb41e48a5e6080b62a445a_1440w.jpg)



> **为什么**要把默认选项放在第 2 个？
> 因为部署节点只需要安装一个即可，而工作节点可能会有很多个。

系统进入自动安装流程，整个过程无需任何交互。系统安装完毕后会弹出光盘并自动重启。

第一次启动过程会比较耗时，请耐心等待。

### 配置修改

> 如果虚机的网络地址段按要求配置，对 OpenStack 的模块也没有什么特别要求，这里可以**不做任何改动**，直接跳到下一步骤即可。
> 为了不让本文变得冗长，这里也不具体介绍修改配置的方法，仅简单说明相关情况。

All-In-One 安装场景默认安装 OpenStack 核心模块和公共组件，包括：

- MySQL
- RabbitMQ
- Memcached
- Keystone
- Glance
- Neutron
- Nova
- Heat

注意到核心模块里包含了初级用户平常比较少用的 Heat 服务，而比较常用的卷存储服务 Cinder 却没有作为核心模块包含在内。如果需要安装 Cinder，需要为其指定一个 backend，不同的存储方式可能还有其它额外的配置条件，这里先保持默认不安装。

同时注意，即使是 All-In-One 场景，默认也是启用了 HAProxy 和浮动 IP，也就是需要安装：

- HAProxy
- Keepalived

启用 HAProxy 不需要什么额外操作，唯一需要的就是多占用一个 IP 地址。启用浮动 IP 可以使得后续控制节点的横向扩展更简单。因此，除非确定就是一直作为单节点环境使用，否则推荐保留默认配置。

> 值得注意的是，在某些云环境下（比如 OpenStack），这个浮动地址可能会面临安全组的问题，需要一些额外的配置。后面有机会再详细说明。

### 命令三连：prechecks、deploy、post-deploy

使用用户名 `kolla`，密码 `kollapass` 登录系统，并切换到 `root` 用户：

```text
$ sudo -s
# cd /root
```

下面的所有操作都使用 `root` 用户执行，全程只需要执行三个命令：

> 下面每个命令都是执行相应的 ansible playbook，所以屏幕会有大量打印。

安装前的环境检测，检查是否必要条件都已经满足

```text
# kolla-ansible prechecks
```

开始安装，视机器性能和选择安装模块数量，20分钟到40分钟不等，耐心等待即可

```text
# kolla-ansible deploy
```

安装后的一点点收尾工作

```text
# kolla-ansible post-deploy
```

上面的命令执行完成后，会在 `/etc/kolla` 目录下生成 `admin-openrc.sh` 文件，其中包含了登录所需要的用户名和密码信息。

### 使用 openstack 命令

以前的 OpenStack 版本每个模块都提供自己的客户端命令，例如 `nova`， `glance`等，现在基本都统一使用 `openstack` 命令。以前的命令有的还能用，比如 `nova`，有的已经不能用了，比如 `keystone`

要使用 `openstack` 命令，必须先要安装各模块的客户端包。而我们的宿主机系统里面只安装了 `Docker` 和 `Ansible`。Kolla 构建的 docker 镜像中，已经在 `openstack-base` 这个基础镜像中安装了所有的客户端包，这意味着：

1. 我们完全没有必要在宿主机单独安装客户端
2. 进入任意一个 OpenStack 服务的容器里，都可以使用客户端

但是，每次手动敲命令进入容器里毕竟不够方便，所以我在镜像中内置了一个 bash 脚本，取名就叫 `openstack`，其中的内容是启动一个容器，使用方法和原本 `openstack` 命令一致：

```text
# source /etc/kolla/admin-openrc.sh    <--仍然需要先导入环境变量
# openstack                 <-- 直接敲命令
(openstack)
```

### 登录 horizon

> 因为随机生成的 admin 用户密码很长，VirtualBox 的控制台不支持复制，所以这时候你最好先找个 SSH 客户端登入虚拟机中把密码拷贝出来



![img](https://pic1.zhimg.com/80/v2-781afddc4c6e0612f8fa3e3fda3cb7c8_1440w.jpg)



### 开始体验

安装过程还有疑问的可以在 [Bilibili](https://www.bilibili.com/video/av78684627) 观看视频操作。

如果觉得文章不错，别忘了点赞和关注公众号，谢谢！

> **PS. 后面还有相关实验会用到 [阿里云](https://www.aliyun.com/%3Fsource%3D5176.11533457%26userCode%3Dsyyh0qx4)，年底大促[新用户首购优惠](https://www.aliyun.com/minisite/goods%3FuserCode%3Dsyyh0qx4)幅度挺大，有需要的同学不妨考虑搞一台。**