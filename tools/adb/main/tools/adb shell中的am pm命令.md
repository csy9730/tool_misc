# [adb shell中的am pm命令](https://www.cnblogs.com/wangcp-2014/p/6076035.html)

adb shell中的am pm命令，一些自己的见解和大多数官网的翻译。

**am命令**

am全称activity manager，你能使用am去模拟各种系统的行为，例如去启动一个activity，强制停止进程，发送广播进程，修改设备屏幕属性等等。当你在adb shell命令下执行am命令：

am <command>
你也可以在adb shell前执行am命令：
adb shell am start -a android.intent.action.VIEW
关于一些am命令的介绍：

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

以下命令查看官网：
monitor [options]
screen-compat [on|off] <PACKAGE>
display-size [reset|<WxH>]
display-density <dpi>
to-uri <INTENT>
to-intent-uri <INTENT>

 

**pm命令:**

pm全称package manager，你能使用pm命令去模拟android行为或者查询设备上的应用等，当你在adb shell命令下执行pm命令：

pm <command>
你也可以在adb shell前执行pm命令：
adb shell pm uninstall com.example.MyApp
关于一些pm命令的介绍：
list packages [options] <FILTER> ：打印所有包，选择性的查询包列表。

参数选项：-f：查看关联文件，即应用apk的位置跟对应的包名（如：package:/system/app /MusicPlayer.apk=com.sec.android.app.music）；

​       -d：查看disabled packages；

​       -e：查看enable package；

​       -s：查看系统package；

​       -3：查看第三方package；

​       -i：查看package的对应安装者（如：1、 package:com.tencent.qqmusic installer=null 2、package:com.tencent.qqpim installer=com.android.vending）；

​      -u：查看曾被卸载过的package。（卸载后又重新安装依然会被列 入）；

​      --user<USER_ID>：The user space to query。

list permission-groups ：打印所有已知的权限群组。

list permissions [options] <GROUP> ：选择性的打印权限。参数选项：

 

list features ：设备特性。硬件之类的性能。

list libraries ：当前设备支持的libs。

list users ：系统上所有的users。（上面提到的USER_ID查询方式，如：UserInfo{0:Primary:3}那么USER_ID为0）

path <PACKAGE> ：查询package的安装位置。

install [options] <PATH> ：安装命令。

uninstall [options] <PACKAGE> ：卸载命令。

clear <PACKAGE> ：对指定的package删除所有数据。

enable <PACKAGE_OR_COMPONENT> ：使package或component可用。（如：pm enable "package/class"）

disable <PACKAGE_OR_COMPONENT> ：使package或component不可用。（如：pm disable "package/class"）

disable-user [options] <PACKAGE_OR_COMPONENT> ：参数选项：--user <USER_ID>: The user to disable.
grant <PACKAGE_PERMISSION> ：授权给应用。

revoke <PACKAGE_PERMISSION> ：撤销权限。

set-install-location <LOCATION> ：设置默认的安装位置。其中0：让系统自动选择最佳的安装位置。1：安装到内部的设备存储空间。2：安装到外部的设备存储空间。（这只用于调试应用程序， 使用该命令可能导致应用程序退出或者其他不适的后果）。

get-install-location ：返回当前的安装位置。返回结果同上参数选项。

set-permission-enforced <PERMISSION> [true|false] ：使指定权限生效或者失效。

create-user <USER_NAME> ：增加一个新的USER。

remove-user <USER_ID> ：删除一个USER。

get-max-users ：该设备所支持的最大USER数。（某些设备不支持该命令）

分类: [appium](https://www.cnblogs.com/wangcp-2014/category/855741.html)

标签: [adb](https://www.cnblogs.com/wangcp-2014/tag/adb/)