cd /d %~dp0
echo y|copy bak\zal_leso.h  zal_leso.h
rem call fileReplaceWord.bat zal_leso.h  "float"   ZalFloat\n
rem pause
call fileReplaceWord.bat zal_leso.h  \bfloat\b   ZalFloat
rem pause
call fileReplaceWord.bat zal_leso.h  void ZalVoid\n
echo del && pause
del zal_leso.h
pause