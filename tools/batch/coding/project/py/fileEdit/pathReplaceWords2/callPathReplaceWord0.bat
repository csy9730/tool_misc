@echo off
cd /d %~dp0
pathReplaceWord.bat my_ladrc  float Float
echo "123"
pathReplaceWord.bat my_ladrc  int ZalInt32
echo "456"
pathReplaceWord.bat my_ladrc  char ZalInt8
pathReplaceWord.bat my_ladrc  short ZalInt16
pathReplaceWord.bat my_ladrc  double ZalFloat64
pathReplaceWord.bat my_ladrc  "unsigned int" ZalUint32
pause

