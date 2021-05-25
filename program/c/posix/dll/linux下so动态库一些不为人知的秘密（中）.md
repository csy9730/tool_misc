# [linux下so动态库一些不为人知的秘密（中）](https://www.cnblogs.com/lidabo/p/5705165.html)

上一篇（[linux下so动态库一些不为人知的秘密（上）](http://blog.chinaunix.net/uid-27105712-id-3313293.html)）介绍了linux下so一些依赖问题，本篇将介绍linux的so路径搜索问题。

  

  我们知道linux链接so有两种途径：显示和隐式。所谓显示就是程序主动调用dlopen打开相关so;这里需要补充的是，如果使用显示链接，上篇文章讨论的那些问题都不存在。首先,dlopen的so使用ldd是查看不到的。其次，使用dlopen打开的so并不是在进程启动时候加载映射的，而是当进程运行到调用dlopen代码地方才加载该so，也就是说，如果每个进程显示链接a.so;但是如果发布该程序时候忘记附带发布该a.so,程序仍然能够正常启动，甚至如果运行逻辑没有触发运行到调用dlopen函数代码地方。该程序还能正常运行，即使没有a.so.

 

  既然显示加载这么多优点，那么为什么实际生产中很少码农使用它呢, 主要原因还是起使用不是很方便，需要开发人员多写不少代码。所以不被大多数码农使用，还有一个重要原因应该是能提前发现错误，在部署的时候就能发现缺少哪些so，而不是等到实际上限运行的时候才发现缺东少西。

 

  下面举个工作中最常碰到的问题，来引申出本篇内容吧。

**写一个最简单的****so****，** **tmp.cpp**

\1.    int test()

\2.    {

\3.      return 20;

\4.    }

  编译=>链接=》运行, 下面main.cpp 内容请参见上一篇文章。



   这个错误是最常见的错误了。运行程序的时候找不到依赖的so。一般人使用方法是修改**LD_LIBRARY_PATH**这个环境变量

   export LD_LIBRARY_PATH=/tmp

[stevenrao]$ ./demo

test

   这样就OK了, 不过这样export 只对当前shell有效，当另开一个shell时候，又要重新设置。可以把export LD_LIBRARY_PATH=/tmp 语句写到 ~/.bashrc中，这样就对当前用户有效了，写到/etc/bashrc中就对所有用户有效了。

   前面链接时候使用 -L/tmp/ -ltmp 是一种设置相对路径方法，还有一种**绝对路径链接方法**。

[stevenrao]$ g++ -o demo  /tmp/libtmp.so main.cpp

[stevenrao]$ ./demo

  test

[stevenrao]$ ldd demo

​        linux-vdso.so.1 =>  (0x00007fff083ff000)

​        /tmp/libtmp.so (0x00007f53ed30f000) 

   绝对路径虽然申请设置环境变量步骤，但是缺陷也是致命的，这个so必须放在绝对路径下，不能放到其他地方，这样给部署带来很大麻烦。**所以应该禁止使用绝对路径链接****so**。

   

   **搜索路径分两种，一种是链接时候的搜索路径，一种是运行时期的搜索路径**。像前面提到的 -L/tmp/ 是属于链接时期的搜索路径，即给ld程序提供的编译链接时候寻找动态库路径；而LD_LIBRARY_PATH则既属于链接期搜索路径，又属于运行时期的搜索路径。

   

   这里需要介绍链-rpath链接选项，它是指定运行时候都使用的搜索路径。聪明的同学马上就想到,运行时搜索路径，那它记录在哪儿呢。也像. LD_LIBRARY_PATH那样，每部署一台机器就需要配一下吗。呵呵，不需要..,因为它已经被硬编码到可执行文件内部了。看看下面演示

 

\1.   [stevenrao] $ **g****++** **-****o demo -L** **/****tmp****/** **-****ltmp main****.****cpp**

\2.   [stevenrao] $ **./****demo**

\3.   ./demo: error while loading shared libraries: libtmp.so: cannot open shared object file: No such file or directory

\4.   [stevenrao] $ **g****++** **-****o demo** **-****Wl****,-****rpath** **/****tmp****/** **-****L****/****tmp****/** **-****ltmp main****.****cpp**

\5.   [stevenrao] $ ./demo

\6.   test

\7.   [stevenrao] $ **readelf -d demo**

\8.    

\9.   Dynamic section at offset 0xc58 contains 26 entries:

\10.    Tag        Type                         Name/Value

\11.   0x0000000000000001 (NEEDED)             Shared library: [libtmp.so]

\12.   0x0000000000000001 (NEEDED)             Shared library: [libstdc++.so.6]

\13.   0x0000000000000001 (NEEDED)             Shared library: [libm.so.6]

\14.   0x0000000000000001 (NEEDED)             Shared library: [libgcc_s.so.1]

\15.   0x0000000000000001 (NEEDED)             Shared library: [libc.so.6]

\16.   0x000000000000000f (RPATH)              Library rpath: [/tmp/]

\17.   0x000000000000001d (RUNPATH)            Library runpath: [/tmp/]

   看看是吧，编译到elf文件内部了，路径和程序深深的耦合到一起

 

​    篇幅太长，请看下回分解



分类: [Linux](https://www.cnblogs.com/lidabo/category/587288.html)