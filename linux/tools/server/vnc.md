# vnc

VNC(Virtual Network Computing)是使用RFB(Remote Frame Buffer protocol)协议的图形桌面共享系统，可以达到远程控制桌面的效果。VNC是server-client架构：

server，称VNC server，常见的有：

    x11vnc
    vnc4server
    tightvncserver

client，称VNC viewer，常见的有：

    Remmina(Linux)
    RealVNC(Windows MacOS)



[vnc](https://www.realvnc.com/en/connect/download/viewer/)

``` bash
sudo apt-get install vnc4server
yum install tigervnc-server -y
vncserver
vncpasswd # 修改
```


vnc的配置文件xstartup
sudo vim /home/lincanran/.vnc/xstartup

如果你的vnc访问:192.168.1.203:1 那么他访问服务器的真正端口是5900+1=5901 （5900是vnc的默认端口）