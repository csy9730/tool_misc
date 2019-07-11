md %USERPROFILE%\.ssh
echo %~dp0
echo f|xcopy %~dp0id_rsa %USERPROFILE%\.ssh\id_rsa
echo f|xcopy %~dp0id_rsa.pub %USERPROFILE%\.ssh\id_rsa.pub
pause