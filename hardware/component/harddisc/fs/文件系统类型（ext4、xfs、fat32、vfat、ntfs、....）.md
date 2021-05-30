# [文件系统类型（ext4、xfs、fat32、vfat、ntfs、....）](https://www.cnblogs.com/daduryi/p/6619028.html)

## Linux

1、Linux：存在几十个文件系统类型：ext2，ext3，ext4，xfs，brtfs，zfs（man 5 fs可以取得全部文件系统的介绍）

不同文件系统采用不同的方法来管理磁盘空间，各有优劣；文件系统是具体到分区的，所以格式化针对的是分区，**分区格式化**是指采用指定的文件系统类型对分区空间进行登记、索引并建立相应的管理表格的过程。

- ext2具有极快的速度和极小的CPU占用率，可用于硬盘和移动存储设备
- ext3增加日志功能，可回溯追踪
- ext4日志式文件系统，支持1EB（1024*1024TB），最大单文件16TB，支持连续写入可减少文件碎片。rhel6默认文件系统
- xfs可以管理500T的硬盘。rhel7默认文件系统
- brtfs文件系统针对固态盘做优化，
- zfs更新？

 

注：EXT（Extended file system）是延伸文件系统、扩展文件系统，ext1于1992年4月发表，是为linux核心所做的第一个文件系统。

格式化命令：mkfs -t <文件系统类型> <分区设备文件名>

　　　　　　mkfs.xfs /dev/sdb1

man 5 fs可以取得全部文件系统的简要介绍

最大支持文件等信息？

 

## windows

- FAT16：MS—DOS和win95采用的磁盘分区格式，采用16位的文件分配表，只支持2GB的磁盘分区，最大单文件2GB，且磁盘利用率低
- FAT32：**（即Vfat）**采用32位的文件分配表，支持最大分区128GB，最大文件4GB
- NTFS：支持最大分区2TB，最大文件2TB，安全性和稳定性非常好，不易出现文件碎片。

## 其他

- RAMFS：内存文件系统
- ISO 9660：光盘
- NFS：网络文件系统
- SMBAFS/CIFS：支持Samba协议的网络文件系统
- Linux swap：交换分区，用以提供虚拟内存。

 

内容大部分引用王良明、赖国明著作，敬谢！

分类: [linux](https://www.cnblogs.com/daduryi/category/967773.html)