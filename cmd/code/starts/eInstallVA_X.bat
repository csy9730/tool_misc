CLS
@echo off

set src="E:\D\GreenSoftware\plugin\"

ECHO.
ECHO ��װ VA_X_Setup1918.exe
ECHO ���Ե�...
rem start /wait  (%src%VA\VA_X_Setup1918.exe  /s /v /qn)
start /wait "%src%VA\VA_X_Setup1918.exe"  "%src%VA\VA_X_Setup1918.exe"  /s /v /qn

ECHO.

rem dir /b /s >a.txt | findstr /n "a" a.txt
rem dir /b /s %USERPROFILE%/AppData/Local/Microsoft/VisualStudio/11.0 >a.txt | findstr  "VA_X.dll" aTemp.txt >bTemp.txt

dir /b /s %USERPROFILE%\AppData\Local\Microsoft\VisualStudio\11.0 >aTemp.txt 
findstr  "VA_X.dll" aTemp.txt >bTemp.txt
rem findstr  "VA_X.dll" a.txt >b.txt
rem set var= findstr  "VA_X.dll" a.txt 
rem set /a var= findstr  "VA_X.dll" a.txt 

set /p var=<bTemp.txt 
echo %var%
echo y |copy "%src%"\VA/VA_X.dll  %var% 
ECHO �滻VA_X.dll�ɹ�
del aTemp.txt bTemp.txt

ECHO.
ECHO ��װ CodeAlignment.vsix
ECHO ���Ե�...
start /wait "%src%\CodeAlignment.vsix" "%src%/CodeAlignment.vsix" /s /v/qn
ECHO.

pause
rem Visual Assist X Options => Advanced => UnderLines =>  UnderLines Spelling Error Uncheck