前言

Linux常用命令中，有些命令可以用于查看系统的状态，通过了解系统当前的状态，能够帮助我们更好地维护系统或定位问题。本文就简单介绍一下这些命令。

查看系统运行时间，负载--uptime

有时候我们想知道系统上一次复位是在什么时候或者系统已经运行了多长时间，我们可以通过uptime命令获取这些信息：

uptime
20:47:06 up 50 min,  1 user,  load average: 0.75, 0.84, 0.93
从左往右显示的信息依次为：当前时间、已运行时间、用户登录数、1分钟、5分钟和15分钟内系统的平均负载。

查看系统已登录用户--who

who -a
hyb      tty7         2018-09-30 19:57 (:0)
通过who命令可以查看到哪些用户通过哪个ip登录到了这台主机。

查看系统版本相关信息--uname

例如：

uname -a
Linux ubuntu16.04 4.15.0-34-generic #37~16.04.1-Ubuntu SMP Tue Aug 28 10:44:06 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux
从结果可以看到操作系统版本（ubuntu16.04），CPU类型（x86_64）等信息。

查看当前环境变量--export

环境变量影响着程序的运行，因此有时候需要查看当前环境的环境变量：

export
查看目录和文件占用空间--du

du命令直接显示当前目录下每个目录及其文件占用空间。结合--max-depth参数可以指定显示的目录层级。
例如，如果只想显示当前目录下各个目录所占总空间，可以使用:

du -h --max-depth=1 
19M        ./python
9.0M        ./git
321M        ./hexo
17M        ./lua
28K        ./vim
1.4M        ./shell
81M        ./redis
316M        ./books
48M        ./c
810M        .
du -sh     #仅统计当前目录总大小
810M
其中-h表示以易读的单位显示大小，即M，--max-depth=1表明目录层级。通过命令结果，我们可以看到当前目录下各个子目录占用空间大小，以及总空间大小。

查看各挂载点空间--df

例如:

df -h
文件系统        容量  已用  可用 已用% 挂载点
udev            3.9G     0  3.9G    0% /dev
tmpfs           786M  9.5M  776M    2% /run
/dev/sda10       24G  9.8G   13G   45% /
tmpfs           3.9G   43M  3.8G    2% /dev/shm
tmpfs           5.0M  4.0K  5.0M    1% /run/lock
tmpfs           3.9G     0  3.9G    0% /sys/fs/cgroup
/dev/sda11      454M  274M  153M   65% /boot
/dev/sda15       55G  5.2G   47G   10% /home
/dev/sda1       256M   31M  226M   12% /boot/efi
/dev/sda14      4.6G  9.9M  4.4G    1% /tmp
tmpfs           786M   60K  786M    1% /run/user/1000
从结果中，我们可以看到各个挂载点总空间以及可用空间。当磁盘文件占用空间较大时，可能导致系统运行缓慢，因此，可根据该结果进行相应的磁盘清理。

查看内存可用情况--free

free命令可用于显示系统中可用的物理内存，交换区内存以及内核使用的buffer：

free -h
              total        used        free      shared  buff/cache   available
Mem:           7.7G        2.3G        2.6G        268M        2.8G        4.7G
Swap:          7.6G          0B        7.6G
从执行结果可以看到已用内存和空闲内存的情况。同样地，当内存不足时，可能导致程序运行异常或系统卡顿。

查看进程的内存使用情况--pmap

pmap命令用于查看进程内存相关信息：

pmap pid    #pid为进程id，可通过ps命令获取
6030:   ./main
0000000000400000      4K r-x-- main
0000000000600000      4K r---- main
0000000000601000      4K rw--- main
00000000017d2000    132K rw---   [ anon ]
00007fc3843e8000   1792K r-x-- libc-2.23.so
00007fc3845a8000   2048K ----- libc-2.23.so
00007fc3847a8000     16K r---- libc-2.23.so
00007fc3847ac000      8K rw--- libc-2.23.so
00007fc3847ae000     16K rw---   [ anon ]
00007fc3847b2000    152K r-x-- ld-2.23.so
00007fc3849b9000     12K rw---   [ anon ]
00007fc3849d7000      4K r---- ld-2.23.so
00007fc3849d8000      4K rw--- ld-2.23.so
00007fc3849d9000      4K rw---   [ anon ]
00007ffcf2018000    132K rw---   [ stack ]
00007ffcf2175000     12K r----   [ anon ]
00007ffcf2178000      8K r-x--   [ anon ]
ffffffffff600000      4K r-x--   [ anon ]
 total             4356K
