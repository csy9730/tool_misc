## Shadowsocks – libev 服务端的部署    			

[cokebar](https://cokebar.info/archives/author/cokebar) 				[2014-11-27 14:39](https://cokebar.info/archives/767)     				[2020-03-09 19:07](https://cokebar.info/archives/767)     					             		[Linux](https://cokebar.info/software/linux), [探索世界](https://cokebar.info/internet/explore-the-world)              		    					             		[68 条评论](https://cokebar.info/archives/767#comments)              	    			

在VPS上部署shadowsocks，推荐使用C语言编写的基于libev的shadowsocks-libev的服务端。下面介绍在Linux系统的VPS上安装并配置的方法。Linux请采用近期的发行版，不要过老。本文基本是照着github上的readme翻译的，给那些英文苦手一点帮助。本篇只提供部分安装方法，其他方式请参考github上原repo的readme。

由于shadowsocks-libev变动频繁，请以shadowsocks-libev的Github页面的readme为准，如有问题可至issue页面查找有无类似问题，或者发issue提问：

[https://github.com/shadowsocks/shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev)

**如果您还未购买将要购买国外VPS搭建shadowsocks，这里为您推荐几家VPS提供商，详情见[《关于本站》](https://cokebar.info/about/)页面。**

###### 一、安装shadowsocks服务端

**方法1. 从snap安装。**

如果OS支持snap，那么先安装snap core，再安装shadowsocks-libev即可，非常简单；不过后续开机自启等配置步骤是不太一样的，本文暂未描述，暂请自行研究。



```bash
sudo apt-get update 
sudo apt-get install shadowsocks-libev
```



**方法2. 使用脚本自动编译deb安装，适用于Debian (>=8) / Ubuntu 14.04 (Trusty) / 16.04 (Xenial) / 16.10 / Higher**

（会自动编译安装所有依赖包，并同时安装simpleobfs plugin）



```bash
mkdir ./build-area 
cd build-area 
wget https://github.com/shadowsocks/shadowsocks-libev/raw/master/scripts/build_deb.sh chmod +x build_deb.sh ./build_deb.sh all
```



**方法3. 手动编译安装（Ubuntu 16.04 / Debian 8及以上），在你需要从最新master源码编译时候可以使用这种方式。**

先通过git下载源码：



```bash
git clone https://github.com/shadowsocks/shadowsocks-libev.git 
cd shadowsocks-libev 
git submodule update --init --recursive
```



安装必须的包：

```bash
sudo apt-get install --no-install-recommends autoconf automake \    
debhelper pkg-config asciidoc xmlto libpcre3-dev apg pwgen rng-tools \    
libev-dev libc-ares-dev dh-autoreconf libsodium-dev libmbedtls-dev
```



Debian 8的用户，注意需要从[Debian Backports](https://backports.debian.org/)安装libsodium（最低版本v1.0.8）。

注意：新版本需要debhelper版本大于等于10，不满足的请使用Backports安装新版debhelper：



```bash
# 仅举例 Ubuntu 16.04 LTS 
# 先添加backports（添加过的跳过） 
echo 'deb http://archive.ubuntu.com/ubuntu xenial-backports main' >/etc/apt/sources.list.d/xenial-backports.list # 安装 
sudo apt update 
sudo apt install debhelper/xenial-backports # backports中的软件较新，可以顺道更新一下 
sudo apt upgrade
```



然后生成deb包并安装，一步步执行（留意是否出错 如果出错需要检查系统或者之前的步骤）：



```bash
./autogen.sh && dpkg-buildpackage -b -us -uc 
cd .. 
sudo dpkg -i shadowsocks-libev*.deb
```



------

其他Unix-like的系统，特别是Debian-based的Linux发行版如： Ubuntu, Debian or Linux Mint

先从最近的源码编译安装libmbedtls和libsodium



```bash
export LIBSODIUM_VER=1.0.11 
export MBEDTLS_VER=2.4.0 
wget https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VER.tar.gz 

tar xvf libsodium-$LIBSODIUM_VER.tar.gz 
pushd libsodium-$LIBSODIUM_VER 
./configure --prefix=/usr && make 
sudo make install popd 
wget https://tls.mbed.org/download/mbedtls-$MBEDTLS_VER-gpl.tgz 
tar xvf mbedtls-$MBEDTLS_VER-gpl.tgz 
pushd mbedtls-$MBEDTLS_VER 
make SHARED=1 CFLAGS=-fPIC 
sudo make DESTDIR=/usr install 
popd
```



安装依赖包：



Shell

```bash
# Debian / Ubuntu 
sudo apt-get install --no-install-recommends gettext build-essential autoconf libtool libpcre3-dev asciidoc xmlto libev-dev libc-ares-dev automake 
# CentOS / Fedora / RHEL 
sudo yum install gettext gcc autoconf libtool automake make asciidoc xmlto c-ares-devel libev-devel 
# Arch 
sudo pacman -S gettext gcc autoconf libtool automake make asciidoc xmlto libev c-ares
```



编译：

```bash
./autogen.sh && ./configure && make 
sudo make install
```





二、配置与启动

1、配置文件为：/etc/shadowsocks-libev/config.json，格式说明：

```json
{ 
    "server":"example.com or X.X.X.X", 
 	"mode":"tcp_and_udp", 
    "server_port":443, 
    "password":"password", 
    "method":"aes-128-gcm", 
    "fast_open":true, 
    "timeout":60 
}
```





其中：

> *server：主机域名或者IP地址，尽量填IP*
>
> *server_port：服务器监听端口*
>
> *password：密码*
>
> *method：加密方式 所有支持的加密方式请参照官方文档。这里本人推荐只使用支持AEAD的加密方式，包括以下五种：  aes-128-gcm/aes-192-gcm/aes-256-gcm/chacha20-ietf-poly1305/xchacha20-ietf-poly1305*

timeout：连接超时时间，单位秒。要适中。

注意引号。

2、控制启动、停止、重启：

由于目前大部分新的linux发行版都已经支持systemd，因此，可以统一使用如下命令



Shell

```bash
# Start 
sudo systemctl start shadowsocks-libev.service 
# Stop 
sudo systemctl stop shadowsocks-libev.service 
# Restart 
sudo systemctl restart shadowsocks-libev.service
```



 

需要前台运行时候，执行ss-server命令运行，具体用法如下：

```bash
ss-[local|redir|server|tunnel]        
-s <server_host>           host name or ip address of your remote server        
-p <server_port>           port number of your remote server        
-l <local_port>            port number of your local server        
-k <password>              password of your remote server        
-m <encrypt_method>        Encrypt method: rc4-md5, aes-128-gcm, aes-192-gcm, aes-256-	 
		gcm, aes-128-cfb, aes-192-cfb, aes-256-cfb, aes-128-ctr, aes-192-ctr, aes-256-ctr,        
		camellia-128-cfb, camellia-192-cfb, camellia-256-cfb, bf-cfb,  chacha20-poly1305, 
		chacha20-ietf-poly1305 salsa20, chacha20 and chacha20-ietf.        
[-f <pid_file>]            the file path to store pid        
[-t <timeout>]             socket timeout in seconds        
[-c <config_file>]         the path to config file        
[-i <interface>]           network interface to bind,  not available in redir mode        
[-b <local_address>]       local address to bind, not available in server mode        
[-u]                       enable udprelay mode, TPROXY is required in redir mode        
[-U]                       enable UDP relay and disable TCP relay,                                  not available in local mode        
[-L <addr>:<port>]         specify destination server address and port                                  for local port forwarding,  only available in tunnel mode        
[-d <addr>]                setup name servers for internal DNS resolver,                                  only available in server mode        
[--fast-open]              enable TCP fast open,  only available in local and server mode,                                  with Linux kernel > 3.7.0        
[--acl <acl_file>]         config file of ACL (Access Control List)                                  only available in local and server mode        
[--manager-address <addr>] UNIX domain socket address                                  only available in server and manager mode        
[--executable <path>]      path to the executable of ss-server                                  only available in manager mode        
[--plugin <name>]          Enable SIP003 plugin. (Experimental)      
[--plugin-opts <options>]  Set SIP003 plugin options. (Experimental)        [-v]                       verbose mode notes:     ss-redir provides a transparent proxy function and only works on the    Linux platform with iptables.
```



一个例子如：

```bash
ss-server -c /etc/shadowsocks/config.json -u
```



查看shadowsocks是否正确启动并监听相应端口，看到有ss-server进程LISTEN正确的端口就表示成功：



```bash
netstat -lnp | grep ss-server
```



**服务器优化**

\1. 开启TCP Fast Open：

需求： 系统内核版本≥3.7，shadowsocks-libev≥3.0.4。

修改 		/etc/sysctl.conf ，加入如下一行：



`net.ipv4.tcp_fastopen = 3`

执行如下命令使之生效：



`sysctl -p`

配置文件 		/etc/shadowsocks.json 增加一行：

```json
{      
     "server": "X.X.X.X",      
     "server_port": "443",      
     "password": "password",      
     "method": "aes-128-gcm",      
     "fast_open": true 
}
```





\2. 其他优化以及配置单边/双边加速

参照官方说明: http://shadowsocks.org/en/config/advanced.html

不过官方说明里面的TCP流控使用了hybla：



`net.ipv4.tcp_congestion_control = hybla`

这里推荐使用bbr而不是hybla。bbr需要内核版本不小于4.9，如果内核版本不够，需要更换内核。注意换内核操作不当可能导致vps无法开机，如果发生问题，有救援模式的可能还能救一下，否则只能找客服处理；KVM的通常更换内核没有问题，OpenVZ是不支持更换内核的。具体的更换内核和开启bbr的步骤参考这里：

[开启TCP BBR拥塞控制算法](https://github.com/iMeiji/shadowsocks_install/wiki/开启TCP-BBR拥塞控制算法)

再推荐一个一键脚本：

[Debian/Ubuntu 开启 TCP BBR 拥塞算法](https://moeclub.org/2017/06/06/249/)

然后换完内核开启BBR之后，可以再换一个魔改版的BBR，优化了参数：

[Debian/Ubuntu TCP BBR 改进版/增强版](https://moeclub.org/2017/06/24/278/)

注意，OpenVZ的VPS可能无法修改大部分的属性，因此如果想要优化网速需要考虑：

\1. 使用kcptun双边加速；

\2. 通过linux kernel library来实现，同样是一键脚本：

[OpenVZ 平台 Google BBR 一键安装脚本](https://blog.kuoruan.com/116.html)。

**如果您还未购买将要购买国外VPS搭建shadowsocks，这里为您推荐几家VPS提供商，详情见[《关于本站》](https://cokebar.info/about/)页面。**