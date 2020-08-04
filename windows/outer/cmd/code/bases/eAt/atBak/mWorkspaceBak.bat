@echo off
cd /d %~dp0
call e7zHashRecord.bat  E:\SVN\gs\workspace\source\ginv_cpu1 E:\SVN\gs\misc\bak\sourceBak
call e7zHashRecord.bat  E:\SVN\gs\workspace\source\gpfc_cpu1 E:\SVN\gs\misc\bak\pfcBak