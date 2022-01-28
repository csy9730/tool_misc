# ifconfig

#### ifconfig eth0
```
ifconfig eth0


[root@M1808 ~]# ifconfig eth0
eth0      Link encap:Ethernet  HWaddr 00:14:97:30:72:DB
          inet addr:192.168.1.136  Bcast:192.168.1.255  Mask:255.255.255.0
          inet6 addr: fe80::214:97ff:fe30:72db/64 Scope:Link
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:139 errors:0 dropped:0 overruns:0 frame:0
          TX packets:88 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:1000
          RX bytes:17714 (17.2 KiB)  TX bytes:20700 (20.2 KiB)
          Interrupt:38
```

```

(base) ➜  ~ ifconfig eno1
eno1: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether b4:2e:99:65:9f:5b  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 16  memory 0x55300000-55320000

```

#### ifconfig -a
可以看到有四个网络配置。
docker0（docker虚拟网卡），eno1（以太网网卡），lo（回环网卡？），wlx1cbfce14a6e9（无线网卡）

```
(base) ➜  ~ ifconfig -a
docker0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 172.17.0.1  netmask 255.255.0.0  broadcast 172.17.255.255
        ether 02:42:20:d9:39:d9  txqueuelen 0  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

eno1: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether b4:2e:99:65:9f:5b  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 16  memory 0x55300000-55320000

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 599091  bytes 79756278 (79.7 MB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 599091  bytes 79756278 (79.7 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

wlx1cbfce14a6e9: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 172.16.209.219  netmask 255.255.255.0  broadcast 172.16.209.255
        inet6 fe80::8aa5:f4a7:ada7:9d5b  prefixlen 64  scopeid 0x20<link>
        ether 1c:bf:ce:14:a6:e9  txqueuelen 1000  (Ethernet)
        RX packets 3893487  bytes 1258407928 (1.2 GB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 1274134  bytes 224996339 (224.9 MB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

```

### ip 配置

### 临时配置ip
当然如果你是临时的想改一下，当重启后恢复默认，可以如下
`ifconfig eth0 x.x.x.x netmask 255.255.255.0`

如果 ping 不通127.0.0.1 ，可能是还没配置localhost ，需要执行 `ifconfig lo 127.0.0.1 up`

```
ifconfig eth0 192.168.0.10 netmask 255.255.255.0 up

ifconfig eth0 192.168.224.149 netmask 255.255.255.0 up
```

#### 永久配置ip
修改 `/etc/init.d/rcS` 文件。

在 `ifconfig lo 127.0.0.1` 下面添加一行 `ifconfig eth0 192.168.0.10 netmask 255.255.255.0 up`
#### 启停网卡
重新启停以太网卡：
```
sudo ifconfig eth0 down
sudo ifconfig eth0 up
```

②添加默认网关：
```
sudo route add default gw 192.168.1.1
```
## help
```
(base) ➜  ~ ifconfig --help
Usage:
  ifconfig [-a] [-v] [-s] <interface> [[<AF>] <address>]
  [add <address>[/<prefixlen>]]
  [del <address>[/<prefixlen>]]
  [[-]broadcast [<address>]]  [[-]pointopoint [<address>]]
  [netmask <address>]  [dstaddr <address>]  [tunnel <address>]
  [outfill <NN>] [keepalive <NN>]
  [hw <HW> <address>]  [mtu <NN>]
  [[-]trailers]  [[-]arp]  [[-]allmulti]
  [multicast]  [[-]promisc]
  [mem_start <NN>]  [io_addr <NN>]  [irq <NN>]  [media <type>]
  [txqueuelen <NN>]
  [[-]dynamic]
  [up|down] ...

  <HW>=Hardware Type.
  List of possible hardware types:
    loop (Local Loopback) slip (Serial Line IP) cslip (VJ Serial Line IP)
    slip6 (6-bit Serial Line IP) cslip6 (VJ 6-bit Serial Line IP) adaptive (Adaptive Serial Line IP)
    ash (Ash) ether (Ethernet) ax25 (AMPR AX.25)
    netrom (AMPR NET/ROM) rose (AMPR ROSE) tunnel (IPIP Tunnel)
    ppp (Point-to-Point Protocol) hdlc ((Cisco)-HDLC) lapb (LAPB)
    arcnet (ARCnet) dlci (Frame Relay DLCI) frad (Frame Relay Access Device)
    sit (IPv6-in-IPv4) fddi (Fiber Distributed Data Interface) hippi (HIPPI)
    irda (IrLAP) ec (Econet) x25 (generic X.25)
    eui64 (Generic EUI-64)
  <AF>=Address family. Default: inet
  List of possible address families:
    unix (UNIX Domain) inet (DARPA Internet) inet6 (IPv6)
    ax25 (AMPR AX.25) netrom (AMPR NET/ROM) rose (AMPR ROSE)
    ipx (Novell IPX) ddp (Appletalk DDP) ec (Econet)
    ash (Ash) x25 (CCITT X.25)
```


## /etc/network/interfaces
具体位置在 /etc/network/interfaces

在最后，或者找到auto eth0，我们将
```
auto eth0

iface eth0 inet dhcp
```

更改成
```
iface eth0 inet static

address 192.168.1.xx
netmask 255.255.255.0
network 192.168.0.0  [这里是非必须的]
gateway 192.168.0.200 [这里是非必须的]
```


### NAT转发网络
todo：
- [ ] 实现ARM开发板与pc机的互ping，及ping www.baidu.com的方法。