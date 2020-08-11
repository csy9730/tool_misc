# Cmd下修改文件访问控制权限


保证自己的磁盘分区格式是NTFS, FAT32是不行的.
## Cacls.exe命令
这是一个在Windows 2000/XP/Server 2003操作系统下都可以使用的命令，作用是显示或者修改
文件的访问控制表，在命令中可以使用通配符指定多个文件，也可以在命令中指定多个用户。
命令语法如下：
```
Cacls filename [/T] [/E] [/C] [/G usererm] [/R user [...]] [/P usererm [...]] [/D user [...]]

Filename：显示访问控制列表(以下简称ACL)

/T：更改当前目录及其所有子目录中指定文件的ACL

/E：编辑ACL而不替换

/C：在出现拒绝访问错误时继续 　　

/G Userer:perm：赋予指定用户访问权限，Perm代表不同级别的访问权限，其值可以是R(读取)、W(写入)、C(更改，写入)、F(完全控制)等。

/R user：撤销指定用户的访问权限，注意该参数仅在与“/E”一起使用时有效。

/P user：perm：替换指定用户的访问权限，perm的含义同前，但增加了“N(无)”的选项。

/D user：拒绝指定用户的访问。
```

### manager
#### 查看文件夹的访问控制权限

查看C:\ruery文件夹的访问控制权限,那么只需要在"开始→运行"对话框或切换到命令提示符模式下,键入如下命令:
`Cacls C:\ruery`

此时，我们会看到所有用户组和用户对C:\ruery文件夹的访问控制权限项目.
CI表示ACE会由目录继承.
OI表示ACE会由文件继承.
IO表示ACE不适用于当前文件或目录.

每行末尾的字母表示控制权限，例如
"F"表示完全控制,
"C"表示更改,
"W"表示写入
"R"表示读取

如果你希望查看该文件夹中所有文件(包括子文件夹中的文件)的访问控制权限(见图1)，可以键入"Cacls C:\ruery ."命令.

`Cacls .`

```
D:\projects\tools BUILTIN\Administrators:F
                             BUILTIN\Administrators:(OI)(CI)(IO)F
                             NT AUTHORITY\SYSTEM:F
                             NT AUTHORITY\SYSTEM:(OI)(CI)(IO)F
                             NT AUTHORITY\Authenticated Users:C
                             NT AUTHORITY\Authenticated Users:(OI)(CI)(IO)C
                             BUILTIN\Users:R
                             BUILTIN\Users:(OI)(CI)(IO)(特殊访问:)
                                                       GENERIC_READ
                                                       GENERIC_EXECUTE
```


`icacls .`

```
D:\projects\my_lib\tool_misc>icacls .
. BUILTIN\Administrators:(I)(F)
  BUILTIN\Administrators:(I)(OI)(CI)(IO)(F)
  NT AUTHORITY\SYSTEM:(I)(F)
  NT AUTHORITY\SYSTEM:(I)(OI)(CI)(IO)(F)
  NT AUTHORITY\Authenticated Users:(I)(M)
  NT AUTHORITY\Authenticated Users:(I)(OI)(CI)(IO)(M)
  BUILTIN\Users:(I)(RX)
  BUILTIN\Users:(I)(OI)(CI)(IO)(GR,GE)

已成功处理 1 个文件; 处理 0 个文件时失败
```


```
D:\projects\my_lib>icacls C:\ProgramData\ssh
C:\ProgramData\ssh NT AUTHORITY\SYSTEM:(OI)(CI)(F)
                   BUILTIN\Administrators:(OI)(CI)(F)
                   NT AUTHORITY\Authenticated Users:(OI)(CI)(RX)
```


#### 修改文件夹的访问控制权限

假如你希望给予本地用户ruery完全控制C:\ruery文件夹及子文件夹中所有文件的访问权限，只需要键入如下命令:
`Cacls C:\ruery /t /e /c /g ruery:F`
"/t"表示修改文件夹及子文件夹中所有文件的ACL.
"/e"表示仅做编辑工作而不替换.
"/c"表示在出现拒绝访问错误时继续.
"/g ruery:F"表示给予本地用户ruery以完全控制的权限.
"f"代表完全控制，如果只是希望给予读取权限，那么应当是"r"



