# 一文读懂SIMD指令集 目前最全SSE/AVX介绍

Axurq

于 2021-06-06 21:48:19 发布

6042
 收藏 55
分类专栏： 学习日记 文章标签： c++ SIMD SSE AVX
版权

学习日记
专栏收录该内容
40 篇文章4 订阅
订阅专栏
SIMD指令集 SSE/AVX
概述
参考手册
Intel® Intrinsics Guide

Tommesani.com Docs

Intel® 64 and IA-32 Architectures Software Developer Manuals

背景
1. 什么是指令集
所谓指令集，就是CPU中用来计算和控制计算机系统的一套指令的集合，而每一种新型的CPU在设计时就规定了一系列与其他硬件电路相配合的指令系统。而指令集的先进与否，也关系到CPU的性能发挥，它也是CPU性能体现的一个重要标志。
通俗的理解，指令集就是CPU能认识的语言，指令集运行于一定的微架构之上，不同的微架构可以支持相同的指令集，比如Intel和AMD的CPU的微架构是不同的，但是同样支持X86指令集，这很容易理解，指令集只是一套指令集合，一套指令规范，具体的实现，仍然依赖于CPU的翻译和执行。指令集一般分为RISC（精简指令集 Reduced Instruction Set Computer）和CISC（复杂指令集Complex Instruction Set Computer）。Intel X86的第一个CPU定义了第一套指令集，后来一些公司发现很多指令并不常用，所以决定设计一套简洁高效的指令集，称之为RICS指令集，从而将原来的Intel X86指令集定义为CISC指令集。两者的使用场合不一样，对于复杂的系统，CISC更合适，否则，RICS更合适，且低功耗。

SIMD（Single Instruction Multiple Data）指令集，指单指令多数据流技术，可用一组指令对多组数据通进行并行操作。SIMD指令可以在一个控制器上控制同时多个平行的处理微元，一次指令运算执行多个数据流，这样在很多时候可以提高程序的运算速度。SIMD指令在本质上非常类似一个向量处理器，可对控制器上的一组数据（又称“数据向量”） 同时分别执行相同的操作从而实现空间上的并行。SIMD是CPU实现DLP（Data Level Parallelism）的关键，DLP就是按照SIMD模式完成计算的。SSE和较早的MMX和 AMD的3DNow!都是SIMD指令集。它可以通过单指令多数据技术和单时钟周期并行处理多个浮点来有效地提高浮点运算速度。

3. 指令集发展
指令集是一直在发展的，在CISC指令集中，慢慢的发展了一系列的指令集：

X86指令集：
X86指令集是Intel为其第一块16位CPU(i8086)专门开发的，IBM1981年推出的世界第一台PC机中的CPU—i8088(i8086简化版)使用的也是X86指令，同时电脑中为提高浮点数据处理能力而增加的X87芯片系列数学协处理器则另外使用X87指令，以后就将X86指令集和X87指令集统称为X86指令集。

MMX指令集：（MultiMedia eXtensions）
1997年Intel公司推出了多媒体扩展指令集MMX，它包括57条多媒体指令。MMX指令主要用于增强CPU对多媒体信息的处理能力，提高CPU处理3D图形、视频和音频信息的能力。

SSE指令集：Streaming SIMD Extensions（系列）
由于MMX指令并没有带来3D游戏性能的显著提升，所以，1999年Inter公司在Pentium III CPU产品中推出了数据流单指令序列扩展指令（SSE），兼容MMX指令。SSE为Streaming SIMD Extensions的缩写，如同其名称所表示的，是一种SSE指令包括了四个主要的部份：单精确度浮点数运算指令、整数运算指令（此为MMX之延伸，并和MMX使用同样的寄存器）、Cache控制指令、和状态控制指令。
在Pentium 4 CPU中，Inter公司开发了新指令集SSE2。SSE2指令一共144条，包括浮点SIMD指令、整形SIMD指令、SIMD浮点和整形数据之间转换、数据在MMX寄存器中转换等几大部分。其中重要的改进包括引入新的数据格式，如：128位SIMD整数运算和64位双精度浮点运算等。
相对于SSE2，SSE3又新增加了13条新指令，此前它们被统称为pni(prescott new instructions)。13条指令中，一条用于视频解码，两条用于线程同步，其余用于复杂的数学运算、浮点到整数转换和SIMD浮点运算。
SSE4增加了50条新的增加性能的指令，这些指令有助于编译、媒体、字符/文本处理和程序指向加速。

