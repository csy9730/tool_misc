# denyhosts

[https://github.com/denyhosts/denyhosts](https://github.com/denyhosts/denyhosts)
## quickstart
### install
下载软件
``` bash
#!/bin/bash
# wget https://github.com/denyhosts/denyhosts/archive/v3.1.tar.gz 
wget http://sourceforge.net/projects/denyhosts/files/denyhosts/2.6/DenyHosts-2.6.tar.gz # python2 的多年前的旧版本

tar -zxvf DenyHosts-2.6.tar.gz
cd DenyHosts-2.6

pip2 install ipaddr 
python2 setup.py install  --record denyhostsInstall.log
## 卸载的时候使用日志文件logName
cat denyhostsInstall.log | xargs rm -rf
```

### start
程序的安装目录是`/usr/lib/python2.7/site-packages/DenyHosts`
共享文档目录 `/usr/share/denyhosts`
程序入口文件是 `python /usr/bin/denyhosts.py`
服务入口是`/usr/bin/daemon-control-dist`
配置文件时`/etc/denyhosts.conf`

``` bash
# /usr/bin/daemon-control-dist
cp  /usr/bin/daemon-control-dist /usr/bin/daemon-control

#  /usr/bin/daemon-control-dist start的内容等价于执行 /usr/bin/env python /usr/local/bin/denyhosts --config /etc/denyhosts.conf --daemon
# 修改/usr/bin/daemon-control
daemon-control start
# /usr/bin/daemon-control start等价于执行 /usr/bin/env python2 /usr/bin/denyhosts.py --config /etc/denyhosts.conf --daemon
```

/usr/bin/daemon-control文件中,可以修改守护进程的调用方法

/etc/denyhosts.conf文件中,可以修改配置:
``` ini
SECURE_LOG = /var/log/secure

```
ubuntu使用/var/log/auth.log 文件
centos使用/var/log/secure文件


### daemon

```

chown root daemon-control
chmod 700 daemon-control
#提高安全级别，修改权限

ln -s /usr/share/denyhosts/daemon-control /etc/init.d/denyhosts
#创建启动服务连接

chkconfig denyhosts on
#添加启动项

cp denyhosts.cfg denyhosts.cfg.bak
#备份配置文件，为修改配置做准备

cat /workspace/denyhost.txt<</usr/share/denyhosts/denyhosts.cfg
#将配置文件内容导入配置文件（我的配置文件安装之前已经配置好了！）

/etc/init.d/denyhosts start
#启动服务

```

### conf

``` ini
SECURE_LOG = /var/log/secure
#sshd日志文件，它是根据这个文件来判断的，不同的操作系统，文件名稍有不同。

HOSTS_DENY = /etc/hosts.deny
#控制用户登陆的文件

PURGE_DENY = 5m
DAEMON_PURGE = 5m
#过多久后清除已经禁止的IP，如5m（5分钟）、5h（5小时）、5d（5天）、5w（5周）、1y（一年）

BLOCK_SERVICE  = sshd
#禁止的服务名，可以只限制不允许访问ssh服务，也可以选择ALL

DENY_THRESHOLD_INVALID = 5
#允许无效用户失败的次数

DENY_THRESHOLD_VALID = 10
#允许普通用户登陆失败的次数

DENY_THRESHOLD_ROOT = 5
#允许root登陆失败的次数

HOSTNAME_LOOKUP=NO
#是否做域名反解

DAEMON_LOG = /var/log/denyhosts
```

## 解除denyhosts

1. 暂停rsyslog `service rsyslog stop`
2. 暂停denyhosts `service denyhosts stop`
3. 删除记录
4. 重新启动denyhosts  `service denyhosts restart`
5. 重新启动sshd和rsyslog `service rsyslog restart`
6. 顺便可以重新启动sshd和 iptables

从/var/log/secure文件中指定IP的移除失败的登录事件
从/etc/hosts.deny移除指定IP

此外还有其他denyhosts的记录文件，位于`/var/lib/denyhosts `或`/usr/share/denyhosts/data`
文件如下
/var/lib/denyhosts/hosts
/var/lib/denyhosts/hosts-restricted
/var/lib/denyhosts/hosts-root
/var/lib/denyhosts/hosts-valid
/var/lib/denyhosts/offset
/var/lib/denyhosts/suspicious-logins
/var/lib/denyhosts/users-hosts
/var/lib/denyhosts/users-invalid
/var/lib/denyhosts/users-valid



### demo
可以用sudo sed -i '/ip/d' /var/log/secure 来直接修改，并使用sudo grep "ip" /var/log/secure来查看是否修改成功（已编写脚本）
如果不在乎上面的记录文件, 推荐清空上面几个Linux系统日志然后重新开启DennyHosts. 
清空上面几个Linux系统日志很简单, 在SSH中敲入下面的命令:`cat /dev/null > /var/log/secure`

不过我不想清空系统日志，所以做了一个简单的ip地址替换。
以下脚本可以一键替换被禁止的ip地址，附带系统服务停止和重启，适用于centos7.
``` bash
systemctl stop rsyslog
daemon-control stop  

sed -i 's/123.34.56.78/123.34.56.79/g'  /var/log/secure
sed -i 's/123.34.56.78/123.34.56.79/g'  /etc/hosts.deny

sed -i 's/123.34.56.78/123.34.56.79/g'  /var/lib/denyhosts/hosts
sed -i 's/123.34.56.78/123.34.56.79/g'  /var/lib/denyhosts/hosts-restricted
sed -i 's/123.34.56.78/123.34.56.79/g'  /var/lib/denyhosts/hosts-root
sed -i 's/123.34.56.78/123.34.56.79/g'  /var/lib/denyhosts/hosts-valid
sed -i 's/123.34.56.78/123.34.56.79/g'  /var/lib/denyhosts/offset
sed -i 's/123.34.56.78/123.34.56.79/g'  /var/lib/denyhosts/suspicious-logins
sed -i 's/123.34.56.78/123.34.56.79/g'  /var/lib/denyhosts/users-hosts
sed -i 's/123.34.56.78/123.34.56.79/g'  /var/lib/denyhosts/users-invalid
sed -i 's/123.34.56.78/123.34.56.79/g'  /var/lib/denyhosts/users-valid

systemctl restart rsyslog
daemon-control start 
systemctl restart sshd
systemctl restart firewalld
 
```
