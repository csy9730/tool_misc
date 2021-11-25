# Tcl简介（一）：Tcl 语法

## Tcl 语法

Tcl是一种很通用的脚本语言，它几乎在所有的平台上都可以释运行，其强大的功能和简单精妙的语法会使你感到由衷的喜悦，这片文章对 Tcl有很好的描述和说明。如果你看起来很吃力，那是因为 Tcl与一般的语言有一些不同之处，刚开始可能有一些不理解，但很快就会掌握的。请坚持一下,我能坚持写完，你至少也应该坚持读一遍吧！

## Tcl Overview

这篇文章里包含了几乎 Tcl 的全部。文章的作者是Tcl的缔造者John Ousterhout，对Tcl的诠释非常清楚。

Introduction 简介

Tcl 代表 "tool command language" 发音为 "tickle." 。它实际上包含了两个部分：一个语言和一个库。

首先，Tcl是一种简单的脚本语言，主要使用于发布命令给一些互交程序如文本编辑器、调试器和shell。它有一个简单的语法和很强可扩充性，Tcl可以创建新的过程以增强其内建命令的能力。

其次，Tcl是一个库包，可以被嵌入应用程序，Tcl的库包含了一个分析器、用于执行内建命令的例程和可以使你扩充（定义新的过程）的库函数。应用程序可以产生Tcl命令并执行，命令可以由用户产生，也可以从用户接口的一个输入中读取（按钮或菜单等）。但Tcl库收到命令后将它分解并执行内建的命令，经常会产生递归的调用。

应用程序使用Tcl作为它的命令语言有三个好处：
1 Tcl提供了标准语法，一旦用户掌握了Tcl就可以很容易的发布命令给基于Tcl的程序。
2 Tcl实现了很多的功能，使你的工作变得很方便。
3 TCl可作为程序间通信的接口。

### Tcl Interpreters 解释器

在Tcl的数据结构中的核心是Tcl_Interp.一个解释器包含了一套命令，一组变量和一些用于描述状态的东西。每一个 Tcl命令是在特定的Tcl_Interp中运行的,基于Tcl的应用程序可以同时拥有几个Tcl_Interp。Tcl_Interp是一个轻量级的结构，可以快速的新建和删除。

Tcl Data Types 数据类型

Tcl只支持一种数据结构：字符串（string）。所有的命令，命令的所有的参数，命令的结果，所有的变量都是字符串。请牢记这一点，所有的东西都是字符串。

然而字符串的实际解释是依赖于上下文或命令的。它有三种形式：命令(command), 表达式(expresion)和表(list)。下面会讨论细节。

### Basic Command Syntax 基本语法

Tcl有类似于shell和lisp的语法，当然也有许多的不同。一条Tcl的命令串包含了一条或多条命令用换行符或分号来隔开，而每一条命令包含了一个域(field)的集合，域使用空白分开的，第一个域是一个命令的名字，其它的是作为参数来传给它。

例如：
set a 22 //相当于C中的 a=22 a是一个变量这条命令分为三个域：1： set 2： a 3： 22
set使用于设置变量的值的命令，a、20 作为参数来传给它，a使它要操作的变量名，22是要付给的a值。

Tcl的命令名可以使内建的命令也可以是用户建的新命令，在应用程序中用函数Tcl_CreateCommand来创建。所有的参数作为字符串来传递，命令自己会按其所需来解释的参数的。命令的名字必须被打全，但 Tcl解释器找不到一同名的命令时会用 unknown命令
来代替。

在很多场合下，unknown 会在库目录中搜寻，找到一个的话，会自动生成一个Tcl命令并调用它。unknown经常完成缩略的命令名的执行。但最好不要使用。

Comments 注释

和shell很象，第一个字母是'#'的Tcl字符串是注释。

Grouping arguments with double-quotes 用双引号来集群参数用双引号来集群参数的目的在于使用有空白的参数。
例如： 
set a "this string contains whitespace"
如够一个参数一双引号来开始，该参数会一直到下一个双引号才结束。其中可以有换行符和分号。

子替换是在正式运行该调命令之前由分析器作的

Variable substitution with $ 用美元符进行变量替换说白了就是引用该变量。
如：
set a hello
set b $a // b = "hello" 实际上传给set命令的参数
//是b,"hello"
set c a // b = "a"

Command substitution with brackets 命令子替换（用方括号）

