regedit /e 1.reg "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp" 
type 1.reg | find "PortNumber" 
del 1.reg 
