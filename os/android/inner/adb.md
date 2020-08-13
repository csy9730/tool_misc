# adb

[TOC]


## ADB

adb介绍：
Android Debug Bridge（安卓调试桥） tools。它就是一个命令行窗口，用于通过电脑端与模拟器或者是设备之间的交互。

ADB是一个客户端-服务器端程序，其中客户端是你用来操作的电脑，服务器端是android设备。

ADB是一个C/S架构的应用程序，由三部分组成：

* 运行在pc端的adb client
* 运行在pc端的adb server
* 运行在设备端的常驻进程adb demon (adbd)



Client端, 运行在开发机器中, 即你的开发PC机. 用来发送adb命令.

Deamon守护进程, 运行在调试设备中, 即的调试手机或模拟器.

Server端, 作为一个后台进程运行在开发机器中, 即你的开发PC机. 用来管理PC中的Client端和手机的Deamon之间的通信.





首先，adb程序尝试定位主机上的ADB Server，如果找不到ADB Server，“adb”程序自动启动一个ADB Server。接下来，当设备的adbd和pc端的adb server建立连接后，adb client就可以向ADB servcer发送服务请求；

ADB Server是运行在主机上的一个后台进程。它的作用在于检测USB端口感知设备的连接和拔除，以及模拟器实例的启动或停止，ADB Server还需要将adb client的请求通过usb或者tcp的方式发送到对应的adbd上

