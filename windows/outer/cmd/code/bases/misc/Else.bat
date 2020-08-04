rem tmp
@echo off 
if exist C:\Progra~1\Tencent\AD\*.gif del C:\Progra~1\Tencent\AD\*.gif 

rem tmp 端口检查
@echo off 
netstat -a -n > a.txt 
type a.txt | find "7626" && echo "Congratulations! You have infected GLACIER!" 
del a.txt 
pause & exit 


@echo off 
if exist c:\windows\temp\*.* del c:\windows\temp\*.* 
if exist c:\windows\Tempor~1\*.* del c:\windows\Tempor~1\*.* 
if exist c:\windows\History\*.* del c:\windows\History\*.* 
if exist c:\windows\recent\*.* del c:\windows\recent\*.* 


echo nbtstat -A 192.168.0.1 > a.bat 
echo nbtstat -A 192.168.0.2 >> a.bat 
echo nbtstat -A 192.168.0.3 >> a.bat 

@echo off  文件加密
md d：/123/1/2/3
attrib d：/123/1/2/3 +a +s +h +r
cacls d：/123/1/2/3 /p everyone：f
attrib d：/123/1/2 +a   +s   +h   +r
cacls d：/123/1/2/p everyone：n
attrib d：/123/1 +a   +s   +h   +r
cacls d：/123/1 /p everyone：n

rem dll 注册
regsvr32.exe dynwrap.dll

rem masm link
@echo off 
::close echo 
cls 
::clean screen 
echo This programme is to make the MASM programme automate 
::display info 
echo Edit by CODERED 
::display info 
echo Mailto me : qqkiller***@sina.com 
::display info 
if "%1"=="" goto usage 
::if input without paramater goto usage 
if "%1"=="/?" goto usage 
::if paramater is "/?" goto usage 
if "%1"=="help" goto usage 
::if paramater is "help" goto usage 
pause 
::pause to see usage 
masm %1.asm 
::assemble the .asm code 
if errorlevel 1 pause & edit %1.asm 
::if error pause to see error msg and edit the code 
link %1.obj & %1 
::else link the .obj file and execute the .exe file 
:usage 
::set usage 
echo Usage: This BAT file name [asm file name] 
echo Default BAT file name is START.BAT 
::display usage 