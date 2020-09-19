# Samba

samba是一个实现不同操作系统之间文件共享和打印机共享的一种SMB协议的免费软件。




``` bash
yum -y install samba*                    #yum在线安装samba
rpm -qa | grep samba                    #检查samba安装情况


```

标注：Samab服务开启之前需要关闭两个服务，iptables防火墙（如果你熟悉可以不关闭，放行smb的端口即可，SAMBA服务TCP端口139,445  UDP端口 137,138）；selinux服务。