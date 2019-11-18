# ssh

ssh是linux下的远程连接工具，windows安装了mingw环境后也能使用ssh工具。
scp 是建立在ssh远程连接之上的文件复制工具，。

## install
``` bash
yum install sshd 		# 安装
yum install openssh-server # 或者安装这个
service sshd start # 开启ssh服务
service sshd status # 查看服务是否开启
service sshd stop # 关闭ssh服务
```

## demo
远程连接需要知道目标的IP地址和端口号，ssh的默认端口号是22。
通过whoami和ifconfig查询IP地址和用户名。

 `ssh pi@192.168.1.102 -p 22`
 ` ssh -i C\:/Program\ Files/PuTTY/2/id_rsa.pem  u0_a150@192.168.1.102 -p 8022`

`scp -r  -i C\:/Program\ Files/PuTTY/2/id_rsa.pem -P 8022 u0_a150@192.168.1.100:/data/data/com.termux/files/home/storage/downloads/github/batch_misc/misc/py_misc/web/eFlaskTodo  . `

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

```

## 
## ssh工具

windows下有winscp，putty，vnc等待界面的ssh工具，也支持SSH登陆。

linux下有：vnc，putty，mstsc.exe，xshell。

### misc

腾讯云平台不支持pem 的 ssh登录，只支持ssh密码登陆。
termux不支持ssh密码登陆。只支持pem 的 ssh登录









