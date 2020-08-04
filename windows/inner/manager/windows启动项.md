# 启动项

msconfig.msc
启动项分为StartUp 和注册表两种

仅对当前用户生效：
`%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup`
对所有用户生效：
`%ProgramData%\Microsoft\Windows\Start Menu\Programs\StartUp`

`C:\Users\admin\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup`
`C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp`

或者在运行中执行`shell:common startup`

ProgramData=C:\ProgramData

``` ini
[software\microsoft\windows\currentVersion\run]
[HKLM software\microsoft\windows\currentVersion\run]
```

## wmic startup
``` bash

```

``` ini
Caption=EvernoteClipper,          
Command=EvernoteClipper.lnk
Description=EvernoteClipper                                                                                         
Location=Startup
SettingID=
User=DESKTOP-PGE4ABC\csy_njgh
```

wmic startup create Caption="mingw_sshd",Command="C:\Program Files\Git\usr\bin\sshd.exe",Location="Startup",Description="werw"

wmic startup create Caption="notepad2",Command="notepad.exe",Location="Startup",Description="werw",User="DESKTOP-PGE4SMB\csy_njgh"

copy "C:\Users\gd_cs\Desktop\sshd.exe - 快捷方式.lnk"  "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

**Q**: 执行`wmic startup create `报错：描述 = 提供程序无法执行所尝试的操作
**A**： 不能使用，
只能使用
copy "C:\Users\gd_cs\Desktop\sshd.exe - 快捷方式.lnk"  "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"