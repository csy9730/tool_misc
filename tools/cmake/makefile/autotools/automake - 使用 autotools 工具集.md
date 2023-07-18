# [automake - 使用 autotools 工具集](https://www.cnblogs.com/gaowengang/p/6170098.html)



 

**建议阅读 GNU Automake 官方文档，系统学习 automake 的用法。**

**在这里**

---------------------------------------------------------------------------------------------（以下内容仅供参考）

一般而言，对于小项目或玩具程序，手动编写 Makefile 即可。但对于大型项目，手动编写维护 Makefile 成为一件费时费力的无聊工作。

本文介绍 autotools 工具集自动生成符合 Linux 规范的 Makefile 文件。

如果读者没有安装 autotools 工具集，安装命令如下，
```
$ sudo apt-get install automake
```
安装完成之后，会有如下工具可用，

- aclocal
- autoscan
- autoconf
- autoheader
- automake

一般大型项目，代码组织结构分为两种，一种是所有文件都在同一个目录下的 flat 结构，另一种是按层次组织的多文件夹形式。先来看第一种，

 

### **flat 结构的项目使用 autotools 工具集**

本篇测试代码如下，

入口代码  int_arithmetic.c



``` cpp
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "sum.h"
#include "sub.h"
#include "mul.h"
#include "div.h"

int main()
{
    printf("======== < Integer Arithmethic > ========\n");
    int x, y;
    printf("Enter two integer: ");
    scanf("%d%d", &x, &y);

    int sm = sum(x, y);
    printf("sum is: %d\n", sm);
    int sb = sub(x, y);
    printf("sub is: %d\n", sb);
    int ml = mul(x, y);
    printf("mul is: %d\n", ml);
    int dv = divide(x, y);
    printf("div is: %d\n", dv);

    return 0;
}
```



辅助代码，头文件，

sum.h

``` cpp
#ifndef SUM_H_
#define SUM_H_

int sum(int x, int y);

#endif
```

sub.h

``` cpp
#ifndef SUB_H_
#define SUB_H_

int sub(int x, int y);

#endif
```

mul.h

``` cpp
#ifndef MUL_H_
#define MUL_H_

int mul(int x, int y);

#endif
```

div.h

``` cpp
#ifndef DIV_H_
#define DIV_H_

int divide(int x, int y);

#endif
```

 

辅助代码，实现文件，

sum.c

``` cpp
#include "sum.h"

int sum(int x, int y)
{
    return x + y;
}
```

sub.c

``` cpp
#include "sub.h"

int sub(int x, int y)
{
    return x - y;
}
```

mul.c

``` cpp
#include "mul.h"

int mul(int x, int y)
{
    return x * y;
}
```

div.c


``` cpp
#include "div.h"
#include <stdio.h>

int divide(int x, int y)
{
    if(x % y != 0)
        printf("\nWarning: Integer Division May Have Accuracy Loss.\n");

    return x / y;
}
```



1) 在项目目录下，运行 autoscan 命令，生成 configure.scan 文件，内容如下，


``` 
# -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([FULL-PACKAGE-NAME], [VERSION], [BUG-REPORT-ADDRESS])
AC_CONFIG_SRCDIR([int_arithmetic.c])
AC_CONFIG_HEADERS([config.h])

# Checks for programs.
AC_PROG_CC

# Checks for libraries.

# Checks for header files.
AC_CHECK_HEADERS([stdlib.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.
AC_OUTPUT
```

重命名 configure.scan 为 configure.ac ，并修改其内容为，


```
#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
#AC_INIT([FULL-PACKAGE-NAME], [VERSION], [BUG-REPORT-ADDRESS])
AC_INIT(int_arithmetic, 0.1, ggao@micron.com)
AM_INIT_AUTOMAKE(int_arithmetic, 0.1)
AC_CONFIG_SRCDIR([int_arithmetic.c])
AC_CONFIG_HEADERS([config.h])

# Checks for programs.
AC_PROG_CC

# Checks for libraries.

# Checks for header files.
AC_CHECK_HEADERS([stdlib.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.
AC_CONFIG_FILES([Makefile])
AC_OUTPUT
```


上述 configure.ac 中宏定义意义如下，

