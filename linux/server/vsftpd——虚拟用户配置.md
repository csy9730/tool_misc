# [vsftpd——虚拟用户配置](https://www.cnblogs.com/UG9527/p/11409703.html)



## 摘自https://www.cnblogs.com/zhangpf/p/7597268.html

原文有一些小错误，对新手不是很友好。各种报错，两天才搞清楚问题所在。

## 1.安装vsftpd

安装依赖包：

```
yum -y install pam pam-devel db4 de4-devel db4-uitls db4-tcl
```

 

新建vsftpd系统用户：

```
#建立Vsftpd服务的宿主用户
useradd vsftpd -M -s /sbin/nologin
#建立Vsftpd虚拟宿主用户
useradd ftpvload -M -s /sbin/nologin -d /var/ftp/
```

 

安装vsftpd

```
yum -y install vsftpd
```

 

## 2.配置vsftpd

```
mv /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.back
```

 

## 2.1 修改vsftpd.conf配置文件

```
vim /etc/vsftpd/vsftpd.conf
```

 

配置如下：

```
anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
anon_upload_enable=NO
anon_mkdir_write_enable=NO
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
chown_uploads=NO
xferlog_file=/var/log/vsftpd.log
xferlog_std_format=YES
async_abor_enable=YES
ascii_upload_enable=YES
ascii_download_enable=YES
ftpd_banner=Welcome to FTP Server
chroot_local_user=YES
ls_recurse_enable=NO
listen=YES
hide_ids=YES
pam_service_name=vsftpd
userlist_enable=YES
tcp_wrappers=YES
guest_enable=YES
guest_username=ftpvload
virtual_use_local_privs=YES
user_config_dir=/etc/vsftpd/vconf
```

 

主要是下面的一些配置参数介绍：

```
anonymous_enable=NO
#设定不允许匿名访问
local_enable=YES
#设定本地用户可以访问。注意：主要是为虚拟宿主用户，如果该项目设定为NO那么所有虚拟用户将无法访问。
write_enable=YES
#设定可以进行写操作。
local_umask=022
#设定上传后文件的权限掩码。
anon_upload_enable=NO
#禁止匿名用户上传。
anon_mkdir_write_enable=NO
#禁止匿名用户建立目录。
dirmessage_enable=YES
#设定开启目录标语功能。
xferlog_enable=YES
#设定开启日志记录功能。
connect_from_port_20=YES
#设定端口20进行数据连接。
chown_uploads=NO
#设定禁止上传文件更改宿主。
xferlog_file=/var/log/vsftpd.log
#设定Vsftpd的服务日志保存路径。注意，该文件默认不存在。必须要手动touch出来，并且由于这里更改了Vsftpd的服务宿主用户为手动建立的Vsftpd。必须注意给与该用户对日志的写入权限，否则服务将启动失败。
xferlog_std_format=YES
#设定日志使用标准的记录格式。
async_abor_enable=YES
#设定支持异步传输功能。
ascii_upload_enable=YES
ascii_download_enable=YES
#设定支持ASCII模式的上传和下载功能。
ftpd_banner=This Vsftp server supports virtual users ^_^
#设定Vsftpd的登陆标语。
chroot_list_enable=NO
#禁止用户登出自己的FTP主目录。
ls_recurse_enable=NO
#禁止用户登陆FTP后使用"ls -R"的命令。该命令会对服务器性能造成巨大开销。如果该项被允许，那么当多用户同时使用该命令时将会对该服务器造成威胁。
listen=YES
#设定该Vsftpd服务工作在StandAlone模式下。
pam_service_name=vsftpd #设定PAM服务下Vsftpd的验证配置文件名。因此，PAM验证将参考/etc/pam.d/下的vsftpd文件配置。
userlist_enable=YES
#设定userlist_file中的用户将不得使用FTP。
tcp_wrappers=YES
#设定支持TCP Wrappers

#以下这些是关于Vsftpd虚拟用户支持的重要配置项目。默认Vsftpd.conf中不包含这些设定项目，需要自己手动添加配置
guest_enable=YES
#设定启用虚拟用户功能。
guest_username=ftpvload
#指定虚拟用户的宿主用户。
virtual_use_local_privs=YES
#设定虚拟用户的权限符合他们的宿主用户。
user_config_dir=/etc/vsftpd/vconf
#设定虚拟用户个人Vsftp的配置文件存放路径。也就是说，这个被指定的目录里，将存放每个Vsftp虚拟用户个性的配置文件，一个需要注意的地方就是这些配置文件名必须和虚拟用户名相同。
```

 

