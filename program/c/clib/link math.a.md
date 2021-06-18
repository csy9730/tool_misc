# link math.a

首先，

引用数学库
```
#include<math.h>
```
 

引用数学库时，要在编译后加上-lm

**是每一个都要加！！**

如下：
```
gcc su.c -o su.o -lm

gcc -g  su.c -lm
```
每一个都要加，不然每一个都会报错！！



引用math.h的时候，数学函数报错为未定义的符号
```
undefined reference to `log10'
undefined reference to `floor'
 undefined reference to `pow‘
```
 编译的是没有没有引用数学函数的函数库导致的，在gcc yoursourcefile.c 的时候加上' -lm' 就好了 "gcc -lm yoursourcefile.c" 编译通过