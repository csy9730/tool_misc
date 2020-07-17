# nircmd



支持以下功能：
* 关闭开启屏幕
* 设置 加减音量
* 剪切板控制
* 创建快捷方式
* 快速关机/锁定
* 调整分辨率
* 截图
* 窗口控制
* 回收站
* 注册表
* 服务


``` bash
nircmd.exe changesysvolume 2000 
nircmd.exe changesysvolume -5000 
nircmd.exe setsysvolume 65535 

nircmd.exe monitor off 
nircmd.exe monitor on

nircmd.exe savescreenshot "shot.png" 
# 延迟2秒截图
nircmd.exe cmdwait 2000 savescreenshot "shot.png" 
nircmd.exe loop 10 60000 savescreenshot c:\temp\scr~$currdate.MM_dd_yyyy$-~$currtime.HH_mm_ss$.png

nircmd exitwin reboot
nircmd.exe exitwin poweroff 

nircmd stdbeep
nircmd speak text "Please visit the Web site of NirSoft at http://www.nirsoft.net" 2 80 

```


[nirsoft](https://launcher.nirsoft.net/downloads/index.html)