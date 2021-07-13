# Nmap

Nmap 是免费开放源代码实用程序，用于网络发现和安全审核。许多系统和网络管理员还发现它对于诸如网络清单，管理服务升级计划以及监视主机或服务正常运行时间之类的任Nmap务很Nmap有用。Nmap以新颖的方式使用原始IP数据包来确定网络上可用的主机，这些主机提供的服务，它们正在运行的操作系统，包过滤器/防火墙的类型。正在使用中，还有许多其他特性。它旨在快速扫描大型网络，但可以在单个主机上正常运行。

## Nmap 主机发现扫描

主机发现有时候也叫做 Ping 扫Nmap描,但它远远超越用世人皆知的 Ping 工具发送简单的 IcMp 回声请求报文,这些探测的目的是获得响应以显示某个 lP 地址是否是活动的(正在被某主机或者网络设备使用).主机发现能够找到零星分布于 lP 地址海洋上的那些机器.

**Nmap 命令参数解析** 扫描之前先来看一下参数解析.

```BASH
-sT    TCP connect() 扫描，这是最基本的 TCP 扫描方式。这种扫描很容易被检测到，在目标主机的日志中会记录大批的连接请求以及错误信息。    
-sS    TCP 同步扫描 (TCP SYN)，因为不必全部打开一个 TCP 连接，所以这项技术通常称为半开扫描 (half-open)。这项技术最大的好处是，很少有系统能够把这记入系统日志。不过，你需要 root 权限来定制 SYN 数据包。    
-sF,-sX,-sN    秘密 FIN 数据包扫描、圣诞树 (Xmas Tree)、空 (Null) 扫描模式。这些扫描方式的理论依据是：关闭的端口需要对你的探测包回应 RST 包，而打开的端口必Nmap需忽略有问题的包（参考 RFC 793 第 64 页）。    
-sP    ping 扫描，用 ping 方式检查网络上哪些主机正在运行。当主机阻塞 ICMP echo 请求包是 ping 扫描是无效的。nmap 在任何情况下都会进行 ping 扫描，只有目标主机处于运行状态，才会进行后续的扫描。    
-sU    UDP 的数据包进行扫描，如果你想知道在某台主机上提供哪些 UDP（用户数据报协议，RFC768) 服务，可以使用此选项。    
-sA    ACK 扫描，这项高级的扫描方法Nmap通常可以用来穿过防火墙。    
-sW    滑动窗口扫描，非常类似于 ACK 的扫描。    
-sR    RPC 扫描，和其它不同的端口扫描方法结合使用。    
-b    FTP 反弹攻击 (bounce attack)，连接到防火墙后面的一台 FTP 服务器做代理，接着进行端口扫描。
-P0    在扫描之前，不 ping 主机。    
-PT    扫描之前，使用 TCP ping 确定哪些主机正在运行。    
-PS    对于 root 用户，这个选项让 nmap 使用 SYN 包而不是 ACK 包来对目标主机进行扫描。    
-PI    设置这个选项，让 nmap 使用真正的 ping(ICMP echo 请求）来扫描目标主机是否正在运行。    
-PB    这是默认的 ping 扫描选项。它使用 ACK(-PT) 和 ICMP(-PI) 两种扫描类型并行扫描。如果防火墙能够过滤其中一种包，使用这种方法，你就能够穿过防火墙。    
-O    这个选项激活对 TCP/IP 指纹特征 (fingerprinting) 的扫描，获得远程主机的标志，也就是操作系统类型。    
-I    打开 nmap 的反向标志扫描功能。    
-f    使用碎片 IP 数据包发送 SYN、FIN、XMAS、NULL。包增加包过滤、入侵检测系统的难度，使其无法知道你的企图。    
-v    冗余模式。强烈推荐使用这个选项，它会给出扫描过程中的详细信息。    
-S <IP>    在一些情况下，nmap 可能无法确定你的源地址 (nmap 会告诉你）。在这种情况使用这个选项给出你的 IP 地址。    
-g port    设置扫描的源端口。一些天真的防火墙和包过滤器的规则集允许源端口为 DNS(53) 或者 FTP-DATA(20) 的包通过和实现连接。显然，如果攻击者把源端口修改为 20 或者 53，就可以摧毁防火墙的防护。    
-oN    把扫描结果重定向到一个可读的文件 logfilename 中。    
-oS    扫描结果输出到标准输出。    
--host_timeout    设置扫描一台主机的时间，以毫秒为单位。默认的情况下，没有超时限制。    
--max_rtt_timeout    设置对每次探测的等待时间，以毫秒为单位。如果超过这个时间限制就重传或者超时。默认值是大约 9000 毫秒。    
--min_rtt_timeout    设置 nmap 对每次探测至少等待你指定的时间，以毫秒为单位。    
-M count    置进行 TCP connect() 扫描时，最多使用多少个套接字进行并行的扫描。
```

