# readme

- app
  - [socks](socks.md) 协议是一种代理协议
  - [shadowsocks](shadowsocks.md) 是基于socks协议的cs应用，
  - [shadowsocks-python](shadowsocks-python.md) 是基于socks协议的cs应用，基于python实现。
  - [shadowsocks-go](shadowsocks-go2.md) 是go语言实现的shadowsocks应用。
  - [shadowsocks-libev](ss-libev.md) 是c语言实现的shadowsocks应用。
  - [ssr.md](ssr.md) 是实现shadowsocks应用。
- misc
  - [ss_config](misc/ss_config.md)
  - [Shadowsocks–libev服务端的部署.md](misc/Shadowsocks–libev服务端的部署.md)   
  - [shadowsocks-libev常见问题](misc/shadowsocks-libev常见问题.md)
  - [Shadowsocks服务器运行时，有log文件么？#1836.md](misc/Shadowsocks服务器运行时，有log文件么？.md)
  - [ss_port_manager.md](misc/ss_port_manager.md)
  - [ss-redir做透明代理](misc/ss-redir做透明代理.md)
  - [树莓派搭建透明代理.md](misc/树莓派搭建透明代理.md)

注意，shadowsocks本身只是接收服务器的通信，在本地转发socks5协议。应用程序能否支持使用shadowsocks，还得看程序是否支持socks5协议。