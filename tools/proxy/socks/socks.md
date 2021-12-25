# socks

socks是代理协议，根据版本分为socks4和socks5，通常使用socks5协议。



## server

openssh，putty支持转发socks服务。

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

``` bash
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