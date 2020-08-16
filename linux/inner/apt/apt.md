# APT

[TOC]

## 包管理器

yum 是centos的包管理器
apt 是Ubuntu的包管理器
deb 是 debian
pacman  是arch linux的包管理器



|操作系统	|格式	|工具|
| ---- | ---- | ---- |
|Debian	|.deb	|apt, apt-cache, apt-get, dpkg |
|Ubuntu	|.deb	|apt, apt-cache, apt-get, dpkg |
|CentOS	|.rpm	|yum |
|Fedora	|.rpm	|dnf |
|FreeBSD|Ports, .txz|	make, pkg |
|Arch |   .|	pacman |

## apt
常用命令

``` bash
apt upgrade # 更新apt软件
apt update  # 更新软件包
apt install openssl # 安装openssl软件

```

```
apt install
-h  This help text.

-d  Download only - do NOT install or unpack archives

-f  Attempt to continue if the integrity check fails

-s  No-act. Perform ordering simulation

-y  Assume Yes to all queries and do not prompt

-u  Show a list of upgraded packages as well
```


其他命令

``` bash
apt list # 查看所有可获得包
apt list --installed # 查看所有本机已经安装的软件包
apt list --installed | less
apt list --installed | grep -i apache

# 下载包
apt-get install dependpackname –reinstall -d


yum list installed # 查看所有本机已经安装的软件包


```



## 下载器

常用下载器有wget 和 curl



## misc

**Q**: E: Could not open lock file /var/lib/dpkg/lock-frontend - open (13: Permission denied) E: Unable to 

**A**:实这是因为有另外一个程序在运行，导致锁不可用。原因可能是上次运行更新或安装没有正常完成。解决办法是杀死此进程，清除缓存

```bash
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
sudo apt-get update
sudo dpkg --configure -a
```



**Q**: Ubuntu终端出现Unable to lock the administration directory (/var/lib/dpkg/)
**A**: ` ps -ef | grep apt-get `命令找到相关进程，然后使用`kill -9 pid`

或者使用`ps -e | grep apt`是否有未执行完的apt程序，然后执行`sudo killall apt`


**Q**: 如何修改apt 源
**A**: 
apt源就是一个文件(Linux下一切都是文件)，位置是/etc/apt/sources.list，打开就可以看到你本机的apt源


**Q**: 安装docker：

**A**: `sudo curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun`


**Q**: 关闭apt自动更新
**A**: 
自动更新程序为`/usr/lib/apt/apt.systemd.daily`
将“系统设置——软件和更新——更新——自动检查更新”选项值设为“从不
或者执行以下命令 
``` bash
sudo systemctl stop apt-daily.timer
systemctl status apt-daily.timer
sudo systemctl disabled apt-daily.timer

sudo systemctl status apt-daily.service
sudo systemctl disalbed apt-daily.service
sudo systemctl mask apt-daily.service

sudo systemctl stop apt-daily-upgrade.timer
sudo systemctl disabled apt-daily-upgrade.timer
sudo systemctl disabled apt-daily-upgrade.service
systemctl daemon-reload
```

英伟达显卡安装？
```
sudo apt-get purge nvidia-common
sudo apt-get install nvidia-common
```


### 装机目录

以下是ubuntu的常用装机目录

``` bash
apt install zsh
apt install vim
apt install git
apt install wget curl
apt install python2
apt install python3
apt install nodejs
apt install perl
apt install sqlite
apt install docker
apt install lua
apt install gcc g++ cmake
apt install autoconf  automake libtool pkg-config
```
