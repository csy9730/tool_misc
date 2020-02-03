# hyper-V



要求CPU支持虚拟化，所以没有虚拟化的还是用vmware、virtualbox吧
开启服务：

打开控制面板，选择服务，打开“启用或关闭windows功能”，勾选hyper-V，重启即可。

程序位于`C:\Windows\System32\virtmgmt.msc`

默认调用方法：C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Administrative Tools\Hyper-V Manager.lnk

`%windir%\System32\mmc.exe "%windir%\System32\virtmgmt.msc`



![1574060835509](..\img\1574060835509.png)

## 新建虚拟机

点击右边快速创建

## 网络连接
对于xp系统，需要安装vmguest.iso

**Q**： 如何固定虚拟网卡的ip
**A**： 
## 文件共享
**Q**: 怎么实现Hyper-V中的虚拟机与主机的文件共享?
**A**: 
1. 使用mstsc远程登陆
2. 文件夹共享？


## commands
``` bash
Start-VM -VMName "虚拟机的名字1","虚拟机的名字2","虚拟机的名字n" # 管理员权限的powershell 中可以直接启动虚拟机，

```