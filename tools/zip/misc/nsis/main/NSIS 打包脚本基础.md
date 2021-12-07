# [NSIS 打包脚本基础](https://www.cnblogs.com/jingmoxukong/p/5033622.html)





> **目录**
>
> [简介](https://www.cnblogs.com/jingmoxukong/p/5033622.html#简介)
> [  工具：](https://www.cnblogs.com/jingmoxukong/p/5033622.html#工具：)
> [脚本结构](https://www.cnblogs.com/jingmoxukong/p/5033622.html#脚本结构)
> [  属性](https://www.cnblogs.com/jingmoxukong/p/5033622.html#属性)
> [  页面](https://www.cnblogs.com/jingmoxukong/p/5033622.html#页面)
> [  区段](https://www.cnblogs.com/jingmoxukong/p/5033622.html#区段)
> [  函数](https://www.cnblogs.com/jingmoxukong/p/5033622.html#函数)
> [基本语法](https://www.cnblogs.com/jingmoxukong/p/5033622.html#基本语法)
> [  变量](https://www.cnblogs.com/jingmoxukong/p/5033622.html#变量)
> [  编译器指令](https://www.cnblogs.com/jingmoxukong/p/5033622.html#编译器指令)
> [参考](https://www.cnblogs.com/jingmoxukong/p/5033622.html#参考)

# 简介

NSIS（Nullsoft Scriptable Install System）是一个开源的 Windows 系统下安装程序制作程序。它提供了安装、卸载、系统设置、文件解压缩等功能。这如其名字所指出的那样，NSIS 是通过它的脚本语言来描述安装程序的行为和逻辑的。NSIS 的脚本语言和通常的编程语言有类似的结构和语法，但它是为安装程序这类应用所设计的。

## 工具：

HW VNISEdit（NSIS脚本编辑器）

1、 使用编辑器中NSIS脚本向导功能，自动生成对应的nsi脚本。

点击文件->新建脚本：向导，接下来根据向导页面的设置选项一步步设置你需要的安装条件。

![img](https://images2015.cnblogs.com/blog/318837/201512/318837-20151209174918449-970374979.png)

 

2、也可以在编辑器中编写nsi脚本，然后再编译生成exe安装包文件。

 

# 脚本结构

NSIS脚本(下称nsi脚本)主要包含安装程序属性、页面、区段、函数。

 

## 属性

用来定义安装程序的行为和界面风格，这些属性大部分是编译时刻属性，即不能在运行时刻改变。

 

## 页面

安装程序的向导页面

例：



 

## 区段

是对应某种安装/卸载选项的处理逻辑，该段代码仅当用户选择相应的选项才被执行。卸载程序的区段名用"un."作为前缀。

例：



 

区段名的修饰符/o表示该区段默认不选上，-表示隐藏区段(匿名区段也是隐藏区段)，！表示需要粗体显示的区段。

SectionIn表示该区段和安装类型之间的关系

SubSection表示子区段



 

## 函数

包含了模块化的安装逻辑。

在nsi脚本中函数分为两种：用户自定义函数和回调函数。

### 用户自定义函数

用户自定义函数仅当是Call指令调用时才被执行，如果函数体中没有abort语句，则安装程序执行完了用户自定义函数，继续运行Call语句和指令。

用户自定义函数的语法：



 

### 回调函数

回调函数则是由在特定的时间点触发的程序段。

例：



 

#### 安装逻辑回调函数

NSIS对于**安装逻辑定义以下回调函数：**

.onGUIInit、.onInit、.onInstFailed、.onInstSuccess、.onGUIEnd、.onMouseOverSection、.onRebootFailed、.onSelChange、.onUserAbort、.onVerifyInstDir



#### 卸载逻辑回调函数

NSIS对于**卸载逻辑定义以下回调函数：**
un.onGUIInit、un.onInit、un.onUninstFailed、un.onUninstSuccess、un.onGUIEnd、un.onRebootFailed、un.onUserAbort

# 基本语法

## 变量

nsi脚本用var关键字来定义变量，使用$来引用变量。

注意：变量是全局的并且是大小写敏感的。

除了用户自定义的变量外，nsi脚本中定义了寄存器变量0 0 9,R0 R0 R9用于参数传递，以及系统变量用于特定用途，这些变量主要有：

$INSTDIR
用户定义的解压路径。
$PROGRAMFILES
程序文件目录(通常为 C:\Program Files 但是运行时会检测)。
$COMMONFILES
公用文件目录。这是应用程序共享组件的目录(通常为 C:\Program Files\Common Files 但是运行时会检测)。
$DESKTOP
Windows 桌面目录(通常为 C:\windows\desktop 但是运行时会检测)。该常量的内容(所有用户或当前用户)取决于 SetShellVarContext 设置。默认为当前用户。
$EXEDIR
安装程序运行时的位置。(从技术上来说你可以修改改变量，但并不是一个好方法)。
${NSISDIR}
包含 NSIS 安装目录的一个标记。在编译时会检测到。常用于在你想调用一个在 NSIS 目录下的资源时，例如：图标、界面……
$WINDIR
Windows 目录(通常为 C:\windows 或 C:\winnt 但在运行时会检测)
$SYSDIR
Windows 系统目录(通常为 C:\windows\system 或 C:\winnt\system32 但在运行时会检测)
$TEMP
系统临时目录(通常为 C:\windows\temp 但在运行时会检测)
$STARTMENU
开始菜单目录(常用于添加一个开始菜单项，使用 CreateShortCut)。该常量的内容(所有用户或当前用户)取决于 SetShellVarContext 设置。默认为当前用户。
$SMPROGRAMS
开始菜单程序目录(当你想定位 $STARTMENU\程序 时可以使用它)。该常量的内容(所有用户或当前用户)取决于 SetShellVarContext 设置。默认为当前用户。
$SMSTARTUP
开始菜单程序/启动 目录。该常量的内容(所有用户或当前用户)取决于 SetShellVarContext 设置。默认为当前用户。
$QUICKLAUNCH
在 IE4 活动桌面及以上的快速启动目录。如果快速启动不可用，仅仅返回和 $TEMP 一样。
$DOCUMENTS
文档目录。一个当前用户典型的路径形如 C:\Documents and Settings\Foo\My Documents。这个常量的内容(所有用户或当前用户)取决于 SetShellVarContext 设置。默认为当前用户。
该常量在 Windows 95 且 Internet Explorer 4 没有安装时无效。
$SENDTO
该目录包含了“发送到”菜单快捷项。
$RECENT
该目录包含了指向用户最近文档的快捷方式。
$FAVORITES
该目录包含了指向用户网络收藏夹、文档等的快捷方式。这个常量的内容(所有用户或当前用户)取决于 SetShellVarContext 设置。默认为当前用户。
该常量在 Windows 95 且 Internet Explorer 4 没有安装时无效。
$MUSIC
用户的音乐文件目录。这个常量的内容(所有用户或当前用户)取决于 SetShellVarContext 设置。默认为当前用户。
该常量仅在 Windows XP、ME 及以上才有效。
$PICTURES
用户的图片目录。这个常量的内容(所有用户或当前用户)取决于 SetShellVarContext 设置。默认为当前用户。
该常量仅在 Windows 2000、XP、ME 及以上才有效。
$VIDEOS
用户的视频文件目录。这个常量的内容(所有用户或当前用户)取决于 SetShellVarContext 设置。默认为当前用户。
该常量仅在 Windows XP、ME 及以上才有效。
$NETHOOD
该目录包含了可能存在于我的网络位置、网上邻居文件夹的链接对象。
该常量在 Windows 95 且 Internet Explorer 4 和活动桌面没有安装时无效。
$FONTS
系统字体目录。
$TEMPLATES
文档模板目录。这个常量的内容(所有用户或当前用户)取决于 SetShellVarContext 设置。默认为当前用户。
$APPDATA
应用程序数据目录。当前用户路径的检测需要 Internet Explorer 4 及以上。所有用户路径的检测需要 Internet Explorer 5 及以上。这个常量的内容(所有用户或当前用户)取决于 SetShellVarContext 设置。默认为当前用户。
该常量在 Windows 95 且 Internet Explorer 4 和活动桌面没有安装时无效。
$PRINTHOOD
该目录包含了可能存在于打印机文件夹的链接对象。
该常量在 Windows 95 和 Windows 98 上无效。
$INTERNET_CACHE
Internet Explorer 的临时文件目录。
该常量在 Windows 95 和 Windows NT 且 Internet Explorer 4 和活动桌面没有安装时无效。
$COOKIES
Internet Explorer 的 Cookies 目录。
该常量在 Windows 95 和 Windows NT 且 Internet Explorer 4 和活动桌面没有安装时无效。
$HISTORY
Internet Explorer 的历史记录目录。
该常量在 Windows 95 和 Windows NT 且 Internet Explorer 4 和活动桌面没有安装时无效。
$PROFILE
用户的个人配置目录。一个典型的路径如 C:\Documents and Settings\Foo。
该常量在 Windows 2000 及以上有效。
$ADMINTOOLS
一个保存管理工具的目录。这个常量的内容(所有用户或当前用户)取决于 SetShellVarContext 设置。默认为当前用户。
该常量在 Windows 2000、ME 及以上有效。
$RESOURCES
该资源目录保存了主题和其他 Windows 资源(通常为 C:\Windows\Resources 但在运行时会检测)。
该常量在 Windows XP 及以上有效。
$RESOURCES_LOCALIZED
该本地的资源目录保存了主题和其他 Windows 资源(通常为 C:\Windows\Resources\1033 但在运行时会检测)。
该常量在 Windows XP 及以上有效。
$CDBURN_AREA
一个在烧录 CD 时储存文件的目录。.
该常量在 Windows XP 及以上有效。
$HWNDPARENT
父窗口的十进制 HWND。
$PLUGINSDIR
该路径是一个临时目录，当第一次使用一个插件或一个调用 InitPluginsDir 时被创建。该文件夹当解压包退出时会被自动删除。这个文件夹的用意是用来保存给 InstallOptions 使用的 INI 文件、启动画面位图或其他插件运行需要的文件。



## 编译器指令

nsi脚本的编译器指令主要指仅在编译时刻执行的命令。这些命令主要用来包含文件、条件化编译、定义常量、定义宏等。定义常量和宏是编译器指令的最主要应用。

 

### 常用指令

#### 文件、目录操作

File

**作用：**释放文件到当前输出路径。

如果使用了 /nonfatal 开关且当文件未找到时使用警告来代替错误

如果使用了 /a 开关，则被添加的文件的属性将会保持

如果使用了 /r 开关，匹配的文件将会在子目录里被递归的搜索。如果目录名匹配则所有包含的内容都会被递归添加，目录结构也会被保持

使用 /x 开关可以用来来排除文件或目录

例：

将ProjectFiles目录下的所有文件释放到输出目录



 

Delete

**作用：**从目标系统删除文件

例：删除文件



 

Rename

**作用：**把源文件重命名为目标文件

例：

重命名文件



 

CreateDirectory

**作用：**创建 (递归创建) 指定的目录。当目录不能创建时会放置一个错误标记。你也可以指定一个绝对路径。

例：在默认Program Files目录下创建一个Temp目录



 

RMDir

**作用：**删除目录

例：

删除Resources及其子目录



 

SetOutPath

**作用：**设置输出路径($OUTDIR)且当路径不存在时创建(需要时会递归创建)。必须为绝对路径名，通常都使用 $INSTDIR。

例：

将用户定义的解压路径作为输出目录



 

CreateShortCut

**作用：**创建快捷文件.lnk 目标文件

例：

设置Test.exe的快捷方式Test.lnk，图标为Test.ico。



 

#### 注册表操作

WriteRegStr、WriteRegExpandStr

**作用：**把字符串写入注册表。根键必须为下面列表之一：

HKCR 或 HKEY_CLASSES_ROOT

HKLM 或HKEY_LOCAL_MACHINE

HKCU 或HKEY_CURRENT_USER

HKU 或HKEY_USERS

HKCC 或HKEY_CURRENT_CONFIG

HKDD 或HKEY_DYN_DATA

HKPD 或HKEY_PERFORMANCE_DATA

SHCTX 或SHELL_CONTEXT

如果字串不能写入注册表则放置一个错误的标记。字串的类型为 REG_SZ 对应 WriteRegStr，或 REG_EXPAND_STR 对应 WriteRegExpandStr。如果注册表键不存在则会自动创建。

例：

将程序信息写入注册表



 

ReadRegDWORD

作用：读取注册表信息

例：

在注册表中读取.net 版本



 

DeleteRegKey

**作用：**删除一个注册表键。如果指定了 /ifempty，则该注册表键仅当它无子键时才会被删除(否则，整个注册表键将被删除)。有效的根键值在后面的 WriteRegStr 列出。如果该键不能被删除(或如果它不存在)则会放置一个错误的标记。

例：

清除注册表信息



 

#### INI文件操作

ReadINIStr 用户变量(输出) INI文件 区段 项

 

**作用：**读取INI文件。从 “INI文件” 的 “区段” 区段读取 “项” 的值并把该值输出到用户变量。如果该项未找到时会放置一个错误标记且该用户变量被赋为空值。

例：

读取TimeZoneZh.ini文件中Field 1区段的State项，将值输出到$0



 

#### 外部调用

ReserveFile

**作用：**把文件保存在稍后使用的数据区块用于下面的调用。有时，预先打包文件，方便安装加速释放之用。

例：



 

Exec

**作用：**这应该算是常用的命令了,执行一个指定的程序并且立即继续安装,就是直接执行一个程序。

例：

安装Microsoft.NET.exe，程序不等待继续执行下个步骤。



 

ExecWait

**作用：**执行一个指定的程序并且等待运行处理结束。

例：

静默安装Microsoft.Net.exe安装包，并等待安装包运行结束。



 

RegDLL

**作用：**载入指定的 DLL 并且调用 DllRegisterServer (或入口点名称，当指定之后)。当产生一个错误的时候会置一个错误标记(例如不能载入 DLL，不能初始化 OLE，不能找到入口点，或者函数返回任何其它错误 ERROR_SUCCESS (=0))。

其实就是注册或加载你要的插件!

例：

注册TIMProxy.dll插件



 

UnRegDLL

**作用：**注销DLL插件

例：

注销TIMProxy.dll插件



 

!include

**作用：**包含头文件

例：

引用"MUI.nsh"头文件



 

!insertmacro

**作用：**插入宏

例：

通过宏插入欢迎页面



 

#### 字符串操作

StrCpy

**作用：**复制字符串

StrCpy $0 "a bbbbbbbb" 就有$0 = "a bbbbbbbb"

StrCpy $0 "a bbbbbbbb" 3就有$0 = "a b"

 

StrCmp

**作用：**比较(不区分大小写)“字串1”和“字串2”，如果两者相等，跳转到“相同时跳转的标记”，否则跳转到“不相同时跳转的标记”。

 

#### 逻辑操作

Push

**作用：**把一个字串压入堆栈，该字串可随后从堆栈里弹出。

 

Pop

**作用：**从堆栈里弹出一个字串到用户变量 $x。如果堆栈是空的，则会置一个错误标记。

 

if

（1） IfAbort 退出时要跳转的标记 [不是退出时要跳转的标记]

如果调用退出时它将返回 true

（2） IfErrors 错误时跳转的标记 [没有错误时跳转的标记]

检测并清除错误标记，如果设了错误标记，则跳转到“错误时跳转的标记”，否则跳转到“没有错误时跳转的标记”。

（3）IfFileExists 要检测的文件 文件存在时跳转的标记 [文件不存在时跳转的标记]

检测“要检测的文件”是否存在(可以用通配符，或目录)，并当文件存在时跳转到“文件存在时跳转”，否则跳转到“文件不存在时跳转”。

 

Goto

**作用：**跳转到指定标记。nsi脚本常常使用相对跳转表示条件分枝，其语法是[+-][1-9]，加号表示从当前位置往前跳转，减号则表示从当前位置往后跳转。数字表示跳转的语句条数。

例：

按数字跳转



例：

按标记跳转



 

MessageBox

**作用：**显示一个包含“消息框文本”的消息框。“消息框选项列表”必须为下面的一个或多个，多个使用 | 来隔开。

MB_OK - 显示 OK 按钮

MB_OKCANCEL - 显示 OK 和取消按钮

MB_ABORTRETRYIGNORE - 显示退出、重试、忽略按钮

MB_RETRYCANCEL - 显示重试和取消按钮

MB_YESNO - 显示是和否按钮

MB_YESNOCANCEL - 显示是、否、取消按钮

MB_ICONEXCLAMATION - 显示惊叹号图标

MB_ICONINFORMATION - 显示信息图标

MB_ICONQUESTION - 显示问号图标

MB_ICONSTOP - 显示终止图标

MB_TOPMOST - 使消息框在最前端显示

MB_SETFOREGROUND - 设置前景

MB_RIGHT - 右对齐文本

MB_RTLREADING - RTL 阅读次序

MB_DEFBUTTON1 - 默认为按钮 1

MB_DEFBUTTON2 - 默认为按钮 2

MB_DEFBUTTON3 - 默认为按钮 3

MB_DEFBUTTON4 - 默认为按钮 4

 

# 参考

官方论坛：http://forums.winamp.com/forumdisplay.php?s=&forumid=65

NSIS中文论坛：http://www.nsisfans.com/

轻狂志博客（NSIS大神）：http://www.flighty.cn/html/bushu/index.html

作者：[静默虚空](http://www.cnblogs.com/jingmoxukong/)
欢迎任何形式的转载，但请务必注明出处。
限于本人水平，如果文章和代码有表述不当之处，还请不吝赐教。



分类: [开发工具](https://www.cnblogs.com/jingmoxukong/category/315717.html)

标签: [NSIS](https://www.cnblogs.com/jingmoxukong/tag/NSIS/), [打包](https://www.cnblogs.com/jingmoxukong/tag/打包/), [安装包](https://www.cnblogs.com/jingmoxukong/tag/安装包/), [windows](https://www.cnblogs.com/jingmoxukong/tag/windows/)