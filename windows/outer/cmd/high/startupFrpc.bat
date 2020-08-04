echo set ws=WScript.CreateObject("WScript.Shell")>"frpc.vbs"
echo ws.Run "cmd /c %~dp0frpc.exe -c  %~dp0frpc2.ini",vbhide >>"frpc.vbs"
copy frpc.vbs  "%programdata%\Microsoft\Windows\Start Menu\Programs\Startup" /y
