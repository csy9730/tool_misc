# saltstack快速入门[#](https://www.cnblogs.com/yanjieli/p/10864648.html#saltstack介绍)

## saltstack介绍[#](https://www.cnblogs.com/yanjieli/p/10864648.html#saltstack介绍)

Salt，一种全新的基础设施管理方式，部署轻松，在几分钟内可运行起来，扩展性好，很容易管理上万台服务器，速度够快，服务器之间秒级通讯

**主要功能**
远程执行
配置管理
[Stalstack官方文档](http://docs.saltstack.cn/)

## Saltstack原理[#](https://www.cnblogs.com/yanjieli/p/10864648.html#Saltstack原理)

`Salt`使用`server-agent`通信模型，服务端组件被称为`Salt master`，`agent`被称为`Salt minion`
`Salt master`主要负责向`Salt minions`发送命令，然后聚合并显示这些命令的结果。一个`Salt master`可以管理多个`minion`系统
`Salt server`与`Salt minion`通信的连接由`Salt minion`发起，这也意味着`Salt minion`上不需要打开任何传入端口（从而减少攻击）。`Salt server`使用端口`4505`和`4506`，必须打开端口才能接收到访问连接

[![img](https://img2018.cnblogs.com/blog/1210730/201905/1210730-20190514205959165-1780192722.png)](https://img2018.cnblogs.com/blog/1210730/201905/1210730-20190514205959165-1780192722.png)

- **Publisher** （端口4505）所有`Salt minions`都需要建立一个持续连接到他们收听消息的发布者端口。命令是通过此端口异步发送给所有连接，这使命令可以在大量系统上同时执行。

- **Request Server** （端口4506）`Salt minios`根据需要连接到请求服务器，将结果发送给`Salt master`，并安全地获取请求的文件或特定`minion`相关的数据值（称为`Salt pillar`）。连接到这个端口的连接在`Salt master`和`Salt minion`之间是1:1（不是异步）。



```
[root@salt-master ~]# lsof -i:4505
COMMAND     PID USER   FD   TYPE DEVICE SIZE/OFF NODE NAME
salt-mast 81121 root   16u  IPv4 304019      0t0  TCP *:4505 (LISTEN)
salt-mast 81121 root   18u  IPv4 304082      0t0  TCP salt-master:4505->salt-minion03:37240 (ESTABLISHED)
salt-mast 81121 root   19u  IPv4 307610      0t0  TCP salt-master:4505->salt-minion01:47804 (ESTABLISHED)
salt-mast 81121 root   20u  IPv4 307611      0t0  TCP salt-master:4505->salt-minion02:58594 (ESTABLISHED)
```



## 快速安装[#](https://www.cnblogs.com/yanjieli/p/10864648.html#快速安装)

1.1 配置 yum 仓库



```
# 使用官方自带yum
[root@salt-master ~]# yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest.el7.noarch.rpm
# 或者使用阿里云的yum（建议使用阿里云的，速度快一点）
[root@salt-master ~]# yum -y install https://mirrors.aliyun.com/saltstack/yum/redhat/salt-repo-latest-2.el7.noarch.rpm
[root@salt-master ~]# sed -i "s/repo.saltstack.com/mirrors.aliyun.com\/saltstack/g" /etc/yum.repos.d/salt-latest.repo
[root@salt-master ~]# yum clean all
[root@salt-master ~]# yum makecache
```



1.2 安装Master，并启动服务

```
[root@salt-master ~]# yum -y install salt-master
[root@salt-master ~]# systemctl enable salt-master
[root@salt-master ~]# systemctl start salt-master
```

1.3 安装 Salt-Minion 指向 Salt-Master 网络地址



```
[root@salt-minion01 ~]# yum -y install salt-minion
# 可以使用主机名，也可以使用IP地址
[root@salt-minion01 ~]# cp /etc/salt/minion{,.back}
[root@salt-minion01 ~]# sed -i '/#master: /c\master: salt-master' /etc/salt/minion
[root@salt-minion01 ~]# systemctl enable salt-minion
[root@salt-minion01 ~]# systemctl start salt-minion
```



## SaltStack认证方式[#](https://www.cnblogs.com/yanjieli/p/10864648.html#SaltStack认证方式)

[![img](https://img2018.cnblogs.com/blog/1210730/201905/1210730-20190514210336850-2045208733.png)](https://img2018.cnblogs.com/blog/1210730/201905/1210730-20190514210336850-2045208733.png)

`Salt` 的数据传输是通过 `AES` 加密，`Master` 和 `Minion` 之前在通信之前，需要进行认证。
`Salt` 通过认证的方式保证安全性，完成一次认证后，Master 就可以控制 Minion 来完成各项工作了。

\1. `minion` 在第一次启动时候，会在 `/etc/salt/pki/minion/` 下自动生成 `minion.pem(private key)` 和 `minion.pub(public key)`, 然后将 `minion.pub` 发送给 `master`
\2. `master` 在第一次启动时，会在 `/etc/salt/pki/master/` 下自动生成 `master.pem` 和 `master.pub` ；并且会接收到 `minion` 的 `public key` , 通过 `salt-key` 命令接收 `minion public key`， 会在 `master` 的 `/etc/salt/pki/master/minions`目录下存放以 `minion id` 命令的 `public key` ；验证成功后同时 `minion` 会保存一份 `master public key` 在 minion 的 `/etc/salt/pki/minion/minion_master.pub`里。

**Salt认证原理总结**

```
minion将自己的公钥发送给master
master认证后再将自己的公钥也发送给minion端
```

**Master端认证示例**

1）根据上面提到的认证原理，先看下未认证前的`master`和`minion`的`pki`目录



```
# master上查看
[root@salt-master ~]# tree /etc/salt/pki/
/etc/salt/pki/
├── master
│   ├── master.pem
│   ├── master.pub
│   ├── minions
│   ├── minions_autosign
│   ├── minions_denied
│   ├── minions_pre
│   │   └── salt-minion01
│   └── minions_rejected
└── minion

# minion上查看
[root@salt-minion01 ~]# tree /etc/salt/pki/
/etc/salt/pki/
├── master
└── minion
    ├── minion.pem
    └── minion.pub
```



`2）salt-key`命令解释：



```
[root@salt-master ~]# salt-key -L 
Accepted Keys:        #已经接受的key
Denied Keys:          #拒绝的key
Unaccepted Keys:      #未加入的key
Rejected Keys:        #吊销的key

#常用参数
-L  #查看KEY状态
-A  #允许所有
-D  #删除所有
-a  #认证指定的key
-d  #删除指定的key
-r  #注销掉指定key（该状态为未被认证）

#配置master自动接受请求认证(master上配置 /etc/salt/master)
auto_accept: True
```



`3）salt-key`认证



```
#列出当前所有的key
[root@salt-master ~]# salt-key -L 
Accepted Keys:
Denied Keys:
Unaccepted Keys:
salt-minion01
Rejected Keys:

#添加指定minion的key
[root@salt-master ~]# salt-key -a salt-minion01 -y
The following keys are going to be accepted:
Unaccepted Keys:
salt-minion01
Key for minion salt-minion01 accepted.
#添加所有minion的key
[root@salt-master ~]# salt-key -A -y

[root@salt-master ~]# salt-key -L 
Accepted Keys:
salt-minion01
Denied Keys:
Unaccepted Keys:
Rejected Keys:
```



4）上面认证完成后再次查看`master`和`minion`的`pki`目录



```
# master上
[root@salt-master ~]# tree /etc/salt/pki/
/etc/salt/pki/
├── master
│   ├── master.pem
│   ├── master.pub
│   ├── minions
│   │   └── salt-minion01
│   ├── minions_autosign
│   ├── minions_denied
│   ├── minions_pre
│   └── minions_rejected
└── minion

# minion上
[root@salt-minion01 ~]# tree /etc/salt/pki/
/etc/salt/pki/
├── master
└── minion
    ├── minion_master.pub
    ├── minion.pem
    └── minion.pub
```



## Saltstack远程执行[#](https://www.cnblogs.com/yanjieli/p/10864648.html#Saltstack远程执行)

远程执行是 `Saltstack` 的核心功能之一。主要使用 `salt` 模块批量给选定的 `minion` 端执行相应的命令，并获得返回结果。

1、判断 `salt` 的 `minion` 主机是否存活



```
[root@salt-master ~]# salt '*' test.ping
salt-minion02:
    True
salt-minion03:
    True
salt-minion01:
    True

# salt saltstack自带的一个命令
# * 表示目标主机，这里表示所有目标主机
# test.ping test是saltstack中的一个模块，ping则是这个模块下面的一个方法
```



2、`saltstack`使用 `cmd.run`模块远程执行shell命令

```
#在指定目标minion节点运行uptime命令
[root@salt-master ~]# salt 'salt-minion02' cmd.run 'uptime'
salt-minion02:
     18:13:08 up 28 min,  2 users,  load average: 0.00, 0.04, 0.13
```

## Saltstack配置管理[#](https://www.cnblogs.com/yanjieli/p/10864648.html#Saltstack配置管理)

`Salt` 通过`State`模块来进行文件的管理；通过`YAML`语法来描述，后缀是`.sls`的文件

1、了解 `YAML` 参考：<http://docs.saltstack.cn/topics/yaml/index.html>

```
remove vim:
  pkg.removed:
    - name: vim
```

- 带有ID和每个函数调用的行都以冒号（:)结束。
- 每个函数调用在ID下面缩进两个空格。
- 参数作为列表传递给每个函数。
- 每行包含函数参数的行都以两个空格缩进开头，然后是连字符，然后是一个额外的空格。
- 如果参数采用单个值，则名称和值位于由冒号和空格分隔的同一行中。
- 如果一个参数需要一个列表，则列表从下一行开始，并缩进两个空格

 2、配置`sals` ,定义环境 [参考文档](https://github.com/watermelonbig/SaltStack-Chinese-ManualBook/blob/master/chapter02/02-3.Configuration-Management-配置管理.md)



```
# 定义环境目录
[root@salt-master ~]# vim /etc/salt/master
file_roots:
  base:
    - /srv/salt/base
  dev:
    - /srv/salt/dev
  prod:
    - /srv/salt/prod
# 创建上面定义的目录
[root@salt-master ~]# mkdir -p /srv/salt/{base,dev,prod}
# 重启服务
[root@salt-master ~]# systemctl restart salt-master
```



3、编写第一个`sls`文件



```
# 在base环境下编写第一个安装apache的sls文件
[root@salt-master ~]# cd /srv/salt/base/
[root@salt-master base]# cat apache.sls 
apache-install:
  pkg.installed:
    - name: httpd

apache-service:
  service.running:
    - name: httpd
    - enable: True

# 在dev环境下编写一个安装ftp的sls文件
[root@salt-master base]# cd /srv/salt/dev/
[root@salt-master dev]# cat vsftpd.sls 
vsftpd-install:
  pkg.installed:
    - name: vsftpd

vsftpd-service:
  service.running:
    - name: vsftpd
    - enable: True
```



4、使用`salt`命令的`state`状态模块让`minion`应用配置



```
# 让所有的minion都安装apache（由于salt默认的环境就是base，所以可以直接在后面指定调用的apache.sls文件，不要后缀sls）
[root@salt-master ~]# salt '*' state.sls apache

# 让所有的minion都安装vsftpd（saltenv指定环境）
[root@salt-master ~]# salt '*' state.sls vsftpd saltenv=dev
```



5、使用`salt`的高级状态使不同主机应用不同的配置



```
# topfile入口文件只能放在base环境
[root@salt-master ~]# cat /srv/salt/base/top.sls 
base:
  'salt-minion01':
    - apache
  'salt-minion03':
    - apache
dev:
  'salt-minion02':
    - vsftpd
  'salt-minion03':
    - vsftpd
```



6、使用`salt`命令执行高级状态，会将`top.sls`当做入口文件，进行调用

```
# 将高级状态应用到所有主机
[root@salt-master ~]# salt '*' state.highstate
```

## Saltstack常用配置[#](https://www.cnblogs.com/yanjieli/p/10864648.html#Saltstack常用配置)

1、**Salt Master配置**
`Salt Master`端的配置文件`/etc/salt/master`，常用配置如下：



```
interface:     //指定bind 的地址(默认为0.0.0.0)
publish_port: //指定发布端口(默认为4505)
ret_port: //指定结果返回端口,  与minion配置文件中的master_port对应(默认为4506)
user: //指定master进程的运行用户,如果调整, 则需要调整部分目录的权限(默认为root)
timeout: //指定timeout时间,  如果minion规模庞大或网络状况不好,建议增大该值(默认5s)
keep_jobs: //minion执行结果返回master, master会缓存到本地的cachedir目录,该参数指定缓存多长时间,可查看之间执行结果会占用磁盘空间(默认为24h)
job_cache: //master是否缓存执行结果,如果规模庞大(超过5000台),建议使用其他方式来存储jobs,关闭本选项(默认为True)
file_recv : //是否允许minion传送文件到master 上(默认是Flase)
file_roots: //指定file server目录,  默认为:
    file_roots:    
       base:    
        - /srv/salt     
pillar_roots : //指定pillar 目录,  默认为:
    pillar_roots:     
      base:     
        - /srv/pillar     
log_level: //日志级别
支持的日志级别有'garbage', 'trace', 'debug', info', 'warning', 'error', ‘critical ’ ( 默认为’warning’)
```



2、`Salt Minion`端的配置文件`/etc/salt/minion`，常用配置如下：



```
master: //指定master 主机(默认为salt)
master_port: //指定认证和执行结果发送到master的哪个端口,  与master配置文件中的ret_port对应(默认为4506)
id: //指定本minion的标识, salt内部使用id作为标识(默认为主机名)
user: //指定运行minion的用户.由于安装包,启动服务等操作需要特权用户, 推荐使用root( 默认为root)
cache_jobs : //minion是否缓存执行结果(默认为False)
backup_mode: //在文件操作(file.managed 或file.recurse) 时,  如果文件发送变更,指定备份目录.当前有效
providers : //指定模块对应的providers, 如在RHEL系列中, pkg对应的providers 是yumpkg5
renderer: //指定配置管理系统中的渲染器(默认值为:yaml_jinja )
file_client : //指定file clinet 默认去哪里(remote 或local) 寻找文件(默认值为remote)
loglevel: //指定日志级别(默认为warning)
tcp_keepalive : //minion 是否与master 保持keepalive 检查, zeromq3(默认为True)
```



 

[saltstack远程执行](https://www.cnblogs.com/yanjieli/p/10873051.html)

[saltstack配置管理](https://www.cnblogs.com/yanjieli/p/10877258.html)

[saltstack数据系统](https://www.cnblogs.com/yanjieli/p/10883804.html)

[saltstack状态判断](https://www.cnblogs.com/yanjieli/p/10883853.html)

[saltstack使用salt-ssh](https://www.cnblogs.com/yanjieli/p/10912572.html)

作者：别来无恙-

出处：<https://www.cnblogs.com/yanjieli/p/10864648.html>

版权：本作品采用「[署名-非商业性使用-相同方式共享 4.0 国际](https://creativecommons.org/licenses/by-nc-sa/4.0/)」许可协议进行许可。





 分类: [SaltStack](https://www.cnblogs.com/yanjieli/category/1464191.html)

 标签: [SaltStack](https://www.cnblogs.com/yanjieli/tag/SaltStack/)