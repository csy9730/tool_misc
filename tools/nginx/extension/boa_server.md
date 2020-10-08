# [linux下boa服务器的搭建](https://www.cnblogs.com/interfaceaj/p/5717339.html)

linux下boa服务器的搭建：
CGI：通用网关接口（Common Gateway Interface）是一个Web服务器主机提供信息服务的标准接口。通过CGI接口，Web服务器就能够获取客户端提交的信息，
转交给服务器端的CGI程序进行处理，最后返回结果给客户端。组成CGI通信系统的是两部分：一部分是html页面，就是在用户端浏览器上显示的页面。另一
部分则是运行在服务器上的Cgi程序。cgi不是一种语言，可以理解为一种接口协议，这个协议可以用vb，c，php，python 来实现。

第一步：下载源码：www.boa.org，可在ubuntu下自带的火狐浏览器下载，也可在window下下载，然后再移到ubuntu下；

第二步：打开终端，将boa解压到某目录并进入当前源码目录
  tar xvzf boa-*
  cd /boa-0.94.13/src

第三步：配置 ./configure

第四步：编译首先修改 src/compat.h
   找到    #define TIMEZONE_OFFSET(foo) foo##->tm_gmtoff
   修改成    #define TIMEZONE_OFFSET(foo) (foo)->tm_gmtoff
   不然make会报错

第五步：make

第六步：将/home/boa-0.94.13/src下的boa 和 boa_indexer这两个文件拷贝到/bin目录下。

第七步：复制boa.conf到/etc/boa目录下，如果没有这个目录，自己手动创建 : sudo mkdir /etc/boa
   因为在defines.h文件中：
     \#ifndef SERVER_ROOT
     \#define SERVER_ROOT "/etc/boa"
     \#endif

注意:修改boa相关配置要修改/etc/boa/boa.conf这个文件
   \#Group nogroup   -->改为 Group 0（可选）
   \#ScriptAlias /cgi-bin/ /usr/lib/cgi-bin/   -->改为   ScriptAlias /cgi-bin/ /var/www/cgi-bin/ （可选）
   
第八步: 运行boa,ps -ef |grep boa 看boa是否启动起来

第九步：将一个.html文件拷贝到/var/www目录下,这里以index.html为例（默认目录，可以更改）

第十步：ifconfig看一下ip，我用的是debian，直接打开firefox,地址栏输入：xxx.xxx.xxx.xxx/index.html，回车就可以看到index.html的内容了。
     如果编写了.cgi程序，将对应的.html文件拷贝到/var/www目录下，.cgi程序拷贝到/var/www/cgi-bin/目录下即可。
     
想到的:
   这两天刚学cgi，觉得这个可以用来写路由器的登录界面，之前公司的路由器界面是用lua写的，现在感觉用html也行，用户登录路由器登录界面，在上面
   配置一些参数，由和html对应的.cgi程序处理用户提交的参数，进行处理并写到对应的路由器配置文件中即可。