# PowerShell Remoting

第一步允许ps远程访问
在服务器端:
powershell执行:
`Enable-PsRemotings`
默认选择 Y 确定
第二部
在客户端执行命令:
`Set-Item wsman:\localhost\Client\TrustedHosts -value *`
允许远程访问服务器:
第三步:
powershell 执行
`Enter-PSSession 10.24.88.120 -Credential administrator`
输入密码既可以访问了.
其中win10的时候 需要将winrm 打开 管理员打开cmd 执行 winrm quickconfig 进行操作. 
