regedit /e 9.reg "HKEY_CURRENT_USER\Environment" 

type 9.reg | find "path" 
del 9.reg 
pause
echo Windows Registry Editor Version 5.00 >1.reg 
echo. >>1.reg 
echo [HKEY_CURRENT_USER\Environment] >>1.reg 
echo "path"="E:\greenSoftware\;" >>1.reg 

echo. >>1.reg 
regedit /s 1.reg 