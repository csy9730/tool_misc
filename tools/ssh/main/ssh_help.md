# ssh help



## help
``` bash
 ssh
usage: ssh [-46AaCfGgKkMNnqsTtVvXxYy] [-B bind_interface]
           [-b bind_address] [-c cipher_spec] [-D [bind_address:]port]
           [-E log_file] [-e escape_char] [-F configfile] [-I pkcs11]
           [-i identity_file] [-J [user@]host[:port]] [-L address]
           [-l login_name] [-m mac_spec] [-O ctl_cmd] [-o option] [-p port]
           [-Q query_option] [-R address] [-S ctl_path] [-W host:port]
           [-w local_tun[:remote_tun]] destination [command]


-p <端口>	指定远程服务器上的端口
-F <配置文件>	指定ssh指令的配置文件，默认的配置文件为“/etc/ssh/ssh_config”
-b <IP地址>	 使用本机指定的地址作为对位连接的源IP地址
-l login_name    指定登录远程主机的用户. 可以在配置文件中对每个主机单独设定这个参数.
-g	允许远程主机连接本机的转发端口？

-t  "Force pseudo-terminal allocation." 显示启用用户交互(需要 TTY)，可以执行全屏程序
-T  Disable pseudo-terminal allocation.
-C ：启用压缩传输
-q ：静音模式，抑制大多数的警告和诊断消息
-f ：后台运行，隐含 -n选项
-n ：后台运行时必须加此选项， 重导向stdin到/dev/null
-N ：不执行远程命令，用于实现端口转发功能

-L port:host:hostport
    将本地机(客户机)的某个端口转发到远端指定机器的指定端口. 工作原理是这样的, 本地机器上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转发出去, 同时远程主机和 host 的 hostport 端口建立连接. 可以在配置文件中指定端口的转发. 只有 root 才能转发特权端口. IPv6 地址用另一种格式说明: port/host/hostport 
-R port:host:hostport
    将远程主机(服务器)的某个端口转发到本地端指定机器的指定端口. 工作原理是这样的, 远程主机上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转向出去, 同时本地主机和 host 的 hostport 端口建立连接. 可以在配置文件中指定端口的转发. 只有用 root 登录远程主机 才能转发特权端口. IPv6 地址用另一种格式说明: port/host/hostport
-D port
    指定一个本地机器 ``动态的 应用程序端口转发. 工作原理是这样的, 本地机器上分配了一个 socket 侦听 port 端口, 一旦这个端口上有了连接, 该连接就经过安全通道转发出去, 根据应用程序的协议可以判断出远程主机将和哪里连接. 目前支持 SOCKS4 协议, 将充当 SOCKS4 服务器. 只有 root 才能转发特权端口. 可以在配置文件中指定动态端口的转发.

-V 显示版本号
-v 详细打印ssh过程，可以用于查看ssh连接的过程错误，最多可以重复3次 -V选项


-w local_tun[:remote_tun]  指定连接使用的虚拟网卡设备？
-X      Enables X11 forwarding.  
-x      Disables X11 forwarding.


```

### demo
通过 `ssh -v xx.xx.xx.xx `可以查看调试信息

`ssh -O cmd `可以执行单次命令
`ssh nick@xxx.xxx.xxx.xxx "pwd; cat hello.txt"`