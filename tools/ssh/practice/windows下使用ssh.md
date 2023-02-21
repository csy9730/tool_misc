# windows下使用ssh 

shell
- cmd
- powershell
- bash


ssh server
- linux openssh
- windows git bash msys
- windows msys2 
- windows cygwin
- windows win32-openssh
- Android termux sshd


终端或图形界面
- git-bash
- msys-gtk
- cygwin
- cmder
- browser+webssh
- windows_terminal



虚拟机
- vmware
- virtualbox
- wsl 
- hyperV
- docker


特殊命令
- winpty 
- sudo 
- tmux
- clipboard



git-bash sshd
msys2 sshd
windows default ssh, windows sshd
cygwin sshd



|ssh|terminal| error|
|---|---| ---|
|git_ssh|git-bash , wsl| stocked|
|git_ssh|git-bash , winpty wsl| ok|
|git_ssh|git-bash , cmd| tab error|
|git_ssh|cygwin , cmd| tab error|
|git_ssh|windows_terminal , powershell| tab error|
|git_ssh|windows_terminal , winpty powershell| tab ok|
|git_ssh|windows_terminal , winpty powershell, cmd| tab ok|


winpty, 支持使用minicom操作.


