# ssh

ssh是linux下的远程连接工具，windows安装了mingw环境后也能使用ssh工具。
scp 是建立在ssh远程连接之上的文件复制工具，。

## install
``` bash
yum install sshd 		# centos安装
apt-get install openssh-server # ubuntu 安装这个
service sshd start # 开启sshd服务
service sshd status # 查看服务是否开启
service sshd stop # 关闭ssh服务
service sshd restart # 重启sshd服务
# systemctl 和 service 功能相当
systemctl restart sshd # 重启sshd服务
systemctl status sshd # sshd状态查看

sudo netstat -atlunp | grep sshd # 查看开启端口是否包括sshd服务
$ TCP    192.168.1.101:56576    123.45.67.89:ssh      ESTABLISHED
# 以上说明192.168.1.101地址通过56576端口远程控制 123.45.67.89的ssh的默认端口，已经建立连接成功

logout  # Ctrl + D 退出ssh连接
exit

```

`sudo vim /etc/ssh/sshd_config` 修改 ssh server 配置
``` ini
# 为了避免与windows的ssh服务冲突，这里端口务必修改
Port 2222 
# Privilege Separation is turned on for security
UsePrivilegeSeparation no
# 登陆验证
PasswordAuthentication yes
```

## demo
远程连接需要知道目标的IP地址和端口号，ssh的默认端口号是22。
通过`whoami`查询用户名IP地址和。使用`ip address|grep inet`和`ifconfig`查询ip地址

 `ssh pi@192.168.1.102 -p 22`
 ` ssh -i ~/document/.ssh/id_rsa.pem  u0_a150@192.168.1.102 -p 8022`

`scp -r  -i ~/document/.ssh/id_rsa.pem -P 8022 u0_a150@192.168.1.100:~/storage/downloads/github/batch_misc/misc/py_misc/web/eFlaskTodo  . `



使用logout或exit登出 


## ssh工具

windows下有winscp，putty，vnc等带界面的ssh工具，也支持SSH登陆。

linux下有：vnc，putty，mstsc.exe，xshell。

## 端口转发

**Q**: 如何实现反向远程？适用于一台服务器有公网ip地址，一台客服机无公网ip地址，实现服务器远程控制客服机的情况
**A**: 通过以下实现
在客服机上开启sshd：
``` bash
/usr/sbin/sshd.exe  -p 9999
ssh -N -R 10001:localhost:9999 -p 22 server_user_name@123.45.67.89
# 9999 和10001 端口号可以自行选择，9999为客服机端口号，10001为远程主机接收9999端口并转发出去的端口号
# 等效于 远程主机开启10001端口的sshd服务
# 每次ssh连接sshd，ssh会使用随机端口号连接sshd的指定端口号
```
在服务器机上执行：
`ssh user@localhost -p 10001 `
最终实现： C:10001 ,C:ssh <=> A:9999



**Q**: 如何实现跳板远程控制？适用于一台有公网ip地址的服务器，两台无公网ip地址的客服机A和B，实现客服机B远程控制客服机A的情况
**A**: 参考反向远程方法。
1. 首先A客服机开启反向远程
2. 客服机B远程服务器，
3. 服务器远程客服机A
最终实现客服机B远程控制客服机A。
如果想在本地机B上直接实现远程控制客服机A，需要：
1. 在客服机A开启远程端口转发，`ssh -fNR 3333:localhost:22 root@123.45.67.89`
2. 在客服机B开启本地端口转发 `ssh -fNL 4444:localhost:3333 root@123.45.67.89`
3. 在客服机B控制客服机A：ssh -p 4444 user_A@localhost


### misc

**Q**：多个sshd服务是否可以复用同一个端口号？
**A**：可以使用同一个端口。但是如果某个sshd服务使用了端口转发，需要避免混用同一个端口号。


**Q**: ssh_exchange_identification: Connection closed by remote host
**A**: 
修改/etc/hosts.allow 和/etc/hosts.deny里面的信息,重启SSH服务就可以了.
```
[root@localhost Desktop]# vi /etc/hosts.allow
#########################
sshd: ALL    ##允许所有ip主机均能连接本机
```
有一种情况，就是客户端连接数过多时，也会报这个错误。缺省情况下，SSH终端连接数最大为10个。在这种情况下，需要改SSH的配置文件，


**Q**: 网速不好的情况下，如何避免ssh断开？
**A**:
不修改配置文件,在命令参数里ssh -o ServerAliveInterval=60 这样子只会在需要的连接中保持持久连接.
如果希望永久修改，可以在client端的etc/ssh/ssh_config添加以下
``` ini
ServerAliveInterval 60 ＃ client每隔60秒发送一次请求给server，然后server响应，从而保持连接
ServerAliveCountMax 3  ＃ client发出请求后，服务器端没有响应得次数达到3，就自动断开连接，正常情况下，server不会不响应
```

**Q**: wsl报错：`System has not been booted with systemd as init system (PID 1). Can't operate.`
**A**: 

~/.ssh/known_hosts 文件保存了所有已知的主机的指纹
```
123.45.67.89 ecdsa-sha2-nistp256 IzIWQPPjUWvbJ8KlENX1lu0=AAABLXNoYTItbmOjIGRi9PTtlzdHAyNAIbAE4G+cqk8Al9Ttpa2y3AAE2VjZHNhAyNTmlzdHBBOAcdN+Eaw8AepBnXeK1qsKUZAyDTYAAYAADanrPL86
```

**Q** ：Permission denied (publickey,keyboard-interactive).
**A**： 这种情况是 ~/.ssh/authorized_keys的密码没有通过


**Q**: What does “Normal Shutdown, Thank you for playing [preauth]” In SSH logs mean?

**A**: ?