# [linux中Expect工具的安装及使用方法](https://www.cnblogs.com/liyuanhong/articles/10390785.html)
原文地址：https://blog.csdn.net/wangtaoking1/article/details/78268574

Expect是一个用来处理交互的工具，通常用于需要手动输入数据的场景，可在脚本中使用expect来实现自动化。

## 安装
首先查看系统中是否有安装expect。

```
# whereis expect
```


Expect工具是依赖tcl的，所以也需要安装tcl。

首先下载并安装tcl，这里安装8.4.19版本。

```
# wget https://sourceforge.net/projects/tcl/files/Tcl/8.4.19/tcl8.4.19-src.tar.gz
# tar zxvf tcl8.4.19-src.tar.gz
# cd tcl8.4.19/unix && ./configure
# make
# make install
```


然后下载expect并安装。



```
# wget http://sourceforge.net/projects/expect/files/Expect/5.45/expect5.45.tar.gz
# tar zxvf expect5.45.tar.gz
# cd expect5.45
# ./configure --with-tcl=/usr/local/lib --with-tclinclude=../tcl8.4.19/generic
# make
# make install
# ln -s /usr/local/bin/expect /usr/bin/expect
```




注意这里的configure命令需要使用–with-tclinclude选项传入tcl安装包中的generic文件夹路径。

安装完成之后运行expect命令，查看是否安装成功。

```
# expect
expect1.1> 
```


## 基本操作
Expect脚本中常用的命令包括spawn, expect, send, interact等。

spawn
该命令用于启动一个子进程，执行后续命令

expect
该命令从进程接受字符串，如果接受的字符串和期待的字符串不匹配，则一直阻塞，直到匹配上或者等待超时才继续往下执行

send
向进程发送字符串，与手动输入内容等效，通常字符串需要以’\r’结尾。

interact
该命令将控制权交给控制台，之后就可以进行人工操作了。通常用于使用脚本进行自动化登录之后再手动执行某些命令。如果脚本中没有这一条语句，脚本执行完将自动退出。

set timeout 30
设置超时时间timeout为30s，expect命令阻塞超时时会自动往下继续执行。将timeout配置为-1时表示expect一直阻塞直到与期待的字符串匹配上才继续往下执行。超时时间timeout默认为10s。

[lindex $argv n]
可以在脚本中使用该命令获取在脚本执行时传入的第n个参数。这里argv为传入的参数，另外argv为传入的参数，另外argc表示传入参数的个数，$argv0表示脚本名字。

另外我们也可以使用[lrange $argv sn en]命令获取第sn到第en个参数。

## 实例解析
这里我们写一个脚本，命名为restart_service.exp，该脚本先切换到指定账户，然后下载软件包到tomcat的webapps目录，然后重启tomcat服务。



``` bash
#!/usr/bin/expect

set timeout -1

set user [lindex $argv 0]
set password [lindex $argv 1]
set cmd_prompt "# "

spawn su ${user}
expect ${cmd_prompt}
send "${password}\r"

expect ${cmd_prompt}
send "cd /opt/tomcat/webapps && wget http://host/path/to/package.war\r"
expect "100%"
# 直到wget下载任务打印出100%才表示软件包下载完成

expect ${cmd_prompt}
send "/opt/tomcat/bin/shutdown.sh\r"

expect ${cmd_prompt}
send "/opt/tomcat/bin/startup.sh\r"

expect eof
#interact
```



所有脚本必须以expect eof或者interact结束，一般自动化脚本以expect eof结束就行了

运行`expect restart_service.exp tomcat tomcat123`命令，脚本将使用tomcat账户下载软件包并重启tomcat服务。



 

博客里大都是转载的内容，其目的主要用户知识的组织和管理。

分类: [linux命令行](https://www.cnblogs.com/liyuanhong/category/743058.html), [shell](https://www.cnblogs.com/liyuanhong/category/821170.html)