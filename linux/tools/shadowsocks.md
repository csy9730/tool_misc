# shadowsocks

[shadowsocks](http://shadowsocks.org/en/index.html)



[](https://github.com/shadowsocks)

## install

``` bash
yum install python-setuptools && easy_install pip
pip install git+https://github.com/shadowsocks/shadowsocks.git@master

# 或者
python setup.py install 

```

## run
``` bash

# To run 

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