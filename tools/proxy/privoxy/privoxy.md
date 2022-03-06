# privoxy

[http://www.privoxy.org/](http://www.privoxy.org/)

> Privoxy is a non-caching web proxy with advanced filtering capabilities for enhancing privacy, modifying web page data and HTTP headers, controlling access, and removing ads and other obnoxious >Internet junk. Privoxy has a flexible configuration and can be customized to suit individual needs and tastes. It has application for both stand-alone systems and multi-user networks.
> Privoxy is Free Software and licensed under the GNU GPLv2 or later.
> Privoxy is an associated project of Software in the Public Interest (SPI).
> Helping hands and donations are welcome:

Privoxy 可以实现http服务代理功能
- 把一个HTTP请求转发给一个HTTP 代理
- 把一个HTTP 请求转给另一个 SOCKS 代理


## install
``` bash
apt install privoxy
```

windows下也可以安装gui版程序。

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
