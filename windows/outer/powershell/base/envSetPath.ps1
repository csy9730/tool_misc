
$env:Path
# 环境变量的操作只会影响当前环境的副本，即当前powershell会话
$env:Path+=";C:\PowerShellmyscript"
pause


#下面的例子对当前用户设置环境变量，经测试，重新打开powershell仍然存在
[environment]::SetEnvironmentvariable("Path", ";c:\powershellscript", "User")
[environment]::GetEnvironmentvariable("Path", "User")

[environment]::SetEnvironmentvariable("Path", ";c:\MinGW\bin", "User")
[environment]::GetEnvironmentvariable("Path", "User")
pause
ls variable: 
#查看正在使用的变量