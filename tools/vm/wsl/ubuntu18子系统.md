# ubuntu子系统

## overview
wsl 是windows 管理linux子系统的工具，分为 wsl1 和 wsl2.

wsl 1 不需要hyperV；wsl2 需要 hyperV 虚拟化平台。


## install
### wsl1
通过以下方法安装wsl子系统
1. 开启wsl服务，重启电脑使服务生效
2. 打开应用商城搜索“WSL”，可根据自己需求选择安装一个或多个Linux系统：
3. 安装完成后可在开始菜单里找到快捷方式并启动，第一次运行需要等待安装并设置用户名、密码。


开启wsl服务：
- 管理员权限运行powershell并运行下面的命令：`Enable-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux`
- 或者：控制面板->程序和功能->启用或关闭Windows功能->勾选 适用于Linux的Windows子系统

安装Linux系统：
- 打开应用商城搜索“WSL”，点击下载，有 ubuuntu18，ubuntu20，debian14 等多个版本选择
- 通过 `wsl --install `


更新wsl 程序，`wsl --update` , 慎用，不知道会不会把wsl1更新成wsl2 

直接执行`wsl`可以进入wsl子系统（C:\Windows\System32\wsl.exe）

### wsl2
需要额外开启 hyperV。

wsl2 和 wsl1 都是 同一个 wsl，通过指定版本号切换。

```bash
# 指定版本号2
wsl --set-default-version 2
```
## usage


通过bash可以执行单条指令，（C:\Windows\System32\bash.exe）

`bash -c "ls /bin"`


### manager

以下命令2023年已经废弃，改用 wsl 实现。

``` bash
wslconfig /setdefault <DistributionName> # 设置默认运行的linux系统
wslconfig /unregister <DistributionName> # 卸载linux系统
wslconfig /unregeister ubuntu # 卸载ubuntu系统
wslconfig /list # 查看已安装的linux系统

net stop LxssManager #  关闭wsl子系统服务
net start LxssManager # 开启wsl子系统服务
```

#### 自启动
wsl 不支持 systemd，所以无法实现自启动，新版wsl 支持了 systemd。


### 文件访问

``` cmd
rem 在win10环境下访问Ubuntu文件系统的home目录：
C:\Users\foo\AppData\Local\Packages\CanonicalGroupLimited.Ubuntu18.04onWindows_79rhkp1fndgsc\LocalState\rootfs\home
```

在Ubuntu系统下

``` bash
# 访问win10的home目录：
cd /mnt/c/Users/xxx


# 在WSL环境下可以创建一个访问win10的快捷方式
ln -s /mnt/c/Users/xxx ~/win10


# 在ubuntu下通过下面的命令直接进入win10的home目录
cd win10
```

### 基础操作
```bash
sudo apt update
sudo apt upgrade


# 切换 root 用户
sudo su root


# 开启 sshd
sudo service ssh start
```


### reference

[https://learn.microsoft.com/zh-cn/windows/wsl/install](https://learn.microsoft.com/zh-cn/windows/wsl/install)
