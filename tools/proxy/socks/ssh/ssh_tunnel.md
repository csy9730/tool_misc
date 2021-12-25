
### SSH tunnel
```
>-D [bind_address:] port    
   Specifies a local “dynamic” application-level port forwarding.  This works by allocating a socket to listen to port on the local side, optionally bound to the specified bind_address.  Whenever a connection is made to this port, the connection is forwarded over the secure channel, and the application protocol is then used to determine where to connect to from the remote machine.  Currently the SOCKS4 and SOCKS5 protocols are supported, and ssh will act as a SOCKS server.  Only root can forward privileged ports. Dynamic port forwardings can also be specified in the configuration file.    
   IPv6 addresses can be specified by enclosing the address in square brackets.  Only the superuser can forward privileged ports.  By default, the local port is bound in accordance with the GatewayPorts setting.  However, an explicit bind_address may be used to bind the connection to a specific address.  The bind_address of “localhost” indicates                     that the listening port be bound for local use only, while an empty address or ‘*’ indicates that the port should be available from all interfaces.   

-g      Allows remote hosts to connect to local forwarded ports.  If used on a multiplexed connection, then this option must be specified on the master process. 

-D listen_port：选项会在本地开启一个Socks服务器.指定一个本地机器 “动态的'’ 应用程序端口转发. 工作原理是这样的, 本地机器上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转发出去, 根据应用程序的协议可以判断出远程主机将和哪里连接. 目前支持 SOCKS4 协议, 将充当 SOCKS4 服务器. 只有 root 才能转发特权端口. 可以在配置文件中指定动态端口的转发.  

-g 参数则允许其他主机连接到 
-D 在本地创建的代理服务上来。
```

基本原理就是用ssh做动态端口转发，在本地开启一个端口用做socket代理
bindaddress ：指定绑定ip地址
port ： 指定侦听端口
name： ssh服务器登录名
server： ssh服务器地址
例如，假设把一个树莓派作为SOCKS5代理服务器，该树莓派的IP地址是192.168.4.160，SOCKS5的端口7070，在树莓派中输入如下命令：
`ssh -f -N -D 192.168.4.160:7070 pi@127.0.0.1`
指定一个远程设备，让设备开启服务器监听指定的ip和端口，。
