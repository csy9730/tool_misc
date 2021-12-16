## [[拾 得\]pipe和xargs的恩怨情仇](https://www.cnblogs.com/alopex/p/7617674.html)

![img](https://images.unsplash.com/photo-1490598000245-075175152d25?dpr=1&auto=compress,format&fit=crop&w=1500&h=&q=80&cs=tinysrgb&crop=)

　　　　　　　　　　　　　　　　Photo by [Joshua Sortino](https://unsplash.com/photos/71vAb1FXB6g?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText) on [Unsplash](https://unsplash.com/?utm_source=unsplash&utm_medium=referral&utm_content=creditCopyText)

 

坚持知识分享,该文章由Alopex编著, 转载请注明源地址: <http://www.cnblogs.com/alopex/> 

 

**索引**:

- pipe 与 xargs 的用途
- 一个head 例子的引入
- STDIN 与 argument 的关系 
- 对pipe 与 xargs的总结

 

**知识摘要**:

- 能够理解 pipe 和 xargs 的作用

- 可以理解 为什么有了 pipe后我们还需要 xargs

- 对 stdin , argument 和 option 有较为简单的认识

- - 涉及命令 pipe(|) , xargs, head, echo, wc

 

 

相信接触Linux的朋友们,常会用到以下两个命令 pipe(|) 和 xargs.

 

- **pipe 与 xargs 的用途**

pipe (|) :

其用途是, 将前一个命令执行得到的的结果,变为下一个命令的输入. 

我们结合pipe(管道)这个生动的形象,可以这样"合理的"假设: 一个命令就是流水线上的一台机器, 传入的数据是加工的材料,pipe则是流水线上的运输带, 当我们传入一个原料后,机器(命令),将按照我们的意愿(命令的参数)对原料进行加工. 

 

然而基于*inux的哲学, "Make each program do one thing well" -- by Doug McIlroy. 的思想, 我们的机器(命令),只能对原材料(传入的数据)进行一项特定的加工, 假如我希望对加工后的材料再进行二次或多次加工呢? 这时,我们就需要一条传输带(pipe), 将我们毛加工后的材料送往需要二次加工的机器上

 

xargs : 

其用途是从标准输入中"重构"和执行命令.

基于pipe上面流水线的比喻, xargs 我们可将其看作是流水线中的一台机器 (但这台机器有点特殊)

首先,像 grep, sed, awk 这些机器(命令)一般都能接收来自 pipe这个传输带送过来的毛加工材料, 但是如果命令是cp ,  echo 等机器(命令), 却不能接收这些加工材料,轻则无视它,严重的直接(罢工)报错.这个时候就需要 xargs 这台机器(命令)先对材料进行合适的加工,再交给这些挑剔的机器(命令)

其此, 在大多数Linux kernel(可使用命令 $ uname  -r 查看 )为2.6.23之前的版本, 普遍无法执行大参数过长的命令. 这时借用xargs, 就能很好地规避这个问题, 实现命令的畅通执行.

 

到这,善于思考的你,可能就会有这样一个疑问,是什么造成毛加工(命令的输出) 后的产品,得某些机器(命令)必须要让xargs协助他们才能继续工作呢?

 

------

- **一个head命令的例子引入**

我们先不忙着立刻去解答,先引出一个例子 

<<声明>>: 

1.终端的提示符为 ［>］

2.为了便于展示,这里使用[head]命令读取, 读者可使用[cat]命令替换[head]命令, 道理是一样的

 

\> head file1 file2

==> file1 <==

I am file one.

==> file2 <==

I am file two.

\#两份文件, 以及里面的内容

 

\> > echo file1 file2 | head    

file1 file2

\# 将echo的内容传入管道, cat 命令处理后,得到的是 echo 的内容

 

\> echo file1 file2 | xargs head

==> file1 <==

I am file one.

==> file2 <==

I am file two.

 

 

\# 将echo的内容传给管道, 先由xargs处理, 再送给head命令处理, 打开了两份文件的内容

 

真令人惊喜, 我们将同样的内容送进管道符, 没有经过xargs处理的数据, head命令直接将其打印到屏幕上了. 经过xargs处理后, 我们传入的数据,变成了两个文件的名字, head命令将两个文件中的内容打印了出来. 这又产生一个疑问了, bash是如何知道,我们传入的是普通字符串还是文件名的呢? 

 

------

- **STDIN 与 argument 的关系** 

 到这里,我们不得不提,两个重要的概念了,这是你每天在命令行上都会接触到,但是常常会忽略的内容.STDIN 和 argument 

 

STDIN: 

Standard input (stdin) , 被称为标准输入数据流,通常是文本信息,也就是我们用键盘输入的字符. 使用这个作为输入信息时,需要程序(命令)对输入的信息进行"读"的操作. 然而并不是所有的程序(命令)都对能力处理流的输入的, 例如 dir , ls 这些命令就无法处理输入的流

例如我们希望能够使用 echo 输出 file1 这个字符串, 通过管道符,将其传输给 ls -l 处理, 希望它能返回出 file1文件的详细列表信息 

如果我们不假思索, 命令将被写成这样

 

\> echo file1 | ls -l

total 12

-rw-r--r-- 1 root root   0 Sep 24 08:28 a.txt

-rw-r--r-- 1 root root   0 Sep 24 08:28 b.txt

-rw-r--r-- 1 root root   0 Sep 24 08:28 c.txt

-rw-r--r-- 1 root root  15 Oct  1 14:27 file1

-rw-r--r-- 1 root root  15 Oct  1 14:27 file2

-rw-r-xr-t 1 root root   0 Sep 24 11:09 hello

-rwxr-xr-x 1 root root 322 Sep 24 12:01 useradd.sh

\# 这时得到的返回值是全部的文件, 而不是我们指定的file1. 这不是我们希望的

这是例子表明, 加工后的数据通过管道符传送给后续的命令时, 传输的数据是标准输入数据(stdin), 这种数据不能被所有的命令所处理

 

argument 

一般被称作参数, 由于跟在命令后的缘故,也被称作命令参数. 它可以是一个文件名,或者是一个可以提供给命令进行加工得到输出的需要的数据.  参数 会比较容易和另外一个概念混淆, 那就是 option(选项)

在Linux中,一般的选项都会有一个flag(-)后面跟着一个单一的字母, 以此来影响程序(命令)的操作,需要注意的是, 如果文件名中存在空格, 请使用 引号(单引号/双引号) 将参数包裹起来,一名bash 无法识别

下面以一个例子说明 argument 和 option

 

\> wc -wl "file 1" "file 2"

1  4 file 1

1  4 file 2

2  8 total

\#以上输入中 , [wc] 是命令 , [-wl] 是选项  ["file 1" "file 2"] 为参数

 

对于我们希望通过echo 输入 file1 字符串, 传给管道符,将其传输给 ls -l 处理 的问题, 由于这里 ls 无法stdin进行处理, 我们必须使用xargs将 stdin 转变为 argument 让 ls 能识别

 

\> echo file1 | xargs ls -l

-rw-r--r-- 1 root root 15 Oct  1 15:06 file1

 

------

- **pipe 和 xargs 的总结**

好了说了那么多,我们对 pipe 和 xargs 进行一个总结吧

pipe 能将我们输入的命令产生的输出, 转变为stdin(标准输入) ,传递给下一个命令, 再又下一个命令对其进行下一步处理

xargs 由于某些命令不具备处理 stdin(标准输入)的能力, 它们只能处理一些argument, xargs 这个时候就需要站出来, 为这些命令提供帮助, 让后续的操作得以继续完成.

 

问题的参考解答

1.是什么造成毛加工(命令的输出) 后的产品,得某些机器(命令)必须要让xargs协助他们才能继续工作呢?

- 命令处理后的数据为stdin, 但是有些命令无法对stdin进行处理,他们必须依赖其他工具如 xargs 对其进行加工,使的加工后的数据适合他们处理

2.bash是如何知道,我们传入的是普通字符串还是文件名的呢? 

- 仅上面的例子分析 , head 是一既能处理stdin 又能处理 argument 的命令. 由于输出通过管道符后,得到的是stdin, 因此 file* 就会被当作流处理, head命令就把它打印处理
- 当流经过了 xargs 处理后, 就称为了head 的argument, 所以 head命令就以文件的方式对待它,并将文件的内容打印到屏幕上

 

 

参考网站:

<http://www.linfo.org/argument.html>                            　　　　　　 Argument Definition

<https://www.wikiwand.com/en/Xargs>                         　　　　　　   xargs

<https://my.oschina.net/asay/blog/789875>                  　　　　　　   xargs 与 管道符的使用

<https://www.wikiwand.com/en/Pipeline_(Unix>)            　　　　　     pipeline

<https://www.wikiwand.com/en/Unix_philosophy>        　　　　　      Unix philosophy

<https://superuser.com/questions/600253/why-is-xargs-necessary>   Why is xargs necessary?

<https://www.wikiwand.com/en/Standard_streams#/Standard_input_.28stdin.29>  standard input

<https://unix.stackexchange.com/questions/46372/whats-the-difference-between-stdin-and-arguments-passed-to-command>     

What's the difference between STDIN and arguments passed to command?

 

 

 

 



分类: [bash](https://www.cnblogs.com/alopex/category/1262171.html)

标签: [xargs](https://www.cnblogs.com/alopex/tag/xargs/), [pipe](https://www.cnblogs.com/alopex/tag/pipe/), [argument](https://www.cnblogs.com/alopex/tag/argument/), [option](https://www.cnblogs.com/alopex/tag/option/)