# ssh端口转发

每次ssh连接sshd，ssh会使用随机端口号（一般是50000之后的端口号）连接sshd的指定端口号

server 和client 的区别是
server是listening，被动等待，允许1对多，可以自行开启。
client是speek，主动发话，一般1对1，必须指定一个server连接。
server或client和ip和端口号的组合捆绑，
所以端口ip也区分服务端口和客服端口。

ssh远程转发是把本地的服务端口映射到远程服务器上的服务端口。
ssh本地转发是把远程的服务端口映射到本地服务器上的服务端口。



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
可以通过本地转发实现穿过host访问其他ip地址
`ssh -N -f -L 2121:otheripaddr:21 host`