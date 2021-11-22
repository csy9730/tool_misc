# 



### install startSshd.vbs
**Q**: 通过vbs设置启动项，没有一闪而过的窗口。

**A**:  执行以下命令：

``` bash
echo set ws=WScript.CreateObject("WScript.Shell")>"startSshd.vbs"
echo ws.Run "cmd /c C:\Program Files\Git\usr\bin\sshd.exe -p 22 ",vbhide >>"startSshd.vbs"
copy startSshd.vbs  "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup" /y
```


### startSshd.vbs
将会在启动目录生成startSshd.vbs，每次开机启动sshd

``` bash
set ws=WScript.CreateObject("WScript.Shell")
ws.Run "cmd /c C:\Program Files\Git\usr\bin\sshd.exe -p 22 ",vbhide 
```


### windows boot  install frpc.vbs

**Q**: windows把frpc.exe 设为启动项？
**A**：

在启动目录下生成frpc.vbs。
``` bash
echo set ws=WScript.CreateObject("WScript.Shell")>>"frpc.vbs"
echo ws.Run "cmd /c %~dp0frpc.exe -c  %~dp0frpc2.ini",vbhide >>"frpc.vbs"
copy frpc.vbs  "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup"
```

### frpc.vbs
frpc.vbs的内容：

``` vbs
Set ws = CreateObject("Wscript.Shell")
ws.run "cmd /c c:\frps\frps.exe -c c:\frps\frps.ini",vbhide
```
