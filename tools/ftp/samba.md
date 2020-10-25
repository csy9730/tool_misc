# Samba

SMB简介：SMB（Server Message Block）(*nix平台和Win NT4.0又称CIFS)协议是Windows平台标准文件共享协议，Linux平台通过samba来支持。SMB最新版本v3.0，在v2.0基础上针对WAN和分布式有改进。

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
创建软连接mklink /d smb \\123.0.0.1 或直接访问\\123.0.0.1

如果已经用另一个用户登陆了共享文件夹，图形界面下无法更改登录用户，可在cmd取消现有连接：
``` bash
net use \\123.0.0.1 /delete # 断开，
net use * /delete # 断开所有
```
IIS依赖svchost，无法更改服务的登录用户.
