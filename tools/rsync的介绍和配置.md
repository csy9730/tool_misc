# rsync的介绍和配置

## 简介

**`rsync`官方网站：**https://rsync.samba.org/

英文全称为Remote synchronization服务软件，缩写`rsync`

`Rsync`是一款**开源的**、**快速的** 多功能的 可以实现**全量**以及**增量**的**本地**或者是**远程**的**数据同步（拷贝）备份**的优秀工具

`rsync`是linux系统下的数据镜像备份工具。使用快速增量备份工具`Remote Sync`可以远程同步，支持本地复制，或者与其他`SSH`、`rsync`主机同步。

目前，已支持跨平台，可以在Windows与Linux间进行数据同步.

## rsync特性

`rsync`支持很多特性：

- 可以镜像保存整个目录树和文件系统文件系统。
- 可以很容易做到保持原来文件的权限、时间、软硬链接等等。
- 无须特殊权限即可安装。
- 快速：第一次同步时 `rsync`会复制全部内容，但在下一次只传输修改过的文件。`rsync`在传输数据的过程中可以实行压缩及解压缩解压缩)操作，因此可以使用更少的带宽。
- 安全：可以使用`scp`、`ssh`等方式来传输文件，当然也可以通过直接的`socket`连接。
- 支持匿名传输，以方便进行网站镜像。

**总结：一个rsync命令相当于scp、cp、rm命令，但是rsync命令比scp、cp、rm命令更胜一筹。**

## **4 rsync工作方式**

一般来说，rsync大致使用三种工作方式来传输数据，分别为：

1. **本地文件系统上实现同步**；单个主机本地之间的数据传输（此时类似于cp命令的功能）
2. **本地主机使用远程shell和远程主机通信**；借助rcp,ssh等通道来传输数据（此时类似于 scp命令的功能）
3. **本地主机通过网络套接字连接远程主机上的rsync daemon**；以守护进程（socket）的方式传输数据（这个是rsync自身的重要的功能）

## **5 rsync的认证协议**

`rsync`命令来同步系统文件之前要先登录`remote`主机认证，认证过程中用到的协议有2种：

- `ssh`协议
- `rsync`协议

在平时使用过程，我们使用最多的是rsync-daemon方式

***5\***|***1\*****rsync认证（rsync-daemon）**

rsync在rsync-daemon认证方式下，默认监听TCP的873端口；

rsync-daemon认证方式是rsync的主要认证方式，这个也是我们经常使用的认证方式；

并且也只有在此种模式下，rsync才可以把密码写入到一个文件中。

**注意：**rsync-daemon认证方式，需要服务器和客户端都安装rsync服务，并且只需要rsync服务器端启动rsync，同时配置rsync配置文件。客户端启动不启动rsync服务，都不影响同步的正常进行

***5\***|***2\*****ssh认证**

rsync在ssh认证方式下，可通过系统用户进行认证，即在rsync上通过ssh隧道进行传输，类似于scp工具；

此时同步操作不在局限于rsync中定义的同步文件夹；

不需要用873端口进行传输。

**注意：**ssh认证方式，不需要服务器和客户端配置rsync配置文件，只需要双方都安装rsync服务，并且也不需要双方启动rsync



```
# 
rsync server端不用启动rsync的daemon进程，只要获取remote host的用户名和密码就可以直接rsync同步文件

#
rsync server端因为不用启动daemon进程，所以也不用配置文件/etc/rsyncd.conf
```

`ssh`认证协议跟`scp`的原理是一样的，如果在同步过程中不想输入密码就用`ssh-keygen -t rsa`打通通道



```
//这种方式默认是省略了 -e ssh 的，与下面等价：
rsync -avz /SRC -e ssh root@192.168.100.10:/DEST 
    -a  //文件宿主变化，时间戳不变
    -V  //显示详细信息的过程
    -z  //压缩数据传输

//当遇到要修改端口的时候，我们可以：
#修改了ssh 协议的端口，默认是22
rsync -avz /SRC -e "ssh -p2222" root@192.168.100.10:/DEST  
```

## **6 *rsync命令*** 安装rsync命令



