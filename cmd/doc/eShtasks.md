# schtasks

## introduction

计划任务：指定主机指定时间运行指定的exe程序


```
C:\Users\admin>schtasks /?
SCHTASKS /parameter [arguments]
描述:
    允许管理员创建、删除、查询、更改、运行和中止本地或远程系统上的计划任
    务。
参数列表:
    /Create         创建新计划任务。
    /Delete         删除计划任务。
    /Query          显示所有计划任务。
    /Change         更改计划任务属性。
    /Run            按需运行计划任务。
    /End            中止当前正在运行的计划任务。
    /ShowSid        显示与计划的任务名称相应的安全标识符。
    /?              显示此帮助消息。
Examples:
    SCHTASKS
    SCHTASKS /?
    SCHTASKS /Run /?
    SCHTASKS /End /?
    SCHTASKS /Create /?
    SCHTASKS /Delete /?
    SCHTASKS /Query  /?
    SCHTASKS /Change /?
    SCHTASKS /ShowSid /?
```


```
C:\Users\admin>schtasks /query

文件夹: \
任务名                                   下次运行时间           模式
======================================== ====================== ===============
Adobe Acrobat Update Task                2019/5/16 11:00:00     就绪
NvBatteryBoostCheckOnLogon_{B2FE1952-018 N/A                    就绪
NvDriverUpdateCheckDaily_{B2FE1952-0186- 2019/5/16 12:25:44     就绪
NVIDIA GeForce Experience SelfUpdate_{B2 N/A                    已禁用
NvNodeLauncher_{B2FE1952-0186-46C3-BAEC- N/A                    就绪
NvProfileUpdaterDaily_{B2FE1952-0186-46C N/A                    已禁用
NvProfileUpdaterOnLogon_{B2FE1952-0186-4 N/A                    已禁用
NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35 N/A                    已禁用
NvTmRepCR1_{B2FE1952-0186-46C3-BAEC-A80A N/A                    已禁用
NvTmRepCR2_{B2FE1952-0186-46C3-BAEC-A80A N/A                    已禁用
NvTmRepCR3_{B2FE1952-0186-46C3-BAEC-A80A N/A                    已禁用
NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35 N/A                    已禁用
OneDrive Standalone Update Task-S-1-5-21 N/A                    已禁用
User_Feed_Synchronization-{804DA5A5-5BEE N/A                    已禁用
WpsExternal_admin_20190428132612         2019/5/16 10:12:12     就绪
WpsUpdateTask_admin                      2019/5/16 9:50:05      就绪

文件夹: \Microsoft
任务名                                   下次运行时间           模式
======================================== ====================== ===============
信息: 目前在你的访问级别上不存在任何可用的计划任务。

文件夹: \Microsoft\VisualStudio
任务名                                   下次运行时间           模式
======================================== ====================== ===============
VSIX Auto Update 14                      2019/5/17 6:30:35      就绪

文件夹: \Microsoft\Windows
任务名                                   下次运行时间           模式
======================================== ====================== ===============
信息: 目前在你的访问级别上不存在任何可用的计划任务。
```


```
C:\Users\admin>SCHTASKS /ShowSid /TN "\备份\启动备份"
成功: 已成功计算 SID“S-1-5-87-782916017-575545879-3398072960-2725436614-2063171235”(用户名“备份-启动备份”)。
```


### CRUD

   SCHTASKS /Create /?
   SCHTASKS /Delete /?
   SCHTASKS /Query  /?
   SCHTASKS /Change /?
   
##### create

创建计划任务 "notepad"，在每月的第一个星期天
运行“空当接龙”。

SCHTASKS /Create /SC MONTHLY /MO first /D SUN /TN gametime
         /TR c:\windows\system32\notepad.exe
##### delete

```

C:\Users\admin>schtasks /delete /tn  WpsUpdateTask_admin
警告: 确实要删除任务 "WpsUpdateTask_admin" 吗 (Y/N )? y
成功: 计划的任务 "WpsUpdateTask_admin" 被成功删除。
```
##### query

定时任务按照文件夹路径区分，默认使用TABLE格式输出。
每个任务都有ssid

