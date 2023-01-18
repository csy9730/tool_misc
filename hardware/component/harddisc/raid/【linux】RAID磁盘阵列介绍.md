# 【linux】RAID磁盘阵列介绍

[![极客Linux](https://pic1.zhimg.com/v2-35f759eb8153412b9e026cd8d867ae89_l.jpg?source=172ae18b)](https://www.zhihu.com/people/xue-xi-jia-you-jia-you-jia-qin-fen)

[极客Linux](https://www.zhihu.com/people/xue-xi-jia-you-jia-you-jia-qin-fen)

公众号《极客运维之家》

## **领取计算机相关资料请关注《极客运维之家》公众号**

**文章目录** 回顾： raid1原理： 实验内容： 1)创建分区 2）创建raid1 3) 将RAID1信息保存到配置文件中 4）检查我们的磁盘阵列 5） 在raid设备上创建文件系统并挂载 6) 创建测试文件，看如果一块磁盘坏掉，数据是否丢失 7） 模拟损坏（sdd1盘坏掉了） 8） 移除坏掉的设备，同时另外加一个备份盘 9） 增加一块热备盘 总结：

## 回顾：

### raid1原理：

RAID-1 ：mirroring（镜像卷）需要磁盘两块以上 原理:是把一个磁盘的数据镜像到另一个磁盘上，也就是说数据在写入一块磁盘的同时，会在另一块闲置的磁盘上生成镜像文件，(同步) 特性:当一块硬盘失效时，系统会忽略该硬盘，转而使用剩余的镜像盘读写数据，具备很好的磁盘冗余能力。

磁盘利用率为50%，即2块100G的磁盘构成RAID1只能提供100G的可用空间。

## 实验内容：

1. 创建raid1
2. 添加一个G的热备盘
3. 模拟磁盘故障，自动顶替故障
4. 卸载阵列

### 1)创建分区

```bash
fdisk /dev/sdd

[root@centos7-xinsz08 ~]# ll /dev/sdd*
brw-rw----. 1 root disk 8, 48 2月  27 16:22 /dev/sdd
brw-rw----. 1 root disk 8, 49 2月  27 16:22 /dev/sdd1
brw-rw----. 1 root disk 8, 50 2月  27 16:22 /dev/sdd2
brw-rw----. 1 root disk 8, 51 2月  27 16:22 /dev/sdd3
brw-rw----. 1 root disk 8, 52 2月  27 16:22 /dev/sdd4
`
```

### 2）创建raid1

```bash
[root@centos7-xinsz08 ~]# mdadm -C -v /dev/md2  -l 1 -n 2 -x 1 /dev/sdd1 /dev/sdd[2,3]
mdadm: Note: this array has metadata at the start and
    may not be suitable as a boot device.  If you plan to
    store '/boot' on this device please ensure that
    your boot-loader understands md/v1.x metadata, or use
    --metadata=0.90
mdadm: size set to 3140608K
mdadm: largest drive (/dev/sdd1) exceeds size (3140608K) by more than 1%
Continue creating array? y
mdadm: Defaulting to version 1.2 metadata
mdadm: array /dev/md2 started.
```

### 3) 将RAID1信息保存到配置文件中

[root@centos7-xinsz08 ~]# mdadm -Dsv > /etc/mdadm.conf

### 4）检查我们的磁盘阵列

```bash
[root@centos7-xinsz08 ~]# mdadm  -D /dev/md2
/dev/md2:    //设备名
           Version : 1.2
     Creation Time : Thu Feb 27 16:24:39 2020   .//创建时间
        Raid Level : raid1
        Array Size : 3140608 (3.00 GiB 3.22 GB)
     Used Dev Size : 3140608 (3.00 GiB 3.22 GB)
      Raid Devices : 2
     Total Devices : 3
       Persistence : Superblock is persistent

       Update Time : Thu Feb 27 16:25:01 2020
             State : clean 
    Active Devices : 2    //当前活动设备
   Working Devices : 3    .//工作设备
    Failed Devices : 0    // 失效设备
     Spare Devices : 1    //热备盘的数量

Consistency Policy : resync

              Name : centos7-xinsz08:2  (local to host centos7-xinsz08)
              UUID : 5e197fe2:5c51970e:5e5288d5:e9066eb4
            Events : 17

    Number   Major   Minor   RaidDevice State
       0       8       49        0      active sync   /dev/sdd1
       1       8       50        1      active sync   /dev/sdd2

       2       8       51        -      spare   /dev/sdd3
