cd /d %~dp0
echo y|copy gsDebugBak.log  gsDebug.log
set a=new^^^|edit
echo %a%
call fileFindWord.bat gsDebug.log "new.*|edit.*"
:: call fileFindWord.bat gsDebug.log new^^^|edit
pause
