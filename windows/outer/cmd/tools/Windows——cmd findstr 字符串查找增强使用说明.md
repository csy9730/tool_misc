# [Windows——cmd findstr 字符串查找增强使用说明](https://www.cnblogs.com/zl1991/p/6742315.html)

在文件中寻找字符串。 

复制代码代码如下:


FINDSTR [/B] [/E] [/L] [/R] [/S] [/I] [/X] [/V] [/N] [/M] [/O] [/P] [/F:file] 
[/C:string] [/G:file] [/D:dir list] [/A:color attributes] [/OFF[LINE]] 
strings [[drive:][path]filename[ ...]] 

/B 在一行的开始配对模式。 
/E 在一行的结尾配对模式。 
/L 按字使用搜索字符串。 
/R 将搜索字符串作为正则表达式使用。 
/S 在当前目录和所有子目录中搜索匹配文件。 
/I 指定搜索不分大小写。 
/X 打印完全匹配的行。 
/V 只打印不包含匹配的行。 
/N 在匹配的每行前打印行数。 
/M 如果文件含有匹配项，只打印其文件名。 
/O 在每个匹配行前打印字符偏移量。 
/P 忽略有不可打印字符的文件。 
/OFF[LINE] 不跳过带有脱机属性集的文件。 
/A:attr 指定有十六进位数字的颜色属性。请见 "color /?" 
/F:file 从指定文件读文件列表 (/ 代表控制台)。 
/C:string 使用指定字符串作为文字搜索字符串。 
/G:file 从指定的文件获得搜索字符串。 (/ 代表控制台)。 
/D:dir 查找以分号为分隔符的目录列表 
strings 要查找的文字。 
[drive:][path]filename 
指定要查找的文件。 

除非参数有 /C 前缀，请使用空格隔开搜索字符串。 
例如: 'FINDSTR "hello there" x.y' 在文件 x.y 中寻找 "hello" 或 
"there"。'FINDSTR /C:"hello there" x.y' 文件 x.y 寻找 
"hello there"。 

正则表达式的快速参考: 
. 通配符: 任何字符 
\* 重复: 以前字符或类出现零或零以上次数 
^ 行位置: 行的开始 
$ 行位置: 行的终点 
[class] 字符类: 任何在字符集中的字符 
[^class] 补字符类: 任何不在字符集中的字符 
[x-y] 范围: 在指定范围内的任何字符 
\x Escape: 元字符 x 的文字用法 
\<xyz 字位置: 字的开始 
xyz\> 字位置: 字的结束 


有关 FINDSTR 常见表达法的详细情况，请见联机命令参考。 
这则帮助信息中，我将“一般表达式”，全部替换成了“正则表达式”（一切都是机器翻译惹的祸）。 

命令概括： 
findstr，全英文find string，意为“查找字符串”； 

/b，全英文begin，意为“开始”； 
/e，全英文end，意为“末端”； 
/l，literally，意为“照字面地”；引申为“去正则表达式”。 
/r,regular，意为“有规律的”；引申为“正则表达式”。 
/s，subdirectory，意为“子目录”； 
/i，ignore，意为“忽略”；引申为“忽略大小写”； 
/x，exactly，意为“恰好地”；引申为“完全匹配”；（一开始意为不是这个单词，不过HAT确实高明——之所以以e为缩写，是因为前面有了end的缩写，所以以第二个字母x为缩写）。 
/v，invert，意为“反转、使颠倒”（感谢doupip的单词提供）； 
/n，全英文number，意为“数字”；引申为“行号”； 
/m，merely，意为“只是”； 
/o,offset，意为“偏移”； 
/p，print，意为“打印”； 
/off[line]，意为“脱机文件”； 
/a，attribute，意为“属性”； 
/f，file，意为“文件”； 
/c，case，意为“把几个字加起来”；引申为“全部字匹配”； 
/g，get，意为“获得”； 
/d，directory，意为“目录”； 
class，类。 

感谢HAT的单词提供。 

感谢weichengxiehou。 

参数详解部分13-14节都是从weichengxiehou的帖子里复制来的（既然有现成了，省心多少），原帖地址。 


参数详解： 
学习findstr需要大量的实践体会，所以需要新建一些txt文本以供测试。 

