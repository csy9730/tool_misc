# cmd shutdown命令：关机，重启，休眠

展开
一段时间后关机：
shutdown -s -t 秒数效果是倒计时到该秒数后关机，例如shutdown -s -t 3600就是3600秒后关机，也就是一小时后关机

立即关机命令：
shutdown -p关闭本地计算机，效果是马上关机，而不进行倒计时
也可以使用shutdown -s -t 0设置0秒后关机，也就是立即关机的意思。

一段时间后重启
shutdown -r -t 秒数，效果是倒计时该秒数后重启，例如shutdown -r -t 0倒数0秒后重启，也就是立即重启的意思，如果没有加-t参数则会倒计时默认的秒数后关机，一般是一分钟。

休眠命令
shutdown -h,这条指令让计算机休眠，也就是完全断电，但是会保存当前电脑的状态，下次启动时这些打开过的程序都还在。类似虚拟机的挂起功能。

睡眠指令
睡眠和休眠的不同的地方是，睡眠没有完全掉电，电脑中其他的耗电部分都关闭，只留下内存供电，下次在唤醒电脑的时候，恢复到睡眠之前的状态。这点和休眠类似，睡眠的好处就是启动快。短时间离开电脑的话可以睡眠，如果时间间隔比较久的话用休眠。休眠和关机一样是不耗电的，而睡眠因为还有给内存供电，所以睡眠还是耗电的。

使用命令行工具PsShutdown.exe实现休眠
直接上微软官方网站下个软件PsShutdown.exe，请前往此页点击下载。
然后在命令行里进入解压后的文件夹中输入：psshutdown.exe -d -t 0

使用nircmd实现睡眠
输入指令nircmd standby即可实现睡眠(也就是待机状态)

启用屏幕保护
cmd下输入rundll32.exe user32.dll LockWorkStation，可以启动屏幕保护功能，这样要再次使用电脑的时候要输入密码。可以在短时间离开的时候，防止别人动你电脑。

显示shutdown命令语法
遇到命令不懂的时候，一般会去网上搜索，但是我发现网上的资料都介绍的都全，其实，最应该做的应该是直接在cmd中查看，官方的介绍文档。
输入shutdown -help显示shutdown指令的用法

用法: shutdown [/i | /l | /s | /sg | /r | /g | /a | /p | /h | /e | /o] [/hybrid] [/soft] [/fw] [/f]
    [/m \\computer][/t xxx][/d [p|u:]xx:yy [/c "comment"]]

    没有参数   显示帮助。这与键入 /? 是一样的。
    /?         显示帮助。这与不键入任何选项是一样的。
    /i         显示图形用户界面(GUI)。
               这必须是第一个选项。
    /l         注销。这不能与 /m 或 /d 选项一起使用。
    /s         关闭计算机。
    /sg        关闭计算机。在下一次启动时，
               重启任何注册的应用程序。
    /r         完全关闭并重启计算机。
    /g         完全关闭并重新启动计算机。在重新启动系统后，
               重启任何注册的应用程序。
    /a         中止系统关闭。
               这只能在超时期间使用。
               与 /fw 结合使用，以清除任何未完成的至固件的引导。
    /p         关闭本地计算机，没有超时或警告。
               可以与 /d 和 /f 选项一起使用。
    /h         休眠本地计算机。
               可以与 /f 选项一起使用。
    /hybrid    执行计算机关闭并进行准备以快速启动。
               必须与 /s 选项一起使用。
    /fw        与关闭选项结合使用，使下次启动转到
               固件用户界面。
    /e         记录计算机意外关闭的原因。
    /o         转到高级启动选项菜单并重新启动计算机。
               必须与 /r 选项一起使用。
    /m \\computer 指定目标计算机。
    /t xxx     将关闭前的超时时间设置为 xxx 秒。
               有效范围是 0-315360000 (10 年)，默认值为 30。
               如果超时时间大于 0，则默示为
               /f 参数。
    /c "comment" 有关重新启动或关闭的原因的注释。
               最多允许 512 个字符。
    /f         强制关闭正在运行的应用程序而不事先警告用户。
               如果为 /t 参数指定大于 0 的值，
               则默示为 /f 参数。
    /d [p|u:]xx:yy  提供重新启动或关闭的原因。
               p 指示重启或关闭是计划内的。
               u 指示原因是用户定义的。
               如果未指定 p 也未指定 u，则重新启动或关闭
               是计划外的。
               xx 是主要原因编号(小于 256 的正整数)。
               yy 是次要原因编号(小于 65536 的正整数)。

