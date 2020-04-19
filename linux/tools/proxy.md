# proxy

## 正向代理&反向代理
正向代理是客户端的代理服务器
反向代理是服务端的代理服务器，nginx是常见的静态网页的反向代理服务器。
正向代理中，proxy和client同属一个LAN，对server透明； 反向代理中，proxy和server同属一个LAN，对client透明。 实际上proxy在两种代理中做的事都是代为收发请求和响应，不过从结构上来看正好左右互换了下，所以把前者那种代理方式叫做正向代理，后者叫做反向代理。

 从用途上来区分：

正向代理：正向代理用途是为了在防火墙内的局域网提供访问internet的途径。另外还可以使用缓冲特性减少网络使用率
反向代理：反向代理的用途是将防火墙后面的服务器提供给internet用户访问。同时还可以完成诸如负载均衡等功能
  从安全性来讲：

正向代理：正向代理允许客户端通过它访问任意网站并且隐蔽客户端自身，因此你必须采取安全措施来确保仅为经过授权的客户端提供服务
反向代理：对外是透明的，访问者并不知道自己访问的是代理。对访问者而言，他以为访问的就是原始服务器

透明代理
  透明代理比较类似正向代理的功能，差别在于客户端根本不知道代理的存在，它改编你的request，并会传送真实IP（使用场景就是公司限制网络的访问）。
## HTTP代理
HTTP代理能够代理客户机的HTTP访问，主要是代理浏览器访问网页，它的端口一般为80、8080、3128等；
HTTP代理：80／8080／3128／8081／9080        
SOCKS代理：1080
## SOCKS简单介绍
SOCKS是一种网络传输协议，主要用于客户端与外网服务器之间的通讯的中间传递。SOCKS是 "SOCKETS"的缩写
目前最新的版本是socks5
版本4和5的区别在于5增加支持UDP，验证，以及IPv6，根据OSI模型，SOCKS是会话层的协议，位于表示曾和传输层之间
想要模拟socks的与浏览器进行通信，我们必须要了解SOCKS的允许机制
Socks默认的端口号是1080 

http代理和socks代理的区别
SOCKS其实是一种网络代理协议。该协议所描述的是一种内部主机（使用私有ip地址）通过SOCKS服务器获得完全的Internet访问的方法。具体说来是这样一个环境：用一台运行SOCKS的服务器（双宿主主机【这是什么？】）连接内部网和Internet，内部网主机使用的都是私有的ip地址，内部网主机请求访问Internet时，首先和SOCKS服务器建立一个SOCKS通道，然后再将请求通过这个通道发送给SOCKS服务器，SOCKS服务器在收到客户请求后，向客户请求的Internet主机发出请求，得到相应后，SOCKS服务器再通过原先建立的SOCKS通道将数据返回给客户。
当然在建立SOCKS通道的过程中可能有一个用户认证的过程。
SOCKS和一般的应用层代理服务器完全不同。一般的应用层代理服务器工作在应用层，并且针对不用的网络应用提供不同的处理方法，比如HTTP、FTP、SMTP等，这样，一旦有新的网络应用出现时，应用层代理服务器就不能提供对该应用的代理，因此应用层代理服务器的可扩展性并不好；

与应用层代理服务器不同的是，SOCKS代理服务器旨在提供一种广义S代理工作再线路层（即应用层和传输层之间），这和单纯工作在网络层或传输层的ip欺骗（或者叫做网络地址转换NAT）又有所不同，因为SOCKS不能提供网络层网关服务，比如ICMP包socks4和socks5都属于socks协议，只是由于所支持的具体应用不同而存在差异。socks4代理只支持TCP应用，而socks5代理则可以支持TCP和UDP两种应用。不过由于socks5代理还支持各种身份验证机制，服务器端域名解析等，而socks4代理没有，所以通常对外开放的socks代理都是socks4代理，因此,UDP应用通常都不能被支持。


## tools
### proxychains
什么是proxychains

