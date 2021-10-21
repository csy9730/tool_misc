## [解决办法： RSA host key for [ip address\] has changed and you have requested strict checking.](https://www.cnblogs.com/AryaZ/p/9334338.html)

2018-07-19 10:28  [鸣仁](https://www.cnblogs.com/AryaZ/)  阅读(1207)  评论(0)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=9334338)  [收藏](javascript:void(0))  [举报](javascript:void(0))

在服务器重装后想要远程连接服务器，报错如下：

```
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the RSA key sent by the remote host is
SHA256:＊＊＊＊＊＊＊
Please contact your system administrator.
Add correct host key in /Users/apple/.ssh/known_hosts to get rid of this message.
Offending RSA key in /Users/apple/.ssh/known_hosts:17
RSA host key for [***ip address***] has changed and you have requested strict checking.
Host key verification failed.
```

因为重装后，本地机和服务器内部ssh对不上导致错误，因此，只需要删除本地机ssh缓存信息，即可恢复。 
在本地机输入一下命令行：

```
ssh-keygen -R [服务器ip address]
```

得到以下结果：

```
# Host ［IP address］ found: line **
/Users/apple/.ssh/known_hosts updated.
Original contents retained as /Users/apple/.ssh/known_hosts.old
```

















-  