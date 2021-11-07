# 如何快速搭建 Discuz! 论坛

2018-10-17阅读 2.5K0

**Discuz!**全称：Crossday Discuz! Board，是一套免费使用的社区论坛软件系统，由北京康盛新创科技有限责任公司推出，目前最新版本是Discuz! X3.4。自面世以来，Discuz!已拥有18年以上的应用历史和数百万网站用户案例，是全球成熟度最高、覆盖率最大的论坛软件系统之一。用户可以在不需要任何编程的基础上，通过简单的设置和安装，在互联网上搭建起具备完善功能、很强负载能力和可高度定制的论坛服务。Discuz!的基础架构采用世界上最流行的web编程组合PHP+[MySQL](https://cloud.tencent.com/product/cdb?from=10680)实现，是一个经过完善设计，适用于各种服务器环境的高效论坛系统解决方案，无论在稳定性、负载能力、安全保障等方面都居于国内外同类产品领先地位。

在本教程中，我们将以Centos 6.5系统的64位服务器为例，教你如何安装设置Discuz!，构建属于你的论坛。如果你还没有服务器，你可以在[这里](https://cloud.tencent.com/act/free?from=10680)免费领取一台腾讯[云服务器](https://cloud.tencent.com/product/cvm?from=10680)，当然作为土豪的你肯定也可以参考[文档](https://cloud.tencent.com/document/product/555/7452?from=10680)自己花钱购买一台。下面我们开始论坛搭建的过程：

## 安装LAMP集成环境

LAMP是Linux+Apache+MySql+PHP的简称，安装LAMP的步骤比较冗长，有兴趣的同学可以参考腾讯云提供的[实验手册](https://cloud.tencent.com/developer/labs/lab/10026?from=10680)自己动手搭建，本文不再向描述。这里，我们提供一种更为快速便捷的安装方案，通过腾讯云云市场中的[PHP全能运行环境](https://market.cloud.tencent.com/products/60)镜像来进行搭建。

首先，我们进入腾讯云官网的[服务器控制台](https://console.cloud.tencent.com/cvm/index)，选择需要安装LAMP集成环境的云服务器进行重装。

![img](https://ask.qcloudimg.com/draft/1000019/8mui6t1x9m.png?imageView2/2/w/1620)

然后，在重装的界面选择“服务市场->全能环境->PHP全能运行环境”镜像，输入自定义的服务器密码，点击“开始”进行系统重装。

![img](https://ask.qcloudimg.com/draft/1000019/bhi3o8726k.png?imageView2/2/w/1620)

等待系统重装成功，我们即完成了LAMP集成环境的安装。

## 连接服务器

首先检查你的服务器安全组设置，确保其开放SSH使用的22和HTTP访问使用80端口以及我们上传文件的21端口。然后我们通过SSH软件登录服务器，如果你本地电脑是Windows情况下可以使用putty等软件，Linux及MacOS请使用终端进行连接。

我这里以MobaXterm的终端软件为例，点击左上角的`Session`按钮，选择以`SSH`方式连接，在`Remote host`输入你的服务器的公网IP地址，`Specify username`输入你的用户名，如果你的服务器是Ubuntu系统，请输入`ubuntu`如果是CentOS系统则输入`root`。这里我们是CentOS系统，所以我们输入`root`。

![img](https://ask.qcloudimg.com/draft/1000019/y0va4z6aa6.png?imageView2/2/w/1620)

点击`OK`后，输入你设置的密码（默认不显示），即可连接到你的服务器，你会看到类似下面的页面。

![img](https://ask.qcloudimg.com/draft/1000019/56frpjudgd.png?imageView2/2/w/1620)

这样，你就进到你的服务器的页面了。

## 查看数据库及FTP服务器的账户密码

进入服务器后，镜像已经帮你搭建好了 Discuz!所需的环境，你只需要查看密码即可使用这个服务器。首先我们输入`ls`命令查看当前目录文件，然就我们会发现一个名为`default.pass`的文件，使用`cat default.pass`命令展示当前生成的密码。

```js
ls
cat default.pass
```

你会看到类似下面的输出

```js
[root@VM_0_7_centos ~]# ls
README.txt  anaconda-ks.cfg  default.pass  install.log  install.log.syslog
[root@VM_0_7_centos ~]# cat default.pass
+----------------------------------------------------------------------
| YJCOM [ EASY CLOUD EASY WEBSITE]
+----------------------------------------------------------------------
| Copyright (c) 2015 http://yjcom.com All rights reserved.
+----------------------------------------------------------------------

MySQL root password: gOeuPMkjSbVn
MySQL database name: ZjI4meIu
MySQL user: ZjI4meIu
MySQL password: dk0KknIIXfn8

FTP account: www
FTP password: SvlLQX5nYEq5
[root@VM_0_7_centos ~]#
```

## 部署Discuz!

获取到FTP及数据库密码后，我们就可以部署Discuz!论坛了，首先，我们需要下载Discuz!的安装包。

### 下载Discuz!

从 2018 年 1 月 1 日起Discuz!只在官方 Git 发布，所以我们打开Discuz!的[官方git](https://gitee.com/ComsenzDiscuz/DiscuzX/tree/master/upload)，然后点击右边的克隆下载。

![img](https://ask.qcloudimg.com/draft/1000019/8wvvsmkq3t.png?imageView2/2/w/1620)

下载完成后，我们就需要上传啦！

### 上传Discuz!

上传前我们需要用软件链接到FTP服务器才行，通过我们上一步获取的FTP账户`www`及密码`SvlLQX5nYEq5`使用ftp软件登录FTP服务器，这里我们依然以MobaXterm为例，点击左上角的`Session`按钮，选择以`FTP`方式连接，在`Remote host`输入你的服务器的公网IP地址，`Username`输入你的用户名，这里我们获取到的是`www`，输入`www`，点击`OK`后，输入你设置的密码，即可连接到你的服务器，你会看到类似下面的页面。

![img](https://ask.qcloudimg.com/draft/1000019/sm71fw2jz1.png?imageView2/2/w/1620)

接下来我们将下载的Discuz!文件解压出来，然后双击解压出来的`upload`文件夹，将所有文件全部上传到FTP服务器。

![img](https://ask.qcloudimg.com/draft/1000019/atyz2eqfjh.png?imageView2/2/w/1620)

上传完成后你就可以打开`http://你的IP/install/`访问安装页面啦！

### 安装Discuz!

访问`http://你的IP/install/`页面，会看到系统提示你可以进一步安装你的博客了。

![img](https://ask.qcloudimg.com/draft/1000019/uoe3zdkyip.png?imageView2/2/w/1620)

点击我同意后，系统可能会提示你不稳文件权限不对，那么我们要赋予这些目录写入权限才行。

![img](https://ask.qcloudimg.com/draft/1000019/32rr08h306.png?imageView2/2/w/1620)

我们需要在你的`www`目录下执行`chmod`命令赋予这几个文件可写入的权限，使用下面的命令。

```js
cd /yjdata/www/www
chmod -R 777 uc_client/
chmod -R 777 uc_server/
chmod -R 777 data/
chmod -R 777 config/
```

执行完后，刷新页面，这下你的Discuz!就可以继续安装了，我们点击`下一步`。接下来，需要选择安装类型，我们并非升级，所以选择`全新安装 Discuz! X (含 UCenter Server)`。然后继续点击`下一步`，这里需要我们输入数据库的信息，由于我们使用的本地自建的数据库，所以我们使用上面得到的数据库账户及密码。

```js
MySQL root password: gOeuPMkjSbVn
MySQL database name: ZjI4meIu
MySQL user: ZjI4meIu
MySQL password: dk0KknIIXfn8
```

请按照图中填写，数据库服务器、数据库名、数据库用户名、数据表前缀保持默认，我们只需要修改数据库密码，系统信箱Email即可。数据库密码为上面的`gOeuPMkjSbVn`，系统信箱为你的邮箱服务器的信箱（可保持默认），管理员账户请自行填写（可保持默认），管理员密码填你记的住的密码。管理员Email为你自己的邮箱。填写完成后我们点击下一步。

![img](https://ask.qcloudimg.com/draft/1000019/tg9ofg4lat.png?imageView2/2/w/1620)

接下来系统会提示正在安装。

![img](https://ask.qcloudimg.com/draft/1000019/7b1ykeeqod.png?imageView2/2/w/1620)

等待十几秒，会提示安装成功，这样，你的Discuz!就部署完成了，赶快登陆到后台去进行相关设置吧！

![img](https://ask.qcloudimg.com/draft/1000019/sa1p6o9twz.png?imageView2/2/w/1620)

然后，我们登陆论坛后台http://你的IP地址/admin.php就可以对站点进行设置了。

![img](https://ask.qcloudimg.com/draft/1000019/dsybfxlogz.png?imageView2/2/w/1620)

## 总结

现在，你已经成功将Discuz! X3.4部署在你的腾讯云服务器上，怎么样，学会了吗？

如果你是在生产环境使用本Discuz! X3.4，那么非常不推荐使用本地MySQL数据库，你可以尝试购买腾讯云[云关系型数据库](https://cloud.tencent.com/product/cdb-overview?from=10680)，云[关系型数据库](https://cloud.tencent.com/product/cdb-overview?from=10680)是一种高度可用的托管服务，提供容灾、备份、恢复、监控、迁移等数据库运维全套解决方案，可将您从耗时的Discuz!数据库管理任务中解放出来，让您有更多时间专注于您的应用和业务。