# [Linux文本三剑客超详细教程---grep、sed、awk](https://www.cnblogs.com/along21/p/10366886.html)

　　awk、grep、sed是linux操作文本的三大利器，合称文本三剑客，也是必须掌握的linux命令之一。三者的功能都是处理文本，但侧重点各不相同，其中属awk功能最强大，但也最复杂。grep更适合单纯的查找或匹配文本，sed更适合编辑匹配到的文本，awk更适合格式化文本，对文本进行较复杂格式处理。

## 1、grep

### **1.1 什么是grep和egrep**

　　Linux系统中grep命令是一种强大的文本搜索工具，它能使用**正则表达式**搜索文本，并把匹配的行打印出来（匹配到的标红）。grep全称是Global Regular Expression Print，表示全局正则表达式版本，它的使用权限是所有用户。

　　grep的工作方式是这样的，它在一个或多个文件中搜索字符串模板。如果模板包括空格，则必须被引用，模板后的所有字符串被看作文件名。搜索的结果被送到标准输出，不影响原文件内容。

　　grep可用于shell脚本，因为grep通过返回一个状态值来说明搜索的状态，如果模板搜索成功，则返回0，如果搜索不成功，则返回1，如果搜索的文件不存在，则返回2。我们利用这些返回值就可进行一些自动化的文本处理工作。

　　**egrep = grep -E：扩展的正则表达式** （除了**\< , \> , \b** 使用其他正则都可以去掉\）

 

### **1.2 使用grep**

#### **1.2.1 命令格式**

```
grep` `[option] pattern ``file
```

 

#### **1.2.2 命令功能**

用于过滤/搜索的特定字符。可使用正则表达式能多种命令配合使用，使用上十分灵活。

 

#### **1.2.3 命令参数**

常用参数已加粗

-  -A<显示行数>：除了显示符合范本样式的那一列之外，并显示该行之后的内容。
-  -B<显示行数>：除了显示符合样式的那一行之外，并显示该行之前的内容。
-  -C<显示行数>：除了显示符合样式的那一行之外，并显示该行之前后的内容。
-  -c：统计匹配的行数
-  **-e ：实现多个选项间的逻辑or 关系**
-  **-E：扩展的正则表达式**
-  -f FILE：从FILE获取PATTERN匹配
-  -F ：相当于fgrep
-  -i --ignore-case #忽略字符大小写的差别。
-  -n：显示匹配的行号
-  -o：仅显示匹配到的字符串
-  -q： 静默模式，不输出任何信息
-  -s：不显示错误信息。
-  **-v：显示不被pattern 匹配到的行，相当于[^] 反向匹配**
-  -w ：匹配 整个单词

 

### **1.3 grep实战演示**

