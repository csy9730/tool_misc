# gdb

远程调试环境由宿主机GDB和目标机调试stub共同构成，两者通过串口或TCP连接。使用 GDB标准程串行协议协同工作，实现对目标机上的系统内核和上层应用的监控和调试功能。调试stub是嵌入式系统中的一段代码，作为宿主机GDB和目标机 调试程序间的一个媒介而存在。 就目前而言，嵌入式Linux系统中，主要有三种远程调试方法，分别适用于不同场合的调试工作：用ROM Monitor调试目标机程序、用KGDB调试系统内核和用gdbserver调试用户空间程序。这三种调试方法的区别主要在于，目标机远程调试stub 的存在形式的不同，而其设计思路和实现方法则是大致相同的。 而我们最常用的是调试应用程序。就是采用gdb+gdbserver的方式进行调试。在很多情况下，用户需要对一个应用程序进行反复调试，特别是复杂的程 序。采用GDB方法调试，由于嵌入式系统资源有限性，一般不能直接在目标系统上进行调试，通常采用gdb+gdbserver的方式进行调试。

## gdb

* list
* print
* run
* continue
* step
* quit
* break
* next
* info

## gdbserver
在嵌入式板子上使用gdbserver，在PC端使用gdb远程调试。


### 通过网络连接
Target arm:
`gdbserver localhost:port my_exe args`

Host pc:
```
gdb my_exe
target remote localhost:port # 连接板子

b main # 打入断点
c # 继续执行，注意这里不能使用 run
s # 单步执行
```

### 通过串口连接

Target arm:
`gdbserver  /dev/ttyS0 my_exe `

Host pc:
```
gdb my_exe

set remotedevice /dev/ttyUSB0 # （这里设置串口1）

set remote baud 115200 （这里设置串口波特率）

set debug remote 1   (可选)

target remote /dev/ttyS0
```

## misc
问题收集：
1.出现“No symbol table is loaded.  Use the "file" command.”表示编译app应用程序时没加－g调试信息选项导致无法load符号表。
2.出现”cannot execute binary file“表示编译gdbserver时平台交叉编译器配置不对，提示无法执行二进制文件，可用“file gdbserver”查看执行平台信息。


dmesg 来查看安装驱动的信息
开发板连接的是USB转串口设备/dev/ttyUSB0，如果是普通的串口设备会是/dev/ttyS*.

stty -F /dev/ttyS0 


(gdb) target remote /dev/ttyUSB0
/dev/ttyUSB0: 输入/输出错误.