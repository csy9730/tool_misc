@echo off
echo "��ʼ�����å���"

sc stop AlibabaProtect
sc delete AlibabaProtect  
rm -r  "/mnt/c/Program Files (x86)/AlibabaProtect"
echo "AlibabaProtect�Ѿ���ֹ"


sc stop XLServicePlatform
sc delete XLServicePlatform
echo "Ѹ�׷����Ѿ���ֹ"

sc delete QPCore
sc stop QPCore
sc stop QQLiveService
rm "G:\Program Files (x86)\Tencent\QQLive\QQLiveService.exe"
schtasks /delete /f /TN "WeChat" 
taskkill /IM   qqprotect.exe  /F
taskkill /IM   qqeimGuard.exe /IM qqeimPlatform.exe /F
echo "��ҵqq�Ѿ���ֹ"

sc stop QiyiService
sc delete QiyiService

taskkill /IM QiyiService.exe  /f
echo "QiyiService�Ѿ���ֹ"

schtasks /delete  /f /tn "����PC�ͻ��˷���������"
taskkill /IM dy_service.exe  /f
echo "dy_service�Ѿ���ֹ"


sc stop wpscloudsvr
sc disable wpscloudsvr
taskkill /IM   wps.exe /IM wpscenter.exe  /IM wpscloudlaunch.exe /F
schtasks /delete /f /TN "WpsUpdatetask_%username%" 
rem schtasks /delete /f /tn WpsExternal_admin_20190428132612 
schtasks|findstr "WpsExternal_%username%">"%TEMP%\sch_wps.txt"
for /f "delims= " %%i in ("%TEMP%\sch_wps.txt") do schtasks /delete /TN %%i
del "%TEMP%\sch_wps.txt"

echo "wps�Ѿ���ֹ"

schtasks /delete /f /tn "\OneDrive Standalone Update Task-S-1-5-21-900106002-500817109-700077563-1004"
schtasks /delete /f /tn "\OneDrive Standalone Update Task-S-1-5-21-900106002-500817109-700077563-1001"
echo "OneDrive update is stop"

taskkill /IM GooglePinyinDaemon.exe  /IM GooglePinyinService /f
sc stop GoogleChromeElevationService
schtasks /delete  /f /tn "GoogleUpdateTaskUserS-1-5-21-900106002-500817109-700077563-1001Core"
schtasks /delete  /f /tn "GoogleUpdateTaskUserS-1-5-21-900106002-500817109-700077563-1001UA"
schtasks /delete /f /tn "\GoogleUpdateTaskMachineUA"
schtasks /delete /f /tn "\GoogleUpdateTaskMachineCore"
sc stop gupdate 
echo "google update is stop"

sc stop AdobeARMservice
sc delete AdobeARMservice
schtasks /delete /f /TN "Adobe Acrobat Update Task"
schtasks /delete /f /TN "AdobeAAMUpdater-1.0-%COMPUTERNAME%-%username%"
echo "Adobe Update�Ѿ���ֹ"


schtasks /delete /f /TN  "�������Ű�ȫ�ؼ���ȫ�������"

sc stop "CAJ Service Host"
sc delete "CAJ Service Host"
sc stop SangforSP
sc delete SangforSP
sc stop SGSCenter
sc delete SGSCenter
sc stop SecoClientService
sc delete SecoClientService
sc stop TeamViewer
echo "finished"