　　在linux系统中有很多软件是不支持代理的，但是proxychains 却可以让不支持代理的软件

也能走代理通道，支持HTTP，HTTPS,SOCKS4,SOCKS5,等多种代理协议，而且还能配置代理链

(可以理解成多重代理)，可以说是安全渗透的神器！
### squid
squid 这个是传统的代理服务器。
### SSH tunnel

-D listen_port：选项会在本地开启一个Socks服务器.指定一个本地机器 “动态的'’ 应用程序端口转发. 工作原理是这样的, 本地机器上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转发出去, 根据应用程序的协议可以判断出远程主机将和哪里连接. 目前支持 SOCKS4 协议, 将充当 SOCKS4 服务器. 只有 root 才能转发特权端口. 可以在配置文件中指定动态端口的转发.
  -D [bind_address:] port 
   
   Specifies a local “dynamic” application-level port forwarding.  This works by allocating a socket to listen to port on the local side, optionally bound to the specified bind_address.  Whenever a connection is made to this port, the connection is forwarded over the secure channel, and the application protocol is then used to determine where to connect to from the remote machine.  Currently the SOCKS4 and SOCKS5 protocols are supported, and ssh will act as a SOCKS server.  Only root can forward privileged ports. Dynamic port forwardings can also be specified in the configuration file.    
   IPv6 addresses can be specified by enclosing the address in square brackets.  Only the superuser can forward privileged ports.  By default, the local port is bound in accordance with the GatewayPorts setting.  However, an explicit bind_address may be used to bind the connection to a specific address.  The bind_address of “localhost” indicates                     that the listening port be bound for local use only, while an empty address or ‘*’ indicates that the port should be available from all interfaces.    

  -g      Allows remote hosts to connect to local forwarded ports.  If used on a multiplexed connection, then this option must be specified on the master process.
 -g 参数则允许其他主机连接到 -D 在本地创建的代理服务上来。


基本原理就是用ssh做动态端口转发，在本地开启一个端口用做socket代理
bindaddress ：指定绑定ip地址
port ： 指定侦听端口
name： ssh服务器登录名
server： ssh服务器地址
例如，假设把一个树莓派作为SOCKS5代理服务器，该树莓派的IP地址是192.168.4.160，SOCKS5的端口7070，在树莓派中输入如下命令：
ssh -f -N -D 192.168.4.160:7070 pi@127.0.0.1
指定一个远程设备，让设备开启服务器监听指定的ip和端口，。

**Q**: windows下如何杀死ssh socks对应的端口和程序？
**A**: tasklist/taskkill无法找到pid对应的程序，无法关闭。

### plink
下面记一下windows的配置方法：

1. 要有putty（含plink）
   
2. 在命令行下执行命令：plink.exe -C -D 127.0.0.1:localport user@host -pw password

that's enough



有两个补充：

a. 如果是在内网（ssh连接需要通过代理），那么可以在putty中配置好一个session，该session下设置好代理

在上面第2步的命令行中，将host改成putty中配置的session name就可以了

b. 如果觉得每次都要开一个cmd窗口比较麻烦（而且如果网络不稳定断掉了，还得再手工启动），那么可以考虑用MyEnTunnel，更方便

ssh 是一种加密的安全传输协议，socket5是代理协议，这两个有什么区别呢？我们经常看到SSH+SOCKS5的说法，SOCKS5本身就能加密了为何还要增加SSH为其提供加密通道呢？
好像socks5, 只是一个代理吧，并没有加密。
## misc

[Danted Socks5](https://github.com/Lozy/danted)

Firefox + Autoproxy
Chrome + Switchy
如果想让普通命令行程序使用这个 Socket 代理，可以考虑使用 proxychains 这个命令，配置简单并且很好用。

`curl www.google.com --socks5 localhost:7070`
curl: (7) Failed to receive SOCKS5 connect request ack.


"C:\Users\admin\AppData\Local\Google\Chrome\Application\chrome.exe" --show-app-list  --proxy-server="SOCKS5://localhost:7070"

w3m proxy