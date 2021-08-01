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

### shadowsocks-windows
https://github.com/shadowsocks/shadowsocks-windows/releases
### electron-ssr
支持从剪贴板复制、从配置文件导入等方式添加配置

支持复制二维码图片、复制SSR链接(右键应用内二维码，点击右键菜单中的复制)
切换系统代理模式:PAC、全局、不代理

配置文件位置
* Windows: C:\Users\{your username}\AppData\Roaming\electron-ssr\gui-config.json
* Mac: ~/Library/Application Support/electron-ssr/gui-config.json
* Linux: ~/.config/gui-config.json

## use

默认情况下本地监听端口是127.0.0.1:1080，在浏览器中设置好代理后就可以开始享受SSR了，如果要全局代理的话，
