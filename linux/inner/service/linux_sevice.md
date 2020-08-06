# [如何停止和禁用Linux系统中的不需要的服务](https://www.cnblogs.com/liushui-sky/p/9442187.html)

从Linux中删除不需要的服务

在本文中，我们将讨论一些您不需要的不需要的应用程序和服务，但它们是在操作系统安装期间默认安装的，并且不知不觉地开始吃您的系统资源。

让我们首先知道使用以下命令在系统上运行什么样的服务。

```
[avishek@howtoing]# ps ax
```

##### 示例输出

```
  PID TTY      STAT   TIME COMMAND
2 ?        S      0:00 [kthreadd]
3 ?        S      0:00  \_ [migration/0]
4 ?        S      0:09  \_ [ksoftirqd/0]
5 ?        S      0:00  \_ [migration/0]
6 ?        S      0:24  \_ [watchdog/0]
7 ?        S      2:20  \_ [events/0]
8 ?        S      0:00  \_ [cgroup]
9 ?        S      0:00  \_ [khelper]
10 ?        S      0:00  \_ [netns]
11 ?        S      0:00  \_ [async/mgr]
12 ?        S      0:00  \_ [pm]
13 ?        S      0:16  \_ [sync_supers]
14 ?        S      0:15  \_ [bdi-default]
15 ?        S      0:00  \_ [kintegrityd/0]
16 ?        S      0:49  \_ [kblockd/0]
17 ?        S      0:00  \_ [kacpid]
18 ?        S      0:00  \_ [kacpi_notify]
19 ?        S      0:00  \_ [kacpi_hotplug]
20 ?        S      0:00  \_ [ata_aux]
21 ?        S     58:46  \_ [ata_sff/0]
22 ?        S      0:00  \_ [ksuspend_usbd]
23 ?        S      0:00  \_ [khubd]
24 ?        S      0:00  \_ [kseriod]
.....
```

