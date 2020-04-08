# service


以下三个功能相同，其中/usr/sbin/service功能是调用/bin/systemctl，生成/etc/init.d/sshd 文件？
```
service sshd restart # 重启sshd服务
systemctl restart sshd # 重启sshd服务
/etc/init.d/sshd restart
```

```
systemctl status sshd # sshd状态查看
# systemctl 和 service 功能相当
service sshd start # 开启sshd服务
service sshd status # 查看服务是否开启
service sshd stop # 关闭ssh服务

```
## systemctl
systemctl是CentOS7的服务管理工具中主要的工具，它融合之前service和chkconfig的功能于一体。
``` bash
systemctl start firewalld.service # 启动一个服务
systemctl stop firewalld.service # 关闭一个服务
systemctl restart firewalld.service # 重启一个服务
systemctl status firewalld.service # 显示一个服务的状态
systemctl enable firewalld.service # 在开机时启用一个服务
systemctl disable firewalld.service # 在开机时禁用一个服务
systemctl is-enabled firewalld.service # 查看服务是否开机启动
systemctl list-unit-files|grep enabled # 查看已启动的服务列表
systemctl --failed # 查看启动失败的服务列表
```