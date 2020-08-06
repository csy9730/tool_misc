
### ftp

 FTP 命令：

 (后面有详细说明内容) ftp的命令行格式为: ftp －v －d －i －n －g[主机名] －v 显示远程服务器的所有响应信息。 －d 使用调试方式。 －n 限制ftp的自动登录,即不使用.netrc文件。 －g 取消全局文件名。

 help [命令] 或 ？[命令] 查看命令说明

 bye 或 quit 终止主机FTP进程,并退出FTP管理方式.

 pwd 列出当前远端主机目录

 put 或 send 本地文件名 [上传到主机上的文件名] 将本地一个文件传送至远端主机中 get 或 recv [远程主机文件名] [下载到本地后的文件名] 从远端主机中传送至本地主机中

 mget [remote-files] 从远端主机接收一批文件至本地主机 mput local-files 将本地主机中一批文件传送至远端主机 dir 或 ls [remote-directory] [local-file] 列出当前远端主机目录中的文件.如果有本地文件,就将结果写至本地文件 ascii 设定以ASCII方式传送文件(缺省值) bin 或 image 设定以二进制方式传送文件 bell 每完成一次文件传送,报警提示

 cdup 返回上一级目录

 close 中断与远程服务器的ftp会话(与open对应) open host[port] 建立指定ftp服务器连接,可指定连接端口 delete 删除远端主机中的文件

 mdelete [remote-files] 删除一批文件

 mkdir directory-name 在远端主机中建立目录

 rename [from] [to] 改变远端主机中的文件名

 rmdir directory-name 删除远端主机中的目录 status 显示当前FTP的状态 s

 ystem 显示远端主机系统类型

 user user-name [password] [account] 重新以别的用户名登录远端主机

 open host [port] 重新建立一个新的连接

 prompt 交互提示模式

 macdef 定义宏命令 lcd 改变当前本地主机的工作目录,如果缺省,就转到当前用户的HOME目录

 chmod 改变远端主机的文件权限

 case 当为ON时,用MGET命令拷贝的文件名到本地机器中,全部转换为小写字母 cd remote－dir 进入远程主机目录 cdup 进入远程主机目录的父目录 ! 在本地机中执行交互shell，exit回到ftp环境,如!ls＊.zip

 


### MYSQL
 MYSQL 命令：

 mysql -h主机地址 -u用户名 －p密码 连接MYSQL;如果刚安装好MYSQL，超级用户root是没有密码的。 （例：mysql -h110.110.110.110 -Uroot -P123456 注:u与root可以不用加空格，其它也一样）

 exit 退出MYSQL mysqladmin -u用户名 -p旧密码

 password 新密码修改密码 grant select on 数据库.* to 用户名@登录主机 identified by \"密码\"; 增加新用户。（注意：和上面不同，下面的因为是MYSQL环境中的命令，所以后面都带一个分号作为命令结束符）

 show databases; 显示数据库列表。刚开始时才两个数据库：mysql和test。mysql库很重要它里面有MYSQL的系统信息，我们改密码和新增用户，实际上就是用这个库进行操作。 use mysql； show tables; 显示库中的数据表

 describe 表名; 显示数据表的结构

 create database 库名; 建库 use 库名； create table 表名 (字段设定列表)； 建表 drop database 库名; drop table 表名； 删库和删表 delete from 表名; 将表中记录清空

 select * from 表名; 显示表中的记录 mysqldump --opt school>school.bbb 备份数据库：（命令在DOS的\\mysql\\bin目录下执行）;注释:将数据库school备份到school.bbb文件，school.bbb是一个文本文件，文件名任取，打开看看你会有新发现。

 