# idb



Windows环境下使用iOS指令

安装教程连接<https://testerhome.com/topics/15440>

常用指令：

1、idevice_id -l      查看当前连接设备的udid

2、ideviceinstaller -u [udid] -i [安装包路径]     给指定的设备安装应用

3、ideviceinstaller -u [udid] -U [bundleId]     给指定设备卸载应用

4、ideviceinstaller -u [udid] -l        查看安装的第三方应用

   ideviceinstaller -u [udid] -l -o list_system     查看安装的系统应用

   ideviceinstaller -u [udid] -l -o list_user       查看安装的第三方应用

   ideviceinstaller -u [udid] -l -o list_all         查看安装的所有应用

5、ideviceinfo -u [udid]       查看指定设备的信息

6、idevicescreenshot.exe  C:\Users\admin\Desktop\123.png   截图

7、idevicesyslog  > C:\Users\admin\Desktop\ log.txt    获取日志





1、[idb](https://link.juejin.im/?target=https%3A%2F%2Fgithub.com%2Ffacebook%2Fidb)顾名思义，iOS 版本的 `adb`。这款 Facebook 开发的命令行工具可助你自动化在模拟器和真机上的调试流程。

<https://github.com/facebook/idb>

2、[InAppViewDebugger](https://link.juejin.im/?target=https%3A%2F%2Fgithub.com%2Findragiek%2FInAppViewDebugger)供内嵌于应用的视图调试器。类似 Xcode 视图调试器，但可以在 iPad 和 iPhone 上调试视图。

<https://github.com/indragiek/InAppViewDebugger>

3、[MTHawkeye](https://link.juejin.im/?target=https%3A%2F%2Fgithub.com%2Fmeitu%2FMTHawkeye)美图秀秀开源的 iOS 调试优化辅助工具集。内置插件有 LivingObjectSniffer （跟踪对象）、Allocations（跟踪实时分配内存）、UITimeProfiler（主线程耗时任务调优）、ANRTrace（捕获卡顿事件）、FPSTrace（跟踪界面 FPS 及 OpenGL 刷新绘制 FPS）、CPUTrace（跟踪 CPU 持续高使用率）、NetworkMonitor（监听记录应用内 HTTP(S) 网络请求各阶段耗时）、NetworkInspect（基于 Network Monitor 推荐可优化项，支持自定义规则）、OpengGLTrace（跟踪 OpenGL 资源内存占用）、DirectoryWatcher（跟踪沙盒文件夹大小）、FLEX（沙盒文件 AirDrop）。开发者可基于基础框架 API 开发自己的调试辅助插件。

 

1. [PonyDebugger](https://link.jianshu.com/?t=https://github.com/square/PonyDebugger)大家有耳熟能详，功能丰富，但其繁琐的配置过程，也提升了一定的Debug成本。
2. [Alpha](https://link.jianshu.com/?t=https://github.com/Legoless/Alpha)作为FLEX的后继者更具有灵活性，调用可以灵活定制需要接入的Debug功能，且DEBUG内容也更加丰富。
3. [FLEX](https://link.jianshu.com/?t=https://github.com/Flipboard/FLEX)Flipboard公司出品的iOS调试工具。



libimobiledevice，这是一个开源包，可以让Linux支持连接iPhone/iPodTouch 等iOS设备，可以替代iTunes，进行iOS设备管理的工具。另外libimobiledevice是开源工具，项目地址在 https://github.com/libimobiledevice/libimobiledevice（官网：http: //www.libimobiledevice.org/）

ideviceinstaller工具，用于给iOS设备安装卸载应用或者备份应用。该工具是基于libmobiledevice的，因此首先要完成 libmobiledevice的编译安装。另外需要用到libzip，也可以通过homebrew来下载安装。ideviceinstaller的工程 地址：

```

https://github.com/libimobiledevice/ideviceinstaller.git

下载完工程后执行编译安装，步骤同libimobiledevice一致。
```