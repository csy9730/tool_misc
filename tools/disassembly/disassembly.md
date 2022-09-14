# 反汇编

## 简介

### Disassembly
反汇编(Disassembly)：把目标代码转为[汇编](https://baike.baidu.com/item/汇编/627224)代码的过程，也可以说是把机器语言转换为汇编语言代码、低级转高级的意思，常用于软件破解（例如找到它是如何注册的，从而解出它的注册码或者编写注册机）、外挂技术、病毒分析、逆向工程、软件汉化等领域。学习和理解反汇编语言对软件调试、漏洞分析、OS的内核原理及理解高级语言代码都有相当大的帮助，在此过程中我们可以领悟到软件作者的编程思想。总之一句话：软件一切神秘的运行机制全在反汇编代码里面。


### compile flow
binary 到 汇编 到 高级语言。

- binary到汇编的过程称为反汇编。
- 汇编到高级语言的过程称为反编译。
    - 反编译出来的高级语言是没有符号的，后端种种优化过的。

- c文件
- asm文件
- obj文件  linux 下是.o
- lib文件  linux 下是.a
- dll文件  linux 下是.so
- exe文件


### file catelog

- COFF
- PE32
- ELF


#### 目标文件格式

| Name | Full Name               | OS      | e.g.                     | View Tool       |
| :--- | :---------------------- | :------ | :----------------------- | :-------------- |
| ELF  | Executable And Linkable | Linux   | .o/.so                   | objdump/readelf |
| PE   | Portable Executable     | Windows | .exe/.dll/.ocx/.sys/.com | PETool          |
| COFF | Common file format      |         | .obj                     | objdump/dumpbin |


#### 目标文件类型

| Type         |                    | Mean                                                         | Linux         | Windows |
| :----------- | :----------------- | :----------------------------------------------------------- | :------------ | :------ |
| 可重定位文件 | Relocatable File   | 包含适合于与其他目标文件链接来创建可执行文件或者共享目标文件的代码和数据 | .o            | .obj    |
| 可执行文件   | Executable File    | 包含适合于执行的一个程序，此文件规定了`exec()`如何创建一个程序的进程映像 | /bin/bash文件 | .exe    |
| 共享目标文件 | Shared Object File | 包含可在两种上下文中链接的代码和数据。首先链接编辑器可以将它和其它可重定位文件和共享目标文件一起处理，生成另外一个目标文件。其次，动态链接器（Dynamic Linker）可能将它与某个可执行文件以及其它共享目标一起组合，创建进程映像。 | .so           | .dll    |

#### COFF
COFF（Common Object File Format）格式，COFF是由Unix System V Release 3首先提出并且使用的格式规范
#### PE
在32位Windows平台下，微软引入了一种叫PE（Portable Executable）的可执行格式。作为Win32平台的标准可执行文件格式，PE有着跟ELF一样良好的平台扩展性和灵活性。PE文件格式事实上与ELF同根同源

请注意，上面在讲到PE文件格式的时候，只是说Windows平台下的可执行文件采用该格式。事实上，在Windows平台，VISUAL C++编译器产生的目标文件仍然使用COFF格式。由于PE是COFF的一种扩展，所以它们的结构在很大程度上相同，甚至跟ELF文件的基本结构也相同，都是基于段的结构。所以我们下面在讨论Windows平台上的文件结构时，目标文件默认为COFF格式，而可执行文件为PE格式。但很多时候我们可以将它们统称为PE/COFF文件。
#### PE32+
随着64位Windows的发布，微软对64位Windows平台上的PE文件结构稍微做了一些修改，这个新的文件格式叫做PE32+。新的PE32+并没有添加任何结构，最大的变化就是把那些原来32位的字段变成了64位，比如文件头中与地址相关的字段。
#### ELF
System V Release 4在COFF的基础上引入了ELF格式，目前流行的Linux系统也以ELF作为基本可执行文件格式。



## tools

### 工具细分

- 可执行文件分析工具，比如PEID啥的，可以分析出EXE文件的内部情况，入口点，数据段，是否加壳等等。
- 去壳工具。简单的壳官方会提供去壳工具，复杂一点的要手动跟踪去除。
- 静态反编译工具。从EXE反编译出汇编代码，先大体上看看内部逻辑请款，函数调用，数据等等。
- 动态跟踪调试工具，比如Ollydog，简称OD。用来跟踪程序的执行过程，下断点，跟踪，找到并且分析软件加密算法，或者通过更改汇编指令改变程序逻辑。
- 注册机制作工具、补丁制作辅助工具。找到算法并且逆向分析出来了的用注册机制作工具写个注册机出来；通过改汇编代码的写个补丁。比如JE改成JNE之类。


以上是基本要用到的，大一点的软件破解还要用到「文件系统监视工具」「注册表监测工具」「虚拟机」等等，如果你要直接做个破解版应该还要用到「EXE资源修改替换工具」。
然后一定要的知识有：PE原理，汇编语言，算法分析，编程语言。


### 命令行工具
基础工具：

- strings: gnu工具，可以提取ASCII字符串。
- file: gnu工具, 可以根据文件首部的幻数猜测文件类型
- size: gnu工具, 列出段节大小和总大小。
- c++filt: gnu工具， C++源码编译后生成二进制文件中符号表中的符号名还原工具。
- nm: gnu工具, nm列出符号值，符号类型和其符号名字
- objdump: gnu工具， 可以打印obj文件的信息。
- ldd: gnu工具, 列出动态库依赖关系
- readelf: gnu工具，可以打印elf文件的信息。
- dumpbin: msvc工具
- depends: msvc的gui工具, 列出dll/exe的依赖动态库
- otool
- pe tools
- peID


### 界面工具


用的静态分析工具是
- [W32DASM](https://baike.baidu.com/item/W32DASM), 它是一个静态反汇编工具，也是破解人常用的工具之一。
- [PEiD](https://baike.baidu.com/item/PEiD)
- FileInfo
- [Hex Rays Ida](https://baike.baidu.com/item/Hex%20Rays%20Ida)
- HIEW


反汇编工具如：
- [OD](https://baike.baidu.com/item/OD)
- [IDA Pro](https://baike.baidu.com/item/IDA%20Pro)
- radare2
- [DEBUG](https://baike.baidu.com/item/DEBUG)
- C32

#### ollyDbg
ollyDbg是动态分析软件

反汇编可以通过反汇编的一些软件实现，比如DEBUG就能实现反汇编，当DEBUG文件位置设置为-u时，即可实现反汇编。 而使用OD实现反汇编时，杀毒软件可能会报告有病毒与木马产生，此时排除即可，且使用OD需要有扎实的基础才能看懂。

#### Dcwa

