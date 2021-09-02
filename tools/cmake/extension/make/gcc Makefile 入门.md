# [gcc Makefile 入门](https://www.cnblogs.com/jasonliu/archive/2011/12/23/2299740.html)



使用**make**命令编译项目文件**入门**
目录：
一、**make**命令的运行过程
二、基本gcc编译命令
三、简单Makefile文件的编写
四、实例

一、make命令的运行过程
    在shell的提示符号下，若输入"make"，则它会到目前的目录下找寻Makefile这个文件.然后依照Makefile中所记录的步骤一步一步的来执行.在我们写程序的时候，如果事先就把compiler程式所需要的步骤先写在Makefile中的话，想要compiler程序的时候就只要打入make的指令.只要程序无误的话，就可以获得所需要的结果了！
    在项目文件中，如果有成百上千个源程序，每次修改其中的一个都需要全部重新编译是不可想象的事情.但通过编辑Makefile文件，利用make命令就可以只针对其中修改的源文件进行编译，而不需要全体编译.这就是make命令在编译项目文件时体现出来的优势.能做到这点，主要是基于Makefile文件的编写，和make命令对Makefile文件的调用.Makefile文件作为make命令的默认参数，使一个基于依赖关系编写的结构文件.
    大家经常看到使用make all, make install, make clean等命令，而他们处理的目标都是一个Makefile文件，那么all、install、clean参数是如何调用Makefile文件的运行呢？在这里，如果向上面的命令如果能够正确运行的话，那么在Makefile文件里一定有这样的几行，他们的以all、install、clean开始
all: ×××××××
       ×××××××××××
install: ××××××
       ×××××××××××
clean: ×××××××××
        ×××××××××××
all，install，clean我们可以用其他的变量来代替，他们是编译时的一个参数，在Makefile文件中作为一个标志存在，也就是我们所说的目标.make all命令，就告诉make我们将执行all所指定的目标.为了便于理解Make程序的流程，我们给大家看一个与gcc毫无关系的Makefile文件：
#Makefile begin
all:
        @echo you have typed command "make all"
clean:
        @echo you have typed command "make clean"
install:
        @ehco you have typed command "make $@"
#Makefile end
注意在这里，all:、clean:、install:行要顶格些，而所有的@echo前要加tab键来跳格缩进.下面是运行结果
[root@xxx test]#make all
you have typed command "make all"
[root@xxx test]#make clean
you have typed command "make clean"
[root@xxx test]#make install
you have typed command "make install"

二、基本gcc编译命令

1、源**程序的**编译 
    在Linux下面,使用GNU的gcc编译器编译一个**C**语言的源程序.下面我们简单介绍几个常用的Gcc编译命令和参数，这里不是讲解Gcc的使用，只是介绍简单的基础知识是我们能看懂一般的makefile文件. 
    我们先看一个使用gcc编译器的实例.假设我们有下面一个非常简单的源程序(hello.**c**): 
    int main(int argc,char **argv) 
    { 
       printf("Hello Linux\n"); 
     } 
