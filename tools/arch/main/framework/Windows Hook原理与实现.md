## **Windows Hook原理与实现**

------

教程参考自《逆向工程核心原理》
SSDT Hook参考：http://www.cnblogs.com/BoyXiao/archive/2011/09/03/2164574.html

------

## 1.概述

Hook技术被广泛应用于安全的多个领域，比如杀毒软件的主动防御功能，涉及到对一些敏感API的监控，就需要对这些API进行Hook；窃取密码的木马病毒，为了接收键盘的输入，需要Hook键盘消息；甚至是Windows系统及一些应用程序，在打补丁时也需要用到Hook技术。接下来，我们就来学习Hook技术的原理。

下图很简单易懂地诠释了Hook的机制，在notepad.exe和kernel32.dll之间挂上一个“钩子”，把它们要使用的CreateFile()函数替换掉，换成MyCreateFile()函数，实现我们想要的自定义功能。

![1](https://img-blog.csdn.net/20180806142834603?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

------

## 2.Hook分类

Hook分为应用层（Ring3）Hook和内核层（Ring0）Hook，应用层Hook适用于x86和x64，而内核层Hook一般仅在x86平台适用，因为从Windows Vista的64版本开始引入的Patch Guard技术极大地限制了Windows x64内核挂钩的使用。

![2](https://img-blog.csdn.net/20180806142903509?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

------

## 3.消息Hook

**3.1 技术原理**

首先先来了解下常规的Windows消息流：
[1]发生键盘输入事件时，WM_KEYDOWN消息被添加到[OS message queue]。
[2]OS判断哪个应用程序中发生了事件，然后从[OS message queue]取出消息，添加到相应应用程序的[application message queue]中。
[3]应用程序（如记事本）监视自身的[application message queue]，发现新添加的WM_KEYDOWN消息后，调用相应的事件处理程序处理。

所以，我们只需在[OS message queue]和[application message queue]之间安装钩子即可窃取键盘消息，并实现恶意操作。
![3](https://img-blog.csdn.net/20180806142959346?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
那么我们该如何安装这个消息钩子呢？很简单，Windows提供了一个官方函数SetWindowsHookEx()用于设置消息Hook，编程时只要调用该API就能简单地实现Hook。

消息Hook常被窃密木马用来监听用户的键盘输入，程序里只需写入如下代码就能对键盘消息进行Hook:
SetWindowsHookEx(
WH_KEYBOARD, //键盘消息
KeyboardProc, //钩子函数（处理键盘输入的函数）
hInstance, //钩子函数所在DLL的Handle
0 //该参数用于设定要Hook的线程ID，为0时表示监视所有线程
)

**3.2 代码实现**

过滤notepad输入例子–核心代码：
![4](https://img-blog.csdn.net/20180806143049836?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)
该API在简单高效的同时也有一个弊端，就是它只能监视较少的消息，如：击键消息、鼠标移动消息、窗口消息。想要对系统更全面的进行Hook就要使用以下介绍的两种Hook方法。

------

## 4.调试Hook

**4.1 技术原理**

该Hook方法的原理跟调试器的工作机制相似，核心思想都是让进程发生异常，然后自己捕获到该异常，对处于被调试状态下的级才能进行恶意操作。
下图是常规进程的异常事件处理，当进程未被其他进程调试时，其默认异常事件处理者是OS，一旦进程发生异常，OS将捕获到该异常，并进行相应的事件处理。
![5](https://img-blog.csdn.net/20180806143136384?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

若进程被另一个进程调试了（如OllyDbg），异常事件的处理工作将移交给调试者，比如进程发生了除0错误，OllyDbg将接收到这个异常事件并对进行相应处理。
PS：调试器无处理或不关心的调试事件最终由OS处理。
![6](https://img-blog.csdn.net/20180806143154881?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

所以，调试Hook的核心思路就是将API的第一个字节修改为0xCC（INT 3），当API被调用时，由于触发了异常，控制权就被转交给调试器。

**4.2 代码实现**

![7](https://img-blog.csdn.net/20180806143225953?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

------

## 5.注入Hook

Hook的核心思想就是修改API的代码，但是，比如我A进程要Hook一个B进程的CreateProcess函数，A是没有权限修改B内存中的代码的，怎么办？这时候使用DLL注入技术就可以解决这问题，我们将Hook的代码写入一个DLL（或直接一个shellcode），将此DLL注入到B进程中，此时因为DLL在B进程的内存中，所以就有权限直接修改B内存中的代码了。

**5.1 IAT Hook**

IAT Hook顾名思义就是通过修改IAT里的函数地址对API进行Hook。

**5.1.1 技术原理**

如下，左图红框内是IAT修改前的状态，指明SetWindowTextW()的地址为0x77D0960E，所以calc.exe执行call SetWindowTextW（dword ptr[01001110]）实质上就是执行call 0x77D0960E。
右图是被Hook后的状态，IAT中的SetWinowTextW()的地址已被修改为0x10001000，calc.exe执行call SetWindowTextW（dword ptr[01001110]）实质变成了执行call 0x10001000（也就是恶意代码的起始地址），这时候就可以做我们想做的操作了。

![7](https://img-blog.csdnimg.cn/20190104113915565.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy,size_16,color_FFFFFF,t_70)

![8](https://img-blog.csdnimg.cn/20190104113938349.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy,size_16,color_FFFFFF,t_70)

**5.1.2 代码实现**

下图是Hook IAT的代码实现，核心代码很少，大部分代码在计算IAT的位置。这里值得注意的是，我们把SetWindowTextW()替换为我们的恶意函数后，我们的恶意函数执行完后必须要调用回SetWindowTextW()（在Hook之前我们保存了SetWindowTextW()的地址），这样才能保证功能的完整性。

![9](https://img-blog.csdn.net/20180806143557858?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

**5.2 Inline Hook**

内联Hook相比于IAT Hook，显得更简单粗暴，它直接修改内存中任意函数的代码，将其劫持至Hook API。同时，它比IAT Hook的适用范围更广，因为只要是内存中有的函数它都能Hook，而后者只能Hook IAT表里存在的函数（有些程序会动态加载函数）。

**5.2.1 技术原理**

Inline Hook的目标是系统函数，如下，左图是Hook之前的状态，procexp.exe进程调用ZwQuerySystemInformation()函数时，ZwQuerySystemInformation()的代码是正常的代码。右图是Hook后的状态，注意红框中的代码，ZwQuerySystemInformation()函数开头5个字节已被修改，变成了jmp 0x10001120，也就是我们恶意代码的地址，之后便可以开始我们的自定义操作。0x1000116A我们先进行unhook操作（脱钩），目的是将ZwQuerySystemInformation()的代码恢复。大家可能有疑惑，为什么刚修改完又要恢复回来，原因很简单，Hook的目的是当调用某个函数时，我们能劫持进程的执行流。现在我们已经劫持了进程的执行流，便可以恢复ZwQuerySystemInformation()的代码，以便我们的恶意代码可以正常调用ZwQuerySystemInformation()。执行完恶意代码后，再次挂钩，监控该函数。

![10](https://img-blog.csdnimg.cn/20190104114034642.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy,size_16,color_FFFFFF,t_70)

![11](https://img-blog.csdnimg.cn/20190104114147532.png?x-oss-process=image/watermark,type_ZmFuZ3poZW5naGVpdGk,shadow_10,text_aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy,size_16,color_FFFFFF,t_70)

**5.2.2 代码实现**

首先获取原API的地址，并保存在pfnOrg中，然后修改内存段属性为RWX，备份原有代码（以便后续代码恢复），实时计算JMP的相对偏移，最后修改API前5字节的代码，恢复内存属性。

![12](https://img-blog.csdn.net/20180806143330162?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

**5.3 HotFix Hook**

从上节对Code Hook方法的讲解中，我们会发现Code Hook存在一个效率的问题，因为每次Code Hook都要进行“挂钩+脱钩”的操作，也就是要对API的前5字节修改两次，这样，当我们要进行全局Hook的时候，系统运行效率会受影响。而且，当一个线程尝试运行某段代码时，若另一个线程正在对该段代码进行“写”操作，这时就会程序冲突，最终引发一些错误。
有没有办法避免这种隐患呢？答案是有的，可以使用HotFix Hook（“热补丁”）方法。

**5.3.1 技术原理**

以上累出的API起始代码有如下两个明显的相似点：
[1]API代码以“MOV EDI,EDI”指令开始。
[2]API代码上方有5个NOP指令。

MOV EDI,EDI用于将EDI的值再次复制给EDI，这没有什么实际意义。也就是说，API起始代码的MOV指令（2个字节）与其上方的5个NOP指令（5个字节）合起来共7个字节的指令没有任何意义。所以我们就可以通过修改这7个字节来实现Hook操作。这种方法因为可以在进程处于运行状态时临时更改进程内存中的库文件，所以微软也常用这种方法来打“热补丁”。

![13](https://img-blog.csdn.net/20180806143356339?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

如下，将前7个字节改成：
JMP 10001000（恶意代码地址）
JMP SHORT 0x7C802366

这样，当API被调用时，首先执行了JMP SHORT 0x7C802366，便跳到了JMP 10001000处执行，最后跳到了恶意代码的起始处0x10001000。

![14](https://img-blog.csdn.net/20180806143414254?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

在5字节代码修改技术中“脱钩”是为了“调用原函数”，而使用“热补丁”技术钩取API时，在API代码遭到修改的状态下也能正常调用原API（从[API起始地址+2]地址开始，仍然能正常调用原API，且执行的动作也完全一样）。

**5.3.2 代码实现**

该技术难的地方在于计算偏移地址。

![15](https://img-blog.csdn.net/20180806143439868?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

由于HotFix Hook需要修改7个字节的代码，所以并不是所有API都适用这种方法，若不适用，请使用5字节代码修改技术。

------

## 6.SSDT Hook

SSDT Hook属于内核层Hook，也是最底层的Hook。由于用户层的API最后实质也是调用内核API（Kernel32->Ntdll->Ntoskrnl），所以该Hook方法最为强大。不过值得注意的是

**6.1SSDT原理**

内核通过SSDT（System Service Descriptor Table）调用各种内核函数，SSDT就是一个函数表，只要得到一个索引值，就能根据这个索引值在该表中得到想要的函数地址。

![16](https://img-blog.csdn.net/20180806143623495?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

下图0x80563520处就是ntoskrnl对应的服务描述符表结构SSDT。那么第一个32位的0x804e58a0则是SSDT Base，即SSDT的首地址。

![17](https://img-blog.csdn.net/2018080614363758?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

通过对这些地址反汇编，就能得到相应的函数，下图中0x80591bfb是SSDT表中的第一个函数NtAcceptConnectPort的地址。

![18](https://img-blog.csdn.net/20180806143657439?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

我们接下来试着寻找NtQuerySystemInformation的地址，首先反汇编ZwQuerySystemInformation，得知它要寻找SSDT中索引号为0xAD的地址。

![19](https://img-blog.csdn.net/2018080614371141?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

从上面我们可以知道，NtQuerySystemInformation的索引号为0xAD，那么我们就可以算出NtQuerySystemInformation的地址：
0x80591bfb + 0xAD = 0x8056ff1

![20](https://img-blog.csdn.net/20180806143724339?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)

**6.2SSDT Hook**

其实内核层Hook并没想象中的那么高大上，Hook的原理相同，只不过Hook的对象不一样罢了。Hook步骤还是那5步：
1.修改内存属性为RWX。
2.拼接汇编码jmp [HookFunc]。
3.保存原代码头5个字节。
4.将头5个字节替换为2的汇编码。
5.恢复前5个字节。
6.恢复内存属性。

![21](https://img-blog.csdn.net/20180806143805906?watermark/2/text/aHR0cHM6Ly9ibG9nLmNzZG4ubmV0L20wXzM3NTUyMDUy/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70)