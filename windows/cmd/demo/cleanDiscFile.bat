rem LOCALAPPDATA=C:\Users\admin\AppData\Local
echo y| rmdir /s  "%LOCALAPPDATA%\CrashDumps"
rem rd /s /q \RECYCLED
echo y|del %tmp%\*

cleanmgr.exe