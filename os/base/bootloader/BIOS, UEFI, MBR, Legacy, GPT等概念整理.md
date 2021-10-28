# BIOS, UEFI, MBR, Legacy, GPT等概念整理

[![Coldwind](https://pic1.zhimg.com/v2-767fdcc5e3adec06038b50a00937c747_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/jimzeus)

[Coldwind](https://www.zhihu.com/people/jimzeus)

程序员



83 人赞同了该文章

之前对以下概念的理解有些模糊并且比较容易混淆，因此抽空整理了一下，信息的主要来源是维基百科。



**分区表**是在磁盘（存储介质）上的，用于描述该磁盘的分区情况，有**GPT**和**MBR**两种格式。

**BIOS**和**UEFI**是固件接口标准，功能包括开机自检、启动流程（如何找到引导程序）、给操作系统和引导程序提供系统服务等。

**MBR**是引导扇区，包括最多446个字节的引导程序（通常是引导程序的前部）和MBR分区表，其中可以包括4个主分区。

**启动方式**是指如何主板上的固件在开机自检后如何找到引导程序，有**Legacy模式**（BIOS + MBR）和**UEFI模式**（UEFI _+ GPT）



## **固件接口标准**

- BIOS

IBM推出的业界标准的固件接口，存储于主板的ROM/EEPROM/flash中，提供的功能包括：

1. 开机自检
2. 加载引导程序（MBR中的，通常是bootloader的第一级）
3. 向OS提供抽象的硬件接口

PS：CMOS是PC上的另一个重要的存储器，用于保存BIOS的设置结果，CMOS是RAM。



- EFI/UEFI

Unified Extensible Firmware Interface，架设在系统固件之上的软件接口，用于替代BIOS接口，EFI是UEFI的前称。

一般认为，UEFI由以下几个部分组成：

1. Pre-EFI初始化模块
2. EFI驱动程序执行环境（DXE）
3. EFI驱动程序
4. 兼容性支持模块（CSM）
5. EFI高层应用
6. [GUID磁盘分区表](https://zh.wikipedia.org/wiki/%E5%85%A8%E5%B1%80%E5%94%AF%E4%B8%80%E6%A8%99%E8%AD%98%E5%88%86%E5%8D%80%E8%A1%A8)（GPT）

通常初始化模块和DXE被集成在一个ROM中；EFI驱动程序一般在设备的ROM中，或者ESP中；EFI高层应用一般在ESP中。CSM用于给不具备UEFI引导能力的操作系统提供类似于传统BIOS的系统服务。



## **启动方式**

- Legacy mode

即通过MBR/BIOS进行引导的传统模式，流程如下：

1. BIOS加电自检（Power On Self Test -- POST）。

2. 读取主引导记录（MBR）。BIOS根据CMOS中的设置依次检查启动设备：将相应启动设备的第一个扇区（也就是MBR扇区）读入内存。

3. 1. 检查MBR的结束标志位是否等于55AAH，若不等于则转去尝试其他启动设备，如果没有启动设备满足要求则显示"NO ROM BASIC"然后死机。
   2. 当检测到有启动设备满足要求后，BIOS将控制权交给相应启动设备的MBR。

4. 根据MBR中的引导代码启动[引导程序](https://zh.wikipedia.org/wiki/%E5%BC%95%E5%AF%BC%E7%A8%8B%E5%BA%8F%22%20%5Co%20%22%E5%BC%95%E5%AF%BC%E7%A8%8B%E5%BA%8F)。



- UEFI mode

UEFI启动不依赖于Boot Sector（比如MBR），大致流程如下：

1. Pre-EFI初始化模块运行，自检
2. 加载DXE（EFI驱动程序执行环境），枚举并加载EFI驱动程序（设备ROM或ESP中）
3. 找到ESP中的引导程序，通过其引导操作系统。



- CSM mode

UEFI中的兼容性支持模块（Compatible Support Module）提供了引导UEFI固件的PC上的传统磁盘（MBR格式）的方法。



## **分区表**

- MBR分区表

指的是512字节的Master Boot Record（主引导记录）中的分区表，由于大小限制，其中只能存有最多四个分区的描述（亦即4个主分区）。



- EBR分区表

位于Extended Boot Record（扩展引导纪录）中的分区表，该分区表所描述的分区即扩展分区。每个EBR仅表示了一个扩展分区，该扩展分区紧接在它的EBR后。EBR中的四个分区描述符中的第一个表示其描述的分你去，第二个描述符则表示下一个扩展分区（如果是最后一个则为空），也就是说，各个EBR串接成了一个EBR链表。



- GPT分区表

GUID Partition Table，是EFI标准的一部分，用于替代MBR分区表，相较起来有分区更大，数量更多（没有4个主分区的限制）等优势，GPT格式的硬盘结构如下，可以看到首部MBR的位置有个保护MBR（用于防止不识别GPT的硬盘工具错误识别并破坏硬盘中的数据），这个MBR中只有一个类型为0xEE的分区。GPT结构如下：





![img](https://pic3.zhimg.com/80/v2-0f9d14100058feff6e180da5623c3aca_720w.jpg)



## **分区**

分区可以是文件系统，启动kernel image，bootloader裸程序，或者参数等各种数据。

MBR Partition ID（分区类型）：[https://en.wikipedia.org/wiki/Partition_type](https://en.wikipedia.org/wiki/Partition_type)



- ESP（EFI系统分区）：

EFI System Partition，FAT格式，在MBR的分区类型ID是0xEF。主要目录是EFI。EFI/boot/bootx64.efi是EFI默认的启动项。安装的操作系统会建立相应的目录EFI/xxx，并将自己的启动项复制为到EFI/boot/bootx64.efi作为缺省启动项。

UEFI官网上注册的EFI的子目录：[http://www.uefi.org/registry](https://link.zhihu.com/?target=http%3A//www.uefi.org/registry)



比如安装Windows的时候，会在ESP分区中建立EFI/Microsoft子目录，并将EFI/Microsoft/bootmgr.efi复制到EFI/boot/bootx64.efi。



安装Ubuntu的时候，会在ESP分区中建立EFI/Ubuntu子目录，并将EFI/ubuntu/grubx64.efi（grub bootloader）复制为EFI/boot/bootx64.efi。因为Grub本身会扫描磁盘上的分区并找到windows启动程序（bootmgr.efi），因此先装windows后装ubuntu仍能通过grub让windows启动。



Linux也可以直接将编译出的Kernel及initrd（打开EFI Stub编译选项）作为efi文件复制到ESP中直接启动。



也可以在PC的系统设置中添加启动项。

维基百科的ESP条目：[https://en.wikipedia.org/wiki/EFI_system_partition](https://en.wikipedia.org/wiki/EFI_system_partition)



- Windows恢复分区

NTFS格式的分区，即Windows Recovery Environment，WinPE+工具集



## **Bootloader**

Bootloader即上文中提到的引导程序，用于启动操作系统或者其它引导程序（比如Grub启动Windows Bootmgr）

- Grub

GNU的开源引导程序，可以用于引导Linux等操作系统，或者用于链式引导其它引导程序（比如Windows Boot Manager），分为三个部分，分别称为步骤1、1.5、2，看名字就可以知道，步骤1.5是可有可没有的，这三个步骤对应的文件分别是：

1. Boot.img：步骤1对应的文件，446个字节大小，步骤1可以引导步骤1.5也可以引导步骤2。MBR分区格式的磁盘中，放在MBR里（446也是为了符合MBR的启动代码区大小）； GPT分区格式的磁盘中，放在Protective MBR中。
2. Core.img：步骤1.5对应的文件，32256字节大小。MBR分区格式的磁盘中，放在紧邻MBR的若干扇区中；GPT分区格式的磁盘中，则放在34号扇区开始的位置（第一个分区所处的位置），而对应的GPT分区表中的第一个分区的entry被置空。通常其中包含文件系统驱动以便load步骤2的文件。
3. /boot/grub：步骤2对应的文件目录，放在系统分区或者单独的Boot分区中





![img](https://pic2.zhimg.com/80/v2-cccf2befeb5363c48ca4911c88e00329_720w.jpg)





- Windows Boot Manager

是从[Windows Vista](https://zh.wikipedia.org/wiki/Windows_Vista)开始引进的新一代开机管理程序，用以取代[NTLDR](https://zh.wikipedia.org/wiki/NTLDR)。

当电脑运行完开机自检后，传统型[BIOS](https://zh.wikipedia.org/wiki/BIOS)会根据[引导扇区](https://zh.wikipedia.org/wiki/%E5%95%9F%E5%8B%95%E7%A3%81%E5%8D%80)查找开机硬盘中标记"引导"分区下的BOOTMGR文件；若是[UEFI](https://zh.wikipedia.org/wiki/UEFI)则是Bootmgfw.efi文件和Bootmgr.efi文件，接着管理程序会读取开机配置数据库（BCD, Boot Configuration Database）下的引导数据，接着根据其中的数据加载与默认或用户所选择的[操作系统](https://zh.wikipedia.org/wiki/%E4%BD%9C%E6%A5%AD%E7%B3%BB%E7%B5%B1)。



- NTLDR

是[微软](https://zh.wikipedia.org/wiki/%E5%BE%AE%E8%BD%AF)的[Windows NT](https://zh.wikipedia.org/wiki/Windows_NT)系列[操作系统](https://zh.wikipedia.org/wiki/%E6%93%8D%E4%BD%9C%E7%B3%BB%E7%BB%9F)（包括[Windows XP](https://zh.wikipedia.org/wiki/Windows_XP)和[Windows Server 2003](https://zh.wikipedia.org/wiki/Windows_Server_2003)）的引导程序。NTLDR可以从[硬盘](https://zh.wikipedia.org/wiki/%E7%A1%AC%E7%9B%98)以及[CD-ROM](https://zh.wikipedia.org/wiki/CD-ROM)、[U盘](https://zh.wikipedia.org/wiki/U%E7%9B%98)等移动存储器运行并引导Windows NT系统的启动。如果要用NTLDR启动其他操作系统，则需要将该操作系统所使用的[启动扇区](https://zh.wikipedia.org/w/index.php%3Ftitle%3D%E5%90%AF%E5%8A%A8%E6%89%87%E5%8C%BA%26action%3Dedit%26redlink%3D1)代码保存为一个文件，NTLDR可以从这个文件加载其它[引导程序](https://zh.wikipedia.org/wiki/%E5%BC%95%E5%AF%BC%E7%A8%8B%E5%BA%8F)。

NTLDR主要由两个文件组成，这两个文件必须放在系统分区（大多数情况下都是C盘）：

1. NTLDR，引导程序本身
2. boot.ini，引导程序的配置文件





以上内容参考维基百科