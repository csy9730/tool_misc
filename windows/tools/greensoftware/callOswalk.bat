@echo off
if {%1}=={}  goto noParam3 else (goto withParam3)
:withParam3
python %~dp0\fOswalkDir.py %1 
goto :eof
:noParam3 
python %~dp0\fOswalkDir.py
goto :eof