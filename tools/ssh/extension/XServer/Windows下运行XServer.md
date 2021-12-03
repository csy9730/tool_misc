# [Windows下运行XServer](https://www.cnblogs.com/itech/archive/2010/02/23/1672137.html)

## 一 XServer和XClient

​    X windows，笼统的称为X，是一种位图显示的视窗系统，是建立图形用户界面的标准工具包和协议。X 是协议，不是具体的应用程序。X 为GUI环境提供了基本的框架：在屏幕上绘图、移动视窗以及与鼠标键盘的互动。
​       现在多用x11版本，X11R6全称为X protocol version 11 release 6。X11使用户可以运行基于X11的应用程序。
​       X是通过server/client架构来实现工作的。
​       Xserver：server为图行程序提供显示服务，并接受用户界面输入，把输入事件交给图行程序（可以是windows manager）处理，并能创建、映射、删除视窗以及在视窗中写和绘图。
​       Xclient：client是一个运行在连接X服务器上的应用程序。它可以发送请求给server，并从server处接受事件。

​    Windows manager，窗口管理器是一个特殊的图形应用程序，它对其他图行程序运行的窗口进行管理，为窗口提供装饰（标题栏、边框等）、对窗口操作提供支持（改变大小、移动、重叠）。许多窗口管理器还提供了虚拟桌面、鼠标手势等功能。Xserver一般只允许一个窗口管理器运行。如果没有窗口管理器，图行程序也可以运行的，但只有最新运行的程序在最上端，并且全屏显示，无法窗口切换。

​    桌面环境（desktop），这是一个容易和窗口管理器混淆的概念。桌面环境一般自带一个窗口管理器，并提供更多的实用程序。如方便管理的控制中心、文件管理等。

​    X display manager（XDM、gdm、wdm），Display manager对多个Xserver进行管理（本地的或远程的）。Linux 机器如果以级别5启动，进入的用户登陆界面就是display manager，用户输入用户名和密码，display manager就会启动本地的Xserver，初始化一个x会话，一般还通过xsession启动本地的窗口管理器和桌面环境。如果在配置文件里设置xdmcp=true，display manager还可以通过xdmcp协议管理远程的Xserver。当在windows机器上使用Xmanager登陆linux/unix机器时，其实是用xdmcp协议登录的，用户同样输入用户名/密码登陆，xdm启动一个x会话，不过这次的Xserver是在远程的机器上。

 

## 二 windows上运行远程linux服务器上的图形界面程序

 如果需要运行远程linux服务器上的图形界面程序，光用ssh登录是运行不了的。因为没有图形界面的支持。linux的图形界面程序是典型的C/S结构，需要一个X server和X client（通常是程序本身）才能正常运行、正常显示结果。如果本地的操作系统也是linux，且有图形界面，就表示本地已经运行了X server，则远程的图形界面X client会连接到本地的X server，即可运行；如果本地的操作系统是windows，则需另外运行一个X server程序，然后远程的linux图形X client会连接本地的xserver。

 

## 三 Cygwin

 cygwin提供window上linux环境的模拟，主页 <http://www.cygwin.com/>，安装时选择xserver相关组件。

 步骤：

1） startXwin.sh & （启动server）

2） ssh –X –l username IP （连接到Linux）

3） gedit& （打开linux上的gedit在本地windows）



## 四  xwinlogon （没有试成功）

基于cygwin的，下载：http://sourceforge.net/projects/xwinlogon/files/。

五 Xming + Putty （超级牛逼的在windows下访问linux的界面）（强烈推荐）

下载：<http://sourceforge.net/projects/xming/files/>

安装后xming server自动运行，如果没有运行，请通过桌面快捷菜单启动，或用命令"C:\Program Files (x86)\Xming\Xming.exe" :0 -clipboard -multiwindow 来启动。

下载putty.exe然后直接运行，然后在PuTTY的配置中，把Connection》SSH》X11中的Enable X11 fowarding勾选上。

连接你的linux机器，然后运行启动gnome-terminal 和gedit，当然你可以运行任何的UI应用程序。

![img](https://images.cnblogs.com/cnblogs_com/itech/linux/xming3.png)




## 六 其他的

商业的x window server

<http://www.labf.com/winaxe/>

<http://www.starnet.com/products/xwin32/>

<http://www.microimages.com/mix/>

 

免费的x window server

<http://www.mochasoft.dk/freeware/x11.htm>

 

## 参考

使用cygwin X server实现Linux远程桌面 (for windows) ：http://easwy.com/blog/archives/linux-remote-desktop-via-cygwin-x-server/

参考 xming+putty： http://www.cnblogs.com/zzub/archive/2011/04/08/2009854.html#2065566

完！

 


作者：[iTech](http://itech.cnblogs.com/)
微信公众号: cicdops
出处：<http://itech.cnblogs.com/>
github：<https://github.com/cicdops/cicdops>