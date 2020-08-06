@echo off
cd /d %~dp0
echo d |xcopy  /s my_ladrc_bak my_ladrc
pathReplaceWord.bat my_ladrc  float Float
echo del  && pause
pause
rmdir  /s /q  my_ladrc
echo exit  && pause

