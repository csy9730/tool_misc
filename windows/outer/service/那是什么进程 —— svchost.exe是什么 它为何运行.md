# [那是什么进程 —— svchost.exe是什么? 它为何运行?](https://www.cnblogs.com/technology/archive/2011/07/20/svchost_exe.html)



![img](https://pic002.cnblogs.com/images/2011/70278/2011072015532842.jpg)

​        你几乎毫不犹豫的来阅读这篇文章是因为你也觉得奇怪, 究竟为什么那里有一打正在运行的进程都叫做 svchost.exe. 你不能终止它们运行, 你也不记得什么时候开始运行它们的...那么它们究竟是什么呢?
​        我们写了一系列的文章用来解释在任务管理器里发现的各种进程, 这篇文章是其中的一个部分, 这个系列包括: [jusched.exe](http://www.cnblogs.com/technology/archive/2011/07/20/jusched_exe.html), [dwm.exe](http://www.cnblogs.com/technology/archive/2011/07/21/dwm_exe.html), ctfmon.exe, [wmpnetwk.exe](http://www.cnblogs.com/technology/archive/2011/07/22/wmpnscfg_exe.html), [wmpnscfg.exe](http://www.cnblogs.com/technology/archive/2011/07/22/wmpnscfg_exe.html), mDNSResponder.exe, conhost.exe, rundll32.exe, Dpupdchk.exe, and Adobe_Updater.exe.
​        你知道这些服务是什么吗? 最好开始阅读吧!

# 那么它是什么?

​        引用微软的解释: "**svchost.exe 是一个共有的宿主进程的名字, 为了运行那些来自动态链接库的服务**". 请问可以讲得通俗一点吗?
​        不久前, 微软开始将所有Windows系统内部的功能移到 .dll 文件中, 从而取代以前的 .exe 文件. 从编程角度来看这这样做有利于复用...但问题是你不能直接从Windows系统中运行一个 .dll 文件, 必须由一个可执行文件加载它, 所以 svchost.exe 就这样产生的.

# 为什么有很多个 svchost.exe 在运行呢?

​        如果你留意过控制面板里的服务这一块, 你也许就会注意到有很多服务是系统所需要的, 但如果所有服务都在一个 svchost.exe 实例下运行, 如果其中一个运行出错也许会导致系统的崩溃...所以将它们分隔开了. 
​        这些服务被按照一定的逻辑进行分组, 每个组产生一个的 svchost.exe 实例. 举个例子: 有个 svchost.exe 运行了三个和防火墙有关的服务, 另外有个 svchost.exe 可能运行了有关用户界面的所有服务, 等等.

# 它有什么用呢?

​        你可以停止一些不是绝对需要运行的服务, 另外如果你注意到某个 svchost.exe 很占 CPU, 你可以重启当前运行的这个服务. 最大的问题是怎么识别哪个服务是在哪个特定的 svchost.exe 下运行的...下面的内容将会谈到这个.
​        如果你很好奇我们究竟在谈论什么, 就打开你的任务管理器并点击 "查看所有用户进程" 的框框:

![img](https://pic002.cnblogs.com/images/2011/70278/2011072017091337.png)

## 用命令行查找

​        如果你想看见某个服务宿主在哪个特定的 svchost.exe 中, 你可以 tasklist 命令来查看服务的一个列表.

> tasklist /SVC

![img](https://pic002.cnblogs.com/images/2011/70278/2011072017123963.png)

​        用命令行这种方法的的问题是你不必知道这些隐晦的名字指的是什么.

## 在任务管理器中查看

​        你可以右击一个 svchost.exe 进程, 然后选择"查看服务"的选项.

![img](https://pic002.cnblogs.com/images/2011/70278/2011072017163218.png)

​        然后会跳转到服务选项卡, 运行在那个 svchost.exe 进程下的服务会被选中:

![img](https://pic002.cnblogs.com/images/2011/70278/2011072017174491.png)

​        这样做最棒的是你可以在描述一列中看到真实的名字, 所以你可以选择那些不需要运行的服务并禁用它们.

## 使用 Process Explorer

​        你还可以使用非常棒的  [Process Explorer](http://technet.microsoft.com/en-us/sysinternals/bb896653.aspx) 工具来查看哪些服务是作为一个部分用一个 svchost.exe 来运行的. 把你的鼠标移到一个进程上, 将弹出一个列表来展示它负责的所有服务.

![img](https://pic002.cnblogs.com/images/2011/70278/2011072017194466.png)

​        你还可以在某个 svchost.exe 上双击并选择服务这个选项卡, 你可以在那儿选择关闭一些你不想运行的服务.

![img](https://pic002.cnblogs.com/images/2011/70278/2011072017204624.png)

# 禁用服务

​        打开控制面板->管理工具->服务, 或者在开始菜单或者运行框中直接输入 services.msc 并回车. 找到列表中你想停止的服务, 你可以双击或者右击并选择属性.

![img](https://pic002.cnblogs.com/images/2011/70278/2011072017222580.png)

​        更改启动类型为禁用, 然后单击停止按钮, 立刻停止它运行.

![img](https://pic002.cnblogs.com/images/2011/70278/2011072017231287.png)

​        你还可以使用命令行来禁用某个服务, 下面这个命令行中的 "trkwks" 是上面对话框中的一个服务的名字, 回到文章上面介绍 tasklist 命令的那个地方你就能找到了.

> sc config trkwks start= disabled



​        希望这篇文章能帮助到一些人!

原文地址: <http://www.howtogeek.com/howto/windows-vista/what-is-svchostexe-and-why-is-it-running/>

本文地址: <http://www.cnblogs.com/technology/archive/2011/07/20/svchost_exe.html>

作者：[Create Chen](http://technology.cnblogs.com/)
出处：[http://technology.cnblogs.com](http://technology.cnblogs.com/)
说明：文章为作者平时里的思考和练习，可能有不当之处，请博客园的园友们多提宝贵意见。
[![知识共享许可协议](http://i.creativecommons.org/l/by-nc-sa/2.5/cn/88x31.png)](http://creativecommons.org/licenses/by-nc-sa/2.5/cn/)本作品采用[知识共享署名-非商业性使用-相同方式共享 2.5 中国大陆许可协议](http://creativecommons.org/licenses/by-nc-sa/2.5/cn/)进行许可。



分类: [Windows 7](https://www.cnblogs.com/technology/category/293385.html)

标签: [进程](https://www.cnblogs.com/technology/tag/进程/), [svchost.exe](https://www.cnblogs.com/technology/tag/svchost.exe/)