```
#查看rsync命令需要哪个包
[root@node1 ~]# yum provides */bin/rsync
Updating Subscription Management repositories.
Unable to read consumer identity
This system is not registered to Red Hat Subscription Management. You can use subscription-manager to register.
Last metadata expiration check: 0:00:27 ago on Mon 10 May 2021 03:27:01 PM CST.
rsync-3.1.3-9.el8.x86_64 : A program for synchronizing files over a network
Repo        : @System
Matched from:
Filename    : /usr/bin/rsync

rsync-3.1.3-9.el8.x86_64 : A program for synchronizing files over a network
Repo        : base
Matched from:
Filename    : /usr/bin/rsync

#安装rsync命令
[root@node1 ~]# yum -y install rsync

#安装成功
[root@node1 ~]# which rsync
/usr/bin/rsync
```

## **6.2 rsync命令格式**



```
//Rsync的命令格式常用的有以下三种：
    rsync [OPTION]... SRC DEST
    rsync [OPTION]... SRC [USER@]HOST:DEST
    rsync [OPTION]... [USER@]HOST:SRC DEST

//对应于以上三种命令格式，rsync有三种不同的工作模式：
1）拷贝本地文件。当SRC和DES路径信息都不包含有单个冒号":"分隔符时就启动这种工作模式.
#命令示例
[root@localhost ~]# rsync -avz abc /opt/123
2）使用一个远程shell程序(如rsh、ssh)来实现将本地机器的内容拷贝到远程机器。当DST路径地址包 \
含单个冒号":"分隔符时启动该模式。
#命令示例
[root@localhost ~]# ssh root@192.168.110.10 'ls -l /root'
3)使用一个远程shell程序(如rsh、ssh)来实现将远程机器的内容拷贝到本地机器。当SRC地址路径 \
包含单个冒号":"分隔符时启动该模式。
#命令示例
[root@localhost ~]# rsync -avz root@192.168.110.13:/etc/yum.repos.d /root/
```

***6\***|***3\*****rsync命令参数详情：**



```
-v, --verbose         详细模式输出
-q, --quiet           精简输出模式
-c, --checksum        打开校验开关，强制对文件传输进行校验
-a, --archive         归档模式，表示以递归方式传输文件，并保持所有文件属性，等于-rlptgoD
-r, --recursive       对子目录以递归模式处理
-R, --relative        使用相对路径信息
-b, --backup          创建备份，也就是对于目的已经存在有同样的文件名时，将老的文件重新命名为~filename。可以使用--suffix选项来指定不同的备份文件前缀。
--backup-dir          将备份文件(如~filename)存放在在目录下。
-suffix=SUFFIX        定义备份文件前缀
-u, --update          仅仅进行更新，也就是跳过所有已经存在于DST，并且文件时间晚于要备份的文件。(不覆盖更新的文件)
-l, --links           保留软链结
-L, --copy-links      像对待常规文件一样处理软链接
--copy-unsafe-links   仅仅拷贝指向SRC路径目录树以外的链接
--safe-links          忽略指向SRC路径目录树以外的链接
-H, --hard-links      保留硬链接
-p, --perms           保持文件权限
-o, --owner           保持文件属主信息
-g, --group           保持文件属组信息
-D, --devices         保持设备文件信息
-t, --times           保持文件时间信息
-S, --sparse          对稀疏文件进行特殊处理以节省DST的空间
-n, --dry-run         显示哪些文件将被传输
-W, --whole-file      拷贝文件，不进行增量检测
-x, --one-file-system 不要跨越文件系统边界
-B, --block-size=SIZE 检验算法使用的块尺寸，默认是700字节
-e, --rsh=COMMAND     指定使用rsh、ssh方式进行数据同步
--rsync-path=PATH     指定远程服务器上的rsync命令所在路径信息
-C, --cvs-exclude     使用和CVS一样的方法自动忽略文件，用来排除那些不希望传输的文件
--existing            仅仅更新那些已经存在于DST的文件，而不备份那些新创建的文件
--delete              删除那些DST中SRC没有的文件
--delete-excluded     同样删除接收端那些被该选项指定排除的文件
--delete-after        传输结束以后再删除
--ignore-errors       即使出现IO错误也进行删除
--max-delete=NUM      最多删除NUM个文件
--partial             保留那些因故没有完全传输的文件，以是加快随后的再次传输
--force               强制删除目录，即使不为空
--numeric-ids         不将数字的用户和组ID匹配为用户名和组名
--timeout=TIME        IP超时时间，单位为秒
-I, --ignore-times    不跳过那些有同样的时间和长度的文件
--size-only           当决定是否要备份文件时，仅仅察看文件大小而不考虑文件时间
--modify-window=NUM   决定文件是否时间相同时使用的时间戳窗口，默认为0
-T --temp-dir=DIR     在DIR中创建临时文件
--compare-dest=DIR    同样比较DIR中的文件来决定是否需要备份
-P                    等同于 --partial
--progress            显示备份过程
-z, --compress        对备份的文件在传输时进行压缩处理
--exclude=PATTERN     指定排除不需要传输的文件模式
--include=PATTERN     指定不排除而需要传输的文件模式
--exclude-from=FILE   排除FILE中指定模式的文件
--include-from=FILE   不排除FILE指定模式匹配的文件
--version             打印版本信息
--address             绑定到特定的地址
--config=FILE         指定其他的配置文件，不使用默认的rsyncd.conf文件
--port=PORT           指定其他的rsync服务端口
--blocking-io         对远程shell使用阻塞IO
-stats                给出某些文件的传输状态
--progress            在传输时显示传输过程
--log-format=formAT   指定日志文件格式
--password-file=FILE  从FILE中得到密码
--bwlimit=KBPS        限制I/O带宽，KBytes per second
-h, --help            显示帮助信息
```

