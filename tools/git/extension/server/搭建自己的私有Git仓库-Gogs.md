# 搭建自己的私有Git仓库-Gogs

## 一、简介

Git是一个分布式版本控制软件，不仅能在服务器上实现版本控制，也能独立使用。虽然现在Github私有库全面开放，但是有些私密的小项目放在Github的服务器上总有些不安心。 大名鼎鼎的Gitlab也能布置到自己服务器上，但是对服务器要求4G的内存着实有些太高。 [gogs](https://gogs.io/)则轻量化的多，号称一个树莓派就能成功跑起来供一个团队使用，我们就在centos上搭建gogs环境。 来吧~开始动手吧~

## 二、安装前的准备

### 1.新建用户

为了方便管理使用，我们先创建gogs使用的git用户，并给相关文件夹赋予权限

```text
sudo adduser git   #建立git用户
su git             #以git用户登录
#建立ssh目录
mkdir ~/.ssh       
chmod 700 ~/.ssh   
chmod 600 ~/.ssh/authorize_keys
```

### 2.下载

为了方便，我们选择二进制安装方法，先去下载对应版本的二进制包。[下载地址](https://gogs.io/docs/installation/install_from_binary.html)

### 3.其他所需环境

安装好MySQL环境

## 三、安装

### 1.解压缩

将刚才下载的压缩包，上传到服务器，并解压缩。 可以解压到任何地方，推荐/home/git/gogs

```text
tar xvf gogs_0.11.86_linux_amd64.tar.gz
```

### 2.配置数据库

gogs中已经有了初始化数据库文件

```text
/home/git/gogs/scripts/mysql.sql
```

执行下述代码，完成服务器用户gogs的创建

```text
mysql -u root -p < scripts/mysql.sql
mysql -u root -p
    >create user 'gogs'@'localhost' identified by 'keyword';
    >grant all privileges on gogs.* to 'gogs'@'localhost';
    >flush privileges;
    >exit;
```

### 3.运行

执行`./gogs web`运行gogs，在浏览器中访问`http://IP:3000/` 完成安装。

## 四、配置

配置文件位于Gogs目录的custom/conf/app.ini，详细参数参考[配置手册](https://link.zhihu.com/?target=https%3A//gogs.io/docs/advanced/configuration_cheat_sheet.html) 部分参数如下：

```text
APP_NAME = 网站名称
RUN_USER = gogs
RUN_MODE = prod

[database]
DB_TYPE  = mysql
HOST     = 127.0.0.1:3306
NAME     = gogs
USER     = gogs
PASSWD   = 数据库密码

[server]
DOMAIN           = https://你的域名
HTTP_PORT        = 3000             #默认监听3000端口
ROOT_URL         = https://你的域名
DISABLE_SSH      = false
SSH_PORT         = 22               #默认监听3000端口
START_SSH_SERVER = false
OFFLINE_MODE     = false
```

## 五、设置开机启动

gogs自带了开机启动的脚本，在`gogs/scripts`下。需要把脚本复制到centos7的脚本目录中。 **复制脚本** centos7使用systemd进行服务管理，需要复制到`/lib/systemd/system/`目录下。

```text
cp /home/git/gogs/scripts/systemd/gogs.service /lib/systemd/system/
```

**修改脚本** 修改后的内容如下：

```text
[Unit]
Description=Gogs
After=syslog.target
After=network.target
After=mysqld.service  #修改为gogs所需的服务，我这里只用了MySQL

[Service]
Type=simple
User=git
Group=git  #设置用户名和所属组
WorkingDirectory=/home/git/gogs  #gogs目录
ExecStart=/home/git/gogs/gogs web   #启动命令
Restart=always
Environment=USER=git HOME=/home/git #运行环境，设置启动用户和用户根目录


ProtectSystem=full
PrivateDevices=yes
PrivateTmp=yes
NoNewPrivileges=true

[Install]
WantedBy=multi-user.target
```

## 六、Gogs服务管理

自此已经完成了gogs的安装,可以使用以下命令进行管理。 开机启动Gogs服务 ：`systemctl enable gogs.service` 启动Gogs服务 ：`systemctl start gogs.service` 查看Gogs服务状态：`systemctl status gogs.service` 停止Gogs服务：`systemctl stop gogs.service`





[搭建自己的私有Git仓库-Gogs](https://zhuanlan.zhihu.com/p/65041792)