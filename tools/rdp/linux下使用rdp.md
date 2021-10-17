# linux下使用rdp


## rdesktop
简单的说就是在linux下如何远程终端连接一台windows的服务器。

在windwos下我们直接可以mstsc开启远程终端的连接。而linux下呢。就需要安装一款工具了。

命令：`sudo apt-get install rdesktop`

然后`rdesktop -f ip`即可。

在linux下默认是全屏的大家可以用Ctrl+Alt+Enter来进行调节。

当然了还有更多的参数


`rdesktop -f -r disk:MyDisk=/home/comet/temp ip`

- -r disk:MyDisk=/home/comet/temp就是把你的Linux下某个文件夹挂载到远程主机上
  - -r clipboard:PRIMARYCLIPBOARD是允许在远程主机和本机之间共享剪切板，就是可以复制粘贴。
  - -r disk:wj=/home/magicgod 映射虚拟盘，可选，会在远程机器的网上邻居里虚拟出一个映射盘，功能很强，甚至可以是软盘或光盘
  - -r sound:off 关闭声音，当然也可以把远程发的声音映射到本地来。
- -x lan|modem：用来决定网络带宽，如果带宽宽的话，选择lan，则可以将桌面背景也传过来，默认是没有桌面背景的；有壁纸的感觉好好哦
- -f 全屏
- -u xxxxxx 登录用户，可选
- -p xxxxxx 登录密码，可选
- -a 16 颜色，可选，不过最高就是16位
- -z 压缩，可选
- -g 1024x768 分辨率，可选，缺省是一种比当前本地桌面低的分辨率
- -P 缓冲，可选


例：`rdesktop -f 192.168.0.184 -u Test3 -p 2013@Miqilai`    全屏，直接输入用户名和密码

rdesktop退出全屏模式 ：使用组合键ctrl+alt+enter进行切换。


默认端口是3389（linux 22 sh）
注意：windows 的服务中的 Terminal Servies 需要开启。我的电脑 右键 属性 远程中，勾选 允许远程用户链接到此计算机。另外，退出的时候选择注销，而不是关机！

## xrdp

```
apt install xrdp
sudo systemctl restart xrdp

sudo ufw allow 3389/tcp
```



* xorg
* x11rdp
* xvnc
* console
* vnc-any
* sesman-anyneutrinordp-any