***7\***|***0\*****rsync配置**

`rsync`使用方式有三种：

- 模式一：**local 本地模式**
- 模式二：**Access via remote shell 通过远程shell访问**
- 模式三：**daemon 守护进程模式**

***7\***|***1\*****模式一：本地模式**

本地模式直接使用命令就可以了



```
#命令格式
rsync [OPTION…] SRC… [DEST]
```

***7\***|***2\*****模式二：通过远程shell访问**

这种模式一般就是本地通过远程shell命令进行推送和拉取



```
#命令格式
拉取pull：
rsync [OPTION…] [USER@]HOST:SRC… [DEST]

推送push：
rsync [OPTION…] SRC… [USER@]HOST:DEST
```

**注意：**访问端和被访问端都需要安装`rsync`命令

**说明：**在传递文件的时候，会首先对比源和目的下的文件的特征码，只有当特征码不同的时，才会进行传递

**重点说明！！！：**工作中通常都是用rsync+ssh密钥认证方式，目的是为了用免密码登录

***7\***|***3\*****模式三：守护进程模式**

守护进程模式可以进行异地实时同步；

与上面前两种模式对比，就要复杂很多了，但是功能也更加强大；

**注意：**这种模式需要在**源服务器端**安装应用：`rsync`+`inotify-tools`工具；**目标服务器端**安装`rsync`即可。

**守护进程模式配置步骤：****目标服务器配置**

**第一步：创建配置文件rsync.conf（默认不存在）,让其工作在守护进程模式**



```
#rsyncd.conf配置文件说明：

log file = /var/log/rsyncd.log    # 日志文件位置，启动rsync后自动产生这个文件，无需提前创建
pidfile = /var/run/rsyncd.pid     # pid文件的存放位置
lock file = /var/run/rsync.lock   # 支持max connections参数的锁文件
secrets file = /etc/rsync.pass    # 用户认证配置文件，里面保存用户名称和密码，必须手动创建这个文件

[etc_from_client]     # 自定义同步名称
path = /tmp/          # rsync目标服务器数据存放路径，源服务器的数据将同步至此目录
comment = sync etc from client
uid = root        # 设置rsync运行权限为root
gid = root        # 设置rsync运行权限为root
port = 873        # 默认端口
ignore errors     # 表示出现错误忽略错误
use chroot = no       # 默认为true，修改为no，增加对目录文件软连接的备份
read only = no    # 设置rsync源服务器为读写权限
list = no     # 不显示rsync源服务器资源列表
max connections = 200     # 最大连接数
timeout = 600     # 设置超时时间
auth users = admin        # 执行数据同步的用户名，可以设置多个，用英文状态下逗号隔开
hosts allow = 192.168.110.12   # 允许进行数据同步的源服务器IP地址，可以设置多个，用英文状态下逗号隔开
hosts deny = 192.168.110.11      # 禁止数据同步的源服务器IP地址，可以设置多个，用英文状态下逗号隔开
```

**注意：**hosts allow跟 hosts deny

