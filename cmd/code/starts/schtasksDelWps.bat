taskkill /IM   wps.exe /IM wpscenter.exe /F
echo "wps已经终止"&pause
schtasks /delete  /f /tn WpsUpdateTask_admin
schtasks /delete /f /tn WpsExternal_admin_20190428132612

rem 查看所有任务
schtasks |grep -i WpsExternal |cut -d ' ' -f1

