# WSL优化之SSH远程登录篇

> Some of the most devastating things that happen to you will teach you the most.
> 有些最打击你的事情反而教会你的东西越多。

## 重装原有SSH

``` bash
sudo apt remove openssh-server
sudo apt install openssh-server
```

> 先解释一下WSL的网络，作为子系统的Ubuntu Linux和Windows主系统的IP是一样的。如果在Linux上搭建了Nginx服务器，那么在Windows上的浏览器上输入localhost是可以访问Nginx服务的。如果在Linux上运行netstat -nlp是不会看到任何端口服务的。在Linux上启用端口服务的时候，Windows系统会弹出窗口，询问是否允许相关端口访问。

**WSL上的Ubuntu默认安装了openssh-server，也就是ssh服务的软件。但是，这个软件的配置是不完整的，如果启用服务，会报缺失几个密钥文件。为了解决这个问题，我们需要重新安装openssh-server：**

**重新安装完还不行，因为WSL上的Ubuntu的SSH服务配置默认不允许密码方式登录，我们需要改配置：**

## 更改配置文件

```
sudo vim /etc/ssh/sshd_config
```

**将以下配置复制到sshd_config配置文件**

``` ini
Port 2222   #设置ssh的端口号, 由于22在windows中有别的用处, 尽量不修改系统的端口号
PermitRootLogin yes   # 可以root远程登录
PasswordAuthentication yes     # 允许密码验证登录
AllowUsers sky # 远程登录时的用户名
```

## 重启sshd服务

```
sudo service ssh --full-restart
```

**此时，我们可以在Ubuntu的Bash下连接自己测试，也可以用Windows的PowerShell连接Ubuntu来测试，命令都是一样的**

## 测试连接

``` bash
ssh localhost -p 2222 	# username为安装WSL Ubuntu时输入的用户名
```

**如果要在其它机器上访问，需要查找本机IP，把localhost换成IP，那么同一子网（wifi、路由器）下的机器也可访问Ubuntu里的服务。**
**如果在其他机器上连接不成功看是不是Win10本地防火墙的2222端口没有放行，放行端口方法**

> 防火墙->高级设置->入站规则->新建规则
> 端口->下一步
> 选择tcp 特定本地端口 2222
> 允许连接, 默认都选上, 下一步填个名字 完成

**不出意外，就应该能连接成功了**

顺便提一下，如果是搭建Nginx服务就比SSH简单多了，执行下面命令安装后在浏览器访问localhost即可：

```
sudo apt install nginx
sudo service nginx start
```

__EOF__

![img](https://files.cnblogs.com/files/yingbin/45961954.bmp)

**本文作者**：**Kingyingbin**
**本文链接**：<https://www.cnblogs.com/yingbin/p/12828902.html>
**关于博主**：评论和私信会在第一时间回复。或者[直接私信](https://msg.cnblogs.com/msg/send/yingbin)我。
**版权声明**：本博客所有文章除特别声明外，均采用 [BY-NC-SA](https://creativecommons.org/licenses/by-nc-nd/4.0/) 许可协议。转载请注明出处！
**声援博主**：如果您觉得文章对您有帮助，可以点击文章右下角**【推荐】**一下。您的鼓励是博主的最大动力！



作者：[王迎彬](http://www.cnblogs.com/yingbin/)

出处：<http://www.cnblogs.com/yingbin/>

Github：<https://github.com/kingyingbin>

\-------------------------------------------

个性签名：独学而无友，则孤陋而寡闻。做一个灵魂有趣的人！

如果觉得这篇文章对你有小小的帮助的话，记得在右下角点个“推荐”哦，博主在此感谢！





分类: [Linux ](https://www.cnblogs.com/yingbin/category/1533022.html), [WSL](https://www.cnblogs.com/yingbin/category/1756168.html), [Ubuntu](https://www.cnblogs.com/yingbin/category/1756169.html), [运维](https://www.cnblogs.com/yingbin/category/1757321.html)

标签: [SSH](https://www.cnblogs.com/yingbin/tag/SSH/)

[好文要顶](javascript:void(0);) [关注我](javascript:void(0);) [收藏该文](javascript:void(0);) [![img](https://common.cnblogs.com/images/icon_weibo_24.png)](javascript:void(0);) [![img](https://common.cnblogs.com/images/wechat.png)](javascript:void(0);)

![img](https://pic.cnblogs.com/face/1685255/20200428184226.png)

[Kingyingbin](https://home.cnblogs.com/u/yingbin/)
[关注 - 39](https://home.cnblogs.com/u/yingbin/followees/)
[粉丝 - 1](https://home.cnblogs.com/u/yingbin/followers/)





[+加关注](javascript:void(0);)

0

0







[« ](https://www.cnblogs.com/yingbin/p/12822701.html)上一篇： [《相思》--嘉定名士王初桐和发小六娘青梅竹马故事](https://www.cnblogs.com/yingbin/p/12822701.html)
[» ](https://www.cnblogs.com/yingbin/p/12897708.html)下一篇： [Window使用PowerShell改文件时间戳](https://www.cnblogs.com/yingbin/p/12897708.html)

posted @ 2020-05-04 23:36  [Kingyingbin](https://www.cnblogs.com/yingbin/)  阅读(4571)  评论(0)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=12828902)  [收藏](javascript:void(0))  [举报](javascript:void(0))







登录后才能查看或发表评论，立即 [登录](javascript:void(0);) 或者 [逛逛](https://www.cnblogs.com/) 博客园首页



[【推荐】华为开发者专区，与开发者一起构建万物互联的智能世界](https://brands.cnblogs.com/huawei)
[【推荐】跨平台组态\工控\仿真\CAD 50万行C++源码全开放免费下载！](http://www.uccpsoft.com/index.htm)
[【推荐】华为 HMS Core 线上 Codelabs 挑战赛第4期，探索“智”感生活](https://brands.cnblogs.com/huawei/p/2730)



**编辑推荐：**
· [一文讲透算法中的时间复杂度和空间复杂度计算方式](https://www.cnblogs.com/lonely-wolf/p/15674526.html)
· [.NET Core基础篇：集成Swagger文档与自定义Swagger UI](https://www.cnblogs.com/cool-net/p/15655036.html)
· [「译」 .NET 6 中 gRPC 的新功能](https://www.cnblogs.com/myshowtime/p/15666336.html)
· [一次缓存雪崩的灾难复盘](https://www.cnblogs.com/wzh2010/p/13874211.html)
· [如何在 ASP.NET Core 中构建轻量级服务](https://www.cnblogs.com/wanghao72214/p/15659718.html)

**最新新闻**：
· [斯坦福抢开“元宇宙”第一课，上起来还真不便宜（2021-12-14 23:00）](https://news.cnblogs.com/n/709034/)
· [92.4%的人想过辞职：你和你的领导，厌倦工作的原因有啥不同？（2021-12-14 21:49）](https://news.cnblogs.com/n/709013/)
· [对宇宙学原理的最新攻击（2021-12-14 21:00）](https://news.cnblogs.com/n/709033/)
· [马斯克当选《时代》年度人物惹争议 官方回应（2021-12-14 20:40）](https://news.cnblogs.com/n/709032/)
· [360集团创始人、董事长周鸿祎：元宇宙绕不开安全这一课（2021-12-14 20:20）](https://news.cnblogs.com/n/709031/)
» [更多新闻...](https://news.cnblogs.com/)





# WSL