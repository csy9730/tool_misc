# OpenMediaVault：你的开源 NAS 系统

[韦易笑](https://www.zhihu.com/people/skywind3000)[](https://www.zhihu.com/topic/20054793)

游戏开发等 4 个话题下的优秀答主

353 人赞同了该文章

我在本专栏里介绍过 HomeLab 服务器的虚拟化的方案，推荐过一些看起来不错的硬件，那么接下来将要讨论搭建 Nas 系统的相关话题了。

Nas 系统方案有很多：标准 Linux，黑群晖，FreeNas，ClearOS，OpenMediaVault。标准 Linux 当然什么都能，但是配置太麻烦了，配置个 samba 或者 ftp 很简单，但你要配置的好就需要查很多资料，你想统一他们的权限也比较麻烦，总之就是一地的碎螺丝等着你去捡，一不小心碰到哪里了，一个错误操作你的数据就挂了。

黑群晖使用相对简单，但是破解的东西总归不大好，你要选择能兼容你设备的版本，而且哪天它群晖一升级，破解跟进不利，你就锁死版本了。还有一个问题是黑群晖用的魔改 linux，不是一个标准发行版，很多事情你做不了，或者得绕很大一个圈去做，后面会说到。

ClearOS 是相对比较完善的系统，但是免费版本功能太少，好用的模块都要付费，FreeNas 有 zfs，但是是 FreeBSD 系统，连 Docker 都跑不起来，再多插件也没用。

所以推荐今天的主角，基于 Debian 的免费开源的 [OpenMediaVault](https://link.zhihu.com/?target=https%3A//www.openmediavault.org/) 下面简称 OMV：

![img](https://pic3.zhimg.com/80/v2-1eebdc9732e171adeb06314d99bbc2a2_1440w.jpg)

大概是这么样一个传统 Nas 的界面，提供简单清晰的界面让你方便的管理你的：存储设备，访问权限，以及网络服务，这三者基本上是 Nas 系统最基础的功能了。同时 OMV 支持插件，透过插件可以安装其他常用服务，还有 docker 之类的东西。

那么把 OMV 安装在哪里呢？OMV 如果安装在物理机上也不是不可以，但是它的虚拟机功能实在太弱，不够完善，因此还是建议物理机上直接上专业的虚拟化系统，比如 ProxmoxVE 或者自己搭建 KVM + WebVirtMgr 之类的，保证物理机的简单纯粹，就做好虚拟化一件事情就好，OMV 放在虚拟机中折腾挂了也不怕，可以方便的备份，快照，迁移。

关于 Nas 系统虚拟化的必要性我前文《[Nas 系统的虚拟化方案](https://zhuanlan.zhihu.com/p/55025102)》中已详细讨论过，因此一种常见的结构是：

![img](https://pic2.zhimg.com/80/v2-ee99626bb926d7b5c5dc848660aed059_1440w.jpg)OMV 安装在虚拟机中（右上角）

物理机的 Hypervisor 配置好后，基本就不需要去动了，同时保持 Hypervisor 上只启动和虚拟机相关的有限的几个服务，其他端口可以全部关闭，越简单的东西越稳定安全。还有一个好处是你可以在不同的虚拟机内尝试不同的 Nas 系统，折腾出错删除重建就行，不会把你整套系统给弄挂掉。

同时所有虚拟机都是通过网桥（bridge）的方式和物理机接入同一个内网，拥有和物理机同级的 IP，可以让你家里的所有设备直接一个 IP 就能访问。

**存储设备管理**

那么虚拟化安装 OMV 以后第一个问题就是怎么管理存储设备，物理机 Hypervisor 的系统装在 SSD 上，但是假设你有四块 HDD 硬盘挂载在物理机上上，你怎么是让物理机管理他们呢？还是让 OMV 管理他们？传统有两种方法来完成这个事情：

**方案1：**物理机管理存储设备，你的 zfs/raid(mdadm) 在物理机上建立，然后新建 200G 一个的独立 qcow2 虚拟磁盘设备给 OMV，这是最简单，也是性能最差的方案，而且外层磁盘出错时，你一整个 qcow2 内的文件恢复很麻烦。

**方案2：**OMV 管理存储设备，物理机那里通过 KVM 的 PCI 透传，将存储设备+USB端口全部透传给 OMV，注意关闭写 cache，然后在 OMV 那里看起来和本机的存储设备/USB端口一样，然后在 OMV 里面组建 Raid/ZFS 其他虚拟机想访问这些存储设备可以用 OMV 提供出来的 NFS/Samba 协议进行访问，这是我推荐的方案。

这两个方案的配置方法，我在《[Nas 系统的虚拟化方案](https://zhuanlan.zhihu.com/p/55025102)》 中提到过，而如果你选用了 OMV 这种基于标准 Linux 发行版的系统的话，还有更好的第三种方案供你选择。

**第三种存储方案**

这种方案继续使用物理机 Hypervisor 那里管理所有存储设备，建立 zfs 和 raid，然后透过 9p （或者称为 VirtFS），用共享文件夹的方式，将某个文件夹共享给虚拟机内的 OMV，然后 OMV 的 fstab 中 mount 到本地文件夹并提供服务：

- 物理机管理存储 -> 9p文件夹共享 -> 虚拟机 mount -> OMV 提供服务

这种方案的好处是，不论物理机还是其他虚拟机都可以直接访问你的单个文件，存储资源不会像先前 PCI 透传那样被 OMV 垄断导致其他虚拟机或者物理机想访问就只能透过 OMV 的 nfs/samba 服务。第三种方案只要物理机配置好 raid/zfs 后，就可以让数据在物理机和所有虚拟机中间全部透明化，物理机也可以自由的用 HDD 资源新建大点的虚拟磁盘给 windows 虚拟机用，不用所有虚拟磁盘都放在物理机的 ssd 上面。

先在物理机上修改 OMV 的虚拟机配置文件 XML：

```xml
<filesystem type='mount' accessmode='mapped'>
      <source dir='/home/data/kvm/kfs'/>
      <target dir='kfs'/>
</filesystem>
```

这样相当于把物理机的 `/home/data/kvm/kfs` 文件夹共享给 OMV 的虚拟机，并取个名字叫做 "kfs"，虚拟机内可以用这个名字 mount。由于我物理机用的是 WebVirtMgr，可以直接在页面上修改虚拟机 xml，如果你用 ProxmoxVE 的话，需要找一下最新版界面上好像有相关配置，没有的话，登录 ProxmoxVE 终端，用命令行修改配置。

物理机注意准备下相关目录和权限：

```bash
sudo mkdir /home/data/kvm/kfs
sudo chown libvirt-qemu:libvirt-qemu /home/data/kvm/kfs
```

注意上面共享目录的权限需要和你虚拟机运行权限相同，qemu.conf 里有这个配置，你还可以在物理机 ps aux 看看虚拟机进程所属的用户和组。接下来 OMV 虚拟机中编辑 /etc/modules 文件，添加下面几行：

```text
loop
virtio
9p
9pnet
9pnet_virtio
```

虚拟机内加载内核模块：

```bash
sudo service kmod start
```

然后测试 mount：

```bash
sudo mkdir /mnt/kfs
sudo mount -t 9p -o trans=virtio kfs /mnt/kfs
```

这样，虚拟机中的 /mnt/kfs 就映射到了物理机的 /home/data/kvm/kfs 路径下。

测试成功的话，设置 /etc/fstab：

```text
kfs             /mnt/kfs        9p      trans=virtio    0       0
```

修改完后，mount -a 测试，测试通过重启虚拟机即可。当然实在懒得折腾可以在物理机上启动一个 nfs 服务，然后虚拟机里面 mount 物理机的 nfs 文件夹，实测性能也还行。

上面已经把物理机的 /home/data/kvm/kfs 共享给 OMV 并且 mount 到 /mnt/kfs 下面了，接下来进入 OMV 插件管理页面，安装 sharerootfs 这个插件：

![img](https://pic1.zhimg.com/80/v2-36b0703c970850e5be9c50a5cf15f77c_1440w.jpg)

这个插件可以让你在 OMV 里面把刚才配置的 /mnt/kfs 文件夹共享给所有服务，接着配置：

![img](https://pic2.zhimg.com/80/v2-e5e9f3c21e7efa3ce59292daac1cace1_1440w.jpg)安装了插件后，就可以添加 OMV 根文件目录下的某个目录作为共享了

找到 OMV 左边的 “共享文件夹”项目，然后点击 “添加”，把你刚才写到 fstab 里的 kfs 共享目录添加进去，我添加的是 kfs 下面一个名为 share 的文件夹，OMV 里提前准备：

```bash
$ mkdir /mnt/kfs/share
$ chown root:users /mnt/kfs/share
$ chmod 775 /mnt/kfs/share
```

总之该 /mnt/kfs/share 文件夹要在 OMV 里保证 users 组可以有读写权限，添加完毕以后，继续在页面上配置哪些用户对这个共享文件夹有权限了：

![img](https://pic2.zhimg.com/80/v2-a26c6bcb590a846c9237bf954cf223a9_1440w.jpg)

于是你就可以在 OMV 页面中把该目录开放给 samba/ftp/nfs 等一系列服务了。至于性能嘛，比起直接 PCI 透传，中间多了一道 9p 文件共享，当然有所下降，但是还好，我内网笔记本透过 wifi 从 FTP 下载文件差不多 50MB/s 的速度，最重要的是避免了 OMV 完全垄断掉所有 HDD 存储设备。

**容器管理**

自从 OMV5 以后，用户可以透过 OMV-Extras 扩展安装各种 docker 服务：

![img](https://pic3.zhimg.com/80/v2-ec4c91df07d5f04e2ea4bd6ec26237e6_1440w.jpg)

在 OMV5 中安装好 OMV-Extras 后，点击左侧的 OMV-Extras 就会看到 Docker 设置页面，进去最重要的一项设置就是 Docker 存储，你可以把它挪到某个 9p 共享文件夹中来保存 docker 的各种数据，也可以继续放在 OMV 的根文件系统下，默认保存 docker 数据，等到具体新建 docker 容器的时候再按照具体需要把数据文件夹映射到 9p 的 HDD 上面去。

在 OMV5 的 docker 中自带了 portainer，点击右上角的“打开 web 页面”即可，然后连接到本地 docker：

![img](https://pic2.zhimg.com/80/v2-05c9faab1613b352082854ee8b52d9bd_1440w.jpg)

Portainer 提供图形化的界面让你管理各个容器，先当于图形化编写 docker-compose 文件的感觉。你基本可以在 Portainer 里面干完所有 docker 相关的事情，当然仍然可以全程用 docker-compose 文件初始化各种服务，然后用 portainer 进行监控和启停。

**常用 Docker 服务**

一些常用的 docker 服务：

- MySQL：

![img](https://pic1.zhimg.com/80/v2-640e3c411b7da568361cd1f57e77522c_1440w.jpg)

为整个内网和其他容器提供数据库服务。

- NextCloud：

![img](https://pic1.zhimg.com/80/v2-311e113e73ca6f30914d905fb23076a8_1440w.jpg)

个人存储云，相当于 dropbox，怎么能少得了呢？

- Gogs：

![img](https://pic3.zhimg.com/80/v2-303ef0d5e02c34a5da201465247c72aa_1440w.jpg)

轻量级 Git 服务，提供类似 GitLab 的功能，但是速度非常快，内存占用很低，自己的代码自己管理。

- Piwigo：

![img](https://pic2.zhimg.com/80/v2-540d889011192aba41d376ede5a41679_1440w.jpg)

家里的照片，用它统一管理起来，并且提供友善的界面和缩略图生成。

Nas+Docker 说起来就一大堆内容了，有兴趣自己探索吧。

**外网穿透**

家里提供了那么多的服务，比如我想在外面访问 gogs 的代码服务的话，那么内网穿透少不了，家里网络稳定有外网 IP 的话，推荐动态域名和路由器内网端口映射，没有的话，使用 FRP 进行内网穿透：

[韦易笑：内网穿透：在公网访问你家的 NASzhuanlan.zhihu.com![图标](https://zhstatic.zhihu.com/assets/zhihu/editor/zhihu-card-default.svg)](https://zhuanlan.zhihu.com/p/57477087)

而且 Frp 推荐直接搭建在 OMV 的服务器上，因为 OMV 自身提供的服务多，装个 supervisor 把 Frp 托管起来。

**关于备份**

OMV 自身根文件夹的备份可以用物理机上的快照，或者关了机直接备份一下 OMV 的 qcow2 磁盘文件，恢复也这样恢复。至于 HDD 上的数据的话，本身就处在 Raid/Zfs 中，你可以定期拷贝一下，我的建议是把 USB 端口透传给 OMV ，需要备份时插上 USB 硬盘，然后再 OMV 内部直接操作备份。

除此之外对于重要数据，还需要写一些同步脚本定时同步到外地的服务器上。

\--

相关阅读：

- 《[KVM 虚拟化环境搭建 - ProxmoxVE](https://zhuanlan.zhihu.com/p/49118355)》
- 《[KVM 虚拟化环境搭建 - WebVirtMgr](https://zhuanlan.zhihu.com/p/49120559)》
- 《[Nas 系统的虚拟化方案](https://zhuanlan.zhihu.com/p/55025102)》
- 《[内网穿透：在公网访问你家的 NAS](https://zhuanlan.zhihu.com/p/57477087)》

\-





编辑于 2020-05-05

[个人私有云](https://www.zhihu.com/topic/19617399)

[网络存储](https://www.zhihu.com/topic/19580009)

[家用 NAS](https://www.zhihu.com/topic/19736752)