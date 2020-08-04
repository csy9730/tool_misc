# ping

``` bash
netsh firewall set icmpsetting 8   # 开启了ICMP的回响功能
netsh firewall set icmpsetting 8 disable # 禁用了ICMP的回响功能
```

``` bash
netsh firewall show icmpsetting   # 查看ICMP设置
# 如果显示为空，则关闭了ICMP的回响功能
# 如果显示以下内容，则开启了ICMP的回响功能
标准 配置文件的 ICMP 配置:
模式     类型  描述
-------------------------------------------------------------------
启用       8     允许入站回显请求

```
Ping程序使用的是ICMP协议，ICMP不像http，FTP应用层有传输层的端口号，（它们使用TCP的端口号80和20/21）。ICMP直接封装在IP包内，所使用IP协议号为1

