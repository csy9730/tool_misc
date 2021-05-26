# X11 forwarding，Windows与Linux结合的最佳开发环境【编程环境优化篇】

[塔叔](https://www.zhihu.com/people/fang-da-tong-15-74)

talk is cheap



6 人赞同了该文章



大多数时候服务器上都没有安装图形界面，但有时候有些程序需要图形界面，比如说使用OPENCV显示图像出来，这种时候就可以利用X Server进行图形界面的显示。

主要就是 怎么样在**远程执行Linux下的GUI程序。**



## 正片：

这篇文章主要是要介绍SSH的X11 forwarding功能

首先需求是你有一台Windows机或者支持X11 Server 的其他机器都是可以的。

(本篇文章演示环境是在Windows10，和Ubuntu 16.04 Desktop之间进行演示)



**1.安装X11 Server**

推荐使用vcxsrv,其他的也是可以的，但是这个试过是最舒服。

https://sourceforge.net/projects/vcxsrv/sourceforge.net



安装完成后一路下一步就可以开启了。

![img](https://pic4.zhimg.com/80/v2-b77908716877d2523f7403f82c8b468f_720w.jpg)

![img](https://pic4.zhimg.com/80/v2-7cf9e7cc83aca226a8dc0ec6fa6c16f3_720w.jpg)

![img](https://pic3.zhimg.com/80/v2-c5dcd90778bdacd71ba7cb9f08f3e8ba_720w.jpg)

![img](https://pic3.zhimg.com/80/v2-9097d2db4148ea44c208ddd2659832e6_720w.jpg)

**2.开启X11 Forwarding**

这里用到的ssh client是bitvise, 其他的client（比如putty）也有对应的功能。可以自行百度摸索一下。

![img](https://pic2.zhimg.com/80/v2-2b185be5e76ca0afeda0afd0f6ba27a9_720w.jpg)

开启传输压缩:

![img](https://pic4.zhimg.com/80/v2-a01aab30a79152b5a1db6eac7a88fc53_720w.jpg)开启传输压缩

重新登录一下，保持命令窗口不要关闭



**3.命令行执行需要GUI的程序**


可以试试xclock,xterm之类的程序，也可以运行IDE等，firefox等。

**（!没有安装桌面环境的服务器需要先安装上桌面环境）**



> $ firefox

![img](https://pic3.zhimg.com/80/v2-35ff3375b71383f64db149c06c415b42_720w.jpg)在Windows桌面下打开了Ubuntu中的火狐浏览器

> $ xterm

![img](https://pic4.zhimg.com/80/v2-2663fdb3ba653b3b45371d581ea7bb1b_720w.jpg)在Windows桌面下打开了Ubuntu中的xterm



## Q: 上面的设置太麻烦了，有没有别的更简单的方法

## A: 有。

**还有更简单的MobaX term软件,默认自动开启了X11 Server及X11 Forwarding及传输压缩，傻瓜版**

![img](https://pic3.zhimg.com/80/v2-ff5185b8d7e2935dbb62144866f45402_720w.png)MobaXterm 终端

MobaXterm free Xserver and tabbed SSH client for Windowsmobaxterm.mobatek.net![图标](https://pic3.zhimg.com/v2-e9048dc002674fd55137d71755096cd6_180x120.jpg)



![img](https://pic2.zhimg.com/80/v2-0caf6857688e7df8bfe3c4bfd99a66f1_720w.jpg)





## 写在后面的话:

拖了很长时间想写一下这个，最近总算是有空来完成一下。

最近也是研究了一下如何在Windows环境下去使用IDE在远程调试Linux上面的程序，经过了一番折腾之后，最终是在X11 forwarding 上停了下来，也是达到了一种比较满意的结果。



实测这种方法加上 远程打开的[JetBrains](https://link.zhihu.com/?target=https%3A//www.jetbrains.com/)的开发工具会让开发很舒服。

1. 会让你的远程debug更加得心应手，当然这样的方法也是有局限性的，比如说需要一个比较稳定的网络，但总体来说是非常棒的体验了。



附心路历程：

请问 VS code 编辑远程文件有没有什么好方法，通过 ssh 这样的。 - V2EXwww.v2ex.com





enjoy it :)