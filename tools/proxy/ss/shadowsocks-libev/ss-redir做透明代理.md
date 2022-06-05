# ss-redir做透明代理



> 本文转载自https://www.zfl9.com/ss-redir.html

> [shadowsocks-libev](https://github.com/shadowsocks/shadowsocks-libev)，基于 libev 事件库开发的 shadowsocks 代理套件；主要组件为：`ss-local`、`ss-redir`、`ss-tunnel`、`ss-server`；

## 各组件区别

### `ss-server`

shadowsocks 服务端程序，核心部件之一，各大版本均提供 ss-server 程序。

### `ss-local`

shadowsocks 客户端程序，核心部件之一，各大版本均提供 ss-local 程序。

ss-local 主要提供 socks5 代理，根据 OSI 模型，socks5 是会话层协议；socks5 支持代理 TCP、UDP，是一个全能的代理协议。

在 Linux 上，我们可以使用 [ss-local + privoxy](https://www.zfl9.com/ss-local.html)，来间接使用 ss-local 提供的 socks5 代理。privoxy 有一个 socks5 转发功能，也就是说，我们只要将 privoxy 当做普通 http 代理来使用就好了，它会自动使用 socks5 协议与后端的 ss-local 进行通信。

### `ss-redir`

shadowsocks-libev 提供的**socks5 透明代理**工具，也就是今天这篇文章的主题 - 实现透明代理！

**正向代理** 正向代理，即平常我们所说的代理，比如 http 代理、socks5 代理等，都属于正向代理。 正向代理的特点就是：**如果需要使用正向代理访问互联网，就必须在客户端进行相应的代理设置**。

**透明代理** 透明代理和正向代理的作用是一样的，都是为了突破某些网络限制，访问网络资源。 但是**透明代理对于客户端是透明的，客户端不需要进行相应的代理设置，就能使用透明代理访问互联网**。

**反向代理** 当然，这个不在本文的讨论范畴之内，不过既然提到了前两种代理，就顺便说说反向代理。 反向代理是针对服务端来说的，它的目的不是为了让我们突破互联网限制，而是为了实现负载均衡。

举个栗子： ss-local，提供 socks5 正向代理，我们必须通过专业的代理软件来配置，才能使用它，不然是不会经过代理的； ss-redir，提供 socks5 透明代理，我们只要配置了适当的 iptables 规则，就可以不修改任何软件设置使用它。

### `ss-tunnel`

shadowsocks-libev 提供的**本地端口转发**工具，通常用于解决 dns 污染问题。

假设 ss-tunnel 监听本地端口 53，转发的远程目的地为 8.8.8.8:53；系统 dns 为 127.0.0.1。 去程：上层应用请求 dns 解析 -> ss-tunnel 接收 -> ss 隧道 -> ss-server 接收 -> 8.8.8.8:53； 回程：8.8.8.8:53 响应 dns 请求 -> ss-server 接收 -> ss 隧道 -> ss-tunnel 接收 -> 上层应用。

## 部署环境说明

**总体方案** 系统：CentOS 7.3（VPS）、ArchLinux for ARMv7（树莓派3B） 版本：shadowsocks-libev 3.1.0 端口号：ss-redir：60080、ss-tunnel：60053、chinadns: 65353、dnsforwarder: 53 方案：ss-redir + ss-tunnel + chinadns + dnsforwarder **内网**，使用 ss-redir（开启 udp_relay）代理所有 tcp/udp 流量（dns 除外，必须指向网关）； **本机**，使用 ss-redir 代理 tcp 流量，使用 ss-tunnel 转发 dns 解析请求，其他 udp 流量无法代理。

> 若使用 ss 服务器域名（而非 ip），请将域名与 ip 的映射关系添加至`/etc/hosts`文件中（重要）！

**详细说明** 这篇文章从发表到现在，已经经历过多次改版，因为当初写的时候并未考虑这么周全，甚至对很多具体的原理都不清楚，导致错误百出，实在是闹笑话。

最开始时，我以为 TCP 透明代理和 UDP 透明代理是一样的，只要无脑 REDIRECT 到 ss-redir 监听端口就可以了，因为我很少使用 UDP 代理（DNS 使用 ss-tunnel 解析），因此也没有发现什么不对劲的地方。直到后来，我才知道远远没有这么简单！

首先我们来了解一下 iptables 的 REDIRECT 重定向的意义，REDIRECT 其实就是 DNAT 目的地址转换，只不过它的目的地址为 127.0.0.1，因此给它取了个形象的名字 - 重定向；DNAT 其实是很粗暴的，就是修改数据包的目的 IP 和目的 Port；那么在 ss-redir 中，它是怎么获取数据包原来的目的 IP 和目的 Port 的呢？这就牵扯到 Linux 连接跟踪了。

什么是连接跟踪？顾名思义，就是跟踪并记录网络连接的状态。Linux 会为每个经过网络堆栈的数据包都生成一个新的**连接记录项**，此后，所有属于此连接的数据包都会被唯一分配给这个连接，并标识连接的状态。

因此，ss-redir 只要使用 netfilter 提供的 API 即可从该连接记录项中获取数据包原本的目的地址和目的端口，来进行代理。

但是，你以为就这么简单么？非也，上面这种情况只针对 TCP；对于 UDP，如果你做了 DNAT，就无法再获取数据包的原目的地址和目的端口了，具体的技术细节我不清楚，我们只需要知道 UDP 透明代理没有这么简单。

那么该怎么透明代理 UDP 呢？利用 TPROXY 技术。TPROXY 是在 Kernel 2.6.28 引进的全新的透明代理技术，TPROXY 的原理完全不同于传统的 DNAT 方式。TPROXY 实现透明代理的特点：

- 不对 IP 报文做改动（不做 DNAT）；
- 应用层可用非本机 IP 与其它主机建立 TCP/UDP 连接；
- Kernel 通过 iptables-tproxy 和策略路由将非本机流量送到 socket 层；
- 仍需要通过其它技术拦截到做代理的流量到代理服务器（WCCP 或 PBR（策略路由））。

因为不做 DNAT，因此可以将它应用于 ss-redir 的 UDP 透明代理，这样就不需要担心数据包原目的地址和原目的端口的问题了。 但是，目前 TPROXY 只能应用于 PREROUTING 链的 mangle 表，因此，只能透明代理来自内网的 UDP 流量，对于本机的 UDP 则无能为力，这算是一个小小的遗憾吧。

说完 TCP 和 UDP 的透明代理，我们再来看一下 DNS 污染问题。什么是 DNS 污染这里就不再解释了，网上一搜一大堆。 你肯定有一个疑问，为什么需要 chinadns，而不是直接将本机 DNS 指向 ss-tunnel 呢？使用 ss-tunnel 不是也可以解析 DNS 吗？

是的，ss-tunnel 完全可以胜任 DNS 解析的任务，但是，有两个原因，让我们不得不再套上一个 chinadns：

- 使用 ss-tunnel 会将所有 DNS 请求转发至国外的 DNS（假设为 8.8.8.8），这就带来一个问题，一般大型网站在海外都有服务器，同时还有多个国际域名，每个地区访问的域名是不一样的，你这样无脑的将 DNS 转发到了国外，进行解析，就会给你返回一个国外的 IP，并且会自动跳转到国外域名（比如 www.taobao.com 会跳转至 world.taobao.com 淘宝全球站），这是主要原因；
- 然后就是因为速度问题，我完全没必要将大陆域名的 DNS 解析请求通过 ss-tunnel 转发到国外去，这样没有任何意义。这是次要原因。

所以，我们需要使用 chinadns 这么个东西，它的大致原理如下：

- 首先 chinadns 需要配置至少两个上游 DNS，并且至少一个为国内 DNS，一个为国外 DNS；
- 当 chinadns 解析一个域名时，它会同时向这些 DNS 服务器发送解析请求，如果国内 DNS 返回的地址是国外的，则过滤掉这个结果，使用国外 DNS 返回的地址；做到智能解析。

好了，说明了 chinadns 的必要性之后，我们再来解释一下 dnsforwarder 的作用以及存在的必要性。 dnsforwarder 其实和 pdnsd 是差不多的东西，因为 pdnsd 多年未更新，因此 dnsforwarder 出现了。 和 pdnsd 一样，dnsforwarder 也支持 DNS 缓存，并且可以设置超长的 TTL 值（甚至忽略 TTL），加速 DNS 的解析。 因为使用 ss-tunnel 进行 DNS 解析比较慢，至少也有 80 ms，因此我们需要使用 dnsforwarder 来缓存 DNS 结果。

还有一个问题需要特别注意，那就是内网主机的 DNS 服务器必须指向网关（即指向 dnsforwarder），为什么？ 因为 dnsforwarder 占用了 0.0.0.0:53/udp 地址。导致 TPROXY 无法在网关上监听 8.8.8.8:53/udp 地址（假设 DNS 设为 8.8.8.8），查看 ss-redir 的日志会发现这个错误：`ERROR: [udp] remote_recv_bind: Address already in use`，意思就是地址被占用。

因此，我特意的将 ss-redir、ss-tunnel、chinadns 的端口设为高位端口 60000+，因为几乎没有哪个公共服务会使用这些端口，因此就不会出现类似的地址被占用问题了。

## 安装相关组件

### shadowsocks-libev

ArchLinux 直接使用`pacman -S --need shadowsocks-libev`即可；

CentOS 需要先获取 shadowsocks-libev 的 yum-repo 仓库配置文件：[CentOS 6.x](https://copr.fedorainfracloud.org/coprs/librehat/shadowsocks/repo/epel-6/librehat-shadowsocks-epel-6.repo)、[CentOS 7.x](https://copr.fedorainfracloud.org/coprs/librehat/shadowsocks/repo/epel-7/librehat-shadowsocks-epel-7.repo)； 然后使用 yum 安装即可`yum install shadowsocks-libev -y`。

但是 yum 安装的 shadowsocks-libev 可能不是最新版本，因此，我通常选择编译安装：

```
# 相关依赖包、工具
yum install epel-release -y
yum install git -y
yum install gcc gettext autoconf libtool automake make pcre-devel asciidoc xmlto udns-devel c-ares-devel libev-devel libsodium-devel mbedtls-devel -y

# 获取 shadowsocks-libev
git clone https://github.com/shadowsocks/shadowsocks-libev.git
cd shadowsocks-libev
git submodule update --init --recursive

# 安装 Libsodium
export LIBSODIUM_VER=1.0.12
wget https://download.libsodium.org/libsodium/releases/libsodium-$LIBSODIUM_VER.tar.gz
tar xvf libsodium-$LIBSODIUM_VER.tar.gz
pushd libsodium-$LIBSODIUM_VER
./configure --prefix=/usr && make
sudo make install
popd
sudo ldconfig

# 安装 MbedTLS
export MBEDTLS_VER=2.4.2
wget https://tls.mbed.org/download/mbedtls-$MBEDTLS_VER-gpl.tgz
tar xvf mbedtls-$MBEDTLS_VER-gpl.tgz
pushd mbedtls-$MBEDTLS_VER
make SHARED=1 CFLAGS=-fPIC
sudo make DESTDIR=/usr install
popd
sudo ldconfig

# 编译 shadowsocks-libev
./autogen.sh && ./configure && make
sudo make install
```

Bash

Copy

### chinadns

```
## 获取 chinadns 源码
wget https://github.com/shadowsocks/ChinaDNS/releases/download/1.3.2/chinadns-1.3.2.tar.gz

## 解压 chinadns 源码
tar xf chinadns-1.3.2.tar.gz

## 编译 chinadns
cd chinadns-1.3.2/
./configure
make && make install

## chinadns 相关文件
mkdir /etc/chinadns/
cp -af chnroute.txt /etc/chinadns/
cp -af iplist.txt /etc/chinadns/
```

Bash

Copy

### dnsforwarder

```
## 获取 dnsforwarder 源码
git clone https://github.com/holmium/dnsforwarder.git

## 编译 dnsforwarder
cd dnsforwarder/
./configure
make && make install

## 初始化 dnsforwarder
dnsforwarder -p
cp -af default.config ~/.dnsforwarder/config
```

Bash

Copy

### ipset

```
## ArchLinux
pacman -S --need ipset

## CentOS
yum install ipset -y
```

Bash

Copy

## 手动部署

> 如果不想一步一步设置，请直接前往 [一键部署](https://www.zfl9.com/ss-redir.html#一键部署)！

### ss-redir

```
## 命令详解
ss-redir -s 'server_ip' -p 'server_port' -m 'method' -k 'passwd' -b 'bind_ip' -l 'listen_port' -u -v
# -s ss服务器ip
# -p ss服务器port
# -m 加密方式
# -k 密码
# -b 本地监听ip
# -l 本地监听port
# -u 启用udp转发
# -v 打印详细信息

## 运行 ss-redir，注意修改相关参数！
nohup ss-redir -s 服务器IP -p 服务器Port -m 加密方式 -k 密码 -b 0.0.0.0 -l 60080 -u < /dev/null &>> /var/log/ss-redir.log &
```

Bash

Copy

### ss-tunnel

```
## 命令详解
ss-tunnel -s 'server_ip' -p 'server_port' -m 'method' -k 'passwd' -b 'bind_ip' -l 'listen_port' -L 'dst_ip:dst_port' -u -v
# -s ss服务器ip
# -p ss服务器port
# -m 加密方式
# -k 密码
# -b 本地监听ip
# -l 本地监听port
# -L 目的地址ip:port
# -u 启用udp转发
# -v 打印详细信息

## 运行 ss-tunnel，注意修改相关参数！
nohup ss-tunnel -s 服务器IP -p 服务器Port -m 加密方式 -k 密码 -b 0.0.0.0 -l 60053 -L 8.8.8.8:53 -u < /dev/null &>> /var/log/ss-tunnel.log &
```

Bash

Copy

### chinadns

```
## 命令详解
chinadns -b 'bind_ip' -p 'listen_port' -s 'ip[:port],ip[:port][,...]' -c /etc/chinadns/chnroute.txt -l /etc/chinadns/iplist.txt -m -v
# -b 本地监听ip
# -p 本地监听port
# -s 指定上游dns服务器，必须至少有一个国内dns、一个国外dns
# -c 指定大陆地址段文件
# -l 指定ip黑名单文件
# -m 启用dns压缩指针
# -v 打印详细信息

## 运行 chinadns
nohup chinadns -b 0.0.0.0 -p 65353 -s 114.114.114.114,127.0.0.1:60053 -c /etc/chinadns/chnroute.txt -l /etc/chinadns/iplist.txt -m < /dev/null &>> /var/log/chinadns.log &
```

Bash

Copy

### dnsforwarder

```
## ~/.dnsforwarder/config 配置文件
## 把原来的配置文件清空，使用以下配置

++++++++++++++++++ config ++++++++++++++++++
#### 日志相关 ####
LogOn true # 启用日志
LogFileThresholdLength 5120000 # 日志大小临界值，大于该值则将原文件备份，使用新文件记录日志
LogFileFolder /var/log/ # 日志文件所在的文件夹

#### 监听地址 ####
UDPLocal 0.0.0.0:53 # 可以有多个，使用逗号隔开，默认端口53

#### 上游dns ####
UDPGroup 127.0.0.1:65353 * on # chinadns 作为上游 dns 服务器
BlockNegativeResponse true # 过滤上游 dns 未成功的响应

#### dns缓存 ####
UseCache true # 启用缓存（文件缓存）
MemoryCache false # 不使用内存缓存
CacheSize 30720000 # 缓存大小，不能小于 102400

IgnoreTTL true # 忽略 TTL 值

ReloadCache true # 启动时加载已有的文件缓存
OverwriteCache true # 当已有的文件缓存载入失败时，覆盖原文件
++++++++++++++++++ config ++++++++++++++++++

## 运行 dnsforwarder
dnsforwarder -d

## 查看运行状态
ps -ef | grep dnsforwarder
ss -lnp | grep :53
```

Bash

Copy

### ipset

```
# 获取大陆地址段
curl -sL http://f.ip.cn/rt/chnroutes.txt | egrep -v '^\s*$|^\s*#' > chnip.txt

# 添加 chnip 表
ipset -N chnip hash:net
for i in `cat chnip.txt`; do echo ipset -A chnip $i >> chnip.sh; done
bash chnip.sh

# 持久化 chnip 表
ipset -S chnip > /etc/ipset.chnip
```

Bash

Copy

### iptables

> 注意修改第 15 行、第 40 行的 ss 服务器地址！

```
# 新建 mangle/SS-UDP 链，用于透明代理内网 udp 流量
iptables -t mangle -N SS-UDP

# 放行保留地址、环回地址、特殊地址
iptables -t mangle -A SS-UDP -d 0/8 -j RETURN
iptables -t mangle -A SS-UDP -d 127/8 -j RETURN
iptables -t mangle -A SS-UDP -d 10/8 -j RETURN
iptables -t mangle -A SS-UDP -d 169.254/16 -j RETURN
iptables -t mangle -A SS-UDP -d 172.16/12 -j RETURN
iptables -t mangle -A SS-UDP -d 192.168/16 -j RETURN
iptables -t mangle -A SS-UDP -d 224/4 -j RETURN
iptables -t mangle -A SS-UDP -d 240/4 -j RETURN

# 放行发往 ss 服务器的数据包，注意替换为你的服务器IP
iptables -t mangle -A SS-UDP -d 服务器IP -j RETURN

# 放行大陆地址
iptables -t mangle -A SS-UDP -m set --match-set chnip dst -j RETURN

# 重定向 udp 数据包至 60080 监听端口
iptables -t mangle -A SS-UDP -p udp -j TPROXY --tproxy-mark 0x2333/0x2333 --on-ip 127.0.0.1 --on-port 60080

# 内网 udp 数据包流经 SS-UDP 链
iptables -t mangle -A PREROUTING -p udp -s 192.168/16 -j SS-UDP

# 新建 nat/SS-TCP 链，用于透明代理本机/内网 tcp 流量
iptables -t nat -N SS-TCP

# 放行环回地址，保留地址，特殊地址
iptables -t nat -A SS-TCP -d 0/8 -j RETURN
iptables -t nat -A SS-TCP -d 127/8 -j RETURN
iptables -t nat -A SS-TCP -d 10/8 -j RETURN
iptables -t nat -A SS-TCP -d 169.254/16 -j RETURN
iptables -t nat -A SS-TCP -d 172.16/12 -j RETURN
iptables -t nat -A SS-TCP -d 192.168/16 -j RETURN
iptables -t nat -A SS-TCP -d 224/4 -j RETURN
iptables -t nat -A SS-TCP -d 240/4 -j RETURN

# 放行发往 ss 服务器的数据包，注意替换为你的服务器IP
iptables -t nat -A SS-TCP -d 服务器IP -j RETURN

# 放行大陆地址段
iptables -t nat -A SS-TCP -m set --match-set chnip dst -j RETURN

# 重定向 tcp 数据包至 60080 监听端口
iptables -t nat -A SS-TCP -p tcp -j REDIRECT --to-ports 60080

# 本机 tcp 数据包流经 SS-TCP 链
iptables -t nat -A OUTPUT -p tcp -j SS-TCP
# 内网 tcp 数据包流经 SS-TCP 链
iptables -t nat -A PREROUTING -p tcp -s 192.168/16 -j SS-TCP

# 内网数据包源 NAT
iptables -t nat -A POSTROUTING -s 192.168/16 -j MASQUERADE

# 持久化 iptables 规则
iptables-save > /etc/iptables.tproxy
```

Bash

Copy

### 策略路由

```
# 新建路由表 100，将所有数据包发往 loopback 网卡
ip route add local 0/0 dev lo table 100

# 添加路由策略，让所有经 TPROXY 标记的 0x2333/0x2333 udp 数据包使用路由表 100
ip rule add fwmark 0x2333/0x2333 lookup 100
```

Bash

Copy

### 网卡转发

```
# 检查是否已开启网卡转发功能
cat /proc/sys/net/ipv4/ip_forward
# 若为 1，则说明已开启，无需配置

# 若为 0，请进行下面两个步骤：
echo 'net.ipv4.ip_forward = 1' >> /etc/sysctl.conf
sysctl -p
```

Bash

Copy

### 修改dns

```
## 本机，使用 127.0.0.1:53/udp
cat /etc/resolv.conf
nameserver 127.0.0.1

## 内网主机，使用 192.168.1.1:53/udp（假设当前主机为 192.168.1.1）
具体原因我已经在 "部署环境说明" 的最后一段详细说明了，此处不再解释
```

Bash

Copy

## 一键部署

[ss-tproxy](https://github.com/zfl9/ss-tproxy) 一键部署脚本，经过多次测试，可以正常使用。 使用该脚本之前，需先安装 shadowsocks-libev、chinadns、dnsforwarder、ipset，具体安装方法已在前文给出。

### 初始化

**获取一键脚本** 1) `git clone https://github.com/zfl9/ss-tproxy.git` 2) `cd ss-tproxy/` 3) `cp -af ss-tproxy /usr/local/bin/` 4) `cp -af ss-tproxy.conf /etc/`

**修改配置文件** 1) 只需修改`服务器信息`，其他的保持默认即可；如果需要修改其他参数，文件中有详细注释可参考。 2) `vim /etc/ss-tproxy.conf`，修改开头的”服务器信息”：服务器地址、服务器端口、加密方式、账户密码。 3) **服务器地址**可以为 IP，也可以为域名；如果是域名，务必将域名和 IP 的解析关系添加至`/etc/hosts`文件！ 4) `ss-tproxy.conf`配置文件其实就是一个 shell 脚本，具体怎么玩，可以自由发挥。

