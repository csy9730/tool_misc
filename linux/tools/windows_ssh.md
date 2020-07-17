# windows ssh

## install
window10自带openssh和wsl，无需安装，
windows7可以安装openssh或者git-bash套件
windowsXp可以安装openssh。

[git-scm](https://git-scm.com/download/win)
[openssh](http://sshwindows.sourceforge.net/)
[openssh371.zip](https://sourceforge.net/projects/sshwindows/files/OldFiles/setupssh371-20031015.zip/download)
[putty](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

## main

以下适用于git-scm的sshd
**Q**: 命令行中直接执行，报错：`sshd re-exec requires execution with an absolute path`
**A**: 执行`"/c/Program Files/Git/usr/bin/sshd.exe"`


**Q**: sshd启动时报错：`Could not load host key: /etc/ssh/ssh_host_rsa_key`
**A**:  在第一次启动sshd时，会要求生成id_ecdsa，id_rsa，id_ed25519这三个文件，充当已经授权的默认公钥文件。
执行以下命令生成密钥即可
``` bash
ssh-keygen -t rsa -b 2048 -f /etc/ssh/ssh_host_rsa_key
ssh-keygen -t ecdsa -b 256 -f /etc/ssh/ssh_host_ecdsa_key
ssh-keygen -t ed25519 -b 256 -f /etc/ssh/ssh_host_ed25519_key

ssh-add /etc/ssh/

cat /etc/ssh/ssh_host_rsa_key.pub>>$USERPROFILE/.ssh/authorized_keys # 添加信任的密钥
# type f:\download\PortableGit\etc\ssh\ssh_host_rsa_key.pub>>%HOME%\.ssh\authorized_keys
```
如果报错`sshd windows permission deny`，需要使用管理员权限打开命令行，在执行命令

**Q**: 装到服务器后不能SSH，解决的方法是，打开配置文件，修改运行ROOT登录，具体方法如下：
**A**: 进入/etc/ssh后找到sshd_config,然后vi sshd_config，找到PermitRootLogin，将no改为yes，即可。


### windows10
自带openssh和wsl子系统，openssh可以很方便的通过ssh连接

wsl
``` 
sudo service ssh restart
```
### xp


1) Run sshwindows installer and click OK and OK…
2) Run cmd.exe:
3) cd C:Program FilesOpenSSHbin (it depends on the sshd’s install location)
4) ‘mkgroup -l >> ..etcgroup’
5) ‘mkpasswd -l >> ..etcpasswd’
6) Configuration the firewall and let it allow the sshd service listening on port 22
7) Start the sshd service: ‘net start “OpenSSH Server”‘

``` bash
cd "C:\Program Files\OpenSSH\bin"
mkgroup -l >> ..etcgroup
mkpasswd -l >> ..etcpasswd
net start opensshd #  开启服务
netstat -an |findstr 22

net stop opensshd #  关闭服务
```


git-bash不支持使用openssh连接
``` bash
$ /C/Windows/System32/OpenSSH/ssh.exe abc@192.168.137.1
Pseudo-terminal will not be allocated because stdin is not a terminal.
CreateProcessW failed error:193
ssh_askpass: posix_spawn: Unknown error
Permission denied, please try again.
CreateProcessW failed error:193
ssh_askpass: posix_spawn: Unknown error
Permission denied, please try again.
CreateProcessW failed error:193
ssh_askpass: posix_spawn: Unknown error
abc@192.168.137.1: Permission denied (publickey,password,keyboard-interactive).
```


**Q**:Unable to negotiate with 192.168.137.1 port 22: no matching key exchange method found. Their offer: diffie-hellman-group-exchange-sha1,diffie-hellman-group1-sha1
**A**: 这是由于sha1加密算法安全性不足已经废弃，需要显式启用该加密算法
`ssh -oKexAlgorithms=+diffie-hellman-group1-sha1 123.123.123.123`
或者在客户端的 ~/.ssh/config添加以下
``` ini
Host 123.123.123.123
    KexAlgorithms +diffie-hellman-group1-sha1
```
或者使用旧版的putty连接。

**Q**: Bad owner or permissions on C:\\Users\\gd_cs/.ssh/config

**A**: 修改.ssh/config的权限
``` 
sudo chmod 600 .ssh/config 
sudo chown $USER .ssh/config
```
方法2： 
右击config,属性→安全→高级→禁止继承→删除所有继承(忘了全称了，大概这个意思)→确定
如果系统是英文：
Properties -> Security -> Advanced -> Disable Inheritance -> Remove all inherited permissions from this object


**Q**: cmd远程启动程序，任务管理器里有，但是前台没有界面，即使是有UI界面的程序；
**A**: 尝试通过计划任务，尝试按键脚本执行。
`SCHTASKS.EXE /create /sc once /tn WeChat /tr "C:\Program Files\Tencent\WeChat\WeChat.exe" /st %time:~0,8%`


**Q**: 通过vbs设置启动项，没有一闪而过的窗口。
**A**: 
``` bash
echo set ws=WScript.CreateObject("WScript.Shell")>"startSshd.vbs"
echo ws.Run "cmd /c /usr/bin/sshd ",vbhide >>"startSshd.vbs"
copy startSshd.vbs  "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup" /y
```


## misc
[Windows上安装配置SSH教程](https://www.cnblogs.com/feipeng8848/p/8568018.html)