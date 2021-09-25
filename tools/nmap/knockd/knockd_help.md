# knockd

## help
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
