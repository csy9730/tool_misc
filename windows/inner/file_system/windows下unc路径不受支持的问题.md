# windows下unc路径不受支持的问题

[TOC]

## 前言

UNC（Universal Naming Convention）

[通用命名规则](https://baike.baidu.com/item/通用命名规则/4356637)，也称通用命名规范、通用命名约定。

UNC为网络（主要指局域网）上资源的完整Windows 2000名称。

1：什么是UNC路径？UNC路径就是类似\\softer这样的形式的网络路径。

2：UNC为网络（主要指局域网）上资源的完整Windows 2000名称。

格式：\\servername\sharename，其中servername是服务器名。sharename是共享资源的名称。

目录或文件的UNC名称可以包括共享名称下的目录路径，格式为：\\servername\sharename\directory\filename。

2：unc共享就是指[网络硬盘](https://baike.baidu.com/item/网络硬盘)的共享：

当访问softer计算机中名为it168的[共享文件夹](https://baike.baidu.com/item/共享文件夹)，用UNC表示就是\\softer\it168；如果是softer计算机的默认管理共享C$则用\\softer\c$来表示。

我们访问[网上邻居](https://baike.baidu.com/item/网上邻居)所采用的命令行访问法，实际上应该称作UNC路径访问法。





昨天我想访问同一个局域网内其他人共享的文件夹，用cmd命令访问不了，报错：cmd不支持将UNC 路径。



## 正文

解决办法：在“计算机”上点击右键，选择“映射网络驱动器”，在弹出的对话框中设置“驱动器”名称，如“Z:”；



![img](https://upload-images.jianshu.io/upload_images/15182918-5deafa63f3774669.png?imageMogr2/auto-orient/strip|imageView2/2/w/628/format/webp)

微信截图_20181129100616.png

然后你可以用cd /d Z:命令来访问了，如下：



![img](https://upload-images.jianshu.io/upload_images/15182918-2a324e6070cd4519.png?imageMogr2/auto-orient/strip|imageView2/2/w/677/format/webp)

微信截图_20181129100708.png





## 解决UNC路径不受支持问题 补充

今天在我的win7系统中在一个共享文件路径中执行bat脚本遇到了如下的错误提示：

![img](https://img.jbzj.com/file_images/article/201809/20180907170428.png)

内容就是：

用作为当前目录的以上路径启动了 CMD.EXE。 UNC 路径不受支持。默认值设为 Windows 目录。

出现的原因：

估计是因为在 网络路径 下所致，如果在普通目录下就没这种问题。

**解决方法:**

在注册表中,添加一个值即可.路径如下:
HKEY_CURRENT_USER\Software\Microsoft\Command Processor
添加值 DisableUNCCheck， 类型为 REG_DWORD 并将该值设置为1 （十六进制）。

批处理文件如下：（虽然运行的时候会有正确提示，但是实际上却没加进去还需要修改）

> reg add "HKEY_CURRENT_USER\Software\Microsoft\Command Processor" /v "DisableUNCCheck" /t "REG_DWORD" /d "1" /f



## pushd

打开网上邻居→整个网络→Microsofi Windows Network→在工作组找到本机对应的电脑，双击测试以下批处理代码：
显示当前目录.bat

```
cd /d %~dp0
echo` `%``
cd``%` `
pushd` `%~dp0
echo` `%``
cd``%``
popd
pause
```


可以看到，在开始使用cd命令跳转到UNC目录时，会出现"CMD 不支持将 UNC 路径作为当前目录。"的提示，即cd命令只能在本地目录跳转，却不能跳转到UNC目录。

那如何是好？看第二个命令：pushd，使用"pushd %~dp0"可以将UNC路径映射成本地的Z盘，执行该命令后，下一个提示符就不是原来的C:\>，而是Z:\>，即已经映射成功的UNC路径。

这时，就可以像操作本地目录一样操作UNC目录了（实际上在“我的电脑”中会出现一个Z盘的映射，相当于本地硬盘）。如图中所示，cd、dir等命令均可以使用。

最后，在执行完操作后，别忘了使用popd将映射断开。断开后，提示符又变成了原来的C:\Windows>。

另外一个更好的解决办法：直接在批处理所在的目录前面加上变量%~dp0即可。无论是调用批处理名字，还是拷贝，都可以。
但是要注意，一般地文件共享是只读共享，UNC目录不可写，因此echo >file1.txt这样的语句，fiel1.txt前面不要加%~dp0，默认用C:\windows目录即可。