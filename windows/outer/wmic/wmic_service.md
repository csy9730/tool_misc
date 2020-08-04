# wmic service

## help

```
SERVICE - 服务应用程序管理。

提示: BNF 的别名用法。
(<别名> [WMI 对象] | <别名> [<路径 where>] | [<别名>] <路径 where>) [<谓词子句>]。

用法:

SERVICE ASSOC [<格式说明符>]
SERVICE CALL <方法名称> [<实际参数列表>]
SERVICE CREATE <分配列表>
SERVICE DELETE
SERVICE GET [<属性列表>] [<获取开关>]
SERVICE LIST [<列表格式>] [<列表开关>]
```


### field

`wmic service list /format:csv>>service.csv`

AcceptPause  
AcceptStop  
CaptionCheckPoint  
CreationClassName  
DelayedAutoStart  
DescriptionDesktopInteract  
DisplayNameErrorControl  
ExitCode  
InstallDate  
Name  
PathName  
ProcessId  
ServiceSpecificExitCode  
ServiceTypeStarted  
StartMode  
StartNameStateStatus   
SystemCreationClassName  
SystemName   
TagId  
WaitHint 

### call
``` 


H:\project\tool_misc>wmic service call /?

方法执行操作。
用法:

CALL <方法名称> [<实际参数列表>]
注意: <实际参数列表> ::= <实际参数> | <实际参数>,  <实际参数列表>

可以使用以下别名谓词/方法:

调用                    [ 内/外 ]参数类型(&T)                   状态
====                    =====================                   ======
Change                  [IN ]DesktopInteract(BOOLEAN)           (null)

                        [IN ]DisplayName(STRING)

                        [IN ]StartPassword(STRING)

                        [IN ]ErrorControl(UINT8)

                        [IN ]LoadOrderGroup(STRING)

                        [IN ]LoadOrderGroupDependencies(ARRAY OF STRING)

                        [IN ]PathName(STRING)

                        [IN ]ServiceDependencies(ARRAY OF STRING)

                        [IN ]ServiceType(UINT8)

                        [IN ]StartMode(STRING)

                        [IN ]StartName(STRING)

ChangeStartMode         [IN ]StartMode(STRING)                  (null)

Create                  [IN ]DesktopInteract(BOOLEAN)           (null)

                        [IN ]DisplayName(STRING)

                        [IN ]StartName(STRING)

                        [IN ]StartPassword(STRING)

                        [IN ]ErrorControl(UINT8)

                        [IN ]LoadOrderGroup(STRING)

                        [IN ]LoadOrderGroupDependencies(ARRAY OF STRING)

                        [IN ]Name(STRING)

                        [IN ]PathName(STRING)

                        [IN ]ServiceDependencies(ARRAY OF STRING)

                        [IN ]ServiceType(UINT8)

                        [IN ]StartMode(STRING)

Delete                                                          (null)
InterrogateService                                              (null)
PauseService                                                    (null)
ResumeService                                                   (null)
StartService                                                    (null)
StopService                                                     (null)

UserControlService      [IN ]ControlCode(UINT8)                 (null)


H:\project\tool_misc>
```