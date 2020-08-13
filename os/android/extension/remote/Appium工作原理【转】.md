## [Appium工作原理【转】](https://www.cnblogs.com/winson-317/p/11133014.html)

 

一、Appium工作原理

![img](https://img-blog.csdn.net/20180906144556641?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L2FwcGtlODQ2/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

 

[![img](https://testerhome.com/uploads/photo/2016/e235a67ba814e315c43905ebc59821b7.png!large)](https://testerhome.com/uploads/photo/2016/e235a67ba814e315c43905ebc59821b7.png!large)

 

二、Appium的加载过程

![img](https://img-blog.csdn.net/20170405091942998?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvamZmaHkyMDE3/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

1）调用Android adb完成基本的系统操作

2）向Android上部署bootstrap.jar

3）Bootstrap.jar Forward Android的端口到PC机器上

4）Pc上监听端口接收请求，使用webdriver协议

5）分析命令并通过forward的端口发给bootstrap.jar

6）Bootstrap.jar接收请求并把命令发给uiautomator

7）Uiautomator执行命令

 

二、初步认识appium工作过程

1.appium是c/s模式的 
2.appium是基于webdriver协议添加对移动设备自动化api扩展而成的，所以具有和webdriver一样的特性，比如多语言支持 
3.webdriver是基于http协议的，第一连接会建立一个session会话，并通过post发送一个json告知服务端相关测试信息 
4.对于android来说，4.2以后是基于uiautomator框架实现查找注入事件的，4.2以前则是instrumentation框架的，并封装成一个叫Selendroid提供服务 
5.客户端只需要发送http请求实现通讯，意味着客户端就是多语言支持的 
6.appium服务端是node.js写的，所以你安装的时候无论哪个平台都是先装node，然后npm install -g appium安装(翻墙墙)

 

三、bootstrap介绍

1）Bootstrap作用：

Bootstrap是Appium运行在安卓目标测试机器上的一个UiAutomator测试脚本，该脚本的唯一一个所做的事情是在目标机器开启一个socket服务器来把一个session中Appium从PC端过来的命令发送给UiAutomator来执行处理。

它会监听4724端口获得命令然后pass给UiAutomator来做处理。

 

2）Bootstrap在appium中扮演的角色：

首先，Bootstrap是uiautomator的测试脚本，它的入口类bootstrap继承于UiautomatorTestCase，所以Uiautomator可以正常运行它，它也可以正常使用uiautomator的方法，这个就是appium的命令可以转换成uiautomator命令的关键；

其次，bootstrap是一个socket服务器，专门监听4724端口过来的appium的连接和命令数据，并把appium的命令转换成uiautomator的命令来让uiautomator进行处理；

最后，bootstrap处理的是从pc端过来的命令，而非一个文件。

 

四、所使用的技术

Android上使用了instrumentation和uiautomator两套技术

iOS使用uiautomation

同时还支持firefox, 并可扩展其他平台

默认开启4723端口接受webdriver请求 ，4723是appium服务的，专门和脚本打交道；

默认开启4724用于和[Android](http://lib.csdn.net/base/android)设备通讯

 

五、Capabilities

Capabilities是由客户端发送给Appium服务器端的用来告诉服务器去启动哪种我们想要的会话的一套键值对集合。当中也有一些键值对是用来在自动化的过程中修改服务器端的行为方式。

 

六、自我理解的工作原理

Appium启动时会创建一个http：127.0.0.1:4723/wd/hub服务端（相当于一个中转站），脚本会告诉服务器我要做什么，服务端再去跟设备打交道，服务端完成了脚本交给他的任务之后

服务端和设备如何通讯？

服务端和设备默认使用4724端口进行通讯的，底层调用uiautomator工具，在测试的时候服务端会给设备扔一个jar包就是appiumbootstrap.jar，会启动这个包，启动之后会在手机上创建一个socket服务，暴露的就是4724的端口；相对于socket服务来说，appium服务端又是一个客户端；

服务端的4724可以修改，设备上的不可以；服务端收到脚本传递过来的命令之后，通过电脑上的4724端口，想设备上的4724端口发送指令，appiumbootstrap.jar收到指令后回去完成点击，滑动其他的操作，完成之后再通过服务给服务端一个相应。服务端收到之后再去相应脚本

 

服务端和脚本如何通讯？

通过接口来访问，意味着服务端和脚本可以不在一起，只要能访问到127.0.0.1:4723这个地址就可以