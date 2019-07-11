@echo off

if {%3}=={}  goto noParam3 else (goto withParam3)
:withParam3)
python %~dp0\mFileReplaceWord.py %1 %2 %3
goto endFiles
:noParam3 
python %~dp0\mFileReplaceWord.py
:endFiles