要编译这个程序,我们只要在命令行下执行:     gcc -o hello hello.**c** 
    gcc 编译器就会为我们生成一个hello的可执行文件.执行./hello就可以看到**程序的**输出结果了.命令行中 gcc表示我们是用gcc来编译我们的源程序,-o 选项表示我们要求编译器给我们输出的可执行文件名为hello 而hello.**c**是我们的源程序文件. 
    gcc的基本格式就是：
       gcc [-option] objectname sourcename
    其中-option是参数，用来控制gcc的编译方式，常见的参数有如下几个：
    -o 表示我们要求输出的可执行文件名：-o binaryname
    -**c** 表示我们只要求编译器进行编译，输出目标代码,而不进行连接: -**c** objectivename.o
    -g 表示我们要求编译器在编译的时候提供我们以后对程序进行调试的信息: -g 
    -O2 表示我们希望编译器在编译的时候对我们的程序进行一定程度的优化.2表示我们优化的级别是2.范
        围是1-3.不过习惯上我们都使用2的优化级别.
    -Wall是警告选项,表示我们希望gcc在编译的时候,让gcc输出她认为的一些程序中可能会出问题的一些警
        告信息,比如指针没有初始化就进行赋值等等一些警告信息. 
    -l 与之紧紧相连的是表示连接时所要的链接**库**，比如多线程，如果你使用了pthread_create函数，那么         你就应该在编译语句的最后加上"-lpthread"，"-l"表示连接，"pthread"表示要连接的**库**，注意他们         在这里要连在一起写.如：gcc -o test test1.o test2.o -lpthread
    -I 表示将系统缺省的头文件路径扩展到当前路径，默认的路径保存在/etc/ld.conf文件中。
    gcc的例子：
        gcc -**c** test.**c**，表示只编译test.**c**文件，成功时输出目标文件test.o
        gcc -o test test.o，将test.o连接成可执行的二进制文件test
        gcc -o test test.**c**，将test.**c**编译并连接成可执行的二进制文件test
        gcc -**c** test.**c** -o test.o ，与上一条命令完全相同
        gcc test.**c** -o test，与上一条命令相同
        gcc -**c** test1.**c**，只编译test1.**c**，成功时输出目标文件test1.o
        gcc -**c** test2.**c**，只编译test2.**c**，成功时输出目标文件test2.o
        gcc -o test test1.o test2.o，将test1.o和test2.o连接为可执行的二进制文件test
        gcc -**c** test test1.**c** test2.**c**，将test1.o和test2.o编译并连接为可执行的二进制文件test

