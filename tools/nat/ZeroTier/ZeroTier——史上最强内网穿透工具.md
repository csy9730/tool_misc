# ZeroTier——史上最强内网穿透工具

[![img](https://upload.jianshu.io/users/upload_avatars/15779997/f58762e8-3fba-44b2-96f4-5825448596be.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96)](https://www.jianshu.com/u/378306bff919)

[Man_程](https://www.jianshu.com/u/378306bff919)

452019.09.29 22:01:31字数 620阅读 45,772

![img](https://upload-images.jianshu.io/upload_images/15779997-cd14899c47dde687.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)

##  **传统的内网穿透：**

内网设备<——>中转服务器<———>网络设备（手机、电脑）

弊端：

1.中转服务器需要一定的费用进行支撑，如果是外网的服务器还可能存在被墙的风险。

2.中转服务器直接决定了中转的“速度”，而这个“速度”越快其对应的服务器带宽就越大，通常来说价格也就越高。

3.需要一定的知识储备来搭建内网穿透的服务端，虽然目前由于各种脚本的出现，门槛越来越低，但同时也会出现各种各样的问题，对于某些人来说解决起来较为繁琐、头疼。（比如我~hh）

## **ZeroTier的内网穿透：**

内网设备<——>移动、PC设备（手机、电脑）

*通常情况下是端到端的传输，如果网络环境差的话也会借助中转服务器进行传输数据。*

优势：

1.操作极其简单，大体可以分为：

创建账号—>创建访问密钥——>需要互通的设备安装zerotier客户端——>输入刚刚创建的访问密钥——>结束

2.正常情况下不依赖服务器进行中转传输文件，端到端连接，理论可以达到满带宽。

3.个人使用可以不需要额外的服务器费用开支，免费版本下可以支持一百个设备（*不同或者相同网络环境*）同时连入软件所创建的虚拟局域网，从而实现局域网内各个设备之间的无限制的访问。



## **Nas设备内网穿透网速实测**

**①家里路由器下的nas：

**



![img](https://upload-images.jianshu.io/upload_images/15779997-492cbdecee27f1b1.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)

![img](https://upload-images.jianshu.io/upload_images/15779997-343f4e75267b623c.png?imageMogr2/auto-orient/strip|imageView2/2/w/1160)

**②在公司电脑安装客户端并加入之前创建的虚拟局域网访问家里的nas并下载文件：**



![img](https://upload-images.jianshu.io/upload_images/15779997-1d35ccd3813d385c.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)

![img](https://upload-images.jianshu.io/upload_images/15779997-89c9dbc3efbeb85a.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200)

网速不是特别稳定，但基本维持在1~2m/s,效果还是蛮理想的。

**③如果想通过zerotier弄nas内网穿透的话可以参考下面这个帖子：**

[无公网IP搞定群晖+ZEROTIER ONE实现内网穿透](https://links.jianshu.com/go?to=https%3A%2F%2Fpost.smzdm.com%2Fp%2F741270%2F)

**④以下是官方网站和使用的方法：**

官方网站：[https://www.zerotier.com/](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.zerotier.com%2F)

官方操作文档：[点击进入](https://links.jianshu.com/go?to=https%3A%2F%2Fzerotier.atlassian.net%2Fwiki%2Fspaces%2FSD%2Fpages%2F8454145%2FGetting%2BStarted%2Bwith%2BZeroTier)