此计算机上的原因:
(E = 预期 U = 意外 P = 计划内，C = 自定义)
类别    主要    次要    标题

 U      0       0       其他(计划外)
E       0       0       其他(计划外)
E P     0       0       其他(计划内)
 U      0       5       其他故障: 系统没有反应
E       1       1       硬件: 维护(计划外)
E P     1       1       硬件: 维护(计划内)
E       1       2       硬件: 安装(计划外)
E P     1       2       硬件: 安装(计划内)
E       2       2       操作系统: 恢复(计划外)
E P     2       2       操作系统: 恢复(计划内)
  P     2       3       操作系统: 升级(计划内)
E       2       4       操作系统: 重新配置(计划外)
E P     2       4       操作系统: 重新配置(计划内)
  P     2       16      操作系统: Service Pack (计划内)
        2       17      操作系统: 热修补(计划外)
  P     2       17      操作系统: 热修补(计划内)
        2       18      操作系统: 安全修补(计划外)
  P     2       18      操作系统: 安全修补(计划内)
E       4       1       应用程序: 维护(计划外)
E P     4       1       应用程序: 维护(计划内)
E P     4       2       应用程序: 安装(计划内)
E       4       5       应用程序: 没有反应
E       4       6       应用程序: 不稳定
 U      5       15      系统故障: 停止错误
 U      5       19      安全问题(计划外)
E       5       19      安全问题(计划外)
E P     5       19      安全问题(计划内)
E       5       20      网络连接丢失(计划外)
 U      6       11      电源故障: 电线被拔掉
 U      6       12      电源故障: 环境
  P     7       0       旧版 API 关机

从帮助文档中可以看出
shutdown -h的意思是：休眠本地计算机，执行该指令后计算机会立即休眠。-h参数可以和-f参数一起使用，但是不能和-t参数一起使用。也是就是说shutdown -h -t 3600这样的用法是错误的。

shutdown -p关闭本地计算机，执行该指令后计算机会立即关闭，也不会等待默认的时间。

shutdown -s表示关闭本地计算机，如果不使用-t参数的话，会倒计时默认的事件后关机，如果使用-t参数的话倒计时设置的时间后关机，例如shutdown -s -t 3600就是3600秒后关机。

shutdown -r表示完全关闭并重启计算机。就理解为重启就行，同样的可以加-t设置倒计时多少时间后重启，例如shutdown -r -t 3600就是倒计时3600秒后重启，而shutdown -r -t 0就是倒计时0秒后重启，也就是立即重启。

shutdown -a表示取消关机，或者取消重启。在shutdown -s或者shutdown -r倒计时结束之前执行shutdown -a可以取消关机或者重启操作。

## sleep

## Windows CDM

简单地说，执行如下命令即可让 Windows 10 进入睡眠状态：

```
rundll32.exe powrprof.dll,SetSuspendState 0,1,0
```

> 请大家注意：如果你的 Windows 10 激活了休眠功能的话，执行上述命令会直接进入休眠而非睡眠模式。

此时，你可以使用如下命令来将休眠功能临时关闭掉，而最后一行表示在系统被唤醒后重新启用休眠功能。

```
powercfg -h offrundll32.exe powrprof.dll,SetSuspendState 0,1,0powercfg -h on
```

## PsShutdown

长期关注系统极客的朋友应该对 [Sysinternals](http://www.sysgeek.cn/tag/sysinternals/) 的 [PsShutdown](http://www.sysgeek.cn/sysinternals-pstools/) 命令不会陌生，在此前的文章中我们已经提到过如下命令也可让 Windows 进入睡眠：

```
psshutdown -d –acceptula
```

## NirCmd

NirSoft 也出了一个名为 [NirCmd](http://www.nirsoft.net/utils/nircmd.html) 的命令行可以让 Windows 进入睡眠：

```
nircmd standby
```

## Get-ScheduledTask

``` bash
Get-ScheduledTask
Get-ScheduledTask -TaskName Google* # 返回所有从Google开始的任务。
Get-ScheduledTask -TaskPath \  # 返回放置在根目录中的所有任务。
Get-ScheduledTask -TaskPath \Microsoft\*  # 返回放置在\Microsoft\目录中的所有任务。

Disable-ScheduledTask -taskname “Adobe Flash Player Updater” # 禁用任务Adobe Flash Player Updater。
Enable-ScheduledTask -taskname “Adobe Flash Player Updater” # 启用任务Adobe Flash Player Updater。
Get-ScheduledTask -taskname Google * | Disable-ScheduledTask # 禁用get命令返回的所有任务（从Google开始）
```

