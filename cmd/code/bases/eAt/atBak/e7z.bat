
set path=C:\Program Files\7-Zip\;%path%
7z.exe  a matSave2.7z matSave2
7z.exe  a matSave.7z matSave
7z.exe  h matSave2.7z >a.txt
7z.exe  h matSave.7z  >b.txt

7z.exe h ginv1.7z ginv1
7z.exe h -scrccrc64 matSave2.7z
7z.exe" h -scrcSHA256 ginv1.7z


type a.txt | find "data" >a2.txt
set /p var=< "a2.txt"
echo %var%
del a2.txt
echo %var: =%
set var2=%var: =%
set var3=%var2:CRC32fordata:=%
echo %var3%

echo a.txt |set /p qwer=

set /p var=< "%dsc%bakCount.txt"
for /f %i in (dir)  do set abc=%i
for /f %i in ('dir')  do set abc=%i
for /f %i in ('type a.txt ^| find "data" ')  do set abc=%i

for /f %i in ("type a.txt^|find 'data' ")  do set abc=%i
for /f %i in ('type a.txt^|find "data " ')  do set abc=%i
for /f %i in ('type a.txt^|findstr data ')  do set abc=%i
