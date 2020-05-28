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
程序的安装目录是`/usr/lib/python2.7/site-packages/DenyHosts
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