- 两个参数都没有的时候，那么所有用户都可以任意访问
- 只有allow，那么仅仅允许白名单中的用户可以访问模块
- 只有deny，那么仅仅黑名单中的用户禁止访问模块
- 两个参数都存在，后优先检查白名单
- 如果匹配成功，则允许访问
- 如果匹配失败，就去检查黑名单，如果匹配成功则禁止访问
- 如果都没有匹配成功，则允许访问

**第二步：创建密码文件，修改权限为600**

**第三步：创建系统用户**

**第四步：创建模块对应的目录，修改目录的属主属组为系统用户**

**第五步：启动daemon模式**



```
#手动启动
rsync --daemon
#查看873端口起来没
ss -anl

#开机自启
[root@localhost ~]# echo 'OPTIONS=""' > /etc/sysconfig/rsyncd
[root@localhost ~]# vim /usr/lib/systemd/system/rsyncd.service
[Unit]
Description=fast remote file copy program daemon
ConditionPathExists=/etc/rsyncd.conf

[Service]
EnvironmentFile=/etc/sysconfig/rsyncd
ExecStart=/usr/bin/rsync --daemon --no-detach "$OPTIONS"

[Install]
WantedBy=multi-user.target
```

**源服务器配置**

**第一步：安装rsync服务端软件，只需要安装，不要启动，不需要配置**

**第二步：创建认证密码文件**

**第三步：设置密码文件权限，只设置文件所有者具有读取、写入权限即可**

**第四步：在源服务器上创建测试目录，然后在源服务器运行以下命令**



```
//手动同步
#--delete删除那些DST中SRC没有的文件
rsync -avH --port 873 --progress --delete /root/etc/ admin@192.168.110.10::etc_from_client --password-file=/etc/rsync.pass

//实时同步
1. 安装inotify-tools工具，实时触发rsync进行同步
yum -y install inotify-tools
2. 查看服务器内核是否支持inotify
#如果有这三个max开头的文件则表示服务器内核支持inotify
[root@localhost ~]# ll /proc/sys/fs/inotify/
total 0
-rw-r--r--. 1 root root 0 May 11 16:15 max_queued_events
-rw-r--r--. 1 root root 0 May 11 16:15 max_user_instances
-rw-r--r--. 1 root root 0 May 11 16:15 max_user_watches
3. 写同步脚本，此步乃最最重要的一步，请慎之又慎
[root@localhost ~]# mkdir /scripts
[root@localhost ~]# touch /scripts/inotify.sh
[root@localhost ~]# chmod 755 /scripts/inotify.sh
[root@localhost ~]# ll /scripts/inotify.sh
-rwxr-xr-x 1 root root 0 Aug 10 13:02 /scripts/inotify.sh
[root@localhost ~]# vim /scripts/inotify.sh
host=192.168.110.10           # 目标服务器的ip(备份服务器)
src=/etc                        # 在源服务器上所要监控的备份目录（此处可以自定义，但是要保证存在）
des=etc_from_client             # 自定义的模块名，需要与目标服务器上定义的同步名称一致
password=/etc/rsync.pass        # 执行数据同步的密码文件
user=admin                      # 执行数据同步的用户名
inotifywait=/usr/bin/inotifywait

$inotifywait -mrq --timefmt '%Y%m%d %H:%M' --format '%T %w%f%e' -e modify,delete,create,attrib $src \
| while read files;do
    rsync -avzP --delete  --timeout=100 --password-file=${password} $src $user@$host::$des
    echo "${files} was rsynced" >>/tmp/rsync.log 2>&1
done
4. 启动脚本
# &表示后台运行
[root@localhost ~]# nohup bash /scripts/inotify.sh &
[1] 86871
[root@localhost ~]# nohup: ignoring input and appending output to ‘nohup.out’

5. 测试：在源服务器上生成一个新文件
6. 查看inotify生成的日志
```

***7\***|***4\*****本地同步演示：****环境说明：**

| 主机名 | IP地址         | 安装的应用 | 系统版本   |
| :----- | :------------- | :--------- | :--------- |
| node1  | 192.168.110.12 | rsync      | redhat 8.2 |
| node2  | 192.168.110.13 | rsync      | redhat 8.2 |

**准备工作：**



```
//node1
#安装rsync命令
yum -y install rsync
#关闭防火墙，selinux
systemctl stop firewalld
setenforce 0

//node2
#安装rsync命令
yum -y install rsync
#关闭防火墙，selinux
systemctl stop firewalld
setenforce 0
```