![img](https://img2018.cnblogs.com/blog/1216496/201902/1216496-20190213110803311-1918968372.png)

 

##  2、正则表达式

### **2.1 认识正则**

（1）介绍

　　正则表达式应用广泛，在绝大多数的编程语言都可以完美应用，在Linux中，也有着极大的用处。

　　使用正则表达式，可以有效的筛选出需要的文本，然后结合相应的支持的工具或语言，完成任务需求。

　　在本篇博客中，我们使用grep/egrep来完成对正则表达式的调用

 

（2）正则表达式类型

正则表达式可以使用正则表达式引擎实现，正则表达式引擎是解释正则表达式模式并使用这些模式匹配文本的基础软件。

在Linux中，常用的正则表达式有：

-  POSIX 基本正则表达式（BRE）引擎
-  POSIX 扩展正则表达式（BRE）引擎

 

### **2.2 基本正则表达式**

#### **2.2.1 匹配字符**

（1）格式

-  . 匹配任意单个字符，不能匹配空行
-  [] 匹配指定范围内的任意单个字符
-  [^] 取反
-  [:alnum:] 或 [0-9a-zA-Z]
-  [:alpha:] 或 [a-zA-Z]
-  [:upper:] 或 [A-Z]
-  [:lower:] 或 [a-z]
-  [:blank:] 空白字符（空格和制表符）
-  [:space:] 水平和垂直的空白字符（比[:blank:]包含的范围广）
-  [:cntrl:] 不可打印的控制字符（退格、删除、警铃...）
-  [:digit:] 十进制数字 或[0-9]
-  [:xdigit:]十六进制数字
-  [:graph:] 可打印的非空白字符
-  [:print:] 可打印字符
-  [:punct:] 标点符号

（2）演示

![img](https://img2018.cnblogs.com/blog/1216496/201902/1216496-20190213090042125-2109800404.png)

 

#### **2.2.2 配置次数**

（1）格式

-  *****  匹配前面的字符任意次，**包括0次**，贪婪模式：尽可能长的匹配
-  **.\*** 任意长度的任意字符，**不包括0次**
-  **\?**  匹配其前面的字符**0 或 1次**
-  **\+** 匹配其前面的字符**至少1次**
-  \{n\}  匹配前面的字符n次
-  \{m,n\}  匹配前面的字符至少m 次，至多n次
-  \{,n\}  匹配前面的字符至多n次
-  \{n,\}  匹配前面的字符至少n次

（2）演示

![img](https://img2018.cnblogs.com/blog/1216496/201902/1216496-20190213090101899-1965232897.png)

 

#### **2.2.3 位置锚定：定位出现的位置**

（1）格式

-  ^  行首锚定，用于模式的最左侧
-  $  行尾锚定，用于模式的最右侧
-  ^PATTERN$，用于模式匹配整行
-  ^$ 空行
-  ^[[:space:]].*$  空白行
-  \< 或 \b  词首锚定，用于单词模式的左侧
-  \> 或 \b  词尾锚定；用于单词模式的右侧
-  \<PATTERN\>

（2）演示

![img](https://img2018.cnblogs.com/blog/1216496/201902/1216496-20190213090122106-1784095099.png)

 

#### **2.2.4 分组和后向引用**

（1）格式

① 分组：\(\) 将一个或多个字符捆绑在一起，当作一个整体进行处理

　　分组括号中的模式匹配到的内容会被正则表达式引擎记录于内部的变量中，这些变量的命名方式为: \1, \2, \3, ...

② 后向引用

引用前面的分组括号中的模式所匹配字符，而非模式本身

\1 表示从左侧起第一个左括号以及与之匹配右括号之间的模式所匹配到的字符

\2 表示从左侧起第2个左括号以及与之匹配右括号之间的模式所匹配到的字符，以此类推

\& 表示前面的分组中所有字符

③ 流程分析如下：

![img](https://img2018.cnblogs.com/blog/1216496/201902/1216496-20190213090906435-1889784692.png)

（2）演示

![img](https://img2018.cnblogs.com/blog/1216496/201902/1216496-20190213090916442-579082373.png)

 

### **2.3 扩展正则表达式**

（1）字符匹配：

-  .  任意单个字符
-  []  指定范围的字符
-  [^] 不在指定范围的字符
-   次数匹配：
-  \* ：匹配前面字符任意次
-  ?  : 0 或1次
-  \+ ：1 次或多次
-  {m} ：匹配m次 次
-  {m,n} ：至少m ，至多n次

（2）位置锚定：

-  ^ : 行首
-  $ : 行尾
-  \<, \b : 语首
-  \>, \b : 语尾
-   分组：()
-  后向引用：\1, \2, ...

（3）总结

　　除了\<, \b : 语首、\>, \b : 语尾；使用其他正则都可以去掉\；上面有演示案例，不在进行演示

 

## 3、sed

### **3.1 认识sed**

　　sed 是一种流编辑器，它一次处理一**行**内容。处理时，把当前处理的行存储在临时缓冲区中，称为“**模式空间**”（patternspace ），接着用sed 命令处理缓冲区中的内容，处理完成后，把缓冲区的内容送往屏幕。然后读入下行，执行下一个循环。如果没有使诸如‘D’ 的特殊命令，那会在两个循环之间清空模式空间，但不会清空**保留空间**。这样不断重复，直到文件末尾。**文件内容并没有改变**，除非你使用**重定向存储输出或-i**。

　　功能：主要用来自动编辑一个或多个文件, 简化对文件的反复操作

 

### **3.2 使用sed**

#### **3.2.1 命令格式**

```
sed` `[options] ``'[地址定界] command'` `file``(s)
```

　　

#### **3.2.2 常用选项options**

-  **-n**：不输出模式空间内容到屏幕，即不自动打印，只打印匹配到的行
-  **-e：**多点编辑，对每行处理时，可以有多个Script
-  **-f**：把Script写到文件当中，在执行sed时-f 指定文件路径，如果是多个Script，换行写
-  **-r**：支持**扩展的正则**表达式
-  **-i**：直接将处理的结果写入文件
-  **-i.bak**：在将处理的结果写入文件之前备份一份

 

#### **3.2.3 地址定界**

-  不给地址：对全文进行处理
- 单地址：
  -  \#: 指定的行
  -  /pattern/：被此处模式所能够匹配到的每一行
- 地址范围：
  -  \#,#
  -  \#,+#
  -  /pat1/,/pat2/
  -  \#,/pat1/
- ~：步进
  -  sed -n **'1~2p'** 只打印奇数行 （1~2 从第1行，一次加2行）
  -  sed -n **'2~2p'** 只打印偶数行

 

#### **3.2.4 编辑命令command**

-  **d：删除**模式空间匹配的行，并立即启用下一轮循环

-  **p：打印**当前模式空间内容，追加到默认输出之后

-  **a**：在指定行**后面追加**文本，支持使用\n实现多行追加

-  **i**：在行**前面插入**文本，支持使用\n实现多行追加

-  **c**：**替换**行为单行或多行文本，支持使用\n实现多行追加

-  w：保存模式匹配的行至指定文件

-  r：读取指定文件的文本至模式空间中匹配到的行后

-  =：为模式空间中的行打印行号

-  **!**：模式空间中匹配行**取反**处理

- s///

  ：

  查找替换

  ，支持使用其它分隔符，如：

  s@@@

  ，

  s###

  ；

  -  **加g表示行内全局替换；**
  -  在替换时，可以加一下命令，实现大小写转换
  -  \l：把下个字符转换成小写。
  -  \L：把replacement字母转换成小写，直到\U或\E出现。
  -  \u：把下个字符转换成大写。
  -  \U：把replacement字母转换成大写，直到\L或\E出现。
  -  \E：停止以\L或\U开始的大小写转换

 

### **3.3 sed用法演示**

#### **3.3.1 常用选项options演示**

```
[root@along ~]``# cat demo``aaa``bbbb``AABBCCDD``[root@along ~]``# sed "/aaa/p" demo #匹配到的行会打印一遍，不匹配的行也会打印``aaa``aaa``bbbb``AABBCCDD``[root@along ~]``# sed -n "/aaa/p" demo #-n不显示没匹配的行``aaa``[root@along ~]``# sed -e "s/a/A/" -e "s/b/B/" demo #-e多点编辑``Aaa``Bbbb``AABBCCDD``[root@along ~]``# cat sedscript.txt``s``/A/a/g``[root@along ~]``# sed -f sedscript.txt demo #-f使用文件处理``aaa``bbbb``aaBBCCDD``[root@along ~]``# sed -i.bak "s/a/A/g" demo #-i直接对文件进行处理``[root@along ~]``# cat demo``AAA``bbbb``AABBCCDD``[root@along ~]``# cat demo.bak``aaa``bbbb``AABBCCDD
```

　　

#### **3.3.2 地址界定演示**

```
[root@along ~]``# cat demo``aaa``bbbb``AABBCCDD``[root@along ~]``# sed -n "p" demo #不指定行，打印全文``aaa``bbbb``AABBCCDD``[root@along ~]``# sed "2s/b/B/g" demo #替换第2行的b->B``aaa``BBBB``AABBCCDD``[root@along ~]``# sed -n "/aaa/p" demo``aaa``[root@along ~]``# sed -n "1,2p" demo #打印1-2行``aaa``bbbb``[root@along ~]``# sed -n "/aaa/,/DD/p" demo``aaa``bbbb``AABBCCDD``[root@along ~]``# sed -n "2,/DD/p" demo``bbbb``AABBCCDD``[root@along ~]``# sed "1~2s/[aA]/E/g" demo #将奇数行的a或A替换为E``EEE``bbbb``EEBBCCDD
```

　　

#### **3.3.3 编辑命令command演示**

```
[root@along ~]``# cat demo``aaa``bbbb``AABBCCDD``[root@along ~]``# sed "2d" demo #删除第2行``aaa``AABBCCDD``[root@along ~]``# sed -n "2p" demo #打印第2行``bbbb``[root@along ~]``# sed "2a123" demo #在第2行后加123``aaa``bbbb``123``AABBCCDD``[root@along ~]``# sed "1i123" demo #在第1行前加123``123``aaa``bbbb``AABBCCDD``[root@along ~]``# sed "3c123\n456" demo #替换第3行内容``aaa``bbbb``123``456``[root@along ~]``# sed -n "3w/root/demo3" demo #保存第3行的内容到demo3文件中``[root@along ~]``# cat demo3``AABBCCDD``[root@along ~]``# sed "1r/root/demo3" demo #读取demo3的内容到第1行后``aaa``AABBCCDD``bbbb``AABBCCDD``[root@along ~]``# sed -n "=" demo #=打印行号``1``2``3``[root@along ~]``# sed -n '2!p' demo #打印除了第2行的内容``aaa``AABBCCDD``[root@along ~]``# sed 's@[a-z]@\u&@g' demo #将全文的小写字母替换为大写字母``AAA``BBBB``AABBCCDD
```

　　

### **3.4 sed高级编辑命令**

（1）格式

-  h：把模式空间中的内容覆盖至保持空间中
-  H：把模式空间中的内容追加至保持空间中
-  g：从保持空间取出数据覆盖至模式空间
-  G：从保持空间取出内容追加至模式空间
-  x：把模式空间中的内容与保持空间中的内容进行互换
-  n：读取匹配到的行的下一行覆盖 至模式空间
-  N：读取匹配到的行的下一行追加 至模式空间
-  d：删除模式空间中的行
-  D：删除 当前模式空间开端至\n 的内容（不再传 至标准输出），放弃之后的命令，但是对剩余模式空间重新执行sed

 

（2）一个案例+示意图演示

① 案例：倒序输出文本内容

```
[root@along ~]``# cat num.txt``One``Two``Three``[root@along ~]``# sed '1!G;h;$!d' num.txt``Three``Two``One
```

② 示意图如下：

![img](https://img2018.cnblogs.com/blog/1216496/201902/1216496-20190213091449198-704428171.png)

③ 总结模式空间与保持空间关系：

保持空间是模式空间一个临时存放数据的缓冲区，协助模式空间进行数据处理

 

（3）演示

① 显示偶数行

```
[root@along ~]``# seq 9 |sed -n 'n;p'``2``4``6``8
```

② 倒序显示

```
[root@along ~]``# seq 9 |sed '1!G;h;$!d'``9``8``7``6``5``4``3``2``1
```

③ 显示奇数行

```
[root@along ~]``# seq 9 |sed 'H;n;d'``1``3``5``7``9
```

④ 显示最后一行

```
[root@along ~]``# seq 9| sed 'N;D'``9
```

⑤ 每行之间加空行

```
[root@along ~]``# seq 9 |sed 'G'``1` `2` `3` `4` `5` `6` `7` `8` `9` `---
```

 ⑥ 把每行内容替换成空行

```
[root@along ~]``# seq 9 |sed "g"`     `---
```

 ⑦ 确保每一行下面都有一个空行

```
[root@along ~]``# seq 9 |sed '/^$/d;G'``1` `2` `3` `4` `5` `6` `7` `8` `9
```

 

## 4、awk

### **4.1 认识awk**

　　awk是一种编程语言，用于在linux/unix下对文本和数据进行处理。数据可以来自标准输入(stdin)、一个或多个文件，或其它命令的输出。它**支持用户自定义函数**和动态正则表达式等先进功能，是linux/unix下的一个强大编程工具。它在命令行中使用，但更多是作为脚本来使用。**awk有很多内建的功能**，比如数组、函数等，这是它和C语言的相同之处，灵活性是awk最大的优势。

　　awk其实不仅仅是工具软件，还是一种编程语言。不过，本文只介绍它的命令行用法，对于大多数场合，应该足够用了。

 

### **4.2 使用awk**

#### **4.2.1 语法**

```
awk` `[options] ``'program'` `var=value ``file``…``awk` `[options] -f programfile var=value ``file``…``awk` `[options] ``'BEGIN{ action;… } pattern{ action;… } END{ action;… }'` `file` `...
```

　　

#### **4.2.2 常用命令选项**

-  -F fs：fs指定输入分隔符，fs可以是字符串或正则表达式，如-F:
-  -v var=value：赋值一个用户定义变量，将外部变量传递给awk
-  -f scripfile：从脚本文件中读取awk命令

 

### **4.3 awk变量**

变量：内置和自定义变量，每个变量前加 -v 命令选项

#### **4.3.1 内置变量**

（1）格式

-  **FS** ：**输入字段分隔符**，**默认为空白字符**
-  **OFS** ：**输出字段分隔符**，默认为空白字符
-  RS ：**输入记录分隔符**，指定输入时的换行符，原换行符仍有效
-  ORS ：**输出记录分隔符**，输出时用指定符号代替换行符
-  **NF** ：字段数量，**共有**多少字段， **$NF引用最后一列，$(NF-1)引用倒数第2列**
-  **NR** ：**行号**，后可跟多个文件，第二个文件行号继续从第一个文件最后行号开始
-  FNR ：各文件分别计数, 行号，后跟一个文件和NR一样，跟多个文件，第二个文件**行号从1开始**
-  FILENAME ：**当前文件名**
-  ARGC ：**命令行参数**的个数
-  ARGV ：数组，保存的是命令行所给定的各参数，**查看参数**

 

（2）演示

```
[root@along ~]``# cat awkdemo``hello:world``linux:redhat:lalala:hahaha``along:love:youou``[root@along ~]``# awk -v FS=':' '{print $1,$2}' awkdemo #FS指定输入分隔符``hello world``linux redhat``along love``[root@along ~]``# awk -v FS=':' -v OFS='---' '{print $1,$2}' awkdemo #OFS指定输出分隔符``hello---world``linux---redhat``along---love``[root@along ~]``# awk -v RS=':' '{print $1,$2}' awkdemo``hello``world linux``redhat``lalala``hahaha along``love``you``[root@along ~]``# awk -v FS=':' -v ORS='---' '{print $1,$2}' awkdemo``hello world---linux redhat---along love---``[root@along ~]``# awk -F: '{print NF}' awkdemo``2``4``3``[root@along ~]``# awk -F: '{print $(NF-1)}' awkdemo #显示倒数第2列``hello``lalala``love``[root@along ~]``# awk '{print NR}' awkdemo awkdemo1``1``2``3``4``5``[root@along ~]``# awk END'{print NR}' awkdemo awkdemo1``5``[root@along ~]``# awk '{print FNR}' awkdemo awkdemo1``1``2``3``1``2``[root@along ~]``# awk '{print FILENAME}' awkdemo``awkdemo``awkdemo``awkdemo``[root@along ~]``# awk 'BEGIN {print ARGC}' awkdemo awkdemo1``3``[root@along ~]``# awk 'BEGIN {print ARGV[0]}' awkdemo awkdemo1``awk``[root@along ~]``# awk 'BEGIN {print ARGV[1]}' awkdemo awkdemo1``awkdemo``[root@along ~]``# awk 'BEGIN {print ARGV[2]}' awkdemo awkdemo1``awkdemo1
```

　　

#### **4.3.2 自定义变量**

自定义变量( 区分字符大小写)

（1）-v var=value

① 先定义变量，后执行动作print

```
[root@along ~]``# awk -v name="along" -F: '{print name":"$0}' awkdemo``along:hello:world``along:linux:redhat:lalala:hahaha``along:along:love:you
```

② 在执行动作print后定义变量

```
[root@along ~]``# awk -F: '{print name":"$0;name="along"}' awkdemo``:hello:world``along:linux:redhat:lalala:hahaha``along:along:love:you
```

　　

（2）在program 中直接定义

可以把执行的动作放在脚本中，直接调用脚本 -f

```
[root@along ~]``# cat awk.txt``{name=``"along"``;print name,$1}``[root@along ~]``# awk -F: -f awk.txt awkdemo``along hello``along linux``along along
```

　　

### **4.4 printf命令**

比print更强大

#### **4.4.1 格式**

（1）格式化输出

```
printf` `"FORMAT"``, item1,item2, ...
```

①  必须指定FORMAT

②  **不会自动换行，需要显式给出换行控制符，\n**

③  FORMAT 中需要分别为后面每个item 指定格式符

 

（2）格式符：与item 一一对应

-  %c:  显示字符的ASCII码
-  %d, %i:  显示十进制整数
-  %e, %E: 显示科学计数法数值
-  **%f ：显示为浮点数，小数**  %5.1f，带整数、小数点、整数共5位，小数1位，不够用空格补上
-  %g, %G ：以科学计数法或浮点形式显示数值
-  **%s ：显示字符串**；例：%5s最少5个字符，不够用空格补上，超过5个还继续显示
-  **%u ：无符号整数**
-  %%:  显示% 自身

 

（3）修饰符：放在%c[/d/e/f...]之间

-  \#[.#]：第一个数字控制显示的宽度；第二个# 表示小数点后精度，%5.1f
-  -：左对齐（**默认右对齐**） %-15s
-  +：显示数值的正负符号 %+d

 

#### **4.4.2 演示**

```
[root@along ~]``# awk -F: '{print $1,$3}' /etc/passwd``root 0``bin 1``---第一列显示小于20的字符串；第2列显示整数并换行``[root@along ~]``# awk -F: '{printf "%20s---%u\n",$1,$3}' /etc/passwd``        ``root---0``         ``bin---1``---使用-进行左对齐；第2列显示浮点数``[root@along ~]``# awk -F: '{printf "%-20s---%-10.3f\n",$1,$3}' /etc/passwd``root        ---0.000  ``bin         ---1.000``---使用``printf``做表格``[root@along ~]``# awk -F: 'BEGIN{printf "username      userid\n-----------------------------\n"}{printf "%-20s|%-10.3f\n",$1,$3}' /etc/passwd``username      userid``-----------------------------``root        |0.000  ``bin         |1.000
```

　　

### **4.5 操作符**

#### **4.5.1 格式**

- 算术操作符：

  -  x+y, x-y, x*y, x/y, x^y, x%y
  -  -x:  转换为负数
  -  +x:  转换为数值

-  字符串操作符：没有符号的操作符，字符串连接

- 赋值操作符：

  -  =, +=, -=, *=, /=, %=, ^=
  -  ++, --

- 比较操作符：

  -  ==, !=, >, >=, <, <=

-  模式匹配符：~ ：左边是否和右边匹配包含 !~ ：是否不匹配

-  逻辑操作符：与&& ，或|| ，非!

-  函数调用： function_name(argu1, argu2, ...)

- 条件表达式（三目表达式）：

  selector

  ?

  if-true-expression

  :

  if-false-expression

  -  注释：先判断selector，如果符合执行 ? 后的操作；否则执行 : 后的操作

 

#### **4.5.2 演示**

（1）模式匹配符

```
---查询以``/dev``开头的磁盘信息``[root@along ~]``# df -h |awk -F: '$0 ~ /^\/dev/'``/dev/mapper/cl-root`  `17G 7.3G 9.7G 43% /``/dev/sda1`      `1014M 121M 894M 12% ``/boot``---只显示磁盘使用状况和磁盘名``[root@along ~]``# df -h |awk '$0 ~ /^\/dev/{print $(NF-1)"---"$1}'``43%---``/dev/mapper/cl-root``12%---``/dev/sda1``---查找磁盘大于40%的``[root@along ~]``# df -h |awk '$0 ~ /^\/dev/{print $(NF-1)"---"$1}' |awk -F% '$1 > 40'``43%---``/dev/mapper/cl-root
```

　　

（2）逻辑操作符

```
[root@along ~]``# awk -F: '$3>=0 && $3<=1000 {print $1,$3}' /etc/passwd``root 0``bin 1``[root@along ~]``# awk -F: '$3==0 || $3>=1000 {print $1}' /etc/passwd``root``[root@along ~]``# awk -F: '!($3==0) {print $1}' /etc/passwd``bin``[root@along ~]``# awk -F: '!($0 ~ /bash$/) {print $1,$3}' /etc/passwd``bin 1``daemon 2
```

　　

（3）条件表达式（三目表达式）

```
[root@along ~]``# awk -F: '{$3 >= 1000?usertype="common user":usertype="sysadmin user";print usertype,$1,$3}' /etc/passwd``sysadmin user root 0``common user along 1000
```

　　

### **4.6 awk PATTERN 匹配部分**

#### **4.6.1 格式**

PATTERN：根据pattern 条件，过滤匹配的行，再做处理

（1）如果未指定：空模式，匹配每一行

（2）/regular expression/ ：仅处理能够模式匹配到的行，**正则**，需要用/ / 括起来

（3）relational expression：**关系表达式，结果为“真”才会被处理**

真：结果为非0值，非空字符串

假：结果为空字符串或0值

（4）line ranges：行范围

　　startline(起始行),endline(结束行)：/pat1/,/pat2/  不支持直接给出数字，可以有多段，中间可以有间隔

（5）BEGIN/END 模式

　　BEGIN{}:  仅在开始处理文件中的文本之前执行一次

　　END{} ：仅在文本处理完成之后执行

 

#### **4.6.2 演示**

```
[root@along ~]``# awk -F: '{print $1}' awkdemo``hello``linux``along``[root@along ~]``# awk -F: '/along/{print $1}' awkdemo``along``[root@along ~]``# awk -F: '1{print $1}' awkdemo``hello``linux``along``[root@along ~]``# awk -F: '0{print $1}' awkdemo``[root@along ~]``# awk -F: '/^h/,/^a/{print $1}' awkdemo``hello``linux``along``[root@along ~]``# awk -F: 'BEGIN{print "第一列"}{print $1} END{print "结束"}' awkdemo``第一列``hello``linux``along``结束
```

　　

### **4.7 awk有意思的案例**

```
[root@along ~]``# seq 10``1``2``3``4``5``6``7``8``9``10``---因为i=0，为假，所以不打印``[root@along ~]``# seq 10 |awk 'i=0'``---i=1，为真，所以全部打印``[root@along ~]``# seq 10 |awk 'i=1'``1``2``3``4``5``6``7``8``9``10``---只打印奇数行；奇数行i进入时本身为空，被赋为!i，即不为空，所以打印；偶数行i进入时本身不为空，被赋为!i，即为空，所以不打印``[root@along ~]``# seq 10 |awk 'i=!i'``1``3``5``7``9``---解释上一个操作，i在奇偶行的值``[root@along ~]``# seq 10 |awk '{i=!i;print i}'``1``0``1``0``1``0``1``0``1``0``---只打印偶数行，是上边打印奇数行的取反``[root@along ~]``# seq 10 |awk '!(i=!i)'``2``4``6``8``10``---只打印偶数行；先对i进行赋值，即不为空，刚好和打印奇数行相反``[root@along ~]``# seq 10 |awk -v i=1 'i=!i'``2``4``6``8``10
```

　　

## 5、awk高阶用法

### **5.1 awk控制语句—if-else判断**

（1）语法

```
if``(condition){statement;…}[``else` `statement] 双分支``if``(condition1){statement1}``else` `if``(condition2){statement2}``else``{statement3} 多分支
```

（2）使用场景：对awk 取得的整行或某个字段做条件判断

（3）演示

```
[root@along ~]``# awk -F: '{if($3>10 && $3<1000)print $1,$3}' /etc/passwd``operator 11``games 1``[root@along ~]``# awk -F: '{if($NF=="/bin/bash") print $1,$NF}' /etc/passwd``root ``/bin/bash``along ``/bin/bash``---输出总列数大于3的行``[root@along ~]``# awk -F: '{if(NF>2) print $0}' awkdemo``linux:redhat:lalala:hahaha``along:love:you``---第3列>=1000为Common user，反之是root or Sysuser``[root@along ~]``# awk -F: '{if($3>=1000) {printf "Common user: %s\n",$1} else{printf "root or Sysuser: %s\n",$1}}' /etc/passwd``root or Sysuser: root``root or Sysuser: bin``Common user: along``---磁盘利用率超过40的设备名和利用率``[root@along ~]``# df -h|awk -F% '/^\/dev/{print $1}'|awk '$NF > 40{print $1,$NF}'``/dev/mapper/cl-root` `43``---``test``=100和>90为very good; 90>``test``>60为good; ``test``<60为no pass``[root@along ~]``# awk 'BEGIN{ test=100;if(test>90){print "very good"}else if(test>60){ print "good"}else{print "no pass"}}'``very good``[root@along ~]``# awk 'BEGIN{ test=80;if(test>90){print "very good"}else if(test>60){ print "good"}else{print "no pass"}}'``good``[root@along ~]``# awk 'BEGIN{ test=50;if(test>90){print "very good"}else if(test>60){ print "good"}else{print "no pass"}}'``no pass
```

　　

### **5.2 awk控制语句—while循环**

（1）语法

```
while``(condition){statement;…}
```

注：条件“真”，进入循环；条件“假”， 退出循环

 

（2）使用场景

　　对一行内的多个字段逐一类似处理时使用

　　对数组中的各元素逐一处理时使用

 

（3）演示

```
---以along开头的行，以：为分隔，显示每一行的每个单词和其长度``[root@along ~]``# awk -F: '/^along/{i=1;while(i<=NF){print $i,length($i); i++}}' awkdemo``along 5``love 4``you 3``---以：为分隔，显示每一行的长度大于6的单词和其长度``[root@along ~]``# awk -F: '{i=1;while(i<=NF) {if(length($i)>=6){print $i,length($i)}; i++}}' awkdemo``redhat 6``lalala 6``hahaha 6``---计算1+2+3+...+100=5050``[root@along ~]``# awk 'BEGIN{i=1;sum=0;while(i<=100){sum+=i;i++};print sum}'``5050
```

　　

### **5.3 awk控制语句—do-while循环**

（1）语法

```
do` `{statement;…}``while``(condition)
```

意义：无论真假，至少执行一次循环体

 

（2）计算1+2+3+...+100=5050

```
[root@along ~]``# awk 'BEGIN{sum=0;i=1;do{sum+=i;i++}while(i<=100);print sum}'``5050
```

　　

### **5.4 awk控制语句—for循环**

（1）语法

```
for``(expr1;expr2;expr3) {statement;…}
```

　　

（2）特殊用法：遍历数组中的元素

```
for``(var ``in` `array) {``for``-body}
```

　　

（3）演示

```
---显示每一行的每个单词和其长度``[root@along ~]``# awk -F: '{for(i=1;i<=NF;i++) {print$i,length($i)}}' awkdemo``hello 5``world 5``linux 5``redhat 6``lalala 6``hahaha 6``along 5``love 4``you 3``---求男m、女f各自的平均``[root@along ~]``# cat sort.txt``xiaoming m 90``xiaohong f 93``xiaohei m 80``xiaofang f 99``[root@along ~]``# awk '{m[$2]++;score[$2]+=$3}END{for(i in m){printf "%s:%6.2f\n",i,score[i]/m[i]}}' sort.txt``m: 85.00``f: 96.00
```

　　

### **5.5 和shell脚本中较相似的控制语句**

#### **5.5.1 switch语句**

和shell中的case很像，就不在演示了

```
switch(expression) {``case` `VALUE1 or ``/REGEXP/``:statement1; ``case` `VALUE2 or ``/REGEXP2/``: statement2;...; default: statementn}
```

 

#### **5.5.2 break和continue**

```
---奇数相加``[root@along ~]``# awk 'BEGIN{sum=0;for(i=1;i<=100;i++){if(i%2==0)continue;sum+=i}print sum}'``2500``---1+2+...+66``[root@along ~]``# awk 'BEGIN{sum=0;for(i=1;i<=100;i++){if(i==66)break;sum+=i}print sum}'``2145
```

 

#### **5.5.3 next**

next：提前结束对本行处理而直接进入下一行处理（awk 自身循环）

```
---只打印偶数行``[root@along ~]``# awk -F: '{if(NR%2!=0) next; print $1,$3}' /etc/passwd``bin 1``adm 3
```

　　

### **5.6 awk数组**

#### **5.6.1 关联数组：array[index-expression]**

（1）可使用任意字符串；字符串要使用双引号括起来

（2）如果某数组元素事先不存在，在引用时，awk 会自动创建此元素，并将其值初始化为“空串”

（3）若要判断数组中是否存在某元素，要使用“index in array”格式进行**遍历**

（4）若要**遍历数组中的每个元素**，要使用for 循环**：for(var in array)** {for-body}

 

#### **5.6.2 演示**

（1）awk使用数组

```
[root@along ~]``# cat awkdemo2``aaa``bbbb``aaa``123``123``123``---去除重复的行``[root@along ~]``# awk '!arr[$0]++' awkdemo2``aaa``bbbb``123``---打印文件内容，和该行重复第几次出现``[root@along ~]``# awk '{!arr[$0]++;print $0,arr[$0]}' awkdemo2``aaa 1``bbbb 1``aaa 2``123 1``123 2``123 3
```

　　分析：把每行作为下标，第一次进来，相当于print ias...一样结果为空，打印空，!取反结果为1，打印本行，并且++变为不空，下次进来相同的行就是相同的下标，本来上次的值，！取反为空，不打印，++变为不空，所以每次重复进来的行都不打印

 

（2）数组遍历

```
[root@along ~]``# awk 'BEGIN{abc["ceo"]="along";abc["coo"]="mayun";abc["cto"]="mahuateng";for(i in abc){print i,abc[i]}}'``coo mayun``ceo along``cto mahuateng``[root@along ~]``# awk '{for(i=1;i<=NF;i++)abc[$i]++}END{for(j in abc)print j,abc[j]}' awkdemo2``aaa 2``bbbb 1``123 3
```

　　

#### **5.6.3 数值\字符串处理**

（1）数值处理

-  rand()：返回0和1之间一个随机数，需有个种子 srand()，没有种子，一直输出0.237788

演示：

```
[root@along ~]``# awk 'BEGIN{print rand()}'``0.237788``[root@along ~]``# awk 'BEGIN{srand(); print rand()}'``0.51692``[root@along ~]``# awk 'BEGIN{srand(); print rand()}'``0.189917``---取0-50随机数``[root@along ~]``# awk 'BEGIN{srand(); print int(rand()*100%50)+1}'``12``[root@along ~]``# awk 'BEGIN{srand(); print int(rand()*100%50)+1}'``24
```

　　

（2）字符串处理：

-  length([s]) ：返回指定字符串的长度
-  sub(r,s,[t]) ：对t 字符串进行搜索r 表示的模式匹配的内容，并**将第一个**匹配的内容替换为s
-  gsub(r,s,[t]) ：对t 字符串进行搜索r 表示的模式匹配的内容，**并全部替换**为s 所表示的内容
-  plit(s,array,[r]) ：以r 为分隔符，切割字符串s ，并将切割后的结果保存至array 所表示的数组中，第一个索引值为1, 第二个索引值为2,…

演示：

```
[root@along ~]``# echo "2008:08:08 08:08:08" | awk 'sub(/:/,"-",$1)'``2008-08:08 08:08:08``[root@along ~]``# echo "2008:08:08 08:08:08" | awk 'gsub(/:/,"-",$0)'``2008-08-08 08-08-08``[root@along ~]``# echo "2008:08:08 08:08:08" | awk '{split($0,i,":")}END{for(n in i){print n,i[n]}}'``4 08``5 08``1 2008``2 08``3 08 08
```

　　

### **5.7 awk自定义函数**

（1）格式：和bash区别：定义函数（）中需加参数，return返回值不是$?，是相当于echo输出

```
function` `name ( parameter, parameter, ... ) {``  ``statements``  ``return` `expression``}
```

　　

（2）演示

```
[root@along ~]``# cat fun.awk``function` `max(v1,v2) {``  ``v1>v2?var=v1:var=v2``  ``return` `var``}``BEGIN{a=3;b=2;print max(a,b)}``[root@along ~]``# awk -f fun.awk``3
```

　　

### **5.8 awk中调用shell 命令**

（1）system 命令

　　空格是awk 中的字符串连接符，如果system中需要使用awk中的变量可以使用空格分隔，或者说除了awk 的变量外其他一律用"" 引用 起来。

```
[root@along ~]``# awk BEGIN'{system("hostname") }'``along``[root@along ~]``# awk 'BEGIN{name="along";system("echo "name)}' 注："echo " echo后有空格``along``[root@along ~]``# awk 'BEGIN{score=100; system("echo your score is " score) }'``your score is 100
```

　　

（2）awk 脚本

将awk 程序写成脚本，直接调用或执行

示例：

```
[root@along ~]``# cat f1.awk``{``if``($3>=1000)print $1,$3}``[root@along ~]``# cat f2.awk``#!/bin/awk -f``{``if``($3 >= 1000)print $1,$3}``[root@along ~]``# chmod +x f2.awk``[root@along ~]``# ./f2.awk -F: /etc/passwd``along 1000
```

　　

（3）向awk脚本传递参数

① 格式：

```
awkfile var=value var2=value2... Inputfile
```

　　注意 ：在BEGIN 过程 中不可用。直到 首行输入完成以后，变量才可用 。可以通过**-v  参数**，让awk 在执行BEGIN 之前得到变量的值。命令行中每一个指定的变量都需要一个-v

② 示例

```
[root@along ~]``# cat test.awk``#!/bin/awk -f``{``if``($3 >=min && $3<=max)print $1,$3}``[root@along ~]``# chmod +x test.awk``[root@along ~]``# ./test.awk -F: min=100 max=200 /etc/passwd``systemd-network 192
```

　　

## 6、grep awk sed对比

grep 主要用于搜索某些字符串；

sed，awk 用于处理文本 ；

　　**grep基本是以行为单位处理文本的****； 而awk可以做更细分的处理，通过指定分隔符将一行（一条记录）划分为多个字段，以字段为单位处理文本。**awk中支持C语法，可以有分支条件判断、循环语句等，相当于一个小型编程语言。

　　awk功能比较多是一个编程语言了。 grep功能简单，就是一个简单的正则表达式的匹配。 awk的功能依赖于grep。

　　**grep可以理解为主要作用是在一个文件中查找过滤需要的内容**。awk不是过滤查找，而是文本处理工具，是把一个文件处理成你想要的格式。

　　AWK的功能是什么？与sed和grep很相似，**awk是一种样式扫描与处理工具**。但其功能却大大强于sed和grep。awk提供了极其强大的功能：它几乎可以完成grep和sed所能完成的全部工作，同时，它还可以可以进行**样式装入、流控制、数学运算符、进程控制语句甚至于内置的变量和函数**。它具备了一个完整的语言所应具有的几乎所有精美特性。实际上，awk的确拥有自己的语言：awk程序设计语言，awk的三位创建者已将它正式定义为：样式扫描和处理语言。 使用awk的第一个理由是基于文本的样式扫描和处理是我们经常做的工作，awk所做的工作有些象数据库，但与数据库不同的是，它处理的是文本文件，这些文件没有专门的存储格式，普通的人们就能编辑、阅读、理解和处理它们。而数据库文件往往具有特殊的存储格式，这使得它们必须用数据库处理程序来处理它们。既然这种类似于数据库的处理工作我们经常会遇到，我们就应当找到处理它们的简便易行的方法，UNIX有很多这方面的工具，例如sed 、grep、sort以及find等等，awk是其中十分优秀的一种。 

　　**使用awk的第二个理由是awk是一个简单的工具**，当然这是相对于其强大的功能来说的。的确，UNIX有许多优秀的工具，例如UNIX天然的开发工具C语言及其延续C++就非常的优秀。但相对于它们来说，awk完成同样的功能要方便和简捷得多。这首先是因为awk提供了适应多种需要的解决方案：从解决简单问题的awk命令行到复杂而精巧的awk程序设计语言，这样做的好处是，你可以不必用复杂的方法去解决本来很简单的问题。例如，你可以用一个命令行解决简单的问题，而C不行，即使一个再简单的程序，C语言也必须经过编写、编译的全过程。其次，awk本身是解释执行的，这就使得awk程序不必经过编译的过程，同时，这也使得它与shell script程序能够很好的契合。最后，awk本身较C语言简单，虽然awk吸收了C语言很多优秀的成分，熟悉C语言会对学习awk有很大的帮助，但awk本身不须要会使用C语言——一种功能强大但需要大量时间学习才能掌握其技巧的开发工具。 

　　**使用awk的第三个理由是awk是一个容易获得的工具**。与C和C++语言不同，awk只有一个文件(/bin/awk)，而且几乎每个版本的UNIX都提供各自版本的awk，你完全不必费心去想如何获得awk。但C语言却不是这样，虽然C语言是UNIX天然的开发工具，但这个开发工具却是单独发行的，换言之，你必须为你的UNIX版本的C语言开发工具单独付费（当然使用D版者除外），获得并安装它，然后你才可以使用它。 

　　基于以上理由，再加上awk强大的功能，我们有理由说，如果你要处理与文本样式扫描相关的工作，awk应该是你的第一选择。在这里有一个可遵循的一般原则：如果你用普通的shell工具或shell script有困难的话，试试awk,如果awk仍不能解决问题，则便用C语言，如果C语言仍然失败，则移至C++。 

　　**sed是一个非交互性文本流编辑器。**它编辑文件或标准输入导出的文本拷贝。sed编辑器按照一次处理 一行的方式来处理文件（或者输入）并把输出送到屏幕上。你可以在vi和ex/ed编辑器里识别他的命令。sed把当前正在处理的行保存在一个临时缓存里，这个缓存叫做模式空间。一但sed完成了对模式空间里的行的处理（即对该行执行sed命令），就把模式空间的行送到屏幕上（除非该命令要删除该行活禁止打印）。处理完该行之后，从模式空间里删除它，然后把下一行读入模式空间，进行处理，并显示。当输入文件的最后一行处理完后，sed终止。通过把每一行存在一个临时缓存里并编辑该行，初始文件不会被修改或被破坏。

**如果您认为这篇文章还不错或者有所收获，您可以通过右边的“打赏”功能 打赏我一杯咖啡【物质支持】，也可以点击右下角的【赞】按钮【精神支持】，因为这两种支持都是我继续写作，分享的最大动力！**

 **作者：[along阿龙](http://www.cnblogs.com/along21/)
 出处：http://www.cnblogs.com/along21/
 简介：每天都在进步，每周都在总结，你的一个点赞，一句留言，就可以让博主开心一笑，充满动力！
 版权：本文版权归作者和博客园共有，欢迎转载，但未经作者同意必须保留此段声明，且在文章页面明显位置给出原文连接，否则保留追究法律责任的权利。**

**已将所有赞助者统一放到单独页面！签名处只保留最近10条赞助记录！查看[赞助者列表](https://www.cnblogs.com/along21/p/7435612.html)**

| 衷心感谢打赏者的厚爱与支持！也感谢点赞和评论的园友的支持！ |          |            |
| ---------------------------------------------------------- | -------- | ---------- |
| 打赏者                                                     | 打赏金额 | 打赏日期   |
| 微信：*光                                                  | 10.00    | 2019-04-14 |
| 微信：小罗                                                 | 10.00    | 2019-03-25 |
| 微信：*光                                                  | 5.00     | 2019-03-24 |
| 微信：*子                                                  | 10.00    | 2019-03-21 |
| 微信：云                                                   | 5.00     | 2019-03-19 |
| 支付宝：马伏硅                                             | 5.00     | 2019-03-08 |
| 支付宝：唯一                                               | 10.00    | 2019-02-02 |
| 微信：*亮                                                  | 5.00     | 2018-12-28 |
| 微信：流金岁月1978                                         | 10.00    | 2018-11-16 |
| 微信：，别输给自己，                                       | 20.00    | 2018-11-06 |

分类: [Linux基础篇](https://www.cnblogs.com/along21/category/1369919.html)