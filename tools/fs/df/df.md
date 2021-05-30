# df


```
(base) ➜  ~ df --help
Usage: df [OPTION]... [FILE]...
Show information about the file system on which each FILE resides,
or all file systems by default.

Mandatory arguments to long options are mandatory for short options too.
  -a, --all             include pseudo, duplicate, inaccessible file systems
  -B, --block-size=SIZE  scale sizes by SIZE before printing them; e.g.,
                           '-BM' prints sizes in units of 1,048,576 bytes;
                           see SIZE format below
  -h, --human-readable  print sizes in powers of 1024 (e.g., 1023M)
  -H, --si              print sizes in powers of 1000 (e.g., 1.1G)
  -i, --inodes          list inode information instead of block usage
  -k                    like --block-size=1K
  -l, --local           limit listing to local file systems
      --no-sync         do not invoke sync before getting usage info (default)
      --output[=FIELD_LIST]  use the output format defined by FIELD_LIST,
                               or print all fields if FIELD_LIST is omitted.
  -P, --portability     use the POSIX output format
      --sync            invoke sync before getting usage info
      --total           elide all entries insignificant to available space,
                          and produce a grand total
  -t, --type=TYPE       limit listing to file systems of type TYPE
  -T, --print-type      print file system type
  -x, --exclude-type=TYPE   limit listing to file systems not of type TYPE
  -v                    (ignored)
      --help     display this help and exit
      --version  output version information and exit

Display values are in units of the first available SIZE from --block-size,
and the DF_BLOCK_SIZE, BLOCK_SIZE and BLOCKSIZE environment variables.
Otherwise, units default to 1024 bytes (or 512 if POSIXLY_CORRECT is set).

The SIZE argument is an integer and optional unit (example: 10K is 10*1024).
Units are K,M,G,T,P,E,Z,Y (powers of 1024) or KB,MB,... (powers of 1000).

FIELD_LIST is a comma-separated list of columns to be included.  Valid
field names are: 'source', 'fstype', 'itotal', 'iused', 'iavail', 'ipcent',
'size', 'used', 'avail', 'pcent', 'file' and 'target' (see info page).

GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
Full documentation at: <http://www.gnu.org/software/coreutils/df>
or available locally via: info '(coreutils) df invocation'
```



## demo

```
(base) ➜  ~ df -h
Filesystem      Size  Used Avail Use% Mounted on
udev            7.8G     0  7.8G   0% /dev
tmpfs           1.6G  3.5M  1.6G   1% /run
/dev/nvme0n1p7   37G   32G  3.3G  91% /
tmpfs           7.8G     0  7.8G   0% /dev/shm
tmpfs           5.0M  4.0K  5.0M   1% /run/lock
tmpfs           7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/loop0      2.3M  2.3M     0 100% /snap/gnome-system-monitor/148
/dev/loop1      141M  141M     0 100% /snap/gnome-3-26-1604/100
/dev/loop2      100M  100M     0 100% /snap/core/10958
/dev/loop4       65M   65M     0 100% /snap/gtk-common-themes/1514
/dev/loop3      219M  219M     0 100% /snap/gnome-3-34-1804/66
/dev/loop5      163M  163M     0 100% /snap/gnome-3-28-1804/145
/dev/loop6      2.3M  2.3M     0 100% /snap/gnome-system-monitor/157
/dev/loop7      384K  384K     0 100% /snap/gnome-characters/570
/dev/loop8      2.5M  2.5M     0 100% /snap/gnome-calculator/826
/dev/loop9       56M   56M     0 100% /snap/core18/1997
/dev/loop10     274M  274M     0 100% /snap/wps-office-multilang/1
/dev/loop11     141M  141M     0 100% /snap/gnome-3-26-1604/102
/dev/loop12     384K  384K     0 100% /snap/gnome-characters/708
/dev/loop13     218M  218M     0 100% /snap/gnome-3-34-1804/60
/dev/loop14     640K  640K     0 100% /snap/gnome-logs/103
/dev/loop15     162M  162M     0 100% /snap/gnome-3-28-1804/128
/dev/loop16     2.5M  2.5M     0 100% /snap/gnome-calculator/884
/dev/loop17     1.0M  1.0M     0 100% /snap/gnome-logs/100
/dev/loop18      66M   66M     0 100% /snap/gtk-common-themes/1515
/dev/nvme0n1p5  1.9G  116M  1.7G   7% /boot
/dev/sdb2       458G  409G   26G  95% /home
tmpfs           1.6G   80K  1.6G   1% /run/user/1000
/dev/nvme0n1p1  178G  143G   36G  81% /media/zal/241450D61450AD14
/dev/sda1       932G  194G  738G  21% /media/zal/data
/dev/sdb5       466G  385G   82G  83% /media/zal/软件
/dev/loop21      99M   99M     0 100% /snap/core/11081
/dev/loop19      56M   56M     0 100% /snap/core18/2066
/dev/sdc4        29G   16G   14G  53% /media/zal/Ubuntu 18.0
```


