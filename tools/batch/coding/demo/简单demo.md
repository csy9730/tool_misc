# demo

## 内涵图

可以实现内涵图：把图片和压缩文件保存在一起
``` batch
copy "src.jpg"+"src2.zip" "dst.jpg"
rem xcopy "src" "dst" /i /s
```


## 改变编码方式
1、打开CMD.exe 命令行窗口
2、通过chcp 命令改变代码页，UTF-8 的代码页为65001，`chcp 65001` 执行该操作后，代码页就被变成UTF-8 了。但是，在窗口中仍旧不能正确显示UTF-8 字符。
3、修改窗口属性，改变字体在命令行标题栏上点击右键，选择”属性”->”字体”，将字体修改为True Type字体”Lucida Console”，然后点击确定将属性应用到当前窗口。
``` batch
rem 就是换成UTF-8 代码页
chcp 65001 

rem 可以换回默认的GBK
chcp 936 

rem 美国英语
chcp 437 
```

注意事项：
1.无法通过建立快捷方式的方法来快速切换到这种窗口模式（无法修改codepage 为65001，Lucida Console 字体只有在code page 设为65001 后才能选择）！
2.这种状态下的控制台调用不了.bat 脚本！


## 一键修改IP
Win7+xp 命令行一键修改IP、DNS
第一步：新建一个txt 文件
第二步：在文件中添加如下内容：
``` batch
netsh interface ip set address name="本地连接" source=static addr=10.60.37.99 mask=255.255.255.0gateway=10.60.37.254
netsh interface ip set dns "本地连接" source=static addr=202.120.190.208
```

4 个红色的部分需要我们根据需要修改：
10.60.37.99 是IP 地址
255.255.255.0 是掩码地址
10.60.37.254 是默认网关
202.120.190.208 是DNS
第三步：将txt 文件的后缀由.txt 改为.cmd
第四步：右键点击.cmd 文件，选择“以管理员身份运行”

如果想改回DHCP(自动获取IP 和DNS)，
只需创建一个新的cmd 文件，内容为：
``` batch
netsh interface ip set address name="本地连接" source=dhcp
netsh interface ip set dns name="本地连接" source=dhcp
```
XP 中的指令稍有不同：
``` batch
netsh interface ip set address name="本地连接" source=static addr=10.60.37.96 mask=255.255.255.0
netsh interface ip set address name="本地连接" gateway=10.60.37.254 gwmetric=0
netsh interface ip set dns "本地连接" source=static addr=202.120.190.208
``` 

## 一键开启wifi
电脑开启wifi：服务开启，cmd 口令，
``` batch
netsh wlan set hostednetwork mode=allow ssid=ABC-PC key=12333333
pause
netsh wlan start hostednetwork
pause
netsh wlan stop hostednetwork
```


## 一键备份
``` batch
CLS
@echo off
title auto bak directory
set src="abc3"
set dsc="bak2\"
echo "source directory= %src% ,destination directory = %dsc% "
if not exist %dsc% (mkdir %dsc%)
if not exist "%dsc%bakCount.txt" ( echo 0 >"%dsc%bakCount.txt" )
set /p var=< "%dsc%bakCount.txt"
set /a var=var+1
echo %var%
echo d |(xcopy "%src%" "%dsc%%src%" /s)
ren "%dsc%%src%" "%src%_%var%"
rem xcopy %src% "%dsc%%src%%var%"
echo %var% >"%dsc%bakCount.txt"
echo "%var%:%date%%time%">>"%dsc%bakDate.txt"
pause
exit
```

## 批量文件编辑
SOP：批量复制指定目录下得jpg 后缀文件。
在命令提示符（cmd）中输入：
``` batch
for /f %i in ('dir "d:\pcdesktop\*.jpg" /s /b') do copy "%i" "f:\hello"
rem 我这里的指定文件夹为"f:\hello"，一定要确保指定文件夹是存在的
```
如果在.bat 脚本中输入，会有如下改变：
``` batch
for /f %%i in ('dir "d:\pcdesktop\*.jpg" /s /b') do copy "%%i" "f:\hello"
for /f "tokens=*"%i in ('dir "d:\pcdesktop\*.jpg" /s /b') do copy "%i" "f:\hello"
```

* Tips： for 脚本用使用%%i，命令行使用%i 。
* 路径名文件名有空格时会出错，使用“”包括。
  
``` batch
cd "F:\Jmgo\Books\Foreign\且听风吟"
dir
rem 批量添加前缀名，批量添加后缀名
for /f %%i in ('dir /b *.txt') do (ren %%i 且听风吟_%%i)
pause
cmd
rem 批量复制到指定路径
@echo off
cd /d e:\
for /f "tokens=*" %%d in ('dir /ad /s /b ^| findstr /i "input"') do (
xcopy "%%d" C:\Temp\data /s /i /y /h)
```



### 交互界面设计
看看高手设计的菜单界面吧：
``` batch
@echo off
cls
title 终极多功能修复
:menu
cls
color 0A
echo.
echo                 ==============================
echo                 请选择要进行的操作，然后按回车
echo                 ==============================
echo.
echo              1.网络修复及上网相关设置,修复IE,自定义屏蔽网站
echo.
echo              2.病毒专杀工具，端口关闭工具,关闭自动播放
echo.
echo              3.清除所有多余的自启动项目，修复系统错误
echo.
echo              4.清理系统垃圾,提高启动速度
echo.
echo              Q.退出
echo.
echo.
:cho
set choice=
set /p choice=          请选择:
IF NOT "%choice%"=="" SET choice=%choice:~0,1%
if /i "%choice%"=="1" goto ip
if /i "%choice%"=="2" goto setsave
if /i "%choice%"=="3" goto kaiji
if /i "%choice%"=="4" goto clean
if /i "%choice%"=="Q" goto endd
echo 选择无效，请重新输入
echo.
goto cho
```
只要学完本教程前面的章节，上面的程序应该能看懂了。



