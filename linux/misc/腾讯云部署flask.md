# 腾讯云部署flask



1. 开放端口
2. 网关配置腾讯云内网IP地址和端口
3. 外网访问腾讯云





Flask出现Error code 400, message Bad request syntax异常
请求api是出现Error code 400, message Bad request syntax，然后后面有一串乱码
其实这个问题最大的原因就是请求时用的https，然后flask服务没有配置ssl证书，所有报错了。

使用http访问即可。



![1572192301381](C:\Users\csy_acer_win8\AppData\Roaming\Typora\typora-user-images\1572192301381.png)