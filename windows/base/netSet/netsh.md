# netsh


通常可以配置ip地址，开启wifi。

``` bash
netsh interface ipv4 set address "WLAN" static 125.217.229.171 255.255.255.192 125.217.229.190 1
pause
netsh interface ipv4 set address  name="本地连接"  source=dhcp
netsh interface ip set dns name="本地连接" source=dhcp
pause
```


``` bash

命令从 netsh 上下文继承:
..             - 移到上一层上下文级。
abort          - 丢弃在脱机模式下所做的更改。
add            - 在项目列表上添加一个配置项目。
advfirewall    - 更改到 `netsh advfirewall' 上下文。
alias          - 添加一个别名
bridge         - 更改到 `netsh bridge' 上下文。
bye            - 退出程序。
commit         - 提交在脱机模式中所做的更改。
delete         - 在项目列表上删除一个配置项目。
dhcpclient     - 更改到 `netsh dhcpclient' 上下文。
dnsclient      - 更改到 `netsh dnsclient' 上下文。
exit           - 退出程序。
firewall       - 更改到 `netsh firewall' 上下文。
http           - 更改到 `netsh http' 上下文。
interface      - 更改到 `netsh interface' 上下文。
ipsec          - 更改到 `netsh ipsec' 上下文。
lan            - 更改到 `netsh lan' 上下文。
mbn            - 更改到 `netsh mbn' 上下文。
namespace      - 更改到 `netsh namespace' 上下文。
netio          - 更改到 `netsh netio' 上下文。
offline        - 将当前模式设置成脱机。
online         - 将当前模式设置成联机。
p2p            - 更改到 `netsh p2p' 上下文。
popd           - 从堆栈上打开一个上下文。
pushd          - 将当前上下文放入堆栈。
quit           - 退出程序。
ras            - 更改到 `netsh ras' 上下文。
rpc            - 更改到 `netsh rpc' 上下文。
set            - 更新配置设置。
show           - 显示信息。
trace          - 更改到 `netsh trace' 上下文。
unalias        - 删除一个别名。
wcn            - 更改到 `netsh wcn' 上下文。
wfp            - 更改到 `netsh wfp' 上下文。
winhttp        - 更改到 `netsh winhttp' 上下文。
winsock        - 更改到 `netsh winsock' 上下文。
wlan           - 更改到 `netsh wlan' 上下文。

此上下文中的命令:
6to4           - 更改到 `netsh interface 6to4' 上下文。
?              - 显示命令列表。
dump           - 显示一个配置脚本。
help           - 显示命令列表。
httpstunnel    - 更改到 `netsh interface httpstunnel' 上下文。
ipv4           - 更改到 `netsh interface ipv4' 上下文。
ipv6           - 更改到 `netsh interface ipv6' 上下文。
isatap         - 更改到 `netsh interface isatap' 上下文。
portproxy      - 更改到 `netsh interface portproxy' 上下文。
set            - 设置配置信息。
show           - 显示信息。
tcp            - 更改到 `netsh interface tcp' 上下文。
teredo         - 更改到 `netsh interface teredo' 上下文。

下列的子上下文可用:
 6to4 httpstunnel ipv4 ipv6 isatap portproxy tcp teredo

若需要命令的更多帮助信息，请键入命令，接着是空格，
后面跟 ?。

```
## IPV4

``` bash
此上下文中的命令:
show addresses - 显示 IP 地址配置。
show compartments - 显示分段参数。
show config    - 显示 IP 地址和其他信息。
show destinationcache - 显示目标缓存项目。
show dnsservers - 显示 DNS 服务器地址。
show dynamicportrange - 显示动态端口范围配置参数。
show excludedportrange - 显示所有排除的端口范围。
show global    - 显示全局配置普通参数。
show icmpstats - 显示 ICMP 统计。
show interfaces - 显示接口参数。
show ipaddresses - 显示当前 IP 地址。
show ipnettomedia - 显示 IP 的网络到媒体的映射。
show ipstats   - 显示 IP 统计。
show joins     - 显示加入的多播组。
show neighbors - 显示邻居缓存项。
show offload   - 显示卸载信息。
show route     - 显示路由表项目。
show subinterfaces - 显示子接口参数。
show tcpconnections - 显示 TCP 连接。
show tcpstats  - 显示 TCP 统计。
show udpconnections - 显示 UDP 连接。
show udpstats  - 显示 UDP 统计。
show winsservers - 显示 WINS 服务器地址。
netsh interface>ipv4 show address
```

### address

包括以下属性
* DHCP 是否使用
* IP地址
* 子网掩码
* 
``` bash
# ss

```

### DNS

``` bash
netsh interface ip set dns name="本地连接" source=dhcp
```