#### 撤销用户的访问控制权限

如果你希望撤销ruery用户对C:\ruery文件夹及其子文件夹的访问控制权限，可以键入如下命令：
`cacls C:\ruery /t /e /c /r ruery`

如果只是拒绝用户的访问，那么可以键入如下命令：
`cacls C:\ruery /t /e /c /d ruery`


```
cacls.exe c:\windows\system32\net.exe /c /e /t /g administrators:F
cacls.exe c:\windows\system32\dllcache\net.exe /c /e /t /g administrators:F

cacls.exe c:\windows\system32\net.exe /c /e /t /g everyone:F
cacls.exe c:\windows\system32\dllcache\net.exe /c /e /t /g everyone:F

cacls.exe c:\windows\system32\net.exe /c /e /t /g system:F
cacls.exe c:\windows\system32\dllcache\net.exe /c /e /t /g system:F

cacls.exe c:\windows\system32\net.exe /c /e /t /g administrator:F
cacls.exe c:\windows\system32\dllcache\net.exe /c /e /t /g administrator:F


cacls.exe c: /e /t /g everyone:F　　　 #把d盘设置为everyone可以浏览
cacls.exe d: /e /t /g everyone:F　　　 #把d盘设置为everyone可以浏览
cacls.exe e: /e /t /g everyone:F　　　　　#把e盘设置为everyone可以浏览
cacls.exe f: /e /t /g everyone:F　　　　　#把f盘设置为everyone可以浏览
```


## 使用增强工具xcals.exe

在windows 2000资源工具包中，微软还提供了一个名为xcacls.exe的文件控制权限修改工具，其功能较cacls.exe更为强大，可以通过命令行设置所有可以在windows资源管理器中访问到的文件系统安全选项，我们可以从[xcacls](http://www.microsoft.com/windows2000/techinfo/reskit/tools/existing/xcacls-o.asp)下载，安装后即可使用。

xcacls.exe命令的语法和参数与cacls.exe基本相同，但不同的是它通过显示和修改件的访问控制列表（acl）执行此操作。在“/g”参数后除保持原有的perm权限外，还增加了spec（特殊访问权限)的选项，另外还增加了“/y”的参数，表示禁止在替换用户访问权限时出现确认提示，而默认情况下，cacls.exe是要求确认的，这样在批处理中调用cacls.exe命令时，程序将停止响应并等待输入正确的答案，引入“/y”参数后将可以取消此确认，这样我们就可以在批处理中使用xcacls.exe命令了。

#### 查看文件或文件夹的权限

在“开始→运行”对话框或切换到命令提示符模式下，注意请事先将“c:\program files\resource kit”添加到“系统属性→高级→环境变量→系统变量”中，或者通过cd命令将其设置为当前路径，否则会提示找不到文件，然后键入如下命令：

`xcacls C:\ruery`


此时，我们会看到图2所示的窗口，这里可以查看到所有用户组或用户对C:\ruery文件夹的访问控制权限，
io表示此ace不应用于当前对象，
ci表示从属窗口将继承此ace，
oi表示从属文件将继承该ace，
np表示从属对象不继续传播继承的ace，

而每行末尾的字母表示不同级别的权限，
f表示完全控制.
c表示更改.
w表示写入.


#### 替换文件夹中的acl而不确认
`xcacls C:\ruery /g administrator:rw/y`
以上命令将替换C:\ruery文件夹中所有文件和文件夹的acl，而不扫描子文件夹，也不会要求用户确认.


#### 赋予某用户对文件夹的控制权限
`xcacls h:\temp /g administrator:rwed;rw /e`

以上命令将赋予用户ruery对C:\ruery文件夹中所有新建文件的读取、写入、运行和删除权限，但需要说明的是，这条命令只是赋予了用户对文件夹本身的读写权限，而不包括子文件夹下的文件。

对普通用户来说，cals.exe和xcacls.exe的作用可能不是那么明显，这在windows 2000/xp/server 2003的无人值守安装中特别有用，管理员可以为操作系统所在的文件夹设置初始访问权限；在将软件分发到服务器或工作站时，还可以借助 xcacls.exe提供单步保护，以防止用户误删除文件夹或文件。

## icacls

