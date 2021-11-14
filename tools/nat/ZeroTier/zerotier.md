# zerotier

[https://www.zerotier.com/](https://www.zerotier.com/)


[](../../../program/c/base/使用C语言中qsort()函数对浮点型数组无法成功排序的问题.md

## install

[https://www.zerotier.com/download/](https://www.zerotier.com/download/)



### linux

安装zerotier程序
``` bash
curl -s https://install.zerotier.com | sudo bash


需要下载 791 kB 的归档。
解压缩后会消耗 2,378 kB 的额外空间。
获取:1 http://download.zerotier.com/debian/bionic bionic/main amd64 zerotier-one amd64 1.8.2 [791 kB]
已下载 791 kB，耗时 1秒 (735 kB/s)   
正在选中未选择的软件包 zerotier-one。
(正在读取数据库 ... 系统当前共安装有 224382 个文件和目录。)
正准备解包 .../zerotier-one_1.8.2_amd64.deb  ...
正在解包 zerotier-one (1.8.2) ...
正在设置 zerotier-one (1.8.2) ...
Created symlink /etc/systemd/system/multi-user.target.wants/zerotier-one.service → /lib/systemd/system/zerotier-one.service.
正在处理用于 man-db (2.8.3-2ubuntu0.1) 的触发器 ...
正在处理用于 ureadahead (0.100.0-21) 的触发器 ...
ureadahead will be reprofiled on next reboot
正在处理用于 systemd (237-3ubuntu10.52) 的触发器 ...

*** Enabling and starting zerotier-one service...
Synchronizing state of zerotier-one.service with SysV service script with /lib/systemd/systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable zerotier-one

*** Waiting for identity generation...

*** Success! You are ZeroTier address [ 131580ed3c ].
```


确认安装成功
```
apt list --installed |grep zero
zerotier-one/bionic,now 1.8.2 amd64 [已安装]
```

```
➜  Downloads ps -ef |grep zero
zerotie+ 22825     1  0 12:08 ?        00:00:00 /usr/sbin/zerotier-one
```

查看当前状态
``` bash
➜  sudo zerotier-cli status
[sudo] password for foo: 
200 info 131580ed3c 1.8.2 ONLINE
```

加入vpn
```
➜ sudo zerotier-cli join abcdefg
200 join OK
```

在网页管理页面中，允许客户端加入vpn。


可以看到，分配了新的ip地址
```
$ ifconfig
ztuzezkc4s: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 2800
        inet 10.123.12.123  netmask 255.255.255.0  broadcast 10.123.12.255
        inet6 fe80::a1c1:7cbeff:fe:d4c0  prefixlen 64  scopeid 0x20<link>
        ether ae:d4:21:be:7c:c3  txqueuelen 1000  (Ethernet)
        RX packets 18  bytes 1705 (1.7 KB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 66  bytes 11138 (11.1 KB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
```
