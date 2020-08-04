# netstat


``` bash
D:\programdata\anaconda\miniconda\pkgs>netstat /?

显示协议统计信息和当前 TCP/IP 网络连接。

NETSTAT [-a] [-b] [-e] [-f] [-n] [-o] [-p proto] [-r] [-s] [-x] [-t] [interval]

  -a            显示所有连接和侦听端口。
  -b            显示在创建每个连接或侦听端口时涉及的
                可执行程序。在某些情况下，已知可执行程序承载
                多个独立的组件，这些情况下，
                显示创建连接或侦听端口时
                涉及的组件序列。在此情况下，可执行程序的
                名称位于底部 [] 中，它调用的组件位于顶部，
                直至达到 TCP/IP。注意，此选项
                可能很耗时，并且在你没有足够
                权限时可能失败。
  -e            显示以太网统计信息。此选项可以与 -s 选项
                结合使用。
  -f            显示外部地址的完全限定
                域名(FQDN)。
  -n            以数字形式显示地址和端口号。
  -o            显示拥有的与每个连接关联的进程 ID。
  -p proto      显示 proto 指定的协议的连接；proto
                可以是下列任何一个: TCP、UDP、TCPv6 或 UDPv6。如果与 -s
                选项一起用来显示每个协议的统计信息，proto 可以是下列任何一个:
                IP、IPv6、ICMP、ICMPv6、TCP、TCPv6、UDP 或 UDPv6。
  -q            显示所有连接、侦听端口和绑定的
                非侦听 TCP 端口。绑定的非侦听端口
                 不一定与活动连接相关联。
  -r            显示路由表。
  -s            显示每个协议的统计信息。默认情况下，
                显示 IP、IPv6、ICMP、ICMPv6、TCP、TCPv6、UDP 和 UDPv6 的统计信息;
                -p 选项可用于指定默认的子网。
  -t            显示当前连接卸载状态。
  -x            显示 NetworkDirect 连接、侦听器和共享
                终结点。
  -y            显示所有连接的 TCP 连接模板。
                无法与其他选项结合使用。
  interval      重新显示选定的统计信息，各个显示间暂停的
                间隔秒数。按 CTRL+C 停止重新显示
                统计信息。如果省略，则 netstat 将打印当前的
                配置信息一次。

```

netstat -s——本选项能够按照各个协议分别显示其统计数据。如果你的应用程序（如Web浏览器）运行速度比较慢，或者不能显示Web页之类的数据，那么你就可以用本选项来查看一下所显示的信息。你需要仔细查看统计数据的各行，找到出错的关键字，进而确定问题所在。

netstat -e——本选项用于显示关于以太网的统计数据。它列出的项目包括传送的数据报的总字节数、错误数、删除数、数据报的数量和广播的数量。这些统计数据既有发送的数据报数量，也有接收的数据报数量。这个选项可以用来统计一些基本的网络流量。

netstat -r——本选项可以显示关于路由表的信息，类似于后面所讲使用route print命令时看到的 信息。除了显示有效路由外，还显示当前有效的连接。

netstat -a——本选项显示一个所有的有效连接信息列表，包括已建立的连接（ESTABLISHED），也包括监听连接请求（LISTENING）的那些连接，断开连接（CLOSE_WAIT）或者处于联机等待状态的（TIME_WAIT）等

netstat -n——显示所有已建立的有效连接。 好像不会显示listening的。


## Tracert
（跟踪路由）是路由跟踪实用程序，用于确定 IP 数据报访问目标所采取的路径。Tracert 命令用 IP 生存时间 (TTL) 字段和 ICMP 错误消息来确定从一个主机到网络上其他主机的路由。最多30跳。

-d 防止 tracert 试图将中间路由器的 IP 地址解析为它们的名称。这样可加速显示 tracert 的结果。例;c:>tracert -d 8.8.8.8

-h 指定搜索目标的路径中存在的跃点的最大数。默认值为 30 个跃点。例:c:>tracert -d -h 5 8.8.8.8

## ARP
ARP命令
显示和修改“地址解析协议”(ARP) 所使用的到以太网的 IP 或令牌环物理地址翻译表。该命令只有在安装了 TCP/IP 协议之后才可用。arp类型分为静态和动态，动态项目由系统自动创建保存时间大概15-20分钟，静态项目有管理员手工输入创建，永久保存但重启后会失效。

常用参数

-a 用于查看所有网络接口缓存中的项目。包括IP地址mac地址和类型 例:c:>arp -a

-a ip 用于查看指定目的ip缓存中的项目。例:c:>arp -a 160.219.0.3

-d 用于清除所有网络接口的arp缓存。例:c:>arp -d

-d ip 用于清除指定目的IP的arp缓存。例:c:>arp -d 160.219.0.3

-s 增加一条静态arp项。例:c:>arp -s 157.55.85.212 00-aa-00-62-c6-09

以上仅为arp命令的常用参数更多参数可以输入apr /?查看

## misc
nslooukup 查看域名解析情况
tracert 119.75.217.26 查看本机到达119.75.217.26的路由路径
ipconfig 查看电脑的ip地址、mac地址，以及其他网卡信息
route print 显示ip路由
netstat -a 查看开启了那些端口，netstat -n 查看端口的网络连接情况

netstat -v 查看正在进行的工作，netstat -p tcp查看tcp协议的使用情况。
tracert 显示请求超时，一般是路由不关闭了ping/ICMP协议
### pathping

   作用：跟踪数据包到达目标所采用的路由，并显示路径中每个路由器的数据包损失的信息。该命令只有在安装了TCP／IP协议后才可使用。

  主要参数：PathPing[一n][一h][一P][一q][一w]远程计算机的IP地址或主机名说明：一n  不将IP地址解析成主机名。

    一h  指定与目的主机之间需要统计的最大跃点数。跃点就是每一台路由器的IP地址。

    一p  指定发送数据包之间等待的毫秒数。

    一q  指定在每一个跃点进行多少次查询以便于统计。

    —w  与ping的—w功能类似。

    PathPing在Windows 9x中还没提供,是Windows 2000中新加入的。它结合了Ping和tracert所共有的一些功能，可以对数据包进行跟踪，并且在一段时间内探测路由上每个跃点，可以显示数据包的延迟与丢失。


### nbtstat

作用：显示本地NetBIOS名称表与NeIBIOS名称缓存, 该命令只有在安装了TCP／IP协议后才可使用。

主要参数：nbtstat[一n][一c][一s][一a]

说明：一n  列出本地NetBIOS名称, 给出信息中的“已注册就是指该名称已被广播或已被WINS注册。

    一c  列出NetBIOS名称缓存的内容并指出每个名称的IP地址。NetBIOS名称高速缓存用于存放与本计算机最近进行通信的其他计算机的NetBIOS名称和IP地址。实际上，如果想通过nbtstat查看最近有谁通过“网络邻居”的方式访问了万机上的资源，这个参数就变得尤为有用。

s  显示客户端与服务端的对话并列出双方NlP地址：

-s  通过IP显示另一台计算机的物理地址和名字列表你所显示纳内容就像对方计算机自己运行nbtstat —n —样。

nbtstat除了可以统计出计算机的NetBIOS名称和计算机所属的工作组之外，还可以显示计算机网卡的MAC地址。如果我们的计算机IP地址是192．168．0．1，键入nbtstat  —a192．168.0．1  可以看到结果如下：