# 修改CentOS默认yum源为国内yum镜像源

有时候CentOS默认的yum源不一定是国内镜像，导致yum在线安装及更新速度不是很理想。这时候需要将yum源设置为国内镜像站点。国内主要开源的开源镜像站点应该是网易和阿里云了。

修改CentOS默认yum源为mirrors.163.com

1. 首先备份系统自带yum源配置文件/etc/yum.repos.d/CentOS-Base.repo
2. 下载CentOS7对应的yum源配置文件
3. 运行`yum makecache`生成缓存

``` bash
mv /etc/yum.repos.d/CentOS-Base.repo /etc/yum.repos.d/CentOS-Base.repo.backup # 备份系统自带yum源配置文件
cd /etc/yum.repos.d/ # 进入yum源配置文件所在的文件夹
wget http://mirrors.163.com/.help/CentOS7-Base-163.repo # 下载163的CentOS7对应的yum源配置文件
wget http://mirrors.163.com/.help/CentOS6-Base-163.repo
wget http://mirrors.163.com/.help/CentOS5-Base-163.repo

yum makecache # 运行yum makecache生成缓存
yum -y update # 更新系统就会看到以下mirrors.163.com信息

```

修改CentOS默认yum源为mirrors.aliyun.com
``` bash
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-7.repo  # 下载aliyun的CentOS7对应的yum源配置文件
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-6.repo
wget -O /etc/yum.repos.d/CentOS-Base.repo http://mirrors.aliyun.com/repo/Centos-5.repo
yum makecache # 运行yum makecache生成缓存
```
显示以下结果
```
[root@localhost ~]# yum -y update
已加载插件：fastestmirror, refresh-packagekit, security
设置更新进程Loading mirror speeds from cached hostfile
* base: mirrors.aliyun.com
* extras: mirrors.aliyun.com
* updates: mirrors.aliyun.com
```
