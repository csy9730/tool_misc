# proxychains

[https://github.com/haad/proxychains](https://github.com/haad/proxychains)

> ProxyChains is a UNIX program, that hooks network-related libc functions in dynamically linked programs via a preloaded DLL and redirects the connections through SOCKS4a/5 or HTTP proxies.


## install
```
sudo apt install proxychains
```


### 配置

安装完成之后你只要在proxychains.conf这个文件下添加一句话就可以了
```
vim /etc/proxychains.conf
```

[ProxyList]这么一行，在这行下面添加上`socks5 127.0.0.1 1080`如果有别的比如`socks4 127.0.0.1 9050`那么就把它给注释掉

``` ini
[ProxyList]
socks4  127.0.0.1 9050
```
### demo
如果你只是给一个命令实现代理，比如你要git clone什么东西，你只要在这个命令前面加上proxychains这个命令就好，比如
```
proxychains git clone https://github.com/haad/proxychains.git
```