@echo off
set /p username=请输入用户名：
set /p password=请输入密码：
set "sign=bat cmd vbs vb minecraft minecraftpe"
cls
curl -d "username=%username%&password=%password%" -c cookie.txt http://wappass.baidu.com/passport/ >nul 2>nul
for %%a in (%sign%) do call:sign %%a
del /s /q cookie.txt >nul 2>nul
cls
echo 签到完成！
pause
exit

:sign
set "bar=%1"
echo 正在签到%bar%吧……
curl -o load.htm -b cookie.txt http://wapp.baidu.com/f?kw=%bar% >nul 2>nul
cscript //nologo ascii.vbs load.htm
for /f "tokens=1 delims=签" %%i in (load.htm.ansi.htm) do (
  for /f "tokens=2 delims=级" %%j in ("%%i") do (
    for /f "tokens=4 delims=<" %%k in ("%%j") do (
      setlocal enabledelayedexpansion
      set link=%%k
      set link=!link:~8,-2!
      set link=http://wapp.baidu.com!link:amp;=!
      curl -b cookie.txt !link! >nul 2>nul
      endlocal
    )
  )
)
del /s /q load.html >nul 2>nul
del /s /q load.htm.ansi.htm >nul 2>nul
goto:eof