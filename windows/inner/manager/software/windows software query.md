# windows software query


安装一个软件，一般会在两个地方找到，
1. 开始菜单
2. 添加删除程序列表

#### wmic

```
wmic product get name
```

```
Microsoft Visual C++ 2008 Redistributable - x64 9.0.30729.4148
COMODO Internet Security
Microsoft Visual C++ 2019 X86 Minimum Runtime - 14.20.27508
ESET NOD32 Antivirus
Microsoft Visual C++ 2019 X64 Minimum Runtime - 14.20.27508
Adobe Reader X (10.1.0) - Chinese Simplified
Microsoft Visual C++ 2019 X86 Additional Runtime - 14.20.27508
Google Update Helper
7-Zip 9.20 (x64 edition)
Microsoft Visual C++ 2019 X64 Additional Runtime - 14.20.27508
Microsoft .NET Framework 4.5.1
Microsoft Visual C++ 2008 Redistributable - x86 9.0.30729.4148
VMware Tools
```



#### 删除程序列表
CurrentVersion\Uninstall

``` powershell
$loc = Get-ChildItem HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall
$names = $loc |foreach-object {Get-ItemProperty $_.PsPath}
foreach ($name in $names)
{
    Write-Host $name.Displayname
}
```

```
7-Zip 9.20 (x64 edition)
Microsoft Visual C++ 2019 X64 Additional Runtime - 14.20.27508
Microsoft Visual C++ 2008 Redistributable - x64 9.0.30729.4148
COMODO Internet Security
VMware Tools
Microsoft .NET Framework 4.5.1
Microsoft .NET Framework 4.5.1
ESET NOD32 Antivirus
Microsoft Visual C++ 2019 X64 Minimum Runtime - 14.20.27508
```

#### App Paths
所有在windows正常安装了的普通软件：
```
REG QUERY "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths"
```
列出名为应用名称（xxx.exe）的注册表文件夹，里面数值是软件安装路径（软件路径和软件目录路径）


```
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\7zFM.exe
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\AcroRd32.exe
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\chrome.exe
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\cmmgr32.exe
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\IEDIAG.EXE
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\IEDIAGCMD.EXE
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\IEXPLORE.EXE
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\install.exe
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\pbrush.exe
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\PowerShell.exe
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\setup.exe
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\table30.exe
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\wab.exe
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\wabmig.exe
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\WORDPAD.EXE
HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\WRITE.EXE

```


#### App Paths 
``` python
import sys
import win32api
import win32con
def find_path(name="CST DESIGN ENVIRONMENT_AMD64.exe"): # 查找的软件名称
    path = None
    key = rf'SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\{name}'
    #通过获取Windows注册表查找软件
    key = win32api.RegOpenKey(win32con.HKEY_LOCAL_MACHINE, key, 0, win32con.KEY_READ)
    info2 = win32api.RegQueryInfoKey(key)
    for j in range(0, info2[1]):
        key_value = win32api.RegEnumValue(key, j)[1]
        if key_value.upper().endswith(name.upper()):
            path = key_value
            break
    win32api.RegCloseKey(key)
    return path #返回查找到的安装路径

```

#### 开始菜单
```
C:\Documents and Settings\All Users\Start Menu\Programs
```
#### psinfo
则Microsoft / Sysinternals的PsInfo可以列出所有已安装的软件。
```
$ >psinfo -s
```

#### CCleaner
[https://www.ccleaner.com/](https://www.ccleaner.com/)
#### Geek Uninstaller

## misc

[https://qastack.cn/superuser/68611/get-list-of-installed-applications-from-windows-command-line](https://qastack.cn/superuser/68611/get-list-of-installed-applications-from-windows-command-line)