2、程序**库**的链接 
试着编译下面这个程序 
/* temp.**c** */ 
\#include 
int main(int argc,char **argv) 
{ 
double value =15; 
printf("Value:%f\n",log(value)); 
} 
这个程序相当简单,但是当我们用 gcc -o temp temp.**c** 编译时会出现下面所示的错误. 
/tmp/cc33Kydu.o: In function `main': 
/tmp/cc33Kydu.o(.text+0xe): undefined reference to `log' 
collect2: ld returned 1 exit status 
    出现这个错误是因为编译器找不到log的具体实现.虽然我们包括了正确的头文件,但是我们在编译的时候还是要连接确定的**库**.在Linux下,为了使用数学函数,我们必须和数学**库**连接,为此我们要加入 -lm 选项. gcc -o temp temp.**c** -lm这样才能够正确的编译.也许有人要问,前面我们用printf函数的时候怎么没有连接**库**呢?是这样的,对于一些常用的函数的实现,gcc编译器会自动去连接一些常用**库**,这样我们就没有必要自己去指定了. 有时候我们在编译**程序的**时候还要指定**库**的路径,这个时候我们要用到编译器的 -L选项指定路径.比如说我们有一个**库**在 /home/hoyt/mylib下,这样我们编译的时候还要加上 -L/home/hoyt/mylib.对于一些标准**库**来说,我们没有必要指出路径.只要它们在起缺省**库**的路径下就可以了.系统的缺省**库**的路径/lib、/usr/lib、/usr/local/lib(你可以查看你的/etc/ld.conf文件来看看你的系统指定了那几个缺省的路径) 在这三个路径下面的**库**,我们可以不指定路径. 
    还有一个问题,有时候我们使用了某个函数,但是我们不知道**库**的名字,这个时候怎么办呢?很抱歉,对于这个问题我也不知道答案,我只有一个傻办法.首先,我到标准**库**路径下面去找看看有没有和我用的函数相关的**库**,我就这样找到了线程(thread)函数的**库**文件(libpthread.a). 当然,如果找不到,只有一个笨方法.比如我要找sin这个函数所在的**库**. 就只好用 nm -o /lib/*.so|grep sin>~/sin 命令,然后看~/sin文件,到那里面去找了. 在sin文件当中,我会找到这样的一行libm-2.1.2.so:00009fa0 W sin 这样我就知道了sin在libm-2.1.2.so**库**里面,我用 -lm选项就可以了(去掉前面的lib和后面的版本标志,就剩下m了所以是 -lm). 如果你知道怎么找,请赶快告诉我,我回非常感激的.谢谢!

3、**程序的**调试 
    我们编写的程序不太可能一次性就会成功的,在我们的程序当中,会出现许许多多我们想不到的错误,这个时候我们就要对我们的程序进行调试了.最常用的调试软件是gdb.如果你想在图形界面下调试程序,那么你现在可以选择xxgdb.记得要在编译的时候加入-g选项.关于gdb的使用可以看gdb的帮助文件.由于我很少使用这个软件,所以我也不能够详细的说出如何使用. 不过我不喜欢用gdb.跟踪一个程序是很烦的事情,我一般用在程序当中输出中间变量的值来调试**程序的**.当然你可以选择自己的办法,没有必要去学别人的.现在有了许多IDE环境,里面已经自己带了调试器了.你可以选择几个试一试找出自己喜欢的一个用.

4、头文件和系统求助 
    有时候我们只知道一个函数的大概形式,不记得确切的表达式,或者是不记得着函数在那个头文件进行了说明.这个时候我们可以求助系统.比如说我们想知道fread这个函数的确切形式,我们只要执行 man fread 系统就会输出着函数的详细解释的.和这个函数所在的头文件说明了. 如果我们要write这个函数的说明,当我们执行man write时,输出的结果却不是我们所需要的. 因为我们要的是write这个函数的说明,可是出来的却是write这个命令的说明.为了得到write的函数说明我们要用 man 2 write. 2表示我们用的write这个函数是系统调用函数,还有一个我们常用的是3表示函数是**C**的**库**函数.


三、简单Makefile文件的编写

1、Makefile文件的一般组成
(1)注释：
    在Makefile中，任何以"#"起始的文字都是注释，**make**在解释Makefile的时候会忽略它们.
(2)转接下行标志：
    在Makefile中，若一行不足以容纳该命令的时候.可在此行之后加一个反斜线(\)表示下一行为本行的延续
   ，两行应视为一行处理
(3)宏(macro)
    宏的格式为： = 
    例如：
                CFLAGS = -O -systype bsd43
    其实**make**本身已有许多的default的macro，如果要查看这些macro的话，可以用**make** -p的命令.
    宏主要是作为运行**make**时的一些环境变量的设置，比如制定编译器等。
    CC 表示我们的编译器名称,缺省值为cc. 
    CFLAGS 表示我们想给编译器的编译选项 
    LDLIBS 表示我们的在编译的时候编译器的连接**库**选项.(我们的这个程序中还用不到这个选项)
(4)规则(Rules)
    格式如下：
        : 
                
                
                ....
        : 
                
                
                ....
    注意:需要顶格写,而需要在下一行tab之后写,由于其是一个批处理形式的文件,所以不
         可以随便的换行写,被迫换行的时候要用上面的转接下行标志进行连接.            
(5)符号标志及缺省规则
   $@ 代指目标文件
   $< 第一个依赖文件
   $^ 所有的依赖文件
   $? 为该规则的依赖
   \-   若在command的前面加一个"-"，表示若此command发生错误不予理会，继续执行下去.
   $(macro) 应用这个变量，可以自动的将定义的宏加以展开，并替换使用。
   .**c**.o: 
      gcc -**c** $<   这个规则表示所有的 .o文件都是依赖与其相应的.**c**文件的.例如mytool.o依赖于mytool.**c**
   再一次简化后的Makefile 
    main:main.o mytool1.o mytool2.o 
         gcc -o $@ $^ 
    .**c**.o: 
         gcc -**c** $< -I.; 
    使用宏后进一步的简化Makefile可以是 
    CC=gcc 
    CFLAGS=-g -Wall -O2 -I. 
    main:main.o mytool1.o mytool2.o 
    .**c**.o:

2、依赖
    我们现在提出这样一个问题：我如何用一个**make**命令将替代所有的**make** all， **make** install，**make** clean命令呢？当然我们可以象刚才那样写一个Makefile文件：
all:
        @echo you have typed command "**make** all"
clean:
        @echo you have typed command "**make** clean"
install:
        @ehco you have typed command "**make** $@"
doall:
        @echo you have typed command "**make** [$@l](mailto:$@l)"
        @echo you have typed command "**make** all"
        @echo you have typed command "**make** clean"
        @ehco you have typed command "**make** install"
[root@xxx test]#**make** doall
you have typed command "**make** doall"
you have typed command "**make** all"
you have typed command "**make** clean"
you have typed command "**make** install"
    在这里，doall:目标有4调语句，他们都是连在一起并都是由tab键开始的.当然，这样能够完成任务，但是太笨了，我们这样来写：
[root@xxx test]#cat Makefile
\# ＃表示Makefile文件中的注释，下面是Makefile文件的具体内容
all:
        @echo you have typed command "**make** all"
clean:
        @echo you have typed command "**make** clean"
install:
        @ehco you have typed command "**make** $@"
doall: all clean install
        @echo you have typed command "**make** [$@l](mailto:$@l)"
    相信大家已经看清了doall:的运行方式，它先运行all目标，然后运行clean目标，然后是install，最后是自己本身的目标，并且每个$@还是保持着各自的目标名称.效果大致是一样的。在这里，我们称all, clean, install为目标doall所依赖的目标，简称为doall的依赖.也就是你要执行doall，请先执行他们（all, clean, install），最后在执行我的代码.
    注意依赖一定是Makefile里面的目标，否则你非要运行；一般写在最前边，而不是像这样写在最后边。

3、Makefile的编写 
   在Makefile中，一般采用引导的注释行开始；下边一般紧跟macro定义；接下来是标签（如上面的all、clean等）；最后就是Makefile中最重要的是描述文件的依赖关系的说明.一般的格式是: 
   \#describe
   macro
   label： label1,label2
   label1:
   : 
                
                
   label2:
   : 
                
                
   ...... 
    
我们来看一个例子：
   /* main.**c** */ 