**批量Ping扫描:** 批量扫描一个网段的主机存活数.

```BASH
[root@localhost ~]# nmap -sP 192.168.1.0/24

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-19 21:41 EDT
Nmap scan report for 192.168.1.1
Host is up (0.0011s latency).
MAC Address: 44:7D:3F:07:2C:A1 (Unknown)
Nmap scan report for 192.168.1.2
Host is up (0.000095s latency).
MAC Address: FF:8E:BB:EE:AA:B4 (Unknown)
Nmap scan report for 192.168.1.3
Host is up (0.051s latency).
MAC Address: CC:C0:AC:22:DD:07 (Unknown)
Nmap scan report for 192.168.1.7
Host is up.
Nmap done: 256 IP addresses (4 hosts up) scanned in 50.15 seconds
```

**跳过Ping探测:** 有些主机关闭了ping检测,所以可以使用`-P0`跳过ping的探测,可以加快扫描速度.

```BASH
[root@localhost ~]# nmap -P0 192.168.1.7

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-19 21:52 EDT
Nmap scan report for 192.168.1.7
Host is up (0.0000090s latency).
Not shown: 999 closed ports
PORT   STATE SERVICE
22/tcp open  ssh

Nmap done: 1 IP address (1 host up) scanned in 0.06 seconds
```

**计算网段主机IP:** 仅列出指定网段上的每台主机,不发送任何报文到目标主机.

```BASH
[root@localhost ~]# nmap -sL 192.168.1.0/24

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-19 21:43 EDT
Nmap scan report for 192.168.1.0
Nmap scan report for 192.168.1.1
Nmap scan report for 192.168.1.2
Nmap scan report for 192.168.1.3
Nmap scan report for 192.168.1.4
Nmap scan report for 192.168.1.5
...省略...
Nmap done: 256 IP addresses (0 hosts up) scanned in 4.03 seconds
```

**扫描IP地址范围:** 可以指定一个IP地址范围

```BASH
[root@localhost ~]# nmap -sP 192.168.1.1-10

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-19 22:17 EDT
Nmap scan report for 192.168.1.1
Host is up (0.00087s latency).
MAC Address: 1A:7D:2E:AC:6E:1A (Unknown)
Nmap scan report for 192.168.1.2
Host is up (0.00016s latency).
MAC Address: 81:8E:38:BC:7C:8E (Unknown)
Nmap scan report for 192.168.1.4
Host is up (0.061s latency).
MAC Address: 81:29:81:64:81:A3 (Unknown)
Nmap scan report for 192.168.1.5
Host is up (0.060s latency).
MAC Address: EA:3A:EA:EA:81:EA (Unknown)
Nmap scan report for 192.168.1.7
Host is up.
Nmap done: 10 IP addresses (5 hosts up) scanned in 0.26 seconds
```

**探测开放端口(SYN):** 探测目标主机开放的端口,可指定一个以逗号分隔的端口列表(如-PS22,443,80).

``` bash
[root@localhost ~]# nmap -PS22,80,443 192.168.1.7

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-19 22:15 EDT
Nmap scan report for 192.168.1.7
Host is up (0.0000090s latency).
Not shown: 997 closed ports
PORT     STATE SERVICE
22/tcp   open  ssh
80/tcp   open  http
3306/tcp open  mysql

Nmap done: 1 IP address (1 host up) scanned in 0.06 seconds
```

**探测开放端口(UDP):** 探测目标主机开放的端口,可指定一个以逗号分隔的端口列表(如-PS22,443,80).

```BASH
[root@localhost ~]# nmap -PU 192.168.1.7

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-19 21:55 EDT
Nmap scan report for 192.168.1.7
Host is up (0.0000090s latency).
Not shown: 999 closed ports
PORT   STATE SERVICE
22/tcp open  ssh

Nmap done: 1 IP address (1 host up) scanned in 0.06 seconds
```

