# tasklist



tasklist,taskkill,taskmgr

- tasklist提供了任务查阅功能，命令行程序
- taskkill可以杀死任务，命令行程序。
- taskmgr 是常用的任务管理器，带界面。



## tasklist命令详解

* 打印所有程序的映像名，PID，是否服务，内存占用
* 通过详细打印可以打印用户名，程序标题。
* 打印程序依赖的dll
* 使用过滤器过滤程序
* 指定远程系统，指定用户密码

 `TASKLIST /V  /FI "IMAGENAME eq mstsc.exe"`

 `TASKLIST  /FI "IMAGENAME eq mstsc.exe" /M`

直接执行tasklist可以打印 映像名称，PID，会话名，会话，内存使用

会话名的console是指命令行或gui程序？services是指服务程序？

``` bash

C:\Users\admin>tasklist

映像名称                       PID 会话名              会话#       内存使用
========================= ======== ================ =========== ============
System Idle Process              0 Services                   0          8 K
System                           4 Services                   0         24 K
Secure System                   64 Services                   0     38,704 K
Registry                       116 Services                   0     13,112 K
smss.exe                       436 Services                   0        332 K
csrss.exe                      720 Services                   0      1,764 K
wininit.exe                    820 Services                   0        824 K
csrss.exe                      828 Console                    1      3,560 K
```

## help

```  bash

C:\Users\admin>tasklist /?

TASKLIST [/S system [/U username [/P [password]]]]
         [/M [module] | /SVC | /V] [/FI filter] [/FO format] [/NH]

描述:
    该工具显示在本地或远程机器上当前运行的进程列表。


参数列表:
   /S     system           指定连接到的远程系统。

   /U     [domain\]user    指定应该在哪个用户上下文执行这个命令。

   /P     [password]       为提供的用户上下文指定密码。如果省略，则
                           提示输入。

   /M     [module]         列出当前使用所给 exe/dll 名称的所有任务。
                           如果没有指定模块名称，显示所有加载的模块。

   /SVC                    显示每个进程中主持的服务。

   /APPS 显示 Microsoft Store 应用及其关联的进程。

   /V                      显示详细任务信息。

   /FI    filter           显示一系列符合筛选器
                           指定条件的任务。

   /FO    format           指定输出格式。
                           有效值: "TABLE"、"LIST"、"CSV"。

   /NH                     指定列标题不应该
                           在输出中显示。
                           只对 "TABLE" 和 "CSV" 格式有效。

   /?                      显示此帮助消息。

筛选器:
    筛选器名称     有效运算符           有效值
    -----------     ---------------           --------------------------
    STATUS          eq, ne                    RUNNING | SUSPENDED
                                              NOT RESPONDING | UNKNOWN
    IMAGENAME       eq, ne                    映像名称
    PID             eq, ne, gt, lt, ge, le    PID 值
    SESSION         eq, ne, gt, lt, ge, le    会话编号
    SESSIONNAME     eq, ne                    会话名称
    CPUTIME         eq, ne, gt, lt, ge, le    CPU 时间，格式为
                                              hh:mm:ss。
                                              hh - 小时，
                                              mm - 分钟，ss - 秒
    MEMUSAGE        eq, ne, gt, lt, ge, le    内存使用(以 KB 为单位)
    USERNAME        eq, ne                    用户名，格式为
                                              [域\]用户
    SERVICES        eq, ne                    服务名称
    WINDOWTITLE     eq, ne                    窗口标题
    模块         eq, ne                    DLL 名称

注意: 当查询远程计算机时，不支持 "WINDOWTITLE" 和 "STATUS"
      筛选器。

Examples:
    TASKLIST
    TASKLIST /M
    TASKLIST /V /FO CSV
    TASKLIST /SVC /FO LIST
    TASKLIST /APPS /FI "STATUS eq RUNNING"
    TASKLIST /M wbem*
    TASKLIST /S system /FO LIST
    TASKLIST /S system /U 域\用户名 /FO CSV /NH
    TASKLIST /S system /U username /P password /FO TABLE /NH
    TASKLIST /FI "USERNAME ne NT AUTHORITY\SYSTEM" /FI "STATUS eq running"
```


