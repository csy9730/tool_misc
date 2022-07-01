# uname

uname可以查看kernel版本，平台，设备名

## windows7 
### MINGW64
##### uname
```
$ uname -a
MINGW64_NT-6.1-7601 wwwserver2-1 3.1.6-340.x86_64 2020-07-09 14:33 UTC x86_64 Msys
```

## windows10 


### msys
##### uname
```
$ uname -a
MSYS_NT-10.0 DESKTOP-PGE4CMB 2.11.2(0.329/5/3) 2018-11-10 14:38 x86_64 Msys
```

### mingw32
##### uname
```
$ uname -a
MINGW32_NT-10.0 DESKTOP-PGE4CMB 2.11.2(0.329/5/3) 2018-11-10 14:38 x86_64 Msys
```

### MINGW64

##### uname
```
$ uname -a
MINGW64_NT-10.0 DESKTOP-PGE4CMB 2.11.2(0.329/5/3) 2018-11-10 14:38 x86_64 Msys
```

``` ini
kernel-name=MINGW64_NT-10.0
machine-hostname=DESKTOP-PGE4CMB
kernel-release=2.11.2(0.329/5/3)
kernel-version=2018-11-10 14:38
machine=
processor=
hardware-platform=x86_64
operating-system=Msys
```



##### /etc/lsb-release
```
$ cat /etc/lsb-release
cat: /etc/lsb-release: No such file or directory
```
##### /etc/issue
```
$ cat /etc/centos-release
cat: /etc/centos-release: No such file or directory
```

### wsl
##### uname
```
root@DESKTOP-PGE4CMB:/mnt/c # uname -a
Linux DESKTOP-PGE4CMB 4.4.0-18362-Microsoft #476-Microsoft Fri Nov 01 16:53:00 PST 2019 x86_64 x86_64 x86_64 GNU/Linux
```

``` ini
kernel-name=Linux
machine-hostname=DESKTOP-PGE4CMB
kernel-release=4.4.0-18362-Microsoft
kernel-version=#476-Microsoft Fri Nov 01 16:53:00 PST 2019 
machine=x86_64
processor=x86_64
hardware-platform=x86_64
operating-system=GNU/Linux
```

##### lsb_release
```
No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 18.04.2 LTS
Release:        18.04
Codename:       bionic
```

## DS918
##### uname
```

admin@DS918Plus:~$ uname -a
Linux DS918Plus 4.4.59+ #23824 SMP PREEMPT Tue Feb 12 16:52:55 CST 2019 x86_64 GNU/Linux synology_apollolake_918+
```

##### /etc/issue
```

admin@DS918Plus:~$ cat /etc/issue
cat: /etc/issue: No such file or directory

```

##### /proc
```
admin@DS918Plus:~$ cat /proc/version
Linux version 4.4.59+ (root@build3) (gcc version 4.9.3 20150311 (prerelease) (crosstool-NG 1.20.0) ) #23824 SMP PREEMPT Tue Feb 12 16:52:55 CST 2019
```


## ubuntu
##### uname
```
Linux shannon-Virtual-Machine 5.3.0-40-generic #32~18.04.1-Ubuntu SMP Mon Feb 3 14:05:59 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux
```

``` ini
kernel-name=Linux
machine-hostname=shannon-Virtual-Machine
kernel-release=5.3.0-40-generic
kernel-version=#32~18.04.1-Ubuntu SMP Mon Feb 3 14:05:59 UTC 2020 
machine=x86_64
processor=x86_64
hardware-platform=x86_64
operating-system=GNU/Linux
```

### centos
##### uname
```
Linux VM_0_15_centos 3.10.0-1062.4.1.el7.x86_64 #1 SMP Fri Oct 18 17:15:30 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux     
```

