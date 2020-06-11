# Visual Studio Emulator for Android 
下面是安装和使用的一些记录

1.安装前需要先启用Hyper-V，这个和windows phone 8 模拟器的要求一样。首先需要确认一下电脑是否支持Hyper-V，如果是intel的CPU至少需要是i3。另外需要注意的是有些电脑虽然支持Hyper-V，但在BIOS中默认没有开启，这就需要先进入BIOS中开启才行。然后再在控制面板中的“启用或关闭windows功能”中勾选Hyper-V，之后还需要重启一下电脑。

2.官网地址[android-mulator](https://www.visualstudio.com/en-us/msft-android-emulator-vs.aspx)

下载vs_emulatorsetup.exe 下载速度还是挺快的。

3.安装好后打开模拟器管理器界面，

`C:\Program Files (x86)\Microsoft Emulator Manager\1.0\emulatormgr.exe`
下面是截图


通过hyperV打开，会出现安卓系统的命令行。

打开模拟器界面
`C:\Program Files (x86)\Microsoft XDE\10.0.10586.0\XDE.exe`


需要安装adb.exe，然后通过拖放文件实现安装程序


### 如何设置联网


### 如何安装app