AVX指令集：（Advanced Vector Extensions）
在2010年AVX将之前浮点运算数据的宽度从128bit的扩展到256bit。同时新的CPU架构下数据传输速度也获得了提升。AVX指令集在SIMD计算性能增强的同时也沿用了的MMX/SSE指令集。不过和MMX/SSE的不同点在于，增强的AVX指令在指令的格式上也发生了很大的变化。x86(IA-32/Intel 64)架构的基础上增加了prefix(Prefix)，所以实现了新的命令，也使更加复杂的指令得以实现，从而提升了x86 CPU的性能。AVX并不是x86 CPU的扩展指令集，可以实现更高的效率，同时和CPU硬件兼容性也更好，在SSE指令的基础上AVX也使SSE指令接口更加易用。

在2011年发布的AVX2则在此基础上加入了以下新内容：整数SIMD指令扩展至256位，2个新FMA单元及浮点FMA指令，离散数据加载指令“gather”，新的位移和广播指令。

AVX-512 是 Intel 公司在 2013 年发布的一套扩展指令集，其指令宽度扩展为 512 bit，每个时钟周期内可执行 32 次双精度或 64 次单精度浮点（FP）运算，专门针对图像/音视频处理、数据分析、科学计算、数据加密和压缩和深度学习等大规模运算需求的应用场景。

MMX	64位整型
SSE	128位浮点运算，整数运算仍然要使用MMX 寄存器，只支持单精度浮点运算
SSE2	对整型数据的支持，支持双精度浮点数运算，CPU快取的控制指令
SSE3	扩展的指令包含寄存器的局部位之间的运算，例如高位和低位之间的加减运算；浮点数到整数的转换，以及对超线程技术的支持。
SSE4	
AVX	256位浮点运算
AVX2	对256位整型数据的支持，三运算指令（3-Operand Instructions）
AVX512	512位运算
可以看到，CISC指令集是一只在不断发展的，随着需求的不断增加，指令集也在不断扩展，从而提高CPU的性能。使用软件CPU-Z可以查看CPU支持的指令集。



寄存器与指令数据细节
在MMX指令集中，使用的寄存器称作MM0到MM7，实际上借用了浮点处理器的8个寄存器的低64Bit，这样导致了浮点运算速度降低。

SSE指令集推出时，Intel公司在Pentium III CPU中增加了8个128位的SSE指令专用寄存器，称作XMM0到XMM7。这样SSE指令寄存器可以全速运行，保证了与浮点运算的并行性。这些XMM寄存器用于4个单精度浮点数运算的SIMD执行，并可以与MMX整数运算或x87浮点运算混合执行。

2001年在Pentium 4上引入了SSE2技术，进一步扩展了指令集，使得XMM寄存器上可以执行8/16/32位宽的整数SIMD运算或双精度浮点数的SIMD运算。对整型数据的支持使得所有的MMX指令都是多余的了，同时也避免了占用浮点数寄存器。SSE2为了更好地利用高速寄存器，还新增加了几条寄存指令，允许程序员控制已经寄存过的数据。这使得 SIMD技术基本完善。

SSE3指令集扩展的指令包含寄存器的局部位之间的运算，例如高位和低位之间的加减运算；浮点数到整数的转换，以及对超线程技术的支持。