例如:
set a [set b "hello"]
实现执行 set b "hello" 并用其结果来替换源命令
中的方括号部分，产生一条新命令
set a "hello" //"hello" 为 set b "hello" 的返
　//回值
最终的结果是b="hello" a="hello"

当命令的一个子域以方括号开始以方括号结束，表示要进行一个命令子替换。并执行该子命令，用其结果来替换原命令中的方括号部分。方括号中的部分都被视为Tcl命令。

一个复杂一点的例子：
set a xyz[set b "abc"].[set c "def"]
//return xyzabcdef

Backslash substitution 转移符替换

转移符时间不可打印字符或由它数意义的字符插入进来。这一概念与C语言中的一样。

\b Backspace (0x8).

\f Form feed (0xc).

\n Newline (0xa).

\r Carriage-return (0xd).

\t Tab (0x9).

\v Vertical tab (0xb).

\{ Left brace (`{').

\} Right brace (`}').

\[ Open bracket (`[').

\] Close bracket (`]').

\$ Dollar sign (`$').

\sp Space (` '): does not terminate argument.

\; Semicolon: does not terminate command.

\" Double-quote.

Grouping arguments with braces 用花扩括号来集群参数

用花扩括号来集群参数与用双引号来集群参数的区别在于：用花扩括号来集群参数其中的三种上述的子替换不被执行。而且可以嵌套。

例如： 
set a {xyz a {b c d}}//set收到俩个参数 a 'xyz a {b 
//c d}'

eval {
set a 22
set b 33
}//eval收到一个参数 'set a 22\nset b 33'


### Command summary 命令综述

1.一个命令就是一个字符串（string）。

2.命令是用换行符或分号来分隔的。

3.一个命令由许多的域组成。第一个于是命令名，其它的域作为参数来传递。

4.域通常是有空白（Tab横向制表健 Space空格）来分开的。

5.双引号可以使一个参数包括换行符或分号。三种子替换仍然发生。

6.花括号类似于双引号，只是不进行三总体换。

7.系统只进行一层子替换，机制替换的结果不会再去做子替换。而且子替换可以在任何一个域进行。

8.如果第一个非控字符是`#', 这一行的所有东西都是注释。

Expressions 表达式

对字符串的一种解释是表达式。几个命令将其参数按表达式处理，如：expr、for 和 if,并调用Tcl表达式处理器(Tcl_ExprLong,Tcl_ExprBoolean等)来处理它们。其中的运算符与C语言的很相似。

!
逻辑非

\* / % + -

<< >> 
左移 右移 只能用于整数。

< > <= >= == != 
逻辑比较

& ^ |
位运算 和 异或 或

&& || 
逻辑'和' '或'

x ? y : z 
If-then-else 与C的一样

Tcl 中的逻辑真为1，逻辑假为0。

一些例子：

5 / 4.0
5 / ( [string length "abcd"] + 0.0 )
---------------------- ---
计算字符串的长度 转化为浮点数来计算

"0x03" > "2"
"0y" < "0x12"
都返回 1

set a 1
expr $a+2

expr 1+2
都返回 3

Lists 列表

字符串的另一种解释为列表。一个列表是类似于结果的一个字符串包含了用空白分开的很多域。例如 "Al Sue Anne John" 是一个有四个元素的例表，在列表中换行父被视为分隔符。

例如：
b c {d e {f g h}} 是一个有三个元素的列表 b 、c 和 {d e {f g h}}。

Tcl的命令 concat, foreach, lappend, lindex, linsert,list , llength, lrange,lreplace, lsearch, 和 lsort 可以使你对列表操作。

Regular expressions 正则表达式

Tcl 提供了两个用于正则表达式的命令 regexp 和 regsub。
这里的正则表导师实际上是扩展的正则表达式，与 egrep 相一致。

支持 ^ $ . + ? \> \< () | []

Command results 命令结果

每一条命令有俩个结果：一个退出值和一个字符串。退出值标志着命令是否正确执行，字符串给出附加信息。
有效的返回制定议在`tcl.h'， 如下：

TCL_OK
命令正确执行，字符串给出了命令的返回值。

TCL_ERROR 
表示有一个错误发生，字符串给出了错误的描述。全局变量 errorInfo 包含了人类可读的错误描述，全局变量errorCode 机器使用的错误信息。

TCL_RETURN 
表示 return 命令被调用，当前的命令（通常是一个函数）必须立刻返回，字符串包含了返回值。

TCL_BREAK 
表示break已经被调用，最近的巡环必须立刻返回并跳出。字符串应该是空的。

TCL_CONTINUE 
表示continue已经被调用，最近的巡环必须立刻返回不跳出。字符串应该是空的。

Tcl编程者一般需要关心退出值。当Tcl解释器发现错误发生后会立刻停止执行。

Procedures 函数

Tcl 允许你通过proc命令来扩充命令（定义新的命令），定义之后可以向其它的内建命令一样使用。
例如：
proc pf {str} {
puts $str
}

pf "hello world"
这里有一个初学者不注意的地方，上述的定义一定要写成那样子。而不能向下面那样写：
proc pf {str} 
{
puts $str
}
因为proc实际上也只不过是一条命令，是一换行符或分号来结束的，用集群参数来传递函数体。proc的定义如下：
proc name args tclcommand

Variables: scalars and arrays 变量：标量和向量（即数组）

向量就是数组，而标量是没有下表的变量。
我们用C来类比：
int i； // i 是标量
int j[10]； // j 是向量

变量不需要定义，使用的时候会自动的被创建。Tcl支持两种
变量：标量和向量
举个例子来说明吧，
set i 100
set j(0) 10
set k(1,3) 20
i是标量，j是向量。
引用的时候：
$i
$j(0)
$k(1,3)

Tcl简介（二）：Tcl 内建命令

Tcl 内建命令

Built-in commands 内建的命令

Tcl提供了下面描述的内建函数。
... 表示参数不定

append varName value 
append varName value value value ... 
将那一大堆value附加到varName后面。如果变量不存在，会新
建一个。
例子：
set i "aaa"
append i "bbb" "ccc"
//i = aaabbbccc


array subcommand arrayName 
array subcommand arrayName arg ... 
这是一组用于向量操作的命令。第二个参数是子命令名。

假设：
set a(1) 1111
set a(2) 2222
set a(three) 3333
一下均以它为例子(tclsh在中运行）。

array names arrayName 
返回一个数组元素名字的列表。
tclsh>array names a
1 2 three

array size arrayName 
返回数组的元素个数。
tclsh>array size a
3

下面是用于遍历的命令
arrry startsearch arrayName
初始化一次遍历，返回一个遍历标示(searchId)在下面的命令
是中使用。

array nextelement arrayName searchId
返回下一个数组中的元素。如果没有返回一个空串。

array anymore arrayName searchId 
返回 1 表示还有更多的元素。0 表示没有了。

array donesearch arrayName searchId 
结束该次遍历。

array nextelement arrayName searchId 
返回下一个元素。

tclsh>array startsearch a
s-1-a
tclsh>array nextelement a s-1-a
1111
tclsh>array nextelement a s-1-a
2222
tclsh>array anymore a s-1-a
1
tclsh?array nextelement a s-1-a
3333
tclsh>array donesearch a s-1-a

注意可以同时并发多个遍历。

break
跳出最近的循环。

case string in patList body ... 
case string patList body ... 
case string in {patList body ...} 
case string {patList body ...} 
分支跳转。
例如：
case abc in {a b} {puts 1} default {puts 2} a* {puts 3}
return 3.

case a in {
{a b} {format 1}
default {format 2}
a* {format 3}
}
returns 1.

case xyz {
{a b}
{format 1}
default
{format 2}
a*
{format 3}
}
returns 2. 
注意default不可以放在第一位。支持shell文件名风格的匹配
符。

catch command 
catch command varName 
用于阻止由于错误而导致中断执行。执行command, 每次都返
回TCL_OK, 无论是否有错误发生。如有错误发生返回1 ，反之返回0
。如果给了varName这被置为错误信息。注意varName是已经存在的
变量。

cd 
cd dirName 
转换当前工作目录。如dirName未给出则转入home目录。

close fileId 
关闭文件描述符。

concat arg ... 
将参数连接产生一个表。
concat a b {c d e} {f {g h}}
return `a b c d e f {g h}'

continue
结束该次循环并继续循环。

eof fileId
如fileId以结束 返回1，反之返回 0。

error message 
error message info 
error message info code 
返回一个错误，引起解释器停止运行。info用于初始化全局变
量errorInfo。code被付给errorCode。

eval arg ... 
将所有的参数连起来作为命令语句来执行。

exec arg ... 
仿佛是在shell下执行一条命令。
exec ls --color
exec cat /etc/passwd > /tmp/a

exit 
exit returnCode 
中断执行。

expr arg 
处理表达式。
set a [expr 1+1]
//a=2

file subcommand name
一组用于文件处理的命令。
file subcommand name arg ...

file atime name
返回文件的最近存取时间。

file dirname name
返回name所描述的文件名的目录部分。

file executable name
返回文件是否可被执行。

file exists name
返回1 表示文件存在，0 表示文件不存在。

file extension name
返回文件的扩展名。

file isdirectory name
判断是否为目录。

file isfile name 
判断是否为文件。

file lstat name varName
以数组形式返回。执行lstat系统函数。存储在varName。

file mtime name
文件的最近修改时间。

file owned name
判断文件是否属于你。

file readable name
判断文件是否可读。

file readlink name
都出符号连接的真正的文件名。

file rootname name
返回不包括最后一个点的字符串。

file size name 
返回文件的大小。

file stat name varName 
调用stat内和调用，以数组形式存在varName中。

file tail name 
返回最后一个斜线以后的部分。

file type name
返回文件类型file, directory, characterSpecial,
blockSpecial, fifo, link, 或
socket。

file writable name
判断文件是否可写。

flush fileId
立即处理由fileId描述的文件缓冲区。

for start test next body
for循环。同C总的一样。

for {set i 1} {$i < 10} {incr i} {puts $i}

foreach varname list body 
类似于C Shell总的foreach或bash中的for..in...

format formatString 
format formatString arg ...
格式化输出，类似于C中的sprintf。
set a [format "%s %d" hello 100]
//a="hello 100"

gets fileId
gets fileId varName
从文件中读出一行。
set f [open /etc/passwd r]
gets $f

glob filename ...
glob -nocomplain filename ...
使用C Shell风格的文件名通配规则，对filename进行扩展。
ls /tmp
a b c

tclsh>glob /tmp/*
a b c
当加上参数 -nocomplain 时，如文件列表为空则发生一个错
误。

global varname ... 
定义全局变量。

if test trueBody
if test trueBody falseBody
if test then trueBody
if test then trueBody else falseBody
条件判断，是在没什么说的。

incr varName
incr varName increment
如果没有incremnet，将varName加一，反之将varName加
上increment。

set i 10
incr i
//i=11
incr i 10
//i=21

info subcommand 
info subcommand arg ... 
取得当前的Tcl解释器的状态信息。

info args procname
返回由procname指定的命令(你自己创建的）的参数列表。
如：
proc ff { a b c } {puts haha}
info args ff
//return "a b c"　

info body procname 
返回由procname指定的命令(你自己创建的）的函数体。
如：
proc ff { a b c } {puts haha}
info body ff
//return "puts haha"　

info cmdcount 
返回当前的解释器已经执行的命令的个数。

info commands 
info commands pattern 
如果不给出模式，返回所有的命令的列表，内建和自建的。
模式是用C Shell匹配风格写成的。

info complete command 
检查名是否完全，有无错误。

info default procname arg varname 
procname的参数arg，是否有缺省值。

info exists varName 
判断是否存在该变量。

info globals 
info globals pattern 
返回全局变量的列表，模式同样是用C Shell风格写成的。

info hostname
返回主机名。

info level 
info level number 
如果不给参数number则返回当前的在栈中的绝对位置，参
见uplevel中的描述。如加了参数number，则返回一个列表包
含了在该level上的命令名和参数。

info library 
返回标准的Tcl脚本的可的路径。实际上是存在变量
tcl_library中。

info locals 
info locals pattern 
返回locale列表。

info procs
info procs pattern
返回所有的过程的列表。

info script 
返回最里面的脚本（用 source 来执行）的文件名。

info tclversion 
返回Tcl的版本号。

info vars 
info vars pattern 
返回当前可见的变量名的列表。

下面是一些用于列表的命令，范围可以是end。

join list 
join list joinString 
将列表的内容连成一个字符串。

lappend varName value ... 
将value加入列表varName中。

lindex list index 
将list视为一个列表，返回其中第index个。列表中的第一个
元素下标是0。
lindex "000 111 222" 1
111

linsert list index element ... 
在列表中的index前插入element。

list arg ... 
将所有的参数发在一起产生一个列表。
list friday [exec ls] [exec cat /etc/passwd]

llength list
返回列表中元素的个数。
set l [list sdfj sdfjhsdf sdkfj]
llength $l
//return 3

lrange list first last
返回列表中从frist到last之间的所有元素。
set l [list 000 111 222 333 444 555]
lrange $l 3 end
//return 333 444 555

lreplace list first last
lreplace list first last element ...
替换列表中的从first到last的元素，用element。
set l [list 000 111 222 333 444 555]
lreplace $l 1 2 dklfj sdfsdf dsfjh jdsf
000 dklfj sdfsdf dsfjh jdsf 333 444 555

lsearch -mode list pattern
在列表中搜索pattern，成功返回序号，找不到返回-1。
-mode : -exact 精确
-glob shell的通配符
-regexp 正则表达式

lsearch "111 222 333 444" 111
//return 0
lsearch "111 222 333 444" uwe
//return 1

lsort -mode list
排列列表。
-mode : -ascii
-dictionary 与acsii类似，只是不区分大小写
-integer 转化为整数再比较
-real 转化为浮点数再比较
-command command 执行command来做比较

open fileName
open fileName access
打开文件，返回一个文件描述符。
access
r w a r+ w+ a+
定义与C中相同。如文件名的第一个字符为|表示一管道的形式
来打开。
set f [open |more w]
set f [open /etc/pass r]

proc name args body
创建一个新的过程，可以替代任何存在的过程或命令。

proc wf {file str} {
puts -nonewline $file str
flush $file
}

set f [open /tmp/a w]
wf $f "first line\n"
wf $f "second line\n"
在函数末尾可用 return 来返回值。

puts -nonewline fileId string
向fileId中写入string，如果不加上 -nonewline 则自动产
生一个换行符。

pwd
返回当前目录。

read fileId 
read fileId numBytes
从fileId中读取numBytes个字节。

regexp ?switches? exp string ?matchVar? ?subMatchVar
subMatchVar ...?
执行正则表达式的匹配。
?switches? -nocase 不区分大小写
-indices 返回匹配区间
如：
regexp ^abc abcjsdfh
//return 1
regexp ^abc abcjsdfh a
//return 1
puts $a
//return abc

regexp -indices ^abc abcsdfjkhsdf a
//return 1
puts $a
//return "0 2"


regsub ?switchs? exp string subSpec varName
执行正则表达式的替换,用subSpec的内容替换string中匹配exp
的部分。
?switchs? -all 将所有匹配的部分替换，缺省子替换第一
个，返回值为替换的个数。
-nocase 不区分大小写。
如：
regsub abc abcabcbac eee b
//return 1
puts $b
//return "eeeabcabc"

regsub -all abc abcabcabc eee b
//return 3
puts $b
//return "eeeeeeeee"


return
立即从当前命令中返回。
proc ff {} {
return friday
}

set a [ff]
//a = "friday"

scan string `format' varname ... 
从string中安format来读取值到varname。

seek fileId offset ?origin?
移动文件指针。
origin: start current end
offset从哪里开始算起。

set varname ?value?
设置varname用value，或返回varname的值。如果不是在一
个proc命令中则生成一个全局变量。

source fileName 
从filename中读出内容传给Tcl解释起来执行。

split string ?splitChars?
将string分裂成列表。缺省以空白为分隔符，也可通
过splitChars来设定分隔符

string subcommand arg ... 
用于字符串的命令。

string compare string1 string2 
执行字符串的比较，按 C strcmp 的方式。返回 -1, 0, or 1。

string first string1 string2 
在string1种查找string2的定义次出现的位置。未找到返回-1。

string length string 
返回字符串string的长度。

string match pattern string 
判断string是否能匹配pattern。pattern是以shell文件名的
统配格式来给出。

string range string first last
返回字符串string中从first到last之间的内容。

string tolower string
将string转换为小写。

string toupper string
将string转换为大写。

string trim string 
将string的左右空白去掉。

string trimleft string
将string的左空白去掉。

string trimright string
将string的右空白去掉。

tell fileId
返回fileId的文件指针位置。

time command
执行命令，并计算所消耗的时间。
time "ls --color"
some file name
503 microseconds per iteration

trace subcommand 
trace subcommand arg ... 
监视变量的存储。子命令定义了不少，但目前只实现了
virable。
trace variable name ops command
name 为变量的名字。
ops 为要监视的操作。
r 读 
w 写 
u unset
command 条件满足时执行的命令。
以三个参数来执行 name1 name2 ops
name1时变量的名字。当name1为矢量时，name2为下标，ops
为执行的操作。

例如：
proc ff {name1 name2 op} {
puts [format "%s %s %s" name1 name2 op]
}
set a hhh
trace variable a r {ff}
puts $a
//return "a r\nhhh"

unknown cmdName
unknown 并不是 Tcl 的一部分，当 Tcl 发现一条不认识的命
令时会看看是否存在 unknown命令，如果有，则调用它，没有则出
错。

如：
\#!/usr/bin/tclsh
proc unknown {cwd args} {
puts $cwd
puts $args
}
//下面是一条错误命令
sdfdf sdf sdkhf sdjkfhkasdf jksdhfk
//return "sdfdf sdf sdkhf sdjkfhkasdf jksdhfk"

unset name ... 
删除一个或多个变量（标量或矢量）。

uplevel command ...
将起参数连接起来（象是在concat中）。最后在由level所指
定的上下文中来执行。如果level是一个整数，给出了在栈中的距
离（是跳到其它的命令环境中来执行）。
缺省为1（即上一层）。
如：

```tcl
#!/usr/bin/tcl
proc ff {} {
set a "ff" //设置了局部的a
\-------------------------
}
set a "global"
ff
puts $a
//return "global"
```





再看下一个：

```tcl
#!/usr/bin/tcl
proc ff {} {
uplevel set a "ff" //改变上一级栈中的a
\-------------------------------------
}
set a global
ff
puts $a
//return "ff"
```



如果level是以#开头后接一个整数，则level指出了在栈中的
绝对位置。如#0表示了顶层（top-level）。
a b c 分别为三个命令，下面是它们之间的调用关系，
top-level -> a -> b -> c -> uplevel level
绝对位置： 0 1 2 3 
当level为 1 或 #2 都是在 b 的环境中来执行。
3 或 #0 都是在 top-level 的环境中来执行。

upvar ?level? otherVar myVar ?otherVar myVar ...?
在不同的栈中为变量建立连接。这里的level与uplevel中
的level是同样风格的。
例如：
\#!/usr/bin/tcl
proc ff {name } {
upvar $name x
set x "ff"
}
set a "global"
ff a
puts $a
//return "ff"

while test body
举个例子吧：
set x 0
while {$x<10} {
puts "x is $x"
incr x
}

### Built-in variables 内建的变量
下名的全局变量是由 Tcl library 自动来管理的。一般是只
读的。

env
环境变量数组。
如：
puts $env(PATH)
// return /bin:/usr/bin:/usr/X11R6/bin

errorCode
当错误发生时保存了一些错误信息。用下列格式来存储：
CHILDKILLED pid sigName msg
当由于一个信号而被终止时的信息。
CHILDSTATUS pid code
当一个子程序以非0值退出时的格式。
CHILDSUSP pid sigName msg
当一个子程序由于一个信号而被终止时的格式。
NONE
错误没有附加信息。
UNIX errName msg
当一个内核调用发生错误时使用的格式。

errorInfo
包含了一行或多行的信息，描述了错误发生处的程序和信息。

原文的作者也是Tcl的缔造者 John Ousterhout

## Tcl简介（三）：Tcl 内建命令

Tcl 名字空间

namespace
创建和操纵命令和变量的上下文(content)。

简介： 
一个名字空间是一个命令和变量的集合，通过名字空间的封装来
保证他们不会影响其它名字空间的变量和命令。 Tcl 总是维护了一
个全局名字空间 global namespace 包含了所有的全局变量和命令。

namespace eval允许你创建一个新的namespace。
例如：

```tcl
namespace eval Counter {
namespace export Bump
variable num 0

proc Bump {} {
variable num//声明局部变量
incr num
}
}
```




名字空间是动态的，可变的。
例如：
namespace eval Counter {
variable num 0//初始化
proc Bump {} {
variable num
return [incr num]
}
}

//添加了一个过程
namespace eval Counter {
proc test {args} {
return $args
}
}

//删除test
namespace eval Counter {
rename test ""
}
引用：
set Counter::num
//return 0
也可以用下面的方式添加：
proc Foo::Test {args} {return $args}
或在名字空间中移动：
rename Foo::Test Bar::Test

 

本文来自CSDN博客，转载请标明出处：<http://blog.csdn.net/danforn/archive/2007/06/25/1665930.aspx>