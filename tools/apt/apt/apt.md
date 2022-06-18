# APT

[TOC]

## 包管理器

- yum 是centos的包管理器
- apt 是Ubuntu的包管理器
- deb 是 debian的包格式
- pacman  是arch linux的包管理器



|操作系统	|格式	|工具|
| ---- | ---- | ---- |
|FreeBSD|Ports, .txz|	make, pkg |
|Debian	|.deb	|apt, apt-cache, apt-get, dpkg |
|Ubuntu	|.deb	|apt, apt-cache, apt-get, dpkg |
|CentOS	|.rpm	|yum |
|Fedora	|.rpm	|dnf |
|Arch |   .|	pacman |

## apt

apt 是ubuntu下常用的包管理工具，位于/usr/bin/apt 。

apt 是apt-get apt-cache 的简化易用版工具。

### 常用命令

``` bash
apt upgrade # 更新apt软件
apt update  # 更新软件包


apt list # 查看所有可获得包
apt list --installed # 查看所有本机已经安装的软件包
apt list --installed | less
apt list --installed | grep -i apache


# 下载包
apt-get install dependpackname –reinstall -d


apt remove xxx # 卸载 xxx软件

yum list installed # centos 查看所有本机已经安装的软件包


```

#### 离线安装deb包
查看依赖
`apt-cache depends <package name>`

比如要下载tree这个deb包, 则使用如下指令： `apt download tree`


安装一个 Debian 软件包，如你手动下载的文件。
`sudo dpkg -i <package.deb>`


### help

``` 
 apt install -h
apt 1.6.14 (amd64)
用法： apt [选项] 命令

命令行软件包管理器 apt 提供软件包搜索，管理和信息查询等功能。
它提供的功能与其他 APT 工具相同（像 apt-get 和 apt-cache），
但是默认情况下被设置得更适合交互。

常用命令：
  list - 根据名称列出软件包
  search - 搜索软件包描述
  show - 显示软件包细节
  install - 安装软件包
  remove - 移除软件包
  autoremove - 卸载所有自动安装且不再使用的软件包
  update - 更新可用软件包列表
  upgrade - 通过 安装/升级 软件来更新系统
  full-upgrade - 通过 卸载/安装/升级 来更新系统
  edit-sources - 编辑软件源信息文件

参见 apt(8) 以获取更多关于可用命令的信息。
程序配置选项及语法都已经在 apt.conf(5) 中阐明。
欲知如何配置软件源，请参阅 sources.list(5)。
软件包及其版本偏好可以通过 apt_preferences(5) 来设置。
关于安全方面的细节可以参考 apt-secure(8).

```

### apt install help
```
apt install
-h  This help text.

-d  Download only - do NOT install or unpack archives

-f  Attempt to continue if the integrity check fails

-s  No-act. Perform ordering simulation

-y  Assume Yes to all queries and do not prompt

-u  Show a list of upgraded packages as well
```


## misc

###  /var/lib/dpkg/lock-frontend
**Q**: E: Could not open lock file /var/lib/dpkg/lock-frontend - open (13: Permission denied) E: Unable to 

**A**:实这是因为有另外一个程序在运行，导致锁不可用。原因可能是上次运行更新或安装没有正常完成。解决办法是杀死此进程，清除缓存

```bash
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
sudo apt-get update
sudo dpkg --configure -a
```

### /var/lib/dpkg/

**Q**: Ubuntu终端出现Unable to lock the administration directory (/var/lib/dpkg/)

**A**: ` ps -ef | grep apt-get `命令找到相关进程，然后使用`kill -9 pid`

或者使用`ps -e | grep apt`是否有未执行完的apt程序，然后执行`sudo killall apt`

### 修改apt 源
**Q**: 如何修改apt 源

**A**: 
apt源就是一个文件(Linux下一切都是文件)，位置是/etc/apt/sources.list，打开就可以看到你本机的apt源


### Package has no installation candidate
今天在安装软件的时候出现了Package has no installation candidate的问题，如：

```
#  apt-get install <packagename>
Reading package lists... Done
Building dependency tree... Done
Package aptitude is not available, but is referred to by another package.
This may mean that the package is missing, has been obsoleted, or
is only available from another source
E: Package <packagename> has no installation candidate
```

解决方法如下：
```
# apt-get update
# apt-get upgrade
# apt-get install <packagename>
```

### 关闭apt自动更新
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

### install docker

**Q**: 安装docker：

**A**: `sudo curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun`


### install nvidia driver

英伟达显卡安装？

```
sudo apt-get purge nvidia-common
sudo apt-get install nvidia-common
```




### 常用工具包

以下是ubuntu的常用工具包

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
