# uname

uname可以查看kernel版本，平台，设备名
## msys
$ uname -a
MINGW64_NT-10.0 DESKTOP-PGE4CMB 2.11.2(0.329/5/3) 2018-11-10 14:38 x86_64 Msys
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

## wsl
root@DESKTOP-PGE4CMB:/mnt/c # uname -a
Linux DESKTOP-PGE4CMB 4.4.0-18362-Microsoft #476-Microsoft Fri Nov 01 16:53:00 PST 2019 x86_64 x86_64 x86_64 GNU/Linux

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

No LSB modules are available.
Distributor ID: Ubuntu
Description:    Ubuntu 18.04.2 LTS
Release:        18.04
Codename:       bionic

## ubuntu


Linux shannon-Virtual-Machine 5.3.0-40-generic #32~18.04.1-Ubuntu SMP Mon Feb 3 14:05:59 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

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
Linux VM_0_15_centos 3.10.0-1062.4.1.el7.x86_64 #1 SMP Fri Oct 18 17:15:30 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux     

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

lsb_release -a                            
LSB Version:    :core-4.1-amd64:core-4.1-noarch:cxx-4.1-amd64:cxx-4.1-noarch:desktop-4.1-amd64:desktop-4.1-noarch:languages-4.1-amd64:languages-4.1-noarch:printing-4.1-amd64:printing-4.1-noarch                           
Distributor ID: CentOS                                 
Description:    CentOS Linux release 7.7.1908 (Core)   
Release:        7.7.1908                               
Codename:       Core  

## system
Linux不源于任何版本的UNIX的源代码，并不是UNIX，而是一个类似于UNIX的产品。
主流的Linux发行版　：Ubuntu， Debian GNU/Linux ，Fedora ，Gentoo ，MandrivaLinux ，PCLinuxOS，Slackware Linux ，openSUSE，ArchLinux，Puppylinux，Mint, CentOS,Red Hat等。

从产品方面看，UNIX和Linux都是操作系统的名称．但UNIX这四个字母除了是操作系统名称外，还作为商标归SCO所有．
Linux商业化的有RedHat Linux 、SuSe Linux、slakeware Linux、国内的红旗等，还有Turbo Linux.
UNIX主要有Sun 的Solaris、IBM 的AIX,　HP的HP-UX，以及x86平台的的SCO 。UNIX/UNIXwareUNIX多数是硬件厂商针对自己的硬件平台的操作系统，主要与CPU等有关，如Sun 的Solaris作为商用，定位在其使用SPARC/SPARCII的CPU的工作站及服务器上，当然Solaris也有x86的版本，而Linux也有其于RISC的版本。

