# [C++编译期间字节序判断](https://www.cnblogs.com/oloroso/p/6203365.html)

当前常用的字节序一般就两种，大端序和小端序。
下面列出四种字节序的表达方式。在对应平台下，内存布局为{0x,00,0x01,0x02,0x03}的四字节，表示为十六进制的值就如下面代码所示的。

```C
Copy Highlighter-hljsENDIAN_BIG		= 0x00010203,	/* 大端序 ABCD */
ENDIAN_LITTLE		= 0x03020100,	/* 小端序 DCBA */
ENDIAN_BIG_WORD		= 0x02030001,   /* 中端序 CDAB, Honeywell 316 风格 */
ENDIAN_LITTLE_WORD	= 0x01000302	/* 中端序 BADC, PDP-11 风格 */
```

gcc或clang中可以使用 `__BYTE_ORDER__`宏来判断

```C
#include <stdio.h>
#include <stdlib.h>

int main()
{
// 这两个宏是gcc或者clang支持的
#if __BYTE_ORDER__ == __ORDER_LITTLE_ENDIAN__
	puts("小端序");
#elif __BYTE_ORDER__== __ORDER_BIG_ENDIAN__
	puts("大端序");
#else
	puts("未知字节序");
#endif // __BYTE_ORDER__
	return 0;
}
```

还有使用`C++ 11`的`constexpr`关键字特性来做编译时判断的方法。但是我没有编译通过。
相关的可以看下面这两个网页

- 在编译时检查字节序
  http://codereview.stackexchange.com/questions/45675/checking-endianness-at-compile-time
- 编译器预定义宏
  https://sourceforge.net/p/predef/wiki/Endianness/

分类: [C/C++](https://www.cnblogs.com/oloroso/category/703612.html)