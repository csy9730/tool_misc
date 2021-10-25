# knock centos

## knockd
### install
``` bash

yum install knock knock-server 
```

### /etc/knockd.conf


``` ini
[options]
        # UseSyslog
        LogFile = /var/log/knockd.log

[opencloseSSH]
        sequence      = 2222:udp,3333:tcp,4444:udp
        seq_timeout   = 15
        tcpflags      = syn,ack
        start_command = /sbin/iptables -D INPUT  -p tcp --dport 8122 -j DROP  && /sbin/iptables -A INPUT -s %IP% -p tcp --dport 8122 -j ACCEPT &&  /sbin/iptables -A INPUT  -p tcp --dport 8122 -j DROP 
        cmd_timeout   = 10
        stop_command  = /sbin/iptables -D INPUT -s %IP% -p tcp --dport ssh -j ACCEPT
                 
```
/sbin/iptables -D INPUT  -p tcp --dport 8122 -j DROP && /sbin/iptables -A INPUT  -p tcp --dport 8122 -j ACCEPT  && /sbin/iptables -A INPUT  -p tcp --dport 8122 -j DROP 

/sbin/iptables -D INPUT -p tcp --dport 22 -j DROP 
/sbin/iptables -A INPUT -s [允许远程的IP] -p tcp --dport 22 -j ACCEPT 
/sbin/iptables -A INPUT -p tcp --dport 22 -j DROP

/sbin/iptables -D INPUT  -p tcp --dport 8122 -j ACCEPT 
修改成：
```ini
[options]
        UseSyslog

[opencloseSSH]
        sequence      = 2222:udp,3333:tcp,4444:udp
        seq_timeout   = 15
        tcpflags      = syn,ack
        start_command = /sbin/iptables -A INPUT -s %IP% -p tcp --dport ssh -j ACCEPT
        cmd_timeout   = 10
        stop_command  = /sbin/iptables -D INPUT -s %IP% -p tcp --dport ssh -j ACCEPT

[opencloseSSHZlg]
        sequence      = 2222:udp,3333:tcp,4444:udp
        seq_timeout   = 15
        tcpflags      = syn,ack
        start_command = /sbin/iptables -A INPUT -s %IP% -p tcp --dport 8122 -j ACCEPT
        cmd_timeout   = 10
        stop_command  = /sbin/iptables -D INPUT -s %IP% -p tcp --dport 8122 -j ACCEPT 
```

### 启动knockd
启动knockd。
``` bash
service knockd start

service knockd status

systemctl status knockd
systemctl start knockd
```

## iptables
添加iptables规则，禁止ssh的包。

``` bash
iptables -A INPUT -p tcp --dport 22 -j DROP

/sbin/iptables -D INPUT  -p tcp --dport 8122 -j ACCEPT

iptables -A INPUT -p tcp --dport 8122 -j DROP

/sbin/iptables -A INPUT  -p tcp --dport 8122 -j ACCEPT

/sbin/iptables -A INPUT  -p tcp --dport 8122 -j ACCEPT
/sbin/iptables -A INPUT  -p tcp --dport 8122 -j ACCEPT
```

## misc

### knock interface error

```
● knockd.service - A port-knocking server
   Loaded: loaded (/usr/lib/systemd/system/knockd.service; disabled; vendor preset: disabled)
   Active: failed (Result: exit-code) since Fri 2021-10-22 16:26:54 UTC; 17s ago
  Process: 91841 ExecStart=/usr/sbin/knockd -d $OPTIONS (code=exited, status=1/FAILURE)

Oct 22 16:26:54 vultrguest systemd[1]: Starting A port-knocking server...
Oct 22 16:26:54 vultrguest knockd[91841]: could not open eth0: eth0: No such device exists (SIOCGIFHWADDR: No such device)
Oct 22 16:26:54 vultrguest systemd[1]: knockd.service: Control process exited, code=exited status=1
Oct 22 16:26:54 vultrguest systemd[1]: knockd.service: Failed with result 'exit-code'.
Oct 22 16:26:54 vultrguest systemd[1]: Failed to start A port-knocking server.
➜  ~ systemctl start  knockd
Job for knockd.service failed because the control process exited with error code.
See "systemctl status knockd.service" and "journalctl -xe" for details.
```
