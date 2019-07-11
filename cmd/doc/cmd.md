# batch
[TOC]
## introduction
批处理定义：顾名思义，批处理文件是将一系列命令按一定的顺序集合为一个可执行的文本文件，其扩展名为BAT或者CMD。这些命令统称批处理命令。
在计算机科学中，Shell俗称壳（用来区别于核），是指“提供使用者使用界面”的软件（命令解析器）。它类似于DOS下的command和后来的cmd.exe。它接收用户命令，然后调用相应的应用程序。
批处理运行方式：有命令行和脚本两种方式。
	命令行方式：输入window+R打开运行窗口，窗口填入cmd并确定，打开cmd界面，在command界面下输入命令。
	脚本形式：编辑txt文件保存成bat或cmd文件并双击执行。
##### 常用命令
* Base Control: CALL  EXIT START REM  ECHO CMD MORE  CLS  PAUSE 
* Logic Control:FOR  GOTO IF SET SHIFT SETLOCAL 
* Environment：DATE TIME TITLE COLOR  VER ASSOC ftype HELP PATH MODE
* Disk: SCHKDSK CHKNTFS COMPACT CONVERT  DISKPART FORMAT   LABEL CHCP BREAK 
* Dir:TREE  CD  CHDIR  RMDIR RD MKDIR DIR  
* File :COPY   DEL ERASE  MOVE XCOPY  RENAME REPLACE  ATTRIB 
* TEXT :TYPE FIND FINDSTR COMP FC 
* Net：net, ipconfig,ping,netstat,arp,getmac,ftp,netsh,netcfg,nbtstat ，ftp,tracert,telnet。
    * Other Program：explorer，SYSTEMINFO， SHUTDOWN ， logoff，tasklist,taskmgr,taskkill, SCHTASKS,sc query,control,regedit,gpedit.msc, AT WMIC
* small tool:notepad ,debug,magnify,osk,calc


## path

dir ../..
dir .
if not exist bak (mkdir bak & echo 1 >bak\bakCount.txt  ) 

## var

echo "%date%%time%"
set /p var=<bTemp.txt 

### demos

文件合并
静默安装
文件夹备份，文件备份，后缀名文件批量备份。
字符串处理：路径分割

### tools


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

### start
7-ZIP

### misc

使用赋值语句时，防止后接空格产生歧义。set a="abc"  

路径包含空格，使用双引包含路径。
转义符：
1. 一般通过转义符^
2. 双引号通过""" 实现,
3. 单引号和双引号嵌套使用