AVX是Intel的SSE延伸架构，把寄存器XMM 128bit提升至YMM 256bit，以增加一倍的运算效率。此架构支持了三运算指令（3-Operand Instructions），减少在编码上需要先复制才能运算的动作。在微码部分使用了LES LDS这两少用的指令作为延伸指令Prefix。AVX的256bit的YMM寄存器分为两个128bit的lanes，AVX指令并不支持跨lanes的操作。其中YMM寄存器的低128位与Intel SSE指令集的128bitXMM寄存器复用。尽管VGX并不要求内存对齐，但是内存对齐有助于提升性能。如对于128-bit访问的16字节对齐和对于256-bit访问的32字节对齐。

AVX虽然已经将支持的SIMD数据宽度增加到了256位，但仅仅增加了对256位的浮点SIMD支持，整点SIMD数据的宽度还停留在128位上，AVX2支持的整点SIMD数据宽度从128位扩展到256位。同时支持了跨lanes操作，加入了增强广播、置换指令支持的数据元素类型、移位操作对各个数据元素可变移位数的支持、跨距访存支持。AVX硬件由16个256bitYMM寄存器（YMM0~YMM15）组成。

每一代的指令集都是对上一代兼容的，支持上一代的指令，也可以使用上一代的寄存器，也就是说，AVX2也依然支持128位，64位的操作，也可以使用上一代的寄存器（当然，寄存器的硬件实现可能有区别）。AVX也对部分之前的指令接口进行了重构，所以可以在指令文档中找到几个处于不同代际有着相同功能调用接口却不相同的函数。

另外，不同代际的指令不要混用，每次状态切换将消耗 50-80 个时钟周期，会拖慢程序的运行速度。

MMX	SSE	SSE2	AVX	AVX2
寄存器	MM0-MM7	XMM0-XMM7	XMM0-XMM7	YMM0-YMM15	YMM0-YMM15
浮点		128bit	128bit	256bit	256bit
整型	64bit		128bit	128bit	256bit
数据结构
由于通常没有内建的128bit和256bit数据类型，SIMD指令使用自己构建的数据类型，这些类型以union实现，这些数据类型可以称作向量，一般来说，MMX指令是__m64 类型的数据，SSE是__m128类型的数据等等。

typedef union __declspec(intrin_type) _CRT_ALIGN(8) __m64
{
    unsigned __int64    m64_u64;
    float               m64_f32[2];
    __int8              m64_i8[8];
    __int16             m64_i16[4];
    __int32             m64_i32[2];    
    __int64             m64_i64;
    unsigned __int8     m64_u8[8];
    unsigned __int16    m64_u16[4];
    unsigned __int32    m64_u32[2];
} __m64;
1
2
3
4
5
6
7
8
9
10
11
12
typedef union __declspec(intrin_type) _CRT_ALIGN(16) __m128 {
     float               m128_f32[4];
     unsigned __int64    m128_u64[2];
     __int8              m128_i8[16];
     __int16             m128_i16[8];
     __int32             m128_i32[4];
     __int64             m128_i64[2];
     unsigned __int8     m128_u8[16];
     unsigned __int16    m128_u16[8];
     unsigned __int32    m128_u32[4];
 } __m128;
1
2
3
4
5
6
7
8
9
10
11
typedef union __declspec(intrin_type) _CRT_ALIGN(16) __m128i {
    __int8              m128i_i8[16];
    __int16             m128i_i16[8];
    __int32             m128i_i32[4];    
    __int64             m128i_i64[2];
    unsigned __int8     m128i_u8[16];
    unsigned __int16    m128i_u16[8];
    unsigned __int32    m128i_u32[4];
    unsigned __int64    m128i_u64[2];
} __m128i;

