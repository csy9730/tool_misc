# regedit

## 简介

### 主键
主要包括以下的主键:
* HKEY_CLASSES_ROOT
* HKEY_CURRENT_USER
* HKEY_LOCAL_MACHINE
* HKEY_CURRENT_CONFIG
* HKEY_USERS

HKEY_USERS 包含  HKEY_CURRENT_USER 
HKEY_LOCAL_MACHINE 包含HKEY_CURRENT_CONFIG

值类型：
SZ为字符串类型，
DWORD(32位int类型？)
* REG_SZ
* REG_BINARY
* REG_DWORD
* REG_QWORD
* REG_MULTI_SZ
* REG_EXPAND_SZ


S-1-5-21-1730791080-3570378909-3625705291-1001

local-machine
* software
* system


user
* software
* system
* env
* console


``` ini
[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDLLs]
"C:\\Windows\\Microsoft.NET\\Framework\\v1.0.3705\\diasymreader.dll"=dword:00001000
```