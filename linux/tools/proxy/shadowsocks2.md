# shadowsocks2


[go-shadowsocks2](https://github.com/shadowsocks/go-shadowsocks2)

## demo


``` bash
# 使用AEAD_AES_128_GCM加密， 8488端口 ，指定密码
go-shadowsocks2 -cipher AEAD_AES_128_GCM  -s 0.0.0.0:8488 -password yourpassword -verbose

go-shadowsocks2 -s 'ss://AEAD_CHACHA20_POLY1305:your-password@:8488' -verbose

go-shadowsocks2 -c 'ss://AEAD_CHACHA20_POLY1305:your-password@[server_address]:8488' \
    -verbose -socks :1080 -u -udptun :8053=8.8.8.8:53,:8054=8.8.4.4:53 \
                             -tcptun :8053=8.8.8.8:53,:8054=8.8.4.4:53
```
## help
```
H:\greensoftware>shadowsocks2-win64.exe
Usage of shadowsocks2-win64.exe:
  -c string
        client connect address or url
  -cipher string
        available ciphers: AEAD_AES_128_GCM AEAD_AES_256_GCM AEAD_CHACHA20_POLY1305 (default "AEAD_CHACHA20_POLY1305")
  -key string
        base64url-encoded key (derive from password if empty)
  -keygen int
        generate a base64url-encoded random key of given length in byte
  -password string
        password
  -plugin string
        Enable SIP003 plugin. (e.g., v2ray-plugin)
  -plugin-opts string
        Set SIP003 plugin options. (e.g., "server;tls;host=mydomain.me")
  -redir string
        (client-only) redirect TCP from this address
  -redir6 string
        (client-only) redirect TCP IPv6 from this address
  -s string
        server listen address or url
  -socks string
        (client-only) SOCKS listen address
  -tcp
        (server-only) enable TCP support (default true)
  -tcpcork
        (client-only) enable TCP_CORK (Linux) or TCP_NOPUSH (BSD) for the first few packets
  -tcptun string
        (client-only) TCP tunnel (laddr1=raddr1,laddr2=raddr2,...)
  -u    (client-only) Enable UDP support for SOCKS
  -udp
        (server-only) enable UDP support
  -udptimeout duration
        UDP tunnel timeout (default 5m0s)
  -udptun string
        (client-only) UDP tunnel (laddr1=raddr1,laddr2=raddr2,...)
  -verbose
        verbose mode
```