# ifconfig


```
ifconfig eth0 192.168.0.10 netmask 255.255.255.0 up

ifconfig eth0 192.168.224.149 netmask 255.255.255.0 up
```

## ifconfig
1. 修改 /etc/init.d/rcS文件。

在 ifconfig lo 127.0.0.1 下面添加一行 `ifconfig eth0 192.168.0.10 netmask 255.255.255.0 up`

## interfaces
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




### 3. 当然如果你是临时的想改一下，当重启后恢复默认，可以如下

`ifconfig eth0 10.150.11.2 netmask 255.254.0.0`

如果 ping 不同127.0.0.1 ，可能是还没配置localhost ，需要执行 `ifconfig lo 127.0.0.1 up`

 