a.txt的内容（a.txt的内容在后面会多次修改，请注意！）： 

复制代码代码如下:


Hello World 
Hello Boy 
hello ,good man. 
goodbye! 


1.最简单的应用：在指定文本中查找指定字符串 
代码： 

复制代码代码如下:


findstr "hello" a.txt 


结果： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr "hello" a.txt 
hello ,good man. 


代码： 

复制代码代码如下:


findstr "Hello" a.txt 


结果： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr "Hello" a.txt 
Hello World 
Hello Boy 


这里可以看出， 
findstr默认是区分大小写的（跟find命令一样）——找hello就不会出现Hello，反之亦然。 
怎么让其不区分大小写呢？ 
用/i参数！ 
例如： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /i "Hello" a.txt 
Hello World 
Hello Boy 
hello ,good man. 


2.显示要查找的字符具体在文本哪一行 
代码：C:\Users\helloworld\Desktop>findstr /n /i "hello" a.txt 
复制代码效果： 

复制代码代码如下:


1:Hello World 
2:Hello Boy 
3:hello ,good man. 


显示的结果中冒号（:）是英文格式下的，在用for提取的时候需要注意！ 
这里可以对比一下find命令的/n参数： 
代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>find /n "hello" a.txt 


效果：---------- A.TXT 
[3]hello ,good man. 
复制代码冒号（:）和中括号（[]），这就是差别，编写代码的时候一定要注意。 
3.查找包含了指定字符的文本 
代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /m /i "hello" *.txt 


效果： 

复制代码代码如下:


1.txt 
a.txt 


1.txt中的类容如下：除非参数有 /C 前缀，请使用空格隔开搜索字符串。 
例如: 

复制代码代码如下:


'FINDSTR "hello there" x.y' 在文件 x.y 中寻找 "hello" 或 
"there"。'FINDSTR /C:"hello there" x.y' 文件 x.y 寻找 
"hello there"。 
[code] 
由于加上了/m参数，所以只列出包含指定字符的文件名。 
4.查找以指定字符开始或结尾的文本行 
这个功能和前面介绍的最大不同就在于涉及到了“元字符”，如果你不明白什么是“元字符”，那也不用担心学不好这一节，这就好像不明白“water”是什么，也不会影响喝水。 
a.txt内容： 
[code] 
good hello 
你好 hello world 
Hello World 
Hello Boy 
hello ,good man. 
goodbye! 


如何查找以hello（忽略大小写）开始的行？ 
两种方法： 
①./b参数 
代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /b /i "hello" a.txt 


效果： 

复制代码代码如下:


Hello World 
Hello Boy 
hello ,good man. 


good hello 和 你好 hello world，这两行都没有显示出来，因为hello不在行的开始处。 
②.^符 
这里的^可不是转义符，而是正则表达式中的“匹配行开始的位置”。 
代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /i "^hello" a.txt 


效果： 

复制代码代码如下:


Hello World 
Hello Boy 
hello ,good man. 


学完了以查找指定字符开始的行，下面学习查找以指定字符结尾的行。 
如何查找以hello（忽略大小写）结尾的行？ 
同样有两种方法： 
①./e参数 
代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /e /i "hello" a.txt 


结果： 

复制代码代码如下:


good hello 


只显示了“good hello”，因为其它行虽然有“hello”，但是他们都没有以“hello”结尾。 
②.$符 
代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /i "hello$" a.txt 


结果：good hello 
到此，我们已经学习了两个正则表达式的元字符：^和$（分别和他们功能相对应的有/b、/e参数）。 
5.查找与指定字符完全匹配的行 
首先修改a.txt的内容： 

复制代码代码如下:


hello 
hello hello 
good hello 
你好 hello world 
Hello World 
Hello Boy 
hello ,good man. 
goodbye! 


懂得举一反三的的童鞋可能会试着尝试以下代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /n /i "^hello$" a.txt 


结果让你倍感欣喜：1:hello 
其实除了这一种方法外，findstr命令还提供了/x参数用来查找完全匹配的行。 
代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /n /i /x "hello" a.txt 


结果： 

复制代码代码如下:


1:hello 