typedef struct __declspec(intrin_type) _CRT_ALIGN(16) __m128d {
    double              m128d_f64[2];
} __m128d;
1
2
3
4
5
6
7
8
9
10
11
12
13
14
数据类型	描述
__m128	包含4个float类型数字的向量
__m128d	包含2个double类型数字的向量
__m128i	包含若干个整型数字的向量
__m256	包含8个float类型数字的向量
__m256d	包含4个double类型数字的向量
__m256i	包含若干个整型数字的向量
每一种类型，从2个下划线开头，接一个m，然后是向量的位长度。
如果向量类型是以d结束的，那么向量里面是double类型的数字。如果没有后缀，就代表向量只包含float类型的数字。
整形的向量可以包含各种类型的整形数，例如char,short,unsigned long long。也就是说，__m256i可以包含32个char，16个short类型，8个int类型，4个long类型。这些整形数可以是有符号类型也可以是无符号类型
内存对齐
为了方便CPU用指令对内存进行访问，通常要求某种类型对象的地址必须是某个值K（通常是2、4或8）的倍数，如果一个变量的内存地址正好位于它长度的整数倍，我们就称他是自然对齐的。不同长度的内存访问会用到不同的汇编指令，这种对齐限制简化了形成处理器和存储器系统之间接口的硬件设计，提高了内存的访问效率。

通常对于各种类型的对齐规则如下：

 数组 ：按照基本数据类型对齐，第一个对齐了后面的自然也就对齐了。
 联合 ：按其包含的长度最大的数据类型对齐。
 结构体： 结构体中每个数据类型都要对齐

对于SIMD的内存对齐是指__m128等union在内存中存储时的存储方式。然而由于结构内存对齐的规则略微复杂，我们以结构为例进行说明：

一般情况下，由于内存对齐的原因存储多种类型数据的结构体所占的内存大小并非元素本身类型大小之和。对于自然对齐而言：

对于各成员变量来说，存放的起始地址相对于结构的起始地址的偏移量必须为该变量的类型所占用的字节数的倍数，各成员变量在存放的时候根据在结构中出现的顺序依次申请空间， 同时按照上面的对齐方式调整位置， 空缺的字节自动填充。

对于整个结构体来说，为了确保结构的大小为结构的字节边界数(即该结构中占用最大的空间的类型的字节数)的倍数，所以在为最后一个成员变量申请空间后，还会根据需要自动填充空缺的字节。

所以一般我们在定义结构体时定义各元素的顺序也会影响实际结构体在存储时的整体大小，把大小相同或相近的元素放一起，可以减少结构体占用的内存空间。

除了自然对齐的内存大小，我们也可以设置自己需要的对齐大小，我们称之为对齐系数，如果结构内最大类型的字节数小于对齐系数，结构体内存大小应按最大元素大小对齐，如果最大元素大小超过对齐系数，应按对齐系数大小对齐。

对齐系数大小的设定可以使用下列方法：

#pragma pack (16)使用预编译器指令要求对齐。#pragma pack()恢复为默认对齐方式。

__attribute__ ((aligned (16)))//GCC要求对齐
1
__declspec(intrin_type) _CRT_ALIGN(16)//Microsoft Visual C++要求对齐
1
联合的内存对齐方式与结构类似。

SIMD的指令中通常有对内存对齐的要求，例如，SSE中大部分指令要求地址是16bytes对齐的，以_mm_load_ps函数来说明，这个函数对应于SSE的loadps指令。

函数原型为：extern __m128 _mm_load_ps(float const*_A);

可以看到，它的输入是一个指向float的指针，返回的就是一个__m128类型的数据，从函数的角度理解，就是把一个float数组的四个元素依次读取，返回一个组合的__m128类型的SSE数据类型，从而可以使用这个返回的结果传递给其它的SSE指令进行运算，比如加法等；从汇编的角度理解，它对应的就是读取内存中连续四个地址的float数据，将其放入SSE的寄存器(XMM)中，从而给其他的指令准备好数据进行计算。其使用示例如下：

