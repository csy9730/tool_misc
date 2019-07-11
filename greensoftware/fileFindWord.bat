@echo off
if {%2}=={}  goto noParam2 else (goto withParam2)

:withParam2
echo %2
python %~dp0\mFileFindWord.py %1 %2
goto :eof
:noParam2
python %~dp0\mFileFindWord.py
goto :eof