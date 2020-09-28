@echo off
cd /d %~dp0

for /r  %~dp0\debug\   %%i in (makefile*) do (
echo %%i 
call fileReplaceWord.bat %%i  E:/SVN/gs/workspace/   D:/code/SVN/gs/workspace/
call fileReplaceWord.bat %%i  E:/greenSoftware/   D:/greenSoftware/
) 
pause
