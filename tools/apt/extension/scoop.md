# scoop

[scoop](https://github.com/lukesampson/scoop)


## install
要求powershell3或以上版本， .NET Framework 4.5或以上版本。
scoop 高版本要求powershell>5.0

在 PowerShell 中输入下面内容，保证允许本地脚本的执行：

`set-executionpolicy remotesigned -scope currentuser`

然后执行下面语句进行安装：

`iex (new-object net.webclient).downloadstring('https://get.scoop.sh')`

即可安装scoop。

[gitee scoop](https://gitee.com/zlata/scoop)

### 安装到指定目录
安装到指定目录(D:\tool\scoop)
```
[environment]::setEnvironmentVariable('SCOOP','D:\tool\scoop','User')
$env:SCOOP='D:\tool\scoop'
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
```

指定-g安装目录(D:\tool\scoop_global)
```
[environment]::setEnvironmentVariable('SCOOP_GLOBAL','D:\tool\scoop_global','Machine')
$env:SCOOP_GLOBAL='D:\tool\scoop_global'
scoop install -g app
```

## core
默认安装路径`C:\Users\<user>\scoop`

```
C:\Users\admin\scoop
- apps
    - scoop
- buckets
    - main
- cache
- shims

```


可执行程序路径：`C:\Users\admin\scoop\apps\scoop\current\bin\scoop.ps1`

命令行调用的路径：
```
$ C:\Users\admin>where scoop
C:\Users\admin\scoop\shims\scoop
C:\Users\admin\scoop\shims\scoop.cmd
```

persist ,这个目录下面放的是已安装软件的配置文件, 后续更新软件的时候这部分内容不会修改.
## demo
```
scoop install sudo
sudo scoop install 7zip git openssh --global
scoop install aria2 curl grep sed less touch
scoop install python ruby go perl

```

```
scoop help            #帮助
scoop list            #查看当前已安装软件
scoop info app        #查看软件信息
scoop install app     #安装软件
scoop search app      #搜索软件
scoop uninstall app   #卸载软件
scoop update app      #更新指定软件
scoop update *        #更新安装的软件和scoop

# 设置代理(http)
scoop config proxy 127.0.0.1:4412
```

## bucket
安装完成后，还需要添加软件源，不然会有好些软件能search到但是不能install.
scoop拥有多个bucket，每个bucket相当于多个软件集合，scoop自带了main bucket，main bucket收集了最常用的软件，包括软件信息，软件下载地址。
```
scoop bucket add extras
scoop bucket add versions
scoop bucket add nonportable
```

```
C:\>scoop bucket  known
main
extras
versions
nightlies
nirsoft
php
nerd-fonts
nonportable
java
games
jetbrains
```

下载地址： [nluug](https://ftp.nluug.nl/)
## help
```
Usage: scoop <command> [<args>]

Some useful commands are:

alias       Manage scoop aliases                                   
bucket      Manage Scoop buckets                                   
cache       Show or clear the download cache                       
checkup     Check for potential problems                           
cleanup     Cleanup apps by removing old versions                  
config      Get or set configuration values                        
create      Create a custom app manifest                           
depends     List dependencies for an app                           
export      Exports (an importable) list of installed apps         
help        Show help for a command                                
hold        Hold an app to disable updates                         
home        Opens the app homepage                                 
info        Display information about an app                       
install     Install apps                                           
list        List installed apps                                    
prefix      Returns the path to the specified app                  
reset       Reset an app to resolve conflicts                      
search      Search available apps                                  
status      Show status and check for new app versions             
unhold      Unhold an app to enable updates                        
uninstall   Uninstall an app                                       
update      Update apps, or Scoop itself                           
virustotal  Look for app's hash on virustotal.com                  
which       Locate a shim/executable (similar to 'which' on Linux) 


Type 'scoop help <command>' to get help for a specific command.
```
## misc
windows下的安装软件有：  scoop ，  chocolate，    nuget， winget
[winget](https://github.com/microsoft/winget-cli/releases)

chocolatey VS scoop
chocolatey权限要求高, scoop 使用-g安装才需要管理员权限, 默认普通用户权限.
scoop可以建软件包仓库, 如果官方仓库里没有想用的软件, 可以自己建一个仓库, 存放自己的软件.
chocolatey很多软件安装位置不固定, 会污染Path