# [DSP+ARM多核异构开发环境SYSLINK搭建OMAPL138](https://www.cnblogs.com/sigma0/p/9154291.html)

# DSP+ARM多核异构开发环境搭建OMAPL138

**注意**： 环境为Ubuntu 12.04 只能是这个环境。我甚至在Ubuntu16.04上面安装了VMware，然后，在装了一个Ubuntu 12.04 x86版本。

# 导语与感想

OMAPL138属于多核异构平台（DSP+ARM），多核通信是多核异构平台的精髓部分，目前市面上流行的还有ZYNQ平台（FPGA+ARM），同样通信机理复杂。德州仪器OMAPL138和Davinci使用一样的多核通信机理。

这个机制相当复杂，又要懂Linux，又要会调试DSP，又要熟练掌握ARM的嵌入式Linux，又要抓住多核通信机制，实在让人抓狂。DSP端使用CCS，用JTAG口进行仿真，ARM端使用终端GDB命令进行动态调试配合调试输出完成多核通信的开发。

好吧，步入正题了，准备好以下的素材（不要被吓到）

**一定要对于文件、编译器有个很好的管理，杜绝东一块西一块，左一个文件，又一个文件，否则到时候自己蒙了。**本人习惯在自己用户的文件夹创建opt文件夹（用于安装非root权限运行的软件），script文件夹（用于处理一些脚本文件）、work（待交叉编译的源代码文件）、setup（安装、压缩包文件）、workspace（编程工程文件路径）、lib（第三方库文件夹）

## 搭建前准备素材

- CGT_组件：ti_cgt_c6000_7.3.0.tar.gz
- 多核通信组件：mcsdk_1_01_00_02_setuplinux.bin
- C6000的Starterware库：OMAPL138_StarterWare_1_10_04_01-Linux-x86-Install
- Qt图形界面库：qwt-6.1.0.tar.bz2
- DSP BIOS组件：bios_5_41_10_36.tar.gz
- dsplink组件：dsplink_linux_1_65_00_03.tar.gz
- Qt源文件：qt-everywhere-opensource-src-4.8.3.tar.gz
- DSP编译工具链：xdctools_3_22_01_21.tar.gz
- CCS的Linux版本：ccs 5.5 for Linux
- 内核源文件：linux-3.3.tar.bz2
- arm-linux交叉编译工具链：arm-2009q1-161-arm-none-eabi.bin

**以上这些文件，全部存在～/setup文件下**

## 环境前提

1. Ubuntu版本为12.04，(不要尝试新版，OMAPL停更了，组件最新支持到ubuntu12.04)
2. 配置好交叉编译环境
3. Linux3.3内核编译正确
4. Qte编译正确
5. CCS的Linux版本安装好

## 编译Linux3.3内核

