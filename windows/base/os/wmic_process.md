# wmic process


## overview

* Caption       标题
* CommandLine   命令行参数
* Description
* ExecutablePath    可执行路径
* Name
* ParentProcessId
* ProcessId
* Handle            值与ProcessId相同
* Priority          优先级
* ThreadCount
* WorkingSetSize        

* CreationDate



## list full

* list ： 按照列表格式显示，显示 HandleCount，Name，Priority  ProcessId  ThreadCount  WorkingSetSize 属性 
* 默认按照table格式显示
* list full 按照list格式显示所有属性，除了CreationDate/CreationClassName
* 

``` bash
# wmic process

wmic process list brief >>process.txt  //获取进程摘要信息
wmic process where name="maxthon.exe" list full

wmic process where name="python.exe" list full /format:xml
wmic process where name="AlibabaProtect.exe" list full

# wmic process where name="AlibabaProtect.exe" list full /format:htable.xsl


wmic process where name="AlibabaProtect.exe" delete
wmic process where name="AlibabaProtect.exe" terminate
wmic process call create "c:\windows\system32\calc.exe" # 创建一个进程
wmic process where name="AlibabaProtect.exe" call terminate # 终止一个进程?
wmic process where name="AlibabaProtect.exe" call SetPriority 8

`H:\project\tool_misc>wmic process where ProcessId="18772" list full`

``` ini
Caption=python.exe
CommandLine=H:\conda\venv\tss_env\python.exe completion.py
CreationClassName=Win32_Process
CreationDate=20200327220120.169426+480
CSCreationClassName=Win32_ComputerSystem 
CSName=DESKTOP-PGE4SMB
Description=python.exe
ExecutablePath=H:\conda\venv\tss_env\python.exe
ExecutionState=
Handle=18772
HandleCount=150
InstallDate=
KernelModeTime=1093750
MaximumWorkingSetSize=1380
MinimumWorkingSetSize=200
Name=python.exe
OSCreationClassName
OSName=Microsoft Windows 10 家庭中文版|C:\Windows|\Device\Harddisk1\Partition1
OtherOperationCount=8216
OtherTransferCount=536294
PageFaults=15480
PageFileUsage=41280
ParentProcessId=15228
PeakPageFileUsage=42124
PeakVirtualSize=4439117824
PeakWorkingSetSize=48468
Priority=8
PrivatePageCount=42270720
ProcessId=18772
QuotaNonPagedPoolUsage=28
QuotaPagedPoolUsage=134
QuotaPeakNonPagedPoolUsage=29
QuotaPeakPagedPoolUsage=141
ReadOperationCount=663
ReadTransferCount=7463729
SessionId=1
Status=
TerminationDate=
ThreadCount=2
UserModeTime=4687500
VirtualSize=4435054592
WindowsVersion=10.0.18363
WorkingSetSize=3854336
WriteOperationCount=93
WriteTransferCount=48100
```


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
### format

wmic process where name="python.exe" list full /format:csv 
其他可选格式：
CSV HFORM HMOF HTABLE HXML LIST RAWXML TABLE VALUE
htable-sortby
htable-sortby.xsl
texttablewsys
texttablewsys.xsl
wmiclimofformat
wmiclimofformat.xsl
wmiclitableformat
wmiclitableformat.xsl
wmiclitableformatnosys
wmiclitableformatnosys.xsl
wmiclivalueformat
wmiclivalueformat.xsl
## help
``` bash
PROCESS - 进程管理。

提示: BNF 的别名用法。
(<别名> [WMI 对象] | <别名> [<路径 where>] | [<别名>] <路径 where>) [<谓词子句>]。

用法:

PROCESS ASSOC [<格式说明符>]
PROCESS CALL <方法名称> [<实际参数列表>]
PROCESS CREATE <分配列表>
PROCESS DELETE
PROCESS GET [<属性列表>] [<获取开关>]
PROCESS LIST [<列表格式>] [<列表开关>]
```