``` ini
kernel-name=Linux
machine-hostname=VM_0_15_centos
kernel-release=3.10.0-1062.4.1.el7.x86_64
kernel-version=#1 SMP Fri Oct 18 17:15:30 UTC 2019
machine=x86_64
processor=x86_64
hardware-platform=x86_64
operating-system=GNU/Linux
```
##### lsb_release
```
lsb_release -a                            
LSB Version:    :core-4.1-amd64:core-4.1-noarch:cxx-4.1-amd64:cxx-4.1-noarch:desktop-4.1-amd64:desktop-4.1-noarch:languages-4.1-amd64:languages-4.1-noarch:printing-4.1-amd64:printing-4.1-noarch                           
Distributor ID: CentOS                                 
Description:    CentOS Linux release 7.7.1908 (Core)   
Release:        7.7.1908                               
Codename:       Core  
```

##### /etc/redhat-release
```
➜  ssd_mobilenet_v1 cat /etc/redhat-release
CentOS Linux release 7.9.2009 (Core)
```

```
➜  ssd_mobilenet_v1 cat /etc/centos-release
CentOS Linux release 7.9.2009 (Core)
```

```
➜  ssd_mobilenet_v1 cat /etc/lsb-release
cat: /etc/lsb-release: No such file or directory
```

##### /etc/issue
```
ssd_mobilenet_v1 cat /etc/issue
\S
Kernel \r on an \m
```
##### /proc/version
```
➜  ssd_mobilenet_v1 cat /proc/version
Linux version 3.10.0-1160.15.2.el7.x86_64 (mockbuild@kbuilder.bsys.centos.org) (gcc version 4.8.5 20150623 (Red Hat 4.8.5-44) (GCC) ) #1 SMP Wed Feb 3 15:06:38 UTC 2021
```

### docker ubuntu
##### uname
```
Linux 2b3b2ee838c1 3.10.0-1160.15.2.el7.x86_64 #1 SMP Wed Feb 3 15:06:38 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux    
```

##### /etc/lsb-release

```
root@2b3b2ee838c1:/# cat /etc/lsb-release
DISTRIB_ID=Ubuntu
DISTRIB_RELEASE=20.04
DISTRIB_CODENAME=focal
DISTRIB_DESCRIPTION="Ubuntu 20.04 LTS"
root@2b3b2ee838c1:/#
```
##### /etc/issue
```
cat /etc/issue         
Ubuntu 20.04 LTS \n \l    
```

## system
Linux不源于任何版本的UNIX的源代码，并不是UNIX，而是一个类似于UNIX的产品。
主流的Linux发行版　：Ubuntu， Debian GNU/Linux ，Fedora ，Gentoo ，MandrivaLinux ，PCLinuxOS，Slackware Linux ，openSUSE，ArchLinux，Puppylinux，Mint, CentOS,Red Hat等。

从产品方面看，UNIX和Linux都是操作系统的名称．但UNIX这四个字母除了是操作系统名称外，还作为商标归SCO所有．
Linux商业化的有RedHat Linux 、SuSe Linux、slakeware Linux、国内的红旗等，还有Turbo Linux.
UNIX主要有Sun 的Solaris、IBM 的AIX,　HP的HP-UX，以及x86平台的的SCO 。UNIX/UNIXwareUNIX多数是硬件厂商针对自己的硬件平台的操作系统，主要与CPU等有关，如Sun 的Solaris作为商用，定位在其使用SPARC/SPARCII的CPU的工作站及服务器上，当然Solaris也有x86的版本，而Linux也有其于RISC的版本。


## 总结
以下总结了4种区分centos和ubuntu系统的方法。

1、`lsb_release -a`

如果是想查看你的Linux系统是Ubuntu还是CentOS，可以使用`lsb_release -a`命令，`lsb_release -a`命令可以列出你的Linux系统是哪个Linux发行版，它还可以列出具体是第几个版本。（推荐：linux使用教程）

2、`cat /etc/redhat-release` && `cat /etc/lsb-release`

radhat或centos存在： /etc/redhat-release 这个文件【 命令 cat /etc/redhat-release 】

ubuntu存在 : /etc/lsb-release 这个文件 【命令 cat etc/lsb-release 】

3、`apt-get` && `yum`

有yum的就是Centos【yum -help】

有apt-get的就是Ubuntu 【apt-get -help】

4、`cat /etc/issue`

有Ubuntu字样为ubuntu，没有则是centos