**ssh协议本地同步**

**注意：**如果目的地没有这个文件，系统会自动创建这个文件，如果有这个文件只会同步不一样的内容。



```
//node1
//示例一，同步一个文件
#创建一个文件来演示
[root@node1 ~]# echo 123 > abc
[root@node1 ~]# ls
abc  anaconda-ks.cfg
[root@node1 ~]# rsync -avz abc /opt/bcd
sending incremental file list
abc

sent 89 bytes  received 35 bytes  248.00 bytes/sec
total size is 4  speedup is 0.03

#查看
[root@node1 ~]# cat /opt/bcd 
123
[root@node1 ~]# ll abc /opt/bcd 
-rw-r--r--. 1 root root 4 May 10 15:58 abc
-rw-r--r--. 1 root root 4 May 10 15:58 /opt/bcd

//示例二，同步一个目录
#创建一个a目录来演示
[root@node1 ~]# mkdir -p test/test1
[root@node1 ~]# mkdir -p test/test2
[root@node1 ~]# echo 123 > test/test1/abc
[root@node1 ~]# tree test/
test/
├── test1
│   └── abc
└── test2

2 directories, 1 file

#把test这一个目录同步到/opt/123
[root@node1 ~]# rsync -avz test /opt/123
sending incremental file list
created directory /opt/123
test/
test/test1/
test/test1/abc
test/test2/

sent 186 bytes  received 82 bytes  536.00 bytes/sec
total size is 4  speedup is 0.01

#查看
[root@node1 ~]# tree /opt/123/
/opt/123/
└── test
    ├── test1
    │   └── abc
    └── test2

3 directories, 1 file

//示例三，同时同步一个文件一个目录（多个文件同理）
#把anaconda-ks.cfg文件和test目录同步到/opt/haha目录下
[root@node1 ~]# rsync -avz anaconda-ks.cfg test /opt/haha
sending incremental file list
created directory /opt/haha
anaconda-ks.cfg
test/
test/test1/
test/test1/abc
test/test2/

sent 930 bytes  received 102 bytes  2,064.00 bytes/sec
total size is 1,188  speedup is 1.15

#查看
[root@node1 ~]# ls /opt/
123  haha
[root@node1 ~]# tree /opt/haha/
/opt/haha/
├── anaconda-ks.cfg
└── test
    ├── test1
    │   └── abc
    └── test2

3 directories, 2 files
```

**ssh协议非本地同步**



```
//node1
#创建一个abc文件
[root@node1 ~]# touch abc
[root@node1 ~]# ls
abc  anaconda-ks.cfg  test

#把node1上的abc文件同步到node2的/tmp/目录下
[root@node1 ~]# rsync -avz abc root@192.168.110.13:/tmp/
root@192.168.110.13's password: 
sending incremental file list
abc

sent 81 bytes  received 35 bytes  46.40 bytes/sec
total size is 0  speedup is 0.00

//node2
#查看
[root@node2 ~]# ls /tmp/
abc  ks-script-yid42nob  vmware-root_968-2965448017
```

**以上只是举例，其他同步方式同理**

***8\***|***0\*****定期自动同步数据*****8\***|***1\*****计划任务的方式**



```
//node1
#编写脚本
[root@node1 ~]# cat rsync.sh 
#!/bin/bash
rsync -avz root@192.168.110.13:/var/log/messages /rsync/messages.`date +%y%m%d-%H%M`

#计划定时任务：每天00：10分执行脚本，记录日志
[root@node1 ~]# crontab -l
10 00 00 * * bash rsync.sh
```



__EOF__

![img](https://pic.cnblogs.com/avatar/2215668/20201125161225.png)

**本文作者**：**[Leidazhuang 我爱吃芹菜~](https://www.cnblogs.com/leixixi/p/14751914.html)**
**本文链接**：https://www.cnblogs.com/leixixi/p/14751914.html
**关于博主**：努力学习Linux的小萌新，希望从今天开始慢慢提高，一步步走向技术的高峰！
**版权声明**：本博客所有文章除特别声明外，均采用 [BY-NC-SA](https://creativecommons.org/licenses/by-nc-nd/4.0/) 许可协议。转载请注明出处！
**声援博主**：如果您觉得文章对您有帮助，可以点击文章右下角**【[推荐](javascript:void(0);)】**一下。您的鼓励是博主的最大动力！