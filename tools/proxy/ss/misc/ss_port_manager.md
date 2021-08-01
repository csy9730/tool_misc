# ss manager

## main

### 显示所有的网络连接
``` bash
➜  ~ netstat -anp |grep 'ESTABLISHED' |grep ss-server
tcp        0      0 46.76.111.188:57988     74.126.204.188:5228     ESTABLISHED 242761/ss-server
tcp        0      0 46.76.111.188:18489     112.80.137.121:53706    ESTABLISHED 242761/ss-server
tcp        0      0 46.76.111.188:18489     112.94.6.92:9788        ESTABLISHED 242761/ss-server
tcp        0      0 46.76.111.188:46512     64.233.189.188:5228     ESTABLISHED 242761/ss-server
tcp        0      0 46.76.111.188:18489     120.236.152.233:26727   ESTABLISHED 242761/ss-server
tcp        0      0 46.76.111.188:18489     112.94.6.92:9353        ESTABLISHED 242761/ss-server
tcp        0      0 46.76.111.188:45908     64.233.189.188:5228     ESTABLISHED 242761/ss-server
```


```
netstat -anp |grep 'ESTABLISHED' |grep 'ss-server' |grep 'tcp6'
```

### 查看入网连接
``` bash
netstat -anp |grep 'ESTABLISHED' |grep 'ss-server' |grep 18489 

tcp        0      0 46.76.111.188:18489     112.80.137.121:53706    ESTABLISHED 242761/ss-server
tcp        0      0 46.76.111.188:18489     112.94.6.92:9788        ESTABLISHED 242761/ss-server
tcp        0      0 46.76.111.188:18489     120.236.152.233:26727   ESTABLISHED 242761/ss-server
tcp        0      0 46.76.111.188:18489     112.94.6.92:9353        ESTABLISHED 242761/ss-server

```

### 查看入网连接的客户端ip和端口
``` bash
netstat -anp |grep 'ESTABLISHED' |grep 'ss-server' |grep 18489  |awk '{print $5}' 


112.80.137.121:53706
112.94.6.92:9788
120.236.152.233:26727
112.94.6.92:9353
112.94.6.92:9545
112.94.6.92:9805
120.236.152.233:27018
112.94.6.92:9395
```

### 查看入网连接的客户端ip
``` bash
netstat -anp |grep 'ESTABLISHED' |grep 'ss-server' |grep 18489  |awk '{print $5}' |awk -F ":" '{print $1}' |sort -u

```

`sort -u` 命令会过滤重复字符串，相同字符串只显示一次。

### 显示当前所有链接SS的用户IP数量
``` bash
netstat -anp |grep 'ESTABLISHED' |grep 'ss-server' |grep 18489  |awk '{print $5}' |awk -F ":" '{print $1}' |sort -u |wc -l

```