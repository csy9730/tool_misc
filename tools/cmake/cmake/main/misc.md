# misc


### 开启fPIC

```


```


```
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -fPIC")
```


### 开启VERBOSE模式

```
cmake .
make VERBOSE=1

```


## misc

### linking error
[https://cmake.org/cmake/help/latest/manual/cmake.1.html](https://cmake.org/cmake/help/latest/manual/cmake.1.html)


requests linking to directory "H:/Project/Github/opencv_build/install".  Targets may link only to libraries.  CMake is dropping the item.

可能是链接错误，例如 x86工程尝试连接x64的lib，导致出错。


#### cmake无法使用amd/cl 作为编译器

msvc针对不同版本有不同的cl.exe
32/64 位系统编译在32位系统上运行 => x86/cl
32 系统上编译64位系统上运行 => x86_amd64/cl
64 系统上编译在64位系统上运行 => amd64/cl

cmake 版本3.20，只能使用 `x86_amd64/cl.exe`, 不能直接使用`amd64/cl.exe`

执行以下命令：
`cmake -G "Visual Studio 14 2015 Win64"  ..`

调用 `x86_amd64/cl.exe`


### /usr/include/c++/6/cstdlib:75:25: fatal error: stdlib.h: No such file or directory
/usr/include/c++/6/cstdlib:75:25: fatal error: stdlib.h: No such file or directory

报错如上。后来经过查阅，发现这个错误是因为由于gcc6的缘故。我的gcc 版本是6.5的。gcc6已经把吧stdlib.h纳入了libstdc++以进行更好的优化，C Library的头文件stdlib.h使用 Include_next，而include_next对gcc系统头文件路径很敏感。

所以这里我们不要把include路径作为系统目录，而是使用标准方式包含include 目录。

2.解决办法
在cmake 编译的时候，加上  以下命令在里面，即可成功。

-DENABLE_PRECOMPILED_HEADERS=OFF