\#include 
\#include 
int main(int argc,char **argv) 
{ 
mytool1_print("hello"); 
mytool2_print("hello"); 
}

/* mytool1.h */ 
\#ifndef _MYTOOL_1_H 
\#define _MYTOOL_1_H 
void mytool1_print(char *print_str); 
\#endif

/* mytool1.**c** */ 
\#include 
void mytool1_print(char *print_str) 
{ 
printf("This is mytool1 print %s\n",print_str); 
}

/* mytool2.h */ 
\#ifndef _MYTOOL_2_H 
\#define _MYTOOL_2_H 
void mytool2_print(char *print_str); 
\#endif

/* mytool2.**c** */ 
\#include 
void mytool2_print(char *print_str) 
{ 
printf("This is mytool2 print %s\n",print_str); 
} 
    因为我们在程序中使用了我们自己的2个头文件,而在包含这2个头文件的时候,我们使用的是<> 这样编译器在编译的时候会去系统默认的头文件路径找我们的2个头文件,由于我们的2个头文件不在系统能够的缺省路径下面,所以我们自己扩展系统的缺省路径,为此我们使用了-I.选项,表示将系统缺省的头文件路径扩展到当前路径.这样的话我们也可以产生main程序,而且也不是很麻烦.但是考虑一下如果有一天我们修改了其中的一个文件(比如说mytool1.**c**)那么我们难道还要重新逐一编译?也许你会说,这个很容易解决啊,我写一个SHELL脚本,让她帮我去完成不就可以了.但是当我们把事情想的更复杂一点,如果我们的程序有几百个源**程序的**时候,难道也要编译器重新一个一个的去编译? 为此,聪明的程序员们想出了一个很好的工具来做这件事情,这就是**make**.我们只要执行一下**make**,就可以把上面的问题解决掉.在我们执行**make**之前,我们要先编写一个非常重要的文件.--Makefile.对于上面的那个程序来说,可能的一个Makefile的文件是: 
\# 这是上面那个**程序的**Makefile文件 
main:main.o mytool1.o mytool2.o 
gcc -o main main.o mytool1.o mytool2.o 
main.o:main.**c** mytool1.h mytool2.h 
gcc -**c** main.**c** -I. 
mytool1.o:mytool1.**c** mytool1.h 
gcc -**c** mytool1.**c** -I. 
mytool2.o:mytool2.**c** mytool2.h 
gcc -**c** mytool2.**c** -I. 
    有了这个Makefile文件,不管我们什么时候修改了源程序当中的什么文件,我们只要执行**make**命令,我们的编译器都只会去编译和我们修改的文件有关的文件,其它的文件她连理都不想去理的.


