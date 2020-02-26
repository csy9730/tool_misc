# nsis

## installPackage

### Microsoft Windows Installer
　　如果某个软件是用 Windows Installer 打包的，那你就应该能在文件夹中看到 *.msi 文件。这是最典型的特征，这些文件通常可以使用 /QB 和 /QN 参数进行自动安装。
　　/qb 会在窗口中显示一个基本的安装进程。
　　/qn 参数则不会显示任何窗口，直接在后台自动安装。

　　为了阻止某些程序安装成功后自动重启动（例如 Kerio Personal Firewall 4），你可以在 /qn 或者 /qb参数后使用REBOOT=Suppress标记。
　　例如：安装虚拟光驱 DaemonTools：
    `msiexec /i dtools.msi /qb REBOOT=SUPPRESS`

### Inno Setup
Inno Setup  下载地址: http://www.cr173.com/soft/8158.html
Inno Setup 制作的安装文 件，请使用：
`setup.exe /sp- /silent /norestart`
### nsis

NullSoft Installation System  http://www.cr173.com/soft/2235.html
使用 NSIS（NullSoft Installation System）制作的安装文件，可用 /S （注意大写）来进行静默安装（“S”是大小写敏感的）。
例如：`Setup.exe /S`
也可以用 /D参数选择将要安装的目标分区和文件夹：
例如：`Setup.exe /S /D=E:\Software\QQ2007`
`Setup.exe /S /D=%localappdata%\abc`
像Winamp 和CDex这类的软件都会在安装结束后显示一个确认屏幕（CDex）或者一个设置文件关联方式的结束安装屏幕（Winamp）
说明：怎么知道哪个程序是使用NSIS技术打包的？
很多用NSIS打包的程序在安装的时候都有类似的窗口，例如Winamp 和CDex。

### Wise Installation Professional
Wise Installation Professional　制作的安装文件，可用 /silent 参数进行静默安装

### InstallShield  
要使用静默安装的方式安装用InstallShield技术打包的程序，首先要在现有的操作系统中创建一个setup.iss文件。在命令行窗口中使用 -R 参数（大小写敏感）运行安装程序。　　例如：
`Setup.exe -R`
接着会显示常见的安装屏幕，并且询问你一些问题，例如要安装的目录等有一点是很重要的，在安装结束后你不能选择“立刻重启动计算机”的选项。如果你选了，在批处理文件中的其他命令就会因为计算机重启动而无法执行。
在安装程序运行完毕后，打开你的 C:\Windows（或者C:\WINNT）目录，然后找到 setup.iss 文件，把这个文件和你将要静默安装的程序 setup.exe 保存在同一个目录中。
用以下命令进行静默安装：setup.exe -s [-sms]
说明：怎么知道哪个程序是使用InstallShield技术打包的？
大部分这类程序的安装文件都可以被压缩软件解压缩，安装文件 setup.exe 的属性对话框中应该有“InstallShield (R) Setup Launcher”或者其他类似的字样。
最后，如果你在保存安装文件的文件夹中看到了一个 setup.iss 文件，那么毫无疑问这是用 InstallShield 打包了！

### InstallShield with MSI
InstallShield with MSI 制作的安装文件，请使用类似：setup.exe /s /v "/qb" 来安装。

## misc

无人值守安装光盘最有魅力的地方之一就是在安装过程中可以静默安装好预先设计集成的一些常用软件，安装结束以后软件就已经可以使用
``` bash
ECHO.
ECHO 正在安装ISOBuster 1.4
ECHO 请稍候...
start /wait %systemdrive%install/Applications/ISOBuster/IsoBuster14.exe /VERYSILENT /SP-
ECHO.
ECHO Killing ISOBuster.exe process
taskkill.exe /F /IM isobuster.exe
ECHO.
```

**Q**:如何静默安装程序，并且可以绕过UAC限制？
**A**: 