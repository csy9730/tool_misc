# webvirtmgr

KVM 的优点是全用开源技术栈在 Linux 下搭建一套属于你自己的 vmware，并且性能比 vmware 还好，在服务端领域 KVM 先后淘汰了：vmware, virtual pc, xen 等一系列老牌的虚拟化服务。

我现在基本不会直接用物理机进行工作，买台物理机来装好操作系统第一件事情就是上 kvm 系统，然后再虚拟机内工作，这样最灵活，环境充分隔离，虚拟机升级/备份/迁移都很方便。

现在包括你熟知的 linode，aws 之类的 vps 服务商 2015年开始就已经从 xen 全面迁移到 kvm了，这么几年用下来，性能和稳定性是大家有目共睹的。

搭建 KVM 环境主要包括几个部分：

1. qemu：用于提供虚拟化服务
2. libvirt：提供 libvirtd 服务，用于管理物理机中的虚拟机实例，并提供外部编程接口。
3. 页面管理器：webvirtmgr 等，提供页面，操作本地libvirt，对虚拟机进行新建/删除/设置/运行
4. vnc服务：页面上控制虚拟机的键盘鼠标，还有显示设备，用来装系统用。

搭建好后你就可以愉快的新建虚拟机了，下图是 webvirtmgr 管理虚拟机实例

![img](https://pic2.zhimg.com/50/v2-1b584fee2999926d502f6ab8e59f7788_720w.jpg?source=1940ef5c)![img](https://pic2.zhimg.com/80/v2-1b584fee2999926d502f6ab8e59f7788_720w.jpg?source=1940ef5c)

新建虚拟机：

![img](https://pic3.zhimg.com/50/v2-42163fce40b6af1aee245a23aa8fc4c2_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-42163fce40b6af1aee245a23aa8fc4c2_720w.jpg?source=1940ef5c)

通过 web-vnc 给虚拟机安装操作系统：

![img](https://pica.zhimg.com/50/v2-517fbb9cc08ef18997ee41c147f9e415_720w.jpg?source=1940ef5c)![img](https://pica.zhimg.com/80/v2-517fbb9cc08ef18997ee41c147f9e415_720w.jpg?source=1940ef5c)

监控资源消耗：

![img](https://pic3.zhimg.com/50/v2-904a9abcddcb9afb2cfa9b2f675cf017_720w.jpg?source=1940ef5c)![img](https://pic3.zhimg.com/80/v2-904a9abcddcb9afb2cfa9b2f675cf017_720w.jpg?source=1940ef5c)

有几个坑要注意下：

1. 请始用网桥模式，网桥得配置对，用默认的 nat 的话无法提供对外服务。
2. 在 IDC机房里架设 kvm，请将显示设备的 vnc 设置那里加个密码，不然容易被黑。
3. Linux 和 FreeBSD 等都可以直接始用 virtio 发挥最佳性能。
4. 安装 Windows 时，要先将 virtio 模式禁用，或者安装支持 virtio 的驱动。
5. IDC 架设集群可以考虑 vswitch 服务，每台vps双ip，一个外网，一个内网。
6. 可以用 python + python-libvirt 写一些简单的自动化管理工具。

架设方法见：

[retspen/webvirtmgr](https://github.com/retspen/webvirtmgr)