**SYN扫描:** 使用SYN半开放扫描

``` BASH
[root@localhost ~]# nmap -sS 192.168.1.7

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-19 22:01 EDT
Nmap scan report for 192.168.1.7
Host is up (0.0000090s latency).
Not shown: 999 closed ports
PORT   STATE SERVICE
22/tcp open  ssh

Nmap done: 1 IP address (1 host up) scanned in 0.06 seconds
```

**TCP扫描:** 扫描开放了TCP端口的设备.

``` BASH
[root@localhost ~]# nmap -sT 192.168.1.7

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-19 22:01 EDT
Nmap scan report for 192.168.1.7
Host is up (0.0012s latency).
Not shown: 999 closed ports
PORT   STATE SERVICE
22/tcp open  ssh

Nmap done: 1 IP address (1 host up) scanned in 0.10 seconds
```

**UDP扫描:** 扫描开放了UDP端口的设备.

``` BASH
[root@localhost ~]# nmap -sU 192.168.1.7

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-19 22:02 EDT
Nmap scan report for 192.168.1.7
Host is up (0.0010s latency).
Not shown: 999 closed ports
PORT   STATE         SERVICE
68/udp open|filtered dhcpc

Nmap done: 1 IP address (1 host up) scanned in 1.52 seconds
```

**协议探测:** 探测目标主机支持哪些IP协议

``` BASH
[root@localhost ~]# nmap -sO 192.168.1.7

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-19 22:04 EDT
Nmap scan report for 192.168.1.7
Host is up (0.000016s latency).
Not shown: 249 closed protocols
PROTOCOL STATE         SERVICE
1        open          icmp
2        open|filtered igmp
6        open          tcp
17       open          udp
103      open|filtered pim
136      open|filtered udplite
255      open|filtered unknown

Nmap done: 1 IP address (1 host up) scanned in 1.37 seconds
```

**探测目标系统:** 扫描探测目标主机操作系统,这里结果仅供参考.

``` BASH
[root@localhost ~]# nmap -O 192.168.1.7

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-19 22:06 EDT
Nmap scan report for 192.168.1.7
Host is up (0.000056s latency).
Not shown: 997 closed ports
PORT     STATE SERVICE
22/tcp   open  ssh
80/tcp   open  http
3306/tcp open  mysql
Device type: general purpose
Running: Linux 3.X
OS CPE: cpe:/o:linux:linux_kernel:3
OS details: Linux 3.7 - 3.9
Network Distance: 0 hops

OS detection performed. Please report any incorrect results at http://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 1.82 seconds
```

**探测服务版本:** 用于扫描目标主机服务版本号.

``` BASH
[root@localhost ~]# nmap -sV 192.168.1.7

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-19 22:08 EDT
Nmap scan report for 192.168.1.7
Host is up (0.0000090s latency).
Not shown: 997 closed ports
PORT     STATE SERVICE VERSION
22/tcp   open  ssh     OpenSSH 7.4 (protocol 2.0)
80/tcp   open  http    Apache httpd 2.4.6 ((CentOS) PHP/5.4.16)
3306/tcp open  mysql   ?

Service detection performed. Please report any incorrect results at http://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 6.43 seconds
```

**扫描多台主机:** 一次性扫描多台目标主机.

```BASH
[root@localhost ~]# nmap 192.168.1.2 192.168.1.7

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-19 22:11 EDT
Nmap scan report for 192.168.1.2
Host is up (0.00052s latency).
Not shown: 997 filtered ports
PORT    STATE SERVICE
135/tcp open  msrpc
139/tcp open  netbios-ssn
445/tcp open  microsoft-ds
MAC Address: F4:8E:38:EE:7C:B4 (Unknown)

Nmap scan report for 192.168.1.7
Host is up (0.000010s latency).
Not shown: 997 closed ports
PORT     STATE SERVICE
22/tcp   open  ssh
80/tcp   open  http
3306/tcp open  mysql

Nmap done: 2 IP addresses (2 hosts up) scanned in 4.26 seconds
```

**导入扫描文件:** 从一个文件中导入IP地址,并进行扫描.

