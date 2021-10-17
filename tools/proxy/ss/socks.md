# socks

socks是代理协议，根据版本分为socks4和socks5，通常使用socks5协议。

openssh，putty支持转发socks服务。

## server

### SSH tunnel
```
>-D [bind_address:] port    
   Specifies a local “dynamic” application-level port forwarding.  This works by allocating a socket to listen to port on the local side, optionally bound to the specified bind_address.  Whenever a connection is made to this port, the connection is forwarded over the secure channel, and the application protocol is then used to determine where to connect to from the remote machine.  Currently the SOCKS4 and SOCKS5 protocols are supported, and ssh will act as a SOCKS server.  Only root can forward privileged ports. Dynamic port forwardings can also be specified in the configuration file.    
   IPv6 addresses can be specified by enclosing the address in square brackets.  Only the superuser can forward privileged ports.  By default, the local port is bound in accordance with the GatewayPorts setting.  However, an explicit bind_address may be used to bind the connection to a specific address.  The bind_address of “localhost” indicates                     that the listening port be bound for local use only, while an empty address or ‘*’ indicates that the port should be available from all interfaces.   
  -g      Allows remote hosts to connect to local forwarded ports.  If used on a multiplexed connection, then this option must be specified on the master process.  
  -D listen_port：选项会在本地开启一个Socks服务器.指定一个本地机器 “动态的'’ 应用程序端口转发. 工作原理是这样的, 本地机器上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转发出去, 根据应用程序的协议可以判断出远程主机将和哪里连接. 目前支持 SOCKS4 协议, 将充当 SOCKS4 服务器. 只有 root 才能转发特权端口. 可以在配置文件中指定动态端口的转发.  
   -g 参数则允许其他主机连接到 -D 在本地创建的代理服务上来。
```

基本原理就是用ssh做动态端口转发，在本地开启一个端口用做socket代理
bindaddress ：指定绑定ip地址
port ： 指定侦听端口
name： ssh服务器登录名
server： ssh服务器地址
例如，假设把一个树莓派作为SOCKS5代理服务器，该树莓派的IP地址是192.168.4.160，SOCKS5的端口7070，在树莓派中输入如下命令：
`ssh -f -N -D 192.168.4.160:7070 pi@127.0.0.1`
指定一个远程设备，让设备开启服务器监听指定的ip和端口，。



### plink
putty是windows下开源的ssh工具，附带plink工具快速地建立socks服务器
windows的配置方法：
1. 要有putty（含plink）
2. 在命令行下执行命令, 相当于开启远程转发到本地的1080端口 `plink.exe -C -N -D 127.0.0.1:1080 user@host  -pw password `
3. 配置本地的Firefox

SOCKS主机：127.0.0.1
端口：1080
选择 SOCKS v5
复选 远程DNS


如果是在内网（ssh连接需要通过代理），那么可以在putty中配置好一个session，该session下设置好代理
在上面第2步的命令行中，将host改成putty中配置的session name就可以了


## client

### browser
Chrome + Switchy插件
Chrome+ SwitchyOmega 插件
Firefox + Autoproxy插件

chrome浏览器通过命令行启动Socks5代理：
``` bash
# windows
"C:\Users\admin\AppData\Local\Google\Chrome\Application\chrome.exe" --show-app-list  --proxy-server="SOCKS5://localhost:7070"

# linux
/path/to/to/Chrome.exe --proxy-server="socks5://127.0.0.1:1080" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost"
```


chrome://net-internals/#sockets

### curl
curl启动Socks5代理：
`curl www.google.com -x socks5h://localhost:1080 `

**Q** : curl: (7) Failed to receive SOCKS5 connect request ack.
**A**: 

curl: (56) Recv failure: Connection was reset


``` bash
# In curl >= 7.21.7, you can use 
curl -x socks5h://localhost:1080 http://www.google.com/

# In curl >= 7.18.0, you can use 
curl --socks5-hostname localhost:1080 http://www.google.com/

#  depreciated
curl www.google.com --socks5 localhost:1080
```


```
unset all_proxy; unset ALL_PROXY
```
### curl +  https_proxy
直接在bash中启用 socks5代理：


depreciated?
``` bash
export http_proxy="socks5://127.0.0.1:1080"
export https_proxy="socks5://127.0.0.1:1080"

curl www.google.com # fail
```


