@echo off
echo 111 >eTmptest.txt
echo 222 >>eTmptest.txt
find "222" eTmptest.txt
type eTmptest.txt|find "111" 
del eTmptest.txt
pause
