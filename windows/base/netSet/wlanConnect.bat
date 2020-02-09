netsh interface ipv4 set address "WLAN" static 125.217.229.171 255.255.255.192 125.217.229.190 1
pause
netsh interface ipv4 set address  name="本地连接"  source=dhcp
netsh interface ip set dns name="本地连接" source=dhcp
pause
