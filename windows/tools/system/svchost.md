# svchost.exe







一分钟了解svchost.exe

00:40







svchost.exe占cpu过高怎么办

00:22





收藏

3171

84



svchost.exe是微软Windows操作系统中的系统文件，微软官方对它的解释是：svchost.exe 是从[动态链接库](https://baike.baidu.com/item/%E5%8A%A8%E6%80%81%E9%93%BE%E6%8E%A5%E5%BA%93/100352) (DLL) 中运行的服务的通用主机进程名称。这个程序对系统的正常运行是非常重要，而且是不能被结束的。许多服务通过注入到该程序中启动，所以会有多个该文件的进程。





- 中文名

  Windows 服务主进程

- 外文名

  Host Process for Windows Services

- 公    司

  [微软](https://baike.baidu.com/item/%E5%BE%AE%E8%BD%AF)

- 操作系统

  Windows

- 进程类别

  [系统进程](https://baike.baidu.com/item/%E7%B3%BB%E7%BB%9F%E8%BF%9B%E7%A8%8B)

- 文件名

  svchost.exe

## 目录

1. 1 [软件特性](https://baike.baidu.com/item/svchost.exe/552746#1)
2. ▪ [进程信息](https://baike.baidu.com/item/svchost.exe/552746#1_1)
3. ▪ [用途说明](https://baike.baidu.com/item/svchost.exe/552746#1_2)
4. ▪ [文件信息](https://baike.baidu.com/item/svchost.exe/552746#1_3)
5. 2 [启动服务](https://baike.baidu.com/item/svchost.exe/552746#2)
6. 3 [相关特征](https://baike.baidu.com/item/svchost.exe/552746#3)

1. ▪ [基础特征](https://baike.baidu.com/item/svchost.exe/552746#3_1)
2. ▪ [深入介绍](https://baike.baidu.com/item/svchost.exe/552746#3_2)
3. ▪ [实例](https://baike.baidu.com/item/svchost.exe/552746#3_3)
4. 4 [病毒解惑](https://baike.baidu.com/item/svchost.exe/552746#4)
5. 5 [虚假进程](https://baike.baidu.com/item/svchost.exe/552746#5)
6. ▪ [清除办法](https://baike.baidu.com/item/svchost.exe/552746#5_1)

1. 6 [操作指南](https://baike.baidu.com/item/svchost.exe/552746#6)
2. 7 [调用程序](https://baike.baidu.com/item/svchost.exe/552746#7)
3. 8 [修复方法](https://baike.baidu.com/item/svchost.exe/552746#8)
4. ▪ [一般修复](https://baike.baidu.com/item/svchost.exe/552746#8_1)
5. ▪ [下载修复](https://baike.baidu.com/item/svchost.exe/552746#8_2)

1. ▪ [中毒处理](https://baike.baidu.com/item/svchost.exe/552746#8_3)
2. ▪ [解决方法](https://baike.baidu.com/item/svchost.exe/552746#8_4)
3. ▪ [检查方法](https://baike.baidu.com/item/svchost.exe/552746#8_5)
4. ▪ [解决方法](https://baike.baidu.com/item/svchost.exe/552746#8_6)



## 软件特性

编辑

 播报



### 进程信息

进程文件：svchost.exe

进程名称：Host Process for Windows Services

进程类别：系统进程

位置：C:\Windows\System32\svchost.exe和C:\Windows\SysWow64\svchost.exe（仅64位）

英文描述：svchost.exe (Service Host, or SvcHost) is a system process that can host from one to many Windows services in the Windows NT family of operating systems. Svchost is essential in the implementation of so-called shared service processes, where a number of services can share a process in order to reduce resource consumption. This program is important for the stable and secure running of your computer and should not be terminated.

出品者：Microsoft Corp.

属于：Microsoft Windows Operating System

系统进程：是

后台程序：是

网络相关：是

常见错误：没有

内存使用：没有

安全等级 (0-5): 0

间谍软件：不是

广告软件：不是

病毒：不是

木马：不是



### 用途说明

多个svchost.exe进程可以同时存在，在Windows 2000一般有2个svchost进程，一个是RPCSS（Remote Procedure Call）服务进程，另外一个则是由很多服务共享的一个svchost.exe。而在Windows XP中，则一般有4个以上的svchost.exe服务进程，之后的系统中则更多（Windows 7中一般是6个，但所有系统中数目都不是绝对的，有时候多一点少一点也是正常现象，是不是病毒也不能杞人忧天，需要用合理的方法来判断）。这样做在一定程度上减少了系统资源的消耗，不过也带来一定的不稳定因素，因为任何一个共享进程的服务因为错误退出进程就会导致整个进程中的所有服务都退出。

近年来，由于计算机性能普遍提高，为了提高系统安全性和稳定性，在最新版本的Windows 10操作系统中，系统不再使多个服务共享1个svchost.exe进程，而会为每个服务都分配一个独立的svchost.exe进程。因此在更新到最新版Windows 10后，在任务管理器中可以看到80至90个svchost.exe进程，这是正常现象。

另外，在64位Windows系统中，系统盘下的SysWOW64文件夹（位于Windows文件夹内）内也存在一个svchost.exe文件，它是svchost.exe的32位版本，用于在64位Windows系统中运行32位服务。在64位Windows操作系统中，大多数位于System32文件夹中的系统文件在SysWOW64文件夹中都拥有1个对应的32位版本，因此无需担心。



### 文件信息

注释: svchost.exe是一类通用的进程名称。它是和运行动态链接库（DLLs）的Windows系统服务相关的。在Windows启动时，svchost.exe检查注册表中的服务，运行并载入它们。经常会有多个svchost.exe同时运行的情况，每一个都表示该计算机上运行的一类基本服务。请不要把它和scvhost.exe混淆。

详细分析: svchost.exe 存放在C:\Windows\System32和C:\Windows\SysWOW64（仅64位）目录中。已知的Windows XP 文件大小为14336 字节 （占总出现比率85% ），21504 字节 及22 种其它情况。

进程没有可视窗口。 这个文件是由Microsoft 所签发。 这个进程打开接口连到局域网或互联网。 总结在技术上威胁的危险度是*9%*。

如果svchost.exe 位于在C:\Windows 下的子目录下，那么威胁的危险度是*74%*。文件大小是106496 字节 （占总出现比率5% ），16896 字节 及121 种其它情况。这个不是Windows 核心文件。 应用程序没有可视窗口。 这个程序没有备注。 这是个不知名的文件存放于Windows 目录。svchost.exe 是有能力可以 监控应用程序，记录输入，隐藏自身，接到互联网，操纵其他程序。

如果svchost.exe 位于在目录C:Windows下，那么威胁的危险度是*67%*。文件大小是36352 字节 （占总出现比率10% ），49242 字节 及74 种其它情况。这个不是Windows 系统文件。 进程是不可见的。 文件存放于Windows 目录但并非系统核心文件。 没有进程的相关资料。

如果svchost.exe 位于在目录C:\Windows\System32\drivers下，那么威胁的危险度是*87%*。文件大小是30720 字节 （占总出现比率10% ），49152 字节 及48 种其它情况。

如果svchost.exe 位于在"C:\Documents and Settings" 下的子目录下，那么威胁的危险度是*66%*。文件大小是233472 字节 （占总出现比率12% ），106496 字节 及87 种其它情况。

如果svchost.exe 位于在"C:\Program Files" 下的子目录下，那么威胁的危险度是*63%*。文件大小是497664 字节 （占总出现比率19% ），493568 字节 及66 种其它情况。

如果svchost.exe 位于在of C:\ 下的子目录下，那么威胁的危险度是*66%*。文件大小是239104 字节 （占总出现比率23% ），183808 字节 及25 种其它情况。

如果svchost.exe 位于在C:Windows\System32 下的子目录下，那么威胁的危险度是*75%*。文件大小是525312 字节 （占总出现比率12% ），86016 字节 及53 种其它情况。

如果svchost.exe 位于在目录"C:\Program Files\Common Files" 下的子目录下，那么威胁的危险度是*65%*。文件大小是1429504 字节 （占总出现比率22% ），289280 字节 及13 种其它情况。

如果svchost.exe 位于在目录"C:\Program Files\Common Files"下，那么威胁的危险度是*61%*。文件大小是17920 字节 （占总出现比率56% ），20480 字节 及4 种其它情况。

如果svchost.exe 位于在C:\Windows\System32\drivers 下的子目录下，那么威胁的危险度是*72%*。文件大小是244484 字节 （占总出现比率22% ），167936 字节 及5 种其它情况。

如果svchost.exe 位于在Windows 的临时目录下，那么威胁的危险度是*52%*。文件大小是109222 字节 （占总出现比率20% ），241664 字节，27652 字节，46154 字节，655360 字节。

如果svchost.exe 位于在目录C:\下，那么威胁的危险度是*64%*。文件大小是415232 字节 （占总出现比率60% ），115712 字节，15536 字节。

如果svchost.exe 位于在目录"C:\Program Files"下，那么威胁的危险度是*56%*。文件大小是28672 字节 （占总出现比率33% ），37376 字节，25600 字节。

如果svchost.exe 位于在"My Files" 下的子目录下，那么威胁的危险度是*56%*。文件大小是7168 字节。

**svchost.exe 也可能是恶意软件所伪装**，尤其是当它们存在于除C:\Windows\System32和C:\Windows\SysWOW64（仅64位）以外目录。



## 启动服务

编辑

 播报

以windowsxp为例，点击“开始”/“运行”，输入“[services.msc](https://baike.baidu.com/item/services.msc)”命令，弹出服务对话框，然后打开“remote procedure call”属性对话框，可以看到rpcss服务的[可执行文件](https://baike.baidu.com/item/%E5%8F%AF%E6%89%A7%E8%A1%8C%E6%96%87%E4%BB%B6)的路径为“c:\windows\system32\svchost.exe -k rpcss”，这说明rpcss服务是依靠svchost调用“rpcss”参数来实现的，而参数的内容则是存放在[系统注册表](https://baike.baidu.com/item/%E7%B3%BB%E7%BB%9F%E6%B3%A8%E5%86%8C%E8%A1%A8)中的。

在运行对话框中输入“[regedit.exe](https://baike.baidu.com/item/regedit.exe)”后回车，打开[注册表编辑器](https://baike.baidu.com/item/%E6%B3%A8%E5%86%8C%E8%A1%A8%E7%BC%96%E8%BE%91%E5%99%A8)，找到[HKEY_Local_Machine\System CurrentControlSet\Services\rpcss]项，找到类型为“reg_expand_sz”的键“imagepath”，其键值为“%systemroot%\system32\svchost-k rpcss”（这就是在服务窗口中看到的服务启动命令），另外在“parameters”子项中有个名为“servicedll”的键，其值为“%systemroot%\system32\rpcss.[dll](https://baike.baidu.com/item/dll)”，其中“rpcss.dll”就是rpcss服务要使用的[动态链接库文件](https://baike.baidu.com/item/%E5%8A%A8%E6%80%81%E9%93%BE%E6%8E%A5%E5%BA%93%E6%96%87%E4%BB%B6)。这样 svchost进程通过读取“rpcss”服务注册表信息，就能启动该服务了。



## 相关特征

编辑

 播报



### 基础特征

在基于NT内核的windows操作系统家族中，不同版本的windows系统，存在不同数量的“svchost”进程，用户使用“[任务管理器](https://baike.baidu.com/item/%E4%BB%BB%E5%8A%A1%E7%AE%A1%E7%90%86%E5%99%A8)”可查看其进程数目。一般来说，win2000有两个svchost进程，winxp中则有四个或四个以上的svchost进程（以后看到系统中有多个这种进程，千万别立即判定系统有病毒了哟），而win2003server中则更多。这些svchost进程提供很多[系统服务](https://baike.baidu.com/item/%E7%B3%BB%E7%BB%9F%E6%9C%8D%E5%8A%A1)，如：rpcss服务（remoteprocedurecall）、dmserver服务（logicaldiskmanager）、dhcp服务（dhcpclient）等。到了Windows Vista 系统时svchost 进程多达12个，这些svchost.exe都是同一个文件路径下C ：\Windows\System32\svchost.exe ， 它们分别是imgsvc、 NetworkServiceNetworkRestricted、 LocalServiceNoNetwork 、NetworkService 、LocalService 、netsvcs 、LocalSystemNetworkRestricted、 LocalServiceNetworkRestricted 、services 、rpcss、 WerSvcGroup 、DcomLaunch服务组。如果要了解每个svchost进程到底提供了多少[系统服务](https://baike.baidu.com/item/%E7%B3%BB%E7%BB%9F%E6%9C%8D%E5%8A%A1)，可以在win2000的[命令提示符](https://baike.baidu.com/item/%E5%91%BD%E4%BB%A4%E6%8F%90%E7%A4%BA%E7%AC%A6)窗口中输入“tlist-s”命令来查看，该命令是win2000supporttools提供的。在winxp则使用“tasklist/svc”命令。

svchost中可以包含多个服务。



### 深入介绍

windows系统进程分为独立进程和共享进程两种，“svchost.exe”文件存在于“%systemroot%system32”目录下，它属于共享进程。随着windows[系统服务](https://baike.baidu.com/item/%E7%B3%BB%E7%BB%9F%E6%9C%8D%E5%8A%A1)不断增多，为了节省系统资源，微软把很多服务做成共享方式，交由svchost.exe进程来启动。但svchost进程只作为服务宿主，并不能实现任何服务功能，即它只能提供条件让其他服务在这里被启动，而它自己却不能给用户提供任何服务。这些系统服务是以动态链接库（dll）形式实现的，它们把可执行程序指向svchost，由svchost调用相应服务的动态链接库来启动服务。svchost通过系统服务在注册表中设置的参数知道[系统服务](https://baike.baidu.com/item/%E7%B3%BB%E7%BB%9F%E6%9C%8D%E5%8A%A1)该调用哪个动态链接库。下面就以rpcss（remoteprocedurecall）服务为例，进行讲解。

从启动参数中可见服务是靠svchost来启动的。



### 实例

以windowsxp为例，点击“开始”/“运行”，输入“[services.msc](https://baike.baidu.com/item/services.msc)”命令，弹出服务对话框，然后打开“remoteprocedurecall”属性对话框，可以看到rpcss服务的[可执行文件](https://baike.baidu.com/item/%E5%8F%AF%E6%89%A7%E8%A1%8C%E6%96%87%E4%BB%B6)的路径为“c:\windows\system32\svchost-krpcss”这说明rpcss服务是依靠svchost调用“rpcss”参数来实现的，而参数的内容则是存放在[系统注册表](https://baike.baidu.com/item/%E7%B3%BB%E7%BB%9F%E6%B3%A8%E5%86%8C%E8%A1%A8)中的。

在运行对话框中输入“[regedit.exe](https://baike.baidu.com/item/regedit.exe)”后回车，打开注册表编辑器，找到[[hkey_local_machine](https://baike.baidu.com/item/hkey_local_machine)\system\currentcontrolset\services\rpcss]项，找到类型为“reg_expand_sz”的键“Imagepath”，其键值为“%systemroot%system32svchost-krpcss”（这就是在服务窗口中看到的服务启动命令），另外在“parameters”子项中有个名为“servicedll”的键，其值为“%systemroot%system32rpcss.[dll](https://baike.baidu.com/item/dll)”，其中“rpcss.dll”就是rpcss服务要使用的[动态链接库文件](https://baike.baidu.com/item/%E5%8A%A8%E6%80%81%E9%93%BE%E6%8E%A5%E5%BA%93%E6%96%87%E4%BB%B6)。这样svchost进程通过读取“rpcss”服务注册表信息，就能启动该服务了。



## 病毒解惑

编辑

 播报

因为svchost进程启动各种服务，所以病毒、木马也想尽办法来利用它，企图利用它的特性来迷惑用户，达到感染、入侵、破坏的目的（如冲击波变种病毒“w32.welchia.worm”）。但windows系统存在多个svchost进程是很正常的，在受感染的机器中到底哪个是病毒进程，这里仅举一例来说明。

假设windowsXP系统被“w32.welchia.worm”感染了。正常的svchost文件存在于“c:\windows\system32”目录下，如果发现该文件出现在其他目录下就要小心了。“w32.welchia.worm”病毒存在于“c:\windows\system32\wins”目录中，因此可以使用[进程管理器](https://baike.baidu.com/item/%E8%BF%9B%E7%A8%8B%E7%AE%A1%E7%90%86%E5%99%A8)->详细信息->路径名称查看svchost进程的执行文件路径就很容易发现系统是否感染了病毒。一旦发现其执行路径为不平常的位置就应该马上进行检测和处理。

Svchost.exe说明解疑对Svchost的困惑

\---------------

Svchost.exe文件对那些从[动态连接库](https://baike.baidu.com/item/%E5%8A%A8%E6%80%81%E8%BF%9E%E6%8E%A5%E5%BA%93)中运行的服务来说是一个普通的主机进程名。Svchost.exe文件定位在系统的%systemroot%\system32文件夹下。在启动的时候，Svchost.exe检查注册表中的位置([HKEY_LOCAL_MACHINE](https://baike.baidu.com/item/HKEY_LOCAL_MACHINE)\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SvcHost)来构建需要加载的服务列表。这就会使多个Svchost.exe在同一时间运行。每个Svchost.exe的回话期间都包含一组服务，以至于单独的服务必须依靠Svchost.exe怎样和在那里启动。这样就更加容易控制和查找错误。

Svchost.exe 组是用下面的注册表值来识别。

HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Svchost

每个在这个键下的值代表一个独立的Svchost组，并且当你正在看活动的进程时，它显示作为一个单独的例子。每个键值都是REG_MULTI_SZ类型的值而且包括运行在Svchost组内的服务。每个Svchost组都包含一个或多个从注册表值中选取的服务名，这个服务的参数值包含了一个ServiceDLL值。

HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services

简单的说没有这个RPC服务，机器几乎就上不了网了。很多应用服务都是依赖于这个RPC接口的，如果发现这个进程占了太多的CPU资源，直接把系统的RPC服务禁用了会是一场灾难：因为连恢复这个界面的[系统服务](https://baike.baidu.com/item/%E7%B3%BB%E7%BB%9F%E6%9C%8D%E5%8A%A1)设置界面都无法使用了。恢复的方法需要使用[注册表编辑器](https://baike.baidu.com/item/%E6%B3%A8%E5%86%8C%E8%A1%A8%E7%BC%96%E8%BE%91%E5%99%A8)，找到 HKEY_LOCAL_MACHINE >> SYSTEM >> CurrentControlSet >> Services >> RpcSs,右侧找到Start属性，把它的值改为2再重启即可

造成svchost占系统CPU 100%的原因并非svchost服务本身：以上的情况是由于Windows Update服务下载/安装失败而导致更新服务反复重试造成的。而Windows的自动更新也是依赖于svchost服务的一个后台应用，从而表现为svchost.exe负载极高。常发生这类问题的机器一般是上网条件（尤其是去国外网站）不稳定的机器，比如家里的父母的机器，往往在安装机器几个月以后不定期发生，每个月的第二个星期是高发期。（因为最近几年MS很有规律的在每个月的第二个星期发布补丁程序）上面的解决方法并不能保证不重发作，但是为了svchost文件而每隔几个月重装一次操作系统还是太浪费时间了。



## 虚假进程

编辑

 播报

常被病毒冒充的进程名有：[svch0st.exe](https://baike.baidu.com/item/svch0st.exe)、schvost.exe、[scvhost.exe](https://baike.baidu.com/item/scvhost.exe)。随着Windows系统服务不断增多，为了节省系统资源，微软把很多服务做成共享方式，交由svchost.exe进程来启动。而系统服务是以动态链接库(DLL)形式实现的，它们把可执行程序指向svchost，由svchost调用相应服务的动态链接库来启动服务。我们可以打开“控制面板”→“[管理工具](https://baike.baidu.com/item/%E7%AE%A1%E7%90%86%E5%B7%A5%E5%85%B7)”→服务，双击其中“ClipBook”服务，在其属性面板中可以发现对应的[可执行文件](https://baike.baidu.com/item/%E5%8F%AF%E6%89%A7%E8%A1%8C%E6%96%87%E4%BB%B6)路径为“C:\WINDOWS\system32\clipsrv.exe”。再双击“Alerter”服务，可以发现其可执行文件路径为“C:\WINDOWS\system32\svchost.exe -kLocalService”，而“Server”服务的可执行文件路径为“C:\WINDOWS\system32\svchost.exe -knetsvcs”。正是通过这种调用，可以省下不少系统资源，因此系统中出现多个svchost.exe，其实只是系统的服务而已。　在Windows2000系统中一般存在2个svchost.exe进程，一个是RPCSS([RemoteProcedureCall](https://baike.baidu.com/item/RemoteProcedureCall))服务进程，另外一个则是由很多服务共享的一个svchost.exe；而在WindowsXP中，则一般有4个以上的svchost.exe服务进程。如果svchost.exe进程的数量多于6个，如果不是使用Vista或以上系统，就要小心了，很可能是病毒假冒的，检测方法也很简单，使用一些[进程管理](https://baike.baidu.com/item/%E8%BF%9B%E7%A8%8B%E7%AE%A1%E7%90%86)工具，例如Windows[优化大师](https://baike.baidu.com/item/%E4%BC%98%E5%8C%96%E5%A4%A7%E5%B8%88)的进程管理功能，查看svchost.exe的[可执行文件](https://baike.baidu.com/item/%E5%8F%AF%E6%89%A7%E8%A1%8C%E6%96%87%E4%BB%B6)路径，如果在“C:\WINDOWS\system32”目录外，那么就可以判定是病毒了。



### 清除办法

1．用unlocker删除类似于C:SysDayN6这样的文件夹：例如C:Syswm1i、C:SysAd5D等等，这些文件夹有个共同特点，就是名称为 Sys*** （***是三到五位的随机字母），这样的文件夹有几个就删几个。

2．开始——运行——输入“regedit”——打开注册表，展开注册表到以下位置：

[HKEY_CURRENT_USER](https://baike.baidu.com/item/HKEY_CURRENT_USER)\Software\Microsoft\Windows\CurrentVersion\Run

删除右边所有用纯数字为名的键，如

<66><C:SysDayN6svchost.exe>

<333><C:Syswm1isvchost.exe>

<50><C:SysAd5Dsvchost.exe>

<4><C:SysWsj7svchost.exe>

3．重新启动计算机，病毒清除完毕。



## 操作指南

编辑

 播报

为了能看到正在运行在Svchost列表中的服务。

开始－运行－敲入cmd

然后再敲入 tlist -s （tlist 应该是win2k[工具箱](https://baike.baidu.com/item/%E5%B7%A5%E5%85%B7%E7%AE%B1)里的东东）

Tlist 显示一个活动进程的列表。开关 -s 显示在每个进程中的活动服务列表。如果想知道更多的关于进程的信息，可以敲 tlist pid。

Tlist 显示Svchost.exe运行的两个例子。

0 System Process

8．System

132．[smss.exe](https://baike.baidu.com/item/smss.exe)

160．[csrss.exe](https://baike.baidu.com/item/csrss.exe)Title:

180．[winlogon.exe](https://baike.baidu.com/item/winlogon.exe)Title: NetDDE Agent

208services.exe

Svcs: AppMgmt,Browser,Dhcp,dmserver,Dnscache,Eventlog,lanmanserver,LanmanWorkst

ation,LmHosts,Messenger,PlugPlay,[ProtectedStorage](https://baike.baidu.com/item/ProtectedStorage),seclogon,TrkWks,W32Time,Wmi

220．lsass.exe Svcs: Netlogon,PolicyAgent,SamSs

404．svchost.exe Svcs: RpcSs

452．[spoolsv.exe](https://baike.baidu.com/item/spoolsv.exe)Svcs: Spooler

544．[cisvc.exe](https://baike.baidu.com/item/cisvc.exe)Svcs: cisvc

556．svchost.exe Svcs: EventSystem,Netman,NtmsSvc,RasMan,SENS,TapiSrv

580．[regsvc.exe](https://baike.baidu.com/item/regsvc.exe)Svcs: RemoteRegistry

596．[mstask.exe](https://baike.baidu.com/item/mstask.exe)Svcs: Schedule

660．[snmp.exe](https://baike.baidu.com/item/snmp.exe)Svcs: SNMP

728．[winmgmt.exe](https://baike.baidu.com/item/winmgmt.exe)Svcs: WinMgmt

852．[cidaemon.exe](https://baike.baidu.com/item/cidaemon.exe)Title: OleMainThreadWndName

812．[explorer.exe](https://baike.baidu.com/item/explorer.exe)Title: Program Manager

1032 OSA.EXE Title: Reminder

1300 cmd.exe Title: D:\WINNT5\System32\cmd.exe - tlist -s

1080 MAPISP32.EXE Title: WMS Idle

1264[rundll32.exe](https://baike.baidu.com/item/rundll32.exe)Title:

1000．[mmc.exe](https://baike.baidu.com/item/mmc.exe)Title: Device Manager

1144 tlist.exe

在这个例子中注册表设置了两个组。

HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Svchost:

netsvcs: Reg_Multi_SZ: EventSystem Ias Iprip Irmon Netman Nwsapagent RasautoRa

sman Remoteaccess SENS Sharedaccess Tapisrv Ntmssvc

rpcss :Reg_Multi_SZ: RpcSs

[smss.exe](https://baike.baidu.com/item/smss.exe)

[csrss.exe](https://baike.baidu.com/item/csrss.exe)

这个是用户模式Win32子系统的一部分。csrss代表客户/服务器运行子系统而且是一个基本的子系统必须一直运行。csrss 负责控制windows，创建或者删除线程和一些16位的虚拟[MS-DOS](https://baike.baidu.com/item/MS-DOS)环境。



## 调用程序

编辑

 播报

(第一行为"服务名字",第二行为"服务的说明",第三行为"调用程序")

**Application Management**

应用程序管理组件，负责[msi文件格式](https://baike.baidu.com/item/msi%E6%96%87%E4%BB%B6%E6%A0%BC%E5%BC%8F)的安装，但是实际上禁止了该服务并无大碍。

svchost.exe

**Automatic Updates**

Windows的自动更新服务。

svchost.exe

**Background Intelligent Transfer Service**

实现http1.1服务器之间的信息传输，微软称支持windows更新时的[断点续传](https://baike.baidu.com/item/%E6%96%AD%E7%82%B9%E7%BB%AD%E4%BC%A0)。

svchost.exe

**COM+ Event System**

某些COM+软件需要，检查c:/program files/ComPlus Applications目录，如果里面没有文件就可以把这个服务关闭．

svchost.exe

**Computer Browser**

用来浏览局域网电脑的服务，关闭不影响浏览。

svchost.exe

**Cryptographic Services**

Windows更新时用来确认windows文件指纹的，可以在更新的时候开启。

svchost.exe

**DHCP Client**

使用动态IP的用户需要，不要禁用。

svchost.exe

**Distributed Link Tracking Client**

用于局域网更新连接信息，（比如在电脑A有个文件，在电脑B做了个连接，如果文件移动了，这个服务将会更新信息。占用4兆内存。）

svchost.exe

**DNS Client**

DNS[解释器](https://baike.baidu.com/item/%E8%A7%A3%E9%87%8A%E5%99%A8)，把域名解释为IP地址，不要禁用。

svchost.exe

**Error Reporting Service**

[错误报告](https://baike.baidu.com/item/%E9%94%99%E8%AF%AF%E6%8A%A5%E5%91%8A)器，把windows中错误报告给微软。

svchost.exe

**Fast User Switching Compatibility**

多用户快速切换服务。

svchost.exe

**Help and Support**

Windows的帮助。新手还是要靠他来指点的。

svchost.exe

**Human Interface Device Access**

支持“人体工学”的电脑配件，比如键盘上调音量的按钮等等。

svchost.exe

**Internet Connection Firewall/Internet Connection Sharing**

XP的[防火墙](https://baike.baidu.com/item/%E9%98%B2%E7%81%AB%E5%A2%99)/为多台电脑联网共享一个拨号网络访问Internet提供服务。

svchost.exe

**Logical Disk Manager**

[磁盘管理](https://baike.baidu.com/item/%E7%A3%81%E7%9B%98%E7%AE%A1%E7%90%86)服务。需要时系统会通知你开启。

svchost.exe

**Network Location Awareness (NLA)**

如有网络共享或[ICS/ICF](https://baike.baidu.com/item/ICS%2FICF)可能需要.（服务器端）。

svchost.exe

**Portable Media Serial Number**

Windows Media Player和Microsoft保护数字媒体版权.

svchost.exe

**Remote Access Auto Connection Manager**

宽带者/网络共享需要的服务。

svchost.exe

**Remote Procedure Call (RPC)**

系统核心服务。如果在Windows2000中禁止该服务，系统将无法启动。

svchost.exe

**Remote Registry Service**

远程注册表运行/修改。

svchost.exe

减少方式：

你可以把下面这段代码复制到一个空的记事本中，然后另存为“.bat”格式的[批处理](https://baike.baidu.com/item/%E6%89%B9%E5%A4%84%E7%90%86)文件，再运行这个批处理。就可以关闭无用的[系统服务](https://baike.baidu.com/item/%E7%B3%BB%E7%BB%9F%E6%9C%8D%E5%8A%A1)了，你会发现少了很多SVCHOST.EXE。

@echo off

REM 关闭“为 Internet 连接共享和 Windows[防火墙](https://baike.baidu.com/item/%E9%98%B2%E7%81%AB%E5%A2%99)提供第三方协议[插件](https://baike.baidu.com/item/%E6%8F%92%E4%BB%B6)的支持”

sc config alg start= disabled

REM 关闭“Windows自动更新功能”

sc config wuauserv start= disabled

REM 关闭“剪贴簿查看器”

sc config clipsrv start= disabled

REM 关闭“Messenger”

sc config Messenger start= disabled

REM 关闭“通过NetMeeting[远程访问](https://baike.baidu.com/item/%E8%BF%9C%E7%A8%8B%E8%AE%BF%E9%97%AE)此计算机”

sc config mnmsrvc start= disabled

REM 关闭“打印后台处理程序”

sc config Spooler start= disabled

REM 关闭“远程修改注册表”

sc config RemoteRegistry start= disabled

REM 关闭“监视系统安全设置和配置”

sc config wscsvc start= disabled

REM 关闭“系统还原”

sc config srservice start= disabled

REM 关闭“计划任务”

sc config Schedule start= disabled

REM 关闭“TCP/IP NetBIOS Helper”

sc config[lmhosts](https://baike.baidu.com/item/lmhosts)start= disabled

REM 关闭“Telnet服务”

sc config tlntsvr start= disabled

REM 关闭“[防火墙](https://baike.baidu.com/item/%E9%98%B2%E7%81%AB%E5%A2%99)服务”

sc config sharedaccess start= disabled

REM 关闭“Computer Browser”

sc config Browser start= disabled

REM 关闭“错误报警”

sc config Alerter start= disabled

REM 关闭“错误报告”

sc config ERSvc start= disabled

REM 关闭“本地和远程计算机上文件的索引内容和属性”

sc config cisvc start= disabled

REM 关闭“管理卷影复制服务拍摄的软件卷影复制”

sc config SwPrv start= disabled

REM 关闭“支持网络上计算机 pass-through 帐户登录身份验证事件”

sc config NetLogon start= disabled

REM 关闭“为使用[传输协议](https://baike.baidu.com/item/%E4%BC%A0%E8%BE%93%E5%8D%8F%E8%AE%AE)而不是[命名管道](https://baike.baidu.com/item/%E5%91%BD%E5%90%8D%E7%AE%A1%E9%81%93)的[远程过程调用](https://baike.baidu.com/item/%E8%BF%9C%E7%A8%8B%E8%BF%87%E7%A8%8B%E8%B0%83%E7%94%A8)(RPC)程序提供安全机制”

sc config NtLmSsp start= disabled

REM 关闭“收集本地或远程计算机基于预先配置的日程参数的性能数据，然后将此数据写入日志或触发警报”

sc config SysmonLog start= disabled

REM 关闭“通过联机计算机重新获取任何音乐播放序号”

sc config WmdmPmSN start= disabled

REM 关闭“管理连接到计算机的不间断电源(UPS)”

sc config UPS start= disabled



## 修复方法

编辑

 播报



### 一般修复

svchost.exe出错，很多是因为系统中了[流氓软件](https://baike.baidu.com/item/%E6%B5%81%E6%B0%93%E8%BD%AF%E4%BB%B6)，如果不了解系统，不知道svchost.exe在电脑中的存放位置，那么建议使用[修复工具](https://baike.baidu.com/item/%E4%BF%AE%E5%A4%8D%E5%B7%A5%E5%85%B7)对系统进行最全面的扫描和修复。

首先，建议使用[金山毒霸](https://baike.baidu.com/item/%E9%87%91%E5%B1%B1%E6%AF%92%E9%9C%B8)或360安全卫士。

然后，点击主界面的快速扫描，进行全面的系统扫描。

最后，按提示重新启动电脑，svchost.exe下载修复完毕。



### 下载修复

一、如果您的系统提示“没有找到svchost.exe”或者“缺少svchost.exe ”等类似错误信息，请把svchost.exe下载到本机

二、直接拷贝该文件到系统目录里：

1、Windows 95/98/Me系统，则复制到C:\Windows\System目录下。

2、Windows NT/2000系统，则复制到C:WINNT\System32目录下。

3、Windows XP系统，则复制到C:Windows\System32目录下。

三、然后打开“开始-运行-输入regsvr32 svchost.exe”，回车即可解决错误提示。



### 中毒处理

1．病毒木马原因导致的 ，因为svchost进程启动各种服务，所以病毒、木马也想尽办法来利用它，企图利用它的特性来迷惑用户，使svchost成为病毒的傀儡进程，进行病毒下载操作，从而下载大量木马，盗取用户信息。推荐使用[金山卫士](https://baike.baidu.com/item/%E9%87%91%E5%B1%B1%E5%8D%AB%E5%A3%AB)对木马病毒木马查杀。

2． IE组件在注册表中注册信息被破坏 ， 重新注册ie组件信息问题即可解决。

3．如果电脑有打印机，还可能是因为[打印机驱动](https://baike.baidu.com/item/%E6%89%93%E5%8D%B0%E6%9C%BA%E9%A9%B1%E5%8A%A8)安装错误，也会造成的错误 ，只要重新安装打印机驱动即可解决

4．某些软件与Svchost.exe发生冲突导致的，解决方法就是[卸载](https://baike.baidu.com/item/%E5%8D%B8%E8%BD%BD)该软件或者升级该软件到最新版本。

5.大多数网民喜欢使用[ghost系统](https://baike.baidu.com/item/ghost%E7%B3%BB%E7%BB%9F)，[破解版](https://baike.baidu.com/item/%E7%A0%B4%E8%A7%A3%E7%89%88)系统，但是使用这些系统可能存在不兼容因素 ，很容易导致发生的错误 ，最好解决方法就是安装使用正版操作系统。



### 解决方法

1．什么程序都没打开。 常见svchost.exe这个进程占用CPU资源高到100%



### 检查方法

按（Ctrl+Alt+Del）进入——[任务管理器](https://baike.baidu.com/item/%E4%BB%BB%E5%8A%A1%E7%AE%A1%E7%90%86%E5%99%A8)里。查看svchost.exe进程CPU资源是否占用50%—100%。（占用CPU资源100%或者内存50%）。



### 解决方法

开始—控制面板—打印机和传真—MicrosoftXXXXX微软[虚拟打印机](https://baike.baidu.com/item/%E8%99%9A%E6%8B%9F%E6%89%93%E5%8D%B0%E6%9C%BA)（系统默认有个打印机）—打开打印机—删除取消所有正在打印中的文档，或者右键删除系统默认打印机程序，就可以解决CPU占用100%。