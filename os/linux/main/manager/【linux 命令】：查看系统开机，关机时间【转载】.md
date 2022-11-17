# [【linux 命令】：查看系统开机，关机时间【转载】](https://www.cnblogs.com/yingsong/p/6012250.html)

转载原文：http://www.cnblogs.com/kerrycode/p/3759395.html
看Linux开机关机时间的方法（非常全面）

## **1： who 命令查看**

`who -b` 查看最后一次系统启动的时间。

`who -r` 查看当前系统运行时间

``` bash
[root@DB-Server ~]# who -b

​     system boot May 11 09:27
```
## **2： last reboot**
如下所示last reboot可以看到Linux系统历史启动的时间。 重启一下操作系统后，然后

``` bash
[root@DB-Server ~]# last reboot
reboot system boot 2.6.9-42.ELsmp Thu May 29 15:25 (00:07)
reboot system boot 2.6.9-42.ELsmp Sun May 11 09:27 (18+05:55)
wtmp begins Mon May 5 16:18:57 2014
```

如果只需要查看最后一次Linux系统启动的时间
``` bash
[root@DB-Server ~]# last reboot | head -1
reboot system boot 2.6.9-42.ELsmp Thu May 29 15:25 (00:08) 
```
## **3：TOP命令查看**
  如下截图所示，up后表示系统到目前运行了多久时间。反过来推算系统重启时间

![img](https://images2015.cnblogs.com/blog/653177/201611/653177-20161102105157924-1718272086.png)

## **4： w命令查看**

如下截图所示，up后表示系统到目前运行了多久时间。反过来推算系统重启时间
``` bash
[root@TestStation ~]# w
 10:53:19 up 1:20, 2 users, load average: 0.06, 0.01, 0.00
USER   TTY   FROM       LOGIN@  IDLE  JCPU  PCPU WHAT
root   tty1   -        10:22  30:15  0.00s 0.00s -bash
root   pts/0  110.87.109.232  10:34  0.00s 0.01s 0.00s w
```
## **5：uptime 命令查看**
``` bash
[root@TestStation ~]# uptime
 10:54:02 up 1:21, 2 users, load average: 0.02, 0.01, 0.00
```
## **6： 查看/proc/uptime**
``` bash

[root@DB-Server ~]# cat /proc/uptime
1415.59 1401.42
[root@DB-Server ~]# date -d "`cut -f1 -d. /proc/uptime` seconds ago"
Thu May 29 15:24:57 CST 2014
[root@DB-Server ~]# date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S" 
2014-05-29 15:24:57
```
分类: [服务器](https://www.cnblogs.com/yingsong/category/679122.html)

标签: [Linux](https://www.cnblogs.com/yingsong/tag/Linux/)