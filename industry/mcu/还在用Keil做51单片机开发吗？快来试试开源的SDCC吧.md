# 还在用Keil做51单片机开发吗？快来试试开源的SDCC吧

[![charlee](https://pic1.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=172ae18b)](https://www.zhihu.com/people/charlee)

[charlee](https://www.zhihu.com/people/charlee)

软件工程师

17 人赞同了该文章

相信许多人学习51单片机的时候接触的IDE都是Keil的μVision，我也不例外。我从[Keil的官方网站](https://link.zhihu.com/?target=https%3A//www.keil.com/)上下载了μVision 5的试用版。在学习的过程中μVision 5一切良好，能满足所有学习的需要。但等到自己开始做一些小项目的时候，一些小问题就出现了。

第一个问题就是μVision 5不支持命令行。为什么需要命令行呢？因为μVision 5本身的IDE的技术已经相当陈旧了，许多现代编辑器拥有的便利功能它都没有。因此，我更希望使用VSCode来编写代码。那么，VSCode写完代码之后怎么编译呢？虽然可以同时在 μVision 5 和VSCode中打开同一个项目，但毕竟每次修改代码后还要切换到 μVision 5 去点编译按钮，不是太方便。我希望能写一个简单的Makefile，修改完代码后直接执行`make` 就可以生成hex文件。这就需要从命令行调用 μVision 5。虽然 μVision 5的可执行文件支持一些简单的命令行选项，但并不能满足Makefile的需求。

第二个问题就是授权问题。 μVision 5的试用版只能编译不超过2KB的代码。当你的项目足够复杂、源代码足够长时，你就会遇到下面的错误：

```text
*** FATAL ERROR L250: CODE SIZE LIMIT IN RESTRICTED VERSION EXCEEDED MODULE: C:\KEIL\C51\LIB\C51FPS.LIB (-----) LIMIT: 0800H BYTES
```

可以说，每个学习51单片机的人早晚都会遇到这个问题。但Keil的授权是非常贵的。虽然Keil官网上并没有给出开发工具的报价，但根据一份2012年的资料，51单片机的开发工具套装（包括CA51、μVision 3仿真器和调试器等）报价为$3640美元，这个价格完全不是业余爱好者和学生承受得起的。

![img](https://pic1.zhimg.com/80/v2-298a221135549448a4ac46f1bc80bb88_720w.webp)

那么，怎样解决这个问题？这就要轮到这篇文章的主角——SDCC——登场了！

## SDCC

[SDCC](https://link.zhihu.com/?target=http%3A//sdcc.sourceforge.net/)的全称是Small Device C Compiler，即“小型设备C语言编译器”。根据官网的说法，

> SDCC是一个可重定向目标的、优化的标准C编译器套件（支持ANSI C89、ISO C99和ISO C11），支持基于英特尔MCS51（8031、8032、8051、8052等）、Maxim（原Dallas）的DS80C390系列、Freescale（原摩托罗拉）的HC08系列（hc08、s08）、Zilog的Z80系列（z80、z180、gbz80、Rabbit 2000/3000、Rabbit 3000A、TLCS-90）、Padauk（pdk14、pdk15）和意法半导体的STM8。

这里的MCS51就是我们常说的51单片机。

SDCC套件是一系列工具的总称，其中我们需要使用的sdcc编译器采用GPL授权，因此我们不需要花钱就可以使用。

SDCC的安装非常简单，只需到官网的下载页面，下载对应于上位机操作系统的版本即可。我打算在Windows 10下使用，因此选择sdcc-win64下载。

安装完成后，需要到系统属性的环境变量设置页面，将`C:\Program Files\SDCC\bin` 加入`PATH` 环境变量。然后打开一个命令行窗口，输入`sdcc --version` 命令验证安装是否成功：

```text
> sdcc --version
SDCC : mcs51/z80/z180/r2k/r2ka/r3ka/gbz80/tlcs90/ez80_z80/z80n/ds390/pic16/pic14/TININative/ds400/hc08/s08/stm8/pdk13/pdk14/pdk15 4.1.0 #12072 (MINGW64)
published under GNU General Public License (GPL)
```

这样SDCC就可以使用了。

## 将Keil程序移植到SDCC

SDCC支持的C语言和Keil所用的C语言略有不同，不过差异并不是太大，只需要10分钟就可以移植完毕。实际上我认为SDCC的C语言更“标准”，Keil才是说方言的那个人。我发现的差异有：

- 包含自定义的头文件时必须使用双引号。例如，我的某个项目中有个名为`tm1638.h` 的文件，那么在Keil中我可以写`#include ` ，但在SDCC中必须写成 `#include "tm1638.h"`。
- 8051的头文件名字不一样。Keil中为 `#include `，而在SDCC中需要写成 `#include <8052.h>`。
- Keil中的特殊类型 `sbit` 和 `sfr` 在SDCC中为 `__sbit`和 `__sfr` 。例如，Keil中的代码 `sfr P0 = 0x80; sbit P0_1 = P0 ^ 1;` 在SDCC中就要写成：`__sfr __at (0x80) P0; __sbit __at (0x81) P0_1;` 。不过好在`8052.h` 中已经为我们定义好了常用的端口，需要使用哪个端口时，直接使用`P0`、`P1`、`P2_1`之类的宏即可。
- Keil中的`code`关键字（用于将数据放入代码段）在SDCC中应该写成`__code`。例如，在Keil中的代码`unsigned char code sevenseg_hex[] = { ... };` 在SDCC中应该这样写：`__code unsigned char sevenseg_hex[] = { ... };`
- Keil中的 `interrupt` 关键字在SDCC中应该写成 `__interrupt`。所以定义中断处理函数的代码在SDCC中应该写成：`void timer0() __interrupt 1 { ... }`。

这些差异只是写法上的区别，所以迁移到SDCC应该非常顺利。

## 编译和下载

SDCC的编译器非常容易使用。简单来说，如果你的项目只有一个C文件，那么只需要执行下述命令即可：

```text
> sdcc main.c
```

如果有两个以上的文件，那么首先需要使用`-c`选项将辅助文件编译成`.rel`文件，然后再与主程序一起编译：

```text
> sdcc -c tm1638.c
> sdcc main.c tm1638.rel
```

编译结果是扩展名为`.ihx`的文件，需要使用以下命令转换成常用的`.hex`文件：

```text
> packihx main.ihx > main.hex
```

更推荐的方法是自己编写一个Makefile。首先需要在Windows下安装GNU Make。这里我使用了Windows下的包管理器chocolatey，当然你可以选择自己喜欢的包管理器：

```text
(在管理员权限下) > chocolatey.exe install make
```

然后编写如下`Makefile`。

```make
ifeq ($(OS),Windows_NT) 
RM = del /Q /F
CP = copy /Y
ifdef ComSpec
SHELL := $(ComSpec)
endif
ifdef COMSPEC
SHELL := $(COMSPEC)
endif
else
RM = rm -rf
CP = cp -f
endif
CC := sdcc
PACKIHX := packihx
.PHONY: all clean
all: tm1638-counter.hex
clean:
        -$(RM) -f *.asm *.lk *.lst *.map *.mem *.rel *.rst *.sym *.asm *.ihx *.hex
tm1638.rel: tm1638.h tm1638.c
        $(CC) -c tm1638.c
main.ihx: tm1638.h main.c tm1638.rel
        $(CC) main.c tm1638.rel
tm1638-counter.hex: main.ihx
        $(PACKIHX) main.ihx > tm1638-counter.hex
```

上面是我的计时器项目的Makefile，你可以根据自己的需要自行修改最后几行的构建目标。写好Makefile之后，只需执行`make`就可以编译项目并生成`tm1638-counter.hex`文件，非常方便。

## 仿真和调试

很可惜SDCC没有调试器，不能像μVision那样软件仿真程序。不过，SDCC在编译的时候会首先生成汇编语言源文件，例如上一节的Makefile的例子中，执行`make` 后会生成一个`main.asm`，我们可以分析这个汇编语言源文件来理解程序的走向。另一个调试的方法是使用MCS51模拟器。最流行的莫过于[EdSim51](https://link.zhihu.com/?target=https%3A//www.edsim51.com/)了。这个模拟器不仅模拟了51芯片本身，还提供了一系列可配置的外围设备，相当于一个软件的开发板，十分好用。

![img](https://pic3.zhimg.com/80/v2-1ca200d96c4c50a5009ae2b1c85ed0ae_720w.webp)

## 总结

我不太清楚目前流行的51单片机开发方式是什么，但从网上的说法来看，似乎很多人还是在尝试破解μVision。首先，旗帜鲜明地反对使用盗版软件。侵权问题放在一边，运行破解程序这一步就会带来很大的安全风险。其次，μVision的确是个好工具，但对于学习和个人爱好来说，完全是杀鸡用牛刀。

所以我的观点是，为了学习的目的，完全可以使用μVision的试用版，官网可以免费下载，可以编译和调试2KB以下的代码，对于学习来说完全够用，没有必要去破解。在个人项目中如果需要编译大型代码，尽可能使用开源软件。SDCC不仅可以避免法律和安全风险，还能提供巨大的便利性（支持Makefile等）。

------

【[电子工程师日记](https://www.zhihu.com/search?q=电子工程师日记&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A433712803})】是一个面向非专业人士和爱好者的电子工程类专栏，主要介绍一些电子DIY项目、单片机项目、树莓派/Arduino应用、[物联网](https://www.zhihu.com/search?q=物联网&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A433712803})等。欢迎关注本专栏，或者在微信中搜索公众号eceblog进行关注。



**阅读更多精彩文章：**

[charlee：用树莓派做一个光照温度记录仪9 赞同 · 1 评论文章![img](https://pic3.zhimg.com/v2-c8d6ac64d4df2e21bc62aa9df82703b6_180x120.jpg)](https://zhuanlan.zhihu.com/p/440680574)

[charlee：用树莓派做一台街机3 赞同 · 0 评论文章![img](https://pic2.zhimg.com/v2-07280710ccc0d0b0ddb255ad558d6d21_180x120.jpg)](https://zhuanlan.zhihu.com/p/428336482)

[charlee：自制番茄计时器提高工作效率0 赞同 · 1 评论文章![img](https://pic4.zhimg.com/v2-fce3abf8b946b187f7ea57ee16ad3bd7_180x120.jpg)](https://zhuanlan.zhihu.com/p/431049828)



发布于 2021-12-10 05:42

[51 单片机](https://www.zhihu.com/topic/19737566)

[DIY](https://www.zhihu.com/topic/19553863)