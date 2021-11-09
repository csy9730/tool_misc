# 如何安装R与Rstudio

[![Anakin Skywalker](https://pic1.zhimg.com/v2-53ad28b60a911377162129f5aa731a65_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/anakin_skywalker)

[Anakin Skywalker](https://www.zhihu.com/people/anakin_skywalker)





562 人赞同了该文章

虽然此前推出过很多使用R做数据分析的文章，但对于新手来说，得首先从安装R学起。

## R是什么？

R是用于**统计计算**和**绘图**的**免费**软件环境。

[R语言_百度百科baike.baidu.com/item/R%E8%AF%AD%E8%A8%80/4090790?fr=aladdin![img](https://pic3.zhimg.com/v2-b58836c5411637c9c20463a47df448ce_180x120.jpg)](https://link.zhihu.com/?target=https%3A//baike.baidu.com/item/R%E8%AF%AD%E8%A8%80/4090790%3Ffr%3Daladdin)

> R is a free software environment for statistical computing and graphics.

[R官方网站www.r-project.org/](https://link.zhihu.com/?target=https%3A//www.r-project.org/)

安装R的步骤主要分**两步**：安装**R**以及安装**RStudio**。RStudio是一款R语言的IDE（集成开发环境），操作界面简洁美观。

## 安装R

进入R官方网站，点击**download R**

![img](https://pic3.zhimg.com/80/v2-141751c829b506f5cb87dc682c5d74be_1440w.jpg)R官方网站

之后选择**CRAN**(The Comprehensive R Archive Network)镜像

![img](https://pic4.zhimg.com/80/v2-ba837a0f44bae57c471b9641b8df03b7_1440w.jpg)CRAN镜像

根据所在的国家选择镜像，这里以中国为例

![img](https://pic1.zhimg.com/80/v2-f58d117e533943d0081b3142ba9b2634_1440w.jpg)

选择其中一个镜像，如第一个清华大学镜像

![img](https://pic2.zhimg.com/80/v2-08605f250bb241aebab2d00b9d2c8071_1440w.jpg)

根据电脑系统选择相应的R版本进行下载，这里以windows为例

![img](https://pic4.zhimg.com/80/v2-aa4e53e4b63450fa4a23d30e9ba7fd6f_1440w.jpg)

点击**install R for the first time**（首次安装R）

![img](https://pic3.zhimg.com/80/v2-105904319c0637ded5133775025694a6_1440w.jpg)

点击Download R 3.6.2 for Windows即可下载最新版本的R

下载完成后安装即可

## 安装RStudio

[RStudio官方网站](https://link.zhihu.com/?target=https%3A//rstudio.com/)

![img](https://pic4.zhimg.com/80/v2-4c2b251a275c1146cd568d64f393f5db_1440w.jpg)

进入官网后鼠标放在**Products**菜单上，之后选择红框中的RStudio

![img](https://pic2.zhimg.com/80/v2-dca4438555f9fab13cc3fcca91e4f2c1_1440w.jpg)

选择**RStudio桌面版**

![img](https://pic4.zhimg.com/80/v2-26073e9d2c524a7e6e217b8081b70d87_1440w.jpg)

左边是**开源免费版**，右边是**专业收费版**

点击**DOWNLOAD RSTUDIO DESKTOP**

![img](https://pic2.zhimg.com/80/v2-3cfd11760be1dd625103caafa98b73f9_1440w.jpg)

点击**DOWNLOAD**

![img](https://pic3.zhimg.com/80/v2-bac7f3a17dbcc6e502029579ac80f78e_1440w.jpg)

Windows用户直接点击红框中的**DOWNLOAD RSTUDIO FOR WINDOWS**即可开始下载

其他操作系统如mac或Ubuntu等用户在页面下方选择相应安装包

下载完成之后安装即可

## 测试是否安装成功

安装好R和RStudio后，桌面或开始菜单会出现相应的软件图标

我们无需打开R，而是**通过RStudio打开R**。因此，只需要在桌面双击RStudio图标或在开始菜单点击RStudio图标即可

![img](https://pic4.zhimg.com/80/v2-0354093ea3aca5e4fef3975488e57653_1440w.jpg)

最新的RStudio图标长这样：

![img](https://pic1.zhimg.com/80/v2-fc690755c03d7c258c1a439947e63f98_1440w.png)最新的RStudio图标

打开RStudio后的界面如下：

![img](https://pic4.zhimg.com/80/v2-13ba7aab639edbeddc7d247f75ebf143_1440w.jpg)

在代码界面输入

```text
print("hello world!")
[1] "hello world!"
```

可以看到RStudio可以正常运行

## 选择更新R包镜像源

R包的作者时常更新其R包的版本，在更新R包时如果选择国内的镜像源，**更新速度**会快很多。

选择**Tools**菜单下的**Global Options**

![img](https://pic2.zhimg.com/80/v2-d7a4dc0dda74385f7c29b85dd8eceb41_1440w.jpg)

选择左侧栏中的**Packages**，在Package Management下点击**Change**选择首选的CRAN库

![img](https://pic1.zhimg.com/80/v2-418619f6456c1c51f42de62fce4fd998_1440w.jpg)

点击Apply应用即可，以后更新R包变会首选国内的服务器。设置好后，开始你的R语言学习之旅吧！

发布于 2020-02-27

Rstudio

统计软件

心理测量学

赞同 562

548 条评论

分享