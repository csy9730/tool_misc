# TCL

本词条缺少**概述图**，补充相关内容使词条更完整，还能快速升级，赶紧来编辑吧！

Tcl, 工具命令语言(Tool Command Language)是一门有编程特征的解释语言，可在 Unix、Windows 和 Apple Macintosh 操作系统上跨平台运行。



TCL

- 中文名

  工具命令语言

- 外文名

  TCL

- 创建者

  John Ousterhout

## 目录

1. 1 [语言简介](https://baike.baidu.com/item/TCL/5779974#1)
2. 2 [语言扩展](https://baike.baidu.com/item/TCL/5779974#2)



## 语言简介

编辑

 语音

TCL (最早称为“工具命令语言”"Tool Command Language",，但是现在已经不是这个含义，不过我们仍然称呼它为TCL)是一种 [脚本语言](https://baike.baidu.com/item/脚本语言)。 由John Ousterhout创建。 TCL很好学，功能很强大。TCL经常被用于快速原型开发，脚本编程， [GUI](https://baike.baidu.com/item/GUI)和测试等方面。TCL念作“踢叩” "tickle"。Tcl的特性包括：

\* 任何东西都是一条命令，包括语法结构(for, if等)。

\* 任何事物都可以重新定义和重载。

\* 所有的数据类型都可以看作字符串。

\* 语法规则相当简单

\* 提供事件驱动给[Socket](https://baike.baidu.com/item/Socket)和文件。基于时间或者用户定义的事件也可以。

\* 动态的域定义。

\* 很容易用C, [C++](https://baike.baidu.com/item/C%2B%2B),或者Java扩展。

\* 解释语言，代码能够动态的改变。

\* 完全的[Unicode](https://baike.baidu.com/item/Unicode)支持。

\* 平台无关。[Win32](https://baike.baidu.com/item/Win32), [UNIX](https://baike.baidu.com/item/UNIX), [Mac](https://baike.baidu.com/item/Mac)上都可以跑。

\* 和[Windows](https://baike.baidu.com/item/Windows)的GUI紧密集成。 Tk

\* 代码紧凑，易于维护。

TCL本身不提供[面向对象](https://baike.baidu.com/item/面向对象)的支持。但是语言本身很容易扩展到支持面向对象。许多[C语言](https://baike.baidu.com/item/C语言)扩展都提供面向对象能力，包括XOTcl, [Incr Tcl](https://baike.baidu.com/item/Incr Tcl)等。另外[SNIT](https://baike.baidu.com/item/SNIT)扩展本身就是用TCL写的。



## 语言扩展

编辑

 语音

使用最广泛的TCL扩展是TK。 TK提供了各种OS平台下的[图形用户界面](https://baike.baidu.com/item/图形用户界面)GUI。连强大的[Python](https://baike.baidu.com/item/Python)语言都不单独提供自己的GUI，而是提供接口适配到TK上。另一个流行的扩展包是Expect. Expect提供了通过终端自动执行命令的能力，例如([passwd](https://baike.baidu.com/item/passwd), [ftp](https://baike.baidu.com/item/ftp), [telnet](https://baike.baidu.com/item/telnet)等命令驱动的外壳).

另外一个TK的例子 (来自 A simple A/D clock) 它使用了定时器时间，3行就显示了一个时钟。

proc every {ms body} {eval $body; after $ms [info level 0]}

pack [label .clock -textvar time]

every 1000 {set ::time [clock format [clock sec] -format %H:%M:%S]} ;# RS

解释：第一行定义了过程every， 每隔ms毫秒，就重新执行[body](https://baike.baidu.com/item/body)代码。第二行创建了标签起内容由time变量决定。第3行中设置[定时器](https://baike.baidu.com/item/定时器)，time变量从当前时间中每秒更新一次。