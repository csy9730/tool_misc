# privoxy

[http://www.privoxy.org/](http://www.privoxy.org/)

## install
``` bash
apt install privoxy
```

### demo
``` bash
➜  tool_misc git:(dev) ✗ privoxy --help
Privoxy version 3.0.26 (https://www.privoxy.org/)
Usage: privoxy [--config-test] [--chroot] [--help] [--no-daemon] [--pidfile pidfile] [--pre-chroot-nslookup hostname] [--user user[.group]] [--version] [configfile]
Aborting
```


###  /etc/privoxy 

- config  
- default.action  
- default.filter  
- match-all.action  
- regression-tests.action  
- templates 
- trust  
- user.action  
- user.filter


#### /etc/privoxy/config

``` ini
listen-address  127.0.0.1:8118
listen-address  [::1]:8118
#

#        forward-socks4a   /              socks-gw.example.com:1080  www-cache.isp.example.net:8080
#        forward           .example.com   .
#
#      A rule that uses a SOCKS 4 gateway for all destinations but no
#      HTTP parent looks like this:
#
#        forward-socks4   /               socks-gw.example.com:1080  .
#
#      To chain Privoxy and Tor, both running on the same system, you
#      would use something like:
#
#        forward-socks5t   /               127.0.0.1:9050 .
 ```
