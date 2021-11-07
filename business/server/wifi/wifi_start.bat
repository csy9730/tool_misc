netsh wlan set hostednetwork mode=allow ssid=ABC-PC key=61333333
pause
netsh wlan start hostednetwork
pause
netsh wlan stop hostednetwork
