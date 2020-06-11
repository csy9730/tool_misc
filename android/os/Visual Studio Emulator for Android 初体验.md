# [Visual Studio Emulator for Android 初体验](https://www.cnblogs.com/chengyujia/p/5093172.html)

Visual Studio Emulator for Android已经推出一段时间了，但一直没有用过。前两天下载安装用了下，整体感觉比谷歌自带的模拟器强多了。Visual Studio Emulator for Android沿袭了windows phone模拟器的优良传统，流畅程度和真机差不多。

下面是安装和使用的一些记录

1.安装前需要先启用Hyper-V，这个和windows phone 8 模拟器的要求一样。首先需要确认一下电脑是否支持Hyper-V，如果是intel的CPU至少需要是i3。另外需要注意的是有些电脑虽然支持Hyper-V，但在BIOS中默认没有开启，这就需要先进入BIOS中开启才行。然后再在控制面板中的“启用或关闭windows功能”中勾选Hyper-V，之后还需要重启一下电脑。

2.官网地址https://www.visualstudio.com/en-us/msft-android-emulator-vs.aspx

下载vs_emulatorsetup.exe 下载速度还是挺快的。

3.安装好后打开模拟器管理界面，下面是截图

![img](https://images2015.cnblogs.com/blog/343777/201601/343777-20160101111846901-855502060.png)

默认安装了两个4.4版本的模拟器，其它的需要先下载才能使用，我下了一个4.2的Nexus S，下载也挺快。从左上角的下拉框中可以看到，目前提供的模拟器最高API Level 是23，最低API Level 是17，一般开发够用了。

4.上图中有绿色小三角的就是已经下载好的，点击一下模拟器就启动了，启动过程大概需要1分钟。下面是启动后的截图：

![img](https://images2015.cnblogs.com/blog/343777/201601/343777-20160101113951776-2116102915.jpg)

点击上图中右边控制栏中的“>>”可以打开附加工具，截图如下：

![img](https://images2015.cnblogs.com/blog/343777/201601/343777-20160101114449120-944031454.png)

可以看到附加工具中有7大功能，这里测试了一下截图功能，挺好用的。

5.下面我在adt-bundle中写了个demo想在这个模拟器中运行一下，结果发现ADB找不到这个模拟器。这是为什么呢？在msdn上找到了答案https://msdn.microsoft.com/en-us/library/mt228282.aspx#ADB。原来是微软的安卓模拟器需要知道本机上的Android SDK的文件夹路径，知道了这个路径，它就能找到ADB，并告诉ADB自己已经启动，可以用了。怎样设置这里路径呢？需要在注册表中设置，打开注册表，在左边的目录树中找到HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Android SDK Tools这个文件夹，在这个文件夹下找到名为Path的键，修改其值为你本机上的Android SDK的文件夹路径。如果注册表中没有Android SDK Tools文件夹或没有Path键，新建即可。

6.使用的过程中发现还是有一些bug的，比如中文输入法问题，打开系统自带了谷歌拼音输入法，只要在屏幕上滑动就会自动启动输入法，不断的输出"c"，截图如下：

![img](https://images2015.cnblogs.com/blog/343777/201601/343777-20160101121947385-463974484.png)

暂时先写这些吧，后续使用有什么问题再补充。:)