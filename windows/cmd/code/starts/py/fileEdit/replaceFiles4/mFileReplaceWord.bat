cd /d %~dp0
echo y|copy bak\zal_leso.h  zal_leso.h
rem call fileReplaceWord.bat zal_leso.h  "float"   ZalFloat\n
rem pause
call fileReplaceWord.bat zal_leso.h  \bfloat\b   f"""loa"""t
rem pause
call fileReplaceWord.bat zal_leso.h  void ""
echo del && pause
del zal_leso.h
pause