四、实例
1、实例一
一个非常简单的Makefile
   假设我们有一个程式，共分为下面的部份：
   menu.**c**       主要的程式码部份
   menu.h       menu.**c**的include **file**
   utils.**c**      提供menu.**c**呼叫的一些function calls
   utils.h      utils.**c**的include **file**
   同时本程式亦叫用了ncurses的function calls.
   而menu.**c**和utils.**c**皆放在/usr/src/menu下.
   但menu.h和utils.h却放在/usr/src/menu/include下.
   而程式做完之后，执行档名为menu且要放在/usr/bin下面.
\# This is the Makefile of menu
CC = gcc
CFLAGS = -DDEBUG -**c**
LIBS = -lncurses
INCLUDE = -I/usr/src/menu/include

all: clean install
install: menu
        chmod 750 menu
        cp menu /usr/bin
menu: menu.o
        $(CC) -o $@ $? $(LIBS)
menu.o:
        $(CC) $(CFLAGS) -o $@ menu.**c** $(INCLUDE)
utils.o:
        $(CC) $(CFLAGS) -o $@ utils.**c** $(INCLUDE)
clean:
        -rm *.o
        -rm *~

在上述的Makefile中，要使用某个macro可用$(macro_name)如此的形式.**make**会自动的加以展开.
$@为该rule的Target，而$?则为该rule的depend.
若在command的前面加一个"-"，表示若此command发生错误则不予理会，继续执行下去.
上述的Makefile的关系可以表示如下：
                        all
                        / \
                   clean   install
                               \
                               menu
                              /    \
                          menu.o    utils.o

若只想清除source以外的档案，可以打**make** clean；若只想做出menu.o可以打**make** menu.o；若想一次全部做完，可以打**make** all或是**make**；要特别注意的是command之前一定要有一个TAB(即TAB键).

2、实例二
有了上面的说明，我们就可以开始写一些简单的Makefile文件了.比如我们有如下结构的文件：
tmp/
   +---- include/
   |      +---- f1.h
   |      +----f2.h
   +----f1.**c**    #include "include/f1.h"
   +----f2.**c**    #include"include/f2.h"
   +---main.**c**   #include"include/f1.h", #include"include/f2.h"
要将他们联合起来编译为目标为testmf的文件，我们就可以按下面的方式写Makefile：
\#Makefile，Create testmf from f1.**c** f2.**c** main.**c**
main: main.o f1.o f2.o
        gcc -o testmf main.o f1.o f2.o
f1.o: f1.**c**
        gcc -**c** -o **file**1.o **file**1.**c**
f2.o: f2.**c**
        gcc -**c** -o **file**2.o **file**2.**c**
main.o
        gcc -**c** -o main.o main.**c**
clean:
        rm -rf f1.o f2.o main.o testmf
执行这个Makefile文件
[root@xxx test]**make**
gcc -**c** -o main.o main.**c**
gcc -**c** -o **file**1.o **file**1.**c**
gcc -**c** -o **file**2.o **file**2.**c**
gcc -o testmf main.o f1.o f2.o
[root@xxx test]ls
f1.**c** f1.o f2.**c** f2.o main.**c** main.o include/ testmf
如果你的程序没有问题的话，就应该可以执行了./testmf
    这是一个很简单的例子,但复杂的例子都是构建在简单功能基础上的.后面将继续介绍详细的makefile的编写方法。
    
参考连接地址：
   <http://bbs.ee.ntu.edu.tw/boards/Programming/17/12.html>
   <http://www.linuxeden.com/forum/blog/index.php?op=ViewArticle&blogId=102509&articleId=341>
   [http://www.douzhe.com/bbs/viewtopic.php?t=376&highlight=**make**](http://www.douzhe.com/bbs/viewtopic.php?t=376&highlight=make)



分类: [Linux](https://www.cnblogs.com/jasonliu/category/330763.html)

