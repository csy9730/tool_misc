# mdadm

## help
```
admin@DS918Plus:~$ mdadm --help
mdadm is used for building, managing, and monitoring
Linux md devices (aka RAID arrays)
Usage: mdadm --create device options...
            Create a new array from unused devices.
       mdadm --assemble device options...
            Assemble a previously created array.
       mdadm --build device options...
            Create or assemble an array without metadata.
       mdadm --manage device options...
            make changes to an existing array.
       mdadm --misc options... devices
            report on or modify various md related devices.
       mdadm --grow options device
            resize/reshape an active array
       mdadm --incremental device
            add/remove a device to/from an array as appropriate
       mdadm --monitor options...
            Monitor one or more array for significant changes.
       mdadm device options...
            Shorthand for --manage.
Any parameter that does not start with '-' is treated as a device name
or, for --examine-bitmap, a file name.
The first such name is often the name of an md device.  Subsequent
names are often names of component devices.

 For detailed help on the above major modes use --help after the mode
 e.g.
         mdadm --assemble --help
 For general help on options use
         mdadm --help-options

```

### 查看磁盘阵列
```

admin@DS918Plus:~$ sudo mdadm  -D /dev/md3
/dev/md3:
        Version : 1.2
  Creation Time : Sat Jan 30 20:50:55 2021
     Raid Level : raid1
     Array Size : 3902196544 (3721.42 GiB 3995.85 GB)
  Used Dev Size : 3902196544 (3721.42 GiB 3995.85 GB)
   Raid Devices : 1
  Total Devices : 1
    Persistence : Superblock is persistent

    Update Time : Wed Nov 30 10:50:32 2022
          State : clean
 Active Devices : 1
Working Devices : 1
 Failed Devices : 0
  Spare Devices : 0

           Name : DS918Plus:3  (local to host DS918Plus)
           UUID : 88770d30:53658a85:e137236f:2ddefd79
         Events : 126

    Number   Major   Minor   RaidDevice State
       0       8       67        0      active sync   /dev/sde3
```

2
```
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
       