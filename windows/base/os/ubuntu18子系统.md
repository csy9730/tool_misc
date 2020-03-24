# ubuntu子系统

## install
通过以下方法安装wsl子系统
1. 开启wsl服务，重启电脑使服务生效
2. 打开应用商城搜索“WSL”，可根据自己需求选择安装一个或多个Linux系统：
3. 安装完成后可在开始菜单里找到快捷方式并启动，第一次运行需要等待安装并设置用户名、密码。

开启wsl服务：
管理员权限运行powershell并运行下面的命令：
`Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`
或者：控制面板->程序和功能->启用或关闭Windows功能->勾选 适用于Linux的Windows子系统
## overview
直接执行wsl可以进入wsl子系统（C:\Windows\System32\wsl.exe）
通过bash可以执行单条指令，（C:\Windows\System32\bash.exe）
`bash -c "ls /bin"`

## manager


``` bash
wslconfig /setdefault <DistributionName> # 设置默认运行的linux系统
wslconfig /unregister <DistributionName> # 卸载linux系统
wslconfig /unregeister ubuntu # 卸载ubuntu系统
wslconfig /list # 查看已安装的linux系统
```
## 文件访问

1. 在win10环境下访问Ubuntu文件系统的home目录：
`C:\Users\gd_cs\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu18.04onWindows_79rhkp1fndgsc\LocalState\rootfs\home`

2. 在Ubuntu系统下访问win10的home目录：
/mnt/c/Users/xxx
在WSL环境下可以创建一个访问win10的快捷方式

$ ln -s /mnt/c/Users/xxx ~/win10 
在ubuntu下通过下面的命令直接进入win10的home目录

$ cd win10
