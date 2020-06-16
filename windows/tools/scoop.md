# scoop

## install
要求powershell3或以上版本， .NET Framework 4.5或以上版本。

在 PowerShell 中输入下面内容，保证允许本地脚本的执行：

`set-executionpolicy remotesigned -scope currentuser`

然后执行下面语句进行安装：

`iex (new-object net.webclient).downloadstring('https://get.scoop.sh')`

即可安装scoop。

安装完成后，还需要添加软件源，不然会有好些软件能search到但是不能install.

默认安装路径`C:\Users\<user>\scoop`
## demo
```
scoop install sudo
sudo scoop install 7zip git openssh --global
scoop install aria2 curl grep sed less touch
scoop install python ruby go perl

```
## bucket
scoop拥有多个bucket，每个bucket相当于多个软件集合，scoop自带了main bucket，main bucket收集了最常用的软件，包括软件信息，软件下载地址。
```
scoop bucket add extras
scoop bucket add versions
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