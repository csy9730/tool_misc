# knockd

## knock help
```
usage: knock [options] <host> <port[:proto]> [port[:proto]] ...
options:
  -u, --udp            make all ports hits use UDP (default is TCP)
  -d, --delay <t>      wait <t> milliseconds between port hits
  -v, --verbose        be verbose
  -V, --version        display version
  -h, --help           this help

example:  knock myserver.example.com 123:tcp 456:udp 789:tcp
```


### knockd
```
(base) root@DESKTOP-ABC:/mnt# knockd --help
usage: knockd [options]
options:
  -i, --interface <int>  network interface to listen on (default "eth0")
  -d, --daemon           run as a daemon
  -c, --config <file>    use an alternate config file
  -D, --debug            output debug messages
  -l, --lookup           lookup DNS names (may be a security risk)
  -p, --pidfile          use an alternate pidfile
  -g, --logfile          use an alternate logfile
  -v, --verbose          be verbose
  -V, --version          display version
  -h, --help             this help
```

## misc

### knockd failed
```
qwe@foo:~/Documents/Mylib/tool_misc$ sudo service knockd status
● knockd.service - Port-Knock Daemon
   Loaded: loaded (/lib/systemd/system/knockd.service; disabled; vendor preset: enabled)
   Active: failed (Result: exit-code) since Thu 2021-10-14 23:51:21 CST; 2s ago
     Docs: man:knockd(1)
  Process: 20123 ExecStart=/usr/sbin/knockd $KNOCKD_OPTS (code=exited, status=1/FAILURE)
 Main PID: 20123 (code=exited, status=1/FAILURE)

10月 14 23:51:21 foo systemd[1]: Started Port-Knock Daemon.
10月 14 23:51:21 foo knockd[20123]: could not open eth0: eth0: No such device exists (SIOCGIFHWADDR: No such device)
10月 14 23:51:21 foo systemd[1]: knockd.service: Main process exited, code=exited, status=1/FAILURE
10月 14 23:51:21 foo systemd[1]: knockd.service: Failed with result 'exit-code'.
```



```ini
[options]
 # UseSyslog
 LogFile = /knock.log
 interface = eth0  # 监听网卡 or eno1
```


```
sudo service knockd status
● knockd.service - Port-Knock Daemon
   Loaded: loaded (/lib/systemd/system/knockd.service; disabled; vendor preset: enabled)
   Active: active (running) since Thu 2021-10-14 23:58:32 CST; 4s ago
     Docs: man:knockd(1)
 Main PID: 20954 (knockd)
    Tasks: 1 (limit: 4915)
   CGroup: /system.slice/knockd.service
           └─20954 /usr/sbin/knockd

10月 14 23:58:32 foo systemd[1]: Started Port-Knock Daemon.
10月 14 23:58:32 foo knockd[20954]: starting up, listening on eno1
```
