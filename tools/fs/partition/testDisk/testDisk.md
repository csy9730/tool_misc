# TestDisk


[https://www.cgsecurity.org/wiki/TestDisk_Download](https://www.cgsecurity.org/wiki/TestDisk_Download)

TestDisk and the other utilities are, and will remain, free software. I am a strong believer in the free/GPL software concept.

Any time spent on TestDisk and the other utilities is time I am not doing paid work for something else, and sometimes that's a lot of time! This includes continuing development as well as answering queries and providing support to current and prospective users.

Therefore if you've used TestDisk, PhotoRec and the other utilities and have found them useful, and maybe feel like giving something back and contributing to the cause then please feel free to click on one of the links below.


[TestDisk](https://www.cgsecurity.org/) 是一款开源软件，受[GNU General Public License](https://www.gnu.org/licenses/gpl.html) (GPL v2+)条款保护.

**TestDisk** 是一款强大的免费数据恢复软件! 早期主要是设计用来在使用有缺陷的软件，病毒或人为误操作（如不小心删除分区表）导致的分区丢失后，帮助用户恢复丢失分区，或修复不能启动的磁盘。 用Testdisk来恢复分区表非常简单。

TestDisk支持以下功能:

- 修复分区表, 恢复已删除分区
- 用FAT32备份表恢复启动扇区
- 重建FAT12/FAT16/FAT32启动扇区
- 修复FAT表
- 重建NTFS启动扇区
- 用备份表恢复NTFS启动扇区
- 用MFT镜像表(MFT Mirror)修复MFT表
- 查找ext2/ext3/ext4备份的SuperBlock
- 从FAT,NTFS及ext2文件系统恢复删除文件
- 从已删除的FAT,NTFS及ext2/ext3/ext4分区复制文件.

TestDisk拥有两种模式：新手模式和专家模式。对于那些对数据恢复技巧了解很少，甚至完全一无所知的人来说，Testdisk可用于收集非启动分区的详细信息，后续再发送给专业数据恢复人员进一步分析。 对于那些对数据恢复较为熟悉的人员来说, Testdisk是一款现场非常容易操作的数据恢复工具。

## 操作系统

**TestDisk 可以在以下系统平台下运行:**

- DOS (*实模式* 或Windows 9x DOS模式)
- Windows (NT4, 2000, XP, 2003, Vista)
- Linux
- FreeBSD, NetBSD, OpenBSD
- SunOS
- MacOS

可从 [下载](https://www.cgsecurity.org/wiki/TestDisk_Download) 页面下载源代码和预编译的二进制可执行文件(适用于DOS, Win32, MacOSX 及Linux平台)

## 支持的文件系统

TestDisk 可恢复以下文件系统的丢失分区:

- BeFS ( BeOS )
- BSD disklabel ( FreeBSD/OpenBSD/NetBSD )
- CramFS, 压缩文件系统
- DOS/Windows FAT12, FAT16 和 FAT32
- Windows exFAT
- HFS, HFS+ 和 HFSX (Hierarchical File System)
- JFS (IBM's Journaled File System)
- Linux ext2, ext3 和ext4
- Linux LUKS 加密分区
- Linux RAID md 0.9/1.0/1.1/1.2
  - RAID 1: 镜像(Mirror)
  - RAID 4: 带容错的条带阵列
  - RAID 5: 带分布式冗余信息的条带阵列
  - RAID 6: 带分布式双冗余信息的条带阵列
- Linux Swap (版本1 和 2)
- LVM 和 LVM2, Linux逻辑卷管理器(Linux Logical Volume Manager)
- Mac partition map
- Novel NSS (Novell Storage Services)
- NTFS ( Windows NT/2000/XP/2003/Vista/2008 )
- ReiserFS 3.5, 3.6 和 4
- Sun Solaris i386 disklabel
- Unix文件系统-UFS and UFS2 (Sun/BSD/...)
- XFS, SGI's Journaled File System

## 文档帮助

- 如何获得Testdisk
  - [![Download.png](https://www.cgsecurity.org/mw/images/thumb/Download.png/32px-Download.png)](https://www.cgsecurity.org/wiki/TestDisk_Download) [下载](https://www.cgsecurity.org/wiki/TestDisk_Download) - 二进制可执行文件和源代码适用于DOS, Win32, MacOSX和Linux平台.
  - [TestDisk如何编译](https://www.cgsecurity.org/wiki/TestDisk_Compilation)
  - [TestDisk及数据恢复启动光盘](https://www.cgsecurity.org/wiki/TestDisk_Livecd)
- 支持特别的介质
  - [恢复已损坏的硬盘(有坏扇区)](https://www.cgsecurity.org/wiki/Damaged_Hard_Disk)
  - [磁盘镜像(如E01)](https://www.cgsecurity.org/wiki/Media_Image)
  - [CD-R/CR-RW/DVD...](https://www.cgsecurity.org/wiki/CDRW)
- 使用Testdisk
  - [支持的操作系统](https://www.cgsecurity.org/wiki/OS_Notes)
  - [TestDisk 操作指南](https://www.cgsecurity.org/wiki/TestDisk_Step_By_Step) 恢复丢失分区及修复损坏的FAT/NTFS启动扇区
  - [如何运行](https://www.cgsecurity.org/wiki/Running_TestDisk)
  - [从NTFS分区恢复已删除文件](https://www.cgsecurity.org/wiki/Undelete_files_from_NTFS_with_TestDisk)
  - [从FAT12/FAT16/FAT32文件系统恢复文件和文件夹](https://www.cgsecurity.org/wiki/TestDisk:_undelete_file_for_FAT)
  - [从ext2文件系统中恢复已删除文件](https://www.cgsecurity.org/wiki/TestDisk:_undelete_file_for_ext2)
  - [使用范例](https://www.cgsecurity.org/wiki/使用范例)
  - [脚本模式运行](https://www.cgsecurity.org/wiki/Scripted_run)
  - [技术支持](https://www.cgsecurity.org/wiki/Support)
- [使用Testdisk之后的后续操作](https://www.cgsecurity.org/wiki/After_using_TestDisk)
- 技术参考
  - [Intel 分区表](https://www.cgsecurity.org/wiki/Intel_Partition_Table)
  - [Microsoft Fdisk](https://www.cgsecurity.org/wiki/Microsoft_Fdisk)
  - [SMART](https://www.cgsecurity.org/wiki/SMART_Monitoring) SMART监控
  - Norton [GoBack](https://www.cgsecurity.org/wiki/GoBack)
  - [当前软件使用限制说明](https://www.cgsecurity.org/wiki/Current_Limitations)
- [如何协助参与该项目](https://www.cgsecurity.org/wiki/HowToHelp)
- [TestDisk & PhotoRec 最新动态](https://www.cgsecurity.org/wiki/In_The_News)
- [Testdisk开发团队](https://www.cgsecurity.org/wiki/TestDisk_Team)

要从数码相机或硬盘中恢复丢失的图片或文件，请运行[PhotoRec](https://www.cgsecurity.org/wiki/PhotoRec) 命令.

------

TestDisk主页: [https://www.cgsecurity.org](https://www.cgsecurity.org/).
Christophe GRENIER [grenier@cgsecurity.org](mailto:grenier@cgsecurity.org)

翻译及软件汉化：小黑子 (Henry Xu) [xiaoheizi2000@gmail.com](mailto:xiaoheizi2000@gmail.com)

Category

:

 

- [Data Recovery](https://www.cgsecurity.org/wiki/Category:Data_Recovery)