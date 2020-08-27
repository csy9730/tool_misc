# windows ssh

## manager
### install

bash-like的ssh，都是在windows系统上模拟linux环境，可以提供ssh执行依赖和环境，有以下几种： 
[git for windows](https://git-scm.com/download/win)

[msys2 ssh]()

[cygwin-ssh]()

其他ssh是windows-pty风格，有以下类型：

[openssh](https://www.openssh.com/)
[openssh](http://sshwindows.sourceforge.net/) ，[openssh371.zip](https://sourceforge.net/projects/sshwindows/files/OldFiles/setupssh371-20031015.zip/download)

[powershell-Win32-OpenSSH](https://github.com/PowerShell/Win32-OpenSSH/releases)

[OpenSSH-Portable source code](https://github.com/PowerShell/OpenSSH-Portable)

openssh371.zip的版本很旧，发布于2003年，powershell-Win32-OpenSSH较新。

客户端：
[putty](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)

window10自带openssh的客户端，还需要安装服务端sshd；此外也可以使用wsl。
windows7可以安装openssh或者git-bash套件
windowsXp可以安装openssh。


### xp使用OpenSSH


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
### powershell openssh

从[powershell-Win32-OpenSSH](https://github.com/PowerShell/Win32-OpenSSH/releases)下载openssh，解压，然后执行以下程序开始安装：
`powershell install-sshd.ps1`

### powershell openssh for win10 
OpenSSH 客户端和 OpenSSH 服务器是在 Windows Server 2019 和 Windows 10 1809之后才有的组件。
以管理员用户打开powershell
运行命令：
``` powershell
PS C:\Windows\system32> Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'


Name  : OpenSSH.Client~~~~0.0.1.0
State : NotPresent

Name  : OpenSSH.Server~~~~0.0.1.0
State : NotPresent

# 安装OpenSSH：

PS C:\Windows\system32> Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0


Path          :
Online        : True
RestartNeeded : False
```

``` powershell
# Uninstall the OpenSSH Client
Remove-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0

# Uninstall the OpenSSH Server
Remove-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0


Start-Service sshd
Stop-Service sshd
# OPTIONAL but recommended:
Set-Service -Name sshd -StartupType 'Automatic'
# Confirm the Firewall rule is configured. It should be created automatically by setup.
Get-NetFirewallRule -Name *ssh*
# There should be a firewall rule named "OpenSSH-Server-In-TCP", which should be enabled
# If the firewall does not exist, create one
New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
```


### windows10
自带openssh和wsl子系统，openssh可以很方便的通过ssh连接

wsl
``` 
sudo service ssh restart
```

## misc

以下适用于git for windows的sshd
**Q**: 命令行中直接执行，报错：`sshd re-exec requires execution with an absolute path`
**A**: 执行`"/c/Program Files/Git/usr/bin/sshd.exe"`



**Q**: 装到服务器后不能SSH，解决的方法是，打开配置文件，修改运行ROOT登录，具体方法如下：

**A**: 进入/etc/ssh后找到sshd_config,然后用记事本打开sshd_config，找到PermitRootLogin，将no改为yes，即可。



高版本git-bash不支持使用低版本openssh连接
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




**Q**: cmd远程启动程序，任务管理器里有，但是前台没有界面，即使是有UI界面的程序；
**A**: 尝试通过计划任务，尝试按键脚本执行。
`SCHTASKS.EXE /create /sc once /tn WeChat /tr "C:\Program Files\Tencent\WeChat\WeChat.exe" /st %time:~0,8%`
也可能是权限不足？

**Q**: 通过vbs设置启动项，没有一闪而过的窗口。
**A**: 
``` bash
echo set ws=WScript.CreateObject("WScript.Shell")>"startSshd.vbs"
echo ws.Run "cmd /c /usr/bin/sshd ",vbhide >>"startSshd.vbs"
copy startSshd.vbs  "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup" /y
```


## misc
[Windows上安装配置SSH教程](https://www.cnblogs.com/feipeng8848/p/8568018.html)

[openssh_install_firstuse](https://docs.microsoft.com/zh-cn/windows-server/administration/openssh/openssh_install_firstuse)