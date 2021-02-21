# 简介
## 烧录
SD Formatter
树莓派装完系统后TF卡显示只有40MB，
## ssh连接

树莓派一般默认开启ssh连接
SSH客户端推荐PuTTY和Xshell。
需要IP、端口(默认22)开启连接 ，用用户名账户和密码登陆
默认账户名： pi
默认密码：raspberry

##### 查看树莓派ip地址的几种方法
1. 树莓派界面输入： ifconfig
2. ping raspberrypi
3. arp -a
4. nmap -sn 192.168.1.0/24
5. 使用advanced IP scanner暴力搜索IP地址

#### VNC远程连接
``` 
# 开启VNC
sudo raspi-config
5 Interfacing Options。
P3 VNC
# 开启VNC
vncserver
```

电脑下载VNC远程连接，连接方式与SSH连接相同
#### 外接HDMI
```
sudo rm -rf LCD-show
git clone https://github.com/goodtft/LCD-show.git
chmod -R 755 LCD-show
cd LCD-show/
sudo ./LCD35-show
```
解决树莓派外接HDMI无法显示屏幕的问题
cd LCD-show/
./LCD-hdmi
./LCD35-show

树莓派设置显示屏分辨率
// 打开/boot/config.txt目录下的配置文件
sudo vi /boot/config.txt
// 设置hdmi_group;hdmi_group可取两个值：
// 1) 使用CEA分辨率,即hdmi_group=1;
// 2) 使用DMT分辨率,即hdmi_group=2.
hdmi_group=1
// 设置hdmi_mode.对于不同的hdmi_group设置的分辨率不一样。
hdmi_mode=31		// 表示1080p 50HZ
####　音频设置
```
alsamixer # 通过键盘的上下箭头可以调整音量，按Esc退出。
speaker-test -t sine # 如果能听到蜂鸣声，那说明没问题.
sudo raspi-config # 第7项Advanced Options并回车，然后选择第4项Audio再回车
```

#### sources
查看树莓派的codename
```
 $ lsb_release -a
No LSB modules are available.
Distributor ID: Raspbian
Description:    Raspbian GNU/Linux 9.8 (stretch)
Release:        9.8
Codename:       stretch
```

`sudo vim /etc/apt/sources.list`

``` ini
deb http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ stretch main contrib non-free rpi
deb-src http://mirrors.tuna.tsinghua.edu.cn/raspbian/raspbian/ stretch main contrib non-free rpi
```

pi@raspberrypi:~ $ sudo leafpad /etc/apt/sources.list.d/raspi.list
使用 # 注释掉原文件内容，使用以下内容取代。
``` ini
deb http://mirror.tuna.tsinghua.edu.cn/raspberrypi/ stretch main ui
deb-src http://mirror.tuna.tsinghua.edu.cn/raspberrypi/ stretch main ui
```
#### misc

定时关机
shutdown -t 60 # 60分钟后关机

### 参考
http://www.lcdwiki.com/zh/3.5inch_RPi_Display

接: https://pan.baidu.com/s/15OGOPkAsMmxgN9x3heN4iQ  提取码:aq7u
我们论坛资料：www.raspigeek.com （免费可注册查看资料）
初次使用安装系统:http://www.raspigeek.com/index.php?c=read&id=6&page=1


3.5寸LCD显示屏需要安装驱动，详情参看3.5寸使用资料http://www.raspigeek.com/index.php?c=read&id=79&page=1

