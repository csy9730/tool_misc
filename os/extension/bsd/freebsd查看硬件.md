# freebsd查看硬件

### systat 

systat能实时查看各种信息

```bash
systat -pigs 默认值CPU
systat -iostat 硬盘IO
systat -swap 交换分区
systat -mbufs 网络缓冲区
systat -vmstat 虚拟内存
systat -netstat 网络
systat -icmp ICMP协议
systat -ip IP协议
systat -tcp TCP协议
systat -ifstat 网卡
```



### network

```bash
# 网络
netstat 
sockstat
tcpdump
trafshow
systat -mbufs
systat -icmp
systat -ip
systat -tcp
```





```bash
# 显示PCI总线设备信息
pciconf -lv 
# 显示内核加载的模块
kldstat -v
# 显示指定模块
klsdstat -m ipfilter

# 即插即用设备
pnpinfo

# 显示设备占用的IRQ和内存地址
devinfo -u

cpu
sysctl -a|grep cpu
sysctl -a|grep sched 查看使用的调度器，我编译的是ULE

# 虚拟内存
vmstat

# 硬盘
gstat
systat -iostat
iostat

# 网卡
ifconfig
systat -ifstat


```







### 查看硬盘大小分区等信息

df或sysintall



### freebsd下查看内存
1、dmesg | grep -i mem

cat /var/log/dmesg.boot | grep -i mem

free

2、sysctl -a | grep hw.physmem





### 查看CPU信息

freebsd# cat /var/run/dmesg.boot |grep CPU 可以查看 cpu信息



sysctl hw.model 看cpuid

sysctl machdep.tsc_freq 看cpu频率



转载于:https://blog.51cto.com/kure6/1576503