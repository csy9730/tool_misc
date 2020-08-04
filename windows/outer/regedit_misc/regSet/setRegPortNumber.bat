echo Windows Registry Editor Version 5.00 >1.reg 
echo. >>1.reg 
echo [HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\TelnetServer\1.0] >>1.reg 
echo "TelnetPort"=dword:00000913 >>1.reg 
echo "NTLM"=dword:00000001 >>1.reg 
echo. >>1.reg 
regedit /s 1.reg 
