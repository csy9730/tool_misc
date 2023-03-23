# STM32的内存管理相关（内存架构，内存管理，map文件分析）

把以前看过的做过的笔记，还有网上参考的部分好文章，利用假期好好梳理了一遍，希望对大家也对自己以后查看有帮助



使用一个STM32芯片，对于内存而言有两个直观的指标就是 RAM 大小，FLASH大小，比如STM32F103系列（其他系列也是如此）：

![img](https://pic2.zhimg.com/80/v2-96e0858eb35ec7a4b6a90acaadb497a9_720w.webp)

那么着两个大小意味着什么？怎么去理解这两个内存，那就得从什么是Flash，什么是RAM说起。

## 一、FLASH 和 RAM基本概念

先来看一张图：

![img](https://pic4.zhimg.com/80/v2-b8ed5e98c3a50785d8689ceba213023b_720w.webp)



### 1.1 FLASH是什么

通过上图我们可以知道，FLASH属于 非易失性存储器：

扩展一点说，FLASH又称为闪存，不仅具备电子可擦除可编程(EEPROM)的性能，还不会断电丢失数据同时可以快速读取数据，U盘和MP3里用的就是这种存储器。在以前的嵌入式芯片中，存储设备一直使用ROM(EPROM)，随着技术的进步，现在嵌入式中基本都是FLASH，用作存储Bootloader以及操作系统或者程序代码或者直接当硬盘使用(U盘)。

然后 Flash 主要有两种NOR Flash和NADN Flash。（对于这两者的区别，下面的话供参考，因为这些介绍都是基于早些年的技术了）

NOR Flash的读取和我们常见的SDRAM的读取是一样，用户可以直接运行装载在NOR FLASH里面的代码，这样可以减少SRAM的容量从而节约了成本。

NAND Flash没有采取内存的随机读取技术，它的读取是以一次读取一块的形式来进行的，通常是一次读取512个字节，采用这种技术的Flash比较廉价。用户不能直接运行NAND Flash上的代码，因此好多使用NAND Flash的开发板除了使用NAND Flah以外，还作上了一块小的NOR Flash来运行启动代码。

STM32单片机内部的FLASH为 NOR FLASH。 Flash 相对容量大，掉电数据不丢失，主要用来存储 代码，以及一些掉电不丢失的用户数据。

### 1.2 RAM是什么

RAM 属于易失性存储器：

RAM随机存储器（Random Access Memory）表示既可以从中读取数据，也可以写入数据。当机器电源关闭时，存于其中的数据就会丢失。比如电脑的内存条。

RAM有两大类，一种称为静态RAM(Static RAM/SRAM)，SRAM速度非常快，是目前读写最快的存储设备了，但是它也非常昂贵，所以只在要求很苛刻的地方使用，譬如CPU的一级缓冲，二级缓冲。另一种称为动态RAM(Dynamic RAM/DRAM)，DRAM保留数据的时间很短，速度也比SRAM慢，不过它还是比任何的ROM都要快，但从价格上来说DRAM相比SRAM要便宜很多，计算机内存就是DRAM的。

DRAM分为很多种，常见的主要有FPRAM/FastPage、EDORAM、SDRAM、DDR RAM、RDRAM、SGRAM以及WRAM等，这里介绍其中的一种DDR RAM。

DDR RAM(Date-Rate RAM)也称作DDR SDRAM，这种改进型的RAM和SDRAM是基本一样的，不同之处在于它可以在一个时钟读写两次数据，这样就使得数据传输速度加倍了。这是目前电脑中用得最多的内存，而且它有着成本优势，事实上击败了Intel的另外一种内存标准-Rambus DRAM。在很多高端的显卡上，也配备了高速DDR RAM来提高带宽，这可以大幅度提高3D加速卡的像素渲染能力。

为什么需要RAM，因为相对FlASH而言，RAM的速度快很多，所有数据在FLASH里面读取太慢了，为了加快速度，就把一些需要和CPU交换的数据读到RAM里来执行（注意这里不是全部数据，只是一部分需要的数据，这个在后面介绍STM32的内存管理中会提到）。

STM32单片机内部的 RAM 为 SRAM。 RAM相对容量小，速度快，掉电数据丢失，其作用是用来存取各种动态的输入输出数据、中间计算结果以及与外部存储器交换的数据和暂存数据。

## 二、STM32的内存架构

### 2.1 Cortex-M3的存储器映射分析

在《ARM Cotrex-M3权威指南》中有关 M3的存储器映射表：

![img](https://pic1.zhimg.com/80/v2-393747cf712128c5ea46940b7d8c8d20_720w.webp)

存储器映射 是用 地址来表示 对象，因为Cortex-M3是32位的单片机，因此其PC指针可以指向2^32=4G的地址空间，也就是图中的 0x00000000到0xFFFFFFFF的区间，也就是将程序存储器、数据存储器、寄存器和输入输出端口被组织在同一个4GB的线性地址空间内，数据字节以小端格式存放在存储器中。

### 2.2 STM32 的存储器映射分析

STM32存储器映射表（选用的是STM32F103VE的，不同的型号Flash 和 SRAM 的地址空间不同，起始地址都是一样的）：

![img](https://pic3.zhimg.com/80/v2-20a7b7db983e9cc0cc1115c821396002_720w.webp)

那么我们所需要分析的STM32 内存，就是图中 0X0800 0000开始的 Flash 部分 和 0x2000 0000 开始的SRAM部分，这里还要介绍一个和Flash模块相关的部分：

![img](https://pic1.zhimg.com/80/v2-30294b56fc2d5a6d05b30ed278c33634_720w.webp)



### 2.3 STM32的 Flash 组织



![img](https://pic1.zhimg.com/80/v2-5e97c80048f04a8d45d9955348f4b4f0_720w.webp)



参考博文：[深入理解STM32内存管理](https://link.zhihu.com/?target=https%3A//blog.csdn.net/zhuguanlin121/article/details/119799860%3Futm_medium%3Ddistribute.pc_relevant.none-task-blog-2~default~CTRLIST~default-1.no_search_link%26depth_1-utm_source%3Ddistribute.pc_relevant.none-task-blog-2~default~CTRLIST~default-1.no_search_link)

STM32的Flash，严格说，应该是Flash模块。该Flash模块包括：Flash主存储区（Main memory）、Flash信息区（Informationblock），以及Flash存储接口寄存器区（Flash memory interface）。

**主存储器**，该部分用来存放代码和数据常数（如加const类型的数据）。对于大容量产品，其被划分为256页，每页2K，小容量和中容量产品则每页只有1K字节。主存储起的起始地址为0X08000000，B0、B1都接GND的时候，就从0X08000000开始运行代码。

**信息块**，该部分分为2个部分，其中启动程序代码，是用来存储ST自带的启动程序，用于下载，当B0接3.3V，B1接GND时，运行的就这部分代码，用户选择字节，则一般用于配置保护等功能。

**闪存储器块**，该部分用于控制闪存储器读取等，是整个闪存储器的控制机构。

对于主存储器和信息块的写入有内嵌的闪存编程管理；编程与擦除的高压由内部产生。

在执行闪存写操作时，任何对闪存的读操作都会锁定总线，在写完成后才能正确进行，在进行读取或擦除操作时，不能进行代码或者数据的读取操作。

## 三、STM32 的内存管理

STM32 的内存管理起始就是对 0X0800 0000 开始的 Flash 部分 和 0x2000 0000 开始的 SRAM 部分使用管理

### 3.1 C/C++ 程序编译后的存储数据段

参考博文：[STM32内存结构介绍](https://link.zhihu.com/?target=https%3A//blog.csdn.net/xingqingly/article/details/120260398)

在了解如何使用内存管理之前，先得理解一下 6 个储存数据段 和 3种存储属性区 的概念：

![img](https://pic4.zhimg.com/80/v2-8ddb44fbe1620bfbf804a330a616b94b_720w.webp)

**.data**

数据段，储存已初始化且不为0的全局变量和静态变量（全局静态变量和局部静态变量）。 static声明的变量放在data段。 数据段属于静态内存分配，所以放在RAM里，准确来说，是在程序运行的时候需要在RAM中运行。

**.BSS**

Block Started by Symbol。储存未初始化的，或初始化为0的全局变量和静态变量。 BSS段属于静态内存分配，所以放在RAM里。

**.text（CodeSegment/Text Segment）**

代码段，储存程序代码。也就是存放CPU执行的机器指令(machineinstructions)。这部分区域的大小在程序运行前就已经确定，并且内存区域通常属于只读(某些架构也允许代码段为可写，即允许修改程序)。 在代码段中，也有可能包含一些只读的常数变量，例如字符串常量等。 放在Flash里。

**.constdata**

储存只读常量。const修饰的常量，不管是在局部还是全局 放在Flash 里。 所以为了节省 RAM，把常量的字符串，数据等 用const声明

**heap（堆）**

堆是用于存放进程运行中被动态分配的内存段。他的大小并不固定，可动态扩张或者缩减，由程序员使用malloc()和free()函数进行分配和释放。当调用malloc等函数分配内存时，新分配的内存就被动态添加到堆上（堆被扩张）；当利用free等函数释放内存时，被释放的内存从堆中被剔除（堆被缩减）。 放在RAM里 其可用大小定义在启动文件startup_stm32fxx.s中。

**stack（栈）**

栈又称堆栈，是用户存放程序临时创建的局部变量，由系统自动分配和释放。可存放局部变量、函数的参数和返回值（但不包括static声明的变量，static意味着 放在 data 数据段中）。 除此以外，在函数被调用时，其参数也会被压入发起调用的进程栈中，并且待到调用结束后，函数的返回值也会被存放回栈中。 ？？？由于栈的先进先出(FIFO)特点？？？上面这句话正确吗？Cortex-M3/M4的堆栈是向下生长，第一个入栈的元素应该是最后一个才能出来？？ 所以栈特别方便用来保存/恢复调用现场。 从这个意义上讲，我们可以把堆栈看成一个寄存、交换临时数据的内存区。 放在RAM里 其大小定义在启动文件startup_stm32fxx.s中。

### 3.2 STM32 程序编译后的内存占用情况

### 3.2.1 MDK 编译

MDK编译后的结果：

![img](https://pic4.zhimg.com/80/v2-ca2a0e086726f50b855f70ef90d7f7b3_720w.webp)



**Code：** 程序代码部分。 .text 段 放在ROM里面，就是Flash，需要占用flash空间

**RO-data** (Read Only)只读数据 程序定义的常量,只读数据，字符串常量（const修饰的） .constdata 段 放在flash里面，需要占用flash空间

**RW-data** (Read Write)可读可写数据 已经初始化的全局变量和静态变量（就是static修饰的变量）； .data 段 需要在 RAM里面运行，但是起初需要保存在 Flash里面，程序运行后复制到 RAM里面运行，需要占用Flash空间

**ZI-data** (Zero Initialize)未初始化的全局变量和静态变量，以及初始化为0的变量； .BSS段 ZI的数据全部是0，没必要开始就包含，只要程序运行之前将ZI数据所在的区域（RAM里面）一律清 0，不占用Flash，运行时候占用RAM.

heap 和 stack 其实也属于 ZI，只不过他不是程序编译就能确定大小的，必须在运行中才会有大小，而是是变化的

因为RAM掉电丢失，所以 RW-data 数据也得下载到ROM（flash） 中，在运行的时候复制到 RAM中运行，如下图所示（图中的地址也是错的，应该是从0x0800 0000 开始）：

![img](https://pic3.zhimg.com/80/v2-480e8491161dbe9095c430dcc113e302_720w.webp)



由上我们得知：

**程序占用 Flash** = **Code** + **RO data** + **RW data**

**程序运行时候占用 RAM** = **RW data** + **ZI data**。

**Code** + **RO data** + **RW data** 的大小也是生成的 **bin** 文件的大小

### 3.2.1 GCC 编译

GCC编译结果：

![img](https://pic1.zhimg.com/80/v2-d6661fdb3c9d90a4e1edad36e3195d60_720w.webp)

GCC编译， 图中红色的部分是占用 Flash 的大小：**Flash** = **text** + **data** 。 蓝色部分是运行时候占用 RAM大小：**RAM** = **data** + **bss**。

### 3.3 STM32 程序的内存分配

我们前面说到的 stack（栈） 和 heap（堆），程序编译完成以后并不能知道运行时候实际占用RAM 大小。 但是我们可以知道的是 stack（栈） 和 heap（堆）的起始地址，和能够使用的最大空间，我们先看能够使用的空间大小。

### 3.3.1 MDK 环境

MDK是在 startup_stm32fxxx.s 中定义的：

![img](https://pic3.zhimg.com/80/v2-79199ecbf0c07e5d099a03d4f4fb824a_720w.webp)

在 startup_stm32fxxx.s 中我们可以看到关于 Stack_Size 和 Heap_Size的定义，图中的定义就是规定本程序中 栈 的大小为 1K， 堆的大小为 0.5K。

startup_stm32fxxx.s文件是系统的启动文件，startup_stm32fxxx.s主要完成三个工作：栈和堆的初始化、定位中断向量表、调用Reset Handler。 （关于STM32的启动文件，我们有单独的一篇文章，请查看另一篇博文 [STM32的启动过程（startup_xxxx.s文件解析）](https://link.zhihu.com/?target=https%3A//blog.csdn.net/weixin_42328389/article/details/120656722)）

我们在生成的.map文件可以看到 HEAP 和 STACK的起始地址（不懂的可以先看博文下面一节的内容——四、MDK生成的.map文件简析），我们要注意的是： 堆使用时候从起始地址开始，往上加 栈使用时候从结束地址，就是__initial_sp（栈顶指针的地址）开始，往下减 他们的空间大小定义好了，如果入栈元素过大，使得元素减到了堆的地址范围，就是栈溢出，这会导致改变堆中相应地址元素的值。 同样的，当申请的动态内存过大，使得堆的变量加到了栈的地址范围，就是堆溢出。

在实际项目中，如果程序复杂，中断嵌套太多，栈需要多设置一点空间 如果你使用裸机程序，从来不使用标准库的malloc，heap可以没有，因为永远不会用到，还一直占用着一片RAM区。

所以在我们知道了以上的知识后，我们可以按照自己的工程需求，定义Stack_Size 和 Heap_Size。

### 3.3.2 GCC 环境

如果是在GCC编译器下面，关于 Stack_Size 和 Heap_Size的定义如下图：

![img](https://pic3.zhimg.com/80/v2-6d54860d2be92acec8801dea1ea68b6a_720w.webp)



## 四、MDK生成的.map文件简析

为了更深层次的理解上述内容，我们还有必要分析一下MDK生成的 .map 文件， 那么既然要分析,除了我们关注的flash 和 ram部分的内容，其他的地方也稍微做一下笔记：

### 4.1 Section Cross References

主要是不同文件中函数的调用关系：

![img](https://pic1.zhimg.com/80/v2-28101e8624768965d5a29f7f6d390ddc_720w.webp)

我们查看一下 clock.c 文件下的

```text
rt_tick_increase
```

函数：

![img](https://pic1.zhimg.com/80/v2-087b4670fd2ddf4f4a1906d908f30c08_720w.webp)



### 4.2 Removing Unused input sections from the image

被删除的冗余函数：

![img](https://pic4.zhimg.com/80/v2-cbc666e88ce4ad07b1ab9dbc78285c93_720w.webp)

删除函数功能在MDK的配置中可以设置，勾选以后删除得多，不勾选删除得少，如下图：

![img](https://pic3.zhimg.com/80/v2-b84c4220e5e6f6dbd3abd755410ccbc6_720w.webp)

在 Removing Unused input sections from the image 的最后会列出删除的冗余函数的大小，如果在MDK上改变上图所示的配置，下图中的删除总代码可以看到变化：

![img](https://pic2.zhimg.com/80/v2-5019beab8bfbecf87597bc1597e4c4e1_720w.webp)



### 4.3 Image Symbol Table

### 4.3.1 Local Symbols

局部标号, 用Static声明的全局变量地址和大小， C文件中函数的地址和用static声明的函数代码大小， 汇编文件中的标号地址（作用域限本文件）：

![img](https://pic4.zhimg.com/80/v2-4905d1b049213133bbb022f391e129d7_720w.webp)

我们找个占用内存地址的地方看一下：

![img](https://pic3.zhimg.com/80/v2-e09a3d6d3cc00bd321a3768ae9b9e3ea_720w.webp)

我们在 startup_stm32f103xg.s ，可以看到RESET函数：

![img](https://pic4.zhimg.com/80/v2-f1c7cf40828dd7b8c18878b7f2af1a87_720w.webp)

我们继续往下看：

![img](https://pic3.zhimg.com/80/v2-8997da56519243ddf35639c719e309a2_720w.webp)



上图中的 i.RCC_Delay 下面跟了一个 RCC_Delay，说明这个函数是用static修饰的，我们找到 stm32f1xx_hal_rcc.c下的

```text
RCC_Delay
```

如图：

![img](https://pic2.zhimg.com/80/v2-d31fc0c1b79421819a199abb58f36b99_720w.webp)

我们接着看到 SRAM区：

![img](https://pic1.zhimg.com/80/v2-c4aa81d1c8f09048f37cd45c2c5cdcf8_720w.webp)

我们继续看到后面的.bss段，包括了 HEAP 和 STACK区域：

![img](https://pic3.zhimg.com/80/v2-aae29efc26eeec1a55cad9e15dd4624e_720w.webp)

通过上图中我们可以看到 HEAP 的起始地址为 0x20002338， ram从 0x2000 0000开始存放的依次为 .data、.bss、HEAP、STACK。 HEAP在 startup_stm32fxxx.s 中定义过大小为 0x200， 所以结束地址为0x20002538， HEAP 是和 STACK连接在一起的，所以STACK的起始地址为 0x20002538，大小 0X400，结束地址为 0x20002938。 最后我们可以看到 __initial_sp 指向的是 0x20002938，入栈从高地址开始入栈，地址越来越小。



### 4.3.2 Global Symbols

全局标号， 全局变量的地址和大小， C文件中函数的地址及其代码大小， 汇编文件中的标号地址（作用域全工程）：

![img](https://pic3.zhimg.com/80/v2-13c2c1ac208791f8ca8e6f6041dd5fa2_720w.webp)



我们找到Flash地址开始的部分：

![img](https://pic2.zhimg.com/80/v2-df8f4f3a3d5899846df96eaa49fa3c6d_720w.webp)

在 startup_stm32fxxx.s 能看到对应的部分：

![img](https://pic4.zhimg.com/80/v2-b2c8031c5b70a697c67ebe8c1822c55f_720w.webp)

看到最后的 RAM区，注意下图中标出的两行的功能：

![img](https://pic3.zhimg.com/80/v2-8ef562fd42af1968738bba39971c70ca_720w.webp)



### 4.4 Memory Map of the image

映像文件可以分为加载域（Load Region）和运行域（Execution Region）：加载域反映了ARM可执行映像文件各个段存放在存储器中时的位置关系。

![img](https://pic4.zhimg.com/80/v2-e43e5ee04142c7cfe46c88c61f673107_720w.webp)

其中还能看出来 Flash中存放的都是 code，和 RO_Data:

![img](https://pic2.zhimg.com/80/v2-d803cdb9adff6f4084be2299a4b281dd_720w.webp)

我们看看SRAM部分：

![img](https://pic2.zhimg.com/80/v2-fd449055d124c10dae33ae20958a4855_720w.webp)

需要注意一下，我们前面代码he 数据部分都是4字节对齐，PAD一般都是补充2个字节，到了栈部分，需要8字节对齐:

![img](https://pic2.zhimg.com/80/v2-3280db8ca31a8377f05696c8def894e9_720w.webp)



### 4.5 Image component sizes

存储组成大小 这部分的内容就比较直观

![img](https://pic4.zhimg.com/80/v2-25bfd8c143fe8578daf6786be9ee738b_720w.webp)

最后就是我们熟悉的部分：

![img](https://pic1.zhimg.com/80/v2-671e2e892e2ef3d58fa3951aed21a7a0_720w.webp)



## 五、一些相关的补充内容

### 5.1 STM32 的启动方式

| BOOT0 | BOOT1 | 启动模式                              |
| ----- | ----- | ------------------------------------- |
| 0     | X     | User Flash memory（从闪存存储器启动） |
| 1     | 0     | System memory（从系统存储器启动）     |
| 1     | 1     | Embedded SRAM（从内嵌SRAM启动）       |

第一种启动方式是最常用的用户FLASH启动，正常工作就在这种模式下，STM32的FLASH可以擦出10万次，所以不用担心芯片哪天会被擦爆！

第二种启动方式是系统存储器启动方式，即我们常说的串口下载方式（ISP），不建议使用这种，速度比较慢。STM32 中自带的BootLoader就是在这种启动方式中，如果出现程序硬件错误的话可以切换BOOT0/1到该模式下重新烧写Flash即可恢复正常。

第三种启动方式是STM32内嵌的SRAM启动。该模式用于调试。 用jlink在线仿真，则是下载到SRAM中。

以上三种启动方式我们都很熟悉，但是他的究竟是如何实现的呢？

我们先来看看《Cortex-M3权威指南》关于CM3复位后的动作：

![img](https://pic4.zhimg.com/80/v2-cf317c6169697e0e09428a27920724e7_720w.webp)

当选择相应的启动方式时，对应的存储器空间被映射到启动空间(0x00000000)。

从闪存存储器启动：主闪存存储器被映射到启动空间(0x0000 0000) ,也就是0x08000000被映射到0x00000000。

从内嵌SRAM启动 ：SRAM起始地址 0x2000 0000 被映射到0x00000000。

从系统存储器启动：系统存储器被映射到启动空间(0x0000 0000)，也就是0x1FFF F000被映射到0x00000000。 (为什么是0x1FFF F000 可以查阅上文中的 2.2小节 STM32 的存储器映射分析，STM32互联型产品这个地址不一样，此地址由ST官方写入了一段BootLoader代码，可以通过官方BootLoader升级MCU固件，无法修改）。

### 5.2 STM32启动地址和 Bootloader 说明

通过上面的内容，我们现在知道STM32 从Flash程序启动以后会从 0X08000000 开始运行，那么他这个地址是否可以修改，答案是当然的！但是单独的改他的启动地址，没有任何意义，一般都是需要使用到 Bootloader 才会使得应用程序的地址发生变化。

在 0x1FFF F000 这个地址上官方写入了一段 BootLoader 用户使用，我们也可以自己写一段 BootLoader 程序方便自己使用，因为是自己写的，他还是用户程序，只是我们自己把程序分成了 BootLoader部分和 应用程序部分，大概的意思如下图所示：

![img](https://pic2.zhimg.com/80/v2-3bc600c62bdf89e27d8a6f3449631f31_720w.webp)

为什么要使用用户 BootLoader ：

在有些项目中，可能因为某些原因需要经常更换 程序，如果每次都是重新烧录，特别的麻烦，那么我们就可以自己设计一个 BootLoader，通过 SD卡进行升级： 上电后先运行 BootLoader，BootLoader主要工作是检测是否有SD卡，SD卡中是否有需要的BIn文件， 如果检测到就将其复制到 应用程序区域 使得程序得以更新，更新结束以后跳转到应用程序执行； 如果没检测到相应的SD卡，就说明程序不需要更新，也跳转到应用程序执行；

以上主要是说明使用 BootLoader 的思路与适用场合，至于具体的实现其实网上有很多教程，如果有机会我也会补充或者单独写一篇文章总结一下

（说明：下面是零碎的笔记，还没整理完，仅供参考 stm32 FLASH的起始地址是0x08000000，当然也可以自定义起始地址，不过记得在main函数中定义变量后加一句SCB->VTOR=FLASH_BASE | OFFSET;OFFSET是想要偏移的量，可宏定义或直接0xXX。 当然也可以调用库函数 NVIC_SetVectorTable（）进行偏移，效果一样。IAP升级这样用的多）

### 5.3 单片机和 x86cpu运行程序的不同

参考博文：[cpu运行时程序是在flash中还是在RAM呢？](https://link.zhihu.com/?target=https%3A//blog.csdn.net/farrellcn/article/details/7956781) x86的pc机cpu在运行的时候程序是存储在RAM中的，而单片机等嵌入式系统则是存于flash中

x86cpu和单片机读取程序的具体途径： pc机在运行程序的时候将程序从外存（硬盘）中，调入到RAM中运行，cpu从RAM中读取程序和数据
而单片机的程序则是固化在flash中，cpu运行时直接从flash中读取程序，从RAM中读取数据

原因分析 ： x86构架的cpu是基于冯.诺依曼体系的，即数据和程序存储在一起，而且pc机的RAM资源相当丰富，从几十M到几百M甚至是几个G，客观上能够承受大量的程序数据。
单片机的构架大多是哈弗体系的，即程序和数据分开存储，而且单片的片内RAM资源是相当有限的，内部的RAM过大会带来成本的大幅度提高。

冯.诺依曼体系与哈佛体系的区别： 二者的区别就是程序空间和数据空间是否是一体的。 早期的微处理器大多采用冯诺依曼结构，典型代表是Intel公司的X86微处理器。取指令和取操作数都在同一总线上，通过分时复用的方式进行的。缺点是在高速运行时，不能达到同时取指令和取操作数，从而形成了传输过程的瓶颈。
哈佛总线技术应用是以DSP和ARM为代表的。采用哈佛总线体系结构的芯片内部程序空间和数据空间是分开的，这就允许同时取指令和取操作数，从而大大提高了运算能力。

### 5.4 ARM 和 x86cpu 指令集RISC和CISC说明

（此部分是学习了韦东山老师的视频后来记录的，原视频可以在韦东山老师官网里面找到：[百问网](https://link.zhihu.com/?target=https%3A//www.100ask.net/)）

ARM芯片属于精简指令集计算机(RISC：Reduced Instruction Set Computing)，它所用的指令比较简单，有如下特点： ① 对内存只有读、写指令 ② 对于数据的运算是在CPU内部实现 ③ 使用RISC指令的CPU复杂度小一点，易于设计



![img](https://pic4.zhimg.com/80/v2-0cff47bce162cfee44f8d9e62af04b87_720w.webp)

在ARM架构中，对于乘法运算a = a * b， 在RISC中要使用4条汇编指令： ① 读内存a ② 读内存b ③ 计算a*b ④ 把结果写入内存

x86属于复杂指令集计算机(CISC：Complex Instruction Set Computing)， 它所用的指令比较复杂，比如某些复杂的指令，它是通过“微程序”来实现的。

![img](https://pic1.zhimg.com/80/v2-707ebb63b8079b626a65ecb639b7083c_720w.webp)

比如执行乘法指令时，实际上会去执行一个“微程序”， 一样是去执行这4步操作： ① 读内存a ② 读内存b ③ 计算a*b ④ 把结果写入内存

**RISC和CISC的区别：**

- CISC的指令能力强，单多数指令使用率低却增加了CPU的复杂度，指令是可变长格式；
- RISC的指令大部分为单周期指令，指令长度固定，操作寄存器，对于内存只有Load/Store操作
- CISC支持多种寻址方式；RISC支持的寻址方式
- CISC通过微程序控制技术实现；
- RISC增加了通用寄存器，硬布线逻辑控制为主，采用流水线
- CISC的研制周期长
- RISC优化编译，有效支持高级语言

## 六、 GCC下生成的.map文件

我们知道了MDK下的.map文件，GCC下的.map文件基本上也可以看懂了，这里添加GCC下.map文件关于RAM的部分：

### 6.1 RAM部分

RAM部分从0x2000 0000开始，首先存放的是.data部分：

![img](https://pic4.zhimg.com/80/v2-2dd9f1a7f8c7235b6ca687f08b7dc1a3_720w.webp)

接下来是.bss段:

![img](https://pic2.zhimg.com/80/v2-9ab551c09be0373ddedb1c2e73de8aa9_720w.webp)

如果使用了FreeRTOS，那么在.bbs段后面会有关于FreeRTOS部分的数据：

![img](https://pic3.zhimg.com/80/v2-183219e2e51ac3861cedcd8b984d9fa2_720w.webp)

最后才到了heap和stack：

![img](https://pic1.zhimg.com/80/v2-a2430c11a4f02d0e26762ba21d981680_720w.webp)



编辑于 2022-06-15 10:14

[内存管理](https://www.zhihu.com/topic/19579205)

[STM32](https://www.zhihu.com/topic/19855229)