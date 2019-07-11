$des = 'D:\DICM'
$phone = Get-ChildShellItem | where { $_.name -eq 'MI 8 Lite' }
Get-ChildShellItem -Path "$($phone.Path)\内部存储设备\Download\code" -Filter '(.*)|(.3gp)$' | foreach {
	#获取照片创建日期
	$datestr = $_.Parent.GetDetailsOf($_,3)
	$datestr = ([datetime]$datestr).ToString('yyyy-MM-dd')
	echo "copy "
	#新建日期文件夹
	$dir = Join-Path $des $datestr
	if( -not (Test-Path $dir) ) {
	mkdir $dir
	}
	echo "copy "
	# 复制文件
	Copy-ShellItem -Path $_ -Destination $dir
	# 或者移动文件
	# Move-ShellItem -Path $_ -Destination $dir
	echo "copyed"
}