float input[4] = { 1.0f, 2.0f, 3.0f, 4.0f };
__m128 a = _mm_load_ps(input);	//WARNING
1
2
这里加载正确的前提是：input这个浮点数阵列都是对齐在16 bytes的边上。否则程序会崩溃或得不到正确结果。如果没有对齐，就需要使用_mm_loadu_ps函数，这个函数用于处理没有对齐在16bytes上的数据，但是其速度会比较慢。
对于上面的例子，如果要将input指定为16bytes对齐，可以采用的方式是：

__declspec(align(16)) float input[4] = {1.0, 2.0, 3.0, 4.0};
1

为了简化，头文件<xmmintrin.h>中定义了一个宏```_MM_ALIGN16```来表示上面的含义，即可以用：

```C
_MM_ALIGN16 float input[4] = {1.0, 2.0, 3.0, 4.0};
1
2
3
4
5
动态数组（dynamic array）可由_aligned_malloc函数为其分配空间：

 input = (float*) _aligned_malloc(ARRAY_SIZE * sizeof(float), 16);
1
由_aligned_malloc函数分配空间的动态数组可以由_aligned_free函数释放其占用的空间：

_aligned_free(input);
1
256-bit AVX 指令在内存访问上对内存对齐比128-bit SSE 指令有更高要求。虽然在一个cache-line 之内，Intel 的对齐和非对齐指令已经没有性能差距了，但是由于AVX 有更长的内存访问宽度（YMM <-> memory），会更频繁地触及cache-line 边界。所以1）尽量使用对齐内存分配；2）有时候内存对齐不能保证，可以用128-bit（XMM）指令访问内存，然后再组合成256-bit YMM

工作模式
packed和scalar
SIMD的运算指令分为两大类：packed和scalar。
Packed指令是一次对XMM寄存器中的四个数（即DATA0 ~ DATA3）均进行计算，而scalar则只对XMM寄存器中的DATA0进行计算。如下图所示：



定址方式
SIMD指令和一般的x86 指令很类似，基本上包括两种定址方式：寄存器-寄存器方式(reg-reg)和寄存器-内存方式(reg-mem)：

addps xmm0, xmm1 ; reg-reg
addps xmm0, [ebx] ; reg-mem
1
2
大小端



float input[4] = { 1.0f, 2.0f, 3.0f, 4.0f };
__m128 a = _mm_load_ps(input);
1
2
3
由于x86的little-endian特性，位址较低的byte会放在寄存器的右边。也就是说，在载入到XMM寄存器后，寄存器中的DATA0会是1.0，而DATA1是2.0，DATA2是3.0，DATA3是4.0。如果需要以相反的顺序载入的话，可以用_mm_loadr_ps 这个intrinsic。



环境配置
使用软件CPU-Z可以查看CPU支持的指令集。

编译器设置
 我们可以在C/C++使用封装的函数而不是嵌入的汇编代码的方式来调用指令集，这就是Compiler Intrinsics。

 Intrinsics指令是对MMX、SSE等指令集的指令的一种封装，以函数的形式提供，使得程序员更容易编写和使用这些高级指令，在编译的时候，这些函数会被内联为汇编，不会产生函数调用的开销。

 除了我们这里使用的intrinsics指令，还有intrinsics函数需要以作区分，这两者既有联系又有区别。编译器指令#pragma intrinsic()可以将一些指定的系统库函数编译为内部函数，从而去掉函数调用参数传递等的开销，这种方式只适用于编译器规定的一部分函数，不是所有函数都能使用，同时会增大生成代码的大小。

 intrinsics更广泛的使用是指令集的封装，能将函数直接映射到高级指令集，同时隐藏了寄存器分配和调度等，从而使得程序员可以以函数调用的方式来实现汇编能达到的功能，编译器会生成为对应的SSE等指令集汇编。

Intel Intrinsic Guide可以查询到所有的Intrinsic指令、对应的汇编指令以及如何使用等。

 对于VC来说，VC6支持MMX、3DNow!、SSE、SSE2，然后更高版本的VC支持更多的指令集。但是，VC没有提供检测Intrinsic函数集支持性的办法。
　　而对于GCC来说，它使用-mmmx、-msse等编译器开关来启用各种指令集，同时定义了对应的 __MMX__、__SSE__等宏，然后x86intrin.h会根据这些宏来声明相应的Intrinsic函数集。__MMX__、__SSE__等宏可以帮助我们判断Intrinsic函数集是否支持，但这只是GCC的专用功能。

如果使用GCC编译器时，使用intrinsics指令时需要在编写cmake或者makefile文件时加上相关参数，例如使用AVX指令集时添加-mavx2参数。

CMake
GCC:

头文件	宏	编译器参数
avx2intrin.h	__AVX2__	-mavx2
avxintrin.h	__AVX__	-mavx
emmintrin.h	__SSE2__	-msse2
nmmintrin.h	__SSE4_2__	-msse4.2
xmmintrin.h	__SSE__	-msse
mmintrin.h	__MMX__	-mmmx
头文件设置
#include <mmintrin.h> //MMX
#include <xmmintrin.h> //SSE(include mmintrin.h)
#include <emmintrin.h> //SSE2(include xmmintrin.h)
#include <pmmintrin.h> //SSE3(include emmintrin.h)
#include <tmmintrin.h>//SSSE3(include pmmintrin.h)
#include <smmintrin.h>//SSE4.1(include tmmintrin.h)
#include <nmmintrin.h>//SSE4.2(include smmintrin.h)
#include <wmmintrin.h>//AES(include nmmintrin.h)
#include <immintrin.h>//AVX(include wmmintrin.h)
#include <intrin.h>//(include immintrin.h)
1
2
3
4
5
6
7
8
9
10
上述头文件中，下一个头文件包含上一个头文件中内容，例如xmmintrin.h为SSE 头文件，此头文件里包含MMX头文件，emmintrin.h为SSE2头文件，此头文件里包含SSE头文件。

VC引入<intrin.h>会自动引入当前编译器所支持的所有Intrinsic头文件。GCC引入<x86intrin.h>.

使用
使用方式
数据存取
使用SSE指令，首先要了解这一类用于进行初始化加载数据以及将寄存器的数据保存到内存相关的指令，我们知道，大多数SSE指令是使用的xmm0到xmm8的寄存器，那么使用之前，就需要将数据从内存加载到这些寄存器，在寄存器中完成运算后， 再把计算结果从寄存器中取出放入内存。C++编程人员在使用SSE指令函数编程时，除了加载存储数据外，不必关心这些128位的寄存器的调度，你可以使用128位的数据类型__m128和一系列C++函数来实现这些算术和逻辑操作，而决定程序使用哪个SSE寄存器以及代码优化是C++编译器的任务。

load系列函数，用于加载数据，从内存到寄存器。

set系列函数，用于加载数据，大部分需要多个指令执行周期完成，但是可能不需要16字节对齐.这一系列函数主要是类似于load的操作，但是可能会调用多条指令去完成，方便的是可能不需要考虑对齐的问题。

store系列函数，用于将计算结果等SSE寄存器的数据保存到内存中。这一系列函数和load系列函数的功能对应，基本上都是一个反向的过程

SSE 指令和 AVX 指令混用
SSE/AVX 的混用有时不可避免，AVX-SSE transition penalty并不是由混合SSE和AVX指令导致的，而是因为混合了legacy SSE encoding 和 VEX encoding。

所以在使用Intel intrinsic写全新的程序时其实并不需要太担心这个问题，因为只要指定了合适的CPU 架构（比如-mavx），SSE 和AVX intrinsic 都会被编译器生成VEX-encoding 代码。

函数命名
SIMD指令的intrinsics函数名称一般为如下形式，

_mm<bit_width>_<name>_<data_type>
1
<bit_width> 表明了向量的位长度，即操作对象的数据类型大小，对于128位的向量，这个参数为空，对于256位的向量，这个参数为256。

<name>描述了内联函数的算术操作。一般由两部分组成：

第一部分是表示指令的作用，比如加法add等；

第二部分是可选的修饰符，表示一些特殊的作用，比如从内存对齐，逆序加载等；

<data_type> 表明了操作的粒度，具体情形见下表：

<data_type>标识		数据类型
epi8/epi16/epi32		有符号的8,16,32位整数
epu8/epu16/epu32		无符号的8,16.32位整数
si128/si256		未指定的128,256位向量
ps		包装型单精度浮点数
ss	scalar single precision floating point data	数量型单精度浮点数
pd	pached double precision floating point data	包装型双精度浮点数
sd		数量型双精度浮点数
可选的修饰符	示例	描述
u	loadu	Unaligned memory: 对内存未对齐的数据进行操作
s	subs/adds	Saturate: 饱和计算将考虑内存能够存储的最小/最大值。非饱和计算略内存问题。即计算的上溢和下溢
h	hsub/hadd	Horizontally: 在水平方向上做加减法
hi/lo	mulhi	高/低位
r	setr	Reverse order: 逆序初始化向量
fm	fmadd	Fused-Multiply-Add(FMA)运算，单一指令进行三元运算
在饱和模式下，当计算结果发生溢出（上溢或下溢）时，CPU会自动去掉溢出的部分，使计算结果取该数据类型表示数值的上限值（如果上溢）或下限值（如果下溢）。

注释中的printf部分是利用__m128这个数据类型来获取相关的值，这个类型是一个union类型，具体定义可以参考相关头文件，但是，对于实际使用，有时候这个值是一个中间值，需要后面计算使用，就得使用store了，效率更高。上面使用的是_mm_loadu_ps和_mm_storeu_ps，不要求字节对齐，如果使用_mm_load_ps和_mm_store_ps，会发现程序会崩溃或得不到正确结果。下面是指定字节对齐后的一种实现方法：

这类函数名一般以__m开头。函数名称和指令名称有一定的关系

部分函数的说明
_mm_load_ss用于scalar的加载，所以，加载一个单精度浮点数到寄存器的低字节，其它三个字节清0，（r0 := *p, r1 := r2 := r3 := 0.0）。

_mm_load_ps用于packed的加载（下面的都是用于packed的），要求p的地址是16字节对齐，否则读取的结果会出错，（r0 := p[0], r1 := p[1], r2 := p[2], r3 := p[3]）。
_mm_load1_ps表示将p地址的值，加载到寄存器的四个字节，需要多条指令完成，所以，从性能考虑，在内层循环不要使用这类指令。（r0 := r1 := r2 := r3 := *p）。
_mm_loadh_pi和_mm_loadl_pi分别用于从两个参数高底字节等组合加载。具体参考手册。
_mm_loadr_ps表示以_mm_load_ps反向的顺序加载，需要多条指令完成，当然，也要求地址是16字节对齐。（r0 := p[3], r1 := p[2], r2 := p[1], r3 := p[0]）。
_mm_loadu_ps和_mm_load_ps一样的加载，但是不要求地址是16字节对齐，对应指令为movups。

_mm_set_ss对应于_mm_load_ss的功能，不需要字节对齐，需要多条指令。（r0 = w, r1 = r2 = r3 = 0.0）
_mm_set_ps对应于_mm_load_ps的功能，参数是四个单独的单精度浮点数，所以也不需要字节对齐，需要多条指令。（r0=w, r1 = x, r2 = y, r3 = z，注意顺序）
_mm_set1_ps对应于_mm_load1_ps的功能，不需要字节对齐，需要多条指令。（r0 = r1 = r2 = r3 = w）
_mm_setzero_ps是清0操作，只需要一条指令。（r0 = r1 = r2 = r3 = 0.0）

_mm_store_ss：一条指令，*p = a0
_mm_store_ps：一条指令，p[i] = a[i]。
_mm_store1_ps：多条指令，p[i] = a0。
_mm_storeh_pi，_mm_storel_pi：值保存其高位或低位。

_mm_storer_ps：反向，多条指令。
_mm_storeu_ps：一条指令，p[i] = a[i]，不要求16字节对齐。
_mm_stream_ps：直接写入内存，不改变cache的数据

permute

根据8位控制值从输入向量中选择元素



Shuffle


功能
跨距访存支持即访存时，每个SIMD数据的向量数据元素可以来自不相邻的内存地址。AVX2的跨距访存指令称为”gather”指令，该指令的操作数是一个基地址加一个向量寄存器，向量寄存器中存放着SIMD数据中各个元素相对基地址的偏移量是多少。有了这条指令，CPU可以轻松用一条指令实现若干不连续数据”聚集”到一个SIMD寄存器中。这会对编译器和虚拟机充分利用向量指令带来很大便利，尤其是自动向量化。另外，参考2中对跨距访存指令的功能描述中可以看到，当该指令的偏移地址向量寄存器中任何两个值相同时，都会出GP错。这意味着编译器还是需要些特殊处理才能利用好这条指令。

跨距访存指令

但跨距访存指令仅仅支持32位整点、64位整点、单精度浮点、双精度浮点的跨距访存操作。从参考4可以猜测其实gather指令只是在硬件上分解成若干条32位或64位的微访存指令实现。这就移位着其实一条32×8的SIMD访存其实就是8次32位普通数据访存，其访存延时和延时不确定性会非常大，聊剩于无。

引入了Fused-Multiply-Add(FMA)运算。所谓FMA，即可通过单一指令实现A = A ∗ B + C A=A*B+CA=A∗B+C计算。

FMA指令集是AVX的扩展指令集，即熔合乘法累积，一种三元运算指令，允许建立新的指令并有效率地执行各种复杂的运算。熔合乘法累积可结合乘法与加法运算，通过单一指令执行多次重复计算，从而简化程序，从而使系统能快速执行绘图、渲染、相片着色、立体音效，及复杂向量运算等计算量大的工作。

FMA则关系到浮点运算能力。Haswell架构中拥有2个新的FMA单元（Intel的FMA3指令），每个FMA单元支持8个单精度或4个双精度浮点数，每周期单/双精度FLOPs都要比AVX高1倍。

FMA拥有20种指令形式，与3种操作数次序组合，形成60种新指令，为选择内存操作数或目的操作数提供了极大的灵活性。另外融合乘加还会自动选择多项式的计算过程，降低了延迟。

在AVX中，Intel定义了两个128位通道，分别是高通道和低通道，不同通道不能互取数据；到AVX2中，跨通道数据排列操作则实现了高低通道数据互通，效率更高。

引用
CPU指令集介绍_。。。。-CSDN博客
在C/C++代码中使用SSE等指令集的指令(1)
在C/C++代码中使用SSE等指令集的指令(3)
在C/C++代码中使用SSE等指令集的指令(4)
在C/C++代码中使用SSE等指令集的指令(5)
x86 - Is NOT missing from SSE, AVX? - Stack Overflow
Intel 内部指令 — AVX和AVX2学习笔记
Intel 的AVX2指令集解读
基于SSE指令集的程序设计简介
单指令多数据SIMD的SSE/AVX指令集和API
为什么AVX反而比SSE慢)
SIMD技术中各向量化指令集的特性
regatepagefirst_rank_v2rank_aggregation-4-114177421.pc_agg_rank_aggregation&utm_term=avx2+指令集&spm=1000.2123.3001.4430)
为什么AVX反而比SSE慢)
SIMD技术中各向量化指令集的特性

高性能云服务器

精品线路独享带宽，毫秒延迟，年中盛惠 1 折起

 
显示推荐内容
```