tmpfs 对应什么？
/dev/nvme0n1 
/dev/loopx  
/dev/sdb2 
/dev/sda1
/dev/sdb2 
/dev/sdb5 
/dev/sdc4 


## /proc/partitions
```

major minor  #blocks  name

   7        0       2220 loop0
   7        1     144032 loop1
   7        2     101528 loop2
   7        3     224248 loop3
   7        4      66324 loop4
   7        5     166776 loop5
   7        6       2288 loop6
   7        7        276 loop7
 259        0  244198584 nvme0n1
 259        1  186525696 nvme0n1p1
 259        2          1 nvme0n1p2
 259        3    1998848 nvme0n1p5
 259        4   15998976 nvme0n1p6
 259        5   39670784 nvme0n1p7
   8        0  976762584 sda
   8        1  976759808 sda1
   8       16  976762584 sdb
   8       17          1 sdb1
   8       18  488262656 sdb2
   8       21  488496352 sdb5
   7        8       2540 loop8
   7        9      56780 loop9
   7       10     280480 loop10
   7       11     144036 loop11
   7       12        276 loop12
   7       13     223124 loop13
   7       14        548 loop14
   7       15     165288 loop15
   7       16       2544 loop16
   7       17        956 loop17
   7       18      66660 loop18
   7       19      56752 loop19
   7       21     101340 loop21
   8       32   30218746 sdc
   8       36   30218618 sdc4

```

## x;jiwonq
```
admin@DS918Plus:~$ cat /proc/partitions
major minor  #blocks  name

   1        0     655360 ram0
   1        1     655360 ram1
   1        2     655360 ram2
   1        3     655360 ram3
   1        4     655360 ram4
   1        5     655360 ram5
   1        6     655360 ram6
   1        7     655360 ram7
   1        8     655360 ram8
   1        9     655360 ram9
   1       10     655360 ram10
   1       11     655360 ram11
   1       12     655360 ram12
   1       13     655360 ram13
   1       14     655360 ram14
   1       15     655360 ram15
   8       16   15638616 sdb
   8       17    2490240 sdb1
   8       18    2097152 sdb2
   8       19      65536 sdb3
   8       20      64512 sdb4
   8       21    9859072 sdb5
   8       64 3907018584 sde
   8       65    2490240 sde1
   8       66    2097152 sde2
   8       67 3902197584 sde3
   8       80 3907018584 sdf
   8       81    2490240 sdf1
   8       82    2097152 sdf2
   8       85 3902188480 sdf5
   9        0    2490176 md0
   9        1    2097088 md1
 251        0     590848 zram0
 251        1     590848 zram1
 251        2     590848 zram2
 251        3     590848 zram3
   9        2    9858048 md2
   9        3 3902196544 md3
   9        4 3902187456 md4
 252        0      12288 dm-0
 252        1 3902173184 dm-1
 ```

猜测对应星际蜗牛
- sda 对应？
- sdb 对应msata
- sdc 对应硬盘位1
- sdd 对应硬盘位2
- sde 对应硬盘位3
- sdf 对应硬盘位4
- md0
- md1
- md2
- md3
- md4
- /dev/ramX


```
admin@DS918Plus:~$ cat /proc/partitions
Filesystem         Size  Used Avail Use% Mounted on
/dev/md0           2.3G 1019M  1.2G  46% /
none               1.9G     0  1.9G   0% /dev
/tmp               1.9G  868K  1.9G   1% /tmp
/run               1.9G  3.9M  1.9G   1% /run
/dev/shm           1.9G  4.0K  1.9G   1% /dev/shm
none               4.0K     0  4.0K   0% /sys/fs/cgroup
cgmfs              100K     0  100K   0% /run/cgmanager/fs
/dev/md2           9.2G  334M  8.7G   4% /volume1
/dev/vg1/volume_3  3.5T   18M  3.5T   1% /volume3
/dev/md3           3.5T   34G  3.5T   1% /volume2
```


