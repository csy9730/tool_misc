taskkill /IM   wps.exe /IM wpscenter.exe  /IM wpscloudlaunch.exe /F
taskkill /IM   qqeimGuard.exe /IM qqeimPlatform.exe /F
echo "wps已经终止"&pause
schtasks /delete  /f /tn WpsUpdateTask_admin
schtasks /delete /f /tn WpsExternal_admin_20190428132612

rem 查看所有任务
rem schtasks |grep -i WpsExternal |cut -d ' ' -f1
rem  wpscloudlaunch.exe & wpscenter.exe  qingnse64.dll

schtasks /delete  /f /tn 斗鱼PC客户端服务启动器
schtasks /delete  /f /tn "WpsUpdateTask_admin"
schtasks /delete  /f /tn "RDP Wrapper Autoupdate"
schtasks /delete  /f /tn "\Microsoft\Windows\Application Experience\Microsoft Compatibility Appraiser"
schtasks /delete  /f /tn "\Microsoft\Windows\Customer Experience Improvement Program\Consolidator"
schtasks /delete  /f /tn "\Microsoft\Windows\Diagnosis\RecommendedTroubleshootingScanner"
schtasks /delete  /f /tn "\Microsoft\Windows\DiskDiagnostic\Microsoft-Windows-DiskDiagnosticDataCollector"
schtasks /delete  /f /tn "\Microsoft\Windows\LanguageComponentsInstaller\ReconcileLanguageResources"
schtasks /delete  /f /tn "\Microsoft\Windows\LanguageComponentsInstaller\Installation"
schtasks /delete  /f /tn "\Microsoft\Windows\Windows Error Reporting\QueueReporting"
schtasks /delete  /f /tn "\Microsoft\Windows\Autochk\Proxy"
schtasks /delete  /f /tn "GoogleUpdateTaskUserS-1-5-21-900106002-500817109-700077563-1001Core"
schtasks /delete  /f /tn "GoogleUpdateTaskUserS-1-5-21-900106002-500817109-700077563-1001UA"

