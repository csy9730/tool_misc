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