# 云镜软件

## 云镜软件
腾讯云主机默认安装了云监控。


1.云镜软件

/usr/local/qcloud/YunJing/YDEyes/
/usr/local/qcloud/YunJing/YDEyes/YDService
/usr/local/qcloud/YunJing/YDEyes/YDLive
https://cloud.tencent.com/document/product/296/9927


2.云监控
/usr/local/qcloud/monitor/barad
/usr/local/qcloud/stargate/sgagent
https://cloud.tencent.com/document/product/248/2260


barad_agent进程是干啥用的？
监控agent有2个进程，只有两个进程正常安装才上报数据。
stargate进程负责监控barad_agent进程，barad_agent负责采集和上报。

### 一键卸载腾讯云监控
**Q**：如何优雅地完整的一键卸载腾讯云监控（sgagent && barad_agent）
**A**：
我主要使用的是Centos的服务器，测试环境是Centos 7.4（其他Linux系统也应该大同小异）
直接在腾讯云服务器上运行以下代码即可
``` bash
/usr/local/qcloud/stargate/admin/uninstall.sh
/usr/local/qcloud/YunJing/uninst.sh
/usr/local/qcloud/monitor/barad/admin/uninstall.sh
```

卸载完以后可以通过：`ps -A | grep agent`, 来查看是否卸载干净，如无任何输出，则已卸载干净，如果有输出，请检查是否你自己的程序.