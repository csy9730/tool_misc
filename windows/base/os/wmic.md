# wmic

## overview

操作系统 包括

硬件驱动管理
系统管理
文件系统管理

用户
安装程序管理
启动项管理
进程管理
网络设置
服务管理
计划任务
防火墙 
端口号

``` bash
wmic service list brief
wmic product list  brief
wmic process list brief
wmic startup list brief
wmic netuse list brief
wmic useraccount list brief
wmic ntdomain list brief
wmic logon list brief
wmic qfe list brief

wmic /node:192.168.1.2 /usr:administrator /password:123456 process call create "cmd.exe /c ipconfig"

powershell Get-WmiObject -List
```
## process

``` ini
Caption 
CommandLine                                                                 
CreationClassName CreationDate 
CSCreationClassName=Win32_ComputerSystem 
CSName=DESKTOP-CTAGE42           
Description                                                         
ExecutablePath                                                                                                                                 ExecutionState=
InstallDate=
Handle  HandleCount    KernelModeTime  MaximumWorkingSetSize  MinimumWorkingSetSize  Name                                                                OSCreationClassName    OSName                                                               OtherOperationCount  OtherTransferCount  PageFaults  PageFileUsage  ParentProcessId  PeakPageFileUsage  PeakVirtualSize  PeakWorkingSetSize  Priority  PrivatePageCount  ProcessId  QuotaNonPagedPoolUsage  QuotaPagedPoolUsage  QuotaPeakNonPagedPoolUsage  QuotaPeakPagedPoolUsage  ReadOperationCount  ReadTransferCount  SessionId  Status  TerminationDate  ThreadCount  UserModeTime   VirtualSize    WindowsVersion  WorkingSetSize  WriteOperationCount  WriteTransferCount  
```

**Q**: 查询某一个进程的命令行参数
**A**: 

 wmic process get caption,commandline /value 如果想查询某一个进程的命令行参数，使用下列方式：
 ` wmic process where caption="update.exe" get caption,commandline /value` 其中update.exe可以换成你要查看的

wmic process where caption="mysqld.exe" get caption,commandline /value
C:\Program Files\MySQL\MySQL Server 5.6\bin\mysqld.exe" --defaults-file="C:\ProgramData\MySQL\MySQL Server 5.6\my.ini" MySQL56


使用下面的命令：
wmic process get caption,commandline /value


``` bash
wmic process get caption,commandline /value
# 如果想查询某一个进程的命令行参数，使用下列方式：
wmic process where caption="svchost.exe" get caption,commandline /value
wmic process where caption="python.exe" get caption,commandline /value

```

## misc

``` bash
wmic csproduct get uuid
wmic baseboard get serialnumber
# \r\r\n26741179-6DE8-EF7A-0B40-0492264EF5F9  \r\r\n\r\r\n
wmic baseboard get serialnumber
wmic cpu get processorid
```