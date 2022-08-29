# conhost.exe

全称是Console Host Process, 即命令行程序的[宿主进程](https://baike.baidu.com/item/%E5%AE%BF%E4%B8%BB%E8%BF%9B%E7%A8%8B/1288137)。简单的说他是微软出于安全考虑，在windows 7和Windows server 2008中引进的新的控制台应用程序处理机制。





- 外文名

  conhost.exe

- 出品者

  Microsoft Corp

- 进程类别

  系统进程

- 存储位置

  %Systemroot%\ System32

## 目录

1. 1 [进程信息](https://baike.baidu.com/item/conhost.exe/3483885#1)
2. 2 [来历及作用](https://baike.baidu.com/item/conhost.exe/3483885#2)



## 进程信息

编辑

 播报

名称：conhost.exe

是否病毒木马：否



## 来历及作用

编辑

 播报

原先，win7之前的[宿主程序](https://baike.baidu.com/item/%E5%AE%BF%E4%B8%BB%E7%A8%8B%E5%BA%8F)是由[csrss.exe](https://baike.baidu.com/item/csrss.exe)来完成的,，所有命令行进程都使用session唯一的csrss.exe进程。而到了win7则改成每个命令行进程都有一个独立的conhost作为宿主了。 这样当然有很多好处了，比如各进程之间不会相互影响，也不会影响到csrss，毕竟csrss还有其他更重要的任务要做。 当然最最重要的还是安全性的考虑，因为csrss是运行在local system账号下的，如果要处理Windows message，就要承担很多威胁，比如著名的Windows Message Shatter Attack。而如果用用户权限的conhost来处理，则即使有攻击，影响的也只是低权限的[宿主进程](https://baike.baidu.com/item/%E5%AE%BF%E4%B8%BB%E8%BF%9B%E7%A8%8B)。

其实，不论是作为普通用户还是企业管理员，我们在日常的Windows应用和运维过程中都会或多或少的使用到控制台应用程序。控制台应用程序是没有用户界面的，我们需要通过[命令提示符](https://baike.baidu.com/item/%E5%91%BD%E4%BB%A4%E6%8F%90%E7%A4%BA%E7%AC%A6)（CMD，这可不是DOS，很多人混淆不清）对其进行输入、输出操作。Windows自带的控制台应用程序 ，典型的有[cmd.exe](https://baike.baidu.com/item/cmd.exe)、[nslookup.exe](https://baike.baidu.com/item/nslookup.exe)和telnet.exe等。

[![与Csrss.exe的关系](https://bkimg.cdn.bcebos.com/pic/5bafa40f4bfbfbedfe089d9578f0f736aec31f82?x-bce-process=image/resize,m_lfit,w_440,limit_1/format,f_auto)](https://baike.baidu.com/pic/conhost.exe/3483885/0/5bafa40f4bfbfbedfe089d9578f0f736aec31f82?fr=lemma&ct=single)与Csrss.exe的关系

在早期的Windows版本中，所有代表非GUI活动的应用程序（即控制台应用程序）要在桌面上运行时，都通过系统进程Csrss.exe进行协调。当控制台应用程序需要接收字符时，会在Kernel32.dll中调用一个小型的“控制台APIs”以让Kernel32产生LPC来调用CSRSS。此时CSRSS会对控制台窗口的输入队列进行检查和校验，并将字符模式的结果通过Kernel32返回给控制台应用程序进行关联。

这样的处理机制就已经产生了一个问题：即使一个控制台应用程序在普通用户的上下文环境中执行，但Csrss.exe始终是运行在本地系统账户权限下的。因此，某些情况下“坏人”开发的[恶意软件](https://baike.baidu.com/item/%E6%81%B6%E6%84%8F%E8%BD%AF%E4%BB%B6)就有可能通过本地系统账户权限执行的Csrss.exe获取到更多特权。这种攻击模式被称为Shatter Attack。

而到了win7和Windows Server 2008 R2时代，所有控制台应用程序都被放到了一个新的上下文进程ConHost.exe中来执行，而ConHost（控制台[主机](https://baike.baidu.com/item/%E4%B8%BB%E6%9C%BA)）与控制台程序运行在相同安全级的上下文环境当中，取代了发出LPC消息请求到CSRSS中进行处理这种机制，而是去请求ConHost。因此，任何应用程序企图利用消息请求来导致特权的自动提升都不会成功。

conhost不是病毒···

conhost全称是console host process, 即命令行程序的[宿主进程](https://baike.baidu.com/item/%E5%AE%BF%E4%B8%BB%E8%BF%9B%E7%A8%8B). 大家都知道命令行程序是什么东西吧, 比如ipconfig.exe之类, 由于命令行程序自身没有代码来显示UI, 我们平时看到的命令行窗口内容都是由宿主进程来完成的,包括窗口的显示, window message的处理,等等.