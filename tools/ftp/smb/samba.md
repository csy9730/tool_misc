# Samba

SMB简介：SMB（Server Message Block）(*nix平台和Win NT4.0又称CIFS)协议是Windows平台标准文件共享协议，Linux平台通过samba来支持。SMB最新版本v3.0，在v2.0基础上针对WAN和分布式有改进。

SMB默认使用445端口。
## server

### linux
samba是一个实现不同操作系统之间文件共享和打印机共享的一种SMB协议的免费软件。




``` bash
yum -y install samba*                    #yum在线安装samba
rpm -qa | grep samba                    #检查samba安装情况


```

标注：Samab服务开启之前需要关闭两个服务，iptables防火墙（如果你熟悉可以不关闭，放行smb的端口即可，SAMBA服务TCP端口139,445  UDP端口 137,138）；selinux服务。


## client

### windows

windows 服务访问共享目录（smb）

添加永久性企业凭据：控制面板----凭据管理器----windows凭据----添加windows凭据，输入共享服务器地址,用户,密码
更改服务的登录用户为桌面用户（不必与访问共享的用户名相同,必须是可以登录到桌面的用户）
直接打开文件浏览器，地址栏输入`\\123.0.0.1`并访问。
或者 点击windows+R键，打开运行对话框，输入`\\123.0.0.1`并访问

如果已经用另一个用户登陆了共享文件夹，图形界面下无法更改登录用户，可在cmd取消现有连接：
``` bash
net use \\123.0.0.1 /delete # 断开，
net use * /delete # 断开所有
```
IIS依赖svchost，无法更改服务的登录用户.

### linux
创建软连接`mklink /d smb \\123.0.0.1`

### android
使用ES文件浏览器
### ios
第三方软件FE Explorer或者Fsharing
### misc
`smb://123.0.0.1` 能否访问？