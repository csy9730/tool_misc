# ls





**Q**: E: Could not open lock file /var/lib/dpkg/lock-frontend - open (13: Permission denied) E: Unable to 

**A**:实这是因为有另外一个程序在运行，导致锁不可用。原因可能是上次运行更新或安装没有正常完成。解决办法是杀死此进程
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
1,sudo dpkg --configure -a
2,sudo apt-get update

sudo curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

``` bash
sudo dpkg -l
sudo dpkg -l | grep -i apache

```

## 包管理器

yum 是centos的包管理器
apt 是Ubuntu的包管理器
pkg 是？？？
deb 是 debian
pacman  是arch linux的包管理器

|操作系统	|格式	|工具|
|Debian	|.deb	|apt, apt-cache, apt-get, dpkg |
|Ubuntu	|.deb	|apt, apt-cache, apt-get, dpkg |
|CentOS	|.rpm	|yum |
|Fedora	|.rpm	|dnf |
|FreeBSD|Ports, .txz|	make, pkg |
|Arch |   .|	pacman |



``` bash
apt list # 查看所有可获得包
sudo apt list --installed | grep -i apache
sudo apt list --installed | less
sudo apt list --installed

yum list installed 
```