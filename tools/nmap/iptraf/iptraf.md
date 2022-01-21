# iptraf


ptraf命令的全拼是“IP traffic monitor”，iptraf命令可以实时地监视网卡流量，可以生成网络协议数据包信息、以太网信息、网络节点状态和ip校验和错误等信息。

iptraf命令支持命令行和菜单操作两种方式，当不带任何参数是iptraf命令将进入菜单操作方式，通过屏幕菜单来执行相应操作。

## install
``` bash
# 安装iptraf
sudo apt install iptraf  # debian\ubuntu

sudo yum install iptraf  # centos\redhat
```

## run


### /usr/sbin/iptraf-ng

```
iptraf-ng
```
### useage

**语法格式：**iptraf  [参数] [网卡]

**常用参数：**

| 命令参数   | 描述                       |
| ---- | ------------------------------------------------------------ |
| -g   | 立即所有生成网络接口的概要状态信息                           |
| -i  eth | 立即在指定网络接口上开启IP流量监视                           |
| -d  eth | 在指定**网络接口**上立即开始监视明细的网络流量信息               |
| -s   eth| 在指定网络接口上立即开始监视TCP和UDP网络流量信息             |
| -z  eth | 在指定网络接口上显示包计数                                   |
| -l   eth| 在指定网络接口上立即开始监视局域网工作站信息                 |
| -t   | 指定命令监视的时间                                           |
| -B   | 将标注输出重新定向到“/dev/null”，关闭标注输入，将程序作为后台进程运行 |
| -f   | 清空所有计数器                                               |
| -h   | 显示帮助信息                                                 |



### run
``` bash
# 使得iptraf后台运行并产生日志
sudo iptraf -i eth0 -L /var/log/traffic_log -B

# 查看日志
less /var/log/traffic_log

# 每周定期清理日志，防止日志过大
 0 0 * * 0 rm -f /var/log/traffic_log

 ```

### help
```
➜  ~ sudo iptraf-ng --help
usage: iptraf-ng [options]
   or: iptraf-ng [options] -B [-i <iface> | -d <iface> | -s <iface> | -z <iface> | -l <iface> | -g]

    -h, --help            show this help message

    -i <iface>            start the IP traffic monitor (use '-i all' for all interfaces)
    -d <iface>            start the detailed statistics facility on an interface
    -s <iface>            start the TCP and UDP monitor on an interface
    -z <iface>            shows the packet size counts on an interface
    -l <iface>            start the LAN station monitor (use '-l all' for all LAN interfaces)
    -g                    start the general interface statistics

    -B                    run in background (use only with one of the above parameters
    -f                    clear all locks and counters
    -t <n>                run only for the specified <n> number of minutes
    -L <logfile>          specifies an alternate log file

```


### -g
```
 iptraf-ng 1.1.4
┌ Iface ──────────────────────── Total ─────────────── IPv4 ────────────── IPv6 ────────────── NonIP ───────── BadIP ──────────────── Activity ────────────────────┐
│ lo                                 0                    0                   0                    0               0                   0.00 kbps                   │
│ eth0                              84                   84                   0                    0               0                  19.45 kbps                   │
│ docker0                            0                    0                   0                    0               0                   0.00 kbps                   │
│ vethf500587                        0                    0                   0                    0               0                   0.00 kbps                   │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                        
```

### -i
```
 iptraf-ng 1.1.4
┌ TCP Connections (Source Host:Port) ─────────────────────────────────────────────────────────── Packets ─────────────── Bytes ────── Flag ──── Iface ─────────────┐
│┌172.19.197.189:22                                                                            >    1023                259020        -PA-      eth0               │
│└120.235.227.209:10053                                                                        >    1023                 53340        --A-      eth0               │
│┌172.19.197.189:56046                                                                         >       5                  3246        -PA-      eth0               │
│└100.100.30.25:80                                                                             >       8                   376        --A-      eth0               │
│┌172.19.197.189:7000                                                                          >      46                  4082        --A-      eth0               │
│└112.94.5.92:23646                                                                            >      40                  5773        -PA-      eth0               │
│┌112.94.5.92:23645                                                                            >      23                  2308        --A-      eth0               │
│└172.19.197.189:7000                                                                          >      27                  2040        -PA-      eth0               │
│┌164.90.222.156:46550                                                                         =       1                    60        S---      eth0               │
│└172.19.197.189:5421                                                                          =       1                    40        RSET      eth0               │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
└ TCP:      5 entries ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────── Active ─┘
┌──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│ UDP (72 bytes) from 172.19.197.189:57483 to 100.100.2.136:53 on eth0                                                                                             │
│ UDP (88 bytes) from 100.100.2.136:53 to 172.19.197.189:57483 on eth0                                                                                             │
│ UDP (72 bytes) from 172.19.197.189:51424 to 100.100.2.138:53 on eth0                                                                                             │
│ UDP (145 bytes) from 100.100.2.138:53 to 172.19.197.189:51424 on eth0                                                                                            │
│ UDP (76 bytes) from 172.19.197.189:54267 to 100.100.5.2:123 on eth0                                                                                              │
│ UDP (76 bytes) from 100.100.5.2:123 to 172.19.197.189:54267 on eth0                                                                                              │
│ UDP (76 bytes) from 172.19.197.189:55095 to 120.25.115.20:123 on eth0                                                                                            │
│ UDP (76 bytes) from 120.25.115.20:123 to 172.19.197.189:55095 on eth0                                                                                            │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
└ Top ───────── Elapsed time:   0:01 ──────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┘
 Packets captured:                                                          2392            │   TCP flow rate:             30.29 kbps
 Up/Dn/PgUp/PgDn-scroll  M-more TCP info   W-chg actv win  S-sort TCP  X-exit
 ```