**配置开机自启** RHEL/CentOS 6.x 及其它使用 sysvinit 的发行版 1) 使用`/etc/rc.d/rc.local`文件 2) `echo "/usr/local/bin/ss-tproxy start" >> /etc/rc.d/rc.local`

RHEL/CentOS 7.x 及其它使用 systemd 的发行版 1) 安装 ss-tproxy.service 服务 2) `cp -af ss-tproxy.service /etc/systemd/system/ && systemctl daemon-reload && systemctl enable ss-tproxy`

**内网主机dns设置** 内网主机的 dns 必须指向 192.168.1.1（假设网关为 192.168.1.1），具体原因已在**部署环境说明**的最后一段解释了。

### 参数

1) `ss-tproxy start`，运行 ss-tproxy； 2) `ss-tproxy status`，ss-tproxy 运行状态； 3) `ss-tproxy stop`，停止 ss-tproxy； 4) `ss-tproxy restart`，重启 ss-tproxy； 5) `ss-tproxy current_ip`，获取当前 IP 地址信息； 6) `ss-tproxy flush_dnsche`，清空 dnsforwarder dns缓存； 7) `ss-tproxy update_chnip`，更新 ipset-chnip 大陆地址段；

## 代理测试

### 测试 tcp

测试 tcp 非常简单，我们只要打开浏览器，看能不能访问被墙网站就知道了。

