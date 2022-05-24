# [Jenkins配置Gogs webhook插件](https://www.cnblogs.com/stulzq/p/8629720.html)



# 前言

我们在前面使用Jenkins集合Gogs来进行持续集成的时候，选择的是Jenkins定时检测git仓库是否有更新来决定是否构建。也就是说，我们提交了代码Jenkins并不会马上知道，那么我们可以通过webhook来解决。Jenkins的插件中心已经有对gogs的支持，真的是非常赞。

> <https://plugins.jenkins.io/gogs-webhook>

# 安装Gogs webhook 插件

打开 系统管理 -> 管理插件 -> 可选插件 ，在右上角的输入框中输入“gogs”来筛选插件：

![img](https://images2018.cnblogs.com/blog/668104/201803/668104-20180323123620877-1149383690.png)

# 在gogs中配置

1. 进入我们的仓库，点击仓库设置

![img](https://images2018.cnblogs.com/blog/668104/201803/668104-20180323124010192-1728342384.png)

2.添加webhook

点击 管理Web钩子 -> 添加Web钩子 ->选择Gogs

![img](https://images2018.cnblogs.com/blog/668104/201803/668104-20180323124238564-968104769.png)

添加如下配置：

![img](https://images2018.cnblogs.com/blog/668104/201803/668104-20180323124510238-2056032717.png)

推送地址的格式为：`http(s)://<你的Jenkins地址>/gogs-webhook/?job=<你的Jenkins任务名>`

3.配置Jenkins

进入主面板，点击我们的任务：

![img](https://images2018.cnblogs.com/blog/668104/201803/668104-20180323124945286-673566783.png)

选择配置：

![img](https://images2018.cnblogs.com/blog/668104/201803/668104-20180323125006824-679229001.png)

选择Gogs Webhook 根据自己的需要进行配置，如果没有设置密钥那么什么都不用动。

![img](https://images2018.cnblogs.com/blog/668104/201803/668104-20180323125050591-1026292103.png)

# 测试

我们回到gogs，点击 推送测试 ，推送成功之后会看到一条推送记录

![img](https://images2018.cnblogs.com/blog/668104/201803/668104-20180323125152960-591204673.png)

回到我们的Jenkins可以看到已经成功进行了一次构建：

![img](https://images2018.cnblogs.com/blog/668104/201803/668104-20180323125246826-165056931.png)

> **目前学习.NET Core 最好的教程 .NET Core 官方教程 ASP.NET Core 官方教程**
> **.NET Core 交流群：923036995  欢迎加群交流**
> **如果您认为这篇文章还不错或者有所收获，您可以点击右下角的【推荐】支持，或请我喝杯咖啡【赞赏】，这将是我继续写作，分享的最大动力！**

作者：[晓晨Master（李志强）](http://www.cnblogs.com/stulzq)

声明：原创博客请在转载时保留原文链接或者在文章开头加上本人博客地址，如发现错误，欢迎批评指正。凡是转载于本人的文章，不能设置打赏功能，如有特殊需求请与本人联系！



分类: [Jenkins](https://www.cnblogs.com/stulzq/category/1184053.html)

标签: [webhook](https://www.cnblogs.com/stulzq/tag/webhook/), [gogs](https://www.cnblogs.com/stulzq/tag/gogs/), [Jenkins](https://www.cnblogs.com/stulzq/tag/Jenkins/)

[好文要顶](javascript:void(0);) [关注我](javascript:void(0);) [收藏该文](javascript:void(0);) [![img](https://common.cnblogs.com/images/icon_weibo_24.png)](javascript:void(0);) [![img](https://common.cnblogs.com/images/wechat.png)](javascript:void(0);)

![img](https://pic.cnblogs.com/face/668104/20200927202019.png)

[晓晨Master](https://home.cnblogs.com/u/stulzq/)
[关注 - 41](https://home.cnblogs.com/u/stulzq/followees/)
[粉丝 - 2934](https://home.cnblogs.com/u/stulzq/followers/)





[+加关注](javascript:void(0);)

2

0





快速评论



[« ](https://www.cnblogs.com/stulzq/p/8629165.html)上一篇： [ASP.NET Core DevOps](https://www.cnblogs.com/stulzq/p/8629165.html)
[» ](https://www.cnblogs.com/stulzq/p/8629954.html)下一篇： [Jenkins持续集成演示](https://www.cnblogs.com/stulzq/p/8629954.html)

posted @ 2018-03-23 12:54  [晓晨Master](https://www.cnblogs.com/stulzq/)  阅读(14277)  评论(2)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=8629720)  [收藏](javascript:void(0))  [举报](javascript:void(0))