```BASH
[root@localhost ~]# cat lyshark.log
localhost
www.baidu.com
192.168.1.7

[root@localhost ~]# nmap -iL lyshark.log

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-19 22:13 EDT
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000090s latency).
Other addresses for localhost (not scanned): 127.0.0.1
Not shown: 996 closed ports
PORT     STATE SERVICE
22/tcp   open  ssh
25/tcp   open  smtp
80/tcp   open  http
3306/tcp open  mysql

Nmap scan report for 192.168.1.7
Host is up (0.0000090s latency).
Not shown: 997 closed ports
PORT     STATE SERVICE
22/tcp   open  ssh
80/tcp   open  http
3306/tcp open  mysql

Nmap done: 3 IP addresses (2 hosts up) scanned in 3.09 seconds
```

**绕过防火墙:** 在扫描时通过使用`-f`参数以及使用`--mtu 4/8/16`使用分片、指定数据包的MTU,来绕过防火墙.

```BASH
[root@localhost ~]# nmap -f 127.0.0.1

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-31 03:12 EDT
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000012s latency).
Not shown: 998 closed ports
PORT   STATE SERVICE
22/tcp open  ssh
25/tcp open  smtp

Nmap done: 1 IP address (1 host up) scanned in 0.07 seconds
```

**其他基本:**

```BASH
nmap localhost    #查看主机当前开放的端口
nmap -p 1024-65535 localhost    #查看主机端口（1024-65535）中开放的端口
nmap -PS 192.168.21.163        #探测目标主机开放的端口
nmap -PS22,80,3306  192.168.21.163    #探测所列出的目标主机端口
nmap -O 192.168.21.163    #探测目标主机操作系统类型
nmap -A 192.168.21.163    #探测目标主机操作系统类型
```

## Nmap 使用扫描脚本

Nmap不仅用于端口扫描,服务检测,其还具有强大的脚本功能,利用`Nmap Script`可以快速探测服务器,一般情况下,常用的扫描脚本会放在`/usr/share/nmap/script`目录下,并且脚本扩招名为`*.nse`后缀的,接下来将介绍最常用的扫描脚本.

**扫描WEB敏感目录:** 通过使用`--script=http-enum.nse`可以扫描网站的敏感目录.

```BASH
[root@localhost ~]# nmap -p 80 --script=http-enum.nse www.mkdirs.com

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-31 01:49 EDT
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000010s latency).
Not shown: 995 closed ports
PORT     STATE SERVICE
21/tcp   open  ftp
22/tcp   open  ssh
25/tcp   open  smtp
80/tcp   open  http
| http-enum:
|   /login.php: Possible admin folder
|   /robots.txt: Robots file
|   /config/: Potentially interesting folder w/ directory listing
|   /docs/: Potentially interesting folder w/ directory listing
|   /external/: Potentially interesting folder w/ directory listing
|_  /icons/: Potentially interesting folder w/ directory listing
3306/tcp open  mysql

Nmap done: 1 IP address (1 host up) scanned in 1.18 seconds
```

**绕开鉴权:** 负责处理鉴权证书(绕开鉴权)的脚本,也可以作为检测部分应用弱口令.

```BASH
[root@localhost ~]# nmap --script=auth www.mkdirs.com

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-30 23:16 EDT
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0000090s latency).
Not shown: 995 closed ports
PORT     STATE SERVICE
21/tcp   open  ftp
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_drwxr-xr-x    2 0        0               6 Oct 30 19:45 pub
22/tcp   open  ssh
25/tcp   open  smtp
| smtp-enum-users:
|_  root
80/tcp   open  http
| http-domino-enum-passwords:
|_  ERROR: No valid credentials were found
3306/tcp open  mysql

Nmap done: 1 IP address (1 host up) scanned in 0.89 seconds
```

**默认脚本扫描:** 脚本扫描,主要是搜集各种应用服务的信息,收集到后可再针对具体服务进行攻击.

```BASH
[root@localhost ~]# nmap --script=default www.mkdirs.com

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-30 23:21 EDT
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000010s latency).
Not shown: 995 closed ports
PORT     STATE SERVICE
21/tcp   open  ftp
| ftp-anon: Anonymous FTP login allowed (FTP code 230)
|_drwxr-xr-x    2 0        0               6 Oct 30 19:45 pub
22/tcp   open  ssh
| ssh-hostkey: 2048 c2:89:44:fc:e3:1b:5a:65:a1:6e:11:34:73:6d:d5:04 (RSA)
|_256 54:0e:d4:47:2f:b2:d4:2b:33:b6:d8:35:66:2d:a2:aa (ECDSA)
3306/tcp open  mysql
| mysql-info: Protocol: 10
| Version: 5.5.60-MariaDB
| Thread ID: 10408
| Status: Autocommit
|_Salt: <D"y]F(2

Nmap done: 1 IP address (1 host up) scanned in 1.06 seconds
```

