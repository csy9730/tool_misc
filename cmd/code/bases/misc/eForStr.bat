@echo off
FOR /F "delims=" %%i in ('net user') do @echo %%i & echo.
pause
