# [Linux动态库的导出控制](https://www.cnblogs.com/zzqcn/p/3640353.html)

在实际工作中，许多软件模块是以动态库的方式提供的。做为模块开发人员，我们不仅要掌握如何编写和构建动态库，还要了解如何控制动态库的导出接口，这样，我们可以向模块的用户仅导出必要的接口，而另一些内部接口，为了安全或其他考虑，可以不必导出。当需要导出C++类时，问题显得更复杂一些，不过我认为不应导出C++类成员，而只应导出纯C接口。

和Visual C++不同，GCC编译器默认会导出所有符号。假设我们需要导出两个全局函数test和test2，以及一个C++类foo，此类有两个public成员函数a和b，声明文件so.h如下：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 #ifndef __SO_H__
 2 #define __SO_H__
 3 
 4 #ifdef __cplusplus
 5 extern "C" {
 6 #endif
 7 
 8 void  test();
 9 int   test2(int _v);
10 
11 
12 class foo
13 {
14 public:
15     void a();
16     int  b(int _v);
17 };
18 
19 
20 #ifdef __cplusplus
21 }
22 #endif
23 
24 
25 #endif
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

实现文件so.cpp如下：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 #include <stdio.h>
 2 #include "so.h"
 3 
 4 
 5 void  test()
 6 {
 7     printf("test\n");
 8 }
 9 
10 
11 int  test2(int _v)
12 {
13     return _v*_v;
14 }
15 
16 
17 void  foo::a()
18 {
19     printf("foo::a()\n");
20 }
21 
22 
23 int  foo::b(int _v)
24 {
25     return _v*_v;
26 }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

我们把这些代码编译成一个动态库test.so:

```
$ g++ -shared -o test.so -fPIC so.cpp
```

然后使用nm命令查看动态符号表：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
$ nm -D test.so
                 w _Jv_RegisterClasses
000000000000063e T _ZN3foo1aEv
0000000000000658 T _ZN3foo1bEi
0000000000201018 A __bss_start
                 w __cxa_finalize
                 w __gmon_start__
0000000000201018 A _edata
0000000000201028 A _end
00000000000006a8 T _fini
0000000000000508 T _init
                 U puts
000000000000061c T test
000000000000062e T test2
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

可见，test、test2、foo::a、foo::b都被导出了（注意带有大写T的项）。

接着我们再写一个客户程序main.cpp，来实现此动态库，代码如下：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 #include <stdio.h>
 2 #include "so.h"
 3 
 4 int main(int argc, char** argv)
 5 {
 6     test();
 7     printf("test2: %d\n", test2(3));
 8 
 9     foo f;
10     f.a();
11     printf("foo::b: %d\n", f.b(2));
12 
13     return 0;
14 }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

 

编译命令和输出如下：

```
$ g++ -o app main.cpp test.so
$ ./app
test
test2: 9
foo::a()
foo::b: 4
```

 

上面的操作，显示了默认情况下，Linux动态库是导出了所有符号的，另外，也展示了如何导出和使用动态库中的C++类成员。

 

现在，假设我们要只导出全局函数test和foo类的成员函数a，怎么办呢？有好几种方法，最方便的是使用GCC编译器特性。首先，将so.h修改如下：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 #ifndef __SO_H__
 2 #define __SO_H__
 3 
 4 #define DLL_PUBLIC __attribute__ ((visibility("default")))
 5 
 6 #ifdef __cplusplus
 7 extern "C" {
 8 #endif
 9 
10 DLL_PUBLIC  void  test();
11 int   test2(int _v);
12 
13 
14 class foo
15 {
16 public:
17     DLL_PUBLIC  void a();
18     int  b(int _v);
19 };
20 
21 
22 #ifdef __cplusplus
23 }
24 #endif
25 
26 
27 #endif
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

so.cpp不变。接着，使用以下命令编译test.so：

```
$ g++ -shared -o test.so -fPIC -fvisibility=hidden so.cpp
```

其中，__attribute__ ((visibility("default")))是默认可见标签，还有一个是__attribute__ ((visibility("hidden")))。-fvisibility=hidden，意思是将动态库中的符号设置为默认不导出。这样一来，只有添加了DLL_PUBLIC，也就是__attribute__ ((visibility("default")))标签的符号才会被导出。我们可以用nm命令来检验：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
$ nm -D test.so
                 w _Jv_RegisterClasses
00000000000005ee T _ZN3foo1aEv
0000000000201018 A __bss_start
                 w __cxa_finalize
                 w __gmon_start__
0000000000201018 A _edata
0000000000201028 A _end
0000000000000658 T _fini
00000000000004b8 T _init
                 U puts
00000000000005cc T test
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

可见，只留下了test和foo::a，其他两个符号已经看不到了。

如果此时，我们按一开始的步骤编译main.cpp，会报错：

```
$ g++ -o app main.cpp test.so
/tmp/ccA12RQf.o: In function `main':
main.cpp:(.text+0x1a): undefined reference to `test2'
main.cpp:(.text+0x48): undefined reference to `foo::b(int)'
collect2: ld returned 1 exit status
```

 

OK, 至此我们已经实现了Linux动态库(.so)中导出符号的控制。

 

 

【参考资料】

\1. 这个还讲了其他导出符号控制方法 http://blog.csdn.net/zdragon2002/article/details/6061962

\2. 这是一个PDF，《how to write shared libraries》，详细讲解了如何在Linux下创建共享库 

 http://www.akkadia.org/drepper/dsohowto.pdf

\3. GCC Visibility http://gcc.gnu.org/wiki/Visibility

分类: [C/C++](https://www.cnblogs.com/zzqcn/category/474508.html) , [Linux](https://www.cnblogs.com/zzqcn/category/543328.html)

标签: [动态库](https://www.cnblogs.com/zzqcn/tag/动态库/) , [Linux](https://www.cnblogs.com/zzqcn/tag/Linux/) , [导出符号](https://www.cnblogs.com/zzqcn/tag/导出符号/)