我们可以根据进程各部分占用空间情况，来不断优化我们的程序。

查看虚拟内存统计信息--vmstat

vmstat
procs -----------memory---------- ---swap-- -----io---- -system-- ------cpu-----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in   cs us sy id wa st
 1  0      0 2214960 407828 2572148    0    0   126    57  377 1006  8  2 88  2  0
vmstat的输出值能够帮助我们了解当前系统的性能。比如说，如果si（每秒从交换区写到内存的大小）和so（每秒写入交换区的内存大小）的值经常大于0，说明内存可能不够用，因此才需要用到交换空间。再比如说，us（用户进程执行时间百分比）的值比较高时，说明用户进程消耗的CPU资源较多。而wa（IO等待时间百分比）值较高时，说明IO等待情况严重。

查看当前主机的外部IP

curl ifconfig.me
查看网口信息-ifconfig

ifconfig可以用来查看ip地址，网口等信息：

ifconfig -a
查看ip地址--ip

有时候使用ifconfig命令并不一定能够看到所有的ip地址，因此可以使用：

ip addr
查看网络连接状态--netstat

netstat命令可以查看网络连接状态，通常用于诊断网络相关问题。例如查看端口是否被占用，连接是否已经释放，服务是否在监听等等。具体可参考《不可不知的网络命令-netstat》。

查看CPU利用率等-top

top命令可用于查看系统的CPU利用率，内存占用等情况：

top
top - 22:06:11 up 12 min,  1 user,  load average: 0.87, 1.12, 1.02
Tasks: 235 total,   1 running, 180 sleeping,   0 stopped,   0 zombie
%Cpu(s):  6.9 us,  2.1 sy,  0.0 ni, 90.8 id,  0.1 wa,  0.0 hi,  0.1 si,  0.0 st
KiB Mem :  8039576 total,  3106072 free,  2486744 used,  2446760 buff/cache
KiB Swap:  8002556 total,  8002556 free,        0 used.  4804820 avail Mem 

  PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM     TIME+ COMMAND     
 3389 hyb       20   0 1243184 108880  68152 S   6.0  1.4   0:28.70 compiz      
 6414 hyb       20   0 1299428 209808  84204 S   6.0  2.6   0:07.48 chrome      
 4879 hyb       20   0 1670760 270444 127124 S   5.6  3.4   0:32.89 chrome
查看进程间关系--pstree

通过pstree命令可以看到进程间的父子关系，它以树形结构显示这些信息：

pstree
systemd─┬─ModemManager─┬─{gdbus}
        │              └─{gmain}
        ├─NetworkManager─┬─dhclient
        │                ├─dnsmasq
        │                ├─{gdbus}
        │                └─{gmain}
        ├─accounts-daemon─┬─{gdbus}
        │                 └─{gmain}
        ├─acpid
        ├─atd
        ├─avahi-daemon───avahi-daemon
        ├─bluetoothd
        ├─colord─┬─{gdbus}
        │        └─{gmain}
        ├─cron
        ├─cups-browsed─┬─{gdbus}
        │              └─{gmain}
        ├─cupsd───3*[dbus]
        ├─dbus-daemon
        ├─gnome-keyring-d─┬─{gdbus}
        │                 ├─{gmain}
        │                 └─{timer}
(仅显示部分内容)
总结

实际上，前面所提到的很多相关命令信息都是从系统文件中获取的，例如/proc/meminfo保存了内存相关信息，/proc/net/dev保存网络流量相关信息。只是，它们都是静态数值，但是我们可以结合watch命令来动态地观察这些信息，例如：

watch -n 1 cat /proc/meminfo 

watch -n 1 cat /proc/net/dev
上面的命令表示，每隔一秒执行一次cat /proc/meminfo或cat /proc/net/dev，因此我们可以看到内存信息或网卡流量信息在实时刷新。更多内容可参考《Linux中不可错过的信息宝库》。

本文仅介绍这些命令的经典使用，更多使用可通过man 命令查看。通过前面这些系统自带命令，我们可以比较方便地监控系统状态，从而帮助我们维护系统或定位问题。欢迎留言补充或更正。