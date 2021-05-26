# [Linux挂载U盘](https://www.cnblogs.com/dmj666/p/8031828.html)

linux是基于文件系统，所有的设备都会对应于：/dev/下面的设备。
   
## mount
以root用户登陆执行以下命令
``` bash
# 加载USB模块 
modprobe usb-storage

# 看看U盘的设备
fdisk -l
# 假如U盘是sda1


# 建立文件夹
mkdir /mnt/upan

# 执行挂载
mount  /dev/sda   /mnt/upan

# 访问目录
ls /mnt/upan
```


## umount
4，卸载u盘：在使用完u盘后，在拔出前需要先键入卸载U盘命令    

  命令如下：`umount /mnt/usb `


## 常见分区加载方法


**mount挂载iso文件**：
```
mkdir /mnt/iso1
mount –o loop linuxsetup.iso /mnt/iso1
```
linux 不需要虚拟光驱，就可以直接读取iso文件了。


- **mount挂载光驱系统**

一般来说CDROM的设备文件是/dev/hdc,使用方法:
``` bash
mkdir /mnt/cdrom
mount /dev/hdc /mnt/cdrom –o iocharset=cp936
```
默认不指定光驱系统，可以自动搜索得到,将编码指定为中文

- **mount挂载软驱**
``` bash
mkdir /mnt/floppy
mount /dev/fd0 /mnt/floppy
```
默认不指定文件系统，可以自动搜索得到

 
- **mount挂载windows共享文件(samba)**
- 
``` bash
mkdir /mnt/winshare
mount -t smbfs -o username=w,password=w,codepage=936,iocharset=gb2312 //192.168.0.101/share /mnt/winshare
```
指定访问共享的用户名，密码，codepage指定编码与iocharset同意义。这里的windows 系统是中文简体。
codepage指定文件系统的代码页，简体中文中文代码是936；iocharset指定字符集，简体中文一般用cp936或gb2312

- **mount挂载u盘**

如果计算机没有其它SCSI设备和usb外设的情况下，插入的U盘的设备路径是 `/dev/sda1`，用命令：
``` bash
mkdir /mnt/upan
mount /dev/sda1 /mnt/upan
```

- **mount挂载nfs系统**

与windows共享连接差不多。需要正确配置服务端的nfs服务。然后通过客户端的：`showmount -e 192.168.0.30` 可以查看连接。

`mount -t nfs 192.168.0.30:/tmp /mnt/nfs`

