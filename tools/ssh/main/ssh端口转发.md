# ssh端口转发

每次ssh连接sshd，ssh会使用随机端口号（一般是50000之后的端口号）连接sshd的指定端口号

server 和client 的区别是
server是listening，被动等待，允许1对多，可以自行开启。
client是speek，主动发话，一般1对1，必须指定一个server连接。
server或client和ip和端口号的组合捆绑，
所以ip+port (socket要区分服务端口和客服端口。

ssh的端口转发有以下三种：
* ssh远程转发是把本地的服务端口(真实端口）映射到远程服务器上的服务端口（中转端口）。
* ssh本地转发是把远程的服务端口(真实端口）映射到本地服务器上的服务端口（中转端口），把本地到本地端口的连接转发到远程端口。
* ssh的Socks转发是在本地开启Socks服务器（中转端口），把流量转发到远程的服务器。


-L port:host:hostport
将本地机(客户机)的某个端口转发到远端指定机器的指定端口. 工作原理是这样的, 本地机器上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转发出去, 同时远程主机和 host 的 hostport 端口建立连接. 可以在配置文件中指定端口的转发. 只有 root 才能转发特权端口. IPv6 地址用另一种格式说明: port/host/hostport

-R port:host:hostport
将远程主机(服务器)的某个端口转发到本地端指定机器的指定端口. 工作原理是这样的, 远程主机上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转向出去, 同时本地主机和 host 的 hostport 端口建立连接. 可以在配置文件中指定端口的转发. 只有用 root 登录远程主机才能转发特权端口. IPv6 地址用另一种格式说明: port/host/hostport

-D port
指定一个本地机器 “动态的’’ 应用程序端口转发. 工作原理是这样的, 本地机器上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转发出去, 根据应用程序的协议可以判断出远程主机将和哪里连接. 目前支持 SOCKS4/SOCKS5 协议, 将充当 SOCKS 服务器. 只有 root 才能转发特权端口. 可以在配置文件中指定动态端口的转发.

## 远程转发
远程转发：
A是客户端，B是服务端。
以下的localhost:222指的是相对A客户端的ip地址
A执行 `ssh -NR 333:localhost:222   -p 22 root@B`

B执行 `ssh -p 333 root@B`

``` mermaid
sequenceDiagram
A->>B:  ssh=>22
B-->>B:tmp<=333<=ssh2
B-->>A: 222<=tmp

```
例如：-R X:Y:Z 就是把我们内部的Y机器的Z监听端口映射到远程机器的X监听端口上。
## 本地转发
本地转发
以下的localhost:222指的是相对B服务端的ip地址
A执行 `ssh -NL 4444:localhost:333   -p 22 root@B`

A执行 `ssh -p 4444 root@A`

``` mermaid
sequenceDiagram
A->>B:  A:ssh=>B:22
A-->>B:  A:ssh2=>A:4444=>B:tmp
B-->>B: B:tmp=>B:333
```
例如：-L X:Y:Z 就是远程机器的Y机器的Z监听端口映射到本地机器的X监听端口上。
## 远程转发+本地转发
远程转发+本地转发

C执行 `ssh -NR 333:localhost:222   -p 22 root@B`

A执行 `ssh -NL 4444:localhost:333   -p 22 root@B`

A执行 `ssh -p 4444 root@B`

``` mermaid
sequenceDiagram
A->>B:  ssh=>22
C->>B:  22<=ssh2

A-->>B:  4444=>tmp
B-->>B: tmp=>333

B-->>B:333=>tmp2
B-->>C: tmp2=>222
```

使用了以下端口
* A:ssh,A:4444
* B:22, B:tmp，B:333,B:tmp2
* C:ssh2,C:222
总共8个端口


## socks

## misc
进一步的，bindaddr不一定需要指定本地地址localhost，也可以指定网络地址。

可以通过本地转发实现穿过host访问其他ip地址的ftp服务
`ssh -N -f -L 2121:otheripaddr:21 root@host`
然后使用localhost:2121即可访问otheripaddr的ftp服务，间接通过root@host的服务器。

对于代理服务，使用
`ssh -CNf -D 127.0.0.1:1080 root@host -P 22`
这样使用localhost:1080就可以通过root@host访问任意流量。