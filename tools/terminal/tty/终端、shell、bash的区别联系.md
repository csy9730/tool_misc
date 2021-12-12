# 终端、shell、bash的区别联系

![img](https://csdnimg.cn/release/blogv2/dist/pc/img/reprint.png)

[Rain722](https://blog.csdn.net/Rain722) 2017-12-02 10:36:20 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes.png) 8042 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect.png) 收藏 15

分类专栏： [Linux-基本操作](https://blog.csdn.net/rain722/category_6802486.html)

[![img](https://img-blog.csdnimg.cn/20201014180756918.png?x-oss-process=image/resize,m_fixed,h_64,w_64)Linux-基本操作](https://blog.csdn.net/rain722/category_6802486.html)专栏收录该内容

3 篇文章0 订阅

订阅专栏

最佳答案

1. 终端，即所谓的[命令行界面](https://www.baidu.com/s?wd=命令行界面&tn=44039180_cpr&fenlei=mv6quAkxTZn0IZRqIHcvrjTdrH00T1YLuHRkmH64PH6zuAuhnWFh0ZwV5Hcvrjm3rH6sPfKWUMw85HfYnjn4nH6sgvPsT6KdThsqpZwYTjCEQLGCpyw9Uz4Bmy-bIi4WUvYETgN-TLwGUv3EPHmLnHTknH04)，又称命令终端，用户输入shell命令用的窗口，跟Windows里的DOS界面差不多。
2. shell，Shell就是用户和[操作系统](https://www.baidu.com/s?wd=操作系统&tn=44039180_cpr&fenlei=mv6quAkxTZn0IZRqIHcvrjTdrH00T1d9rHcsn1R1nv7-nHwBuHNb0ZwV5Hcvrjm3rH6sPfKWUMw85HfYnjn4nH6sgvPsT6KdThsqpZwYTjCEQLGCpyw9Uz4Bmy-bIi4WUvYETgN-TLwGUv3EPHDzrHbdnjDz)之间的壳，中介，GUI和CLI都算是Shell，登陆终端可以是登陆了Bash也可能是Csh或者Dash；是[操作系统](https://www.baidu.com/s?wd=操作系统&tn=44039180_cpr&fenlei=mv6quAkxTZn0IZRqIHcvrjTdrH00T1YLuHRkmH64PH6zuAuhnWFh0ZwV5Hcvrjm3rH6sPfKWUMw85HfYnjn4nH6sgvPsT6KdThsqpZwYTjCEQLGCpyw9Uz4Bmy-bIi4WUvYETgN-TLwGUv3EPHmLnHTknH04)与用户交互用的接口，在命令终端里可以使用shell。shell将用户输入翻译为[操作系统](https://www.baidu.com/s?wd=操作系统&tn=44039180_cpr&fenlei=mv6quAkxTZn0IZRqIHcvrjTdrH00T1YLuHRkmH64PH6zuAuhnWFh0ZwV5Hcvrjm3rH6sPfKWUMw85HfYnjn4nH6sgvPsT6KdThsqpZwYTjCEQLGCpyw9Uz4Bmy-bIi4WUvYETgN-TLwGUv3EPHmLnHTknH04)能处理的指令。shell提供了一些内置命令，也支持调用外面工具。
3. dash，是ubuntu里默认的shell。shell有好多种，除支持默认的POSIX标准外还支持不同的扩展语法，目前最常用的是bash，很多shell学习的教程都是针对bash的。dash除了不支持数组外，其实和bash差别也不大。ubuntu里可以将默认shell由dash改为bash。

第二篇：

终端(terminal，或者叫物理终端）： 
是一种设备，不是一个程序，一般说的就是能提供命令行用户界面的设备，典型的是屏幕和键盘，或其他的一些物理终端。
虚拟终端： 
屏幕和键盘只是一个终端，可能不够用，又不想增加设备投入，就产生了虚拟终端。
gnome-terminal,urxvt，mlterm，xterm等等：
是一个程序，职责是模拟终端设备，和虚拟终端的区别表面上在于它以 GUI 形式的窗口出现，内部则是程序结构和系统控制结构有所不同，但本质上差不多。
控制台（console): 
显示系统消息的终端就叫控制台，Linux 默认所有虚拟终端都是控制台，都能显示系统消息。
但有时专指CLI下的模拟终端设备的一个程序，和gnome-terminal,urxvt，mlterm，xterm等相同，只是CLI和GUI界面的区别。一般console有6个，tty1-6，CTRL+ALT+fn切换。还没听说过怎么换console

shell是一个抽象概念，shell的一切操作都在计算机内部，负责处理人机交互，执行脚本等，是操作系统能正常运行的重要组成部分
bash，ash，zsh，tcsh等是shell这个抽象概念的一种具体的实现，都是一个程序，都能生成一个进程对象。
如果想换shell的程序，可以修改/etc/passwd，把里面的/bin/bash换成你想要的shell，或者用chsh命令来切换

shell与终端的关系：shell把一些信息适当的输送到终端设备，同时还接收来自终端设备的输入。一般每个shell进程都会有一个终端关联，也可以没有。

 

当然，还有一些不同的见解，我认为这个总结不错，仅供参考！

另外在wikipedia上也讲到：

字符程序 <---> 虚拟终端 <---> 图像显示
shell <---> xterm <---> X11
可见xterm的确是所谓的“虚拟终端”！

 

  今天看到有人问终端和控制台的区别，而且这个问题比较有普遍性，因此想抽出一点时间来解释一下这两个术语的区别。　　终端，英文叫做terminal ,通常简称为term ，比如我们在X下的xterm. 　　控制台，英文叫做console。 　　要明白这两者的关系，还得从以前的多人使用的计算机开始。 　　大家都知道，最初的计算机由于价格昂贵，因此，一台计算机一般是由多个人同时使用的。在这种情况下一台计算机需要连接上许多套键盘和显示器来供多个人 使用。在以前专门有这种可以连上一台电脑的设备，只有显示器和键盘，还有简单的处理电路，本身不具有处理计算机信息的能力，他是负责连接到一台正常的计算 机上（通常是通过串口） ，然后登陆计算机，并对该计算机进行操作。当然，那时候的计算机操作系统都是多任务多用户的操作系统。这样一台只有显示器和键盘能够通过串口连接到计算机 的设备就叫做终端。 　　而控制台又是什么回事呢？ 学机电的人应该知道，一台机床，或者数控设备的控制箱，通常会被称为控制台，顾名思义，控制台就是一个直接控制设备的台面（一个面板，上面有很多控制按 钮）。 在计算机里，把那套直接连接在电脑上的键盘和显示器就叫做控制台。请注意它和终端的区别，终端是通过串口连接上的，不是计算机本身就有的设备，而控制台是 计算机本身就有的设备，一个计算机只有一个控制台。计算机启动的时候，所有的信息都会显示到控制台上，而不会显示到终端上。也就是说，控制台是计算机的基 本设备，而终端是附加设备。 当然，由于控制台也有终端一样的功能，控制台有时候也被模糊的统称为终端。 计算机操作系统中，与终端不相关的信息，比如内核消息，后台服务消息，都可以显示到控制台上，但不会显示到终端上。 　　以上是控制台和终端的历史遗留区别。现在由于计算机硬件越来越便宜，通常都是一个人独占一台计算机超做，不再连接以前那种真正意义上的“终端设备了”，因此，终端和控制台的概念也慢慢演化了。终端和控制台由硬件的概念，演化成了软件的概念。 　　现在说的终端，比如linux中的虚拟终端，都是软件的概念，他用计算机的软件来模拟以前硬件的方式。比如在linux中，你用 alt+f1 ~ f6 可以切换六个虚拟终端，就好比是以前多人公用的计算机中的六个终端设备，这就是为什么这个叫“虚拟终端”的原因。当然，现在的linux也可以通过串口 线，连接一个真正的终端，现在这种终端设备已经非常罕见了，但是还存在，只是一般人很难见到。也有人利用以前的老电脑（386，486）装上一个串口通信 软件，连上一台计算机，来模拟一个终端来用。这样可以达到一台电脑多人使用的目的。 　　简单的说，能直接显示系统消息的那个终端称为控制台，其他的则称为终端。但是在linux系统中，这个概念也已经模糊化了。 　　比如下面这条命令： 　　echo "hello,world" > /dev/console 　　这条命令的目的是将"hello,world"显示到控制台上/dev/console是控制台设备的设备名。在linux中，在字符模式下，你无论 在哪个虚拟终端下执行这条命令，字符hello,world都会显示在当前的虚拟终端下。也就是说，linux把当前的终端当作控制台来看待。可见， linux中已经完全淡化了控制台和终端的区别。但是在其他的UNIX类系统中，却很明显的有虚拟终端和控制台的区别。比如 freeBSD系统。 　　



在freebsd中，只有第一个“终端”才是真正的控制台。（就是说按alt+f1得到的那个虚拟终端） ，你无论在哪个虚拟终端上执行上面的那条命令（哪怕是通过网络连接的伪终端上执行这条命令）。hello,world字符总会显示到第一个“终端”也就是 真正的控制台上。另外，其他的一些系统内部信息，比如哪个用户在哪个终端登陆，系统有何严重错误警告等信息，全都显示在这个真正的控制台上。在这里，就明 显的区分了终端和控制台的概念。其他UNIX中也是这样的。比如Tru64 unix 在X下有一个控制台模拟软件，你无论在哪里输入echo "hello,world" > /dev/console命令，hello,world总会显示在这个控制台模拟器中。 我们在X界面下用的那些输入命令的软件，比如xterm ,rxvt, gnome-terminal等等，都应该被称为终端模拟软件。请注意它和控制台模拟软件的区别。 linux中好象没有控制台模拟软件。在X中的终端模拟 软件中输入的echo "hello,world">/dev/console 命令的输出信息，都会输出到启动该X服务器的虚拟终端上。比如，你用字符方式登陆系统。进入第一个虚拟终端，然后startx启动X服务器。再打开 xterm 来输入 echo "hello,world">/dev/console 命令，那么字符串hello,world就显示在第一个虚拟终端上。你按ctrl+alt+f1，回到那个启动X服务器的终端，就可以看到hello, world字符串。 　　现在该明白终端和控制台的区别了吧。再简单的说，控制台是直接和计算机相连接的原生设备，终端是通过电缆、网络等等和主机连接的设备。 　　在以前的硬件终端设备中，由于生产厂家不同，所遵循的标准不同，因此有不同的型号标准。比如vt100等。这里的vt100就是一个标准，那么现在我 们所说的终端，往往不是真正的硬件终端了，而是终端模拟软件了，因此不同的终端模拟软件可能符合不同的标准，还有一些终端模拟软件符合很多种不同终端的标 准。比如gnome的终端模拟软件gnome-terminal，他提供好几中标准可供用户选择。用户只要设置一下就可以了。

 　　

现在，由于原先的这些设备在我们的视线中渐渐淡出，控制台和终端的概念也慢慢谈化。普通用户可以简单的把终端和控制台理解为：可以输入命令行并显示程序运行过程中的信息以及程序运行结果的窗口。 不必要严格区分这两者的差别。