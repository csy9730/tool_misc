# CentOS



## 图形化界面安装



``` bash
yum upgrade -y 

 yum groupinstall "X Window System" 　//注意有引号
 yum groupinstall "GNOME Desktop" "Graphical Administration Tools" -y




```



```
systemctl set-default graphical.target
startx

ln -sf /lib/systemd/system/runlevel5.target  /etc/systemd/system/default.target

```



 Transaction check error:   file /boot/efi/EFI/centos from install of fwupdate-efi-12-5.el7.centos.x



 init 5 //切换到图形化界面
以下在控制台操作
依次输入1-2-q-yes-登录-设置