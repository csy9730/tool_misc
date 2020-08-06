@echo off
set path=C:\Program Files\7-Zip\;%path%
cd /d  %~dp0%\..\..
rem for /r   \%%i in (*.*) do ( copy %%i   misc\tmp\%%i ) 
echo y | copy gsDebug.log  misc\tmp\gsDebug.log
echo y | copy TortoiseProcUpdate.bat  misc\tmp\TortoiseProcUpdate.bat
echo y | copy readme.txt  misc\tmp\readme.txt

7z.exe  a gsCollect.7z matlab   doc  py  source  workspace\source workspace\projcet  PCMonitorBuild\PCMonitor  PCMonitorBuild\doc  misc\tmp
pause
