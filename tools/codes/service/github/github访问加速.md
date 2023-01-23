# github访问加速
[https://zhuanlan.zhihu.com/p/75994966](https://zhuanlan.zhihu.com/p/75994966)

1.  **使用镜像网站**
2.  **使用代理网站下载**
3.  **cdn加速**
4.  **转入gitee加速**

**概括:**

如果是**下载比较大的项目**,比如耗时5min往上,大小30mb往上,十分推荐**使用代理网站下载,或者转入gitee**的方式下载.

如果仅仅是**下载比较小的项目**,类似代码性质,文档性质的项目,**使用cdn加速**,提升到100多KB/s也就够用了

## 一.使用镜像网站

**使用github的镜像网站** [https://hub.fastgit.org/](https://hub.fastgit.org/) 进行搜索

## 二. 使用代理网站下载

对于github release中下载的大文件

使用[https://toolwa.com/github/](https://toolwa.com/github/)来下载，**速度起飞,无需注册，亲测有效**。

* * *

## 三. cdn加速

通过修改系统hosts文件的办法，绕过国内dns解析，直接访问GitHub的CDN节点，从而达到github访问加速的目的。不需要海外的服务器辅助。

> GitHub在国内访问速度慢的问题原因有很多,但最直接和最主要的原因是GitHub的分发加速网络的域名遭到dns污染,下载网站上任何东西的时候会下半天,有时还会失败需要从头再来,多失败了几次又因访问次数过多被做了ip限制,让人恼火

做到以上需要三步

1.  获取GitHub官方CDN地址
2.  修改系统Hosts文件
3.  刷新系统DNS缓存

* * *

### 1\. **获取GitHub官方CDN地址**

  
首先,打开

查询以下三个链接的DNS解析地址

1.  [github.com](http://github.com/)
2.  [assets-cdn.github.com](http://assets-cdn.github.com/)
3.  [github.global.ssl.fastly.net](http://github.global.ssl.fastly.net/)

![](https://pic2.zhimg.com/v2-e34e023b48f51e9ac8b11d03c5d95bfd_b.jpg)

![](https://pic2.zhimg.com/v2-944ff508d171711d41ad7c8a78951601_b.jpg)

![](https://pic3.zhimg.com/v2-856cade48b85c965ff4b7239fb65a9d6_b.jpg)

### **2\. 修改系统Hosts文件**

  
接着,打开系统hosts文件(需管理员权限)。  
路径：C:\\Windows\\System32\\drivers\\etc

> mac或者其他linux系统的话,是/etc下的hosts文件,需要切入到root用户修改

```text
# Copyright (c) 1993-2009 Microsoft Corp. 
# 
# This is a sample HOSTS file used by Microsoft TCP/IP for Windows. 
# 
# This file contains the mappings of IP addresses to host names. Each 
# entry should be kept on an individual line. The IP address should 
# be placed in the first column followed by the corresponding host name. 
# The IP address and the host name should be separated by at least one 
# space. 
# 
# Additionally, comments (such as these) may be inserted on individual 
# lines or following the machine name denoted by a '#' symbol. 
# 
# For example: 
# 
#      102.54.94.97     rhino.acme.com          # source server 
#       38.25.63.10     x.acme.com              # x client host 




# localhost name resolution is handled within DNS itself. 
#   127.0.0.1       localhost 
#   ::1             localhost 


140.82.113.3    github.com
185.199.108.153 assets-cdn.github.com
199.232.69.194  github.global.ssl.fastly.net
```

并在末尾添加三行记录并保存。(需管理员权限，注意IP地址与域名间需留有空格)

> 感谢评论区 [@trans-bug](https://www.zhihu.com/people/aaf2faa08e21db7432565e0fbd79cd9f) 的分享， 对于ubuntu系统，修改完hosts文件执行如下命令: **sudo /etc/init.d/network-manager restart**

### **3\. 刷新系统DNS缓存**

  
最后,Windows+X 打开系统命令行（管理员身份）或powershell

运行 ipconfig /flushdns 手动刷新系统DNS缓存。

> mac系统修改完hosts文件,保存并退出就可以了.不要要多一步刷新操作.  
> centos系统执行/etc/init.d/network restart命令 使得hosts生效

![](https://pic3.zhimg.com/v2-356517675d47da314b288a95807965c6_b.jpg)

* * *

## 四. 转入gitee加速

最终下载速度对比

**github** 42KB/s (加了github访问cdn)

![](https://pic4.zhimg.com/v2-f7170be0c6cd8ba1f1a15ae8aad292c7_b.jpg)

github下载速度

**gitee** 1034KB/s 大约25倍与github的速度

![](https://pic4.zhimg.com/v2-72dd9eb98e349a4117d616c8a6162c87_b.jpg)

gitee下载速度

例:我们要下载[https://github.com/DoubleLabyrinth/navicat-keygen](https://github.com/DoubleLabyrinth/navicat-keygen)

先访问要下载的仓库的地址（在chrome中打

点击fork （fork会把这个仓库复制一份到你的github账号的名下，所以你需要有个githu账号，没有的注册一下，有了的记得登陆）

点完之后

![](https://pic2.zhimg.com/v2-556279ed6be1297498c11506a79375f9_b.jpg)

注意到这个仓库已经到了我们的名下

好了 github这边的事我们暂时做完了

现在登陆gitee （没有账号的注册一个账号）

然后点击

![](https://pic1.zhimg.com/v2-81aa2e63cbb16d0f29ab46ee915a1fa4_b.jpg)

gitee

接着会出现一个授权

![](https://pic3.zhimg.com/v2-7afa5ead85ee6b07a0b731425c147c42_b.jpg)

然后可能会出现第一输入密码的地方

![](https://pic1.zhimg.com/v2-07599425c7282d680234f2c22461ad68_b.jpg)

这儿输入mac的登陆密码 并点击始终允许

然后出现

![](https://pic2.zhimg.com/v2-aee51229781dd9a6a2a99a576d7ccc11_b.jpg)

输入 github账号的密码 之后出现

![](https://pic3.zhimg.com/v2-8460b1eefc401090a4e71730bc28bc62_b.jpg)

选择我们刚刚的项目 navicat-keygen -> 导入

gitee正在帮我们从github下载（gitee从github下载的速度一定是很快的，毕竟大网站）

![](https://pic1.zhimg.com/v2-6ee9cf9bf720015cabe98bc468f7346c_b.jpg)

一般来说30s内就处理好自动刷新了

![](https://pic4.zhimg.com/v2-fbd228a9c0f3c0b18eabe1a5f919bdf7_b.jpg)

然后我们复制这个网址

![](https://pic4.zhimg.com/v2-39b039fd2374741efe24a05d771fc2a7_b.jpg)

然后我们下载这个地址

可以看到速度

![](https://pic4.zhimg.com/v2-72dd9eb98e349a4117d616c8a6162c87_b.jpg)