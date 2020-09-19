# misc


## 密钥文件

~/.ssh/identity
~/.ssh/id_dsa
~/.ssh/id_ecdsa
~/.ssh/id_ed25519
~/.ssh/id_rsa

> Contains the private key for authentication.  These files contain sensitive data and should be readable by the user but not accessible by others (read/write/execute).  ssh will simply ignore a private key file if it is accessible by others.  It is possible to specify a passphrase when generating the key which will be used to encrypt the sensitive part of this file using 3DES.

以上文件的区别是：
identity文件ssh V1使用的，现在都使用ssh V2，按照加密性比较 dsa=rsa <ecdsa < ed25519 ，dsa逐渐被淘汰。
ECDSA （椭圆曲线签名算法）
在第一次启动sshd时，会要求生成id_ecdsa，id_rsa，id_ed25519这三个文件，充当已经授权的默认公钥文件。


**Q**: sshd启动时报错：`Could not load host key: /etc/ssh/ssh_host_rsa_key`
或者报错： `sshd: no hostkeys available — exiting`
或者报错： `Privilege separation user sshd does not exist `


**A**:  在第一次启动sshd时，会要求生成id_ecdsa，id_rsa，id_ed25519这三个文件，充当已经授权的默认公钥文件。
执行以下命令生成密钥即可
``` bash
ssh-keygen -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key
ssh-keygen -t ecdsa -b 256 -f /etc/ssh/ssh_host_ecdsa_key
ssh-keygen -t ed25519 -b 256 -f /etc/ssh/ssh_host_ed25519_key

ssh-add /etc/ssh/
# 添加信任的密钥
cat /etc/ssh/ssh_host_rsa_key.pub>>$HOME/.ssh/authorized_keys 

```

```
ssh-keygen -t rsa -b 2048 -f C:\ProgramData\ssh\ssh_host_rsa_key
ssh-keygen -t ecdsa -b 256 -f C:\ProgramData\ssh\ssh_host_ecdsa_key
ssh-keygen -t ed25519 -b 256 -f C:\ProgramData\ssh\ssh_host_ed25519_key

# 添加信任的密钥
type C:\ProgramData\ssh\ssh_host_rsa_key.pub>>%USERPROFILE%\.ssh\authorized_keys
```


默认在`C:\Users\your_username\.ssh`目录下生成id_rsa文件,id_ecdsa文件,id_ed25519文件, linux_like 路径是`~/.ssh`
如果报错`sshd windows permission deny`，需要使用管理员权限打开命令行，在执行命令

使用openssh for windows，在`%programdata%\ssh`目录下生成id_rsa文件


**Q**: Bad owner or permissions on C:\\Users\\gd_cs/.ssh/config

**A**: 修改.ssh/config的权限
方法1： 
``` bash
sudo chmod 600 .ssh/config 
sudo chown $USER .ssh/config
```

方法2： 
右击config,属性→安全→高级→禁止继承→删除所有继承(忘了全称了，大概这个意思)→确定
如果系统是英文：
Properties -> Security -> Advanced -> Disable Inheritance -> Remove all inherited permissions from this object

## 公钥


**Q**: authorized_keys 文件是什么功能？
**A**: ~/.ssh/authorized_keys 文件，保存了本机的公钥，持有了对应私钥的客户端可以通过ssh控制本机。
内容大概以下格式
```
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDAfX1sjT6AkKv abc@DESKTOP-123456
ssh-rsa AABAQDAfX1sjT6AkKvAAAAB3NzaC1yc2EAAAADAQABA abc@DESKTOP-123456
```
一个主机里面的authorized_keys可以存放多个公钥，一台主机可以持有多个authorized_keys，


**Q**: 什么是 known_hosts文件？
**A**:位置在 ~/.ssh/konwn_hosts中
文件内容如下，包括了本机访问过的域名/ip地址 ，端口，公钥的加密级别，公钥指纹。
``` 
[localhost]:22 ecdsa-sha2-nistp256 AAAAE2VBBBAvJhftz077X+jZHNhLXNoY2ItbmlIbmlzdHAyNTYAAA3Z23LALTLEzdHAyNTYAAAANelNZ8hXpxlunMxfdh5UkdT08DIslgxqXiCj+yHFl+IDA1y6DdgcaIroiNQCkisQ=
[abc]:2222,[123.45.67.89]:2222 ecdsa-sha2-nistp256 AAAAIbmlzdHAyKlENX1AyDE4G+c1TYAAABBBOAcdN+Eaw8AepBnbJ8qk8Al9Ttpa2AAAE2VjZHNhLXNoYTItbmlzdHAyNTYAy3lOjIGRi9PTtXeK1qsKUZDanrPL86IzIWQPPjUWvu0=
```
记录链接到对方时，对方给的host key，每次连线都会检查目前对方给的host key 与你记录的host key是否相同，进行简单的验证。
重装服务器时，需要先进入自己电脑的 ~/.ssh/konwn_hosts 删除原有的服务器的host key


``` 
ssh admin@192.168.2.123
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@    WARNING: REMOTE HOST IDENTIFICATION HAS CHANGED!     @
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
IT IS POSSIBLE THAT SOMEONE IS DOING SOMETHING NASTY!
Someone could be eavesdropping on you right now (man-in-the-middle attack)!
It is also possible that a host key has just been changed.
The fingerprint for the ECDSA key sent by the remote host is
SHA256:DVPHN/qpBNWX32PzGV5V1pSgCSv8rHQvpIpObl2DyKs.
Please contact your system administrator.
Add correct host key in /home/ZAL/.ssh/known_hosts to get rid of this message.
Offending ECDSA key in /home/ZAL/.ssh/known_hosts:1
ECDSA host key for 192.168.2.123 has changed and you have requested strict checking.
Host key verification failed.

CDSA host key for has changed and you have requested strict checking.
Host key verification failed.
```
这个也是本机公钥和目标设备持有的本机公钥对应不上，通过目标设备更新本地公钥，避免出这个问题。
`ssh-keygen -R host`