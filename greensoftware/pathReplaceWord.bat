@echo off
echo %1 
rem if {%3}=={}  goto :eof
for /r  %1 %%i in (*.*) do (
echo %%i
call fileReplaceWord.bat %%i  %2 %3
) 