```
# 查看当前 ip，理论来说，显示本机 ip
curl -sL ip.chinaz.com/getip.aspx

# 访问各大网站，若均有网页源码输出，说明 tcp 转发已成功
curl -sL www.baidu.com
curl -sL www.google.com
curl -sL www.google.com.hk
curl -sL www.google.co.jp
curl -sL www.youtube.com
curl -sL mail.google.com
curl -sL facebook.com
curl -sL twitter.com
curl -sL www.wikipedia.org
```

Bash

Copy

### 测试 udp

测试 udp 也很容易，只要在其他主机上进行 dns 测试就可以了，注意不能使用 53/udp 端口哦，因为该端口被占用了。

```
## 先使用 192.168.1.1:53 解析被污染的域名
dig @192.168.1.1 www.twitter.com
dig @192.168.1.1 www.twitter.com
dig @192.168.1.1 www.twitter.com
# 记录出现的几个 ip，因为是通过 ss-tunnel 解析的，因此这些 ip 都是未受污染的

## 再使用 OpenDNS 443/udp 端口进行 dns 解析
dig @208.67.222.222 -p 443 www.twitter.com
dig @208.67.222.222 -p 443 www.twitter.com
dig @208.67.222.222 -p 443 www.twitter.com
# 多执行几次，如果解析出来的 ip 和上面的一样，说明 udp 转发已成功
# 同时，查看 /var/log/ss-redir.log 日志可以看到 udp_relay 成功的信息
```



