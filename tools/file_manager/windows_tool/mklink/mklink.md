# mklink


```
C:\Users\admin>mklink /?
创建符号链接。

MKLINK [[/D] | [/H] | [/J]] Link Target

        /D      创建目录符号链接。默认为文件
                符号链接。
        /H      创建硬链接而非符号链接。
        /J      创建目录联接。
        Link    指定新的符号链接名称。
        Target  指定新链接引用的路径
                (相对或绝对)。
```

## demo


``` batch
rem 为D:\sourceDir 创建符号链接C:\destDir
mklink /d "C:\destDir" "D:\sourceDir"
```


```
robocopy C:\Users\admin\.insightface D:\Documents\.insightface /MOVE
mklink /d C:\Users\admin\.insightface D:\Documents\.insightface

robocopy C:\Users\admin\scoop D:\Documents\scoop /MOVE /E
mklink /d C:\Users\admin\scoop D:\Documents\scoop


robocopy C:\Users\admin\AppData\Roaming\npm D:\Documents\npm /MOVE /E
mklink /d C:\Users\admin\AppData\Roaming\npm D:\Documents\npm

robocopy C:\Users\admin\.vscode D:\Documents\.vscode /MOVE /E
mklink /d C:\Users\admin\.vscode D:\Documents\.vscode


C:\Users\admin\AppData\Roaming\npm-cache
```
