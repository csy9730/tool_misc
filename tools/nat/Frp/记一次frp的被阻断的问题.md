# [记一次frp的被阻断的问题](https://blog.phpgao.com/frp_tcp_reset.html)

- 作者: [老高](https://blog.phpgao.com/author/1/)
-  

- 时间: 2019-08-31
-  

- 分类: [代码人生](https://blog.phpgao.com/category/coding/)

> 作为一个合格的程序员，应该抱着在哪里都要加班的理想。

为了在家调试方便，老高使用frp将自己放在公司的开发机器的ssh端口开放出来了，但是配置frp客户端的过程中总是出现下面的一句话：

```
2019/08/30 23:42:47 [W] [service.go:82] login to server failed: EOF
EOF
```

开始怀疑是frp的版本问题，于是客户端和服务端都换上了最新的版本，结果还是无法解决问题，继续尝试更换端口，问题依旧。

网上搜索一圈，发现遇到`login to server failed: EOF`问题的人还真不少，下面看看老高是如何解决的吧！

## 本地抓包

开启Wireshark，选择网卡，输入过滤规则：

```
tcp and ip.addr==xxx.xxx.220.109
```

![wireshark 抓包](https://blog.phpgao.com/usr/uploads/2019/08/148061091.png)

后面的那三个RST包**很可疑**，其中还有三个IRC协议的包，打开看一下，发现原来是认证数据。

```json
{"version":"0.28.2","hostname":"","os":"darwin","arch":"amd64","user":"","privilege_key":"144fa23b09635f403ccd18","timestamp":1567119104,"run_id":"","pool_count":1}
```

## 服务端抓包

打开终端，输入命令

```bash
# xxxx 为frp监听端口
tcpdump -i eth0  port xxxx -n

23:57:54.041136 IP 180.167.229.162.64674 > xx.xx.xx.xx.PPPP: Flags [S], seq 2454088299, win 65535, options [mss 1460,nop,wscale 6,nop,nop,TS val 1598952560 ecr 0,sackOK,eol], length 0
23:57:54.041203 IP xx.xx.xx.xx.PPPP > 180.167.229.162.64674: Flags [S.], seq 2502814427, ack 2454088300, win 65160, options [mss 1460,sackOK,TS val 3508779989 ecr 1598952560,nop,wscale 6], length 0
23:57:54.171283 IP 180.167.229.162.64674 > xx.xx.xx.xx.PPPP: Flags [.], ack 1, win 2058, options [nop,nop,TS val 1598952691 ecr 3508779989], length 0
23:57:54.171670 IP 180.167.229.162.64674 > xx.xx.xx.xx.PPPP: Flags [P.], seq 1:13, ack 1, win 2058, options [nop,nop,TS val 1598952692 ecr 3508779989], length 12
23:57:54.171694 IP xx.xx.xx.xx.PPPP > 180.167.229.162.64674: Flags [.], ack 13, win 1018, options [nop,nop,TS val 3508780120 ecr 1598952692], length 0
23:57:54.171896 IP xx.xx.xx.xx.PPPP > 180.167.229.162.64674: Flags [P.], seq 1:13, ack 13, win 1018, options [nop,nop,TS val 3508780120 ecr 1598952692], length 12
23:57:54.172366 IP 180.167.229.162.64674 > xx.xx.xx.xx.PPPP: Flags [P.], seq 13:25, ack 1, win 2058, options [nop,nop,TS val 1598952692 ecr 3508779989], length 12
23:57:54.172391 IP 180.167.229.162.64674 > xx.xx.xx.xx.PPPP: Flags [R.], seq 25, ack 1, win 8224, length 0
23:57:54.301735 IP 180.167.229.162.64674 > xx.xx.xx.xx.PPPP: Flags [R.], seq 13, ack 1, win 8224, length 0
23:57:54.302089 IP 180.167.229.162.64674 > xx.xx.xx.xx.PPPP: Flags [R.], seq 13, ack 13, win 8224, length 0
```

好嘛，注意最后三个包，也是RST，而且方向刚好和我在本地抓包相反，很明显，这是受到了替身攻击！😄

## 解决

看来公司的防火墙应该是探测到了某些特征流量而触发了规则，导致frp认证的包被重置，于是服务端frp关闭了链接，而翻开[源码](https://github.com/fatedier/frp/blob/e62d9a52429f54dee8df1c42f2d4bad7a267b05d/client/service.go#L221)，我们能看到再发送完认证信息后执行了`ReadMsgInto`方法，因为连接已经关闭，所以我们就得到了EOF错误！

回头再看wireshark的RST包之前的三个IRC包，等等，IRC是什么鬼？在FRP源代码中根本搜不到这个关键字啊！从源代码的登录逻辑来看，基本都是TCP的操作。于是再试着抓一次包，IRC又变回了TCP，看来wireshark也有误报的情况发生。

究其原因，很有可能是这一段明文数据暴露了frp，然后导致被防火墙封杀。

那么如何解决`login to server failed: EOF`的问题呢？

其实看了源代码就知道了，原来frp在v0.25.0版本后增加了一个客户端选项，支持了tls传输，也就是传说中的非对称加密，原来在frps初始化服务时，在内存中已经为我们生成了一个[简易的TLS服务](https://github.com/fatedier/frp/blob/e62d9a52429f54dee8df1c42f2d4bad7a267b05d/server/service.go#L417)，简直完美！

开启的办法很简单，在客户端原来的`[common]`配置中加入`tls_enable = true`即可!

## 另一种解决办法

其实嘛，还有一种解决办法，但是不一定能行，而且可能会带来一些问题！

什么方法呢？既然防火墙检测了我的`tcp`，那我换成`udp`行不行？

frp支持使用kcp作为底层的通讯协议，而kcp默认就是基于`udp`协议，废话不多说，赶紧试一试！

步骤(假设kcp的端口为7000)：

1. 在**服务端**原来的`[common]`配置中加入`kcp_bind_port = 7000`，使其支持udp
2. 在**客户端**原来的`[common]`处加入`protocol = kcp`即可，注意端口一定要对上！

标签: [tcp](https://blog.phpgao.com/tag/tcp/), [frp](https://blog.phpgao.com/tag/frp/), [kcp](https://blog.phpgao.com/tag/kcp/)