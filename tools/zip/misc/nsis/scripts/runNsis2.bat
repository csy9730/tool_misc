set path=%path%;C:\Program Files (x86)\NSIS\;
cd %~dp0\example
del data.7z
cp ../a3.nsi .
tools\7z.exe a data.7z data
"makensis" a3.nsi
del a3.nsi
del data.7z
echo "finishe" &&pause
