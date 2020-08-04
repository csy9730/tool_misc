cd /d %~dp0
echo y|copy subdir_rulesBak.mk  subdir_rules.mk
call fileReplaceWord.bat subdir_rules.mk  E:/SVN/gs/workspace/   D:/code/SVN/gs/workspace/
pause
call fileReplaceWord.bat subdir_rules.mk  E:/greenSoftware/CCS7.1.0.00016   D:/greenSoftware/CCS7.1.0.00016
pause