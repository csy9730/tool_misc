@echo off
cd /d %~dp0
echo d |xcopy  /s my_ladrc_bak my_ladrc
for /r  %~dp0\my_ladrc\  %%i in (*.*) do (
echo %%i 
call fileReplaceWord.bat %%i  \bint\b   ZalInt32
call fileReplaceWord.bat %%i  \bshort\b   ZalInt16
call fileReplaceWord.bat %%i  \bchar\b   ZalInt8
call fileReplaceWord.bat %%i  \bunsigned\s+int\b   ZalUint32
call fileReplaceWord.bat %%i  \bunsigned\s+short\b    ZalUint16
call fileReplaceWord.bat %%i  \bunsigned\s+char\b    ZalUint8
call fileReplaceWord.bat %%i  \bfloat\b   ZalFloat
call fileReplaceWord.bat %%i  \bdouble\b   ZalDouble
call fileReplaceWord.bat %%i  \bvoid\b   ZalVoid
) 
echo del  && pause
rmdir  /s /q  my_ladrc
pause