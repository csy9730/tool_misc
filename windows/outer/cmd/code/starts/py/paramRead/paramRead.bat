@echo off
path =%path%;"D:\Python 3.5\"
cd /d %~dp0
if {%1}=={}  goto noParam
echo %1
"python.exe" paramBin2Txt.py %1
goto fileEnd
:noParam
"python.exe" paramBin2Txt.py 
:fileEnd
pause
rem "D:\Python 3.5\python.exe" D:\csy\py\paramRead\paramBin2Txt.py D:\csy\INV1_2018-04-27-16-01-19.bin