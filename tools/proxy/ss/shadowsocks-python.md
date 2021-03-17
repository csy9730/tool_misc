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
* ssserver 是将该ss作为服务端，向外部提供服务
* sslocal 是将该ss作为客户端，需要连接一个ss服务器，可以向外提供socks5服务。

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



