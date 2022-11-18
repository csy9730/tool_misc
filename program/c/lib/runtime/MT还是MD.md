# MT还是MD

[![李KK](https://pic1.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_xs.jpg?source=32738c0c)](https://www.zhihu.com/people/li-mark-55-75)

[李KK](https://www.zhihu.com/people/li-mark-55-75)



2 人赞同了该文章

最近在做一个C++的项目，设置链接选型MT或者MD时又有点糊涂了，今天总结下。

无论MT还是MD，底层都涉及一个叫做C运行时的依赖库。C运行时，有一系列的库文件组成，这里将这若干个库文件基于功能分为三个类别来做区分。

## 一、C运行时的实现层

实现层主要做了异常处理、调试支持、运行时检查、类型信息、实现细节以及特定扩展函数等。

在win10以前，windows上只有visual C++的代码实现了c 运行时，有了win10以后，操作系统自带了一个叫做通用C运行时的实现库。两者实现都区分了静态库和动态库、调试版本和非调试版本。

Visual C++的名称如下：

1. Libvcruntime.lib、libvcruntimed.lib 静态库的调试和非调试版本。
2. Vcruntime.lib、vcruntimed.lib 动态库的调试和非调试版本。

Ucrt的名称如下:

1. Liburct.lib liburctd.lib 静态库的调试和非调试版本。
2. Urct.lib和ucrtd.lib 动态库的调试和非调试版本。

## 二、C运行时的初始化层

初始化层主要是基于原生代码、混合代码和托管代码来决定实现层的初始化，包括启动、终止和线程数据初始化等。

注意，这里全部都为静态库

1. libcmt.lib libcmtd.lib ，此时对应实现层的Libvcruntime.lib的调试和非调试版本。
2. msvcrt.lib msvcrtd.lib，此时对应实现层的Vcruntime.lib的调试和非调试版本。
3. msvcmrt.lib msvcmrtd.lib，此时对应实现层的urct.lib和vcruntime.lib的调试和非调试版。编译选项为/CLR
4. msvcurt.lib msvcrutd.lib ，此时对应实现层urct.lib的调试和非调试版本。/clr:pure。目前已废弃。

## 三、C++标准版库实现层

工程中包含C++标准库头文件时，就会链接该模块。

1. libcpmt.lib、libcpmtd.lib，C++标准库的静态库版本。
2. msvcprt.lib、msvcprtd.lib，C++标准库的动态库版本，实际加载的dll，会有版本后缀。

无论静态链接还是动态链接，都会存在父模块和子模块依赖的CRT不一致的情形，内存的分配和销毁不在一个堆中，从而导致程序崩溃、异常无法捕获等情形。所以在实际使用开源库时，最好是能亲自手动编译。