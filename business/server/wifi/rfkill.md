# Ubuntu下在图形界面没有Enable Wi-Fi的时候

在终端使用`ifconfig wlan0 up`的时候报错
```
SIOCSIFFLAGS: Operation not possible due to RF-kill
```

使用`rfkill list`命令查看被被关闭的射频
```
0: hci0: Bluetooth
        Soft blocked: no
        Hard blocked: no
1: tpacpi_bluetooth_sw: Bluetooth
        Soft blocked: no
        Hard blocked: no
2: phy0: Wireless LAN
        Soft blocked: yes
        Hard blocked: no
3: phy1: Wireless LAN
        Soft blocked: yes
        Hard blocked: no
```
使用`rfkill unblock all`解锁设备
可以看到Wireless Lan的Soft blocked状态变成no了

这样就可以使用`ifconfig wlan0 up`命令使能无线接口了