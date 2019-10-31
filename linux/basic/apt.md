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

常用命令

``` bash
apt upgrade # 更新apt软件
apt update  # 更新软件包
apt install openssl # 安装openssl软件

```

其他命令

``` bash
apt list # 查看所有可获得包
apt list --installed # 查看所有本机已经安装的软件包
apt list --installed | less
apt list --installed | grep -i apache

yum list installed # 查看所有本机已经安装的软件包
```

## 下载器

常用下载器有wget 和 curl



## misc

**Q**: E: Could not open lock file /var/lib/dpkg/lock-frontend - open (13: Permission denied) E: Unable to 

**A**:实这是因为有另外一个程序在运行，导致锁不可用。原因可能是上次运行更新或安装没有正常完成。解决办法是杀死此进程

```bash
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
sudo apt-get update
sudo dpkg --configure -a
```



**Q**: Ubuntu终端出现Unable to lock the administration directory (/var/lib/dpkg/)
**A**: ` ps -ef | grep apt-get `命令找到相关进程 然后使用`Kill -9 pid`

或者使用`ps -e | grep apt`是否有未执行完的apt程序，然后执行`sudo killall apt`



**Q**: docker安装：

**A**: `sudo curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun`



英伟达显卡安装？

sudo apt-get purge nvidia-common
sudo apt-get install nvidia-common



sudo dpkg -l
sudo dpkg -l | grep -i apache

### 装机目录

以下是ubuntu的装机目录

``` bash
apt install zsh
apt install zsh
apt install python2
apt install python3
apt install nodejs
apt install perl
apt install sqlite
apt install docker
```

