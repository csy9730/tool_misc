# ping

``` bash
netsh firewall set icmpsetting 8   # 
netsh firewall set icmpsetting 8 disable
```
Ping程序使用的是ICMP协议，ICMP不像http，FTP应用层有传输层的端口号，（它们使用TCP的端口号80和20/21）。ICMP直接封装在IP包内，所使用IP协议号为1