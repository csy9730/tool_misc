# [windows 使用pthreads线程库](https://www.cnblogs.com/fengbing/articles/2996393.html)



只有还没做出来的，没有想不到的。

从linux移植到windows的C++程序，肯定要改造下 socket和线程库。

某日，突然想到 windows 可以使用pthread库么？搜索，果然有线程的解决方案。

1.下载：<http://sourceware.org/pthreads-win32/#download>

直接下载最新的就行，目前是： prebuilt-dll-2-9-1-release.zip  因为是windows平台的，所以下载 .zip 或。exe就行，.exe 就是自解压而已，别无其他。最新版本 没有.exe的下载版本了，其内容和zip的一样。但是 zip和 tar.gz tar.bz2的 不太一样。zip比较全，包括了 已经编译好的二进制Pre-built.2，源码pthreads.2，还有一个3.QueueUserAPCEx 不知道到底干什么用的，是一个alert的driver，编译 需要 DDK ，默认vs2010 没有安装。Windows Device Driver Kit NTDDK.h 需要额外单独安装。

2.安装这些开发库到你的环境中，包括 lib 到vs的lib文件夹，dll到path目录中，include到vs的include文件夹中。这样比较方便么。

写两个个脚本 容易实现的：



[![复制代码](https://common.cnblogs.com/images/copycode.gif)](http://www.cnblogs.com/ayanmw/archive/2012/08/06/2625275.html)

```
rem put this file to :D:\#win pthread\pthreads-w32-2-9-1-release\Pre-built.2


copy include\pthread.h "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\include\"pthread.h
copy include\sched.h "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\include\"sched.h
copy include\semaphore.h "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\include\"semaphore.h

copy dll\x86\pthreadVC2.dll %windir%\pthreadVC2.dll
copy dll\x86\pthreadVCE2.dll %windir%\pthreadVCE2.dll
copy dll\x86\pthreadVSE2.dll %windir%\pthreadVSE2.dll

copy lib\x86\pthreadVC2.lib "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\lib\"pthreadVC2.lib 
copy lib\x86\pthreadVCE2.lib "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\lib\"pthreadVCE2.lib 
copy lib\x86\pthreadVSE2.lib "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\lib\"pthreadVSE2.lib 


ping -n 2 127.1>nul
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](http://www.cnblogs.com/ayanmw/archive/2012/08/06/2625275.html)





[![复制代码](https://common.cnblogs.com/images/copycode.gif)](http://www.cnblogs.com/ayanmw/archive/2012/08/06/2625275.html)

```
rem put this file to :D:\#win pthread\pthreads-w32-2-9-1-release\Pre-built.2


del /f /a /q "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\include\"pthread.h
del /f /a /q "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\include\"sched.h
del /f /a /q "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\include\"semaphore.h

del /f /a /q  %windir%\pthreadVC2.dll
del /f /a /q  %windir%\pthreadVCE2.dll
del /f /a /q  %windir%\pthreadVSE2.dll

del /f /a /q "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\lib\"pthreadVC2.lib 
del /f /a /q "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\lib\"pthreadVCE2.lib 
del /f /a /q "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\lib\"pthreadVSE2.lib 


ping -n 2 127.1>nul
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](http://www.cnblogs.com/ayanmw/archive/2012/08/06/2625275.html)



以上 路径 可能不一样，请自行更正。

3.测试 windows下的pthread库



[![复制代码](https://common.cnblogs.com/images/copycode.gif)](http://www.cnblogs.com/ayanmw/archive/2012/08/06/2625275.html)

```
#include<stdio.h>
#include<pthread.h>
#include<Windows.h>
#pragma comment(lib, "pthreadVC2.lib")  //必须加上这句
 
void*Function_t(void* Param)
{
     pthread_t myid = pthread_self();
     while(1)
     {
         printf("线程ID=%d \n", myid);
         Sleep(4000);
     }
     return NULL;
}
 
int main()
{
     pthread_t pid;
     pthread_create(&pid, NULL, Function_t,NULL);
     while (1)
     {
         printf("in fatherprocess!\n");
         Sleep(2000);
     }
     getchar();
     return 1;
}
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](http://www.cnblogs.com/ayanmw/archive/2012/08/06/2625275.html)



这个是直接copy网友的，例子不是特别的好，仅仅使用到了pthread_create.

包括了 windows.h 和pthread.h 头文件。

由于其是使用 DLL 方式链接 pthread库的，所以，dll需要到path路径中去，放到 可执行文件目录也行。至于能否 直接静态链接 到可执行文件，我想 应该 特别容易了，自己编译下 windows pthread库就可以了。

编译 这个 测试文件 我也写个 批处理，以后 直接看到批处理，就什么都明白了。



[![复制代码](https://common.cnblogs.com/images/copycode.gif)](http://www.cnblogs.com/ayanmw/archive/2012/08/06/2625275.html)

```
rem 0.=========初始化 VS环境
call "C:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\vcvarsall.bat" x86

rem 1.=========
rem 源文件中添加 #pragma comment(lib, "pthreadVC2.lib")
cl.exe testWPthread.cpp  

rem 2.=========
rem cl.exe testWPthread.cpp  /c /I"c:\pthreads-w32-2-7-0-release\Pre-built.2\include"
rem link.exe testWPthread.obj /LIBPATH:"c:\pthreads-w32-2-7-0-release\Pre-built.2\lib" pthreadVC2.lib


testWPThread.exe

del /f *.exe
del /f *.obj

cmd
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](http://www.cnblogs.com/ayanmw/archive/2012/08/06/2625275.html)



链接 lib库 ，在cl.exe编译器下 可以通过  #pragma comment(lib, "pthreadVC2.lib") 或者 加入 到cl.exe 的参数中去 都可以。

