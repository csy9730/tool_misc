# 解除denyhosts

## main
1. 暂停服务
      1. 暂停rsyslog `service rsyslog stop`
      2. 暂停denyhosts `service denyhosts stop`
2. 从log文件中删除IP记录
      - /var/log/secure
      - /etc/hosts.deny
      - /var/lib/denyhosts/hosts
3. 重启服务
      1. 重新启动denyhosts  `service denyhosts restart`
      2. 重新启动sshd和rsyslog `service rsyslog restart`
      3. 顺便可以重新启动sshd和 iptables

从/var/log/secure文件中指定IP的移除失败的登录事件
从/etc/hosts.deny移除指定IP

此外还有其他denyhosts的记录文件，位于`/var/lib/denyhosts `或`/usr/share/denyhosts/data`

文件如下
- /var/lib/denyhosts/hosts
- /var/lib/denyhosts/hosts-restricted
- /var/lib/denyhosts/hosts-root
- /var/lib/denyhosts/hosts-valid
- /var/lib/denyhosts/offset
- /var/lib/denyhosts/suspicious-logins
- /var/lib/denyhosts/users-hosts
- /var/lib/denyhosts/users-invalid
- /var/lib/denyhosts/users-valid



## demo
可以用`sudo sed -i '/ip/d' /var/log/secure` 来直接修改，并使用`sudo grep "ip" /var/log/secure`来查看是否修改成功

如果不在乎上面的记录文件, 推荐清空上面几个Linux系统日志然后重新开启DennyHosts. 清空上面几个Linux系统日志很简单, 在SSH中敲入下面的命令:`cat /dev/null > /var/log/secure`

不过我不想清空系统日志，所以做了一个简单的ip地址替换。

以下脚本可以一键替换被禁止的ip地址，附带系统服务停止和重启，适用于centos7.
``` bash
systemctl stop rsyslog
# daemon-control stop  
systemctl stop denyhosts

export IP=123.34.56.78 # IP to remove
export IP2=123.34.56.79 # IP to add
sed -i "s/${IP}/${IP2}/g"  /var/log/secure # centos sshd log
sed -i "s/${IP}/${IP2}/g"  /var/log/auth.log # ubuntu sshd log
sed -i "s/${IP}/${IP2}/g"  /etc/hosts.deny

sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/hosts
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/hosts-restricted
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/hosts-root
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/hosts-valid
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/offset
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/suspicious-logins
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/users-hosts
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/users-invalid
sed -i "s/${IP}/${IP2}/g"  /var/lib/denyhosts/users-valid

systemctl restart rsyslog
# daemon-control start 
systemctl start denyhosts
systemctl restart sshd
systemctl restart firewalld
 
```
