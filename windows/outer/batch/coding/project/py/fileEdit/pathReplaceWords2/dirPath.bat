@echo off
echo %1 
for /r  %1 %%i in (*.*) do (
echo %%i
) 