### -d 
```
 iptraf-ng 1.1.4
┌ Statistics for eth0 ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                                                                                                                                  │
│               Total      Total    Incoming   Incoming    Outgoing   Outgoing                                                                                     │
│             Packets      Bytes     Packets      Bytes     Packets      Bytes                                                                                     │
│ Total:          366      72108         183       9598         183      62510                                                                                     │
│ IPv4:           366      72064         183       9554         183      62510                                                                                     │
│ IPv6:             0          0           0          0           0          0                                                                                     │
│ TCP:            366      72064         183       9554         183      62510                                                                                     │
│ UDP:              0          0           0          0           0          0                                                                                     │
│ ICMP:             0          0           0          0           0          0                                                                                     │
│ Other IP:         0          0           0          0           0          0                                                                                     │
│ Non-IP:           0          0           0          0           0          0                                                                                     │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│ Total rates:         46.69 kbps            Broadcast packets:            0                                                                                       │
│                         32 pps             Broadcast bytes:              0                                                                                       │
│                                                                                                                                                                  │
│ Incoming rates:       6.98 kbps                                                                                                                                  │
│                         16 pps                                                                                                                                   │
│                                            IP checksum errors:           0                                                                                       │
│ Outgoing rates:      39.70 kbps                                                                                                                                  │
│                         16 pps                                                                
```

###  TCP/UDP
```
 iptraf-ng 1.1.4
┌ Proto/Port ──────────────────── Pkts ──────── Bytes ─────── PktsTo ───── BytesTo ───── PktsFrom ──── BytesFrom ──────────────────────────────────────────────────┐
│ TCP/22                        207           33360            106           5564            101           27796                                                   │
│ TCP/80                          7            2312              3           2142              4             170                                                   │
│                                                                                                                   
```
### -L
```
 iptraf-ng 1.1.4
┌───────── PktsIn ────────────── IP In ────────── BytesIn ─────────── InRate ───────── PktsOut ───────────── IP Out ───────── BytesOut ──────── OutRate ───────────┐
│ Ethernet HW addr: 00:16:3e:0e:88:67 on eth0                                                                                                                      │
│ └        352                 352                20375                9.9               351                 351                92638             35.7             │
│ Ethernet HW addr: ee:ff:ff:ff:ff:ff on eth0                                                                                                                      │
│ └        351                 351                92638               35.7               352                 352                20375              9.9   
```

### -z
```
 iptraf-ng 1.1.4
┌ Packet Distribution by Size ─────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────────┐
│                                                                                                                                                                  │
│ Packet size brackets for interface eth0                                                                                                                          │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│ Packet Size (bytes)      Count     Packet Size (bytes)     Count                                                                                                 │
│     1 to   75:             183      751 to  825:               1                                                                                                 │
│    76 to  150:              18      826 to  900:               0                                                                                                 │
│   151 to  225:             143      901 to  975:               0                                                                                                 │
│   226 to  300:               1      976 to 1050:               0                                                                                                 │
│   301 to  375:               0     1051 to 1125:               1                                                                                                 │
│   376 to  450:               2     1126 to 1200:               0                                                                                                 │
│   451 to  525:               0     1201 to 1275:               0                                                                                                 │
│   526 to  600:               0     1276 to 1350:               0                                                                                                 │
│   601 to  675:               1     1351 to 1425:               1                                                                                                 │
│   676 to  750:               0     1426 to 1500+:              3                                                                                                 │
│                                                                                                                                                                  │
│                                                                                                                                                                  │
│ Interface MTU is 1500 bytes, not counting the data-link header                                                                                                   │
│ Maximum packet size is the MTU plus the data-link header length                                                                                                  │
│ Packet size computations include data-link headers, if any                                                                                                       │
│                                                                                                                                                                  │
│                                                                                                                                                                  │                    |
```
                                                                      