```

### 5） 在raid设备上创建文件系统并挂载

```bash
[root@centos7-xinsz08 ~]# mkfs.xfs /dev/md2
meta-data=/dev/md2               isize=512    agcount=4, agsize=196288 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=0, sparse=0
data     =                       bsize=4096   blocks=785152, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0 ftype=1
log      =internal log           bsize=4096   blocks=2560, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =none                   extsz=4096   blocks=0, rtextents=0
[root@centos7-xinsz08 ~]# mkdir /raid1
[root@centos7-xinsz08 ~]# mount /dev/md2 /raid1/
[root@centos7-xinsz08 ~]# df -h |  tail -1
/dev/md2                 3.0G   33M  3.0G    2% /raid1
```

### 6) 创建测试文件，看如果一块磁盘坏掉，数据是否丢失

```bash
[root@centos7-xinsz08 raid1]# touch a.txt
[root@centos7-xinsz08 raid1]# echo "磁盘坏了，我也在" >a.txt
```

### 7） 模拟损坏（sdd1盘坏掉了）

```bash
[root@centos7-xinsz08 raid1]# mdadm /dev/md2 -f /dev/sdd1
mdadm: set /dev/sdd1 faulty in /dev/md2

[root@centos7-xinsz08 raid1]# mdadm  -D /dev/md2
/dev/md2:
           Version : 1.2
     Creation Time : Thu Feb 27 16:24:39 2020
        Raid Level : raid1
        Array Size : 3140608 (3.00 GiB 3.22 GB)
     Used Dev Size : 3140608 (3.00 GiB 3.22 GB)
      Raid Devices : 2
     Total Devices : 3
       Persistence : Superblock is persistent

       Update Time : Thu Feb 27 16:31:48 2020
             State : clean, degraded, recovering 
    Active Devices : 1
   Working Devices : 2
    Failed Devices : 1
     Spare Devices : 1

Consistency Policy : resync

    Rebuild Status : 88% complete

              Name : centos7-xinsz08:2  (local to host centos7-xinsz08)
              UUID : 5e197fe2:5c51970e:5e5288d5:e9066eb4
            Events : 35

    Number   Major   Minor   RaidDevice State
       2       8       51        0      spare rebuilding   /dev/sdd3
       1       8       50        1      active sync   /dev/sdd2

       0       8       49        -      faulty   /dev/sdd1
```

测试移除之后文件是否还在

```bash
[root@centos7-xinsz08 raid1]# cat /raid1/a.txt 
磁盘坏了，我也在
```

### 8） 移除坏掉的设备，同时另外加一个备份盘

~~~bash
[root@centos7-xinsz08 raid1]# mdadm  -r /dev/md2 /dev/sdd1
mdadm: hot removed /dev/sdd1 from /dev/md2
``
查看是否移除

```bash
[root@centos7-xinsz08 raid1]# mdadm -D /dev/md2
/dev/md2:
           Version : 1.2
     Creation Time : Thu Feb 27 16:24:39 2020
        Raid Level : raid1
        Array Size : 3140608 (3.00 GiB 3.22 GB)
     Used Dev Size : 3140608 (3.00 GiB 3.22 GB)
      Raid Devices : 2
     Total Devices : 2
       Persistence : Superblock is persistent

       Update Time : Thu Feb 27 16:34:10 2020
             State : clean 
    Active Devices : 2
   Working Devices : 2
    Failed Devices : 0
     Spare Devices : 0

Consistency Policy : resync

              Name : centos7-xinsz08:2  (local to host centos7-xinsz08)
              UUID : 5e197fe2:5c51970e:5e5288d5:e9066eb4
            Events : 39

    Number   Major   Minor   RaidDevice State
       2       8       51        0      active sync   /dev/sdd3
       1       8       50        1      active sync   /dev/sdd2
~~~

### 9） 增加一块热备盘

mdadm -a /dev/md2 /dev/sdb4

## 总结：

1. raid1中一块硬盘坏了不影响raid正常运行
2. 使用率是50%







发布于 2021-10-27 13:56

[磁盘阵列](https://www.zhihu.com/topic/19744182)

[RAID](https://www.zhihu.com/topic/19631084)

[Linux](https://www.zhihu.com/topic/19554300)