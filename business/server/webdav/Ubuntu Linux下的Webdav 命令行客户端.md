# Ubuntu Linux下的Webdav 命令行客户端

## davfs2

方法一：用davfs2:

​    

```
#apt-get install davfs2
#mkdir /media/akann
#mount -t davfs http://www.server.com/dir /media/akann
```

这样即可像普通文件一样拷贝复制了，但是davfs文件系统在某些vps服务器不支持/dev/fuse模块的情况下无法使用。

 ##  Cadaver

方法二： Cadaver：

  很简单 

```
#apt-get install cadaver
```



```
#cadaver http://www.server.com/dir
```

 然后提示你输入帐号密码即可。但问题是很讨厌的是cadaver不支持https.

## curl

方法三：curl:curl是个万金油

 上传：

```
#apt-get install curl
#curl --user 账户名:密码 -T 文件名 https://www.server.com:443/dir --trace-ascii goo.txt 
```

 下载：

```
#curl --user 账户名:密码 https://www.server.com/dir/文件名>文件名 
```

遗憾的是curl没有进程条显示

## rclone