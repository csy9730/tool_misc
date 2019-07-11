@echo off
title ir
rem ren "E:\Code\IAR\gno\Methods" "Methods2%date%"
ren "E:\Code\IAR\gno\Methods\Methods" Methods2%random%
xcopy "E:\SVN\Gesture Monitor Diagram\Gesture Monitor\Methods" "E:\Code\IAR\gno\Methods\Methods" /e /i
echo "copy success"
pause
rem "//#undef _DEBUG"
E:\Code\IAR\gno\IAR_Lib\GestureMethodsLib.eww
echo "iar open success"
pause

set pthSend="E:\Code\IAR\gno\IAR_Lib\send"
ren "E:\Code\IAR\gno\IAR_Lib\send" send%random%
mkdir "E:\Code\IAR\gno\IAR_Lib\send" & copy "E:\Code\IAR\gno\IAR_Lib\Debug\Exe\GestureMethodsLib.lib"  "E:\Code\IAR\gno\IAR_Lib\send\GestureMethodsLib.lib" 
copy "E:\Code\IAR\gno\Methods\Methods\include\zal_fgrnex.h" "E:\Code\IAR\gno\IAR_Lib\send\zal_fgrnex.h" 
copy "E:\Code\IAR\gno\Methods\Methods\include\zal_arg_set.h" "E:\Code\IAR\gno\IAR_Lib\send\zal_arg_set.h"
echo "bak files success"

pause 
del "E:\Code\IAR\gno\IAR_Lib\send.7z"
"C:\Program Files\7-Zip\7z.exe"  a send.7z %pthSend%
echo "zip success"

del "C:\Users\admin\Desktop\send.7z"
copy "E:\Code\IAR\gno\IAR_Lib\send.7z" "C:\Users\admin\Desktop\send.7z"
echo "copy to desktop"
pause

rem 7z a archive1.zip subdir\

"C:\Program Files (x86)\Internet Explorer\iexplore.exe" http://apply/webfileout/b01.send_apply
echo "call IE "
pause

