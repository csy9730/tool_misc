# telnet


开启telnet服务,对应23号端口
运行：services.msc  - 手动开启 telnet服务器 服务；
或者执行：`net start telnet`
防火墙里设置开通23端口

telnet 123.45.67.89

##　windows10
win10中没有默认安装telnet-server,只能开启telnet

 Install-WindowsFeature -name Telnet-Client 
  Install-WindowsFeature -name Telnet-Server
`dism /online /Enable-Feature /FeatureName:TelnetClient`
`dism /online /Enable-Feature /FeatureName:TelnetServer`

```
更改telnet服务启动类型[Auto|Disabled|Manual] wmic SERVICE where name="tlntsvr" set startmode="Auto"
wmic SERVICE where name="tlntsvr" call startservice # 运行telnet服务 
停止ICS服务 wmic SERVICE where name="ShardAccess" call stopservice
删除test服务 wmic SERVICE where name="test" call delete

dism /online /Get-Features
```

