# cmake交叉编译参数toolchain

![img](https://upload.jianshu.io/users/upload_avatars/4378116/235213327fa0.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[无敌大灰狼me](https://www.jianshu.com/u/e48caea06934)关注

0.9962020.05.03 12:48:54字数 835阅读 1,845

> 因为嵌入式开发，我接触的都是交叉编译。即编译好的可执行程序并不是在本机运行，而是在目标机上跑。因此，我在使用cmake的时候，也需要交叉编译。
>
> 更多信息请参看：[cmake官网](https://links.jianshu.com/go?to=https%3A%2F%2Fcmake.org%2Fcmake%2Fhelp)

CMake给交叉编译预留了一个很好的变量即`CMAKE_TOOLCHAIN_FILE`,它定义了一个文件的路径，这个文件即toolChain,里面set了一系列你需要改变的变量和属性，包括`C_COMPILER`,`CXX_COMPILER`。CMake为了不让用户每次交叉编译都要重新输入这些命令，因此它带来toolChain机制，简而言之就是一个cmake脚本，内嵌了你需要改变以及需要set的所有交叉环境的设置。

这里面也牵扯了一些相关的变量设置,在这里我通过自己的项目，简单介绍下几个比较重要的：

```cmake
set(CMAKE_ASM_COMPILER ccmips)

set(CMAKE_SYSTEM_NAME Generic)

set(UNIX True CACHE BOOL "Archiver")

set(CMAKE_C_COMPILER ccmips)
set(CMAKE_CXX_COMPILER c++mips)

set(CMAKE_AR armips CACHE FILEPATH "Archiver")
set(CMAKE_RANLIB ranlibmips CACHE FILEPATH "Archiver")
set(CMAKE_LINKER ldmips CACHE FILEPATH "Archiver")

set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_MODE_LIBRARY ONLY)

add_compile_options(-mno-branch-likely -mips64 -nostdinc -mabi=n32 -mgp64 -EL -fno-builtin -fno-zero-initialized-in-bss -fno-common -Wall -G8 -MD  -O2 -G 8 -D_VSB_CONFIG_FILE="${CONFIG_H}/lib_smp/h/config/vsbConfig.h" )

#精简后好的
add_definitions(-DCPU=_DELTA_MIPSI64 -DINET -DTOOL_FAMILY=gnu -DTOOL=gnule -D_CORETEK_KERNEL -D_CORETEK_MIPS_N32_ABI -DMIPSEL -D_WRS_LIB_BUILD  -DWRS_IPNET -D_WRS_CONFIG_SMP)

add_link_options(-EL)
```

1. `CMAKE_SYSTEM_NAME`:

   即你目标机target所在的操作系统名称，比如ARM或者Linux你就需要写"Linux",如果Windows平台你就写"Windows",如果你的嵌入式平台没有相关OS你即需要写成"Generic",只有当CMAKE_SYSTEM_NAME这个变量被设置了，CMake才认为此时正在交叉编译，它会额外设置一个变量CMAKE_CROSSCOMPILING为TRUE.

2. `CMAKE_C_COMPILER`

   顾名思义，即C语言编译器，这里可以将变量设置成完整路径或者文件名，设置成完整路径有一个好处就是CMake会去这个路径下去寻找编译相关的其他工具比如linker,binutils等，如果你写的文件名带有arm-elf等等前缀，CMake会识别到并且去寻找相关的交叉编译器。

3. `CMAKE_CXX_COMPILER`

   同上，此时代表的是C++编译器。

4. `CMAKE_FIND_ROOT_PATH`

   代表了一系列的相关文件夹路径的根路径的变更，比如你设置了/opt/arm/,所有的Find_xxx.cmake都会优先根据这个路径下的/usr/lib,/lib等进行查找，然后才会去你自己的/usr/lib和/lib进行查找，如果你有一些库是不被包含在/opt/arm里面的，你也可以显示指定多个值给CMAKE_FIND_ROOT_PATH

5. `CMAKE_FIND_ROOT_PATH_MODE_PROGRAM`:

   对FIND_PROGRAM()起作用，有三种取值，NEVER,ONLY,BOTH,第一个表示不在你CMAKE_FIND_ROOT_PATH下进行查找，第二个表示只在这个路径下查找，第三个表示先查找这个路径，再查找全局路径，对于这个变量来说，一般都是调用宿主机的程序，所以一般都设置成NEVER.

6. `CMAKE_FIND_ROOT_PATH_MODE_LIBRARY`

   对FIND_LIBRARY()起作用，表示在链接的时候的库的相关选项，因此这里需要设置成ONLY来保证我们的库是在交叉环境中找的.

7. `CMAKE_FIND_ROOT_PATH_MODE_INCLUDE:`

   对FIND_PATH()和FIND_FILE()起作用，一般来说也是ONLY,如果你想改变，一般也是在相关的FIND命令中增加option来改变局部设置，有NO_CMAKE_FIND_ROOT_PATH,ONLY_CMAKE_FIND_ROOT_PATH,BOTH_CMAKE_FIND_ROOT_PATH

8. `add_compile_options`

   添加编译时的参数

9. `add_definitions`

   添加编译时的宏

10. `add_link_options`

添加链接参数

#### 出差必备