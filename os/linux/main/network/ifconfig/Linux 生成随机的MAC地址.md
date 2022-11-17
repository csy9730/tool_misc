# [Linux: 生成随机的MAC地址](https://www.cnblogs.com/kumata/p/14160608.html)

## 场景

有一批ARM板出来全都是同一个MAC地址: 08:00:27:00:01:92

这就导致获取的IP都是一样的，需要让他们启动后获取各自不一样的IP，因此每个板子都需要获得其自己的MAC地址(后三个BYTE区分身份): "08:00:27:XX:XX:XX"

## 解决方案

用shell脚本来实现随机的MAC。

#### MAC printf test

Printf random mac by 4 commands :

```
$ echo "08:00:27$(dd bs=1 count=3 if=/dev/random 2>/dev/null |hexdump -v -e '/1 ":%02X"')"
$ echo "$(hexdump -n3 -e'/3 "08:00:27" 3/1 ":%02X"' /dev/random)"
$ printf '08:00:27:%02X:%02X:%02X\n' $[RANDOM%256] $[RANDOM%256] $[RANDOM%256]
$ echo 08:00:27:`openssl rand -hex 3 | sed 's/\(..\)/\1:/g; s/.$//'`
```

#### 设定网卡的MAC地址(重启后失效)

```
$ ifconfig eth0 hw ether [mac_address]
```

#### 通过系统启动脚本来设定

Target:

- 第一次启动时生产一个随机的MAC，记录该MAC地址
- 下一次启动直接读取这个本机专属MAC

demo: /etc/init.d/network.sh, 添加配置的实现：

```
echo "Set mac address and ifconfig eth0 up .."    

if [ -f "mac_address" ];then
    echo "Load existing mac_address.."
    ifconfig eth0 hw ether $(cat mac_address)
else
    echo "Not setup mac_address yet, create one."
    echo "$(hexdump -n3 -e'/3 "08:00:27" 3/1 ":%02X"' /dev/random)" > mac_address
    ifconfig eth0 hw ether $(cat mac_address)
fi

ifconfig eth0 up
```

Github地址：https://github.com/kumataahh

##  自定义mac

配置eth0网卡为12:34:56:78:9a:bc

```bash
ifconfig eth0 hw ether 12:34:56:78:9a:bc
```

