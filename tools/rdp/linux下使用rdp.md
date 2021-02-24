# linux下使用rdp


## rdesktop
简单的说就是在linux下如何远程终端连接一台windows的服务器。

在windwos下我们直接可以mstsc开启远程终端的连接。而linux下呢。就需要安装一款工具了。

命令：sudo apt-get install rdesktop

然后rdesktop -f ip即可。

在linux下默认是全屏的大家可以用Ctrl+Alt+Enter来进行调节。

当然了还有更多的参数

-r clipboard:PRIMARYCLIPBOARD是允许在远程主机和本机之间共享剪切板，就是可以复制粘贴。
rdesktop -f -r disk:MyDisk=/home/comet/temp ip
-r disk:MyDisk=/home/comet/temp就是把你的Linux下某个文件夹挂载到远程主机上
-x lan|modem：用来决定网络带宽，如果带宽宽的话，选择lan，则可以将桌面背景也传过来，默认是没有桌面背景的；有壁纸的感觉好好哦

## xrdp

```
apt install xrdp
sudo systemctl restart xrdp

sudo ufw allow 3389/tcp
```



xorg
x11rdp
xvnc
console
vnc-any
sesman-anyneutrinordp-any
