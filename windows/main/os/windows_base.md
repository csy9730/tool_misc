# windows base

启动telnet服务
`net start telnet`

**Q**: 如何查看系统版本
**A**: 
1. `winver `
2. 　`systeminfo | findstr Build`
3. `HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion`



**Q**: powershell远程启动程序，任务管理器里有，但是前台没有界面，即使是有UI界面的程序，如何使远程能显示有界面的程序
**A**: 
通过计划任务能否？
python 通过os.system直接调用，无效。
通过按键脚本？
```
SCHTASKS /create 
SCHTASKS.EXE /create /sc once /tn WeChat /tr "C:\Program Files\Tencent\WeChat\WeChat.exe" /st $time%
SCHTASKS.EXE /create /sc once /tn WeChat /tr "C:\Program Files\Tencent\WeChat\WeChat.exe" /st %time:~0,8%
```

``` python
import os
os.system('"C:\Program Files\Tencent\WeChat\WeChat.exe"')
```

### autorun

software\microsoft\windows\currentVersion\run
HKLM software\microsoft\windows\currentVersion\run
