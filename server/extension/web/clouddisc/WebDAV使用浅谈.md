# WebDAV使用浅谈

# 什么是 WebDAV 呢？

简单的来说，它像是一个各种 App 都能够连接的一种存储服务，可以让 App 直接访问我们的云盘。

想想看，有一只章鱼，云盘是它的大脑，WebDAV 是它的触角。每个触角都连接着我们在智能设备上的 App，我们的 App 能够通过触角读取这只章鱼的大脑，并将资料写入大脑。

# 支持 WebDAV 方式的常见网盘有：

国外网盘：[Box.com](https://box.com/)、[Dropbox.com](https://www.dropbox.com/) 等

国内网盘：[坚果云](https://jianguoyun.com/)

私有云：[OwnCloud](https://owncloud.org/)、[Seafile](https://www.seafile.com/) 等

由于国内的网络状况原因，国外网盘或多或少会存在问题，而私有云则需要用户自行使用本地服务器搭建，存在一定的难度。综合以上，推荐使用国内的坚果云作为**同步云**网盘。

# 同步手机应用数据

**以SafeInCloud为例，其他支持WebDAV的APP（比如纯纯写作）的同步方法一样**

> **同步方法**

1. **登录[坚果云](https://link.jianshu.com/?t=https://www.jianguoyun.com/)，在左上角创建个人同步文件夹，文件夹名称最好容易记，等会还要用**

   ![img](https://upload-images.jianshu.io/upload_images/8571330-2d69eb088274a618.png?imageMogr2/auto-orient/strip|imageView2/2/w/977/format/webp)

   

2. **进入SafeInCloud，在登录界面选择WebDAV登录**

![img](https://upload-images.jianshu.io/upload_images/8571330-9c115b7de78612bb.png?imageMogr2/auto-orient/strip|imageView2/2/w/513/format/webp)

- 协议选择：**https**
- HOST填写： **dav.jianguoyun.com/dav**
- 端口不用管
- 本地路径填写创建的**同步文件夹**名字(例如：SafeInCloud)
- 用户密码可填**应用密码**或者**坚果云密码**



13人点赞



[公开记事本](https://www.jianshu.com/nb/17881283)