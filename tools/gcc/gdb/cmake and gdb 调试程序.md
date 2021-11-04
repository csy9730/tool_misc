# [cmake and gdb 调试程序](https://www.cnblogs.com/welen/articles/4286266.html)

## cmake支持gdb的实现
在CMakeLists.txt下加入

在下面加入：

```cmake
SET(CMAKE_BUILD_TYPE "Debug") 
SET(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g -ggdb")
SET(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")
```




原因是CMake 中有一个变量 CMAKE_BUILD_TYPE ,可以的取值是 Debug Release RelWithDebInfo >和 MinSizeRel。
当这个变量值为 Debug 的时候,CMake 会使用变量 CMAKE_CXX_FLAGS_DEBUG 和 CMAKE_C_FLAGS_DEBUG 中的字符串作为编译选项生成 Makefile;

## debug
\2.  在GDB中间加入程序启动参数
比如我们需要调试一个可执行文件./a.out help
这时
$gdb ./a.out
进入到gdb的命令行模式下，然后：
(gdb) set args help
就能加上可执行文件需要的参数，如果要看argc[1]到argc[N]的参数，只需要
(gdb) show args

\3. gdb中查看字符串，地址的操作，数据类型
比始有一个int型的变量i，相要知道他的相关信息，可以
(gdb) print i
打印出变量i的当前值
(gdb)x &i
与上面的命令等价。

如果有x命令看时，需要看一片内存区域，（如果某个地方的值为0，用x时会自动截断了）
(gdb) x/16bx address
单字节16进制打印address地址处的长度为16的空间的内存，16表示空间长度，不是16进制，x表示16进制，b表示byte单字节

gdb看变量是哪个数据类型 
(gdb) whatis i
即可知道i是什么类型的变量  





查看代码:
list/l

开始调试:
start

逐行调试:
n

进入函数调试:
s

查看变量数据
p 变量名

退出调试:
q

delete <N>