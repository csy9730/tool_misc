# [linux下so动态库一些不为人知的秘密（上）](https://www.cnblogs.com/lidabo/p/5705148.html)

 linux 下有动态库和静态库，动态库以.so为扩展名，静态库以.a为扩展名。二者都使用广泛。本文主要讲动态库方面知识。

   

   基本上每一个linux 程序都至少会有一个动态库，查看某个程序使用了那些动态库，使用**ldd命令**查看 

1. **# ldd /bin/ls**
2. linux-vdso.so.1 => (0x00007fff597ff000)
3. libselinux.so.1 => /lib64/libselinux.so.1 (0x00000036c2e00000)
4. librt.so.1 => /lib64/librt.so.1 (0x00000036c2200000)
5. libcap.so.2 => /lib64/libcap.so.2 (0x00000036c4a00000)
6. libacl.so.1 => /lib64/libacl.so.1 (0x00000036d0600000)
7. libc.so.6 => /lib64/libc.so.6 (0x00000036c1200000)
8. libdl.so.2 => /lib64/libdl.so.2 (0x00000036c1600000)
9. /lib64/ld-linux-x86-64.so.2 (0x00000036c0e00000)
10. libpthread.so.0 => /lib64/libpthread.so.0 (0x00000036c1a00000)
11. libattr.so.1 => /lib64/libattr.so.1 (0x00000036cf600000)

   这么多so，是的。使用ldd显示的so，并不是所有so都是需要使用的，下面举个例子

main.cpp

1. \#include <stdio.h>
2. \#include <iostream>
3. \#include <string>
4. using namespace std;
5. 
6. int main ()
7. {
8.    cout << "test" << endl;
9.    return 0;
10. }

   使用缺省参数编译结果

1. **# g++ -o demo main.cpp**
2. \# ldd demo
3. ​    linux-vdso.so.1 => (0x00007fffcd1ff000)
4. ​        libstdc++.so.6 => /usr/lib64/libstdc++.so.6 (0x00007f4d02f69000)
5. ​        libm.so.6 => /lib64/libm.so.6 (0x00000036c1e00000)
6. ​        libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00000036c7e00000)
7. ​        libc.so.6 => /lib64/libc.so.6 (0x00000036c1200000)
8. ​        /lib64/ld-linux-x86-64.so.2 (0x00000036c0e00000)

   如果我链接一些so，但是程序并不用到这些so，又是什么情况呢，下面我加入链接压缩库，数学库，线程库

1. **# g++ -o demo -lz -lm -lrt main.cpp**
2. \# ldd demo
3. ​        linux-vdso.so.1 => (0x00007fff0f7fc000)
4. ​        libz.so.1 => /lib64/libz.so.1 (0x00000036c2600000)
5. ​        librt.so.1 => /lib64/librt.so.1 (0x00000036c2200000)
6. ​        libstdc++.so.6 => /usr/lib64/libstdc++.so.6 (0x00007ff6ab70d000)
7. ​        libm.so.6 => /lib64/libm.so.6 (0x00000036c1e00000)
8. ​        libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00000036c7e00000)
9. ​        libc.so.6 => /lib64/libc.so.6 (0x00000036c1200000)
10. ​        libpthread.so.0 => /lib64/libpthread.so.0 (0x00000036c1a00000)
11. ​        /lib64/ld-linux-x86-64.so.2 (0x00000036c0e00000)

  看看，虽然没有用到，但是一样有链接进来，那看看程序启动时候有没有去加载它们呢

1. **# strace ./demo**
2. ​    execve("./demo", ["./demo"], [/* 30 vars */]) = 0
3. ​    ... = 0
4. ​    open("/lib64/libz.so.1", O_RDONLY) = 3
5. ​    ...
6. ​    close(3) = 0
7. ​    open("/lib64/librt.so.1", O_RDONLY) = 3
8. ​    ...
9. ​    close(3) = 0
10. ​    open("/usr/lib64/libstdc++.so.6", O_RDONLY) = 3
11. ​    ...
12. ​    close(3) = 0
13. ​    open("/lib64/libm.so.6", O_RDONLY) = 3
14. ​    ...
15. ​    close(3) = 0
16. ​    open("/lib64/libgcc_s.so.1", O_RDONLY) = 3
17. ​    ...
18. ​    close(3) = 0
19. ​    open("/lib64/libc.so.6", O_RDONLY) = 3
20. ​    ...
21. ​    close(3) = 0
22. ​    open("/lib64/libpthread.so.0", O_RDONLY) = 3
23. ​    ...
24. ​    close(3) = 0
25. ​    ...

  看，有加载，所以必定会影响进程启动速度，所以我们最后不要把无用的so编译进来，这里会有什么影响呢？

   大家知不知道linux从程序（program或对象）变成进程（process或进程），要经过哪些步骤呢，这里如果详细的说，估计要另开一篇文章。简单的说分三步：

​    1、fork进程，在内核创建进程相关内核项，加载进程可执行文件；

​    2、查找依赖的so，一一加载映射虚拟地址

​    3、初始化程序变量。

  可以看到，第二步中dll依赖越多，进程启动越慢，并且发布程序的时候，这些链接但没有使用的so，同样要一起跟着发布，否则进程启动时候，会失败，找不到对应的so。所以我们不能像上面那样，把一些毫无意义的so链接进来，浪费资源。但是开发人员写makefile 一般有没有那么细心，图省事方便，那么有什么好的办法呢。继续看下去，下面会给你解决方法。

  先**使用 ldd -u demo 查看不需要链接的so，看下面，一面了然，无用的so全部暴露出来了吧**

1. **# ldd -u demo**
2. Unused direct dependencies:
3. ​        /lib64/libz.so.1
4. ​        /lib64/librt.so.1
5. ​        /lib64/libm.so.6
6. ​        /lib64/libgcc_s.so.1

  使用 -Wl,--as-needed 编译选项

1. **# g++ -Wl,--as-needed -o demo -lz -lm -lrt main.cpp**
2. **# ldd demo**
3. ​        linux-vdso.so.1 => (0x00007fffebfff000)
4. ​        libstdc++.so.6 => /usr/lib64/libstdc++.so.6 (0x00007ff665c05000)
5. ​        libc.so.6 => /lib64/libc.so.6 (0x00000036c1200000)
6. ​        libm.so.6 => /lib64/libm.so.6 (0x00000036c1e00000)
7. ​        /lib64/ld-linux-x86-64.so.2 (0x00000036c0e00000)
8. ​        libgcc_s.so.1 => /lib64/libgcc_s.so.1 (0x00000036c7e00000)
9. \# ldd -u demo
10. Unused direct dependencies:
11. 

  呵呵，办法很简单省事吧，本文主要讲so依赖的一些问题，下一篇将介绍so的路径方面一些不为人知的小秘密![img](http://blog.chinaunix.net/blog/image/editor/hou/5.gif)



分类: [Linux](https://www.cnblogs.com/lidabo/category/587288.html)