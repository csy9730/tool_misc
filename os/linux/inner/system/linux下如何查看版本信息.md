# linux下如何查看版本信息

## 一、linux下如何查看已安装的centos版本信息：
### 1.Linux查看当前操作系统版本信息 
 `cat /proc/version`

```
Linux version 2.6.32-696.el6.x86_64 (mockbuild@c1bm.rdu2.centos.org) (gcc version 4.4.7 20120313 (Red Hat 4.4.7-18) (GCC) ) #1 SMP Tue Mar 21 19:29:05 UTC 2017
```

### 2.Linux查看版本当前操作系统内核信息
`uname -a`

```
Linux localhost.localdomain 2.4.20-8 #1 Thu Mar 13 17:54:28 EST 2003 i686 athlon i386 GNU/Linux
```
### 3.linux查看版本当前操作系统发行信息
 `cat /etc/issue 或 cat /etc/centos-release`
CentOS release 6.9 (Final)
### 4.Linux查看cpu相关信息，包括型号、主频、内核信息等 
 `cat /etc/cpuinfo`

``` bash
processor : 0
vendor_id : GenuineIntel
cpu family : 6
model : 60
model name : Intel(R) Core(TM) i5-4590 CPU @ 3.30GHz
stepping : 3
microcode : 29
cpu MHz : 3292.277
cache size : 6144 KB
physical id : 0
siblings : 4
core id : 0
cpu cores : 4
apicid : 0
initial apicid : 0
fpu : yes
fpu_exception : yes
cpuid level : 13
wp : yes
flags : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc arch_perfmon pebs bts rep_good xtopology nonstop_tsc aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx smx est tm2 ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm ida arat epb xsaveopt pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase bmi1 avx2 smep bmi2 erms invpcid
bogomips : 6584.55
clflush size : 64
cache_alignment : 64
address sizes : 39 bits physical, 48 bits virtual

```
### 5.Linux查看版本说明当前CPU运行在32bit模式下(但不代表CPU不支持64bit)
 `getconf LONG_BIT`

```
 64
```

## 二、uname的使用
uname命令用于打印当前系统相关信息（内核版本号、硬件架构、主机名称和操作系统类型等）。
```
uname -a显示全部信息
-m或--machine：显示电脑类型；
-r或--release：显示操作系统的发行编号；
-s或--sysname：显示操作系统名称；
-v：显示操作系统的版本；
-p或--processor：输出处理器类型或"unknown"；
-i或--hardware-platform：输出硬件平台或"unknown"； 
-o或--operating-system：输出操作系统名称；
--help：显示帮助；
--version：显示版本信息。
```
## 三、查看Linux版本
### 1.查看系统版本信息的命令
 `lsb_release -a `
(使用命令时提示command not found,需要安装`yum install redhat-lsb -y`)
```
[root@localhost ~]# lsb_release  -a
LSB Version:    :core-4.0-amd64:core-4.0-noarch:graphics-4.0-amd64:graphics-4.0- noarch:printing-4.0-amd64:printing-4.0-noarch
Distributor ID: CentOS
Description:    CentOS Linux release 6.0 (Final)
Release:        6.0
Codename:       Final
```
注:这个命令适用于所有的linux，包括RedHat、SUSE、Debian等发行版。


### 2.查看centos版本号 

`cat /etc/issue`

```
CentOS release 6.9 (Final)
Kernel \r on an \m
```
### 3.使用 `file /bin/ls`

```
/bin/ls: ELF 64-bit LSB executable, x86-64, version 1 (SYSV), dynamically linked (uses shared libs), for GNU/Linux 2.6.32, BuildID[sha1]=c8ada1f7095f6b2bb7ddc848e088c2d615c3743e, stripped

```