```
AC_PREREQ         ： 声明 autoconf 的版本号
AC_INIT           ： 声明软件名称，版本号及 bug report 地址
AM_INIT_AUTOMAKE  ： automake 需要的信息，参数为软件名和版本号
AC_CONFIG_SRCDIR  ： autoscan 侦测的源文件名，用来确定目录的有效性
AC_CONFIG_HEADERS ： autoscan 定义要生成的头文件，后续 autoheader 要使用
AC_PROG_CC        ： 指定编译器，默认为 gcc
AC_CHECK_HEADERS  ： autoscan 侦测到的头文件
AC_CONFIG_FILES   ： 指定生成 Makefile，如果是多目录结构，可指定生成多个Makefile，以空格分隔，例如，AC_CONFIG_FILES([Makefile src/Makefile])
AC_OUTPUT         ： autoscan 输出
```

1) 运行 aclocal，根据 configure.ac 生成 aclocal.m4 文件，该文件主要处理各种宏定义

2) 运行 autoconf，将 configure.ac 中的宏展开，生成 configure 脚本，这过程中可能会用到 aclocal.m4

3) 执行 autoheader，生成 config.h.in 文件，该命令通常会从 "acconfig.h” 文件中复制用户附加的符号定义。该例子中没有附加的符号定义, 所以不需要创建 "acconfig.h” 文件

4) 创建 Makefile.am 文件，automake工具会根据 configure.in 中的参量把 Makefile.am 转换成 Makefile.in 文件，最终通过 Makefile.in 生成 Makefile

```
AUTOMAKE_OPTIONS=foreign
bin_PROGRAMS=int_arithmetic
int_arithmetic_SOURCES=int_arithmetic.c sum.c sub.c mul.c div.c
include_HEADERS=sum.h sub.h mul.h div.h
```

对上述 makefile.am 中各标签的解释，

```
AUTOMAKE_OPTIONS       ： 由于 GNU 对自己发布的软件有严格的规范, 比如必须附带许可证声明文件 COPYING 等，否则 automake 执行时会报错。 
　　　　　　　　　　　　　　　 automake 提供了3中软件等级： foreign, gnu, gnits, 默认级别是gnu, 在本例中，使用 foreign 等级，它只检测必须的文件。
bin_PROGRAMS           ： 要生成的可执行文件名称，如果要生成多个可执行文件，用空格隔开。
int_arithmetic_SOURCES ： 可执行文件依赖的所有源文件。
```

6) 手动添加必要的文件 NEWS，README，AUTHORS，ChangeLog

7) 执行 automake --add-missing ，该命令生成 Makefile.in 文件。使用选项 "--add-missing" 可以让 automake 自动添加一些必需的脚本文件。

8) 执行 ./configure 生成 Makefile

====>>> 至此 Makefile 生成完毕。

如果要继续安装，

9) $ make

10) $ sudo make install  即可将可执行文件安装在 /usr/local/bin/ 目录下，以后就可以直接使用啦

11)  $ sudo make uninstall 即可将安装的可执行文件从 /usr/local/bin 目录下移除

如果要发布你的软件，

12) $ make dist  即可打包生成 xxx-version.tar.gz 文件

如果要清理中间文件，

13) make clean

14) make distclean

 

### **层次结构的项目使用 autotools 工具集**

 当前项目层次结构如下图，

![img](https://images2015.cnblogs.com/blog/986259/201612/986259-20161213203139870-463049094.png)

主入口函数 int_arithmetic.c

``` cpp
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include "include/sum.h"
#include "include/sub.h"
#include "include/mul.h"
#include "include/div.h"

int main()
{
    printf("======== < Integer Arithmethic > ========\n");
    int x, y;
    printf("Enter two integer: ");
    scanf("%d%d", &x, &y);

    int sm = sum(x, y);
    printf("sum is: %d\n", sm);
    int sb = sub(x, y);
    printf("sub is: %d\n", sb);
    int ml = mul(x, y);
    printf("mul is: %d\n", ml);
    int dv = divide(x, y);
    printf("div is: %d\n", dv);

    return 0;
}
```


头文件，

sum.h

``` cpp
#ifndef SUM_H_
#define SUM_H_

int sum(int x, int y);

#endif
```

sub.h

``` cpp
#ifndef SUB_H_
#define SUB_H_

int sub(int x, int y);

#endif
```

mul.h

``` cpp
#ifndef MUL_H_
#define MUL_H_

int mul(int x, int y);

#endif
```

div.h

``` cpp
#ifndef DIV_H_
#define DIV_H_

int divide(int x, int y);

#endif
```

 实现文件，

sum.c

``` cpp
#include "../include/sum.h"

int sum(int x, int y)
{
    return x + y;
}
```

sub.c

``` cpp
#include "../include/sub.h"

int sub(int x, int y)
{
    return x - y;
}
```

mul.c

``` cpp
#include "../include/mul.h"

int mul(int x, int y)
{
    return x * y;
}
```

div.c


``` cpp
#include "../include/div.h"
#include <stdio.h>

int divide(int x, int y)
{
    if(x % y != 0)
        printf("\nWarning: Integer Division May Have Accuracy Loss.\n");

    return x / y;
}
```

1) 在项目顶层目录，建立文件 Makefile.am, 内容如下，

