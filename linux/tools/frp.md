# frp


## install
[frp](https://github.com/fatedier/frp/releases)

## demo

### ssh


服务器A执行,(ip地址123.45.67.89)
`./frps -c ./frps.ini`

``` ini
# frps.ini
[common]
bind_port = 7000
```

无IP的客户端B，充当服务端，用户名abc
`./frpc -c .frpc.ini`
``` ini
# frpc.ini
[common]
server_addr = 123.45.67.89
server_port = 7000

[ssh]
type = tcp
local_ip = 127.0.0.1
local_port = 22
remote_port = 6000
```


客户端C通过A连接B
`ssh -p 6000 abc@123.45.67.89`
客户端C无需运行frp程序


服务器A不会运行sshd服务，通过frp转发端口
ssh 是p2p连接，所以要指定双方的端口号
网络链接方式是：
C:ssh =>A:6000=>A:7000=>C:frp=>C:22

### web

``` ini
# frps.ini
[common]
bind_port = 7000
vhost_http_port = 8080
```

``` ini
# frpc.ini
[common]
server_addr = 123.45.67.89
server_port = 7000

[web]
type = http
local_port = 80
custom_domains = www.example.com
```

hosts文件添加以下内容
``` ini
123.45.67.89 www.example.com
```

C => www.example.com:8080 =>A:8080=>A:7000=>C:frp=>C:80

**Q**: frp完全通过custom_domains区分不同网页？一定需要DNS支持？
**A**: 


### rdp
``` ini
[rdp]
type = tcp
local_ip = 127.0.0.1
local_port = 3389
remote_port = 13389
```
### kcp

### xtcp

## full_ini

``` ini
[common]
auto_token=123456
```

## misc
frp 支持 虚拟主机、多路复用、负载均衡、点对点内网穿透

**Q**: new proxy [ssh] error: proxy name [ssh] is alread│ y in use
**A**: 这是因为frpc.ini文件使用相同的节，只需要把"ssh"改成"ssh_2"即可

**Q**: frp报错“http: proxy error: no such domain”
**A**: 

**Q**: windows把frpc.exe 设为启动项？
**A**：
``` bash
echo set ws=WScript.CreateObject("WScript.Shell")>>"frpc.vbs"
echo ws.Run "cmd /c %~dp0frpc.exe -c  %~dp0frpc2.ini",vbhide >>"frpc.vbs"
copy frpc.vbs  "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup"
```

把frpc.vbs复制到启动目录
``` vbs
Set ws = CreateObject("Wscript.Shell")
ws.run "cmd /c c:\frps\frps.exe -c c:\frps\frps.ini",vbhide
```