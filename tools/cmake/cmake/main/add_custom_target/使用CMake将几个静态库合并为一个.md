# [使用CMake将几个静态库合并为一个](http://www.djcxy.com/p/92353.html)

2018-07-03 03:23:37 



我有一个与cmake邮件列表中描述的非常类似的问题，我们有一个项目依赖于许多静态库（所有这些库都是从各个子模块的源代码构建的，每个库都有自己的CMakeLists.txt，用于描述每个库的构建过程）想要将它们合并成一个静态库，以便发布给消费者。 我的图书馆的依赖关系可能会发生变化，我不想让这些更改中的开发者进一步受到影响。 整洁的解决方案是将所有的库绑定到一个单独的库中。

有趣的是， `target_link_libraries`命令在将目标设置为`mylib`并像这样使用它时没有组合所有静态。 。

```
target_link_libraries(mylib a b c d)
```

然而，奇怪的是，如果我将`mylib`项目作为可执行项目的子模块，并且只与顶级可执行文件CMAkeLists.txt中的`mylib`链接，那么该库看起来就是合并的。 也就是说，当我将目标设置为只构建`mylib`时，mylib是27 MB，而不是3 MB。

有一些解决方案描述了将lib解包到目标文件和重新组合（这里和这里），但是当CMake看起来完全能够自动合并libs时，这看起来非常笨拙，正如上面的例子中所描述的那样。 那里有一个我错过的魔法命令，或者是一个推荐的制作发布库的优雅方式？

------

鉴于我能想到的最简单的工作示例：2个类， `a`和`b` ，其中`a`取决于`b` 。 。

# 啊

```
#ifndef A_H
#define A_H

class aclass
{
public:
    int method(int x, int y);
};

#endif
```

# a.cpp

```
#include "a.h"
#include "b.h"

int aclass::method(int x, int y) {
    bclass b;
    return x * b.method(x,y);
}
```

# BH

```
#ifndef B_H
#define B_H

class bclass
{
public:
    int method(int x, int y);
};

#endif
```

# b.cpp

```
#include "b.h"

int bclass::method(int x, int y) {
    return x+y;
}
```

# main.cpp中

```
#include "a.h"
#include <iostream>

int main()
{
    aclass a;
    std::cout << a.method(3,4) << std::endl;

    return 0;
}
```

可以将它们编译为单独的静态库，然后使用自定义目标合并静态库。

```
cmake_minimum_required(VERSION 2.8.7)

add_library(b b.cpp b.h)
add_library(a a.cpp a.h)
add_executable(main main.cpp)

set(C_LIB ${CMAKE_BINARY_DIR}/libcombi.a)

add_custom_target(combined
        COMMAND ar -x $<TARGET_FILE:a>
        COMMAND ar -x $<TARGET_FILE:b>
        COMMAND ar -qcs ${C_LIB} *.o
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        DEPENDS a b
        )

add_library(c STATIC IMPORTED GLOBAL)
add_dependencies(c combined)

set_target_properties(c
        PROPERTIES
        IMPORTED_LOCATION ${C_LIB}
        )

target_link_libraries(main c)
```

使用Apple的`libtool`版本的自定义目标也可以很好地工作。 。 。

```
add_custom_target(combined
        COMMAND libtool -static -o ${C_LIB} $<TARGET_FILE:a> $<TARGET_FILE:b>
        WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
        DEPENDS a b
        )
```

仍然接缝，似乎应该有一个更好的方式。 。

链接地址:

 

http://www.djcxy.com/p/92353.html