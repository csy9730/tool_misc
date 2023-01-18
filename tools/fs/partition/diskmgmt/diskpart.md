# diskpart


diskpart.exe是命令行工具，diskmgmt.msc 是可视化工具，两者功能接近。
位于C:\Windows\System32\diskpart.exe。

该工具可以显示/转换/创建/删除等管理：磁盘/基本卷/分区。

## help

```

Microsoft DiskPart 版本 10.0.18362.1

Copyright (C) Microsoft Corporation.
在计算机上: DESKTOP-PGE4SMB

DISKPART> help

Microsoft DiskPart 版本 10.0.18362.1

ACTIVE      - 将选中的分区标记为活动的分区。
ADD         - 将镜像添加到一个简单卷。
ASSIGN      - 给所选卷分配一个驱动器号或装载点。
ATTRIBUTES  - 操纵卷或磁盘属性。
ATTACH      - 连接虚拟磁盘文件。
AUTOMOUNT   - 启用和禁用基本卷的自动装载。
BREAK       - 中断镜像集。
CLEAN       - 从磁盘清除配置信息或所有信息。
COMPACT     - 尝试减少文件的物理大小。
CONVERT     - 在不同的磁盘格式之间转换。
CREATE      - 创建卷、分区或虚拟磁盘。
DELETE      - 删除对象。
DETAIL      - 提供对象详细信息。
DETACH      - 分离虚拟磁盘文件。
EXIT        - 退出 DiskPart。
EXTEND      - 扩展卷。
EXPAND      - 扩展虚拟磁盘上可用的最大大小。
FILESYSTEMS - 显示卷上当前和支持的文件系统
FORMAT      - 格式化卷或分区
GPT         - 给选择的 GPT 分区分配属性。
HELP        - 显示命令列表。
IMPORT      - 导入磁盘组。
INACTIVE    - 将所选分区标为不活动。
LIST        - 显示对象列表。
MERGE       - 将子磁盘与其父磁盘合并。
ONLINE      - 使当前标为脱机的对象联机。
OFFLINE     - 使当前标记为联机的对象脱机。
RECOVER     - 刷新所选包中所有磁盘的状态。
              尝试恢复无效包中的磁盘，并
              重新同步具有过时丛或奇偶校验数据
              的镜像卷和 RAID5 卷。
REM         - 不起任何作用。用来注释脚本。
REMOVE      - 删除驱动器号或装载点分配。
REPAIR      - 用失败的成员修复一个 RAID-5 卷。
RESCAN      - 重新扫描计算机，查找磁盘和卷。
RETAIN      - 在一个简单卷下放置一个保留分区。
SAN         - 显示或设置当前启动的操作系统的 SAN 策略。
SELECT      - 将焦点移动到对象。
SETID       - 更改分区类型。
SHRINK      - 减小选定卷。
UNIQUEID    - 显示或设置磁盘的 GUID 分区表(GPT)标识符或
              主启动记录(MBR)签名。
```
### list 
```
DISKPART> list

Microsoft DiskPart 版本 10.0.18362.1

DISK        - 显示磁盘列表。例如，LIST DISK。
PARTITION   - 显示所选磁盘上的分区列表。
              例如，LIST PARTITION。
VOLUME      - 显示卷列表。例如，LIST VOLUME。
VDISK       - 显示虚拟磁盘列表。
```

#### list disk
```
DISKPART> list disk 

  磁盘 ###  状态           大小     可用     Dyn  Gpt
  --------  -------------  -------  -------  ---  ---
  磁盘 0    联机              111 GB      0 B        *
  磁盘 1    联机              465 GB  3072 KB
  磁盘 2    联机              931 GB  3072 KB
  磁盘 3    联机              465 GB   465 GB        *
```
#### select

```

DISKPART> select

Microsoft DiskPart 版本 10.0.18362.1

DISK        - 将焦点移动到磁盘。例如，SELECT DISK。
PARTITION   - 将焦点移动到分区。例如，SELECT PARTITION。
VOLUME      - 将焦点移动到卷。例如，SELECT VOLUME。
VDISK       - 将焦点转移到虚拟磁盘。例如，SELECT VDISK。

DISKPART> select disk

为此命令指定的参数无效。
有关此命令类型的详细信息，请使用 HELP SELECT DISK 命令

没有选择磁盘。


```

#### list partition
```
SELECT
DISKPART> list partition

没有选择要列出分区的磁盘。
选择一个磁盘，再试一次。
DISKPART> select disk 0

磁盘 0 现在是所选磁盘。

DISKPART> list partition

  分区 ###       类型              大小     偏移量
  -------------  ----------------  -------  -------
  分区      1    恢复                 529 MB  1024 KB
  分区      2    系统                 100 MB   530 MB
  分区      3    保留                  16 MB   630 MB
  分区      4    主要                  69 GB   646 MB
  分区      5    系统                 191 MB    69 GB
  分区      6    未知                4663 MB    69 GB
  分区      7    未知                  37 GB    74 GB

```
#### list volume
```
DISKPART> list volume

  卷 ###      LTR  标签         FS     类型        大小     状态       信息
  ----------  ---  -----------  -----  ----------  -------  ---------  --------
  卷     0     D                NTFS   磁盘分区          69 GB  正常
  卷     1                      FAT32  磁盘分区         100 MB  正常         已隐藏
  卷     2                      FAT32  磁盘分区         191 MB  正常         已隐藏
  卷     3     C                NTFS   磁盘分区         220 GB  正常         系统
  卷     4     H   软件           NTFS   磁盘分区         245 GB  正常
  卷     5     E   系统           NTFS   磁盘分区         500 GB  正常
  卷     6     I   软件           NTFS   磁盘分区         431 GB  正常

DISKPART>
```
#### list vdisk
vdisk 不能显示 raiddrive挂载的网络硬盘。


#### convert
```
DISKPART> CONVERT

Microsoft DiskPart 版本 10.0.18362.1

BASIC       - 将磁盘从动态转更换为基本。
DYNAMIC     - 将磁盘从基本转更换为动态。
GPT         - 将磁盘从 MBR 转更换为 GPT。
MBR         - 将磁盘从 GPT 转更换为 MBR。
```


#### exFAT转换成FAT32
exFAT转换成FAT32
步骤1. 在搜索框中输入cmd并以管理员身份运行命令提示符。

步骤2. 依次输入以下命令，并在每一行命令后按一次Enter键执行即可将exFAT格式化成FAT32。
`diskpart`

```
list volume
select volume #（#指的是您想要转换的驱动器卷号）
clean
create partition primary size=32000
format fs=fat32 quick（如果您想要将其转换为NTFS文件系统，也可以将fat32更改为ntfs）
```

出现错误：
设备 \Device\Harddisk4\DR23 有一个不正确的区块。

如何处理？



#### FAT32转NTFS
只限于FAT32转NTFS
`convert F: /fs:ntfs`
## misc

fsck（file system check）是linux工具，用来检查和维护不一致的文件系统。若系统掉电或磁盘发生问题，可利用fsck命令对文件系统进行检查. 