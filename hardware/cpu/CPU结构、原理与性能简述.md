# CPU结构、原理与性能简述

[ermaot](https://www.jianshu.com/u/07f3d21a61d7)关注

2020.03.09 15:45:46字数 1,542阅读 421

## 简介

中央处理器（CPU，central processing unit）作为计算机系统的运算和控制核心，是信息处理、程序运行的最终执行单元。

## CPU结构



![img](https://upload-images.jianshu.io/upload_images/12069313-199af4c0d3d7f07b.png?imageMogr2/auto-orient/strip|imageView2/2/w/613/format/webp)

A·P·J·克莱顿. 处理器结构

下图是上图的细节描述：



![img](https://upload-images.jianshu.io/upload_images/12069313-fc1c7ad8f998caa8.png?imageMogr2/auto-orient/strip|imageView2/2/w/1048/format/webp)

百度百科-处理器结构

## CPU执行过程

CPU的工作分为以下 5 个阶段：取指令阶段、指令译码阶段、执行指令阶段、访存取数和结果写回。【本部分来自万方[X86中央处理器安全问题综述]】

1. 取指令（IF，instruction fetch），即将一条指令从主存储器中取到指令寄存器的过程。程序计数器中的数值，用来指示当前指令在主存中的位置。当 一条指令被取出后，PC中的数值将根据指令字长度自动递增。

2. 指令译码阶段（ID，instruction decode），取出指令后，指令译码器按照预定的指令格式，对取回的指令进行拆分和解释，识别区分出不同的指令类别以及各种获取操作数的方法。

3. 执行指令阶段（EX，execute），具体实现指令的功能。CPU的不同部分被连接起来，以执行所需的操作。

4. 访存取数阶段（MEM，memory），根据指令需要访问主存、读取操作数，CPU得到操作数在主存中的地址，并从主存中读取该操作数用于运算。部分指令不需要访问主存，则可以跳过该阶段。

5. 结果写回阶段（WB，write back），作为最后一个阶段，结果写回阶段把执行指令阶段的运行结果数据“写回”到某种存储形式。结果数据一般会被写到CPU的内部寄存器中，以便被后续的指令快速地存取；许多指令还会改变程序状态字寄存器中标志位的状态，这些标志位标识着不同的操作结果，可被用来影响程序的动作。
   在指令执行完毕、结果数据写回之后，若无意外事件（如结果溢出等）发生，计算机就从程序计数器中取得下一条指令地址，开始新一轮的循环，下一个指令周期将顺序取出下一条指令

   

   ![img](https://upload-images.jianshu.io/upload_images/12069313-df707a8e3fa6ee2f.png?imageMogr2/auto-orient/strip|imageView2/2/w/600/format/webp)

   五条指令简述

## CPU性能指标

#### 1. 主频

其实就是CPU内核工作时的时钟频率。CPU的主频所表示的是CPU内数字脉冲信号振荡的速度。所以并不能直接说明主频的速度是计算机CPU的运行速度的直接反映形式，我们并不能完全用主频来概括CPU的性能。

#### 2.总线速度，外频

外频是系统总线的工作频率，即CPU的基准频率，是CPU与主板之间同步运行的速度。外频速度越高，CPU就可以同时接受更多来自外围设备的数据，从而使整个系统的速度进一步提高。

#### 3.CPU的缓存容量（参考[CPU缓存原理](https://www.jianshu.com/p/62681796b78e)）

计算的缓存容量越大，那么性能就越好。计算机在进行数据处理和运算时，会把读出来的数据先存储在一旁，然后累计到一定数量以后同时传递，这样就能够把不同设备之间处理速度的差别给解决了，这个就是缓存容量。在处理数据时，数据的临时存放点，按道理，只要缓存容量越大，计算机的数据处理速度将会越大，则计算机运行速度将会越快。

#### 4.CPU工作电压

CPU的正常工作电压的范围比较宽，在计算机发展的初期，这时候CPU的核定电压为5伏左右，后来CPU工艺、技术发展，CPU正常工作所需电压相较以前而言越来越低，最低可达1.1V，如此低电压下的环境，CPU也能正常运行。有些发烧友通过加强工作电压，加强CPU的运转效率，达到超频的目的，极大的提升了CPU的运行效率，但这样是一种消耗CPU使用寿命的不可取的办法。

#### 5.CPU的总线方式

一般来说，我们把CUP内部的总线结构分为三类：单线结构，由一条总线连接内部所有的部件，结构简单，性能低下。双总线结构，连接各部件的总线有两条，被叫做双总线结构。多总线结构，连接CPU内各部件的总线有3条及以上，则构成多总线结构。

#### 6.CPU制程

CPU的制程工艺最早是0.5um的，随着制造水平的提高，后来人们大多用的是0.25um的。如今，科学技术飞速发展，CPU的制造工艺已经开始用纳米衡量了。

#### 7.超标量

超标量是指在一个时钟周期内CPU可以执行一条以上的指令。这在486或者以前的CPU上是很难想象的，只有Pentium级以上CPU才具有这种超标量结构；486以下的CPU属于低标量结构，即在这类CPU内执行一条指令至少需要一个或一个以上的时钟周期。

#### 8.超线程

超线程技术把多线程处理器内部的两个逻辑内核模拟成两个物理芯片，让单个处理器就能使用线程级的并行计算，进而兼容多线程操作系统和软件。超线程技术充分利用空闲CPU资源，在相同时间内完成更多工作。

## CPU信息查看

#### lscpu

```bash
# lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                1
On-line CPU(s) list:   0
Thread(s) per core:    1
Core(s) per socket:    1
Socket(s):             1
NUMA node(s):          1
Vendor ID:             AuthenticAMD
CPU family:            23
Model:                 1
Model name:            AMD EPYC Processor
Stepping:              2
CPU MHz:               1999.996
BogoMIPS:              3999.99
Hypervisor vendor:     KVM
Virtualization type:   full
L1d cache:             64K
L1i cache:             64K
L2 cache:              512K
NUMA node0 CPU(s):     0
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm rep_good nopl cpuid extd_apicid tsc_known_freq pni pclmulqdq ssse3 fma cx16 sse4_1 sse4_2 x2apic movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm cr8_legacy abm sse4a misalignsse 3dnowprefetch osvw vmmcall fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 arat
```

#### x86info

```python
# dmidecode  -t processor
# dmidecode 3.0
Getting SMBIOS data from sysfs.
SMBIOS 2.8 present.

Handle 0x0400, DMI type 4, 42 bytes
Processor Information
    Socket Designation: CPU 0
    Type: Central Processor
    Family: Other
    Manufacturer: Smdbmds
    ID: 12 0F 80 00 FF FB 8B 07
    Version: 3.0
    Voltage: Unknown
    External Clock: Unknown
    Max Speed: 2000 MHz
    Current Speed: 2000 MHz
    Status: Populated, Enabled
    Upgrade: Other
    L1 Cache Handle: Not Provided
    L2 Cache Handle: Not Provided
    L3 Cache Handle: Not Provided
    Serial Number: Not Specified
    Asset Tag: Not Specified
    Part Number: Not Specified
    Core Count: 1
    Core Enabled: 1
    Thread Count: 1
    Characteristics: None
```





0人点赞



硬件