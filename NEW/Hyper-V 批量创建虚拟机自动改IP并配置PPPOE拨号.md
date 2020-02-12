# Hyper-V 批量创建虚拟机自动改IP并配置PPPOE拨号



PowerShell 批量创建虚拟机：

``` powershell
#---------------------------批量创建虚拟机脚本20190314--------------------- 
#虚拟机存放路径
$VHDPath="d:\vhd\"
#虚拟机IP初始信息
$IP="192.168.185."
#虚拟机IP开始值
$IP_START=2
#准备创建虚拟机的数
​```量
$IP_ZENJIA=25
#虚拟机网卡名称
$NetworkName1="hgpppoe"
$NetworkName2="nat"
#拨号DNS+密码
$DNS1="202.103.44.150"
$DNS2="223.5.5.5"
$PPPOEWD="123789"
#虚拟机cpu核数 
$LogicPrecesserCount=2 
#虚拟机内存
$MomeryCount=2GB 
#模板位置 
$MasterDiskPath="C:\mupan.vhdx" 
#----------------------------下面部分不用修改------------------------ 
$IP_END=$IP_START+$IP_ZENJIA - 1
for($i=$IP_START;$i -le$IP_END;$i++) { 
$VMDIR = $VHDPath + $IP +$I 
#创建虚拟机磁盘存放的文件夹
mkdir $VMDIR 
#虚拟机名称
$VMName = $IP + $i + ".vhdx" 
#虚拟机文件所在的完整路径
$VMCFDIR = $VMDIR + "\" + $VMName
#拷贝母盘到虚拟机存放的目录下
Copy-Item $MasterDiskPath $VMCFDIR
#读取该虚拟机指定的拨号信息 
$PPPOE=(Get-Content C:\adsl.txt -TotalCount $I)[-1]
#创建一个虚拟机 
$HYName = $IP + $i + "/" + $PPPOE
New-VM -Name $HYName -path $VMDIR -MemoryStartupBytes $MomeryCount -VHDPath $VMCFDIR -SwitchName $NetworkName1
#到虚拟机磁盘目录
cd $VMDIR
#新建内网网卡信息
New-Item "ip.txt" -type File 
#写入内网网卡信息到文件
"IPADDR=$IP$I" |Out-File ip.txt -encoding utf8
#新建自动拨号脚本
New-Item "autoad.sh" -type File
#编辑自动拨号脚本
"pppoe-setup <<EOF" |Add-Content autoad.sh -encoding utf8 
" " |Add-Content autoad.sh -encoding utf8 
"$PPPOE" |Add-Content autoad.sh -encoding utf8 
"eth0" |Add-Content autoad.sh -encoding utf8
"no" |Add-Content autoad.sh -encoding utf8 
"$DNS1" |Add-Content autoad.sh -encoding utf8 
"$DNS2" |Add-Content autoad.sh -encoding utf8 
"$PPPOEWD" |Add-Content autoad.sh -encoding utf8 
"$PPPOEWD" |Add-Content autoad.sh -encoding utf8 
"yes" |Add-Content autoad.sh -encoding utf8 
"0" |Add-Content autoad.sh -encoding utf8 
"yes" |Add-Content autoad.sh -encoding utf8 
"y" |Add-Content autoad.sh -encoding utf8 
"EOF" |Add-Content autoad.sh -encoding utf8 
#拷贝生成iso的脚本到虚拟机目录
Copy-Item c:/iso.bat $VMDIR
#设置UltraISO环境变量
$Env:path=$Env:Path+";C:\Program Files (x86)\UltraISO" 
#执行生成iso脚本
cmd /c iso.bat
#虚拟机挂载iso文件
set-VMDvdDrive -VMName $HYName -path $VMDIR\ip.iso
#增加一个网卡适配器并挂载网卡
Add-VMNetworkAdapter $HYName -Name network2 
Connect-VMNetworkAdapter $HYName -Name network2 $NetworkName2
#设置虚拟机内核数量
Set-VMProcessor $HYName -Count $LogicPrecesserCount
#设置动态内存
#Set-VMMemory $HYName -StartupBytes 2048MB
#Set-VMMemory $HYName -DynamicMemoryEnabled $true -MaximumBytes 2048MB -MinimumBytes 800MB
#设置所有网卡的速率为20mb
#Set-VMNetworkAdapter –VMName $HYName -MaximumBandwidth 20000000
#删除网卡
#Remove-VMNetworkAdapter -VMName $HYName -VMNetworkAdapterName network2 
#开启路由器保护功能 
Set-VMNetworkAdapter $HYName -RouterGuard On
#启动虚拟朿
Start-VM -Name $HYName 
}
```



封装ISO镜像包 ISO.bat ：

ultraiso -volume iso -file "%cd%\ip.txt" -file "%cd%\autoad.sh" -output "%cd%\ip.iso"

centos自动修改IP和配置PPPOE拨号 autoad.sh：

\#!/bin/bash
mount /dev/cdrom /mnt
cp /mnt/ip.txt /ip.txt
cp /mnt/autoad.sh /autoad.sh
sed -i 's/^\xEF\xBB\xBF//g' /ip.txt
sed -i 's/^\xEF\xBB\xBF//g' /autoad.sh
dos2unix /ip.txt
dos2unix /autoad.sh
cat /ip.txt >>/etc/sysconfig/network-scripts/ifcfg-eth1
chmod 777 /autoad.sh
service network restart
sh /autoad.sh
rm -rf /ip.txt
rm -rf /autoad.sh
eject /dev/cdrom

创建虚拟机

1.将UltraISO.exe+iso.bat+adsl.txt+创建虚拟机改IP.PS1 拷贝到服务器C盘根目录
2.在服务器中安装UltraISO.exe ，安装目录使用默认路径，不要修改！
3.使用PowerShell打开脚本文件，修改模板文件路径、存放虚拟机的路径、网卡名称/速率、IP信息（只允许写IP,不要加其他信息）、机器配置/数量等信息
4.开始执行脚本，批量创建虚拟机并自动修改IP地址
5.使用PassPort软件，结合EXCEL批量 导入映射信息
6.测远程连接，虚拟机创建完成

CentOS母盘制作
1.修改网卡配置文件，将内网网卡配置文件中的"IPADDR=192.168.2.2"该行删除
2.将gaiip.sh 上传到系统/目录
3.添加gaiip.sh执行权限 
chmod +x /gaiip.sh
4.编辑开机启动项
vi /etc/rc.d/rc.local 
添加一行脚本路径
/gaiip.sh
添加开机启动项的执行权限
chmod +x /etc/rc.d/rc.local
5.将虚拟机关机，该虚拟机磁盘文件即为可用来制作自动创建虚拟机的系统模板





[参考](https://blog.51cto.com/biwei/2308671)