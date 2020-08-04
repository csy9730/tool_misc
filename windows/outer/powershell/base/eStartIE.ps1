$IEHost = New-Object -ComObject "InternetExplorer.Application"
$IEHost.Navigate("www.baidu.com")
$IEHost.Visible = $true