- [PREVIOUS
  为JEKYLL静态博客添加搜索功能](http://ivo-wang.github.io/2018/02/24/jekyll-search/)
- [NEXT
  LINUX下SUSPEND与HIBERNATE的区别](http://ivo-wang.github.io/2018/02/24/suspend-hibernate/)



##### [CATALOG](http://ivo-wang.github.io/2018/02/24/ss-redir/#)





##### [FEATURED TAGS](http://ivo-wang.github.io/tags/)

[linux](http://ivo-wang.github.io/tags/#linux) [shell](http://ivo-wang.github.io/tags/#shell) [vim](http://ivo-wang.github.io/tags/#vim) [python](http://ivo-wang.github.io/tags/#python) [archlinux](http://ivo-wang.github.io/tags/#archlinux) [samba](http://ivo-wang.github.io/tags/#samba) [python 3.5](http://ivo-wang.github.io/tags/#python 3.5) [centos7](http://ivo-wang.github.io/tags/#centos7) [ubuntu](http://ivo-wang.github.io/tags/#ubuntu) [ubuntu 18.04 lts](http://ivo-wang.github.io/tags/#ubuntu 18.04 lts) [debian](http://ivo-wang.github.io/tags/#debian)



##### FRIENDS

- [linux中国](http://linux.cn/)
-  

- [linux命令行](http://man.linuxde.net/)
-  

- [害虫](http://ezlost.com/)
-  

- [谷歌开发者](https://developers.google.cn/)