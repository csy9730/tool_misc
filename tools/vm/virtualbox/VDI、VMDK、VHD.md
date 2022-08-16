# VDI、VMDK、VHD
## VDI、VMDK、VHD分别有什么区别
虚拟机vm的虚拟机硬盘VDI、VMDK、VHD分别有什么区别？ 

期望能从以下方面对上述格式做个对比：

- 能够使用动态大小调整
- 可以做快照
- 能够以较小代价将我的虚拟机移动到另一个操作系统或者虚拟机。最好能在ubuntu上正常运行。
- 性能

### 综述

这些都是虚拟机格式

- vmdk 是vm虚拟机的格式
- vdi是virtual box的格式
- vhd 是微软Virtual PC虚拟机的格式
- HDD是苹果系的格式
- OVA
- raw, qcow2 是kvm使用的格式


VirtualBox完全支持VDI，VMDK和VHD，并且支持Parallels Version 2(HDD)。

其中VHD是微软系的格式，而HDD是苹果系的格式，这些都对跨平台有限制，所以，不太推荐。

### vhd
vhd 是微软Virtual PC虚拟机的格式。

### vmdk
vmdk 是vm虚拟机的格式。VMDK是专门为VMWare开发，但其他虚机像Sun xVM，QEMU，VirtualBox，SUSE Studio和.NET DiscUtils也都支持这种格式。 (这种格式应该是最适合题主的，因为您希望在Ubuntu上正常运行虚拟机软件。)
### vdi
vdi是virtual box的格式。

### HDD
关于HDD，从这个站点来看，Parallels是Mac OS X产品，可能不太适合您，特别是考虑到VirtualBox仅支持旧版本的HDD格式。 


### vmdk转vhd
Windows7的引导程序能够引导vhd格式的虚拟硬盘，而VirtualBox创建的虚拟硬盘文件是vdi格式的，怎么办呢？
以前要借助其他软件才能实现，但是VirtualBox早就悄悄为我们带来了一个VBoxManager.exe来转换格式。
命令如下(Windows环境，Linux版的应该也有VBoxManager这个二进制文件)：
VBoxManager存在于VirtualBox的安装目录下。

``` bash
# vmdk转换成vdi
VBoxManage.exe clonehd source.vmdk target.vdi --format VDI 

# vdi转换成vmdk
VBoxManage.exe clonehd source.vdi target.vmdk --format VMDK 

# vdi转换成vhd
VBoxManage.exe clonehd source.vdi target.vhd --format VHD 
```


vmdk转vhd，vhd转vdi、vmdk的话稍微改一点参数就OK了。
需要注意的是运行完命令之后，原文件并不会被删除。


### OVA
关于虚拟机迁移的补充回答

关于虚拟机迁移，更通用的做法可能是使用VirtualBox文件/导出功能，创建一个“开放的虚拟化设备”.ova文件，然后可以导入到VMware。通过这种方法，您可以将虚拟机移植到支持.ova的任何虚拟化系统，而无需关心您在VirtualBox中使用哪种磁盘映像格式。

如果您需要定期从相同的VM导出，比如要每一天做一遍，这可能比较麻烦。但是，如果你只是偶尔移动到不同的技术，这应该是不错的选择。

如果您已经有一个.vdi文件，您可以试试这个是否有效，而无需创建新的虚拟机：将其导出为.ova，然后尝试使用vmware进行导入。

### raw
RAW 的原意是「未被加工的」, 所以 RAW 格式镜像文件又被称为 原始镜像 或 裸设备镜像, 从这些称谓可以看出, RAW 格式镜像文件能够直接当作一个块设备, 以供 GuestOS 使用. 也就是说 KVM 的 GuestOS 可以直接从 RAW 镜像中启动, 就如 HostOS 直接从硬盘中启动一般。至于文件里面的空洞，则是由宿主机的文件系统来管理的，linux下的文件系统可以很好的支持空洞的特性，所以，如果你创建了一个100G的raw格式的文件，ls看的时候，可以看到这个文件是100G的，但是用du 来看，这个文件会很小。


优点
使用 dd 指令创建一个 File 就能够模拟 RAW 镜像文件
性能较 QCOW2 要更高
支持裸设备的原生特性, 例如: 直接挂载
能够随意转换格式, 甚至作为其他两种格式转换时的中间格式
能够使用 dd 指令来追加 RAW 镜像文件的空间



### QCOW

QCOW2(qemu copy on write 2) 格式包含一些特性，包括支持多重快照，占用更小的存储空间（不支持稀疏特性，也就是不会预先分配指定 size 的空间），可选的 AES 加密和可选的 zlib 压缩方式。

qcow2是kvm支持的磁盘镜像格式，我们创建一个100G的qcow2磁盘之后，无论用ls来看，还是du来看，都是很小的。这说明了，qcow2本身会记录一些内部块分配的信息的。

与普通的 raw 格式的镜像相比，有以下特性：

更小的空间占用，即使文件系统不支持空洞(holes)；
支持写时拷贝（COW, copy-on-write），镜像文件只反映底层磁盘的变化；
支持快照（snapshot），镜像文件能够包含多个快照的历史；
可选择基于 zlib 的压缩方式
可以选择 AES 加密

### QED

### COW