**检测常见漏洞:** 通过使用`--script=luln`,可以扫描网站的常见漏洞,以及网页的目录结构.

```BASH
[root@localhost ~]# nmap --script=vuln www.mkdirs.com

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-30 23:24 EDT
Nmap scan report for localhost (127.0.0.1)
Host is up (0.000017s latency).
Not shown: 995 closed ports
PORT     STATE SERVICE
21/tcp   open  ftp
22/tcp   open  ssh
25/tcp   open  smtp
| smtp-vuln-cve2010-4344:
|_  The SMTP server is not Exim: NOT VULNERABLE
80/tcp   open  http
| http-enum:
|   /login.php: Possible admin folder
|   /robots.txt: Robots file
|   /config/: Potentially interesting folder w/ directory listing
|   /docs/: Potentially interesting folder w/ directory listing
|   /external/: Potentially interesting folder w/ directory listing
|_  /icons/: Potentially interesting folder w/ directory listing
|_http-fileupload-exploiter:
|_http-frontpage-login: false
|_http-stored-xss: Couldn't find any stored XSS vulnerabilities.
|_http-trace: TRACE is enabled
3306/tcp open  mysql

Nmap done: 1 IP address (1 host up) scanned in 14.40 seconds
```

**内网服务探测:** 通过使用`--script=broadcast`,可以实现在局域网内探查更多服务开启状况.

```BASH
[root@localhost ~]# nmap -n -p445 --script=broadcast 127.0.0.1

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-30 23:28 EDT
Pre-scan script results:
| broadcast-dhcp-discover:
|   IP Offered: 192.168.1.14
|   Server Identifier: 192.168.1.1
|   Subnet Mask: 255.255.255.0
|   Router: 192.168.1.1
|_  Domain Name Server: 192.168.1.1
| broadcast-eigrp-discovery:
|_ ERROR: Couldn't get an A.S value.
| broadcast-listener:
|   ether
|       ARP Request
|         sender ip    sender mac         target ip
|         192.168.1.1  43:72:23:04:56:21  192.168.1.2
|         192.168.1.2  B4:8C:28:BE:4C:34  192.168.1.1
|       EIGRP Update
........
```

**进行WhoIS查询:** 通过使用`--script whois`模块,可以查询网站的简单信息.

```BASH
[root@localhost ~]# nmap --script whois www.baidu.com

Host script results:
| whois: Record found at whois.apnic.net
| inetnum: 61.135.0.0 - 61.135.255.255
| netname: UNICOM-BJ
| descr: China Unicom Beijing province network
| country: CN
| person: ChinaUnicom Hostmaster
|_email: hqs-ipabuse@chinaunicom.cn

Nmap done: 1 IP address (1 host up) scanned in 4.76 seconds
```

**详细WhoIS解析:** 利用第三方的数据库或资源,查询详细的WhoIS解析情况.

```BASH
[root@localhost ~]# nmap --script external www.baidu.com

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-30 23:31 EDT
Nmap scan report for www.baidu.com (61.135.169.125)
Host is up (0.018s latency).
|_http-robtex-shared-ns: ERROR: Script execution failed (use -d to debug)
| ip-geolocation-geoplugin:
| 61.135.169.125 (www.baidu.com)
|   coordinates (lat,lon): 39.9288,116.3889
|_  state: Beijing, China
|_ip-geolocation-maxmind: ERROR: Script execution failed (use -d to debug)
| whois: Record found at whois.apnic.net
| inetnum: 61.135.0.0 - 61.135.255.255
| netname: UNICOM-BJ
| descr: China Unicom Beijing province network
|_country: CN
.....
```

**发现内网网关:** 通过使用`--script=broadcast-netbios-master-browser`可以发现内网网关的地址.

```BASH
[root@localhost ~]# nmap --script=broadcast-netbios-master-browser 192.168.1.1

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-31 02:05 EDT
Pre-scan script results:
| broadcast-netbios-master-browser:
| ip           server          domain
|_192.168.1.2  Web-Server     WORKGROUP
Nmap scan report for 192.168.1.1
Host is up (0.0011s latency).
Not shown: 998 closed ports
PORT     STATE    SERVICE
80/tcp   filtered http
1900/tcp open     upnp
MAC Address: 42:1C:1B:E7:B1:B2 (TP-Link)
```