现在，让我们快速浏览一下使用接受连接（端口）进程[netstat命令](https://www.howtoing.com/20-netstat-commands-for-linux-network-management/) ，如下图所示。

```
[avishek@howtoing]# netstat -lp
```

##### 示例输出

```
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address               Foreign Address             State       PID/Program name   
tcp        0      0 *:31138                     *:*                         LISTEN      1485/rpc.statd      
tcp        0      0 *:mysql                     *:*                         LISTEN      1882/mysqld         
tcp        0      0 *:sunrpc                    *:*                         LISTEN      1276/rpcbind        
tcp        0      0 *:ndmp                      *:*                         LISTEN      2375/perl           
tcp        0      0 *:webcache                  *:*                         LISTEN      2312/monitorix-http 
tcp        0      0 *:ftp                       *:*                         LISTEN      2174/vsftpd         
tcp        0      0 *:ssh                       *:*                         LISTEN      1623/sshd           
tcp        0      0 localhost:ipp               *:*                         LISTEN      1511/cupsd          
tcp        0      0 localhost:smtp              *:*                         LISTEN      2189/sendmail       
tcp        0      0 *:cbt                       *:*                         LISTEN      2243/java           
tcp        0      0 *:websm                     *:*                         LISTEN      2243/java           
tcp        0      0 *:nrpe                      *:*                         LISTEN      1631/xinetd         
tcp        0      0 *:xmltec-xmlmail            *:*                         LISTEN      2243/java           
tcp        0      0 *:xmpp-client               *:*                         LISTEN      2243/java           
tcp        0      0 *:hpvirtgrp                 *:*                         LISTEN      2243/java           
tcp        0      0 *:5229                      *:*                         LISTEN      2243/java           
tcp        0      0 *:sunrpc                    *:*                         LISTEN      1276/rpcbind        
tcp        0      0 *:http                      *:*                         LISTEN      6439/httpd          
tcp        0      0 *:oracleas-https            *:*                         LISTEN      2243/java         
....
```

在上面的输出中，您注意到您可能不需要在服务器上的一些应用程序，但它们仍然运行如下：

#### smbd和nmbd

smbd和nmbd是Samba进程的守护程序。 你真的需要在Windows或其他机器上导出smb共享。 如果没有！ 为什么这些进程运行？ 您可以安全地终止这些进程，并禁止它们在下次引导计算机时自动启动。

#### 2. Telnet

你需要通过互联网或局域网进行双向交互式文本导向通信吗？ 如果没有！ 杀死这个进程并关闭它从启动开始。

#### 3. rlogin

您需要通过网络登录到另一台主机。 如果没有！ 杀死此进程并禁止它在启动时自动启动。

#### rexec

远程进程执行也称为rexec，您可以在远程计算机上执行shell命令。 如果不需要在远程机器上执行shell命令，只需杀死该进程即可。

#### 5. FTP

您需要通过Internet将文件从一个主机传输到另一个主机吗？ 如果不是，您可以安全地停止服务。

#### 6.自动挂载

你需要自动挂载不同的文件系统来启动网络文件系统吗？ 如果没有！ 为什么这个进程正在运行？ 为什么要让此应用程序使用您的资源？ 杀死进程并禁止它自动启动。

#### 7.命名

你需要运行NameServer（DNS）吗？ 如果不是在地球上迫使你运行这个过程，并允许吃掉你的资源。 先停止运行的进程，然后在启动时关闭它运行它。

#### 8.lpd

lpd是可以打印到该服务器的打印机守护程序。 如果您不需要从服务器打印，则可能是您的系统资源正在被占用。

#### 9.Inetd

您是否正在运行任何inetd服务？ 如果你运行独立的应用程序像ssh使用其他独立的应用程序像Mysql，Apache等，那么你不需要inetd。 更好地杀死进程，并禁用它自动下次启动。

#### 10. portmap

Portmap是开放网络计算远程过程调用（ONC RPC）并使用守护程序rpc.portmap和rpcbind。 如果这些进程正在运行，则表示您正在运行NFS服务器。 如果NFS服务器运行未注意到意味着您的系统资源被不必要地用尽。

### 如何在Linux中杀死进程

为了杀死在Linux下运行的过程中，使用' **杀PID“**命令。 但是，在运行Kill命令之前，我们必须知道进程的**PID。** 例如，在这里我想找个' **的cupsd“**进程的PID。

```
[avishek@howtoing]# ps ax | grep cupsd
1511 ?        Ss     0:00 cupsd -C /etc/cups/cupsd.conf
```

所以**，'cupsd将** '处理的PID为**“1511”。** 要终止该PID，请运行以下命令。

```
[avishek@howtoing]# kill -9 1511
```

要了解更多关于他们的榜样kill命令，阅读文章[指南kill命令终止在Linux中程序](https://www.howtoing.com/how-to-kill-a-process-in-linux/)

### 如何在Linux中禁用服务

在基于**Red Hat**分发比如**Fedora**和**CentOS，**使用一个名为“脚本[chkconfig的](https://www.howtoing.com/chkconfig-command-examples/) ”在Linux中启用和禁用正在运行的服务。

例如，允许在系统启动时禁用Apache Web服务器。

```
[avishek@howtoing]# chkconfig httpd off
[avishek@howtoing]# chkconfig httpd --del
```

在基于**Debian的**发行版，如**Ubuntu的** **，Linux Mint的**和其他基于Debian的发行版使用一种叫做**更新- rc.d**脚本。

例如，要在系统启动时禁用Apache服务，请执行以下命令。 在这里**，'-f'**选项代表力量是强制性的。

```
[avishek@howtoing]# update-rc.d -f apache2 remove
```

进行这些更改后，系统下次将启动，而不需要这些UN必要的过程，实际上将会节省我们的系统资源，并且服务器将更实用，快速，安全和安全。

 参考：https://www.howtoing.com/remove-unwanted-services-from-linux/

 

很多时候最好把操作命令写成脚本的形式：