# regedit

## j简介
HKEY_CLASSES_ROOT
HKEY_CURRENT_USER
HKEY_LOCAL_MACHINE
HKEY_CURRENT_CONFIG
HKEY_USERS


HKEY_USERS 包含  HKEY_CURRENT_USER 
值类型：
HKEY_LOCAL_MACHINE 包含HKEY_CURRENT_CONFIG

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



[HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDLLs]
"C:\\Windows\\Microsoft.NET\\Framework\\v1.0.3705\\diasymreader.dll"=dword:00001000
