# mstsc

如何开启mstsc服务？
系统管理->服务 里面的RDS服务

## feature

mstsc使用rdp协议，使用本地显卡渲染，与teamviewer的远程差分局部渲染不同。

## misc

**Q**: mstsc无法连接，如何处理？ 
**A**:
1. 检查网络连接，主机和客户机相互ping，确保相互能够访问
2. 检查3389端口，通过`netstat -an` 
3. 检查防火墙是否支持

**Q**: 如何查看ip地址和账户？
**A**：通过`ipconfig`查看ip，通过`net user`查看账户


**Q**: mstsc发送大文件(大于2GB)容易失败
**A**：尝试分割文件成小文件。


**Q**: 如何开启3389端口？
**A**：

修改注册表：
`REG ADD HKLM\SYSTEM\CurrentControlSet\Control\Terminal" "Server /v fDenyTSConnections /t REG_DWORD /d 00000000 /f`
**Q**: 如何修改3389端口？
**A**：
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server\ Wds\rdpwd\Tds\tcp ，修改PortNamber值，默认值是3389

## misc

``` bash
mstsc [default.rdp] [/v:server:[:port]]  [/admin] [/fullscreen]
rdpclip.exe
wmic RDTOGGLE WHERE ServerName='%COMPUTERNAME%' call SetAllowTSConnections 1
```
## RDPWRAP

Windows 10 家庭版中取消了远程桌面服务端，想通过远程连接到自己的电脑就很麻烦了，第三方远程桌面速度又不理想(如TeamViewer)。通过以下方法可让系统恢复远程桌面功能
通过使用rdpwrap，可以启用Win10家庭版中被阉割的远程桌面服务端。
同时还可以允许通过mstsc实现多用户同时登陆
[rdpwrap](https://github.com/stascorp/rdpwrap/releases)
``` bash
autoupdate.bat # update
helper
install.bat # call RDPWInst.exe (not important)
RDPCheck.exe # check rdp if can run
RDPConf.exe # view install status & config rdp port 
RDPWInst.exe
rdpwrap.dll
rdpwrap.ini
rdpwrap_new.ini
uninstall.bat
update.bat
```

使用方法：
1. 执行RDPCheck.exe
2. 以管理员权限执行install.bat
3. 对于特殊版本，需要以管理员权限执行autoupdate.bat更新程序
4. 确认程序安装成功，服务可以运行，端口开启成功

安装目录一般位于`C:\Program Files\RDP Wrapper`

![rdpconfig](./img/rdpconfig.jpg)