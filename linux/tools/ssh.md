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

## pem
需要在客户端生成pem私钥和公钥，再把公钥发送到主机端，主机端添加公钥到授权键
1. 客户端生成pem私钥和公钥
2. 公钥发送到主机端
3. 主机端添加公钥到授权键
4. 客户端连接主机端

生成pem私钥和公钥：`ssh-keygen -t rsa -f my.pem -C "your@email.com"`
参数说明：-t type密钥类型（rsa、dsa...），-f生成文件名，-C备注
公钥发送到主机端可以使用任意方法发送，
添加公钥到授权键：把公钥复制到`~/.ssh/authorized_keys` 文件。


## help
``` bash
 ssh
usage: ssh [-46AaCfGgKkMNnqsTtVvXxYy] [-B bind_interface]
           [-b bind_address] [-c cipher_spec] [-D [bind_address:]port]
           [-E log_file] [-e escape_char] [-F configfile] [-I pkcs11]
           [-i identity_file] [-J [user@]host[:port]] [-L address]
           [-l login_name] [-m mac_spec] [-O ctl_cmd] [-o option] [-p port]
           [-Q query_option] [-R address] [-S ctl_path] [-W host:port]
           [-w local_tun[:remote_tun]] destination [command]

-p <端口>	指定远程服务器上的端口
-F <配置文件>	指定ssh指令的配置文件，默认的配置文件为“/etc/ssh/ssh_config”
-b <IP地址>	 使用本机指定的地址作为对位连接的源IP地址
-l login_name    指定登录远程主机的用户. 可以在配置文件中对每个主机单独设定这个参数.
-g	允许远程主机连接本机的转发端口？
-t  "Force pseudo-terminal allocation." 显示启用用户交互(需要 TTY)
-L port:host:hostport
    将本地机(客户机)的某个端口转发到远端指定机器的指定端口. 工作原理是这样的, 本地机器上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转发出去, 同时远程主机和 host 的 hostport 端口建立连接. 可以在配置文件中指定端口的转发. 只有 root 才能转发特权端口. IPv6 地址用另一种格式说明: port/host/hostport 
-R port:host:hostport
    将远程主机(服务器)的某个端口转发到本地端指定机器的指定端口. 工作原理是这样的, 远程主机上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转向出去, 同时本地主机和 host 的 hostport 端口建立连接. 可以在配置文件中指定端口的转发. 只有用 root 登录远程主机 才能转发特权端口. IPv6 地址用另一种格式说明: port/host/hostport
-D port
    指定一个本地机器 ``动态的 应用程序端口转发. 工作原理是这样的, 本地机器上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转发出去, 根据应用程序的协议可以判断出远程主机将和哪里连接. 目前支持 SOCKS4 协议, 将充当 SOCKS4 服务器. 只有 root 才能转发特权端口. 可以在配置文件中指定动态端口的转发.
```
通过 ssh -v xx.xx.xx.xx 可以查看调试信息

`ssh -O cmd `可以执行单次命令
`ssh nick@xxx.xxx.xxx.xxx "pwd; cat hello.txt"`

ssh会话中执行远程文件复制到本地的操作
## ssh工具

windows下有winscp，putty，vnc等待界面的ssh工具，也支持SSH登陆。

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



**Q**：多个sshd服务是否可以复用同一个端口号？
**A**：可以使用同一个端口。但是如果某个sshd服务使用了端口转发，需要避免混用同一个端口号。



### misc

腾讯云平台不支持pem 的 ssh登录，只支持ssh密码登陆。
termux不支持ssh密码登陆。只支持pem 的 ssh登录
windowsXp支持openssh，所以支持ssh登录，（客户端会显示乱码）
windows7支持msys2-ssh，所以支持ssh登录
由于windows10支持wsl（内嵌unbuntu子系统），所以支持ssh登录

**Q**: ssh_exchange_identification: Connection closed by remote host
**A**: 
修改/etc/hosts.allow 和/etc/hosts.deny里面的信息,重启SSH服务就可以了.
```
[root@localhost Desktop]# vi /etc/hosts.allow
#########################
sshd: ALL    ##允许所有ip主机均能连接本机
```
有一种情况，就是客户端连接数过多时，也会报这个错误。缺省情况下，SSH终端连接数最大为10个。在这种情况下，需要改SSH的配置文件，




**Q**: wsl报错：`System has not been booted with systemd as init system (PID 1). Can't operate.`
**A**: 

**Q**:How to Find All Failed SSH login Attempts in Linux
**A**: 
grep "Failed password" /var/log/auth.log
cat /var/log/auth.log | grep "Failed password"