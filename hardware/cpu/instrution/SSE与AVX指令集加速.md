# SSE与AVX指令集加速

[![img](https://upload.jianshu.io/users/upload_avatars/18517645/9a745851-3385-4df0-9125-0b3416a789dc.png?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)](https://www.jianshu.com/u/a671f9f312d2)

[zackary_shen](https://www.jianshu.com/u/a671f9f312d2)关注

2021.08.10 09:09:59字数 1,343阅读 3,060

# SSE与AVX指令集

> `SSE`指令集是英特尔提供的基于`SIMD`（**单指令多数据，也就是说同一时间内，对多个不同的数据执行同一条命令**）的硬件加速指令，通过使用寄存器来进行并行加速。经过几代的迭代，最新的`SSE4`已经极大地扩展了指令集的功能，并且随后已经从128位寄存器继续扩展到256位的指令。

想要使用SSE或AVX指令集，需要包含以下头文件



```c
#include <mmintrin.h>   //mmx, 4个64位寄存器
#include <xmmintrin.h>  //sse, 8个128位寄存器
#include <emmintrin.h>  //sse2, 8个128位寄存器
#include <pmmintrin.h>  //sse3, 8个128位寄存器
#include <smmintrin.h>  //sse4.1, 8个128位寄存器
#include <nmmintrin.h>  //sse4.2, 8个128位寄存器
#include <immintrin.h>  // avx, 16个256位寄存器
```

#### 1. **intrinsics**

intrinsic是将xmm、sse等指令封装，变成内联函数以减少函数调用的一种操作，具体语法如下：



```c
#pragma intrinsic(function_name)
```

**intrinsic只允许内联诸如标准库函数或部分函数，是通过内联底层标准函数而减小开销的，不是所有函数都能使用。而指令集SSE、AVX等属于封装好的标准内联函数，导入头文件之后可直接使用。**

#### 2. SSE指令集

完整的SSE指令集可以点击[此处](https://links.jianshu.com/go?to=https%3A%2F%2Fsoftpixel.com%2F~cwright%2Fprogramming%2Fsimd%2Fsse.php)查看。

我们主要关注SSE指令集在C和C++上的应用。在工程中，对于128位的寄存器，最实用的操作就是当做4个32位单精度的浮点数。**其中，`包装指令集`是指矢量指令集，单个指令会对VALU中的数据都进行同一指令操作；而`标量指令`是指指令只对寄存器最低位的数据进行操作**。

![img](https://upload-images.jianshu.io/upload_images/18517645-744fa6122cd0742d.png?imageMogr2/auto-orient/strip|imageView2/2/w/737/format/webp)

SSE架构

以下是[常用的函数](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.cnblogs.com%2Fdragon2012%2Fp%2F5200698.html)。

1. 编译语句

   

   ```shell
   g++ -msse4 filename.cpp
   ```

1. 编程实例

   对于多核处理器，每一个核都有着自己的缓存，以及FPU、VALU模块。VALU允许同时操作4个浮点数，通过SSE指令集加速一个128位矢量的FDTD程序。

   1. 相加的简例

      

      ```c
      /* 对于变量v1与v2各有x、y、z、w四个属性，vec_res的结果便是v1、v2对应的属性相加 */
      
      // 标量版本
      vec_res.x = v1.x + v2.x;
      vec_res.y = v1.y + v2.y;
      vec_res.z = v1.z + v2.z;
      vec_res.w = v1.w + v2.w;
      
      // VALU版本
      movaps xmm0, [v1];                    // 将要移动v1变量到xmm0寄存器中
      xmm0 = v1.w | v1.z | v1.y | v1.x ;    // 将4个值加载到寄存器中
      addps xmm0, [v2];                     // 将要对xmm0和v2变量进行相加
      xmm0 = v1.w + v2.w | v1.z + v2.z | v1.y + v2.y | v1.x + v2.x ;  // 相加
      movaps [vec_res], xmm0;               // 将寄存器的值赋给vec_res
      ```

   2. C++矢量相乘简例

      **注意**：在编译时必须使用`g++`编译器，同时，SSE指令集有`SSE`、`SSE2`、`SSE3`、`SSE4`几种，越新的版本功能就越多，可以通过在使用`g++`编译链接时，加上`-msse4`使用`SSE4`指令集，其他以此类推。

      

      ```c
      /* 使用SSE指令进行矢量相乘加速 */
      
      #include<iostream>
      // 使用SSE指令集需要的头文件
      #include<xmmintrin.h>
      using namespace std;
      
      int main()
      {
          // VALU加速版本: 0m0.004s
          __m128 a, b;
      
          a = _mm_set_ps(1, 2, 3, 4);
          b = _mm_set_ps(1, 2, 3, 4);
      
          __m128 c = _mm_add_ps(a, b);
          
          for(int i=0; i<4; i++)
          {
              cout << a[i] << endl;
          }
          
          return 0;
      }
      ```

#### 3. 扩展后的AVX指令集

1. **新增特性**

   - 将 128 位 SIMD 寄存器扩展至 256 位。
   - 添加了 3 操作数非破坏性运算。之前在 A = A + B 类运算中执行的是 2 操作数指令，它将覆盖源操作数，而**新的操作数可以执行 A = B + C 类运算，且保持原始源操作数不变**。

   **需要启用AVX指令时，编译必须加上 `-mvax`，否则会报错。头文件中包含的所有函数在 [此处](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Ffuxiaoxiaoyue%2Farticle%2Fdetails%2F83153667) 可以查看。**

1. 编译语句：

   

   ```shell
   g++ -mavx filename.cpp
   ```

1. YMM寄存区

   相比于早年128位的XMM寄存器，英特尔AVX提供了256位的YMM寄存器，而XMM被视作了相应的底层部分。

![img](https://upload-images.jianshu.io/upload_images/18517645-58fc82d7d40887be.gif?imageMogr2/auto-orient/strip|imageView2/2/w/329/format/webp)

YMM寄存器

1. 对齐

   当源数据是关于n位对齐（也就是能完整地以n为一个单位切分）地存入YMM寄存器中，称之为数据对齐。对于SSE运算来说，默认必须保证数据对齐（虽不必须，但最好保证，某些操作并不提供非对齐的操作版本）。

1. 尽量不要VEX与XMM指令混用

   混合使用旧的仅 XMM 的指令和较新的AVX 指令会导致延迟 ，所以不要将 VEX 前缀的指令和非 VEX 前缀的指令混合使用，以实现最佳吞吐量 。

1. 相加的例子

   

   ```c
   #include<iostream>
   #include<immintrin.h>   // avx
   using namespace std;
   
   int main()
   {
       __m256 a, b;
       
       /*
       Note:
       随着位数的变化，寄存器可以存放的同一类型数据的个数也发生了翻倍，
       在128位的SSE中，_mm_set_ps()可以计算4个float型数据，而到了
       256位的AVX中，_mm256_set_ps()可以计算8个float型数据。
       */
       
       a =  _mm256_set_ps(1, 2, 3, 4, 5, 6, 7, 8);
       b =  _mm256_set_ps(1, 2, 3, 4, 5, 6, 7, 8);
   
       __m256 c = _mm256_add_ps(a, b);
   
       for(int i=0; i<8; i++)
       {
           cout << c[i] << endl;
       }
   
       return 0;
   }
   ```



0人点赞



[性能优化](https://www.jianshu.com/nb/50533314)



更多精彩内容，就在简书APP