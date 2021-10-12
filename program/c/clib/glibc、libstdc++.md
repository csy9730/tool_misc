# c runtime

### libc
libc是Linux下原来的标准C库，也就是当初写hello world时包含的头文件`#include <stdio.h>` 定义的地方.
### glibc
libc后来逐渐被glibc取代，也就是传说中的GNU C Library, 在此之前除了有libc，还有klibc,uclibc。现在只要知道用的最多的是glibc就行了，主流的一些linux操作系统如 Debian, Ubuntu，Redhat等用的都是glibc或者其变种，下面会说到。
#### klibc
### eglibc
这里的e是Embedded的意思，也就是前面说到的变种glibc。

### glib
一个glib看起来也很相似，那它又是什么呢？

glib也是个c程序库，不过比较轻量级，glib将C语言中的数据类型统一封装成自己的数据类型，提供了C语言常用的数据结构的定义以及处理函数，有趣的宏以及可移植的封装等(注：glib是可移植的，说明你可以在linux下，也可以在windows下使用它）。

### libstdc++
libstdc++是gcc搞的，是C++标准库的实现。

### libc++
libstdc++是gcc搞的，libc++是llvm搞的，他们都是C++标准库的实现。
libc++是针对clang编译器特别重写的C++标准库
两套c++标准库，使用取决于编译器优先集成哪个，一般libstdc++兼容性好些，发展的比较早。

相比glibc，libstdc++虽然提供了c++程序的标准库，但它并不与内核打交道。对于系统级别的事件，libstdc++首先是会与glibc交互，才能和内核通信。相比glibc来说，libstdc++就显得没那么基础了。
### openbsd libm
[https://github.com/openbsd/src/tree/master/lib/libm/src](https://github.com/openbsd/src/tree/master/lib/libm/src)

### openbsd libz
zlib是软件包的名称，里面包括库文件libz.so
[http://www.zlib.net/](http://www.zlib.net/)
### misc
libz  压缩库（Z）
librt 实时库（real time）
libm  数学库（math）
libc  标准C库（C lib）