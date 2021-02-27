# vnc

VNC(Virtual Network Computing)是使用RFB(Remote Frame Buffer protocol)协议的图形桌面共享系统，可以达到远程控制桌面的效果。VNC是server-client架构：

server，称VNC server，常见的有：
* x11vnc
* vnc4server
* tightvncserver

client，称VNC viewer，常见的有：
* Remmina(Linux)
* RealVNC(Windows MacOS)

## demo

[vnc](https://www.realvnc.com/en/connect/download/viewer/)
``` bash
sudo apt-get install vnc4server
sudo apt-get install xfce4

# yum install tigervnc-server
vncserver
vncpasswd # 修改
```


vnc的配置文件xstartup
`sudo vim ~/.vnc/xstartup`

如果你的vnc访问:192.168.1.203:1 那么他访问服务器的真正端口是5900+1=5901 （5900是vnc的默认端口）


## misc

```
#!/bin/sh

# Uncomment the following two lines for normal desktop:
# unset SESSION_MANAGER
# exec /etc/X11/xinit/xinitrc

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
x-window-manager &

```


``` bash
#!/bin/sh
# Uncomment the following two lines for normal desktop:
# unset SESSION_MANAGER
# exec /etc/X11/xinit/xinitrc

[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup
[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources
xsetroot -solid grey
vncconfig -iconic &
x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &
x-window-manager &

#gnome-terminal &

sesion-manager & xfdesktop & xfce4-panel &
xfce4-menu-plugin &
xfsettingsd &
xfconfd &
xfwm4 &
```