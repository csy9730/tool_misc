# [Linux查看系统开机时间（转）](https://www.cnblogs.com/EasonJim/p/8169304.html)

**1、who命令查看**

`who -b`查看最后一次系统启动的时间。

`who -r`查看当前系统运行时间

**2、last reboot**

last reboot可以看到Linux系统历史启动的时间。 重启一下操作系统后，然后

```
last reboot
reboot system boot 2.6.9-42.ELsmp Thu May 29 15:25 (00:07)
reboot system boot 2.6.9-42.ELsmp Sun May 11 09:27 (18+05:55)
wtmp begins Mon May 5 16:18:57 2014
```

如果只需要查看最后一次Linux系统启动的时间 

```
last reboot | head -1
reboot system boot 2.6.9-42.ELsmp Thu May 29 15:25 (00:08) 
```

**3、top命令查看**

左上角up后表示系统到目前运行了多久时间。反过来推算系统重启时间

**4、w命令查看**

开头up后表示系统到目前运行了多久时间。反过来推算系统重启时间

**5、uptime命令查看**

和上面用法一致。

**6、查看/proc/uptime**

```
cat /proc/uptime
1415.59 1401.42
date -d "`cut -f1 -d. /proc/uptime` seconds ago"
Thu May 29 15:24:57 CST 2014
date -d "$(awk -F. '{print $1}' /proc/uptime) second ago" +"%Y-%m-%d %H:%M:%S"  
2014-05-29 15:24:57
```

 

## 参考：

[https://www.cnblogs.com/kerrycode/p/3759395.html](https://www.cnblogs.com/kerrycode/p/3759395.html)（以上内容转自此篇文章）

[http://www.thegeekstuff.com/2011/10/linux-reboot-date-and-time/](http://www.thegeekstuff.com/2011/10/linux-reboot-date-and-time/)

[http://www.averainy.info/linux-system-operation-time-and-the-view-of-the-latest-powered-up-time/](http://www.averainy.info/linux-system-operation-time-and-the-view-of-the-latest-powered-up-time/)

分类: [服务器运维-[Linux/Mac/Ubuntu/CentOS/Windows\]](https://www.cnblogs.com/EasonJim/category/811268.html)

标签: [linux](https://www.cnblogs.com/EasonJim/tag/linux/), [shell](https://www.cnblogs.com/EasonJim/tag/shell/)

[好文要顶](javascript:void(0);) [关注我](javascript:void(0);) [收藏该文](javascript:void(0);) [![img](https://common.cnblogs.com/images/icon_weibo_24.png)](javascript:void(0);) [![img](https://common.cnblogs.com/images/wechat.png)](javascript:void(0);)

0

[« ](https://www.cnblogs.com/EasonJim/p/8169262.html)上一篇： [Linux查找某个时间点后生成的文件（转）](https://www.cnblogs.com/EasonJim/p/8169262.html)
[» ](https://www.cnblogs.com/EasonJim/p/8169538.html)下一篇： [MetaWeblog是什么](https://www.cnblogs.com/EasonJim/p/8169538.html)

posted @ 2018-01-01 23:00 [EasonJim](https://www.cnblogs.com/EasonJim/) 阅读(11411) 评论(0) [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=8169304) [收藏](javascript:void(0)) [举报](javascript:void(0))