### 调用VBScript程序
使用 Windows 脚本宿主，可以在命令提示符下运行脚本。CScript.exe 提供了用于设置脚本属性的命令行开关。

```
用法：CScript 脚本名称 [脚本选项...] [脚本参数...]
选项：
//B         批模式：不显示脚本错误及提示信息
//D         启用 Active Debugging
//E:engine  使用执行脚本的引擎
//H:CScript 将默认的脚本宿主改为 CScript.exe
//H:WScript 将默认的脚本宿主改为 WScript.exe （默认）
//I         交互模式（默认，与 //B 相对)
//Job:xxxx  执行一个 WSF 工作
//Logo      显示徽标（默认）
//Nologo    不显示徽标：执行时不显示标志
//S         为该用户保存当前命令行选项
//T:nn      超时设定秒：允许脚本运行的最长时间
//X         在调试器中执行脚本
//U         用 Unicode 表示来自控制台的重定向 I/O
```
“脚本名称”是带有扩展名和必需的路径信息的脚本文件名称，如d:\admin\vbscripts\chart.vbs。
“脚本选项和参数”将传递给脚本。脚本参数前面有一个斜杠 (/)。每个参数都是可选的；但不能在未指定脚本名称的情况下指定脚本选项。如果未指定参数，则 CScript 将显示 CScript 语法和有效的宿主参数。



### 时间延迟
本条引用[英雄]教程
什么是时间延迟？顾名思义，就是执行一条命令后延迟一段时间再进行下一条命令。
1、利用ping命令延时
例：
``` batch
  @echo off
  echo 延时前！
  ping /n 3 127.0.0.1 >nul
  echo 延时后！
  pause 
```
解说：用到了ping命令的“/n”参数，表示要发送多少次请求到指定的ip。本例中要发送3次请求到本机的ip
（127.0.0.1）。127.0.0.1可简写为127.1。“>nul”就是屏蔽掉ping命令所显示的内容。
2、利用for命令延时
例：
``` batch
  @echo off
  echo 延时前！
  for /l %%i in (1,1,5000) do echo %%i>nul
  echo 延时后！
  pause
```
解说：原理很简单，就是利用一个计次循环并屏蔽它所显示的内容来达到延时的目的。

### 模拟进度条
下面给出一个模拟进度条的程序。如果将它运用在你自己的程序中，可以使你的程序更漂亮。
``` batch
@echo off
mode con cols=113 lines=15 &color 9f
cls
echo.
echo  程序正在初始化. . . 
echo.
echo  ┌──────────────────────────────────────┐
set/p=  ■<nul
for /L %%i in (1 1 38) do set /p a=■<nul&ping /n 1 127.0.0.1>nul
echo   100%%
echo  └──────────────────────────────────────┘
pause
```
解说：“set /p a=■<nul”的意思是：只显示提示信息“■”且不换行，也不需手工输入任何信息，这样可以使每个“■”在同一行逐个输出。“ping /n 0 127.1>nul”是输出每个“■”的时间间隔，即每隔多少时间输出一个“■”。



### 特殊字符的输入及应用

开始 -> 运行 -> 输入cmd -> edit -> ctrl+p（意思是允许输入特殊字符）-> 按ctrl+a将会显示笑脸图案。

（如果要继续输入特殊字符请再次按ctrl+p，然后ctrl+某个字母）

以上是特殊字符的输入方法，选自[英雄]教程，很管用的。也就是用编辑程序edit输入特殊字符，然后保存为一文本文件，再在windows下打开此文件，复制其中的特殊符号即可。

一些简单的特殊符号可以在dos命令窗口直接输入，并用重定向保存为文本文件。
例：
C:>ECHO ^G>temp.txt
“^G”是用Ctrl＋G或Alt＋007输入，输入多个^G可以产生多声鸣响。


特殊字符的应用也很有意思，这里仅举一例：退格键

退格键表示删除左边的字符，此键不能在文档中正常输入，但可以通过edit编辑程序录入并复制出来。即“”。

利用退格键，可以设计闪烁文字效果

例：文字闪烁
``` batch
@echo off
:start
set/p=床前明月光<nul
::显示文字，光标停于行尾
ping -n 0 127.0.0.1>nul
::设置延迟时间
set /p a=<nul
:: 输出一些退格符将光标置于该行的最左端（退格符的数量可以自己调整）。
set /p a=                               <nul
::输出空格将之前输出的文字覆盖掉。
set /p a=<nul
::再次输出退格符将光标置于该行的最左端，这里的退格符数量一定不能比前面的空格数少。
::否则光标不能退到最左端。
goto start
```

例：输出唐诗一首，每行闪动多次
``` batch
@echo off
setlocal enabledelayedexpansion

set str=床前明月光 疑是地上霜 举头望明月 低头思故乡
::定义字符串str
for %%i in (%str%) do (
 rem 由于str中含有空格，则以空格为分隔符将str中的每一个部分依次赋给变量%%i。
        set char=%%i
        echo.
        echo.
        for /l %%j in (0,1,5) do (
                set/p=!char:~%%j,1!<nul
  rem 依次取出变量char中的每一个字符，并显示。
                ping -n 0 127.0.0.1>nul
  rem 设置输出每个字符的时间延迟。
        )
 call :hero %%i
)
pause>nul
exit

:hero
for /l %%k in (1,1,10) do (
 ping /n 0 127.0.0.1>nul
 set /p a=<nul
 set /p a=                               <nul
 set /p a=<nul
 ping /n 0 127.0.0.1>nul
 set /p a=%1<nul
)
::文字闪动
goto :eof
```