# 编译工具

[TOC]

## 编译相关工具包括：
* 文本工具
* 预处理器
* 编译器
* 汇编器
* 连接器
* 调试器
* IDE工具
* 组织工具

##### c编译器
常用c编译器包括：gcc(gnu)，msvc_cl, nvcc, mingw32-gcc,cygwin-gcc,llvm-cc, mingw-w64-gcc，clang

GCC 原名为 GNU C 语言编译器（GNU C Compiler），因为它原本只能处理 C语言。。GCC 很快地扩展，变得可处理 C++。后来又扩展能够支持更多编程语言，如Fortran、Pascal、Objective-C、Java、Ada、Go以及各类处理器架构上的汇编语言等，所以改名GNU编译器套件（GNU Compiler Collection）。

TCC(Tiny C Compiler)介绍 TCC是一个超小、超快的标准C语言编译器。
##### 其他编译器
    fortran编译器：gcc-fortran，
##### 常用汇编器
ml.exe ml64.exe masm.exe

如何msvc生成汇编代码文件？
Project->Setting->C/C++->Category->Listing Files->lISTING file type:选No Listing以外的即可 
项目属性->配置属性->cc++->输出文件->汇编文件输出->带源代码程序集
gcc 生成asm文件？
执行gcc -S 命令
##### 调试器
一般与编译器配套
lib文件和同名pdb文件，lib文件用于编译，pdb用于调试，可以跟踪源码。


    
##### 组织工具
make，cmake，nmake，bjam(boost),qmake
* cmake 添加 OpenCVConfig.cmake 路径到环境变量，OpenCVConfig.cmake和install相同路径
* 通过FindOpenCV.cmake提供路径变量
* cmake通过findSwig.cmake来搜索swig.exe,进而得到swig目录。

##### ide工具
前端IDE工具：Sublime、Atom、VSCode,msvc，eclipse,


#### msvc编译工具
msvc编译工具位于：C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin
``` 
C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\vcvars32.bat
C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\bin\amd64\vcvars64.bat
C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\x86_amd64\vcvarsx86_amd64.bat
C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64_x86\vcvarsamd64_x86.bat
C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\x86_arm\vcvarsx86_arm.bat
C:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\bin\amd64_arm\vcvarsamd64_arm.bat
# 以上变量会添加一下环境变量：
PATH=c:\Program Files (x86)\Microsoft F#\v4.0\;c:\Program Files (x86)\Microsoft
Visual Studio 10.0\VSTSDB\Deploy;c:\Program Files (x86)\Microsoft Visual Studio
10.0\Common7\IDE\;c:\Program Files (x86)\Microsoft Visual Studio 10.0\VC\BIN;c:\
Program Files (x86)\Microsoft Visual Studio 10.0\Common7\Tools;C:\WINDOWS\Micros
oft.NET\Framework\v4.0.30319;C:\WINDOWS\Microsoft.NET\Framework\v3.5;c:\Program
Files (x86)\Microsoft Visual Studio 10.0\VC\VCPackages;C:\Program Files (x86)\HT
ML Help Workshop;c:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\bin\NETFX 4
.0 Tools;c:\Program Files (x86)\Microsoft SDKs\Windows\v7.0A\bin
```


```
 c:\program files (x86)\microsoft visual studio 11.0\vc\bin 的目录
vcvars32.bat
bscmake.exe    cl.exe         cvtres.exe     dumpbin.exe    editbin.exe
lib.exe        link.exe       ml.exe         nmake.exe      pgocvt.exe
pgomgr.exe     pgosweep.exe   undname.exe    xdcmake.exe    
```

```
cl.exe
ml.exe
nmake.exe   

devenv.exe
blend.exe

bscmake.exe
lib.exe
nmake.exe
pgocvt.exe
editbin.exe
pgomgr.exe
dumpbin.exe
pgosweep.exe
undname.exe
cvtres.exe
cl.exe
xdcmake.exe
ml.exe
link.exe
vcvars32.bat
xdcmake.exe.config
cl.exe.config
link.exe.config
c1xx.dll
pgort100.dll
pgodb100.dll
c1.dll
c2.dll
atlprov.dll
```



##### 编译器
CL.EXE
##### lib

```
lib /machine:ix86 /def:libfftw3-3.def
rem 生成动态dll声明对应的.lib文件
```
##### dumpbin
可以查看lib文件结构
dumpbin.exe /DIRECTIVES E:\Code\\levmar.lib

##### msvc标准库代码
C:\Program Files (x86)\Microsoft Visual Studio 11.0\VC\CRT


#### misc

opencv的dll版本：cxcore100.dll , cvcore240.dll,

#### 常见编译错误解决方法
##### 编译错误lnk1104
编译错误lnk1104， 没有lib文件
有dll文件，没有lib文件，说明没有定义dllexport宏


##### VS2010中“转到定义”提示“未能找到符号”的解决方法
1、关闭VS2010或解决方案；
2、删除解决方案对应的 .sdf文件；

##### fatal error lnk1123:转换到coff期间失败
删除cvtres.exe

1.打开该项目的“属性页”对话框。
2.单击“链接器”文件夹。
3.单击“命令行”属性页。
4.将 /SAFESEH:NO 键入“附加选项”框中，然后点击应用

是嵌入清单的问题，于是对该工程以及所有依赖工程进行如下操作
右键->工程属性->配置属性-> 清单工具->输入和输出->嵌入清单，选择[否]
1>LINK : fatal error LNK1123: 转换到 COFF 期间失败: 文件无效或损坏
1>CVTRES : fatal error CVT1100: 资源重复。类型: MANIFEST，名称: 1，语言: 0x0409
这个是由于日志文件引起的，可以将
项目\属性\配置属性\清单工具\输入和输出\嵌入清单：原来是“是”，改成“否”。
或者将
项目\属性\配置属性\链接器\清单文件\生成清单：原来是“是”，改成“否”
