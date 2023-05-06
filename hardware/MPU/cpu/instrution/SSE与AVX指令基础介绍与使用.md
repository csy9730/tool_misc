# SSE与AVX指令基础介绍与使用

SSE/AVX指令属于Intrinsics函数，由编译器在编译时直接在调用处插入代码，避免了函数调用的额外开销。但又与inline函数不同，Intrinsics函数的代码由编译器提供，能够更高效地使用机器指令进行优化调整。

在开始之前可以先在CPU-Z或者[Intel产品规范](https://ark.intel.com/content/www/cn/zh/ark.html#@Processors)查看自己CPU的指令集支持情况。

关于SSE和AVX内部函数的相关信息也都可以在[Intel® Intrinsics Guide](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html)查看。

------

## 1.头文件

SSE和AVX指令集有多个不同版本，其函数也包含在对应版本的头文件里。

若不关心具体版本则可以使用 **** 包含所有版本的头文件内容。



highlighter- arduino

```
#include <intrin.h> 
```

> 以下是头文件对照表
>
> | **File**    | **描述**                                     | **VS** | **VisualStudio** |
> | :---------- | :------------------------------------------- | :----- | :--------------- |
> | intrin.h    | All Architectures                            | 8.0    | 2005             |
> | mmintrin.h  | MMX intrinsics                               | 6.0    | 6.0 SP5+PP5      |
> | xmmintrin.h | Streaming SIMD Extensions intrinsics         | 6.0    | 6.0 SP5+PP5      |
> | emmintrin.h | Willamette New Instruction intrinsics (SSE2) | 6.0    | 6.0 SP5+PP5      |
> | pmmintrin.h | SSE3 intrinsics                              | 9.0    | 2008             |
> | tmmintrin.h | SSSE3 intrinsics                             | 9.0    | 2008             |
> | smmintrin.h | SSE4.1 intrinsics                            | 9.0    | 2008             |
> | nmmintrin.h | SSE4.2 intrinsics.                           | 9.0    | 2008             |
> | wmmintrin.h | AES and PCLMULQDQ intrinsics.                | 10.0   | 2010             |
> | immintrin.h | Intel-specific intrinsics(AVX)               | 10.0   | 2010 SP1         |
> | ammintrin.h | AMD-specific intrinsics (FMA4, LWP, XOP)     | 10.0   | 2010 SP1         |
> | mm3dnow.h   | AMD 3DNow! intrinsics                        | 6.0    | 6.0 SP5+PP5      |
>
> 来源[Intrinsics头文件与SIMD指令集、Visual Studio版本对应表 - zyl910](https://www.cnblogs.com/zyl910/archive/2012/02/28/vs_intrin_table.html)

另外，在[Intel® Intrinsics Guide](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html)也可以查询到每个函数所属的指令集和对应的头文件信息。

------

## 2.编译选项

除了头文件以外，我们还需要添加额外的编译选项，才能保证代码被编译成功。

各版本的SSE和AVX都有单独的编译选项，比如-msseN, -mavxN(N表示版本编号)。

经过简单测试后发现，此类编译选项支持向下兼容，比如-msse4可以编译SSE2的函数，-mavx也可以兼容各版本的SSE。

本文中的内容最多涉及到AVX2主要是我的CPU最多支持到这(悲)，所以只需要一个-mavx2就能正常运行文中的所有代码。

------

## 3.数据类型

Intel目前主要的SIMD指令集有MMX, SSE, AVX, AVX-512，其对处理的数据位宽分别是：

- 64位 MMX
- 128位 SSE
- 256位 AVX
- 512位 AVX-512

每种位宽对应一个数据类型，名称包括三个部分：

1. 前缀 **__m**，**两个下划线**加m。
2. 中间是**数据位宽**。
3. 最后加上的字母表示**数据类型**，**i为整数，d为双精度浮点数，\*不加字母则是单精度浮点数\***。

比如SSE指令集的 **__m128**, **__m128i**, **__m128d**

AVX则包括 **__m256**, **__m256i**, **__m256d**。

这里的位宽指的是SIMD寄存器的位宽，CPU需要先将数据加载进专门的寄存器之后再并行计算。

------

## 4.Intrinsic函数命名

同样，Intrinsic函数的命名通常也是由3个部分构成：

1. 第一部分为前缀_mm，MMX和SSE都为_mm开头，AVX和AVX-512则会额外加上256和512的位宽标识。
2. 第二部分表示执行的操作，比如_add,_mul,_load等，操作本身也会有一些修饰，比如_loadu表示以*无需内存对齐*的方式加载数据。
3. 第三部分为操作选择的数据范围和数据类型，比如_ps的p(packed)表示所有数据，s(single)表示单精度浮点。_ss则表示s(single)第一个，s(single)单精度浮点。_epixx（xx为位宽）操作所有的xx位的有符号整数，_epuxx则是操作所有的xx位的无符号整数。

例如_mm256_load_ps表示将浮点数加载进整个256位寄存器中。

绝大部分Intrinsic函数都是按照这样的格式构成，每个函数也都能在[Intel® Intrinsics Guide](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html)找到更为完整的描述。

> 以上介绍内容参照自[SSE指令集学习：Compiler Intrinsic - Brook@CV](https://www.cnblogs.com/wangguchangqing/p/5466301.html)

------

## 5.SSE基础应用

进入正题，现在我们有一个程序需要对A、B数组求和，并将结果写入数组C。



highlighter- cpp

```cpp
#include <stdio.h>

#define SIZE 100000
int main()
{
    float A[SIZE], B[SIZE], C[SIZE];
    
    for(int i = 0; i < SIZE; i++)
        C[i] = A[i] + B[i];
}
```

现在我们来一步步地使用SSE修改这个程序，进行数据并行优化。

导入头文件。



highlighter- arduino

```cpp
#include <intrin.h>
```

创建3个__m128寄存器分别存储三个数组的float值



highlighter- gcode

```
__m128 ra, rb, rc;
```

到了循环体内，我们需要把A、B的值写入寄存器之中，这就需要用到[_mm_loadu_ps](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html#ig_expand=92,92,193,4363&text=_mm_loadu_ps)函数，他会把从指针位置开始的后128位的数据写入寄存器。

至于为什么用loadu而不是load，这个稍后会进行解释。



highlighter- ini

```
ra = _mm_loadu_ps(A + i);
rb = _mm_loadu_ps(B + i);
```

括号里的A+i等价于&A[i]。

之后就是用[_mm_add_ps](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html#ig_expand=92,92,193,4363,153&text=_mm_add_ps)函数计算ra、rb相加，然后把结果返回到rc之中。



highlighter- ini

```
rc = _mm_add_ps(ra, rb);
```

当然还没结束，rc的值还得写回到C数组，这就要用到[_mm_storeu_ps](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html#ig_expand=92,92,193,4363,6928&text=_mm_storeu_ps)函数。

依旧是u结尾的storeu而不是store。



highlighter- reasonml

```
_mm_storeu_ps(C + i, rc);
```

因为128位寄存器一次可以写入4个(128/32)float值，等于一次循环计算4个float的加法，循环的跨度也应该由1变为4，这样循环次数就只需要原来的1/4。



highlighter- nginx

```
for (int i = 0; i < SIZE; i += 4)
```

这样就基本的雏形就完成了，不过在运行之前，**别忘了加上编译选项**。



highlighter- sqf

```cpp
#include <stdio.h>
#include <intrin.h>

#define SIZE 100000
int main()
{
    float A[SIZE], B[SIZE], C[SIZE];

    for (int i = 0; i < SIZE; i += 4)    // 一次计算4个数据，所以要改成+4
    {
        __m128 ra = _mm_loadu_ps(A + i); // ra = {A[i], A[i+1], A[i+2], A[i+3]}
        __m128 rb = _mm_loadu_ps(B + i); // rb = {B[i], B[i+1], B[i+2], B[i+3]}
        __m128 rc = _mm_add_ps(ra, rb);  // rc = ra + rb
        _mm_storeu_ps(C + i, rc);        // C[i~i+3] <= rc
    }
}
```

现在对比一下加速的效果：

[![img](https://img2023.cnblogs.com/blog/2583637/202212/2583637-20221207202053597-478690145.png)](https://img2023.cnblogs.com/blog/2583637/202212/2583637-20221207202053597-478690145.png)

看到这个结果你可能还是有些失望，明明只循环了原来的1/4次，速度却只有1.7倍。

但还没完，前面为了清晰地展示逻辑，导致代码中用了非常多不必要的中间变量（ra、rb、rc都是），作为一个压行选手自然不能容忍这种事情发生，再进行简化一下：



highlighter- sqf

```cpp
#include <stdio.h>
#include <intrin.h>

#define SIZE 100000
int main()
{
    float A[SIZE], B[SIZE], C[SIZE];

    for (int i = 0; i < SIZE; i += 4)
    {
        _mm_storeu_ps(C + i,  _mm_add_ps(_mm_loadu_ps(A + i), _mm_loadu_ps(B + i))); // 压行好耶！
    }
}
```

现在再来看看加速情况：

[![img](https://img2023.cnblogs.com/blog/2583637/202212/2583637-20221207202128849-590089191.png)](https://img2023.cnblogs.com/blog/2583637/202212/2583637-20221207202128849-590089191.png)

简化后达到了2.2倍的速度，相较简化前已经有了大幅度的提升，但即使如此，距离理论上的4倍也还有很大的优化空间，让我们接着看还有什么优化的方法。

------

## 6.内存对齐

### 6.1为什么用loadu

我们刚刚用load和store进行加载和存储的时候，在二者后面加了个‘u’作为修饰，这个u就表示着无需内存对齐。

二者的区别体现在于[Intel® Intrinsics Guide](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html)中的这一句话。

> **[_mm_store_ps](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html#ig_expand=92,92,193,4363,6928,6928,6860&text=_mm_store_ps&techs=SSE)** : mem_addr must be aligned on a 16-byte boundary or a general-protection exception may be generated.
>
> **[_mm_storeu_ps](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html#ig_expand=92,92,193,4363,6928,6928,6860,6928&text=_mm_storeu_ps&techs=SSE)** : mem_addr does not need to be aligned on any particular boundary.

也就是说不加u的版本需要原数据有16字节内存对齐，否则在读取的时候就会触发边界保护产生异常。

xx字节对齐的意思是要求数据的地址是xx字节的整数倍，128位宽的SSE要求16字节内存对齐，而256位宽的AVX函数则是要求32字节内存对齐。

可以明显地看出，内存对齐要求的字节数就是指令需要处理的字节数，而要求内存对齐也是为了能够一次访问就完整地读到数据，从而提升效率。

### 6.2如何进行内存对齐

既然内存对齐后能达到更好的性能，那么我们应该怎么做呢？

创建变量时设置N字节对齐可以用：

1. **__declspec(align(N))**，MSVC专用关键字
2. **__attribute__((__aligned__(N)))**，GCC专用关键字
3. **alignas(N)**，C++11关键字，不过我这里测试只能指定到16，否则就会warning并且无法生效。

只需要在创建变量时在类型名前加上这几个关键字，就像下面这样：



highlighter- scss

```cpp
alignas(16)                      float A[SIZE]; // C++11
__declspec(align(16))            float B[SIZE]; // MSVC
__attribute__((__aligned__(16))) float C[SIZE]; // GCC
```

对于new或malloc这种申请的内存也有相应的设置方法：

1. **_aligned_malloc(size, N)**，包含在<stdlib.h>头文件中，与malloc相比多了一个参数N用于指定内存对齐。**注意！用此方法申请的内存需要用 _aligned_free() 进行释放**。
2. **new((std::align_val_t) N)**，C++17新特性，需要在GCC7及以上版本使用 **-std=c++17** 编译选项开启。

具体使用方式如下：



highlighter- cpp

```cpp
float *A = new ((std::align_val_t)32) float[SIZE];             // C++17
float *B = (float *)_aligned_malloc(sizeof(float) * SIZE, 32); // <stdlib.h>
_aligned_free(B);                                              // 用于释放_aligned_malloc申请的内存
```

使用关键字把数组进行16字节内存对齐后，就可以放心地把loadu和storeu替换成load和store。



highlighter- sqf

```cpp
#include <stdio.h>
#include <intrin.h>

#define SIZE 100000
int main()
{
    __attribute__((__aligned__(16))) float A[SIZE], B[SIZE], C[SIZE]; // GCC的内存对齐

    for (int i = 0; i < SIZE; i += 4)
    {
        _mm_store_ps(C + i,  _mm_add_ps(_mm_load_ps(A + i), _mm_load_ps(B + i))); // 用store和load替换storeu和loadu
    }
}
```

在我的测试平台，编译器会自动对数组和申请的内存空间进行16字节对齐，所以这次修改对SSE指令其实影响不大，但到后面使用要求32字节对齐的AVX指令就很有必要了。

不过我们可以手动将其修改为8字节对齐，来对比一下与16字节之间的性能差距：

[![img](https://img2023.cnblogs.com/blog/2583637/202212/2583637-20221207202755359-1158155267.png)](https://img2023.cnblogs.com/blog/2583637/202212/2583637-20221207202755359-1158155267.png)

可以看到对于load和loadu，内存对齐之后速度只有略微的提升。

但你肯定也注意到了，这个所谓的“类型转换”居然直接霸榜了，内存对齐之后更是从3.6提升到了3.8倍，这已经非常接近理论上的4倍提升了。

那么接下来我们就来了解一下这个“类型转换”究竟是什么。

------

## 7.类型转换

对代码进行单步调试，观察一下几个函数在头文件中的实现方式。

在程序运行到_mm_load_ps时点击单步进入，到达函数内部。



highlighter- sqf

```cpp
/* Load four SPFP values from P.  The address must be 16-byte aligned.  */
extern __inline __m128 __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_load_ps (float const *__P)
{
  return *(__m128 *)__P;
}
```

> _mm_loadu_ps对应的类型是*(__m128_u *)__P

忽视上面的几个声明，可以发现这个函数只是对传入的指针进行了一次类型转换，这个转换看着可能有点绕，但拆分后其实很简单，将*(__m128 *)__P分成两个部分：

1. (__m128 *)__P：将__P从float *类型转换为__m128 *
2. *：访问__m128 *指针指向的__m128对象

而_mm_store_ps也是类似的操作：



highlighter- sqf

```cpp
/* Store four SPFP values.  The address must be 16-byte aligned.  */
extern __inline void __attribute__((__gnu_inline__, __always_inline__, __artificial__))
_mm_store_ps (float *__P, __m128 __A)
{
  *(__m128 *)__P = __A;
}
```

既然这么简单，那我们完全可以自己手动来实现这一步：



highlighter- sqf

```cpp
#include <stdio.h>
#include <intrin.h>

#define SIZE 100000
int main()
{
    __attribute__((__aligned__(16))) float A[SIZE], B[SIZE], C[SIZE];

    for (int i = 0; i < SIZE; i += 4)
    {
        *(__m128 *)(C + i) = _mm_add_ps(*(__m128 *)(A + i), *(__m128 *)(B + i)); // 使用类型转换
    }
}
```

转换成__m128*同样是有内存对齐要求的，若是低于16字节对齐就会在访问指针时出错，非对齐的情况应该使用__m128_u*指针。

------

## 8.AVX

AVX的用法与SSE相同，只需要根据命名规律修改一下数据类型和函数的名称就可以了。

AVX的数据处理位宽为256位，是SSE的两倍，因此内存对齐要求也提升到了 **32字节**。



highlighter- sqf

```cpp
#include <stdio.h>
#include <intrin.h>

#define SIZE 100000
int main()
{
    __attribute__((__aligned__(32))) float A[SIZE], B[SIZE], C[SIZE]; // 32字节对齐

    for (int i = 0; i < SIZE; i += 8) // 循环跨度修改为8
    {
        *(__m256 *)(C + i) = _mm256_add_ps(*(__m256 *)(A + i), *(__m256 *)(B + i)); // 使用256位宽的数据与函数
    }
}
```

来测试一下速度提升：

[![img](https://img2023.cnblogs.com/blog/2583637/202212/2583637-20221207204351979-842623841.png)](https://img2023.cnblogs.com/blog/2583637/202212/2583637-20221207204351979-842623841.png)

可以看到内存对齐方式对AVX的性能也是有一定影响的，在内存对齐之后AVX也能达到7倍的提升。

## 9.整数操作

最后是对SSE/AVX整数操作的一些简单补充，文章开头介绍时提到过，整数计算使用的数据类型是__m128i/__m256i，二者都是以i结尾。

还有基本的算数函数，比如SSE的加法add，epi表示整数，后面的数字就是单个整数的数据位宽。比如epi8就是1字节char加法，4字节int加法就是epi32。



highlighter- sqf

```cpp
__m128i _mm_add_epi8 (__m128i a, __m128i b)
__m128i _mm_add_epi16 (__m128i a, __m128i b)
__m128i _mm_add_epi32 (__m128i a, __m128i b)
__m128i _mm_add_epi64 (__m128i a, __m128i b)
```

**最坑的一个就是整数乘法**，还是以SSE为例：



highlighter- sqf

```cpp
// mul
__m128i _mm_mul_epi32 (__m128i a, __m128i b)
__m128i _mm_mul_epu32 (__m128i a, __m128i b)
// mullo
__m128i _mm_mullo_epi16 (__m128i a, __m128i b)
__m128i _mm_mullo_epi32 (__m128i a, __m128i b)
__m128i _mm_mullo_epi64 (__m128i a, __m128i b)
// mulhi
__m128i _mm_mulhi_epi16 (__m128i a, __m128i b)
__m128i _mm_mulhi_epu16 (__m128i a, __m128i b)
```

可以看到有三种不同功能的乘法，如果没有事先了解过的话很极其容易用错版本，强烈建议使用之前到[Intel® Intrinsics Guide](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html)查看一下功能描述。

## 参考文献

[SSE指令集学习：Compiler Intrinsic](https://www.cnblogs.com/wangguchangqing/p/5466301.html)

[Intel® Intrinsics Guide](https://www.intel.com/content/www/us/en/docs/intrinsics-guide/index.html)

[AVX / AVX2 指令编程](https://www.cnblogs.com/qmjc/p/13495708.html)

[第4篇:C/C++ 结构体及其数组的内存对齐](https://zhuanlan.zhihu.com/p/184956286)

[在C/C++代码中使用SSE等指令集的指令(3)SSE指令集基础](https://blog.csdn.net/gengshenghong/article/details/7008704)

[__declspec(align())内存对齐](https://blog.csdn.net/hevc_cjl/article/details/12359627)

[C++11 内存对齐 alignof alignas](https://blog.csdn.net/luoshabugui/article/details/83268086)

[GCC平台C++17 新特性aligned_new 的使用](https://www.jianshu.com/p/7ce101df70da)

------

> 本文发布于2022年12月7日
>
> 最后修改于2022年12月7日