**发现WEB中Robots文件:** 通过使用`--script=http-robots.txt.nse`可以检测到robots文件内容.

```BASH
[root@localhost scripts]# nmap --script=http-robots.txt.nse www.baidu.com

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-31 02:12 EDT
Nmap scan report for www.baidu.com (61.135.169.125)
Host is up (0.019s latency).
Other addresses for www.baidu.com (not scanned): 61.135.169.121
Not shown: 998 filtered ports
PORT    STATE SERVICE
80/tcp  open  http
| http-robots.txt: 9 disallowed entries
| /baidu /s? /ulink? /link? /home/news/data/ /shifen/
|_/homepage/ /cpro /
443/tcp open  https
| http-robots.txt: 9 disallowed entries
| /baidu /s? /ulink? /link? /home/news/data/ /shifen/
|_/homepage/ /cpro /

Nmap done: 1 IP address (1 host up) scanned in 5.06 seconds
```

**检查WEB服务器时间:** 检查web服务器的当前时间.

```BASH
[root@localhost scripts]# nmap -p 443 --script http-date.nse www.baidu.com

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-31 02:16 EDT
Nmap scan report for www.baidu.com (61.135.169.121)
Host is up (0.017s latency).
Other addresses for www.baidu.com (not scanned): 61.135.169.125
PORT    STATE SERVICE
443/tcp open  https
|_http-date: Sun, 31 Mar 2019 06:16:53 GMT; 0s from local time.

Nmap done: 1 IP address (1 host up) scanned in 0.27 seconds
```

**执行DOS攻击:** dos攻击,对于处理能力较小的站点还挺好用的.

```BASH
[root@localhost ~]# nmap --script http-slowloris --max-parallelism 1000 www.mkdirs.com
Warning: Your max-parallelism (-M) option is extraordinarily high, which can hurt reliability

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-31 02:21 EDT
```

**检查DNS子域:** 检查目标ns服务器是否允许传送,如果能,直接把子域拖出来就好了.

```BASH
[root@localhost scripts]# nmap -p 53 --script dns-zone-transfer.nse -v www.baidu.com

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-31 02:28 EDT
NSE: Loaded 1 scripts for scanning.
NSE: Script Pre-scanning.
Initiating Ping Scan at 02:28
Scanning www.baidu.com (61.135.169.121) [4 ports]
Completed Ping Scan at 02:28, 0.02s elapsed (1 total hosts)
Initiating Parallel DNS resolution of 1 host. at 02:28
Completed Parallel DNS resolution of 1 host. at 02:28, 0.01s elapsed
Initiating SYN Stealth Scan at 02:28
Scanning www.baidu.com (61.135.169.121) [1 port]
Completed SYN Stealth Scan at 02:28, 0.20s elapsed (1 total ports)
NSE: Script scanning 61.135.169.121.
Nmap scan report for www.baidu.com (61.135.169.121)
Host is up (0.016s latency).
Other addresses for www.baidu.com (not scanned): 61.135.169.125
PORT   STATE    SERVICE
53/tcp filtered domain

NSE: Script Post-scanning.
Read data files from: /usr/bin/../share/nmap
Nmap done: 1 IP address (1 host up) scanned in 0.28 seconds
           Raw packets sent: 6 (240B) | Rcvd: 1 (28B)
```

**查询WEB旁站:** 旁站查询,ip2hosts接口该接口似乎早已停用,如果想继续用,可自行到脚本里把接口部分的代码改掉.

```BASH
[root@localhost scripts]# nmap -p80 --script hostmap-ip2hosts.nse www.baidu.com

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-31 02:29 EDT
Nmap scan report for www.baidu.com (61.135.169.121)
Host is up (0.017s latency).
Other addresses for www.baidu.com (not scanned): 61.135.169.125
PORT   STATE SERVICE
80/tcp open  http

Host script results:
| hostmap-ip2hosts:
|_  hosts: Error: could not GET http://www.ip2hosts.com/csv.php?ip=61.135.169.121

Nmap done: 1 IP address (1 host up) scanned in 5.89 seconds
```

**暴力破解DNS记录:** 这里以破解百度的域名为例子,由于内容较多这里简化显示.

