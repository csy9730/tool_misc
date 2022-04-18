# [adb shell中的am pm命令](https://www.cnblogs.com/wangcp-2014/p/6076035.html)

adb shell中的am pm命令，一些自己的见解和大多数官网的翻译。

## **am命令**

am全称activity manager，你能使用am去模拟各种系统的行为，例如去启动一个activity，强制停止进程，发送广播进程，修改设备屏幕属性等等。当你在adb shell命令下执行am命令：

am <command>
你也可以在adb shell前执行am命令：
adb shell am start -a android.intent.action.VIEW
关于一些am命令的介绍：
```
start [options] <INTENT> ：启动activity通过指定的intent参数。具体intent参数参照官方表。

startservice [options] <INTENT> ： 启动service通过指定的intent参数。具体intent跟start命令参数相同。

force-stop <PACKAGE> ： 强制停止指定的package包应用。

kill [options] <PACKAGE> ：杀死指定package包应用进程，该命令在安全模式下杀死进程，不影响用户体验。参数选项：--user <USER_ID> | all | current: 指定user进程杀死，如果不指定默认为所有users。（关于USER_ID下面会介绍到）

kill-all ：杀死所有的后台进程。

broadcast [options] <INTENT> ：发送一个intent。具体intent参数参照start命令参数。参数选项：--user <USER_ID> | all | current: 指定user进程杀死，如果不指定默认为所有users。

instrument [options] <COMPONENT> ：测试命令，不多作介绍。

profile start <PROCESS> <FILE> ：在<PROCESS>进程中运行profile，分析结果写到<FILE>里。

profile stop <PROCESS> ：停止profile。

set-debug-app [options] <PACKAGE> ：设置package包应用为debug模式。参数选项：-w|--persistent：等待进入调试模式，保留值。

clear-debug-app ：清空之前用set-debug-app命令设置的package包应用。
```

以下命令查看官网：
monitor [options]
screen-compat [on|off] <PACKAGE>
display-size [reset|<WxH>]
display-density <dpi>
to-uri <INTENT>
to-intent-uri <INTENT>

 
