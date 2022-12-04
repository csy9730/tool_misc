# wsl

win10的linux子系统wsl无法原生支持使用图形界面(X11)，
win10的linux子系统wsl2支持使用图形界面(X11)，

## help

### wsl --help
```
C:\Users\foo>wsl --help
版权所有 (c) Microsoft Corporation。保留所有权利。

用法: wsl.exe [参数] [选项...] [CommandLine]

用于运行 Linux 二进制文件的参数:

    如果未提供任何命令行，wsl.exe 将启动默认 shell。

    --exec, -e <CommandLine>
        在不使用默认 Linux shell 的情况下执行指定的命令。

    --
        按原样传递剩余的命令行。

选项:
    --distribution, -d <DistributionName>
        运行指定的分发。

    --user, -u <UserName>
        以指定用户身份运行。

用于管理 Windows Subsystem for Linux 的参数:

    --export <DistributionName> <FileName>
        将分发导出到 tar 文件。
        文件名可为 - 以便标准输出。

    --import <DistributionName> <InstallLocation> <FileName>
        将指定的 tar 文件作为新分发导入。
        文件名可为 - 以便标准输入。

    --list, -l [选项]
        列出分发。

        选项:
            --all
                列出所有分发，包括当前
                正在安装或卸载的分发。

            --running
                仅列出当前正在运行的分发。

    -setdefault, -s <DistributionName>
        将分发设置为默认值。

    --terminate, -t <DistributionName>
        终止分发。

    --unregister <DistributionName>
        注销分发。

    --upgrade <DistributionName>
        将分发升级为 WslFs 文件系统格式。

    --help
        显示用法信息。

```



```
C:\Users\foo>wsl --list
适用于 Linux 的 Windows 子系统:
Ubuntu-18.04 (默认)
```



### wslconfig
```
C:\Users\foo>wslconfig
在 Windows Subsystem for Linux 上执行管理操作

用法:
    /l, /list [选项]
        列出已注册分发。
        /all - 可选择列出所有分发，包括
               当前正在安装或卸载的分发。

        /running - 仅列出当前正在运行的分发。

    /s, /setdefault <DistributionName>
        将分发设置为默认值。

    /t, /terminate <DistributionName>
        终止分发。

    /u, /unregister <DistributionName>
        注销分发。

    /upgrade <DistributionName>
        将分发升级为 WslFs 文件系统格式。
```

```
C:\Users\foo>wslconfig /l
适用于 Linux 的 Windows 子系统:
Ubuntu-18.04 (默认)
```
