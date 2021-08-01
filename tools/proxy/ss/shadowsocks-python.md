# shadowsocks

SS是Shadowsocks的简称，也被称为酸酸、小飞机、纸飞机，是目前主流的科学上网工具，官方网站是[https://shadowsocks.org](https://shadowsocks.org)，目前在国内被墙无法正常打开。

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
程序的入口是sslocal和ssserver。

ss有两种启动的方式，ssserver和sslocal。
* ssserver 是将本地作为服务端，向外部提供ss代理服务
* sslocal 是将本地作为客户端，需要连接一个ss服务器，可以向本地提供socks5服务。

服务器上运行 ssserver提供服务。
个人电脑上 运行 sslocal，连接 ssserver，在本地暴露 socks5 服务。本地浏览器通过 socks端口，访问网页。

ss 是socks5的封装，提供了 远程服务能力，流量加密能力。

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


``` bash
# server side
ssserver -p 443 -k password -m aes-256-cfb

# client side
sslocal -s server_ip -p 443 -l 1080 -k password -m aes-256-cfb
```
## help

ssserver 是shadowsocks （python）版本的服务端，sslocal是对应的客户端。
### crypto
``` 
ciphers = {
    'aes-128-cfb': (16, 16, OpenSSLCrypto),
    'aes-192-cfb': (24, 16, OpenSSLCrypto),
    'aes-256-cfb': (32, 16, OpenSSLCrypto),
    'aes-128-ofb': (16, 16, OpenSSLCrypto),
    'aes-192-ofb': (24, 16, OpenSSLCrypto),
    'aes-256-ofb': (32, 16, OpenSSLCrypto),
    'aes-128-ctr': (16, 16, OpenSSLCrypto),
    'aes-192-ctr': (24, 16, OpenSSLCrypto),
    'aes-256-ctr': (32, 16, OpenSSLCrypto),
    'aes-128-cfb8': (16, 16, OpenSSLCrypto),
    'aes-192-cfb8': (24, 16, OpenSSLCrypto),
    'aes-256-cfb8': (32, 16, OpenSSLCrypto),
    'aes-128-cfb1': (16, 16, OpenSSLCrypto),
    'aes-192-cfb1': (24, 16, OpenSSLCrypto),
    'aes-256-cfb1': (32, 16, OpenSSLCrypto),
    'bf-cfb': (16, 8, OpenSSLCrypto),
    'camellia-128-cfb': (16, 16, OpenSSLCrypto),
    'camellia-192-cfb': (24, 16, OpenSSLCrypto),
    'camellia-256-cfb': (32, 16, OpenSSLCrypto),
    'cast5-cfb': (16, 8, OpenSSLCrypto),
    'des-cfb': (8, 8, OpenSSLCrypto),
    'idea-cfb': (16, 8, OpenSSLCrypto),
    'rc2-cfb': (16, 8, OpenSSLCrypto),
    'rc4': (16, 0, OpenSSLCrypto),
    'seed-cfb': (16, 16, OpenSSLCrypto),
}
ciphers = {
    'salsa20': (32, 8, SodiumCrypto),
    'chacha20': (32, 8, SodiumCrypto),
}
ciphers = {
    'table': (0, 0, TableCipher)
}
ciphers = {
    'rc4-md5': (16, 16, create_cipher),
}
```

### ssserver
```
(root) D:\Project>ssserver -h
usage: ssserver [OPTION]...
A fast tunnel proxy that helps you bypass firewalls.

You can supply configurations via either config file or command line arguments.

Proxy options:
  -c CONFIG              path to config file
  -s SERVER_ADDR         server address, default: 0.0.0.0
  -p SERVER_PORT         server port, default: 8388
  -k PASSWORD            password
  -m METHOD              encryption method, default: aes-256-cfb
  -t TIMEOUT             timeout in seconds, default: 300
  --fast-open            use TCP_FASTOPEN, requires Linux 3.7+
  --workers WORKERS      number of workers, available on Unix/Linux
  --forbidden-ip IPLIST  comma seperated IP list forbidden to connect
  --manager-address ADDR optional server manager UDP address, see wiki

General options:
  -h, --help             show this help message and exit
  -d start/stop/restart  daemon mode
  --pid-file PID_FILE    pid file for daemon mode
  --log-file LOG_FILE    log file for daemon mode
  --user USER            username to run as
  -v, -vv                verbose mode
  -q, -qq                quiet mode, only show warnings/errors
  --version              show version information

Online help: <https://github.com/shadowsocks/shadowsocks>
```

### sslocal
```
(root) D:\Project>sslocal -h
usage: sslocal [OPTION]...
A fast tunnel proxy that helps you bypass firewalls.

You can supply configurations via either config file or command line arguments.

Proxy options:
  -c CONFIG              path to config file
  -s SERVER_ADDR         server address
  -p SERVER_PORT         server port, default: 8388
  -b LOCAL_ADDR          local binding address, default: 127.0.0.1
  -l LOCAL_PORT          local port, default: 1080
  -k PASSWORD            password
  -m METHOD              encryption method, default: aes-256-cfb
  -t TIMEOUT             timeout in seconds, default: 300
  --fast-open            use TCP_FASTOPEN, requires Linux 3.7+

General options:
  -h, --help             show this help message and exit
  -d start/stop/restart  daemon mode
  --pid-file PID_FILE    pid file for daemon mode
  --log-file LOG_FILE    log file for daemon mode
  --user USER            username to run as
  -v, -vv                verbose mode
  -q, -qq                quiet mode, only show warnings/errors
  --version              show version information

Online help: <https://github.com/shadowsocks/shadowsocks>
```