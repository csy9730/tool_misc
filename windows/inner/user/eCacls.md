# cacls

## base
Cacls：显示或修改文件的访问控制列表（ACL)

ICACLS:显示或修改自由访问控制表(Dacl) 上指定的文件，并指定目录中的文件应用于存储的 Dacl。

总结:显示或修改文件访问控制权限

相关术语：

一个DACL(Discretionary Access Control List),其指出了允许和拒绝某用户或用户组的存取控制列表，当一个进程需要访问安全对象，系统就会检查DACL来决定进程的访问权。如果一个对象没有DACL,则说明任何人对这个对象都可以拥有完全的访问权限。

一个SACL(System Acess Control List),其指出了在该对象上的一组存取方式（如：读，谢，运行等）的存取控制权限细节的列表

DACL和SACL构成了整个存取控制列表Access Control List,简称ACL,ACL中的每一项我们叫做ACE(Acess Control Entry)

以上是对DACL，SACL,ACL,ACE等相关术语的简要介绍。

## help
```
C:\Windows\system32>cacls /?

 注意: 不推荐使用 Cacls，请使用 Icacls。

 显示或者修改文件的访问控制列表(ACL)

 CACLS filename [/T] [/M] [/L] [/S[:SDDL]] [/E] [/C] [/G user:perm]
        [/R user [...]] [/P user:perm [...]] [/D user [...]]
    filename      显示 ACL。
    /T            更改当前目录及其所有子目录中
                  指定文件的 ACL。
    /L            对照目标处理符号链接本身
    /M            更改装载到目录的卷的 ACL
    /S            显示 DACL 的 SDDL 字符串。
    /S:SDDL       使用在 SDDL 字符串中指定的 ACL 替换 ACL。
                  (/E、/G、/R、/P 或 /D 无效)。
    /E            编辑 ACL 而不替换。
    /C            在出现拒绝访问错误时继续。
    /G user:perm  赋予指定用户访问权限。
                  Perm 可以是: R  读取
                               W  写入
                               C  更改(写入)
                               F  完全控制
    /R user       撤销指定用户的访问权限(仅在与 /E 一起使用时合法)。
    /P user:perm  替换指定用户的访问权限。
                  Perm 可以是: N  无
                               R  读取
                               W  写入
                               C  更改(写入)
                               F  完全控制
    /D user       拒绝指定用户的访问。
 在命令中可以使用通配符指定多个文件。
 也可以在命令中指定多个用户。

缩写:
    CI - 容器继承。
         ACE 会由目录继承。
    OI - 对象继承。
         ACE 会由文件继承。
    IO - 只继承。
         ACE 不适用于当前文件/目录。
    ID - 已继承。
         ACE 从父目录的 ACL 继承。
```


``` 
H:\project\GitHubs BUILTIN\Administrators:F
                   BUILTIN\Administrators:(OI)(CI)(IO)F
                   NT AUTHORITY\SYSTEM:F
                   NT AUTHORITY\SYSTEM:(OI)(CI)(IO)F
                   NT AUTHORITY\Authenticated Users:C
                   NT AUTHORITY\Authenticated Users:(OI)(CI)(IO)C
                   BUILTIN\Users:R
                   BUILTIN\Users:(OI)(CI)(IO)(:)
                                             GENERIC_READ
                                             GENERIC_EXECUTE
```

输出	ACE 的适用于
OI	对象继承,适用于此文件夹和文件
CI	(容器继承),适用于此文件夹和子文件夹
IO	仅继承, ACE不适用于当前文件/目录。
** (NP) ** -不传播继承

没有输出消息	仅此文件夹
(IO)(CI)	此文件夹、子文件夹和文件
(OI)(CI)(IO)	仅子文件夹和文件
(CI)(IO)	仅子文件夹
(OI)(IO)	仅文件





## Icacls


每行末尾的字母表示控制权限，例如
* "F"表示完全控制
* "C"表示更改
* "W"表示写入
* "R"表示读取
* M 修改访问权限
* RX -读取和执行访问

* D -Delete
* X -执行/遍历
* RC -读取控制
* GR -通用读取
* GW -泛型写入

### demo
若要将 C：\Windows 目录及其子目录中所有文件的 Dacl 保存到 ACLFile 文件，请键入：
`icacls c:\windows\* /save aclfile /t`

若要授予用户 User1 删除和写入名为 Test1 的文件的 DAC 权限，请键入：
`icacls test1 /grant User1:(d,wdac)`

若要向用户授予 SID S-1-1-0 删除和写入 DAC 权限的用户，请在名为 Test2 的文件中键入：
`icacls test2 /grant *S-1-1-0:(d,wdac)`

## 用户/组合内置安全体
```
  BUILTIN\Administrators:(I)(F)
  BUILTIN\Administrators:(I)(OI)(CI)(IO)(F)
  NT AUTHORITY\SYSTEM:(I)(F)
  NT AUTHORITY\SYSTEM:(I)(OI)(CI)(IO)(F)
  NT AUTHORITY\Authenticated Users:(I)(M)
  NT AUTHORITY\Authenticated Users:(I)(OI)(CI)(IO)(M)
  BUILTIN\Users:(I)(RX)
  BUILTIN\Users:(I)(OI)(CI)(IO)(GR,GE)

  guest
  administrator 
```

