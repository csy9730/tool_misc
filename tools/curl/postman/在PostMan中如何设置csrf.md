# 在PostMan中如何设置csrf

[![img](https://cdn2.jianshu.io/assets/default_avatar/3-9a2bcc21a5d89e21dafc73b39dc5f582.jpg)](https://www.jianshu.com/u/7b4f80f6744d)

[FGCore](https://www.jianshu.com/u/7b4f80f6744d)关注

2020.02.29 19:17:39字数 321阅读 1,364

CSRF简介

  CSRF攻击的全称是跨站请求伪造（ cross site request forgery)，是一种对网站的恶意利用，尽管听起来跟XSS跨站脚本攻击有点相似，但事实上CSRF与XSS差别很大，XSS利用的是站点内的信任用户，而CSRF则是通过伪装来自受信任用户的请求来利用受信任的网站。你可以这么理解CSRF攻击：攻击者盗用了你的身份，以你的名义向第三方网站发送恶意请求。 CRSF能做的事情包括利用你的身份发邮件、发短信、进行交易转账等，甚至盗取你的账号。

 在PostMan中没有设置csrf的情况下如下图（不考虑安全的情况系后台可以禁用csrf）

![img](https://upload-images.jianshu.io/upload_images/4356395-73c874e30be79596.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

 在PostMan中如何设置csrf呢？ 

**第一步**

  在Cookies标签页面中找到对应的cookie变量并设置在【Tests】脚本的变量里面



![img](https://upload-images.jianshu.io/upload_images/4356395-e5de4412282bffdc.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

**脚本代码贴上**

var csrf_token = postman.getResponseCookie("XSRF-TOKEN").value

postman.clearGlobalVariable("XSRF-TOKEN");

postman.setGlobalVariable("XSRF-TOKEN", csrf_token);

**第二步**

在【Headers】中获取变量“XSRF-TOKEN的值。获取值的方式：{{XSRF-TOKEN}}

![img](https://upload-images.jianshu.io/upload_images/4356395-f06d1a9cc8a633ed.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

点击【Send】按钮后成功获取到值

![img](https://upload-images.jianshu.io/upload_images/4356395-4f3ab265df805925.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)



0人点赞



[云笔记](https://www.jianshu.com/nb/43423218)