6.关闭正则表达式会怎么样？ 
我们可以人为地将findstr分为两种模式，“正则表达式模式”和“普通字符串模式”。 
findstr默认为“正则表达式模式”，加上/r参数也是“正则表达式模式”（换言之，/r参数有点多余）。 
加上/l参数后，findstr转换为“普通字符串模式”（其实find就是这种模式、且只有这种模式）。 
“普通字符串模式”下，以同样的代码，看看结果怎样？ 
代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /li "^hello" a.txt 


结果什么都没显示出来。 
以hello开头的行明明有以下这些，为什么没显示出来呢？ 

复制代码代码如下:


hello hello 
Hello World 
Hello Boy 
hello ,good man. 


因为，当你使用“普通字符串模式”，findstr不会把^当做是正则表达式的元字符，而只是把其当做普通字符^，也就是说它此时已经不具备“表示行首”的功能，变成了和h之类字符一样的普通民众，再也没“特权”。 
改变a.txt的内容：^hello 

复制代码代码如下:


hello 
hello hello 
good hello 
你好 hello world 
Hello World 
Hello Boy 
hello ,good man. 
goodbye! 


再次运行代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /nli "^hello" a.txt 


结果： 

复制代码代码如下:


1:^hello 


7.查找不包含指定字符的行 
如果比较一下find和findstr命令就会发现，他们都具有/v，/n,/i,/off[line]参数，而且功能都是一摸一样的，这里说的就是/v参数。 
查找不包含hello的行。 
代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /vni "hello" a.txt 


结果： 

复制代码代码如下:


9:goodbye! 


8.如何查找当前目录及子目录下文件内容中包含某字符串的文件名？ 
在写这篇教程的时候，偶然看到有批友问了这个问题，问题地址：http://bbs.bathome.net/viewthread.php?tid=14727 
代码： 

复制代码代码如下:


findstr /ms "专业" *.txt 


效果： 
找出当前目录及子目录下文件内容中包含“专业”的文本文件，并只显示其文件名。 
9.用文本制定要查找的文件 And 用文本制定要查找的字符串 
用文本制定要查找的文件 
新建一个file.txt，内容如下（这个文本中指定findstr要查找的文本的路径）： 

复制代码代码如下:


C:\Users\helloworld\Desktop\1.txt 
C:\Users\helloworld\Desktop\a.txt 
C:\Users\helloworld\Desktop\clip.txt 
C:\Users\helloworld\Desktop\CrLf 批处理笔记.txt 
C:\Users\helloworld\Desktop\file.txt 
C:\Users\helloworld\Desktop\MyRarHelp.txt 
C:\Users\helloworld\Desktop\test.txt 
C:\Users\helloworld\Desktop\红楼.txt 
C:\Users\helloworld\Desktop\520\新建文本文档.txt 
C:\Users\helloworld\Desktop\520\12\hello_ world.txt 
C:\Users\helloworld\Desktop\编程\help.txt 
C:\Users\helloworld\Desktop\编程\win7 help比xp help多出来的命令.txt 
C:\Users\helloworld\Desktop\编程\wmic.txt 


代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /f:file.txt /im "hello" 


效果： 

复制代码代码如下:


C:\Users\helloworld\Desktop\1.txt 
C:\Users\helloworld\Desktop\a.txt 
C:\Users\helloworld\Desktop\CrLf 批处理笔记.txt 
C:\Users\helloworld\Desktop\file.txt 
C:\Users\helloworld\Desktop\test.txt 


用文本制定要查找的字符串 
新建一个string.txt，内容如下（这个文本中指定findstr要查找的字符串）： 

复制代码代码如下:


^hello 
world 


a.txt 

复制代码代码如下:


^hello 
hello 
hello hello 
good hello 
你好 hello 
Hello World 
Hello Boy 
hello ,good man. 
goodbye! 


代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /ig:string.txt a.txt 


效果： 

复制代码代码如下:


hello 
hello hello 
Hello World 
Hello Boy 
hello ,good man. 


被忽略的行 

复制代码代码如下:


^hello 
good hello 
你好 hello 
goodbye! 


