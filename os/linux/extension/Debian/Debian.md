# debian

[Debian GNU/Linux](http://www.debian.org/)，是一个操作系统及自由软件的发行版，由一群自愿付出时间和精力的用户来维护并更新。它附带了超过 59000 个软件包，这些预先编译好的软件被打包成一种良好的格式以便于用户安装和使用。


#### 使用阿里源镜像

debian 11.x (bullseye)

编辑/etc/apt/sources.list文件(需要使用sudo), 在文件最前面添加以下条目(操作前请做好相应备份)
``` bash
deb https://mirrors.aliyun.com/debian/ bullseye main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ bullseye main non-free contrib
deb https://mirrors.aliyun.com/debian-security/ bullseye-security main
deb-src https://mirrors.aliyun.com/debian-security/ bullseye-security main
deb https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ bullseye-updates main non-free contrib
deb https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib
deb-src https://mirrors.aliyun.com/debian/ bullseye-backports main non-free contrib
```