```
 /FO   format         为输出指定格式。有效值: TABLE、LIST、CSV。

 /NH                  指定在输出中不显示列标题。
                      只对 TABLE 格式有效。
                      仅适用于 TABLE 和 CSV 格式。

 /V                   显示详细任务输出。

 /TN   taskname       指定要检索其信息的任务路径\名称，
                      否则会检索所有任务的信息。

 /XML  [xml_type]     以 XML 格式显示任务定义。

                      如果 xml_type 为 ONE，则输出为一个有效 XML 文件。

                      如果 xml_type 不存在，则输出将为

                      所有 XML 任务定义的串联。

···

schtasks /query /v >temp.txt


```
文件夹: \
任务名                                   下次运行时间           模式
======================================== ====================== ===============
Adobe Acrobat Update Task                2019/5/16 11:00:00     就绪
NvBatteryBoostCheckOnLogon_{B2FE1952-018 N/A                    就绪
NvDriverUpdateCheckDaily_{B2FE1952-0186- 2019/5/16 12:25:44     就绪
NVIDIA GeForce Experience SelfUpdate_{B2 N/A                    已禁用
NvNodeLauncher_{B2FE1952-0186-46C3-BAEC- N/A                    就绪
NvProfileUpdaterDaily_{B2FE1952-0186-46C N/A                    已禁用
NvProfileUpdaterOnLogon_{B2FE1952-0186-4 N/A                    已禁用
NvTmMon_{B2FE1952-0186-46C3-BAEC-A80AA35 N/A                    已禁用
NvTmRepCR1_{B2FE1952-0186-46C3-BAEC-A80A N/A                    已禁用
NvTmRepCR2_{B2FE1952-0186-46C3-BAEC-A80A N/A                    已禁用
NvTmRepCR3_{B2FE1952-0186-46C3-BAEC-A80A N/A                    已禁用
NvTmRep_{B2FE1952-0186-46C3-BAEC-A80AA35 N/A                    已禁用
OneDrive Standalone Update Task-S-1-5-21 N/A                    已禁用
User_Feed_Synchronization-{804DA5A5-5BEE N/A                    已禁用
WpsExternal_admin_20190428132612         2019/5/16 10:12:12     就绪
WpsUpdateTask_admin                      2019/5/16 9:50:05      就绪

文件夹: \Microsoft
任务名                                   下次运行时间           模式
======================================== ====================== ===============
信息: 目前在你的访问级别上不存在任何可用的计划任务。

文件夹: \Microsoft\VisualStudio
任务名                                   下次运行时间           模式
======================================== ====================== ===============
VSIX Auto Update 14                      2019/5/17 6:30:35      就绪
```

详细模式打印
···
>>schtasks /query /v
文件夹: \Microsoft\XblGameSave
主机名:                             DESKTOP-CTAGE42
任务名:                             \Microsoft\XblGameSave\XblGameSaveTask
下次运行时间:                       N/A
模式:                               就绪
登录状态:                           交互方式/后台方式
上次运行时间:                       1999/11/30 0:00:00
上次结果:                           267011
创建者:                             Microsoft
要运行的任务:                       %windir%\System32\XblGameSaveTask.exe standby
起始于:                             N/A
注释:                               XblGameSave Standby Task
计划任务状态:                       已启用
空闲时间:                           仅在空闲  分钟后启动, 如果没空闲，重试  分钟 如果空闲结束，停止任务
电源管理:                           不用电池启动
作为用户运行:                       SYSTEM
删除没有计划的任务:                 已禁用
如果运行了 X 小时 X 分钟，停止任务: 02:00:00
计划:                               计划数据在此格式中不可用。
计划类型:                           在空闲时间
开始时间:                           N/A
开始日期:                           N/A
结束日期:                           N/A
天:                                 N/A
月:                                 N/A
重复: 每:                           N/A
重复: 截止: 时间:                   N/A
重复: 截止: 持续时间:               N/A
重复: 如果还在运行，停止:           N/A
···
### REMOTE RUN

SCHTASKS /Query /S system /U user /P password
