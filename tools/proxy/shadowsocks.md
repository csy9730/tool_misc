# shadowsocks

[shadowsocks](http://shadowsocks.org/en/index.html)


[github/shadowsocks](https://github.com/shadowsocks)

## server
下载地址[servers](http://shadowsocks.org/en/download/servers.html)
推荐在linux的ubuntu下安装ss服务端，不推荐在windows下使用ss服务端。

原版服务端是基于python，新版服务端基于go,是[go-shadowsocks2](https://github.com/shadowsocks/go-shadowsocks2)
### install

限定是python2
``` bash
yum install python-setuptools && easy_install pip
pip install git+https://github.com/shadowsocks/shadowsocks.git@master

# 或者
python setup.py install 
# 或者
pip install shadowsocks
```

### run
``` bash

# To run with password，encrypt method，

ssserver -p 443 -k password -m aes-256-cfb

# To run in the background:

sudo ssserver -p 443 -k password -m aes-256-cfb --user nobody -d start

# To stop:

sudo ssserver -d stop

# To check the log:

sudo less /var/log/shadowsocks.log

# To start with config file:

ssserver -c /etc/shadowsocks.json

```

## client

[clients](http://shadowsocks.org/en/download/clients.html)
客户端包括：
windows，linux，mac
android，ios
openWRT


## 其他工具
polipo
proxychains
haproxy

/path/to/to/Chrome.exe --proxy-server="socks5://127.0.0.1:1080" --host-resolver-rules="MAP * 0.0.0.0 , EXCLUDE localhost"

chrome://net-internals/#sockets

