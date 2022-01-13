# 外网远程唤醒(WOL)群晖nas

[![李存金](https://pic3.zhimg.com/df9ba2e87_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/li-cun-jin-73)

[李存金](https://www.zhihu.com/people/li-cun-jin-73)





33 人赞同了该文章

最近入手一台群晖nas，最低配的DS216j，主要用于存储电子书和手机照片，这样的话16G的手机也不至于那么拙荆见肘。这两个需求都不需要群晖nas一直处于开机状态，按需开机存取也节能环保，所以我属于关机派。



所以远程外网唤醒(WOL)群晖nas就成了我的刚需。google了一通，被多次误导之后终于摸索成功，现分享出来，供网友参考。



**WOL唤醒技术**

WOL(Wake On LAN)技术最早由AMD开发，目前得到了绝大部分厂商的支持。该功能用于

给处于关机状态的网络设备发送特定数据包实现开机的目的。



发送的数据包被称为Magic Package，PC端常用的工具是WOL Magic Packet Sender，可以

从网络上下载使用。



搞清了什么是WOL，怎么实现群晖nas外网远程唤醒就很清晰了。



**1. 生成Magic Package**

必须有手机端可用的工具，最简单也是最方便的是web online的工具，收藏网址，要唤醒

的时候直接点击打开网址就行 [Wake on Lan Over The Interweb](https://link.zhihu.com/?target=https%3A//www.depicus.com/wake-on-lan/woli%3Fm%3D001143BDA600%26i%3D82.110.108.30%26s%3D255.255.255.255%26p%3D4321)



**2. 发送Magic Package到内网群晖nas端口9**

这个相对麻烦一点，因为群晖nas一般处于家中路由器之后，而且唤醒的时候群晖nas是没

有Ip地址的，只有mac地址， 但是Magic Package只能发送到Ip地址，所以路由器必须支持

mac与ip的静态绑定，否则就别尝试了，偶尔成功一次是因为路由器还缓存着nas的ip-mac绑定。注意是静态绑定，而不是路由器DHCP中的mac与ip绑定，这个是nas启动以后分配ip地址用的。



**2.1 Magic Package发送的目标->路由器**，

所以路由器要支持动态域名，这个自行参考路由器设置说明。



**2.2 路由器转发到群晖nas**

要在路由器上设置端口转发，外网端口无所谓，但是一定要转发到群晖的端口9，我的DS216j是这样的，其它机型没测试过。大家可以用Ip抓包工具抓一下群晖Synology Assistant唤醒时的包就知道了。



**2.3 群晖nas mac地址与ip地址绑定**

这个时候群晖nas还没开机，没有ip地址的，而路由转发是装发到局域网内的某个ip地址

，所以要在路由内做mac-ip静态绑定。



我用的是网件路由器R7000，被称之为ARP Protection / IP MAC Binding。在这里吐槽一下网件，开启该功能后没有绑定的任何Ip都是上不了网的，访客模式的ip也上不了，所以家里来客人要用wifi，我都要绑定一次，晕死。



到此为止，手机端生成的Magic Package就可以顺利的放到群晖nas上，成功唤醒，这个功

能超赞，家里的台式机配合TeamView不要太爽。



按照2设定好以后，当然也可以在PC端远程唤醒nas，随便找个工具就好了。

发布于 2017-09-04 22:34