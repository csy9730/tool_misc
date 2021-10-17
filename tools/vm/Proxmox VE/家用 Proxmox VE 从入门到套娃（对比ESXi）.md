# 家用 Proxmox VE 从入门到套娃（对比ESXi）

​				![img](https://wusiyu.me/wp-content/uploads/2020/02/Screenshot_20200220_171410.png)							

**Proxmox Virtual Environment** ，俗称pve， 是一个开源的服务器虚拟化环境Linux发行版，带有qemu kvm虚拟机和lxc容器功能。pve基于Debian stable，如果你对deb系Linux比较熟悉，那么用起来会相当舒爽。

![img](https://pve.proxmox.com/mediawiki/images/f/f9/Proxmox-VE-5-4-Cluster-Summary.png)↑图片来源： https://pve.proxmox.com/wiki/Main_Page 

## 与ESXi比较

### 架构

ESXi虽然很多地方看起来很像Linux，但实际上其既不是Linux，甚至不是“Unix-like”，其内核是VMware专有的VMKernel，专为虚拟化而定制。

而pve本质就是个装了Web管理面板的的Debian stable，外加一些pve集群相关的服务，pve官方也支持从标准的debian既有安装上去部署pve，只需要添加pve的软件源即可。

![“Proxmox”的图片搜索结果](https://helloproxmox.readthedocs.io/zh_CN/latest/_images/proxmox_introduction.svg)pve的架构

这意味着pve是高度可定制的，因为这就是一个debian加了点料的系统，你甚至可以在pve上安装桌面使用，就像你可以在Kali上打游戏一样。

### 存储

本地存储方面，除去PCI直通外，ESXi只支持vmfs的文件存储和RDM（裸磁盘映射），但经测试，性能都很拉胯，能跑700MB/s的RAID6阵列，RDM到虚拟机后只能跑到 250MB/s左右。

pve的支持就很丰富，可以不通过文件系统，直接使用LVM或者LVM  thinpool中的分区，作为块设备给虚拟机当磁盘用，也可以在本机的文件系统（如ZFS）上使用qcow2格式虚拟磁盘文件，给虚拟机用。这里推荐使用LVM thinpool，具体会在下文提到。

![img](https://wusiyu.me/wp-content/uploads/2020/02/image.png)

既然支持直接使用块设备作为虚拟机的磁盘，那自然也可以直接将本机硬盘的设备文件挂到虚拟机上，实现ESXi的RDM（裸磁盘映射）功能， 评价速度700MB/s的RAID6阵列，在虚拟机的缓存选项关闭的情况下，也可以跑到500MB/s左右。 

### 处理器性能对比

ESXi和kvm都是硬件虚拟化，所有处理器性能和物理机相差较小，经过我的简单测试，在E5 2650 v2上ESXi可以发挥物理机95%左右的性能，而kvm为90%左右，低了一些。这里测试的项目是编译linux内核，如果是其他的项目可能会有不同结果。

## Proxmox VE 进阶技巧

### 精简置备与LVM thinpool自动空间回收

精简置备，即Thin Provision，比如你给一个虚拟机创建了一个大小为128G的虚拟磁盘，但虚拟机实际只使用了其中的10G，就只会占用宿主机10G的存储空间，而非厚置备时的128G。

常见的vmdk和qcow2格式的虚拟磁盘文件都支持精简置备，但都是“只增不减的”，例如刚才的虚拟机又在磁盘中创建了一些5G大小的文件，总共用了15G空间，虚拟磁盘文件也会增加到15G大小，这很正常，但如果之后虚拟机又删除了10G大小的文件，实际只使用5G空间了，虚拟磁盘文件并不会自动随之缩小，还是会维持15G的大小，造成了一定程度的浪费。

LVM即逻辑卷管理器，是Linux核心所提供的逻辑卷管理功能。它在硬盘的硬盘分区之上，又创建一个逻辑层，以方便系统管理硬盘分区系统 *（来自Wikipedia）* 。而LVM thinpool是一个lvm中支持精简置备的存储池，可以在其中创建精简置备的逻辑卷（分区），其只会为逻辑卷中真正存储了数据的部分分配存储块。

与虚拟磁盘文件不同的是，LVM  thinpool还支持discard，也称trim，了解SSD的人可能听说过它，其功能为：文件系统删除某些文件后，通知下级存储设备，这样文件在设备上相应的块已经不再被占用。对于LVM  thinpool，在逻辑卷上的文件系统上删除文件并执行trim后，thinpool也会释放逻辑卷中不再使用的存储块，使得逻辑卷实际占用的空间减小，thinpool的整体可用空间增加。

![img](https://wusiyu.me/wp-content/uploads/2020/02/image-10.png)man lvmthin 对此的描述

对于pve，其会将lvm中的逻辑卷作为虚拟机的磁盘，故使用lvm thinpool，并打开虚拟磁盘的`Discard`功能，在并在Linux客户机中对分区加入`discard`挂载选项或定期手动执行`fstrim`。对于Windows客户机，可以打开SSD模拟来诱使Windows对磁盘使用discard/trim的功能（我没测试过）。

![img](https://wusiyu.me/wp-content/uploads/2020/02/image-9.png)

### 嵌套虚拟化（虚拟机套娃）

![img](https://wusiyu.me/wp-content/uploads/2020/02/屏幕截图47.png)

在ESXi中虚拟机的CPU选项里，可以勾选“把CPU的虚拟化特性向客户机公开”，即允许客户机继续利用Host的硬件虚拟化功能去创建虚拟机，虚拟机中的虚拟机，套娃一样。在kvm中，可以在加载`kvm_intel`或`kvm_amd`的时候传入`nested=Y`选项，启用嵌套虚拟化支持，并最好在客户机CPU模型中选择`[host]`，否则可能会不识别。

### 更换WebUI的主题界面

pve的WebUI界面基于一个叫做extjs的东西，所以可以套用extjs的其他主题，参考：https://lunar.computer/posts/themes-proxmox/

我在其`theme-triton`上进行了一些小改动，最终效果如下：

![img](https://wusiyu.me/wp-content/uploads/2020/02/image-7.png)

![img](https://wusiyu.me/wp-content/uploads/2020/02/image-8.png)

如果有人感兴趣，我会把修改的文件打个包传上来。

## 总结

对于家用homelab环境，比如简单的单机部署，pve是很方便的。不过对于大型企业级场景，ESXi和ovirt可能会是更好选择，毕竟他们身后都有一线大型企业背书。

+3			

发布日期：2020年2月20日作者：[WuSiYu](https://wusiyu.me/author/wusiyu/)

分类：[Linux & homelab](https://wusiyu.me/category/linux/) 

![img](https://secure.gravatar.com/avatar/2f33c5c8301def53ee2efd008260b73e?s=85&d=retro&r=pg)

## 			作者：WuSiYu			

 学生，Web开发者，智能硬件&IOT爱好者

[查看WuSiYu的所有文章。](https://wusiyu.me/author/wusiyu/)