```BASH
[root@localhost scripts]# nmap --script=dns-brute.nse www.baidu.com

Starting Nmap 6.40 ( http://nmap.org ) at 2019-03-31 03:19 EDT
Nmap scan report for www.baidu.com (61.135.169.125)
Host is up (0.018s latency).
Other addresses for www.baidu.com (not scanned): 61.135.169.121
Not shown: 998 filtered ports
PORT    STATE SERVICE
80/tcp  open  http
443/tcp open  https

Host script results:
| dns-brute:
|   DNS Brute-force hostnames
|     lab.baidu.com - 180.149.144.192
|     lab.baidu.com - 180.149.132.122
|     corp.baidu.com - 123.129.254.12
|_    log.baidu.com - 10.26.39.14

Nmap done: 1 IP address (1 host up) scanned in 10.58 seconds
```

**内网VNC扫描:** 通过使用脚本,检查VNC版本等一些敏感信息.

```BASH
[root@localhost ~]# nmap --script=realvnc-auth-bypass 127.0.0.1                                            #检查VNC版本
[root@localhost ~]# nmap --script=vnc-auth 127.0.0.1                                                       #检查VNC认证方式
[root@localhost ~]# nmap --script=vnc-info 127.0.0.1                                                       #获取VNC信息
[root@localhost ~]# nmap --script=vnc-brute.nse --script-args=userdb=/user.txt,passdb=/pass.txt 127.0.0.1  #暴力破解VNC密码
```

**内网SMB扫描:** 检查局域网中的`Samba`服务器,以及对服务器的暴力破解.

```BASH
[root@localhost ~]# nmap --script=smb-brute.nse 127.0.0.1                                                            #简单尝试破解SMB服务
[root@localhost ~]# nmap --script=smb-check-vulns.nse --script-args=unsafe=1 127.0.0.1                               #SMB已知几个严重漏
[root@localhost ~]# nmap --script=smb-brute.nse --script-args=userdb=/user.txt,passdb=/pass.txt 127.0.0.1            #通过传递字段文件,进行暴力破解
[root@localhost ~]# nmap -p445 -n --script=smb-psexec --script-args=smbuser=admin,smbpass=1233 127.0.0.1             #查询主机一些敏感信息:nmap_service
[root@localhost ~]# nmap -n -p445 --script=smb-enum-sessions.nse --script-args=smbuser=admin,smbpass=1233 127.0.0.1  #查看会话
[root@localhost ~]# nmap -n -p445 --script=smb-os-discovery.nse --script-args=smbuser=admin,smbpass=1233 127.0.0.1   #查看系统信息
```

**MSSQL扫描:** 检查局域网中的`SQL Server`服务器,以及对服务器的暴力破解.

```BASH
[root@localhost ~]# nmap -p1433 --script=ms-sql-brute --script-args=userdb=/var/passwd,passdb=/var/passwd 127.0.0.1  #暴力破解MSSQL密码
[root@localhost ~]# nmap -p 1433 --script ms-sql-dump-hashes.nse --script-args mssql.username=sa,mssql.password=sa 127.0.0.1   #dumphash值
[root@localhost ~]# nmap -p 1433 --script ms-sql-xp-cmdshell --script-args mssql.username=sa,mssql.password=sa,ms-sql-xp-cmdshell.cmd="net user" 192.168.137.4 xp_cmdshell      #执行命令
```

**MYSQL扫描:** 检查局域网中的`MySQL`服务器,以及对服务器的暴力破解.

```BASH
[root@localhost ~]# nmap -p3306 --script=mysql-empty-password.nse 127.0.0.1                                             #扫描root空口令
[root@localhost ~]# nmap -p3306 --script=mysql-users.nse --script-args=mysqluser=root 127.0.0.1                         #列出所有用户
[root@localhost ~]# nmap -p3306 --script=mysql-brute.nse --script-args=userdb=/var/passwd,passdb=/var/passwd 127.0.0.1  #暴力破解MYSQL口令
```

**Oracle扫描:** 检查局域网中的`Oracle`服务器,以及对服务器的暴力破解.

```BASH
[root@localhost ~]# nmap --script=oracle-sid-brute -p 1521-1560 127.0.0.1    #oracle sid扫描
[root@localhost ~]# nmap --script oracle-brute -p 1521 --script-args oracle-brute.sid=ORCL,userdb=/var/passwd,passdb=/var/passwd 127.0.0.1     #oracle弱口令破解
```