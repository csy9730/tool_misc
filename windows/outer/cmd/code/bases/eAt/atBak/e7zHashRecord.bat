@echo off
set src=E:\SVN\gs\workspace\source\ginv_cpu1
set dsc=E:\SVN\gs\misc\bak\sourceBak
set path=C:\Program Files\7-Zip\;%path%
set dt=%date:~0,4%%date:~5,2%%date:~8,2%%time:~0,2%%time:~3,2%%time:~6,2%
if {%1}=={}  (
	echo goto noParam
)else ( set src=%1  
		echo %1)
if {%2}=={}  (
	echo goto noParam2
)else ( set dsc=%2
		echo %2)
set logFile=%dsc%\7zHashRecord.log
set logFile2=%dsc%\7zHashRecord2.log
rem 7z.exe  a matSave2.7z %1
rem 7z.exe  h matSave2.7z >a.txt
7z.exe  h %src% >"a.txt"

type a.txt | find "data" > "a2.txt"
set /p var=< "a2.txt"
del "a.txt"
del "a2.txt"
set var2=%var: =%
set var3=%var2:CRC32fordata:=%
echo %var3%

set equFlag=0
if not exist %dsc% (mkdir %dsc%) 
if not exist %logFile% (
	echo newCrc32=%var3%
	echo %var3%>>%logFile%
	echo %var3%;%dt%>%logFile2%
	7z.exe  a %dsc%/_%dt%.7z %src%
	goto :eof
)
for /f %%i in (%logFile% ) do (
	if "%%i"=="%var3%" (
		set equFlag=1
	) 
)

if %equFlag%==0 (
	echo "not equal"
	echo %var3%>>%logFile%
	echo %var3%;%dt%>>%logFile2%
	 7z.exe  a %dsc%/bak_%dt%.7z %src% ) else echo " exist equal"
	rem 7z.exe  a matSave2.7z %1


goto :eof
:noParam
echo noParam