### fdisk -l
```
sudo fdisk -l
Password:
Disk /dev/ram0: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram1: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram2: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram3: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram4: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram5: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram6: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram7: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram8: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram9: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram10: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram11: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram12: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram13: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram14: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/ram15: 640 MiB, 671088640 bytes, 1310720 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/sdb: 14.9 GiB, 16013942784 bytes, 31277232 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: A75F353C-7518-4301-95CD-5E36654842DB

Device       Start      End  Sectors  Size Type
/dev/sdb1     2048  4982527  4980480  2.4G Linux RAID
/dev/sdb2  4982528  9176831  4194304    2G Linux RAID
/dev/sdb3  9177088  9308159   131072   64M EFI System
/dev/sdb4  9308160  9437183   129024   63M Linux filesystem
/dev/sdb5  9437184 29155327 19718144  9.4G Linux RAID


Disk /dev/sde: 3.7 TiB, 4000787030016 bytes, 7814037168 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 5F1B53C2-D766-49DD-AC4F-940E78412E72

Device       Start        End    Sectors  Size Type
/dev/sde1     2048    4982527    4980480  2.4G Linux RAID
/dev/sde2  4982528    9176831    4194304    2G Linux RAID
/dev/sde3  9437184 7813832351 7804395168  3.6T Linux RAID


Disk /dev/sdf: 3.7 TiB, 4000787030016 bytes, 7814037168 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: BB232D9A-5487-4531-84B0-EFEBF39E1AED

Device       Start        End    Sectors  Size Type
/dev/sdf1     2048    4982527    4980480  2.4G Linux RAID
/dev/sdf2  4982528    9176831    4194304    2G Linux RAID
/dev/sdf5  9453280 7813830239 7804376960  3.6T Linux RAID


Disk /dev/md0: 2.4 GiB, 2549940224 bytes, 4980352 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/md1: 2 GiB, 2147418112 bytes, 4194176 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/zram0: 577 MiB, 605028352 bytes, 147712 sectors
Units: sectors of 1 * 4096 = 4096 bytes
Sector size (logical/physical): 4096 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/zram1: 577 MiB, 605028352 bytes, 147712 sectors
Units: sectors of 1 * 4096 = 4096 bytes
Sector size (logical/physical): 4096 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/zram2: 577 MiB, 605028352 bytes, 147712 sectors
Units: sectors of 1 * 4096 = 4096 bytes
Sector size (logical/physical): 4096 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/zram3: 577 MiB, 605028352 bytes, 147712 sectors
Units: sectors of 1 * 4096 = 4096 bytes
Sector size (logical/physical): 4096 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/md2: 9.4 GiB, 10094641152 bytes, 19716096 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/md3: 3.6 TiB, 3995849261056 bytes, 7804393088 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/md4: 3.6 TiB, 3995839954944 bytes, 7804374912 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/mapper/vg1-syno_vg_reserved_area: 12 MiB, 12582912 bytes, 24576 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes


Disk /dev/mapper/vg1-volume_3: 3.6 TiB, 3995825340416 bytes, 7804346368 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
admin@DS918Plus:~$
```



Disk /dev/sdb: 14.9 GiB, 16013942784 bytes, 31277232 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: A75F353C-7518-4301-95CD-5E36654842DB

Device       Start      End  Sectors  Size Type
/dev/sdb1     2048  4982527  4980480  2.4G Linux RAID
/dev/sdb2  4982528  9176831  4194304    2G Linux RAID
/dev/sdb3  9177088  9308159   131072   64M EFI System
/dev/sdb4  9308160  9437183   129024   63M Linux filesystem
/dev/sdb5  9437184 29155327 19718144  9.4G Linux RAID



Disk /dev/sde: 3.7 TiB, 4000787030016 bytes, 7814037168 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: 5F1B53C2-D766-49DD-AC4F-940E78412E72

Device       Start        End    Sectors  Size Type
/dev/sde1     2048    4982527    4980480  2.4G Linux RAID
/dev/sde2  4982528    9176831    4194304    2G Linux RAID
/dev/sde3  9437184 7813832351 7804395168  3.6T Linux RAID


Disk /dev/sdf: 3.7 TiB, 4000787030016 bytes, 7814037168 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 4096 bytes
I/O size (minimum/optimal): 4096 bytes / 4096 bytes
Disklabel type: gpt
Disk identifier: BB232D9A-5487-4531-84B0-EFEBF39E1AED

Device       Start        End    Sectors  Size Type
/dev/sdf1     2048    4982527    4980480  2.4G Linux RAID
/dev/sdf2  4982528    9176831    4194304    2G Linux RAID
/dev/sdf5  9453280 7813830239 7804376960  3.6T Linux RAID