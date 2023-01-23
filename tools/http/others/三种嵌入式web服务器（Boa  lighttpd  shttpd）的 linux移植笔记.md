# [三种嵌入式web服务器（Boa / lighttpd / shttpd）的 linux移植笔记](https://www.cnblogs.com/oracleloyal/p/5973541.html)



## **一：移植Boa(web服务器)到嵌入式Linux系统**



### **一、Boa程序的移植**

1、下载Boa源码
    下载地址: [http://www.boa.org/](http://www.embeddedlinux.org.cn/html/jishuzixun/201105/link.php?url=http://www.boa.org%2F)
    目前最新发行版本： 0.94.13   （几年没更新版本了）
    下载 boa-0.94.13.tar.gz，

注意：若从boa上下载的是boa-0.94.13.tar.tar，解压方式一样
    解压：

 

2、生成Makefile文件
   进入boa-0.94.13，直接运行src/configure文件



 

3、修改Makefile文件**（注意：必须用cross-2.95.3, 如使用3.4.1、4.1.1等等会出错）** 4、交叉编译



 

5、去除调试信息，减小体积。（可选）

6、将编译好的程序放入根文件系统的/bin目录下。


### **二、配置Boa**

Boa需要在/etc目录下建立一个boa目录，里面放入Boa的主要配置文件boa.conf。在Boa源码目录下已有一个示例boa.conf，可以在其基础上进行修改。

 

1、Group的修改

修改 Group nogroup
为 Group user（开发板上有的组）
修改 User nobody
为 User boa （user组中的一个成员）

根据你的开发板的情况设定。一定要存在的组和用户。

 

以下是我在开发板上的操作：



2、ScriptAlias的修改

修改 ScriptAlias /cgi-bin/  /usr/lib/cgi-bin/
为 ScriptAlias /cgi-bin/  /var/www/cgi-bin/

这是在设置CGI的目录，你也可以设置成别的目录。比如用户文件夹下的某个目录。

3、ServerName的设置

修改 #ServerName [www.your.org.here](http://www.embeddedlinux.org.cn/html/jishuzixun/201105/link.php?url=http://www.your.org.here%2F)
为 ServerName [www.your.org.here](http://www.embeddedlinux.org.cn/html/jishuzixun/201105/link.php?url=http://www.your.org.here%2F)

注意：该项默认为未打开，执行Boa会异常退出，提示“gethostbyname::No such file or directory”,所以必须打开。其它默认设置即可。你也可以设置为你自己想要的名字。比如我设置为：ServerName tekkaman2440

此外，还需要：

将mime.types文件复制/etc目录下，通常可以从linux主机的 /etc目录下直接复制即可。

**（以下配置和boa.conf的配置有关）**

创建日志文件所在目录/var/log/boa

创建HTML文档的主目录/var/www

创建CGI脚本所在录 /var/www/cgi-bin

 

### **三、运行Boa**

开发板操作：

[root@~]#boa

如果发现boa没有运行，则可以在开发板的/var/log/boa/error_log文件中找原因。



**四、功能测试**

静态网页测试

将静态网页存入根文件系统的/var/www目录下（可以将主机 /usr/share/doc/HTML/目录下的index.html、homepage.css和img、stylesheet-images目录复制到/var/www目录下）

我参考《嵌入式Web服务器移植 》的做法如下：

在根文件系统的/var目录下

直接在浏览器中输入开发板的IP地址（比如我的是[http://192.168.1.2](http://www.embeddedlinux.org.cn/html/jishuzixun/201105/link.php?url=http://192.168.1.2%2F)） ，出现fedora的欢迎网页。静态HTML调试成功。

CGI功能测试

1、编写HelloworldCGI.c程序

[tekkamanninja@Tekkaman-Ninja source]$ vi helloworldCGI.c

(主程序的程序开头一定要用Tab，而不是空格，不然编译可能不通过)


2.交叉编译生成CGI程序

 

将helloworldCGI 拷贝至根文件系统的/var/www/cgi-bin/下


3.测试

浏览器输入
   [http://192.168.1.2/cgi-bin/helloworldCGI](http://www.embeddedlinux.org.cn/html/jishuzixun/201105/link.php?url=http://192.168.1.2%2Fcgi-bin%2FhelloworldCGI)

网页出现 **Hello,world.** 调试成功！
 

## **二：移植lighttpd Web服务器到嵌入式linux系统**

 

### **一、下载并解压**
下载的官方主页：[www.lighttpd.net](http://www.embeddedlinux.org.cn/html/jishuzixun/201105/link.php?url=http://www.lighttpd.net)
我下的是目前最新的lighttpd-1.4.18
解压：
[tekkamanninja@Tekkaman-Ninja source]$ tar xjvf lighttpd-1.4.18.tar.bz2

### **二、配置和交叉编译**
[tekkamanninja@Tekkaman-Ninja source]$ cd lighttpd-1.4.18
[tekkamanninja@Tekkaman-Ninja lighttpd-1.4.18]$ CC=/home/tekkamanninja/working/gcc4.1.1/gcc-4.1.1-glibc-2.3.2/arm-9tdmi-linux-gnu/bin/arm-9tdmi-linux-gnu-gcc ./configure -prefix=/lighttpd  -host=arm-9tdmi-linux-gnu --disable-FEUTARE -disable-ipv6 -disable-lfs  

这里特别注意一下：-prefix=/lighttpd ， 我是将软件先装在Host的根目录下的lighttpd文件夹内，然后将其复制到开发板的根文件系统的根目录下。我之所以这样做是因为这个软件在make install时会配置他私有的库文件的路径，在开发板运行时会在-prefix= 的文件加下找他的私有库文件。而我又是交叉编译给开发板，这样配置比较方便移植。

--disable-FEUTARE -disable-ipv6 -disable-lfs 可以不加。

[tekkamanninja@Tekkaman-Ninja lighttpd-1.4.18]$ make

### **三、程序安装**
[tekkamanninja@Tekkaman-Ninja lighttpd-1.4.18]$ make install

拷贝配置文件到开发板根文件系统的etc文件夹并进行适当修改：
[tekkamanninja@Tekkaman-Ninja lighttpd-1.4.18]$ cp doc/lighttpd.conf  /home/tekkamanninja/working/nfs/rootfs/etc/

[tekkamanninja@Tekkaman-Ninja lighttpd-1.4.18]$ kwrite  /home/tekkamanninja/working/nfs/rootfs/etc/lighttpd.conf 

**必需修改的地方有：**

​    server.document-root        = "/srv/www/htdocs/"
改为server.document-root        = "/home/lighttpd/html/"

你可以自己定义，这里就是设置web服务的根目录。

屏蔽一下语句，不然嵌入式这样的小系统下可能无法启动
\#$HTTP["url"] =~ "\.pdf$" {
\#  server.range-requests = "disable"
\#}

开看程序需要那些动态库：
```
[tekkamanninja@Tekkaman-Ninja lighttpd-1.4.18]$ ~/working/gcc4.1.1/gcc-4.1.1-glibc-2.3.2/arm-9tdmi-linux-gnu/bin/arm-9tdmi-linux-gnu-readelf -d src/lighttpd

Dynamic section at offset 0x20790 contains 21 entries:
  Tag        Type                         Name/Value
 0x00000001 (NEEDED)                     Shared library: [libdl.so.2]
 0x00000001 (NEEDED)                     Shared library: [libc.so.6]
 0x0000000c (INIT)                       0xc200
 0x0000000d (FINI)                       0x231c0
 0x00000004 (HASH)                       0x8128
 0x00000005 (STRTAB)                     0xa338
 0x00000006 (SYMTAB)                     0x8b48
 0x0000000a (STRSZ)                      5946 (bytes)
 0x0000000b (SYMENT)                     16 (bytes)
 0x00000015 (DEBUG)                      0x0
 0x00000003 (PLTGOT)                     0x30860
 0x00000002 (PLTRELSZ)                   960 (bytes)
 0x00000014 (PLTREL)                     REL
 0x00000017 (JMPREL)                     0xbe40
 0x00000011 (REL)                        0xbe00
 0x00000012 (RELSZ)                      64 (bytes)
 0x00000013 (RELENT)                     8 (bytes)
 0x6ffffffe (VERNEED)                    0xbd70
 0x6fffffff (VERNEEDNUM)                 2
 0x6ffffff0 (VERSYM)                     0xba72
 0x00000000 (NULL)                       0x0
```
拷贝动态库：
```
[tekkamanninja@Tekkaman-Ninja lighttpd-1.4.18]$ cp ~/working/gcc4.1.1/gcc-4.1.1-glibc-2.3.2/arm-9tdmi-linux-gnu/arm-9tdmi-linux-gnu/lib/libdl-2.3.2.so~/working/nfs/rootfs/lib/
[tekkamanninja@Tekkaman-Ninja lighttpd-1.4.18]$ cp ~/working/gcc4.1.1/gcc-4.1.1-glibc-2.3.2/arm-9tdmi-linux-gnu/arm-9tdmi-linux-gnu/lib/libdl.s*  ~/working/nfs/rootfs/lib/
```
在开发板为此程序新建一个用户及存储网页的根目录以及一个log目录：

开发板操作：
```
[root@~]#adduser -g user lighttpd
Changing password for lighttpd
Enter the new password (minimum of 5, maximum of 8 characters)
Please use a combination of upper and lower case letters and numbers.
Enter new password:
Bad password: too short.

Warning: weak password (continuing).
Re-enter new password:
passwd[786]: password for `lighttpd' changed by user `root'
Password changed.
[root@~]#
```
HOST 操作：
```
[tekkamanninja@Tekkaman-Ninja lighttpd-1.4.18]$ cd ../../nfs/rootfs/home/lighttpd/
[tekkamanninja@Tekkaman-Ninja lighttpd]$ su
```
口令：
```
[root@Tekkaman-Ninja lighttpd]# mkdir html
[root@Tekkaman-Ninja lighttpd]# chmod 777 html/
[root@Tekkaman-Ninja lighttpd]# mkdir  ../../var/log/lighttpd
[root@Tekkaman-Ninja lighttpd]# chmod 777 ../../var/log/lighttpd
```
将移植好的程序（整个目录，其中包含了bin、sbin、lib和share目录）拷贝到开发板根文件系统的根目录下：
```
[root@Tekkaman-Ninja lighttpd]# mv /lighttpd   /home/tekkamanninja/working/nfs/
[root@Tekkaman-Ninja lighttpd]# exit
exit
```
### **四、运行程序**

在开发板上操作：

[root@~]#/lighttpd/sbin/lighttpd -f /etc/lighttpd.conf

将测试静态网页放在server.document-root设置的目录下，并在HOST的浏览器下输入开发板IP，测试通过。

至于CGI的运行，我还不懂配置，有空再研究！

 



## **三：移植shttpd Web服务器到嵌入式Linux系统**

 

### **一、下载并解压**下载的官方主页：[http://shttpd.sourceforge.net/](http://www.embeddedlinux.org.cn/html/jishuzixun/201105/link.php?url=http://shttpd.sourceforge.net%2F)
我下的是目前最新的shttpd-1.39.tar.gz
解压：
[tekkamanninja@Tekkaman-Ninja source]$ tar zxvf shttpd-1.39.tar.gz

 

### **二、配置和交叉编译**
[tekkamanninja@Tekkaman-Ninja source]$ cd shttpd-1.39  
[tekkamanninja@Tekkaman-Ninja shttpd-1.39]$ cd src/
[tekkamanninja@Tekkaman-Ninja src]$ kwrite Makefile

 

只需在前面加上交叉编译器路径就好：
```
CC = /home/tekkamanninja/working/gcc4.1.1/gcc-4.1.1-glibc-2.3.2/arm-9tdmi-linux-gnu/bin/arm-9tdmi-linux-gnu-gcc
AR = /home/tekkamanninja/working/gcc4.1.1/gcc-4.1.1-glibc-2.3.2/arm-9tdmi-linux-gnu/bin/arm-9tdmi-linux-gnu-ar
CFLAGS =  -DNO_SSL
```
 

加上CFLAGS =  -DNO_SSL，是因为如果编译SSL支持，会因符号未定义而无法通过。所以我去除了SSL 支持。

 

**交叉编译：**

[tekkamanninja@Tekkaman-Ninja src]$ make unix

开看程序需要那些动态库：
```
[tekkamanninja@Tekkaman-Ninja src]$ ~/working/gcc4.1.1/gcc-4.1.1-glibc-2.3.2/arm-9tdmi-linux-gnu/bin/arm-9tdmi-linux-gnu-readelf -d shttpd

Dynamic section at offset 0x12cc8 contains 20 entries:
  Tag        Type                         Name/Value
 0x00000001 (NEEDED)                     Shared library: [libc.so.6]
 0x0000000c (INIT)                       0x9180
 0x0000000d (FINI)                       0x18708
 0x00000004 (HASH)                       0x8128
 0x00000005 (STRTAB)                     0x8a5c
 0x00000006 (SYMTAB)                     0x843c
 0x0000000a (STRSZ)                      807 (bytes)
 0x0000000b (SYMENT)                     16 (bytes)
 0x00000015 (DEBUG)                      0x0
 0x00000003 (PLTGOT)                     0x22d90
 0x00000002 (PLTRELSZ)                   704 (bytes)
 0x00000014 (PLTREL)                     REL
 0x00000017 (JMPREL)                     0x8ec0
 0x00000011 (REL)                        0x8e88
 0x00000012 (RELSZ)                      56 (bytes)
 0x00000013 (RELENT)                     8 (bytes)
 0x6ffffffe (VERNEED)                    0x8e48
 0x6fffffff (VERNEEDNUM)                 1
 0x6ffffff0 (VERSYM)                     0x8d84
 0x00000000 (NULL)                       0x0
```

将编译好的程序放入开发板的文件系统下：
[tekkamanninja@Tekkaman-Ninja src]$ cp shttpd /home/tekkamanninja/working/nfs/rootfs/sbin/

 

### **三、运行shttpd**

因为shttpd 没有配置文件，所以配置是由启动参数加的，比如我在开发板中操作如下：
[root@~]#shttpd -root /var/www -ports 80  &

意思是Web 根目录为/var/www 用80端口提供服务。

 

还有别的参数如下：
```
[root@~]#shttpd --help
SHTTPD version 1.39 (c) Sergey Lyubka
usage: shttpd [options] [config_file]
  -A <htpasswd_file>
  -root         Web root directory (default: .)
  -index_files  Index files (default: index.html,index.htm,index.php,index.cgi)
  -ports        Listening ports (default: 80)
  -dir_list     Directory listing (default: 1)
  -cfg_uri      Config uri
  -protect      URI to htpasswd mapping
  -cgi_ext      CGI extensions (default: cgi,pl,php)
  -cgi_interp   CGI interpreter
  -cgi_env      Additional CGI env vars
  -ssi_ext      SSI extensions (default: shtml,shtm)
  -auth_realm   Authentication domain name (default: mydomain.com)
  -auth_gpass   Global passwords file
  -auth_PUT     PUT,DELETE auth file
  -access_log   Access log file
  -error_log    Error log file
  -mime_types   Additional mime types list
  -aliases      Path=URI mappings
  -acl          Allow/deny IP addresses/subnets
  -inetd        Inetd mode (default: 0)
  -uid          Run as user
```
 

**这里说明一下 -cgi_ext  ：shttpd没有CGI 目录的概念，它是通过认文件扩展名来识别的。要运行CGI 程序，默认情况下就要在编译好的程序后面加上 “.cgi””pl””php”等后缀。而 -cgi_ext  是你可以自定义其后缀。**

### **四、开发板测试**

 

**静态网页测试**

在开发板的 /var/www（由-root指定的根目录）放入测试网页：index.html 
在HOST的浏览器中输入开发板地址，测试通过！

 

**CGI测试**

在 /var/www （由-root指定的根目录）放入测试 CGI 程序：helloworldCGI.cgi
 在流览器中输入（开发板地址）192.168.1.2/helloworldCGI.cgi ，测试通过！

 



分类: [嵌入式web](https://www.cnblogs.com/oracleloyal/category/896559.html)