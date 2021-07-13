# Kali Linux 使用nmap进行局域网扫描


nmap 执行（至少）两步操作，一个是主机发现（Ping），另一个是主机扫描(扫描端口)。

默认两步是都做的. 
-P0/-Pn 关闭主机发现，
-sP/-sn 关闭主机扫描。
-P0 -sP 两个一起用就是啥也不干，

## ping扫描

### sP
ping扫描：扫描192.168.0.0/24网段上有哪些主机是存活的；
 
```
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
```

### sn
-sn: Ping Scan - disable port scan

### Pn
 -Pn: Treat all hosts as online -- skip host discovery


## 端口扫描

### TCP
端口扫描：扫描192.168.0.3这台主机开放了哪些端口；

```
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
```


```
# nmap -sT localhost -p 22,3389
Starting Nmap 7.80 ( https://nmap.org ) at 2021-07-13 13:06 ?D1ú±ê×?ê±??
Nmap scan report for localhost (127.0.0.1)
Host is up (0.0010s latency).
Other addresses for localhost (not scanned): ::1
rDNS record for 127.0.0.1: csy.com

PORT     STATE    SERVICE
22/tcp   filtered ssh
3389/tcp open     ms-wbt-server

Nmap done: 1 IP address (1 host up) scanned in 2.44 seconds
```


### UDP端口扫描
UDP端口扫描：扫描192.168.0.127开放了哪些UDP端口；

```
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
```

## 隐藏扫描
隐藏扫描，只在目标主机上留下很少的日志信息：隐藏扫描192.168.0.220

```
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
```

### 操作系统识别
操作系统识别

```
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
```

### 全部扫描

-A: Enable OS detection, version detection, script scanning, and traceroute

``` 
pi@raspberrypi:~ $ sudo nmap -sS  -A  192.168.1.100

Starting Nmap 7.40 ( https://nmap.org ) at 2020-05-25 22:29 CST
Nmap scan report for 192.168.1.103
Host is up (0.0063s latency).
Not shown: 985 closed ports
PORT      STATE SERVICE            VERSION
135/tcp   open  msrpc              Microsoft Windows RPC
139/tcp   open  netbios-ssn        Microsoft Windows netbios-ssn
445/tcp   open  microsoft-ds       Windows 8.1 China 9600 microsoft-ds (workgroup: WORKGROUP)
902/tcp   open  ssl/vmware-auth    VMware Authentication Daemon 1.10 (Uses VNC, SOAP)
912/tcp   open  vmware-auth        VMware Authentication Daemon 1.0 (Uses VNC, SOAP)
2869/tcp  open  http               Microsoft HTTPAPI httpd 2.0 (SSDP/UPnP)
|_http-server-header: Microsoft-HTTPAPI/2.0
|_http-title: Service Unavailable
3306/tcp  open  mysql              MySQL (unauthorized)
3389/tcp  open  ssl/ms-wbt-server?
| ssl-cert: Subject: commonName=abc-acer
| Not valid before: 2020-01-21T02:45:05
|_Not valid after:  2020-07-22T02:45:05
6000/tcp  open  X11?
|_x11-access: ERROR: Script execution failed (use -d to debug)
49152/tcp open  msrpc              Microsoft Windows RPC
49153/tcp open  msrpc              Microsoft Windows RPC
49154/tcp open  msrpc              Microsoft Windows RPC
49155/tcp open  msrpc              Microsoft Windows RPC
49156/tcp open  msrpc              Microsoft Windows RPC
49165/tcp open  unknown
| fingerprint-strings:
|   FourOhFourRequest, GetRequest, HTTPOptions:
|     HTTP/1.1 200 OK
|     Cache-Control: no-cache
|     Content-Type: application/json
|     Content-Length: 46
|_    {"success":false,"msg":"Verification failure"}
1 service unrecognized despite returning data. If you know the service/version, please submit the following fingerprint at https://nmap.org/cgi-bin/submit.cgi?new-service :
SF-Port49165-TCP:V=7.40%I=7%D=5/25%Time=5ECBD68D%P=arm-unknown-linux-gnuea
SF:bihf%r(GetRequest,8E,"HTTP/1\.1\x20200\x20OK\r\nCache-Control:\x20no-ca
SF:che\r\nContent-Type:\x20application/json\r\nContent-Length:\x2046\r\n\r
SF:\n{\"success\":false,\"msg\":\"Verification\x20failure\"}")%r(HTTPOptio
SF:ns,8E,"HTTP/1\.1\x20200\x20OK\r\nCache-Control:\x20no-cache\r\nContent-
SF:Type:\x20application/json\r\nContent-Length:\x2046\r\n\r\n{\"success\":
SF:false,\"msg\":\"Verification\x20failure\"}")%r(FourOhFourRequest,8E,"HT
SF:TP/1\.1\x20200\x20OK\r\nCache-Control:\x20no-cache\r\nContent-Type:\x20
SF:application/json\r\nContent-Length:\x2046\r\n\r\n{\"success\":false,\"m
SF:sg\":\"Verification\x20failure\"}");
MAC Address: 30:32:51:52:CB:D9 (Liteon Technology)
Device type: general purpose
Running: Microsoft Windows Vista|7|8.1
OS CPE: cpe:/o:microsoft:windows_vista cpe:/o:microsoft:windows_7::sp1 cpe:/o:microsoft:windows_8.1
OS details: Microsoft Windows Vista, Windows 7 SP1, or Windows 8.1 Update 1
Network Distance: 1 hop
Service Info: Host: ABC-ACER; OS: Windows; CPE: cpe:/o:microsoft:windows

Host script results:
|_clock-skew: mean: -1s, deviation: 0s, median: -1s
|_nbstat: NetBIOS name: ABC-ACER, NetBIOS user: <unknown>, NetBIOS MAC: 30:52:cb:51:31:d9 (Liteon Technology)
| smb-os-discovery:
|   OS: Windows 8.1 China 9600 (Windows 8.1 China 6.3)
|   OS CPE: cpe:/o:microsoft:windows_8.1::-
|   NetBIOS computer name: ABC-ACER\x00
|   Workgroup: WORKGROUP\x00
|_  System time: 2020-05-25T22:32:24+08:00
| smb-security-mode:
|   account_used: <blank>
|   authentication_level: user
|   challenge_response: supported
|_  message_signing: disabled (dangerous, but default)
|_smbv2-enabled: Server supports SMBv2 protocol

TRACEROUTE
HOP RTT     ADDRESS
1   6.33 ms 192.168.1.103

OS and Service detection performed. Please report any incorrect results at https://nmap.org/submit/ .
Nmap done: 1 IP address (1 host up) scanned in 224.48 seconds

```

## help
