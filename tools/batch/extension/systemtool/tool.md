

#### net

```
net use \\192.168.0.21\ipc$ "password" /user:"lilei"

net use \\192.168.23.25\ipc$ "password" /user:"lilei"

net use  h: \\192.168.23.25\c$ password /user:lilei
net use  h: \\192.168.23.25\c$ password /user:lilei /del
net use  j: \\192.168.23.25\d$ password /user:lilei

net use  k: \\192.168.12.38\d$ a123456/user:hanmeimei /del

net share 

net share ipc$

net share ipc$ /del
```

#### schetasks

#### tasklist
#### taskkill
#### taskmgr

#### regedit

#### VBScript
#### CScript.exe 
#### mstsc

mstsc /v:192.168.23.25
mstsc abc.rdp

#### ftp
#### telnet
#### regsvr32

```
@echo 开始注册
copy dll %windir%\system32\
regsvr32 %windir%\system32\dll /s
@echo dll注册成功
@pause

ren %windir%\system32\msvcr90d.dll MSVCR90D.DLL


@echo 开始注册
copy dll %windir%\syswow64\
regsvr32 %windir%\syswow64\dll /s
@echo dll注册成功
@pause
```