从被忽略的“^hello”可以看出，在不加/l参数的前提下，用/g指定的搜索字符串中如果含有“元字符”，则作为正则表达式使用，而不是作为普通表达式。 
10.搜索一个完全匹配的句子 
其实findstr自带的帮助中就有个很好的例子： 
例如: 'FINDSTR "hello there" x.y' 在文件 x.y 中寻找 "hello" 或 
"there"。'FINDSTR /C:"hello there" x.y' 文件 x.y 寻找 
"hello there"。 
可以以这个例子来做个测试。 

复制代码代码如下:


a.txthello there 
hellothere 
hello 
there 


代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /ic:"hello there" a.txt 


结果： 

复制代码代码如下:


hello there 


这就是句子的完全匹配了。 
11.搜索一个完全匹配的词。 
这里也涉及到了两个元字符：\<，\>。 
先试看一个例子。 
a.txt 

复制代码代码如下:


far there 
farthere 
there 
far 
farm 
farmer 


代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr "far" a.txt 


结果： 

复制代码代码如下:


far there 
farthere 
far 
farm 
farmer 


我的本意是要查找含有“far”这个单词的行，但是farthere、farm、farmer却显示出来了，这不是我想要的结果。 
如果只要求显示含有“far”这个单词的行，该怎么写呢？ 
代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr "\<far\>" a.txt 


结果： 

复制代码代码如下:


far there 
far 


12.指定要查找的目录 
/d参数我一直把它和/f、/g归为一类，但其实二者截然不同，/f、/g是用文本文件制定要查找的文件、字符串，而/d是直接书写目录名到命令中。 
代码： 

复制代码代码如下:


C:\Users\helloworld\Desktop>findstr /imd:520;编程; ".*" "*.txt" 


结果： 

复制代码代码如下:


520: 
hello.txt 


编程: 
help.txt 

复制代码代码如下:


win7 help比xp help多出来的命令.txt 
wmic.txt 


查找在520、编程目录中所有包含任意字符的txt文件。 
13.统计字符数 
/o:在每行前打印字符偏移量，在找到的每行前打印该行首距离文件开头的位置，也就是多少个字符，如test.txt中有如下内容： 

复制代码代码如下:


aaaaaaaaaa 
aaaaaaaaaa 
aaaaaaaaaa 
aaaaaaaaaa 
aaaaaaaaaa 
aaaaaaaaaa 


执行命令：findstr /o .* test.txt 
复制代码::上一行中的.*为正则表达式的内容，表示任意行，包含空行 
结果如下： 

复制代码代码如下:


0:aaaaaaaaaa 
12:aaaaaaaaaa 
24:aaaaaaaaaa 
36:aaaaaaaaaa 
48:aaaaaaaaaa 


注意每行末尾的回车换行符算两个字符。 
14.以指定颜色显示文件名 
/a:当被搜索文件名中含有通配符*或?时对搜索结果的文件名部分指定颜色属性，具体颜色值参见color帮助： 
0 = 黑色 8 = 灰色 
1 = 蓝色 9 = 淡蓝色 
2 = 绿色 A = 淡绿色 
3 = 浅绿色 B = 淡浅绿色 
4 = 红色 C = 淡红色 
5 = 紫色 D = 淡紫色 
6 = 黄色 E = 淡黄色 
7 = 白色 F = 亮白色 
常用于彩色显示，举个简单的例子，想要彩色显示“批处理之家”怎么办，假如当前的color设置为27（背景绿色，字体白色），用蓝色显示“批处理之家”咋办？::下一行的退格符可以在cmd的编辑模式下按ctrl+p后按退格键获得>"批处理之家" set /p=<nul 

复制代码代码如下:


\>"批处理之家" set /p=<nul 
findstr /a:21 .* "批处理之家*" 
pause 


代码中的退格符是为了让显示的内容仅为"批处理之家",如果有其他内容，在彩色显示的"批处理之家"后还有一个冒号和其他内容，退格符正好将冒号删除。注意代码中的通配符是必须的。 
15.findstr中的元字符 
16.未讲解的内容:/p，/off[line] 
这两个命令不明白是什么意思，因为不知道什么是“不可打印字符”、“带有脱机属性集的文件”，望有识之士给予解答。 

联系方式：emhhbmdfbGlhbmcxOTkxQDEyNi5jb20=