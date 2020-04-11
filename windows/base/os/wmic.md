# wmic

先决条件：
a. 启动Windows Management Instrumentation服务，开放TCP135端口。
b. 本地安全策略的“网络访问: 本地帐户的共享和安全模式”应设为“经典-本地用户以自己的身份验证”。

## overview

操作系统 包括

硬件驱动管理
系统管理
文件系统管理
用户管理
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


**Q**: 查询某一个进程的命令行参数
**A**: 

 wmic process get caption,commandline /value 如果想查询某一个进程的命令行参数，使用下列方式：
 ` wmic process where caption="update.exe" get caption,commandline /value` 其中update.exe可以换成你要查看的

`wmic process where caption="mysqld.exe" get caption,commandline /value` 
显示：
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