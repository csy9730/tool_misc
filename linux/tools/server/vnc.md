# vnc



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