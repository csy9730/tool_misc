# 腾讯云部署flask



1. 开放端口
2. 网关配置腾讯云内网IP地址和端口
3. 外网访问腾讯云





Flask出现Error code 400, message Bad request syntax异常
请求api是出现Error code 400, message Bad request syntax，然后后面有一串乱码
其实这个问题最大的原因就是请求时用的https，然后flask服务没有配置ssl证书，所有报错了。

使用http访问即可。



![1572192301381](C:\Users\csy_acer_win8\AppData\Roaming\Typora\typora-user-images\1572192301381.png)

## misc
### 腾讯云如何配置安全组

### 云镜软件
腾讯云默认操作系统被安装的软件
展开
1.云镜软件
/usr/local/qcloud/YunJing/YDEyes/
/usr/local/qcloud/YunJing/YDEyes/YDService
/usr/local/qcloud/YunJing/YDEyes/YDLive
https://cloud.tencent.com/document/product/296/9927

2.云监控
/usr/local/qcloud/monitor/barad
/usr/local/qcloud/stargate/sgagent
https://cloud.tencent.com/document/product/248/2260

bash /usr/local/qcloud/YunJing/uninst.sh


**Q**：如何优雅地完整的一键卸载腾讯云监控（sgagent && barad_agent）
**A**：
我主要使用的是Centos的服务器，测试环境是Centos 7.4（其他Linux系统也应该大同小异）
直接在腾讯云服务器上运行以下代码即可
``` bash
/usr/local/qcloud/stargate/admin/uninstall.sh
/usr/local/qcloud/YunJing/uninst.sh
/usr/local/qcloud/monitor/barad/admin/uninstall.sh
```

卸载完以后可以通过：ps -A | grep agent, 来查看是否卸载干净，如无任何输出，则已卸载干净，如果有输出，请检查是否你自己的程序.