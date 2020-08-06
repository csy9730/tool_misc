# misc


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


~/.ssh/identity
~/.ssh/id_dsa
~/.ssh/id_ecdsa
~/.ssh/id_ed25519
~/.ssh/id_rsa
        Contains the private key for authentication.  These files contain sensitive data and should be readable by the user but not accessible by others (read/write/execute).  ssh will simply ignore a pri‐
        vate key file if it is accessible by others.  It is possible to specify a passphrase when generating the key which will be used to encrypt the sensitive part of this file using 3DES.

以上文件的区别是：
identity文件ssh V1使用的，现在都使用ssh V2，按照加密性比较 dsa=rsa <ecdsa < ed25519 ，dsa逐渐被淘汰。
ECDSA （椭圆曲线签名算法）
在第一次启动sshd时，会要求生成id_ecdsa，id_rsa，id_ed25519这三个文件，充当已经授权的默认公钥文件。