``` bash
export http_proxy="socks5h://127.0.0.1:1080"
export HTTPS_PROXY="socks5h://127.0.0.1:1080"

curl www.google.com # success
```




### wget
curl 支持 http、https、socks4、socks5

wget 支持 http、https


```
wget www.google.com
Error parsing proxy URL socks5://127.0.0.1:1080: Unsupported scheme ‘socks5’.
```


### linux

#### bash

``` bash
export http_proxy="socks5h://127.0.0.1:1080"
export HTTPS_PROXY="socks5h://127.0.0.1:1080"
```

```
env http_proxy=socks5h://localhost:1080 HTTPS_PROXY=socks5h://localhost:1080 ALL_PROXY=socks5h://localhost:1080 PROG
env ALL_PROXY=socks5h://localhost:1080  curl www.google.com
```


#### proxychains
w3m 如何使用proxy？

在linux让普通命令行程序使用这个 Socket 代理，可以使用 proxychains。proxychains 命令行代理神器.
[proxychains-ng](https://github.com/rofl0r/proxychains-ng) 是proxychains的下一代。

#### Danted
[Danted Socks5](https://github.com/Lozy/danted)

#### haproxy
[haproxy](http://www.haproxy.org/)
HAProxy is a free, very fast and reliable solution offering high availability, load balancing, and proxying for TCP and HTTP-based applications. It is particularly suited for very high traffic web sites and powers quite a number of the world's most visited ones. Over the years it has become the de-facto standard opensource load balancer, is now shipped with most mainstream Linux distributions, and is often deployed by default in cloud platforms. Since it does not advertise itself, we only know it's used when the admins report it :-)

### windows client
#### MyEnTunnel
MyEnTunnel（ssh客户端工具）是plink的GUI前端，因其可以避免记忆复杂的命令行，还可以安全的保存密码，很多人用MyEnTunnel做为windows下的ssh客户端，可以和PortaPuTTY同时工作，也兼容Wine。运行时占用极少量的CPU和系统资源，在访问某些网站查阅技术资料时常常会用到。

#### SocksCap
SocksCap是一个通过Socks代理连接网络的代理服务器第三方支持软件，拥有功能强大的Socks调度，所有Windows应用（如IE、Firefox、QQ、FTP等）都可以使用这个Socks代理工具通过Socks代理服务器上网，即使不支持Socks代理的应用也可以用Socks代理上网。
SocksCap64 是 SocksCap的64位版本。

[SocksCap64](https://www.sockscap64.com/homepage/) support the 32-bit and 64-bit system of Windows XP/Vista/Win7/Win8/Win8.1/Win10 perfectly.

SocksCap64, developed by Taro. It’s designed to reduce delays of cross-regional online game. It can also  assist you to speed up of the network through the socks proxy server, reduce ping of online games. SocksCap64 currently support the SOCKS 4/SOCKS 5/HTTP/Shadowsocks protocols, supports TCP and UDP.
SocksCap64 已经停止开发，并关闭下载。

#### FreeCap
除了SocksCap之外，也可以使用功能和界面几乎完全相同的另一款软件FreeCap来代替

### Privoxy
[Privoxy](https://www.privoxy.org/)
开源，支持windows/linux等多平台。

Privoxy - Home Page
Privoxy logoPrivoxy is a non-caching web proxy with advanced filtering capabilities for enhancing privacy, modifying web page data and HTTP headers, controlling access, and removing ads and other obnoxious Internet junk. Privoxy has a flexible configuration and can be customized to suit individual needs and tastes. It has application for both stand-alone systems and multi-user networks.

Privoxy is Free Software and licensed under the GNU GPLv2 or later.

Privoxy is an associated project of Software in the Public Interest (SPI).


#### proxfier
[proxfier](https://www.proxifier.com/) 带UI的客户端程序，可以提供全局代理，收费软件，支持windows和mac。
#### polipo
[polipo](https://www.irif.fr/~jch/software/polipo/), 不再维护

[https://github.com/jech/polipo](https://github.com/jech/polipo)


## misc
**Q**: SSH和SOCKS5有何关系？
**A**: ssh 是一种加密的安全传输协议，socket5是代理协议，并没有加密。两者没有关系。