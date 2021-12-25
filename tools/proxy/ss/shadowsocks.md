# shadowsocks

Shadowsocks 分为服务端和客户端，服务端有以下四种。
目前有4个衍生版本的Shadowsocks:

* Shadowsocks-go: 二进制编译, 轻量, 快速
* Shadowsocks-python: 是最原始的版本，近年来更新速度略慢
* Shadowsocks-libev: 一直处于更新之中，最大的特点是支持obfs混淆
* ShadowsocksR: 从作者到产品都极负争议性, obfs混淆模式开创者.


## client


[clients](http://shadowsocks.org/en/download/clients.html)
客户端包括：
windows，linux，mac
android，ios
openWRT

## use

默认情况下本地监听端口是127.0.0.1:1080，在浏览器中设置好代理后就可以开始享受SSR了，如果要全局代理的话，
