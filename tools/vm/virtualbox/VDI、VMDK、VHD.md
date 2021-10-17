# VDI、VMDK、VHD
## VDI、VMDK、VHD分别有什么区别
虚拟机vm的虚拟机硬盘VDI、VMDK、VHD分别有什么区别？ 

期望能从以下方面对上述格式做个对比：

- 能够使用动态大小调整
- 可以做快照
- 能够以较小代价将我的虚拟机移动到另一个操作系统或者虚拟机。最好能在ubuntu上正常运行。
- 性能

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
raw qcow2 这个好像主要是为KVM虚拟机的
### QED
### COW
### QCOW