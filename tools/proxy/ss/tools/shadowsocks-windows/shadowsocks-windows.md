# shadowsocks-windows

[https://github.com/shadowsocks/shadowsocks-windows/releases](https://github.com/shadowsocks/shadowsocks-windows/releases)

程序可以实现shadowskocks客户端功能。

## arch


- Shadowsocks.exe
- gui-config.json
- pac.txt
- ss_win_temp/
    - ss_privoxy.exe
    - sysproxy.exe
    - libsscrypto.dll

### core

shadowsocks_windows = shadowsocks + ss_privoxy + sysproxy

原理：通过Shadowsocks程序连接ss服务器，在本地生成socks5服务；通过ss_privoxy程序连接socks5服务，在本地生成http服务；sysproxy修改系统的代理配置，全局使用http代理服务。



### ss_privoxy

### sysproxy
[sysproxy](https://github.com/Noisyfox/sysproxy)

Agent of updating network proxy settings for x86/x64 Windows.

X64 Windows doesn't allow applications running in x86 mode to modify system proxy settings and vise versa. This project provides a tiny tool in both x86 and x64 binary to alert system proxy settings so you could pack them into your own application and run accordingly without having to compile your own application in both x86 and x64 platforms.