参考我的博客：(基于OMAPL：Linux3.3内核的编译)[https://www.cnblogs.com/sigma0/p/9149041.html]

## 编译正确Qt

Qt版本使用的是Qt4,Qt5还没有实验，等着实验完Qt5会过来更新。

参考我的博客：(Linux编译Qt4的环境_OMAPL138
)[https://www.cnblogs.com/sigma0/p/8168313.html]

最后我之前设定的Qt make install的路径室/opt/qt-arm-4.8.3 （后面会用到）

## 编译QWT组件

qwt 全称是"Qt Widgets for Technical Applications",是一个基于 LGPL 版权协议的开源
项目,可生成各种统计图。**QWT的编译需要基于上一章节编译QT，编译出的qmake编译器**

### 解压qwt

准备qwt-6.1.0.tar.bz2文件，解压到`~/work`路径下：
`tar -xvf qwt-6.1.0.tar.bz2 -C ~/work`

### 配置QWT编译环境（使用创龙公司）

需要修改两个地方：

- 在"qwt-6.1.0/qwtconfig.pri"文件第 100 行 QwtOpenGL 和 119 行 QwtDesigner 前面增加。符号"#",表示注释掉此两行,因为此例程没有使用 QwtOpenGL 和 QwtDesigner。如下图所示:
- 修改 QWT_INSTALL_PREFIX 最后QWT输出路径。
  ![注释掉的信息](https://images2018.cnblogs.com/blog/810200/201806/810200-20180607101431613-1433993912.png)
  ![修改输出路径](https://images2018.cnblogs.com/blog/810200/201806/810200-20180607102208335-1690835129.png)

在 qwt 目录下执行以下命令产生 Makefile 编译文件:
`/opt/qt-arm-4.8.3/bin/qmake`

`ls` 如果有Makefile文件则表示配置成功。

### 编译QWT和安装

在 qwt 根目录下执行以下命令编译 qwt 组件源码:
`make -j4` 启动4个线程编译

编译完成后：

在 qwt 根目录下执行以下命令安装 qwt 组件:
`sudo make install`

**该组件会解压到QWT_INSTALL_PREFIX指定的路径中**：/opt/qwt-6.1.0

### 将库发送到开发板(HOST)端

将"/opt/qwt-6.1.0/lib"下的所有文件拷贝到开发板文件系统"/usr/lib"目录下，用SD卡也可以，用scp命令也可以。

## 安装CCS

安装过程请参考我发在贴吧上的教程：我这里用的是CCS5.5版本，大同小异 (在LINUX（ubuntu）系统下装CCSv6方法)[https://tieba.baidu.com/p/3698761357]

注意路径安装到 /opt/ti下

## 安装StarterWare库

执行：`sudo ./OMAPL138_StarterWare_1_10_04_01-Linux-x86-Install`
安装路径为: /opt/ti下

## 安装配置MCSDK

MCSDK是多核通信组件。

### 安装MCSDK

准备好mcsdk_1_01_00_02_setuplinux.bin，注意路径安装到/opt/ti下，完全安装就好。

```
sudo ./mcsdk_1_01_00_02_setuplinux.bin
```

### 配置MCSDK

进入"mcsdk_1_01_00_02"目录下,启动 MCSDK 设置脚本,根据不同主机设置,进行tftp、nfs、U-Boot 等配置。在设置之前,务必保证虚拟机网络畅通。

```
cd /opt/ti/mcsdk_1_01_00_02/`
`sudo ./setup.sh
```

- 问你NFS目标地址安装在哪里，直接回车
- 问你是否是root权限启动的配置，直接回车
- 创建EXEC_DIR等等环境变量，回车
- 问tftp路径直接回车
- 串口部分，我们用的室CH340所以是/dev/ttyUSB0
- 问ip，输入omapl138板子的ip地址
- 问你Linux Kernal位置，我的在SD卡
- 问你root file system的位置，我的在SD卡
- 问nfs文件系统启动方式启动方式，直接回车
- 启动tftp下载内核镜像，n
- installing linux devkit Y
- 最后看到TI SDK SETUP COMPLETED配置已经完成。
  ![ 在安装完之后TI路径下就该有这些东西](https://images2018.cnblogs.com/blog/810200/201806/810200-20180608100543416-1196605590.png)

### SYSLINK的配置和安装

`cd /opt/ti/syslink_2_21_01_05`
进入该路径下，打开配置文件：
`sudo vim products.mak`
要改的内容在下面

```shell
DEVICE	=	OMAPL1XX
SDK	=	NONE
EXEC_DIR	= /media/delvis/rootfs  // host root文件系统路径 可以在SD卡上(需要挂载)，也可以暂时存储到你电脑临时文件夹上，到时候拷贝到SD卡上
DEPOT	=	/opt/ti		// MCSDK 安装路径
```

接下来配置的如图所示：
![img](https://images2018.cnblogs.com/blog/810200/201806/810200-20180608101832452-490203470.png)

配置完成后保存退出。

### 编译syslink源代码

编译 syslink 之前,先将以下两个宏定义添加到 syslink 中的 Omapl1xxIpcInt.c、omapl1xx_phy_shmem.c、omapl1xxpwr.c 文件开头,否则编译会出错。
(1) /opt/ti/syslink_2_21_01_05/packages/ti/syslink/ipc/hlos/knl/notifyDrivers/arch/omapl1xx/Omapl1xxIpcInt.c
(2) /opt/ti/syslink_2_21_01_05/packages/ti/syslink/family/hlos/knl/omapl1xx/omapl1xxdsp/Linux/omapl1xx_phy_shmem.c
(3) /opt/ti/syslink_2_21_01_05/packages/ti/syslink/family/hlos/knl/omapl1xx/omapl1xxdsp/omapl1xxpwr.c

- Omapl1xxIpcInt.c 文件，修改在头处添加文件

```C
#undef __ASM_ARCH_HARDWARE_H
#include <mach/hardware.h>
```

- omapl1xx_phy_shmem.c文件，修改在头文件处添加

```C
#undef __ASM_ARCH_HARDWARE_H
#include <mach/hardware.h>
```

- omapl1xxpwr.c 文件，修改在头文件处添加

```C
#undef __ASM_ARCH_HARDWARE_H
#include <mach/hardware.h>
```

### 编译syslink

```
cd /opt/ti/syslink_2_21_01_05`
`make syslink
```

### 编译syslink示例

```
make samples
```

### 安装syslink驱动程序

```
sudo make install`
返回到在setup.sh配置syslink的时候指定的rootfs目录，`ls lib/modules/3.3.0/kernel/drivers/dsp/
```

可以看到在文件系统"lib/modules/3.3.0/kernel/drivers/dsp/"目录下有 syslink 驱动程序syslink.ko 文件和文件系统根目录下有"ex**_##"的示例程序。
就配合环境成功了。

## 参考文献

[1]创龙公司，基于 OMAPL138 的多核软件开发组件 MCSDK 开发入门
[2]创龙公司，OMAPL138基于SYSLINK的双核例程