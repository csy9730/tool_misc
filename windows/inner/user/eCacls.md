# cacls


## help
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
OI	此文件夹和文件
CI	此文件夹和子文件夹
IO	ACE 不适用于当前文件/目录。
没有输出消息	仅此文件夹
(IO)(CI)	此文件夹、子文件夹和文件
(OI)(CI)(IO)	仅子文件夹和文件
(CI)(IO)	仅子文件夹
(OI)(IO)	仅文件



## Icacls


## 用户/组合内置安全体

