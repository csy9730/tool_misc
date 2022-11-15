# ssh pem



**Q**: 因为需要经常远程登录到Linux 服务器，每次都得输入一遍密码，比较麻烦！所以，想找找有没有什么方法，可以在调用ssh的时候就指定好密码
**A**: 
方案一：通过ssh-keygen生成RSA，然后采用公钥登陆的。
方案二 (仅适用于*unix系统) ：用Python的expect来发送密码验证，验证通过后，把控制权返还给终端。 Linux下一般使用sshpass(C language) ，还有 python 实现的 sshpass
方案三：采用putty.exe

## pem
需要在客户端生成pem私钥和公钥，再把公钥发送到主机端，主机端添加公钥到授权键
1. 客户端生成pem私钥和公钥
2. 公钥发送到主机端
3. 主机端添加公钥到授权键
4. 客户端连接主机端

生成pem私钥和公钥：`ssh-keygen -t rsa -f my.pem -C "your@email.com"`
参数说明：-t type密钥类型（rsa、dsa...），-f生成文件名，-C随便写的备注
公钥发送到主机端可以使用任意方法发送，
添加公钥到授权键：把公钥复制到`~/.ssh/authorized_keys` 文件。

### misc

- 腾讯云平台不支持pem 的 ssh登录，只支持ssh密码登陆。
- android 的termux不支持ssh密码登陆。只支持pem 的 ssh登录
- windowsXp支持openssh，所以支持ssh登录，（客户端会显示乱码）
- windows7支持msys2-ssh，所以支持ssh登录
- windows10支持openssh
- windows10支持msys2-ssh
- windows10的wsl（内嵌unbuntu子系统）支持ssh登录


## expect

**Q**：为了不每次都执行这么长的命令，也为了不每次都要输入密码，可以使用下面的自动化脚本来完成自动登录的工作：
**A**：自动化脚本

``` bash 
#!/usr/bin/expect
set timeout 60
spawn /usr/bin/ssh -D 7070 -g username@your.hostname.com
expect {
    "*yes/no*" { send "yes\r"; exp_continue }
    "*password:" { send "your_password\r" }
}
interact { timeout 60 { send " "} }
```
上述脚本依赖 expect 程序的支持，使用 yum 或 apt-get 安装：
可以将这个脚本保存到 PATH 中的某个目录下，例如我将它保存为 /usr/local/bin/sshproxy，然后加上执行权限：`chmod +x /usr/local/bin/sshproxy`