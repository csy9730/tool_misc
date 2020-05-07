Kali Linux 使用nmap进行局域网扫描

Mr_zhang_p_j 2017-07-21 11:52:58  9284  收藏 3
展开
ping扫描：扫描192.168.0.0/24网段上有哪些主机是存活的；
 
[root@laolinux ~]# nmap -sP 192.168.0.0/24
Starting Nmap 4.11 ( http://www.insecure.org/nmap/ ) at 2009-04-25 06:59 CST
Host laolinux (192.168.0.3) appears to be up.
Host 192.168.0.20 appears to be up.
MAC Address: 00:1E:4F:CD:C6:0E (Unknown)
Host 192.168.0.108 appears to be up.
MAC Address: 00:E3:74:27:05:B7 (Unknown)
Host 192.168.0.109 appears to be up.
MAC Address: 00:E0:E4:A6:14:6F (Fanuc Robotics North America)
Host 192.168.0.111 appears to be up.
MAC Address: 00:E0:E4:A6:1C:91 (Fanuc Robotics North America)
Host 192.168.0.114 appears to be up.
MAC Address: 00:11:1A:35:38:65 (Motorola BCS)
Host 192.168.0.118 appears to be up.
MAC Address: 00:E0:2A:51:AC:5B (Tandberg Television AS)
Host 192.168.0.119 appears to be up.
MAC Address: 00:EA:E5:C1:21:D6 (Unknown)
Host 192.168.0.124 appears to be up.
MAC Address: 00:E0:4C:39:05:81 (Realtek Semiconductor)
Host 192.168.0.127 appears to be up.
MAC Address: 00:11:1A:35:38:62 (Motorola BCS)
Host 192.168.0.128 appears to be up.
MAC Address: 00:E0:E4:A6:1C:96 (Fanuc Robotics North America)
Host 192.168.0.134 appears to be up.
MAC Address: 00:E0:2A:51:AC:5F (Tandberg Television AS)
Host 192.168.0.135 appears to be up.
MAC Address: 00:11:1A:35:38:60 (Motorola BCS)
Host 192.168.0.137 appears to be up.
MAC Address: 00:1F:06:D6:3E:BA (Unknown)
Host 192.168.0.139 appears to be up.
MAC Address: 00:E0:E4:A6:1C:92 (Fanuc Robotics North America)
Host 192.168.0.140 appears to be up.
MAC Address: 00:1F:1A:39:1B:8D (Unknown)
Host 192.168.0.155 appears to be up.
MAC Address: 00:1C:23:4C:DB:A0 (Unknown)
Host 192.168.0.211 appears to be up.
MAC Address: 00:1D:72:98:A2:8C (Unknown)
Host 192.168.0.220 appears to be up.
MAC Address: 00:40:45:20:8C:93 (Twinhead)
Host 192.168.0.221 appears to be up.
MAC Address: 00:09:6B:50:71:26 (IBM)
Nmap finished: 256 IP addresses (20 hosts up) scanned in 3.818 seconds
 
2、端口扫描：扫描192.168.0.3这台主机开放了哪些端口；
 
[root@laolinux ~]# nmap -sT 192.168.0.3
Starting Nmap 4.11 ( http://www.insecure.org/nmap/ ) at 2009-04-25 07:02 CST
Interesting ports on laolinux (192.168.0.3):
Not shown: 1667 closed ports
PORT      STATE SERVICE
21/tcp    open  ftp
22/tcp    open  ssh
25/tcp    open  smtp
53/tcp    open  domain
80/tcp    open  http
110/tcp   open  pop3
111/tcp   open  rpcbind
143/tcp   open  imap
964/tcp   open  unknown
993/tcp   open  imaps
995/tcp   open  pop3s
3306/tcp  open  mysql
10000/tcp open  snet-sensor-mgmt
Nmap finished: 1 IP address (1 host up) scanned in 4.755 seconds
3、隐藏扫描，只在目标主机上留下很少的日志信息：隐藏扫描192.168.0.220
 
[root@laolinux ~]# nmap -sS 192.168.0.127
Starting Nmap 4.11 ( http://www.insecure.org/nmap/ ) at 2009-04-25 07:08 CST
Interesting ports on 192.168.0.127:
Not shown: 1675 closed ports
PORT    STATE SERVICE
21/tcp  open  ftp
135/tcp open  msrpc
139/tcp open  netbios-ssn
445/tcp open  microsoft-ds
912/tcp open  unknown
MAC Address: 00:11:1A:35:38:62 (Motorola BCS)
Nmap finished: 1 IP address (1 host up) scanned in 3.121 seconds
4、UDP端口扫描：扫描192.168.0.127开放了哪些UDP端口；
 
[root@laolinux ~]# nmap -sU 192.168.0.127
Starting Nmap 4.11 ( http://www.insecure.org/nmap/ ) at 2009-04-25 07:08 CST
Interesting ports on 192.168.0.127:
Not shown: 1480 closed ports
PORT     STATE         SERVICE
123/udp  open|filtered ntp
137/udp  open|filtered netbios-ns
138/udp  open|filtered netbios-dgm
445/udp  open|filtered microsoft-ds
500/udp  open|filtered isakmp
1900/udp open|filtered UPnP
4500/udp open|filtered sae-urn
MAC Address: 00:11:1A:35:38:62 (Motorola BCS)
Nmap finished: 1 IP address (1 host up) scanned in 2.947 seconds
5、操作系统识别：
 
[root@laolinux ~]# nmap -sS -O  192.168.0.127
Starting Nmap 4.11 ( http://www.insecure.org/nmap/ ) at 2009-04-25 07:09 CST
Interesting ports on 192.168.0.127:
Not shown: 1675 closed ports
PORT    STATE SERVICE
21/tcp  open  ftp
135/tcp open  msrpc
139/tcp open  netbios-ssn
445/tcp open  microsoft-ds
912/tcp open  unknown
MAC Address: 00:11:1A:35:38:62 (Motorola BCS)
Device type: general purpose
Running: Microsoft Windows 2003/.NET|NT/2K/XP
OS details: Microsoft Windows 2003 Server or XP SP2
Nmap finished: 1 IP address (1 host up) scanned in 5.687 seconds
****************************************************
**    by ：     laolinux
**    my blog： http://laolinux.cublog.cn
****************************************************
目标来源--------------------》博客