# sc

命令行工具是`sc`
界面工具是`services.msc`

## field

* type
* start :auto , manual 

## help

``` bash
描述:
        SC 是用来与服务控制管理器和服务进行通信
        的命令行程序。
用法:
        sc <server> [command] [service name] <option1> <option2>...


        <server> 选项的格式为 "\\ServerName"
        可通过键入以下命令获取有关命令的更多帮助: "sc [command]"
        命令:
          query-----------查询服务的状态，
                          或枚举服务类型的状态。
          queryex---------查询服务的扩展状态，
                          或枚举服务类型的状态。
          start-----------启动服务。
          pause-----------向服务发送 PAUSE 控制请求。
          interrogate-----向服务发送 INTERROGATE 控制请求。
          continue--------向服务发送 CONTINUE 控制请求。
          stop------------向服务发送 STOP 请求。
          config----------更改服务的配置(永久)。
          description-----更改服务的描述。
          failure---------更改失败时服务执行的操作。
          failureflag-----更改服务的失败操作标志。
          sidtype---------更改服务的服务 SID 类型。
          privs-----------更改服务的所需特权。
          managedaccount--更改服务以将服务帐户密码
                          标记为由 LSA 管理。
          qc--------------查询服务的配置信息。
          qdescription----查询服务的描述。
          qfailure--------查询失败时服务执行的操作。
          qfailureflag----查询服务的失败操作标志。
          qsidtype--------查询服务的服务 SID 类型。
          qprivs----------查询服务的所需特权。
          qtriggerinfo----查询服务的触发器参数。
          qpreferrednode--查询服务的首选 NUMA 节点。
          qmanagedaccount-查询服务是否将帐户
                          与 LSA 管理的密码结合使用。
          qprotection-----查询服务的进程保护级别。
          quserservice----查询用户服务模板的本地实例。
          delete ----------(从注册表中)删除服务。
          create----------创建服务(并将其添加到注册表中)。
          control---------向服务发送控制。
          sdshow----------显示服务的安全描述符。
          sdset-----------设置服务的安全描述符。
          showsid---------显示与任意名称对应的服务 SID 字符串。
          triggerinfo-----配置服务的触发器参数。
          preferrednode---设置服务的首选 NUMA 节点。
          GetDisplayName--获取服务的 DisplayName。
          GetKeyName------获取服务的 ServiceKeyName。
          EnumDepend------枚举服务依赖关系。

        以下命令不需要服务名称:
        sc <server> <command> <option>
          boot------------(ok | bad)指示是否应将上一次启动另存为
                          最近一次已知的正确启动配置
          Lock------------锁定服务数据库
          QueryLock-------查询 SCManager 数据库的 LockStatus
示例:
        sc start MyService


QUERY 和 QUERYEX 选项:
        如果查询命令带服务名称，将返回
        该服务的状态。其他选项不适合这种
        情况。如果查询命令不带参数或
        带下列选项之一，将枚举此服务。
    type=    要枚举的服务的类型(driver, service, userservice, all)
             (默认 = service)
    state=   要枚举的服务的状态 (inactive, all)
             (默认 = active)
    bufsize= 枚举缓冲区的大小(以字节计)
             (默认 = 4096)
    ri=      开始枚举的恢复索引号
             (默认 = 0)
    group=   要枚举的服务组
             (默认 = all groups)

语法示例
sc query                - 枚举活动服务和驱动程序的状态
sc query eventlog       - 显示 eventlog 服务的状态
sc queryex eventlog     - 显示 eventlog 服务的扩展状态
sc query type= driver   - 仅枚举活动驱动程序
sc query type= service  - 仅枚举 Win32 服务
sc query state= all     - 枚举所有服务和驱动程序
sc query bufsize= 50    - 枚举缓冲区为 50 字节
sc query ri= 14         - 枚举时恢复索引 = 14
sc queryex group= ""    - 枚举不在组内的活动服务
sc query type= interact - 枚举所有不活动服务
sc query type= driver group= NDIS     - 枚举所有 NDIS 驱动程序



```

### create
``` 
描述:
        在注册表和服务数据库中创建服务项。
用法:
        sc <server> create [service name] [binPath= ] <option1> <option2>...

选项:
注意: 选项名称包括等号。
      等号和值之间需要一个空格。
 type= <own|share|interact|kernel|filesys|rec|userown|usershare>
       (默认 = own)
 start= <boot|system|auto|demand|disabled|delayed-auto>
       (默认 = demand)
 error= <normal|severe|critical|ignore>
       (默认 = normal)
 binPath= <.exe 文件的 BinaryPathName>
 group= <LoadOrderGroup>
 tag= <yes|no>
 depend= <依存关系(以 / (斜杠)分隔)>
 obj= <AccountName|ObjectName>
       (默认= LocalSystem)
 DisplayName= <显示名称>
 password= <密码>
```
sc create MingwSsh binpath= "C:\Program Files\Git\usr\bin\sshd.exe" type= share start= auto displayname= "Sshd Services"
sc create MingwSsh2 binpath= "C:\Windows\system32\svchost.exe -k  'C:\Program Files\Git\usr\bin\sshd.exe'" type= share start= auto displayname= "Sshd Services2"
sc description MingwSsh "提供SSHD服务。如果此服务被禁用，任何依赖它的服务将无法启动。"

添加服务： 
sc create MyPolicyAgent binpath= "C:\WINDOWS\system32\lsass.exe" type= share start= auto displayname= "IPSEC Services" depend= RPCSS/Tcpip/IPSec 
修改描述： 
sc description MyPolicyAgent "提供 TCP/IP 网络上客户端和服务器之间端对端的安全。如果此服务被停用，网络上客户端和服务器之间的 TCP/IP 安全将不稳定。如果此服务被禁用，任何依赖它的服务将无法启动。" 

## exe

**Q**: 怎样把任意exe程序注册成windows系统服务?
**A**: 

C:/Windows/Microsoft.NET/Framework/v2.0.50727\InstallUtil.exe
C:\Windows\Microsoft.NET\Framework\v4.0.30319\InstallUtil.exe
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\InstallUtil.exe
InstallUtil.exe
```
set path=%path%;C:\Windows\Microsoft.NET\Framework64\v4.0.30319\;
InstallUtil.exe  "C:\Program Files\Git\usr\bin\sshd.exe"
net start ServiceName
net stop ServiceName
InstallUtil.exe /u  Path/WinServiceName.exe

```

在初始化安装时发生异常:
System.BadImageFormatException: 未能加载文件或程序集“file:///C:\Program Files\Git\usr\bin\sshd.exe”或它的某一个依赖项。该模块应包含一个程序集清单。