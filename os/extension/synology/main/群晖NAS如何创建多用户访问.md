# 群晖NAS如何创建多用户访问

[胖哥叨逼叨](https://www.pangshare.com/jerrysayprofile/jerry) • 2019年6月30日 am12:13 • [技术分享](https://www.pangshare.com/category/tshare) • 阅读 8622

今天和大家分享一下如何在[群晖NAS](https://www.pangshare.com/tag/群晖nas)中创建多用户访问，每个人一个用户，将数据同步到属于自己的文件夹中，这样在PC、手机上可以只看到属于自己的文件夹。一直想用树莓派3B+搞一个[黑群晖](https://www.pangshare.com/tag/黑群晖)做个测试，学习学习。可惜这树莓派3B+这性能属实太尴尬不适合。不过最近树莓派4马上就发布了。4G内存版本还是比较诱惑的。

我们今天用ESXI部署了一台[群晖](https://www.pangshare.com/tag/群晖)NAS，在创建多用户的时候一直在手机端无法显示文件夹。本来一个很简单的操作，却折腾半天。现在把步骤描述一下做个记录。

[![群晖NAS如何创建多用户访问](https://cdn.pangshare.com/wp-content/uploads/2019/06/image.png)](https://cdn.pangshare.com/wp-content/uploads/2019/06/image.png)1、创建用户

[![群晖NAS如何创建多用户访问](https://cdn.pangshare.com/wp-content/uploads/2019/06/image-1.png)](https://cdn.pangshare.com/wp-content/uploads/2019/06/image-1.png)2、填写用户名、密码（对于密码需要注意复杂度的要求）

[![群晖NAS如何创建多用户访问](https://cdn.pangshare.com/wp-content/uploads/2019/06/image-2.png)](https://cdn.pangshare.com/wp-content/uploads/2019/06/image-2.png)3、勾选默认的组即可（users group）

[![群晖NAS如何创建多用户访问](https://cdn.pangshare.com/wp-content/uploads/2019/06/image-4.png)](https://cdn.pangshare.com/wp-content/uploads/2019/06/image-4.png)4、选择我们刚创建的用户，权限勾选上“可读写”

下面的步骤一直下一步即可。最关键的就是下面这一步。

[![群晖NAS如何创建多用户访问](https://cdn.pangshare.com/wp-content/uploads/2019/06/image-5.png)](https://cdn.pangshare.com/wp-content/uploads/2019/06/image-5.png)5、打开Drive管理控制台将刚创建的文件夹点击启用即可

此时我们在手机上打开Drive App，成功登陆后即可看见我们创建的文件夹了。