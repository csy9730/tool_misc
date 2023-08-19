# Linux 技巧：Bash的测试和比较函数（探密test，[，[[，((和if-then-else）

<http://article.yeeyan.org/view/wangxiaoyu/58410>

**概述：**你有没有为Bash中太多的测试和比较选项而困惑呢？这则技巧可以帮助你深刻理解多种文件类型、数值和字符串的测试，这样你便会知道什么时候需要用test、[ ]、[[ ]]、(( ))或者是if-then-else结构。

现在，许多 Linux® 和 UNIX® 都有Bash 环境，它往往还是Linux默认的shell环境。Bash拥有强大的程序设计能力，包括各种的测试文件类型的函数和其它特性，比如像大多数程序语言中的数值和字符串的比较一样。

理解各种测试，并且懂得在shell中通过元操作符表达大部分的操作，这些是成为一个强大的shell用户重要的步骤。这篇文章，摘自developerWorks tutorial [LPI exam 102 prep: Shells, scripting, programming, and compiling](http://www.ibm.com/developerworks/linux/edu/l-dw-linux-lpic1109-i.html?S_TACT=105AGX03&S_CMP=art2tut) ，它指出如何理解和使用bash环境下的测试和比较操作。

这则内容阐述了shell的测试和比较函数，以及如何增加shell的程序设计能力。你可能已经认识了通过 && 和 || 表达简单的shell逻辑，它可以让我们根据前边命令的返回正常或者是错误决定是否执行后边的命令。在本文中，你将会认识到如何把这些基本的测试操作扩充成更复杂的shell程序。

在许多程序设计语言中，我们都知道，在定义了变量的值或者是传递参数后，都需要测试这变量的值和参数值。shell环境下的测试命令像其它shell命令一样都会设置返回的状态，实际上，test命令是一个shell内建命令！

shell内建命令test根据表达式 `*expr*` 的运算结果返回０（真）或者是１（假）。你也可以使用`[ ]`，`test *expr*`和`[ *expr* ]`是等价的。你即可以通过变量 `$?` 来测试测试操作的返回值；也可以把返回值直接与 &&、|| 连用；当然后面我们还会涉及到通过多个条件结构来测试返回值。

#### **列表 1. 一些简单的test**

``` bash
[ian@pinguino ~]$ test 3 -gt 4 && echo True || echo false # false
[ian@pinguino ~]$ [ "abc" != "def" ];echo $? # 0
[ian@pinguino ~]$ test -d "$HOME" ;echo $? # 0
```

在列表１的第一个例子中，-gt操作符对两个数值进行算术比较。
在第二个例子中，test的变形 [ ] 则是比较不等式两边的字符串。
在最后一个例子中，是通过一元操作符 -d 来测试变量 HOME 变量的值是否是一个正常的目录。

你可以通过-eq、-ne、-lt、-le、-gt或者是-ge来比较算术值，它们分别表示相等、不相等、小于、小于等于、大于或者是大于等于。

同样你也可以用 = 和 != 比较字符串相等和不等，或者通过 < 或 > 测试第一个字符串是否排在第二个字符串的前边或后边，通过一元操作符 - z测试字符串是否为空，而一元操作符 -n 或不加操作符则当字符串为非空时返回真值。

注意：< 和 > 这两个符号同时也是用来做shell重定向，所以你必须通过 < 和 > 来反转它的意思。列表２给出了更多的字符测试的例子。检验一下是不是你所期望样子。

#### **列表 2. 一些字符串 tests**

``` bash
[ian@pinguino ~]$ test "abc" = "def" ;echo $? # 1
[ian@pinguino ~]$ [ "abc" != "def" ];echo $? # 0
[ian@pinguino ~]$ [ "abc" < "def" ];echo $? # 0
[ian@pinguino ~]$ [ "abc" > "def" ];echo $? # 1
[ian@pinguino ~]$ [ "abc" <"abc" ];echo $? # 1
[ian@pinguino ~]$ [ "abc" > "abc" ];echo $? # 1
```

下面的表１中列出一些更常用的文件测试，如果测试一个文件存在且包匹配指定的特性则返回的结果为真。

| 操作符 | 属性                                    |
| ------ | --------------------------------------- |
| -d     | Directory                               |
| -e     | Exists (also -a)                        |
| -f     | Regular file                            |
| -h     | Symbolic link (also -L)                 |
| -p     | Named pipe                              |
| -r     | Readable by you                         |
| -s     | Not empty                               |
| -S     | Socket                                  |
| -w     | Writable by you                         |
| -N     | Has been modified since last being read |

 除了上面的一元测试以外，，你也可以通过一对操作符来对两个文件进行比较，如表２.

| 操作符号 | 为真的情况                                                   |
| -------- | ------------------------------------------------------------ |
| -nt      | Test if file1 is newer than file 2. The modification date is used for this and the next comparison. |
| -ot      | Test if file1 is older than file 2.                          |
| -ef      | Test if file1 is a hard link to file2.                       |

一些其它的测试还能检查其它信息如文件的权限。想了解更多内容请使用 help test 来查看 man 手册中 shell 内建命令test的小节。你也可以使用 help 命令来查看其它的 shell 内建命令。

-o 这个操作符能让我们测试那些可以通过 set 的 -o *option* 来设定的各种shell选项，如果对应的选项设置了就返回真（１），否则返回假（０），请看列表３.

**列表 3. 测试 shell 选项**

``` bash
[ian@pinguino ~]$ set +o nounset
[ian@pinguino ~]$ [ -o nounset ];echo $? # 1
[ian@pinguino ~]$ set -u
[ian@pinguino ~]$ test  -o nounset; echo $? # 0
```


最后，-a 和 -o 选项分别表示通过逻辑的与（AND）和（OR）把表达式连接起来，一元操作符 -a 则是用来反转一个测试的真值。你甚于可以用括号把表达式分组来改变默认的优先级。要谨记，一般情况下，shell 环境会把括号中的表达式放到子 shell 中去运行，所以你需要通过 ( 和 ) 或者把它俩放到单引号或双引号中来反转它的意思。列表４演示了对一个表达式德摩根定律的应用。

**列表 4. 连接和分组tests**

``` bash
[ian@pinguino ~]$ test "a" != "$HOME" -a 3 -ge 4 ; echo $? # 1
[ian@pinguino ~]$ [ ! ( "a" = "$HOME" -o 3 -lt 4 ) ]; echo $? # 1
[ian@pinguino ~]$ [ ! ( "a" = "$HOME" -o '(' 3 -lt 4 ')' ")" ]; echo $? # 1
```

------

**(( and [[**

虽然test命令功能非常强大，但有些时候也非常笨拙，像需要转义时候或者是需要区别字符串比较和算术比较。所幸的是， bash 环境还包含了另外两种测试方式，这两种方式对于那些熟悉 C、C++、或者是 Java® 语法的朋友会更自然一些。

复合命令 (( )) 计算一个算术表达式的值，并且当运算结果为０时，设置返回的状态为１，运算结果为非０的值时则设置返回状态为０。同时你也不必转义 (( 和 )) 之间的操作符号。支持整数的四则运算。被０除会导致错误，但是不会溢出。你也可以在其中运行usual C形式的算术表达式、逻辑和移位操作。let 命令也可以运行一个或多个算术表达式。它常常用来给算术变量赋值。


#### **列表５. 赋值并测试算术表达式**

``` bash
[ian@pinguino ~]$ let x=2 y=2**3 z=y*3;echo $? $x $y $z0 2 8 24
[ian@pinguino ~]$ (( w=(y/x) + ( (~ ++x) & 0x0f ) )); echo $? $x $y $w0 3 8 16
[ian@pinguino ~]$ (( w=(y/x) + ( (~ ++x) & 0x0f ) )); echo $? $x $y $w0 4 8 13
```

像 (( )) 一样复合命令 [[ ]] 允许你使用更自然的语法对文件或字符串进行测试。你也可以通过括号和逻辑操作符连接多个测试。


#### **列表６.使用复合命令[[**

``` bash
[ian@pinguino ~]$ [[ ( -d "$HOME" ) && ( -w "$HOME" ) ]] &&  >  echo "home is a writable directory"home is a writable directory
```

当使用 = 或 != 时 [[ 复合命令也可以对字符串执行模式匹配，针对通配符的匹配如列表7所示。

#### **列表7. 通过 [[ 做匹配tests**

``` bash
[ian@pinguino ~]$ [[ "abc def .d,x--" == a[abc]* ?d* ]]; echo $?0
[ian@pinguino ~]$ [[ "abc def c" == a[abc]* ?d* ]]; echo $?1
[ian@pinguino ~]$ [[ "abc def d,x" == a[abc]* ?d* ]]; echo $?1
```

你甚至也可以通过 [[ 执行算术操作，但是请谨慎，只有是在 (( 复合命令中，< 和 > 操作符会把字符串作为操作对象测试其对应的次序前后。列表８中通过几个例子做了演示。

**列表８.通过 [[ 做算术测试**

``` bash
[ian@pinguino ~]$ [[ "abc def d,x" == a[abc]* ?d* || (( 3 > 2 )) ]]; echo $?0
[ian@pinguino ~]$ [[ "abc def d,x" == a[abc]* ?d* || 3 -gt 2 ]]; echo $?0
[ian@pinguino ~]$ [[ "abc def d,x" == a[abc]* ?d* || 3 > 2 ]]; echo $?0
[ian@pinguino ~]$ [[ "abc def d,x" == a[abc]* ?d* || a > 2 ]]; echo $?0
[ian@pinguino ~]$ [[ "abc def d,x" == a[abc]* ?d* || a -gt 2 ]]; echo $?-bash: a: unbound variable
```

------

**条件判断**

虽然你可以通过上面的测试和&&、||控制操作符来完成一个大量的程序设计，不过bash环境中还包含了更亲切的“if,then,else”和case语法结构。当你学会了这两种结构之后，你还会学到循环结构，这时你的知识结构才会真正拓展开来。

**if-then-else语句**

bash环境下的if命令是一个复合的命令，它用来测试test语句或者是命令（$?）的返回值，根据其真（０）或者假（非０）来执行不同的分支。虽然上面提到的 test 返回值非０即１，但命令还可能会返回其它的值。关于这点更多内容请到　[LPI exam 102 prep: Shells, scripting, programming, and compiling](http://www.ibm.com/developerworks/linux/edu/l-dw-linux-lpic1109-i.html?S_TACT=105AGX03&S_CMP=art2tut) 。

bash环境下的if命令带一个then子句，这条子句包含一个命令序列，当测试或者是命令的返回值为０时执行。一个或多个可选的子句是elif，每条elif都会附带一个test测试和一条关联一组命令的then子句。最后else和一组命令也是可选的，当if语句中的测试或者是elif语句中的测试都不为真时会执行这组命令，在if-then-else结构的结尾用fi标示结束。

现在来使用一下刚刚学到的吧，你可以创建一个简单的计算器来计算一下算术表达式，如列表９.

**列表 9.用if，then，else来计算表达式**

``` bash
[ian@pinguino ~]$ function mycalc ()> {>   local x>   if [ $# -lt 1 ]; then>     echo "This function evaluates arithmetic for you if you give it some">   elif (( $* )); then>     let x="$*">     echo "$* = $x">   else>     echo "$* = 0 or is not an arithmetic expression">   fi> }
[ian@pinguino ~]$ mycalc 3 + 43 + 4 = 7
[ian@pinguino ~]$ mycalc 3 + 4**33 + 4**3 = 67
[ian@pinguino ~]$ mycalc 3 + (4**3 /2)-bash: syntax error near unexpected token `('
[ian@pinguino ~]$ mycalc 3 + "(4**3 /2)"3 + (4**3 /2) = 35
[ian@pinguino ~]$ mycalc xyzxyz = 0 or is not an arithmetic expression
[ian@pinguino ~]$ mycalc xyz + 3 + "(4**3 /2)" + abcxyz + 3 + (4**3 /2) + abc = 35
```


这个计算器用 loca l那句声明了一个本地变量 x ，它只在 mycalc 函数的范围内有效。let 函数可以有多个选项，像 declare 函数一样，选项与函数的作用也是密切相关联。更多信息请查看bash的man手册，或者通过 help let 获得。

在列表9中看到的，你需要确认如果你的表达式用到了 shell 的元字符像 ( 、 ) 、 * 、 > 和 < ，它们应该被正确地转义。虽然如此，你有了这个按照shell的方式来计算算术的相当方便小巧的计算器。

你可能已经注意到了列表9中的 else 子句以及最后两个例子。正如你看到的，给计算器传递 xyz 它并不会产生错误，但是 xyz 会被计算成 0 。这个函数并没有那么智能能指出最后的那个例子中用了字符值，并提醒用户。你可以用一个字符串的匹配测试 [[  ! ("$*" == *[a-zA-Z]* ]]（或者根据你自己设置适当的形式）来排除表达式中包含拼音字母的情况。但是这会阻止十六进制表示法的使用，因为你使用了 0x0f 来表达十六进制形式的 15 。实际上，shell 环境是允许基数最大到 64 （用 **base#value** 表示），这样你可以合理地使用任意拼音字母，包括 _ 和 @ 作为你的输入。用 0 打头的八进制和用 0x 或 0X 打头的十六进制最常用的进制表达法。列表10列举了一些例子。

**列表 10. 不同基数的运算**

``` bash
[ian@pinguino ~]$ mycalc 015015 = 13
[ian@pinguino ~]$ mycalc 0xff0xff = 255
[ian@pinguino ~]$ mycalc 29#3729#37 = 94
[ian@pinguino ~]$ mycalc 64#1az64#1az = 4771
[ian@pinguino ~]$ mycalc 64#1azA64#1azA = 305380
[ian@pinguino ~]$ mycalc 64#1azA_@64#1azA_@ = 1250840574
[ian@pinguino ~]$ mycalc 64#1az*64**3 + 64#A_@64#1az*64**3 + 64#A_@ = 1250840574
```

这些附加的输入已经走出了这篇文章的范围，用你的这个计算器时请谨慎使用。

elif 语句非常方便，它帮助你在写脚本时简单地实现的缩进。当你看到列表11中通过type命令查看mycalc函数的内容时你可能会惊讶。


**列表 11. 打印mycalc**

``` bash
[ian@pinguino ~]$ type mycalcmycalc is a functionmycalc (){    
    local x;    
    if [ $# -lt 1 ]; 
    then        echo "This function evaluates arithmetic for you if you give it some";    
    else        
        if (( $* )); then            
            let x="$*";            
            echo "$* = $x";        
        else            
            echo "$* = 0 or is not an arithmetic expression";        
        fi;    
    fi
}
```


当然,你可以像列表12中一样通过 $(( *expression* )) 和 echo 命令仅仅利用 shell 做算术。那种方式你不会学会任何与函数有关的东西，但提示你的是，在 (( *expression* )) 或者是 [[ *expression* ]] 中， shell 不会翻译元字符，像 * 等等。


**列表 12. 直接在shell环境中通过(( ))和echo命令运算**

``` bash 
[ian@pinguino ~]$  echo $((3 + (4**3 /2)))35
```
 

[ top](https://www.cnblogs.com/haivey/archive/2012/09/04/2669870.html#a0)

 