```
AUTOMAKE_OPTIONS=foreign     		   # 软件等级  
SUBDIRS=src  				   # 先扫描子目录  
bin_PROGRAMS=int_arithmetic    		   # 软件生成后的可执行文件名称  
int_arithmetic_SOURCES=int_arithmetic.c    # 当前目录源文件  
int_arithmetic_LDADD=src/libsrc.a          # 静态连接方式,连接 src 下生成的 libsrc.a 文件  
#LIBS = -l xxx -l xxx                      # 添加必要的库  
```

在 src 目录，建立文件 Makefile.am，内容如下，

```
noinst_LIBRARIES=libsrc.a                  # 生成的静态库文件名称，noinst加上之后是只编译，不安装到系统中  
libsrc_a_SOURCES=sum.c sub.c mul.c div.c   # 这个静态库文件需要用到的依赖  
include_HEADERS=../include/sum.h ../include/sub.h ../include/mul.h ../include/div.h  # 导入需要依赖的头文件 
```

2） 执行 autoscan 生成 configure.scan 文件， 如下，


```
# -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])
AC_INIT([FULL-PACKAGE-NAME], [VERSION], [BUG-REPORT-ADDRESS])
AC_CONFIG_SRCDIR([int_arithmetic.c])
AC_CONFIG_HEADERS([config.h])

# Checks for programs.
AC_PROG_CC

# Checks for libraries.

# Checks for header files.
AC_CHECK_HEADERS([stdlib.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_CONFIG_FILES([Makefile
                 src/Makefile])
AC_OUTPUT
```


 重命名 configure.scan 为 configure.ac 并修改如下，


```
# -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.69])

#AC_INIT([FULL-PACKAGE-NAME], [VERSION], [BUG-REPORT-ADDRESS])
AC_INIT(int_arithmetic, 0.1, ggao@micron.com)
AM_INIT_AUTOMAKE(int_arithmetic, 0.1)
# Generate static lib
AC_PROG_RANLIB

AC_CONFIG_SRCDIR([int_arithmetic.c])
AC_CONFIG_HEADERS([config.h])

# Checks for programs.
AC_PROG_CC

# Checks for libraries.

# Checks for header files.
AC_CHECK_HEADERS([stdlib.h unistd.h])

# Checks for typedefs, structures, and compiler characteristics.

# Checks for library functions.

AC_CONFIG_FILES([Makefile
                 src/Makefile])
AC_OUTPUT
```



1) 执行 aclocal

2) 运行 autoconf

3) 运行 autoheader

4) 手动添加必要的文件 NEWS，README，AUTHORS，ChangeLog

5) 执行 automake --add-missing

6) 执行 ./configure 生存 Makefile

====>>> 至此 Makefile 生成完毕。

 

如果要继续安装，

9) $ make

10) $ sudo make install  即可将可执行文件安装在 /usr/local/bin/ 目录下，以后就可以直接使用啦

11)  $ sudo make uninstall 即可将安装的可执行文件从 /usr/local/bin 目录下移除

如果要发布你的软件，

12) $ make dist  即可打包生成 xxx-version.tar.gz 文件

如果要清理中间文件，

13) make clean

14) make distclean

 

 ====>>> 感谢原创作者的分享  <http://blog.csdn.net/initphp/article/details/43705765>

 

完。

 



标签: [Linux](https://www.cnblogs.com/gaowengang/tag/Linux/), [C++](https://www.cnblogs.com/gaowengang/tag/C%2B%2B/)