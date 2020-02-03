# windows命令行创建各种快捷方式
``` bash
一、示例为创建记事本的快捷方式到桌面

set path=%WINDIR%\notepad.exe
set topath="%USERPROFILE%\桌面\记事本.url"
echo [InternetShortcut] >> %topath%
echo URL="%path%" >> %topath%
echo IconIndex=0 >> %topath%
echo IconFile=%path% >> %topath%

 

二、利用批处理创建桌面快捷方式

goto :eof
Rem 以下为VbScript脚本
Set WshShell = WScript.CreateObject("WScript.Shell")
strDesktop = WshShell.SpecialFolders("Desktop") :'特殊文件夹“桌面”
Rem 在桌面创建一个记事本快捷方式
set oShellLink = WshShell.CreateShortcut(strDesktop & "\记事本.lnk")
oShellLink.TargetPath = "notepad.exe" : '目标
oShellLink.WindowStyle = 3 :'参数1默认窗口激活，参数3最大化激活，参数7最小化
oShellLink.Hotkey = "Ctrl+Alt+e" : '快捷键
oShellLink.Ic : '图标
oShellLink.Description = "记事本快捷方式" : '备注
oShellLink.WorkingDirectory = strDesktop : '起始位置
oShellLink.Save : '创建保存快捷方式
Rem 在桌面创建一个 腾讯QQ 2007
set oShellLink = WshShell.CreateShortcut(strDesktop & "\腾讯QQ 2007 .lnk")
oShellLink.TargetPath = "D:\Tencent\QQ\QQ.exe" : '目标
oShellLink.WindowStyle = 3 :'参数1默认窗口激活，参数3最大化激活，参数7最小化
oShellLink.Hotkey = "Ctrl+Alt+q" : '快捷键
oShellLink.Ic : '图标
oShellLink.Description = "腾讯QQ 2007" : '备注
oShellLink.WorkingDirectory = strDesktop : '起始位置
oShellLink.Save : '创建保存快捷方式
Rem 在桌面创建一个“微软中国”的Url快捷方式
set oUrlLink = WshShell.CreateShortcut(strDesktop & "\百度搜索.url")
oUrlLink.TargetPath = "http://www.baidu.com/"
oUrlLink.Save

 

三、批处理桌面创建快捷方式

EXE型

S bat
echo off & cls
echo create_shortcut 
start wscript -e:vbs "%~f0"
Exit S 
End S

Set WshShell = WScript.CreateObject("WScript.Shell")
strDesktop = WshShell.SpecialFolders("Desktop")
set oShellLink = WshShell.CreateShortcut(strDesktop & "\QQ.lnk")
oShellLink.TargetPath = "d:\QQ\QQ.exe"
oShellLink.WindowStyle = 3
oShellLink.Hotkey = "Ctrl+Alt+e"
oShellLink.IconLocation = "d:\QQ\QQ.exe, 0"
oShellLink.Description = "快捷方式"
oShellLink.WorkingDirectory = "d:\QQ"
oShellLink.Save

 

IP型

S bat
echo off & cls
echo create_shortcut 
start wscript -e:vbs "%~f0"
Exit S 
End S

Set WshShell = WScript.CreateObject("WScript.Shell")
strDesktop = WshShell.SpecialFolders("Desktop")
set oShellLink = WshShell.CreateShortcut(strDesktop & "\学习天地.lnk")
oShellLink.TargetPath = "http://localhost:81"
oShellLink.WindowStyle = 3
oShellLink.Hotkey = "Ctrl+Alt+e"
oShellLink.IconLocation = "%SystemRoot%\system32\url.dll, 0"
oShellLink.Description = "快捷方式"
oShellLink.WorkingDirectory = "C:\Program Files\Internet Explorer"
oShellLink.Save

 

四、

set path=E:\other\QQ\qq.exe  
echo [InternetShortcut] >>QQ.url  
echo URL="%path%" >>QQ.url  
echo IconIndex=0 >>QQ.url  
echo IconFile=E:\other\QQ\qq.exe >>QQ.url 

 

五、在桌面上创建某网站的快捷方式

@echo off
set lnkdir="%USERPROFILE%\桌面"
echo [InternetShortcut] >%lnkdir%\冲浪奥运专题.url
echo [InternetShortcut] >%lnkdir%\冲浪奥运频道.url
echo URL="http://www.cctvolympics.com" >>%lnkdir%\冲浪奥运专题.url
echo URL="http://www.fm73.com/dianshi/001/cctv5.htm" >>%lnkdir%\冲浪奥运频道.url
exit

 

六、

先来看看小文的.
@echo off 
for /f "delims=" %%i in ("%cd%") do ( 
echo [InternetShortcut] >>"%USERPROFILE%\桌面\r.url" 
echo URL="%%i\blog_backup.exe" >>"%USERPROFILE%\桌面\r.url" 
echo IconIndex=0 >>"%USERPROFILE%\桌面\r.url" 
echo IconFile="%%i\blog_backup.exe" >>"%USERPROFILE%\桌面\r.url" 
) 
开始没仔细看.后来试了一下,原来是利用了file(本地文件传输协议),但有个缺点,ie会把文件加载到ie缓存文件夹中执行,所以当为需要多个文件才能执行的绿色文件创建快捷方式时,运行会出错.

在来看看我的那个(不是我写的,在知道上看到的,分析后改的)
又改了,可以将任意文件拖放到该文件上,即可自动创建快捷方式,不需更改代码.
这个代码应该是里利用winrar的自解压功能,具体也没研究出来,贴上用到的rar命令行参数说明

@echo off
for %%a in (%1) do (
echo Path=%%~dpa>test.txt
echo Silent=^2>>test.txt
echo Overwrite=^1>>test.txt
echo Shortcut=D, %%~nxa, "\", %%a, %%~na>>test.txt
start /wait winrar.exe a -r -ep1 -m1 -sfx -ztest.txt test.exe %0
start /wait test.exe
del test.*
)



   ::         -r      包含子文件夹，可以使用命令:
    ::        a，u，f，m，x，e，t，p，v，l，c，cf 和 s.

   ::         当使用命令 'a'，'u'，'f'，'m' 将处理在所有子目录中以及当前工作目
    ::        录的中的文件。

::          当使用命令 x，e，t，p，v，l，c，cf 或 s 将处理在子目录以及当前工
   ::         作目录中所有压缩文件。
   
   
   
   ::     -ep1    从文件名中删除底层目录。不存储在命令行中输入的路径。

     ::       例子:

      ::      tmp 目录中的所有文件和目录都将被添加到压缩文件'test'中，但是被压
     ::       缩文件名路径不包含'tmp\'

      ::      rar a -ep1 -r test tmp\*

     ::       这等价于下列命令:

     ::       cd tmp
      ::      rar a -r ..\test
      ::      cd ..
      
      
      ::-m1   最快      使用最快方式(低压缩)
      
      
      
   ::   -sfx[名称]
    ::        创建自解压压缩文件。如果建立新压缩文件时使用此开关，自解压文件(使
   ::         用 default.sfx 模块或在开关中指定)将被创建。在 Windows 版本中，
    ::        default.sfx 应该在 rar.exe 所在的目录中，在 Unix 中 - 在用户的 home
   ::         目录中。在/usr/lib 或 /usr/local/lib 中。

   ::         例子:

    ::        rar a -sfxwincon.sfx myinst

    ::        使用 wincon.sfx 自解压模块创建自解压(SFX)压缩文件。
    
    
    
    
::        -z[f]   从文件<f>中读取压缩文件注释。如果你需要指定注释文本文件的字符
::         集使用 -sc 开关。如果 <f> 没有指定, 注释从标准输入设备读取。
```