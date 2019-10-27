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

### Ubuntu 16.04设置rc.local开机启动命令/脚本的方法（通过update-rc.d管理Ubuntu开机启动程序/服务）--debian与ubuntu类似

**注意：rc.local脚本里面启动的用户默认为root权限。**

**一、rc.local脚本**

rc.local脚本是一个Ubuntu开机后会自动执行的脚本，我们可以在该脚本内添加命令行指令。该脚本位于/etc/路径下，需要root权限才能修改。

该脚本具体格式如下：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

![复制代码](https://common.cnblogs.com/images/copycode.gif)

```
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.
  
exit 0
```

![复制代码](https://common.cnblogs.com/images/copycode.gif)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

**注意:** 一定要将命令添加在exit 0之前。里面可以直接写命令或者执行Shell脚本文件sh。

**二、关于放在rc.local里面时不启动的问题：**

1、可以先增加日志输出功能，来查看最终为什么这个脚本不启动的原因，这个是Memcached启动时的样例文件：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

![复制代码](https://common.cnblogs.com/images/copycode.gif)

```
#!/bin/sh -e
#
# rc.local
#
# This script is executed at the end of each multiuser runlevel.
# Make sure that the script will "exit 0" on success or any other
# value on error.
#
# In order to enable or disable this script just change the execution
# bits.
#
# By default this script does nothing.

#log
exec 2> /tmp/rc.local.log  # send stderr from rc.local to a log file  
exec 1>&2                  # send stdout to the same log file  
set -x                     # tell sh to display commands before execution 

#Memcached
/usr/local/memcache/bin/memcached -p 11211 -m 64m -d -u root

exit 0
```

![复制代码](https://common.cnblogs.com/images/copycode.gif)

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

2、rc.local文件头部/bin/sh修改为/bin/bash

3、如果是执行sh文件，那么要赋予执行权限sudo chmod +x xxx.sh，然后启动时加上sudo sh xxx.sh

**三、 update-rc.d增加开机启动服务**

**给Ubuntu添加一个开机启动脚本，操作如下：**

**1、新建个脚本文件new_service.sh**

```
#!/bin/bash
# command content
  
exit 0
```

**2、设置权限**

```
sudo chmod 755 new_service.sh
#或者
sudo chmod +x new_service.sh
```

**3、把脚本放置到启动目录下**

```
sudo mv new_service.sh /etc/init.d/
```

**4、将脚本添加到启动脚本**

执行如下指令，在这里90表明一个优先级，越高表示执行的越晚

```
cd /etc/init.d/
sudo update-rc.d new_service.sh defaults 90
```

**5、移除Ubuntu开机脚本**

```
sudo update-rc.d -f new_service.sh remove
```

**6、通过sysv-rc-conf来管理上面启动服务的启动级别等，还是开机不启动**

```
sudo sysv-rc-conf 
```

**7、update-rc.d的详细参数**

使用update-rc.d命令需要指定脚本名称和一些参数，它的格式看起来是这样的（需要在 root 权限下）：

```
update-rc.d [-n] [-f] <basename> remove
update-rc.d [-n] <basename> defaults
update-rc.d [-n] <basename> disable|enable [S|2|3|4|5]
update-rc.d <basename> start|stop <NN> <runlevels>
-n: not really
-f: force
```

其中：

- disable|enable：代表脚本还在/etc/init.d中，并设置当前状态是手动启动还是自动启动。
- start|stop：代表脚本还在/etc/init.d中，开机，并设置当前状态是开始运行还是停止运行。（启用后可配置开始运行与否）
- NN：是一个决定启动顺序的两位数字值。（例如90大于80，因此80对应的脚本先启动或先停止）
- runlevels：则指定了运行级别。

实例：

（1）、添加一个新的启动脚本sample_init_script，并且指定为默认启动顺序、默认运行级别（还记得前面说的吗，首先要有实际的文件存在于/etc/init.d，即若文件/etc/init.d/sample_init_script不存在，则该命令不会执行）：

```
update-rc.d sample_init_script defaults
```

上一条命令等效于（中间是一个英文句点符号）：

```
update-rc.d sample_init_script start 20 2 3 4 5 . stop 20 0 1 6
```

（2）、安装一个启动脚本sample_init_script，指定默认运行级别，但启动顺序为50：

```
update-rc.d sample_init_script defaults 50
```

（3）、安装两个启动脚本A、B，让A先于B启动，后于B停止：

```
update-rc.d A 10 40
update-rc.d B 20 30
```

（4）、删除一个启动脚本sample_init_script，如果脚本不存在则直接跳过：

```
update-rc.d -f sample_init_script remove
```

这一条命令实际上做的就是一一删除所有位于/etc/rcX.d目录下指向/etc/init.d中sample_init_script的链接（可能存在多个链接文件），update-rc.d只不过简化了这一步骤。

（5）禁止Apache/MySQL相关组件开机自启：

```
update-rc.d -f apache2 remove
update-rc.d -f mysql remove
```

**8、服务的启动停止状态**

```
#通过service，比如
sudo service xxx status
sudo service xxx start
sudo service xxx stop
sudo service xxx restart
```

**9、查看全部服务列表**

```
sudo service --status-all
```

 

参考：

<http://www.jamescoyle.net/cheat-sheets/791-update-rc-d-cheat-sheet>（查看全部服务列表）

<http://blog.csdn.net/typ2004/article/details/38712887>

<http://blog.csdn.net/shb_derek1/article/details/8489112>

<http://blog.sina.com.cn/s/blog_79159ef50100z1ax.html>

<http://www.linuxidc.com/Linux/2013-01/77553p2.htm>

<http://www.jb51.net/article/100413.htm>

<http://blog.csdn.net/yplee_8/article/details/50342563>

<http://blog.163.com/zhu329599788@126/blog/static/66693350201731211940840/>

rc.local不启动的原因：

<http://fantaxy025025.iteye.com/blog/2097862>

<http://www.linuxidc.com/Linux/2016-12/138665.htm>

<http://blog.csdn.net/sea_snow/article/details/51051289>

<http://blog.csdn.net/benbenxiongyuan/article/details/58597036>

<http://www.cnblogs.com/liulanghe/p/3376380.html>

<http://blog.csdn.net/zhe_d/article/details/50312967>

 转自：https://www.cnblogs.com/EasonJim/p/7573292.html

 

### Linux 编写一个简单的一键脚本

Linux中我们安装软件或者一些常用操作，都会接触很多命令，有时在关键时刻往往因为忘了一些简单的命令而苦恼，这时，我们不妨把命令写成可执行的批量脚本，可以减少很多重复而又容易忘记的代码，写成一键脚本还有一个好处就是方便迁移，可以直接将写好的sh文件在其他Linux平台运行。

格式：

 文件后缀.sh 
第一行代码需要指定路径来执行程序

\#!/bin/sh 或#!/bin/bash

建议由后者，参见[shell脚本头,#!/bin/sh与#!/bin/bash的区别.](https://www.cnblogs.com/jonnyan/p/8798364.html)

一般一键脚本会要求用户输入各种选项：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 #提示“请输入姓名”并等待30秒，把用户的输入保存入变量name中
 2 read -t 30 -p "请输入用户名称:" name
 3 echo -e "\n"
 4 echo "用户名为:$name"
 5 #提示“请输入密码”并等待30秒，把用户的输入保存入变量age中，输入内容隐藏
 6 read -t 30 -s -p "请输入用户密码:" age
 7 echo -e "\n"
 8 echo "用户密码为:$age"
 9 #提示“请输入性别”并等待30秒，把用户的输入保存入变量sex中，只接受一个字符输入
10 read -t 30 -n 1 -p "请输入用户性别:" sex
11 echo -e "\n"
12 echo "性别为$sex"
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

![img](https://images2018.cnblogs.com/blog/350840/201808/350840-20180808132543286-1566541324.png)

 

逻辑判断：

```
1 read -t 30 -p "请输入用户名称:" isYes
2 if [ "${isYes}" = "yes" ]; then
3 echo "输入了Yes"
4 fi
```

执行并行脚本：

```
1 wget -c http://www.xxx.com/xx.tar.gz && tar zxf xx.tar.gz && cd xx && ./install.sh
```

方法调用：

```
1 print_hello()
2 {
3 echo "hello"
4 }
5 print_hello
```

转自：https://blog.csdn.net/c__chao/article/details/79785571

### echo命令

[Shell内建命令](http://man.linuxde.net/sub/shell%e5%86%85%e5%bb%ba%e5%91%bd%e4%bb%a4)

**echo命令**用于在shell中打印shell变量的值，或者直接输出指定的字符串。linux的echo命令，在shell编程中极为常用, 在终端下打印变量value的时候也是常常用到的，因此有必要了解下echo的用法echo命令的功能是在显示器上显示一段文字，一般起到一个提示的作用。

### 语法

```
echo(选项)(参数)
```

### 选项

```
-e：激活转义字符。
```

使用`-e`选项时，若字符串中出现以下字符，则特别加以处理，而不会将它当成一般文字输出：

- \a 发出警告声；
- \b 删除前一个字符；
- \c 最后不加上换行符号；
- \f 换行但光标仍旧停留在原来的位置；
- \n 换行且光标移至行首；
- \r 光标移至行首，但不换行；
- \t 插入tab；
- \v 与\f相同；
- \\ 插入\字符；
- \nnn 插入nnn（八进制）所代表的ASCII字符；

### 参数

变量：指定要打印的变量。

### 实例

用echo命令打印带有色彩的文字：

**文字色：**

```
echo -e "\e[1;31mThis is red text\e[0m"
This is red text
```

- `\e[1;31m` 将颜色设置为红色
- `\e[0m` 将颜色重新置回

颜色码：重置=0，黑色=30，红色=31，绿色=32，黄色=33，蓝色=34，洋红=35，青色=36，白色=37

**背景色**：

```
echo -e "\e[1;42mGreed Background\e[0m"
Greed Background
```

颜色码：重置=0，黑色=40，红色=41，绿色=42，黄色=43，蓝色=44，洋红=45，青色=46，白色=47

**文字闪动：**

```
echo -e "\033[37;31;5mMySQL Server Stop...\033[39;49;0m"
```

红色数字处还有其他数字参数：0 关闭所有属性、1 设置高亮度（加粗）、4 下划线、5 闪烁、7 反显、8 消隐

转自：http://man.linuxde.net/echo