建立Vsftpd的日志文件，并更该属主为Vsftpd的服务宿主用户：

```
touch /var/log/vsftpd.log
chown vsftpd.vsftpd /var/log/vsftpd.log
```

 

## 2.2 虚拟用户配置

创建虚拟用户配置文件存放路径

```
mkdir /etc/vsftpd/vconf/ -pv
```

 

制作虚拟用户数据库文件

```
touch /etc/vsftpd/virtusers
```

 

新建一个测试用虚拟用户

```
vim /etc/vsftpd/virtusers
```

 

编辑这个虚拟用户名单文件，在其中加入用户的用户名和口令信息。格式很简单：“奇数行用户名，偶数行口令”。

virtusers文件格式如下：

```
test     #用户名
test1234 #用户密码
```

 

生成虚拟用户数据文件：

```
db_load -T -t hash -f /etc/vsftpd/virtusers /etc/vsftpd/virtusers.db
```

 

需要特别注意的是，以后再要添加虚拟用户的时候，只需要按照“一行用户名，一行口令”的格式将新用户名和口令添加进虚拟用户名单文件。但是光这样做还不够，这样是不会生效的！还要再执行一遍“ db_load -T -t hash -f 虚拟用户名单文件 虚拟用户数据库文件.db ”的命令使其生效才可以！

## 2.3 设置认证文件PAM

在编辑前做好备份：

 

```
cp /etc/pam.d/vsftpd /etc/pam.d/vsftpd.backup
```

 

编辑Vsftpd的PAM验证配置文件，把原来的配置文件全部注释掉（不注释掉虚拟用户会登录不上），添加如下行

 

 

```
#vim /etc/pam.d/vsftpd
auth    sufficient      /lib64/security/pam_userdb.so    db=/etc/vsftpd/virtusers
account sufficient      /lib64/security/pam_userdb.so    db=/etc/vsftpd/virtusers
```

 

\#以上两条是手动添加的，内容是对虚拟用户的安全和帐户权限进行验证。

这里的auth是指对用户的用户名口令进行验证。

这里的accout是指对用户的帐户有哪些权限哪些限制进行验证。

其后的sufficient表示充分条件，也就是说，一旦在这里通过了验证，那么也就不用经过下面剩下的验证步骤了。相反，如果没有通过的话，也不会被系统立即挡之门外，因为sufficient的失败不决定整个验证的失败，意味着用户还必须将经历剩下来的验证审核。

再后面的/lib/security/pam_userdb.so表示该条审核将调用pam_userdb.so这个库函数进行。

最后的db=/etc/vsftpd/virtusers则指定了验证库函数将到这个指定的数据库中调用数据进行验证。

## 2.4 虚拟用户配置

规划好虚拟用户的主路径：

 

```
mkdir /var/ftp/virtual
```

 

建立测试用户的FTP用户目录：

```
mkdir /var/ftp/virtual/test1
```

 

更改虚拟用户的主目录的属主为虚拟宿主用户：

 

```
chown -R ftpvload.ftpvload /var/ftp/virtual/
```

 

建立虚拟用户配置文件模版：

```
vi /etc/vsftpd/vconf/vconf.tmp
```

 

vconf.tmp内容如下：

```
local_root=/var/ftp/virtual/username
#指定虚拟用户的具体主路径
anonymous_enable=NO
#设定不允许匿名用户访问
write_enable=YES
#设定允许写操作
local_umask=022
#设定上传文件权限掩码
anon_upload_enable=NO
#设定不允许匿名用户上传
anon_mkdir_write_enable=NO
#设定不允许匿名用户建立目录
idle_session_timeout=600
#设定空闲连接超时时间
data_connection_timeout=120
#设定单次连续传输最大时间
max_clients=10
#设定并发客户端访问个数
max_per_ip=5
#设定单个客户端的最大线程数，这个配置主要来照顾Flashget、迅雷等多线程下载软件
local_max_rate=50000
#设定该用户的最大传输速率，单位b/s
```

 

测试用户复制配置模板

```
cp /etc/vsftpd/vconf/vconf.tmp /etc/vsftpd/vconf/test
```

 

 

```
vim /etc/vsftpd/vconf/test
修改内容 local_root=/var/ftp/virtual/test
```

 

## 3.测试配置

使用ftp连接之后，测试情况如下

