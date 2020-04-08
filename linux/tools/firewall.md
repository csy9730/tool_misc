# firewall
centos7 开始使用firewalld，centos6使用iptables
``` bash
systemctl enable firewalld
systemctl start firewalld
systemctl status firewalld
systemctl stop firewalld.service # 停止firewall
systemctl status firewalld.service # 停止firewall
systemctl disable firewalld.service # 禁止firewall开机启动
systemctl restart firewalld

firewall-cmd --query-port=80/tcp # 查询端口号80 是否开启
firewall-cmd --permanent --zone=public --add-port=100-500/tcp  # 永久的开放需要的端口
firewall-cmd --permanent --zone=public --add-port=100-500/udp
firewall-cmd --list-port # 查看所有端口

# 检查防火墙状态
firewall-cmd --state
firewall-cmd --list-all

firewall-cmd --reload # 重载防火墙
```

## iptables
``` bash
# 开放80，22，8080 端口
/sbin/iptables -I INPUT -p tcp --dport 80 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 22 -j ACCEPT
/sbin/iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
# 保存
/etc/rc.d/init.d/iptables save
# 查看打开的端口
/etc/init.d/iptables status

# 关闭防火墙 
# 永久性生效，重启后不会复原
chkconfig iptables on # 开启
chkconfig iptables off # 关闭
# 即时生效，重启后复原
service iptables start # 开启
service iptables stop # 关闭
/etc/init.d/iptables stop 

vi /etc/sysconfig/iptables
```

## misc

### 信任级别
通过Zone的值指定信任级别
drop: 丢弃所有进入的包，而不给出任何响应
block: 拒绝所有外部发起的连接，允许内部发起的连接
public: 允许指定的进入连接
external: 同上，对伪装的进入连接，一般用于路由转发
dmz: 允许受限制的进入连接
work: 允许受信任的计算机被限制的进入连接，类似 workgroup
home: 同上，类似 homegroup
internal: 同上，范围针对所有互联网用户
trusted: 信任所有连接


### 端口转发
```
打开端口转发，首先需要打开IP地址伪装
　　firewall-cmd --zone=external --add-masquerade

转发 tcp 22 端口至 3753：
firewall-cmd --zone=external --add-forward-port=22:porto=tcp:toport=3753
转发端口数据至另一个IP的相同端口：
firewall-cmd --zone=external --add-forward-port=22:porto=tcp:toaddr=192.168.1.112
转发端口数据至另一个IP的 3753 端口：
firewall-cmd --zone=external --add-forward-port=22:porto=tcp:：toport=3753:toaddr=192.168.1.112
```

