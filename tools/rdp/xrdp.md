# xrdp

在Windows下用 mstsc 连接Ubuntu桌面，跳出账号密码页面，登录后自动退出（闪退）的解决方法：


echo xfce4-session > ~/.xsession


sudo vim /etc/xrdp/startwm.sh
在. /etc/X11/Xsession前面加
xfce4-session

然后重启 sudo service xrdp restart。

tigervnc-server

## xfce4
首先安装xfce4-terminal：

`sudo apt install xfce4-terminal`

好了，装好xfce-terminal之后，打开xfce4 manager：

直接终端输入：xfce4-settings-manager