![img](https://images2017.cnblogs.com/blog/987248/201709/987248-20170926160042901-231274925.png)

## 4.自动脚本

## 4.1 自动安装配置

```
#!/bin/bash
#date:2017-08-15
#version:0.0.2

#开始安装vsftpd
echo ">>> 1. Start install Vsftpd ......"
yum -y install pam pam-devel db4 de4-devel db4-tcl vsftpd
mkdir /var/ftp/virtual
useradd vsftpd -M -s /sbin/nologin
useradd ftpvload -d /var/ftp/ -s /sbin/nologin
sleep 3
chown -R ftpvload.ftpvload /var/ftp/
sleep 5

#开始配置vsftpd
echo ">>> 2. Start config Vsftpd ......"
mv /etc/vsftpd/vsftpd.conf /etc/vsftpd/vsftpd.conf.back

echo "anonymous_enable=NO
local_enable=YES
write_enable=YES
local_umask=022
anon_upload_enable=NO
anon_mkdir_write_enable=NO
dirmessage_enable=YES
xferlog_enable=YES
connect_from_port_20=YES
chown_uploads=NO
xferlog_file=/var/log/vsftpd.log
xferlog_std_format=YES
async_abor_enable=YES
ascii_upload_enable=YES
ascii_download_enable=YES
ftpd_banner=Welcome to FTP Server
chroot_local_user=YES
ls_recurse_enable=NO
listen=YES
hide_ids=YES
pam_service_name=vsftpd
userlist_enable=YES
tcp_wrappers=YES
guest_enable=YES
guest_username=ftpvload
virtual_use_local_privs=YES
user_config_dir=/etc/vsftpd/vconf" > /etc/vsftpd/vsftpd.conf

cp /etc/pam.d/vsftpd /etc/pam.d/vsftpd.backup
sed -i s/^/#/g /etc/pam.d/vsftpd
echo "auth    sufficient      /lib64/security/pam_userdb.so    db=/etc/vsftpd/virtusers
account sufficient      /lib64/security/pam_userdb.so    db=/etc/vsftpd/virtusers" >> /etc/pam.d/vsftpd
sleep 3

#开始配置其它
echo ">>> 3. Start config other ......"
touch /var/log/vsftpd.log
chown vsftpd.vsftpd /var/log/vsftpd.log
mkdir /etc/vsftpd/vconf/ -p
sleep 3

#配置虚拟用户
echo ">>> 4. Start config vitual user"
echo -e "test\ntest1234" >> /etc/vsftpd/virtusers
db_load -T -t hash -f /etc/vsftpd/virtusers /etc/vsftpd/virtusers.db
mkdir /var/ftp/virtual/test

echo "local_root=/var/ftp/virtual/username
#指定虚拟用户的具体主路径
anonymous_enable=NO
#设定不允许匿名用户访问
write_enable=YES
#设定允许写操作
local_umask=022
#设定上传文件权限掩码
anon_upload_enable=NO
#设定不允许匿名用户上传
anon_mkdir_write_enable=NO
#设定不允许匿名用户建立目录
idle_session_timeout=600
#设定空闲连接超时时间
data_connection_timeout=120
#设定单次连续传输最大时间
max_clients=10
#设定并发客户端访问个数
max_per_ip=5
#设定单个客户端的最大线程数，这个配置主要来照顾Flashget、迅雷等多线程下载软件
#local_max_rate=50000
#设定该用户的最大传输速率，单位b/s" >> /etc/vsftpd/vconf/vconf.tmp

cp /etc/vsftpd/vconf/vconf.tmp /etc/vsftpd/vconf/test
sed -i s/username/test/g /etc/vsftpd/vconf/test

echo "All OVER! "
```

 

## 4.2 新增用户

```
#!/bin/bash
#date:2017-05-25
if read -t 5 -p "Please enter you name: " username
then
   if [ -f /etc/vsftpd/vconf/$username ]  #判断用户是否存在
   then
      echo "The $username is exists, please input another name."
   else
      read -s -p "Please enter your password: " passwd
	  echo -e "$username\n$passwd" >> /etc/vsftpd/virtusers
	  db_load -T -t hash -f /etc/vsftpd/virtusers /etc/vsftpd/virtusers.db
      mkdir -p /var/ftp/virtual/$username
      chown -R ftpvload.ftpvload /var/ftp
      cp /etc/vsftpd/vconf/vconf.tmp /etc/vsftpd/vconf/$username
      sed -i s/username/$username/g /etc/vsftpd/vconf/$username
      echo "The config is over."
   fi
else
   echo -e "\nThe 5s has passed, you are to slow! "
fi
```

 

 

报错：500 OOPS: vsftpd: refusing to run with writable root inside chroot()

解决：增加虚拟用户权限 echo “allow_writeable_chroot=YES” >> /etc/vsftpd/vconf/test