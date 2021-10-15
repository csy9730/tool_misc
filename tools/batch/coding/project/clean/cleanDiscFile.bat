rem LOCALAPPDATA=C:\Users\admin\AppData\Local
echo "删除CrashDumps文件夹"
echo y| rmdir /s  "%LOCALAPPDATA%\CrashDumps"

echo "清空回收站"
rem rd /s /q \RECYCLED

echo "清空tmp文件夹"
echo y|del %tmp%\*

cleanmgr.exe