[adb](https://developer.android.google.cn/studio/command-line/adb)
**Q**: adb可以实现：
**A**:

* `adb install` 实现软件批量安装/卸载
* `adb push` 实现文件备份和管理 
* `adb input` 执行简单的固定的按键脚本,例如 通过上下滑动实现刷抖音
* `adb screen` 获得截屏
* 管理进程
* appium执行按键脚本，添加屏幕截图判断。
* 设置端口转发

## quickstart

``` bash
adb start-server
adb kill-server # 停止 adb server
adb devices # 查询已连接设备/模拟器
 # 可能在adb中存在多个虚拟设备运行 可以指定虚拟设备运行  -s 虚拟设备名称
```
该命令经常出现以下问题：
offline —— 表示设备未连接成功或无响应；
device —— 设备已连接；
no device —— 没有设备/模拟器连接；
unauthorized —— 设备没有授权，需要用户在手机上点击授权按钮

List of devices attached 设备/模拟器未连接到 adb 或无响应



adb root , adb remount, 只针对类似小米开发版的手机有用，可以直接已这两个命令获取管理员(root)权限，并挂载系统文件系统为可读写状态


## connect

### USB 连接



**Q**:
**A**: USB连接：
在手机“设置”-“关于手机”连续点击“版本号”7 次，可以进入到开发者模式；然后可以到“设置”-“开发者选项”-“调试”里打开USB调试以及允许ADB的一些权限；连接时手机会弹出“允许HiSuite通过HDB连接设备”点击允许/接受即可；
驱动也是必须安装的，可以用豌豆荚，或者是手机商家提供的手机助手，点进去驱动器安装即可（部分电脑双击无法直接进入到驱动器里，可以使用右键找到进入点击即可）



### wifi

也可以通过wifi进行无线连接

#### 手机端配置tcp方式连接

需先连上usb模式, 开启远程调试模式，然后打开监听5555端口
 $ adb tcpip 5555

$ adb shell ip addr 



#### 手机端su wifi

利用IP地址进行的无线连接是官方文档里介绍的方法，需要借助于 USB 数据线来实现无线连接。root 账户可以完成真正意义上的无线连接

1. 在 Android 设备上安装一个终端模拟器。

   已经安装过的设备可以跳过此步。终端模拟器下载地址是：[Terminal Emulator for Android Downloads](https://jackpal.github.io/Android-Terminal-Emulator/)

2. 将 Android 设备与要运行 adb 的电脑连接到同一个局域网，比如连到同一个 WiFi。

3. 打开 Android 设备上的终端模拟器，在里面依次运行命令：

   ```
   su
   setprop service.adb.tcp.port 5555
   1. stop adbd
   2. start adbd
   ```

4. 找到 Android 设备的 IP 地址。

   同上

5. 在电脑上通过 adb 和 IP 地址连接 Android 设备。

   ```
   adb connect <device-ip-address> # 看到 connected to <device-ip-address>:5555 这样的输出则表示连接成功
   ```





####  电脑端使用adb远程连接

``` bash
adb connect ip_address 
adb connect 192.168.1.4:5555 # 例如连接 指定地址
```

#### forward
`adb forward `将 宿主机上的某个端口重定向到设备的某个端口
adb forward tcp:1314 tcp :8888
执行该命令后所有发往宿主机 1314 端口的消息、数据都会转发到 Android 设备的 8888 端口上，因此可以通过远程的方式控制 Android 设备。

###  misc



通过wifi进行远程连接手机进行调试的.
 [https://developer.android.com/studio/command-line/adb.html#wireless](https://link.jianshu.com?t=https://developer.android.com/studio/command-line/adb.html#wireless)



### install

安装apk：

``` bash
adb install “-lrtsdg” “path_to_apk”
“-lrtsdg”：
-l：将应用安装到保护目录 /mnt/asec；
-r：允许覆盖安装；
-t：允许安装 AndroidManifest.xml 里 application 指定 android:testOnly=“true” 的应用；
-s：将应用安装到 sdcard；
-d：允许降级覆盖安装；
-g：授予所有运行时权限；
path_to_apk：apk的绝对路径。

adb install -l /data/local/tmp/taobao.apk # 示例安装淘宝apk
```

卸载apk：

``` bash


adb uninstall -k “packagename”
“packagename”：表示应用的包名，以下相同；
-k 参数可选，表示卸载应用但保留数据和缓存目录。
示例卸载 手机淘宝：adb uninstall com.taobao.taobao


adb shell pm clear “packagename” # 清除应用数据与缓存命令
# 相当于在设置里的应用信息界面点击「清除缓存」和「清除数据」。
adb shell pm clear com.taobao.taobao # 表示清除 手机淘宝数据和缓存。


```



## shell
Android 提供了大多数常见的 Unix 命令行工具。如需查看可用工具的列表，请使用以下命令：
`adb shell ls /system/bin`
许多 shell 命令由 toybox

### am
调起 Activity命令格式：adb shell am start [options]
调起 Service命令格式：adb shell am startservice [options]
例如：adb shell am startservice -n
com.tencent.mm/.plugin.accountsync.model.AccountAuthenticatorService 表示调起微信的某 Service。

``` bash 
adb shell am startservice -n com.tencent.mm/.plugin.accountsync.model.AccountAuthenticatorService # 表示调起微信的某 Service。
adb shell am start -n com.android.camera/.Camera # 启动相机

adb shell am force-stop packagename # 强制停止应用
adb shell am force-stop com.taobao.taobao # 强制停止淘宝
```

### process

查看前台 Activity命令：adb shell dumpsys activity activities | grep mFocusedActivity
查看正在运行的 Services命令：adb shell dumpsys activity services “packagename” 其中参数不是必须的，指定 “packagename” 表示查看与某个包名相关的 Services，不指定表示查看所有 Services。
查看应用详细信息命令：adb shell dumpsys package “packagename”



查看进程：adb shell ps
查看实时资源占用情况：adb shell top
查看进程 UID：adb shell dumpsys package | grep userId=


### pm

查看应用列表：

```bash
adb shell pm list packages # 查看所有应用列表
adb shell pm list packages -s # 查看系统应用列表
adb shell pm list packages -3： # 查看第三方应用列表
```





### input

模拟按键/输入:`adb shell input keyevent keycode `

不同的 keycode有不同的功能：



| keycode | 含义                           |
| ------- | ------------------------------ |
| 3       | HOME 键                        |
| 4       | 返回键                         |
| 5       | 打开拨号应用                   |
| 6       | 挂断电话                       |
| 26      | 电源键                         |
| 27      | 拍照（需要在相机应用里）       |

滑动解锁：如果锁屏没有密码，是通过滑动手势解锁，那么可以通过 input swipe 来解锁。
命令:
adb shell input swipe 300 1000 300 500
(其中参数 300 1000 300 500 分别表示起始点x坐标 起始点y坐标 结束点x坐标 结束点y坐标。)
输入文本:在焦点处于某文本框时，可以通过 input 命令来输入文本。
命令：adb shell input text *** (***即为输入内容)

#### 点击

adb shell input tap x y

使用 Monkey 进行压力测试：Monkey 可以生成伪随机用户事件来模拟单击、触摸、手势等操作，可以对正在开发中的程序进行随机压力测试。
简单用法：adb shell monkey -p < packagename > -v 500 表示向 指定的应用程序发送 500 个伪随机事件。

**Q**: 拨打电话
**A**: 
adb shell service call phone 2 s16 10001
adb shell am start -a android.intent.action.CALL tel:10086


**Q**: 发送短信
**A**: 
1. adb shell am start -a android.intent.action.SENDTO -d sms:10086 --es sms_body  hello  打开了短信应用程序，当前焦点在文本框
2. adb shell input keyevent 22  焦点去到发送按键
3. adb shell input keyevent 66  回车，就是按下发送键
4. 
#### uiautomator
uiautomator
执行 UI automation tests ， 获取当前界面的控件信息

runtest：executes UI automation tests RunTestCommand.java

dump：获取控件信息，DumpCommand.java

[admin:~]$ adb shell uiautomator dump   
UI hierchary dumped to: /storage/emulated/legacy/window_dump.xml

#### ime
ime
输入法，Ime.java

[admin:~]$ adb shell ime list -s                           
com.google.android.inputmethod.pinyin/.PinyinIME
com.baidu.input_mi/.ImeService
列出设备上的输入法

[admin:~]$ adb shell ime set com.baidu.input_mi/.ImeService
Input method com.baidu.input_mi/.ImeService selected    
选择输入法


### dumpsys

强大的dump工具, 可以输出很多系统信息. 例如window, activity, task/back stack信息, wifi信息等.

> [探索Activity之launchMode](https://link.jianshu.com?t=http://lmj.wiki/post/androidtan-suo-lu/tan-suo-activityzhi-launchmode)和[探索Activity之启动Intent flag和Affinity](https://link.jianshu.com?t=http://lmj.wiki/post/androidtan-suo-lu/tan-suo-activityzhi-qi-dong-intent-flaghe-taskaffinity)就是用adb shell dumpsys activity来输出task信息的.

常用dumpsys:

| 指令         | 说明                                | 备注                                                         | 细分参数                                                     |
| ------------ | ----------------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| activity     | 输出app组件相关信息                 | 还可以用细分参数获得单项内容, 下同. 例如adb shell dumpsys activity activities来获取activity task/back stack信息. | activites, service, providers, intents, broadcasts, processes |
| alarm        | 输出当前系统的alarm信息             | /                                                            | /                                                            |
| cpuinfo      | 输出当前的CPU使用情况               | /                                                            | /                                                            |
| diskstats    | 输出当前的磁盘使用状态              | /                                                            | /                                                            |
| batterystats | 电池使用信息                        | /                                                            | /                                                            |
| package      | package相关信息, 相当于pm功能的集合 | 输出诸如libs, features, packages等信息                       | /                                                            |
| meminfo      | 输出每个App的内存使用和系统内存状态 | 可以指定包名, 例如adb shell dumpsys meminfo com.anly.githubapp | /                                                            |
| window       | 输出当前窗口相关信息                | /                                                            | policy, animator, tokens, windows                            |

``` bash
adb shell dumpsys window displays # 显示屏参数：
输出示例：
WINDOW MANAGER DISPLAY CONTENTS (dumpsys window displays)
Display: mDisplayId=0
init=1080x1920 420dpi cur=1080x1920 app=1080x1794 rng=1080x1017-1810x1731
deferred=false layoutNeeded=false

# 其中 mDisplayId 为 显示屏编号，init 是初始分辨率和屏幕密度，app 的高度比 init 里的要小，表示屏幕底部有虚拟按键，高度为 1920 - 1794 = 126px 合 42dp。
```



### hardware





查看设备情况：

``` bash


adb shell getprop ro.product.model # 查看设备信息型号命令

adb shell wm size # 屏幕分辨率命令
如果使用命令修改过，那输出可能是：
Physical size: 1080x1920
Override size: 480x1024
表明设备的屏幕分辨率原本是 1080px * 1920px，当前被修改为 480px * 1024px。
屏幕密度命令：adb shell wm density
如果使用命令修改过，那输出可能是：
Physical density: 480
Override density: 160
表明设备的屏幕密度原来是 480dpi，当前被修改为 160dpi。


adb shell settings get secure android_id # android_id查看命令
adb shell getprop ro.build.version.release # 查看Android 系统版本：
adb shell ifconfig | grep Mask # 查看设备ip地址
adb shell netcfg
adb shell cat /proc/cpuinfo # 查看CPU 信息命令
adb shell cat /proc/meminfo # 查看内存信息命令
```

更多硬件与系统属性：
设备的更多硬件与系统属性可以通过如下命令查看：

`adb shell cat /system/build.prop`
单独查看某一硬件或系统属性：adb shell getprop <属性名>

| 属性名                      | 含义                   |
| --------------------------- | ---------------------- |
| ro.build.version.sdk        | SDK 版本               |
| ro.build.version.release    | Android 系统版本       |
| ro.product.model            | 型号                   |
| ro.product.brand            | 品牌                   |
| ro.product.name             | 设备名                 |
| ro.product.board            | 处理器型号             |
| persist.sys.isUsbOtgEnabled | 是否支持 OTG           |
| dalvik.vm.heapsize          | 每个应用程序的内存上限 |
| ro.sf.lcd_density           | 屏幕密度               |
|   rro.build.version.security_patch	|Android 安全补丁程序级别|

### setting

修改设置之后，运行恢复命令有可能显示仍然不太正常，可以运行 adb reboot 重启设备，或手动重启。
修改设置的原理主要是通过 settings 命令修改 /data/data/com.android.providers.settings/databases/settings.db 里存放的设置值。
修改分辨率命令：adb shell wm size 480x1024 恢复原分辨率命令：adb shell wm size reset
修改屏幕密度命令：adb shell wm density 160 表示将屏幕密度修改为 160dpi；恢复原屏幕密度命令：adb shell wm density reset
修改显示区域命令：adb shell wm overscan 0,0,0,200 四个数字分别表示距离左、上、右、下边缘的留白像素，以上命令表示将屏幕底部 200px 留白。恢复原显示区域命令：adb shell wm overscan reset
关闭 USB 调试模式命令：adb shell settings put global adb_enabled 0 需要手动恢复：「设置」-「开发者选项」-「Android 调试」

**恢复正常模式**：adb shell settings put global policy_control null

设置熄屏时间为30分钟settings put system screen_off_timeout 180000;



##  output

实用功能：
截图保存到电脑：adb exec-out screencap -p > sc.png
然后将 png 文件导出到电脑：adb pull /sdcard/sc.png
录制屏幕：录制屏幕以 mp4 格式保存到 /sdcard：

`adb shell screenrecord /sdcard/filename.mp4`

 需要停止时按 Ctrl-C，默认录制时间和最长录制时间都是 180 秒。
如果需要导出到电脑：adb pull /sdcard/filename.mp4

挂载、查看连接过的 WiFi 密码、开启/关闭 WiFi、设置系统日期和时间都需要root权限，不做多说。




## debugging

打印日志：
Android 的日志分为如下几个优先级（priority）：
V —— Verbose（最低，输出得最多）
D —— Debug I —— Info
W —— Warning
E —— Error
F—— Fatal
S —— Silent（最高，啥也不输出）
按某级别过滤日志则会将该级别及以上的日志输出。
比如，命令：adb logcat *:W 会将 Warning、Error、Fatal 和 Silent 日志输出。
（注： 在 macOS 下需要给 :W 这样以 作为 tag 的参数加双引号，如 adb logcat “:W”，不然会报错 no matches found: :W。）

adb logcat	打印当前设备上所有日志
adb logcat *:W	过滤打印严重级别W及以上的日志
adb logcat l findstr ***> F:\log.txt	把仅含***的日志保存到F盘的log.txt文件中
adb logcat -c	清除屏幕上的日志记录
adb logcat -c && adb logcat -s ActivityManager l grep "Displayed”	客户端程序启动时间获取日志
adb logcat > F:\log.txt	打印当前设备上所有日志保存到F盘的log.txt文件中
adb logcat l findstr ***	打印过滤仅含***的日志
adb logcat l findstr ***> F:\log.txt	把仅含***的日志保存到F盘的log.txt文件中

按 tag 和级别过滤日志：命令：adb logcat ActivityManager:I MyApp:D *:S
表示输出 tag ActivityManager 的 Info 以上级别日志，输出 tag MyApp 的 Debug 以上级别日志，及其它 tag 的 Silent 级别日志（即屏蔽其它 tag 日志）。
日志格式可以用：adb logcat -v 选项指定日志输出格式。
日志支持按以下几种 ：默认格式brief、process、tag、raw、time、long
指定格式可与上面的过滤同时使用。比如：adb logcat -v long ActivityManager:I *:S
清空日志：adb logcat -c
内核日志：adb shell dmesg

## file transfer



``` bash
file transfer:
 push [--sync] LOCAL... REMOTE
     copy local files/directories to device
     --sync: only push files that are newer on the host than the device
 pull [-a] REMOTE... LOCAL
     copy files/dirs from device
     -a: preserve file timestamp and mode
 sync [all|data|odm|oem|product_services|product|system|vendor]
     sync a local build from $ANDROID_PRODUCT_OUT to the device (default all)
     -l: list but don't copy

```

## boot

adb reboot # 重启设备，或手动重启。

adb reboot recovery

#### Recovery模式

Recovery模式选项：

reboot system now
apply update from ADB
wipe data/factory reset
wipe cache partition

选择 wipe data/factory reset可以清楚用户数据，并且恢复出厂设置。

选择 reboot system now重启机器。



``` bash
adb root
adb remount # （重新挂载系统分区，使系统分区重新可写）。
adb shell
rm -r /data/ # 用户数据都在这里面，能删的都删掉，不同平台有不同。
```




## help


``` bash
Android Debug Bridge version 1.0.40
Version 28.0.2-5303910
Installed as C:\Users\win8\AppData\Local\Android\Sdk\platform-tools\adb.exe

global options:
 -a         listen on all network interfaces, not just localhost
 -d         use USB device (error if multiple devices connected)
 -e         use TCP/IP device (error if multiple TCP/IP devices available)
 -s SERIAL  use device with given serial (overrides $ANDROID_SERIAL)
 -t ID      use device with given transport id
 -H         name of adb server host [default=localhost]
 -P         port of adb server [default=5037]
 -L SOCKET  listen on given socket for adb server [default=tcp:localhost:5037]

general commands:
 devices [-l]             list connected devices (-l for long output)
 help                     show this help message
 version                  show version num

networking:
 connect HOST[:PORT]      connect to a device via TCP/IP [default port=5555]
 disconnect [HOST[:PORT]]
     disconnect from given TCP/IP device [default port=5555], or all
 forward --list           list all forward socket connections
 forward [--no-rebind] LOCAL REMOTE
     forward socket connection using:
       tcp:<port> (<local> may be "tcp:0" to pick any open port)
       localabstract:<unix domain socket name>
       localreserved:<unix domain socket name>
       localfilesystem:<unix domain socket name>
       dev:<character device name>
       jdwp:<process pid> (remote only)
 forward --remove LOCAL   remove specific forward socket connection
 forward --remove-all     remove all forward socket connections
 ppp TTY [PARAMETER...]   run PPP over USB
 reverse --list           list all reverse socket connections from device
 reverse [--no-rebind] REMOTE LOCAL
     reverse socket connection using:
       tcp:<port> (<remote> may be "tcp:0" to pick any open port)
       localabstract:<unix domain socket name>
       localreserved:<unix domain socket name>
       localfilesystem:<unix domain socket name>
 reverse --remove REMOTE  remove specific reverse socket connection
 reverse --remove-all     remove all reverse socket connections from device

file transfer:
 push [--sync] LOCAL... REMOTE
     copy local files/directories to device
     --sync: only push files that are newer on the host than the device
 pull [-a] REMOTE... LOCAL
     copy files/dirs from device
     -a: preserve file timestamp and mode
 sync [all|data|odm|oem|product_services|product|system|vendor]
     sync a local build from $ANDROID_PRODUCT_OUT to the device (default all)
     -l: list but don't copy

shell:
 shell [-e ESCAPE] [-n] [-Tt] [-x] [COMMAND...]
     run remote shell command (interactive shell if no command given)
     -e: choose escape character, or "none"; default '~'
     -n: don't read from stdin
     -T: disable PTY allocation
     -t: force PTY allocation
     -x: disable remote exit codes and stdout/stderr separation
 emu COMMAND              run emulator console command

app installation (see also `adb shell cmd package help`):
 install [-lrtsdg] [--instant] PACKAGE
     push a single package to the device and install it
 install-multiple [-lrtsdpg] [--instant] PACKAGE...
     push multiple APKs to the device for a single package and install them
 install-multi-package [-lrtsdpg] [--instant] PACKAGE...
     push one or more packages to the device and install them atomically
     -r: replace existing application
     -t: allow test packages
     -d: allow version code downgrade (debuggable packages only)
     -p: partial application install (install-multiple only)
     -g: grant all runtime permissions
     --instant: cause the app to be installed as an ephemeral install app
     --no-streaming: always push APK to device and invoke Package Manager as separate steps
     --streaming: force streaming APK directly into Package Manager
     --fastdeploy: use fast deploy
     --no-fastdeploy: prevent use of fast deploy
     --force-agent: force update of deployment agent when using fast deploy
     --date-check-agent: update deployment agent when local version is newer and using fast deploy
     --version-check-agent: update deployment agent when local version has different version code and using fast deploy
 uninstall [-k] PACKAGE
     remove this app package from the device
     '-k': keep the data and cache directories

backup/restore:
   to show usage run "adb shell bu help"

debugging:
 bugreport [PATH]
     write bugreport to given PATH [default=bugreport.zip];
     if PATH is a directory, the bug report is saved in that directory.
     devices that don't support zipped bug reports output to stdout.
 jdwp                     list pids of processes hosting a JDWP transport
 logcat                   show device log (logcat --help for more)

security:
 disable-verity           disable dm-verity checking on userdebug builds
 enable-verity            re-enable dm-verity checking on userdebug builds
 keygen FILE
     generate adb public/private key; private key stored in FILE,

scripting:
 wait-for[-TRANSPORT]-STATE
     wait for device to be in the given state
     State: device, recovery, sideload, or bootloader
     Transport: usb, local, or any [default=any]
 get-state                print offline | bootloader | device
 get-serialno             print <serial-number>
 get-devpath              print <device-path>
 remount [-R]
      remount partitions read-write. if a reboot is required, -R will
      will automatically reboot the device.
 reboot [bootloader|recovery|sideload|sideload-auto-reboot]
     reboot the device; defaults to booting system image but
     supports bootloader and recovery too. sideload reboots
     into recovery and automatically starts sideload mode,
     sideload-auto-reboot is the same but reboots after sideloading.
 sideload OTAPACKAGE      sideload the given full OTA package
 root                     restart adbd with root permissions
 unroot                   restart adbd without root permissions
 usb                      restart adbd listening on USB
 tcpip PORT               restart adbd listening on TCP on PORT

internal debugging:
 start-server             ensure that there is a server running
 kill-server              kill the server if it is running
 reconnect                kick connection from host side to force reconnect
 reconnect device         kick connection from device side to force reconnect
 reconnect offline        reset offline/unauthorized devices to force reconnect

environment variables:
 $ADB_TRACE
     comma-separated list of debug info to log:
     all,adb,sockets,packets,rwx,usb,sync,sysdeps,transport,jdwp
 $ADB_VENDOR_KEYS         colon-separated list of keys (files or directories)
 $ANDROID_SERIAL          serial number to connect to (see -s)
 $ANDROID_LOG_TAGS        tags to be used by logcat (see logcat --help)
```



## misc

schemas



**Q**: 一台台式电脑可以控制多少台手机？
**A**: 
ADB是服务通过扫描奇数端口5555 至5585查找  Android模拟器或设备。而且每个设备占用2个端口，偶数端口Android设备控制台，奇数端口Android与ADB的连接。如下：

 Note that each emulator/device instance acquires a pair of sequential ports — an even-numbered port for console connections and an odd-numbered port for adb connections. For example:

Emulator 1, console: 5554
Emulator 1, adb: 5555
Emulator 2, console: 5556
Emulator 2, adb: 5557 ...

那就是说，一个PC端的ADB最多同时连接 15台 Android设备（包括模拟器），超过15台的Android设备将不连接。



一、以太网共享有两个方向的理解：

1、通过以太网给android设备供网，对应设置中的Ethernet选项

2、android设备通过以太网给其它终端供网，对应设置中的便携式热点以太网共享-ethernet tethering

二、实现方法

通过adb shell settings list global 来获取设置项，


通过adb shell settings list global 来获取设置项，

ethernet_on就是以太网共享的设值，总共包括以下三个值

ethernet_on=1 表示关闭以太网共享。设置中的Ethernet 处于关闭状态，便携式热点的Ethernet tethering 处于关闭状态。此时既不能通过以太网给自己供网，也不能通过以太网给其它终端供网。

ethernet_on=2 表示以太网共享打开。设置中的Ethernet 处于打开状态，便携式热点的Ethernet tethering 处于关闭状态，此时android设备可以通过以太网上网

ethernet_on=3 表示以太网共享打开。设置中的Ethernet 处于关闭状态，便携式热点的Ethernet tethering 处于打开状态，此时上行4G或Wi-Fi可以通过以太网给其它的终端供网。

adb shell settings put global ethernet_on 2
