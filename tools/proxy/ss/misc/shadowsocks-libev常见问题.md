# [shadowsocks-libev常见问题](http://ciika.com/2017/10/shadowsocks-libev-common-issues/)

- 2017-10-31
-  

- 分类: [vpn](http://ciika.com/category/vpn/)

一、shadowsocks-libev输出的日志在哪里
实际上目前我还没有找到相关的错误日志的记录地方，但是在/var/log/syslog能看到一些日志,或者把-f参数去掉，用nohup启动，重定向日志

二、shadowsocks-libev配置多用户模式
shadowsocks-libev不支持多用户模式，python支持

三、shadowsocks-libev能开启多少端口
shadowsocks-libev通过ss-manager可以开启多端口，但是最多只能是1024个，在代码里面写死了

四、开启vpn后，有一些域名解析报错
报错类似为：

```unknown
unable to resolve stats.appsflyer.com
unable to resolve gj.applog.uc.cn
unable to resolve dsp.batmobil.net
unable to resolve android.clients.google.com
unable to resolve android.clients.google.com
unable to resolve dsp.batmobil.net
unable to resolve www.facebook.com
unable to resolve portal.fb.com
unable to resolve tpc.googlesyndication.com
unable to resolve imasdk.googleapis.com
unable to resolve ad.api.kaffnet.com
unable to resolve android.clients.google.com
unable to resolve lh3.googleusercontent.com
unable to resolve lh3.googleusercontent.com
unable to resolve gj.applog.uc.cn
unable to resolve lh3.googleusercontent.com
unable to resolve lh3.googleusercontent.com
unable to resolve api5.batmobil.net
unable to resolve cdn.batmobi.net
unable to resolve tpc.googlesyndication.com
unable to resolve gj.applog.uc.cn
unable to resolve api5.batmobil.net
unable to resolve stats.appsflyer.com
unable to resolve gj.applog.uc.cn
unable to resolve cdn.batmobi.net
unable to resolve ad.api.kaffnet.com
unable to resolve www.facebook.com
unable to resolve imasdk.googleapis.com
unable to resolve cdn.avazutracking.net
unable to resolve cdn.avazutracking.net
unable to resolve gj.applog.uc.cn
unable to resolve gj.applog.uc.cn
unable to resolve cdn.batmobi.net
unable to resolve android.clients.google.com
```

这个我测试过，打开防火墙的53端口后，此类错误减少了很多

其它异常：
getpeername: Transport endpoint is not connected，偶尔会有这样的错误，但是VPN能正常连接

标签: [shadowsocks](http://ciika.com/tag/shadowsocks/)