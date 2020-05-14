# vsftpd

[TOC]


一般来讲，人们将计算机联网的首要目的就是获取资料，而文件传输是一种非常重要的获取资料的方式。今天的互联网是由几千万台个人计算机、工作站、服务器、小型机、大型机、巨型机等具有不同型号、不同架构的物理设备共同组成的，而且即便是个人计算机，也可能会装有Windows、Linux、UNIX、Mac等不同的操作系统。为了能够在如此复杂多样的设备之间解决问题解决文件传输问题，文件传输协议（FTP）应运而生。

FTP是一种在互联网中进行文件传输的协议，基于客户端/服务器模式，默认使用20、21号端口，其中端口20（数据端口）用于进行数据传输，端口21（命令端口）用于接受客户端发出的相关FTP命令与参数。FTP服务器普遍部署于内网中，具有容易搭建、方便管理的特点。而且有些FTP客户端工具还可以支持文件的多点下载以及断点续传技术，因此FTP服务得到了广大用户的青睐。
![](https://img2018.cnblogs.com/blog/1682975/201905/1682975-20190511140335494-2133810542.png)
FTP服务器是按照FTP协议在互联网上提供文件存储和访问服务的主机，FTP客户端则是向服务器发送连接请求，以建立数据传输链路的主机。FTP协议有下面两种工作模式。

    主动模式：FTP服务器主动向客户端发起连接请求。

    被动模式：FTP服务器等待客户端发起连接请求（FTP的默认工作模式）。

（防火墙一般是用于过滤从外网进入内网的流量，因此有些时候需要将FTP的工作模式设置为主动模式，才可以传输数据。本文中使用的是被动模式）


## 1、安装并启动 FTP 服务

### 1.1 安装 VSFTPD

使用 `yum` 安装 `vsftpd`

```javascript
yum install -y vsftpd 
```

### 1.2  启动 VSFTPD

安装完成后，启动 FTP 服务：

```javascript
service vsftpd start
```

启动后，可以看到系统已经监听了 21 端口：

```javascript
netstat -nltp | grep 21
```

此时，访问 ftp://192.168.1.170 可浏览机器上的 /var/ftp目录了。


``` bash
# 关闭ftp服务
service vsftpd stop
service vsftpd restart
```





### 防火墙设置



setenforce 0 设置SELinux 成为permissive模式 （关闭SELinux）
setenforce 1 设置SELinux 成为enforcing模式 （开启SELinux）

``` bash
#关闭SELinux服务 permissive模式
setenforce 0 
#关闭防火墙
iptables -F 
```

或防火墙允许ftp服务和修改 SELinux 配置

``` bash

# 允许 ftp 服务
firewall-cmd --permanent --zone=public --add-service=ftp
# 重新载入配置
firewall-cmd --reload

# 查看当前配置
getsebool -a |grep ftp
# 设置 ftp 可以访问 home 目录
setsebool -P ftp_home_dir=1
# 设置 ftp 用户可以有所有权限
setsebool -P allow_ftpd_full_access=1
```



## 配置 FTP 权限

### 了解 VSFTP 配置

vsftpd 的配置目录为 /etc/vsftpd，包含下列的配置文件：

- vsftpd.conf 为主要配置文件
- ftpusers 配置禁止访问 FTP 服务器的用户列表（黑名单）
- user_list 配置用户访问控制，（黑名单或白名单）

ftpusers 总是生效，user_list 可以生效也可以不生效，可以是白名单生效或黑名单生效。



### 阻止匿名访问和切换根目录

匿名访问和切换根目录都会给服务器带来安全风险，我们把这两个功能关闭。

编辑 /etc/vsftpd/vsftpd.conf，找到下面两处配置并修改：
cd 
```javascript
# 禁用匿名用户  12 YES 改为NO
anonymous_enable=NO

# 禁止切换根目录 101 行 删除#
chroot_local_user=YES 
```

编辑完成后保存配置，重新启动 FTP 服务

```javascript
service vsftpd restart
```

### 创建 FTP 用户

创建一个用户 `ftpuser`

```javascript
useradd ftpuser
```

为用户 ftpuser 设置密码

```javascript
echo "javen205" | passwd ftpuser --stdin
```



限制用户 `ftpuser`只能通过 FTP 访问服务器，而不能直接登录服务器：

```javascript
usermod -s /sbin/nologin ftpuser
```



为用户 `ftpuser`创建主目录并约定：

`/data/ftp` 为主目录, 该目录不可上传文件  `/data/ftp/pub` 文件只能上传到该目录下

在`/data`中创建相关的目录

```javascript
mkdir -p /data/ftp/pub
```

创建登录欢迎文件

```javascript
echo "Welcome to use FTP service." > /data/ftp/welcome.txt
```

设置访问权限

```javascript
chmod a-w /data/ftp && chmod 777 -R /data/ftp/pub
```

设置为用户的主目录：

```javascript
usermod -d /data/ftp ftpuser
```



### script
``` bash
# 创建一个用户 `ftpuser`
useradd ftpuser

# 为用户 ftpuser 设置密码
echo "javen205" | passwd ftpuser --stdin

# 限制用户 `ftpuser`只能通过 FTP 访问服务器，而不能直接登录服务器：
usermod -s /sbin/nologin ftpuser

# 为用户 `ftpuser`创建主目录并约定：
# 在`/data`中创建相关的目录
mkdir -p /data/ftp/pub

# 创建登录欢迎文件
touch  /data/ftp/welcome.txt
echo "Welcome to use FTP service." > /data/ftp/welcome.txt

# 设置访问权限 sudo chmod a-w /data/ftp
sudo chmod 755 /data/ftp && sudo chmod 777 -R /data/ftp/pub
# 设置为用户的主目录：
usermod -d /data/ftp ftpuser

# 更改文件夹所有权
# chown -R ftpuser:ftpuser /data/ftp/pub
```

### 其他配置

``` bash
配置：
anonymous_enable=YES    #设置是否允许匿名用户登录 
local_enable=YES        #设置是否允许本地用户登录 
local_root=/home        #设置本地用户的根目录 
write_enable=YES        #是否允许用户有写权限 
local_umask=022        #设置本地用户创建文件时的umask值 
anon_upload_enable=YES    #设置是否允许匿名用户上传文件 
anon_other_write_enable=YES    #设置匿名用户是否有修改的权限 
anon_world_readable_only=YES    #当为YES时，文件的其他人必须有读的权限才允许匿名用户下载，单单所有人为ftp且有读权限是无法下载的，必须其他人也有读权限，才允许下载 
download_enbale=YES    #是否允许下载 
chown_upload=YES        #设置匿名用户上传文件后修改文件的所有者 
chown_username=ftpuser    #与上面选项连用，表示修改后的所有者为ftpuser 
ascii_upload_enable=YES    #设置是否允许使用ASCII模式上传文件 
ascii_download_enable=YES    #设置是否允许用ASCII模式下载文件 

chroot_local_user=YES   # 是否限定用户在其主目录下（NO 表示允许切换到上级目录）
#chroot_list_enable=YES # 是否启用限制用户的名单（注释掉为禁用）
chroot_list_file=/etc/vsftpd/chroot_list # 用户列表文件（一行一个用户）
allow_writeable_chroot=YES # 如果启用了限定用户在其主目录下需要添加这个配置，解决报错 500 OOPS: vsftpd: refusing to run with writable root inside chroot()
xferlog_enable=YES     # 启用上传和下载的日志功能，默认开启。
use_localtime=YES     # 是否使用本地时(自行添加)
userlist_enable=YES 
```

### 主动模式与被动模式

ftp 的主动模式（Port 模式）与被动模式（PASV 模式）的区别：[https://www.cnblogs.com/xiaohh/p/4789813.html](https://link.jianshu.com?t=https%3A%2F%2Fwww.cnblogs.com%2Fxiaohh%2Fp%2F4789813.html)
 本文推荐使用**被动模式**，vsftp 默认即为被动模式

- 开启被动模式（PASV）

在 `/etc/vsftpd/vsftpd.conf` 配置文件添加如下配置

```objectivec
pasv_enable=YES # 是否允许数据传输时使用PASV模式（默认值为 YES）
pasv_min_port=port port_number # PASV 模式下，数据传输使用的端口下界（0 表示任意。默认值为 0）把端口范围设在比较高的一段范围内，比如 50000-60000，将有助于安全性的提高.
pasv_max_port=port_number # PASV 模式下，数据传输使用的端口上界（0 表示任意。默认值为 0）
pasv_promiscuous=NO # 是否屏蔽对 PASV 进行安全检查，默认值为 NO（当有安全隧道时可禁用）
pasv_address # PASV 模式中服务器传回的 ip 地址。默认值为 none，即地址是从呼入的连接套接字中获取。
```

- 开启主动模式（PORT）的配置

```objectivec
port_enable=YES  # 是否开启 Port 模式
connect_from_port_20=YES # 当 Port 模式开启的时候，是否启用默认的 20 端口监听
ftp_data_port=port_number # Port 模式下 FTP 数据传输所使用的端口，默认值为20
```



## 访问FTP客户端

Windows 用户可以复制下面的链接
到资源管理器的地址栏访问：`ftp://ftpuser:javen205@192.168.1.170 `

也可以直接使用ftp命令行工具：
```
ftp  ftp.test.com

ftp> quote pasv

ftp> passive

ls
```

此外还有其他带界面的ftp工具
[WinSCP](https://winscp.net/eng/docs/lang:chs)- Windows 下的 FTP 和 SFTP 连接客户端
[FileZilla](https://filezilla-project.org/) - 跨平台的 FTP 客户端，支持 Windows 和 Mac

## misc



**Q**: 227 Entering Passive Mode (192,168,0,112,169,241).
425 Security: Bad IP connecting.

**A**: 这个原因是因为服务器本身设置了两个ip地址

vim /etc/vsftpd/vsftpd.conf 
添加：pasv_promiscuous=YES 

重启vsftpd #service vsftpd restart



**Q**: ftp vsftpd 530 login incorrect 解决办法汇总

**A**: vsftpd 530 login incorrect 的N中情况

1. 密码错误。
2. 检查/etc/vsftpd/vsftpd.conf配置
``` bash
vim /etc/vsftpd/vsftpd.conf
# 看下面配置
local_enable=YES  
pam_service_name=vsftpd     # 这里重要，有人说ubuntu是pam_service_name=ftp，可以试试
userlist_enable=YES 
```
3.检查/etc/pam.d/vsftpd

vim /etc/pam.d/vsftpd

注释掉
```
#auth    required pam_shells.so
```

**Q**: 向vsftp服务器上传文件报“550 Permission denied”错误的解决办法 

**A**: 
原因：vsftp默认配置不允许上传文件。
解决：修改/etc/vsftpd.conf
将“write_enable=YES”前面的#取消。
重启vsftp服务器。


还需要注意的是：
可以上传到制定的文件夹（例如Downloads），赋予这个文件夹读写权限（这次为了方面chmod  777 Downloads）

**Q**: ftp使用那些端口？
**A**: 服务端如果是主动模式，使用21和20端口，如果是被动模式，可以自行定义多个端口使用。

## misc
ftp 最常见的ftp，不够安全
sftp，使用22端口，特别安全，速度较慢
ftps和ftpes ： ttp over tls，较安全，速度中等。
scp :不是文件传输协议，只是单次文件复制
