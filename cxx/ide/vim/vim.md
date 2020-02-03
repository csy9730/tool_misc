# VIM笔记
[TOC]
## 基础
VIM是linux下常用的文本编辑工具，没有窗口界面，命令行内执行编辑操作。



``` bash
apt install vim # 安装 
vim my.txt # 打开
```


### 状态模式简介
* 命令模式（Command mode）
* 编辑模式（Edit mode）
* 底行模式（Last line mode）


**命令模式**：控制光标的移动，字符、字或行的删除，移动复制某区段。vim打开文件之后的初始默认模式，任何模式下按「ESC」到命令行模式
**编辑模式**：文本输入。命令行模式输入I,A,O,S,C,i,a,o,s,c,R,到插入模式或替换模式
**底行模式**：文件的保存退出等操作，命令行模式再按:进入。

### 命令操作
* 状态切换符 Esc和:
* 普通文本编辑 insert/Replace
* 光标移动 motion: up/down/left/right/home/end/ctrl+home/ctrl+end/pageup/pagedown/...
* 常用编辑操作命令：剪切/复制/黏贴/查找
* 选择命令： v/ ctrl+v /V 
* 底行操作命令: save/open/new
* 其他命令：
    * 复数命令，搭配其他命令实现重复多次的效果


#### 编辑状态切换

以下命令进入插入模式或替换模式：a A i I S s O o r R C c
a       //在当前光标位置的右边添加文本
i        //在当前光标位置的左边添加文本
A      //在当前行的末尾位置添加文本
I       //在当前行的开始处添加文本(非空字符的行首)
O     //在当前行的上面新建一行
o     //在当前行的下面新建一行
R     //替换(覆盖)当前光标位置及后面的若干文本
S       // 删除行并输入
s       // 删除字符并输入

#### 光标移动motion
命令模式下，可以使用以下方法移动光标
* 基础移动：hjkl space，enter，
*  以word为单位移动：w,b,e,W,E,B	 
* 单行跳转 $^0 ()+    
*  括号跳转  %	 
* 翻页ctrl+b,ctrl+f,ctrl+u,ctrl+d,ctrl+e,ctrl+y
* 屏幕内：H，M，L 
* 全文行跳转gg,G, #n G
* 行内单字母查找：f[a~z],F[a~z],t[a~z],T[a~z]
* 正则表达式搜索跳转
* mark 跳转
* 历史记录跳转 Ctrl+o，ctrl+i

h/j/k/l 对应left/down/up/right,space对应光标前进一个单位，不换行时相当于l，enter对应光标换行,不换行时相当于j
基础光标移动指令hjkl经常指定次数执行，#n space,#n Enter ,#n l 
* 单词跳转
  * wW跳转到下个单次词头，Bb跳转到上一个单词词头，Ee跳转到下一个单次词尾。
  * 单次跳转快捷键w,b,e对应的word（按字母分割word）较严格，单次跳转快捷键W,B,E对应分割的WORD较宽泛（按空格分割WORD）。
* 行跳转： 0=^=[Home]，$=[END]
* 屏幕跳转：
  * ctrl+b =[PageUp],ctrl+f=[PageDown],ctrl+u=[HalfPageUp],ctrl+d=[HalfPageDown]
  * ctrl+e,ctrl+y 等于鼠标中键滚轮操作，上下翻滚一样屏幕，光标相对文本位置不变。
  * H/M/L 光标跳转到当前屏幕的顶端/中部/末尾
* 全文跳转： gg = 1G=[Ctrl+Home],G =[Ctrl+End]
* 行单字符跳转:向后查找单字母，F向前查找单字母，t向后查找单字母，再回退一格。T向前查找，再回退一格。

#### 基础编辑操作

* 删除(默认都会加入剪切板）x，X ,D, c, J(删除当前行的回车）
* 复制y，剪切d，粘贴p,P（光标前粘贴） 
* 撤销u,行内撤销U，恢复撤销：Ctrl + r 
* 其他  . (重复上次操作） ， 

* 直接删除操作：x=[Del]；X =[Backspace]；
* 选择删除操作：
  * 从当前直到行尾选择字符并删除：D =[Shift+End Del] =d$；
  * c等同于d，会自动进入insert mode，C等同于D，删除完成后自动进入插入模式；
* 剪切d，复制y支持光标操作组合(例如w,gg,G,0,$)：dw, dgg=d1G, dG (Ctrl+Shift+end+del),d0,ygg=y1G,yG,y0,cw
* yy 复制当前行，dd剪切当前行，#ndd， #nx
#### 选择模式
v进入选择模式，V进入行选择模式，ctrl+v进入块选择模式。
配合 x,d,y,p使用
注意：d/y/p单独使用是先编辑后选择;开启选择模式之后，就是先选择后编辑
##### 块选择模式
在块模式下，可以进行多列的同时修改，效果等同于notepad++的列块编辑。修改方法是：
1.  首先进入块模式 Ctrl+ v
2.  使用按键j/k/h/l进行选中多列
3.  按键Shift + i 进行 块模式下的插入
4.  输入字符之后，按键ESC，完成多行的插入

#### 正则表达式

查找词语操作：
?命令向后搜索关键字；"/"命令向前搜索关键字。
激活查找命令之后，n跳转到下个关键字，N跳转到上个关键字。
组合命令："*" 命令从当前光标到下个空格前为止，选择作为搜索的关键字搜索；#向前搜索。

##### replace

使用 /word 配合 n 及 N 是非常有帮助的！可以让你重复的找到一些你搜寻的关键词！
``` bash
:n1,n2s/word1/word2/g # n1 与 n2 为数字。在第 n1 与 n2 行之间寻找 word1 这个字符串，并将该字符串取代为 word2
# 举例来说，在 100 到 200 行之间搜寻 vbird 并取代为 VBIRD 则：『:100,200s/vbird/VBIRD/g』。(常用))
:1,$s/word1/word2/g # 从第一行到最后一行寻找 word1 字符串，并将该字符串取代为 word2 ！(常用)
:%s/word1/word2/g # 同上
1,$s/word1/word2/gc #从第一行到最后一行寻找 word1 字符串，并将该字符串取代为 word2 ！且在取代前显示提示字符给用户确认 (confirm) 是否需要取代！(常用)
 :%s/word1/word2/gc  # 同上
```

#### mark
``` bash
ma #将当前位置标记为a，26个字母均可做标记， mb 、 mc 等等；
 `a # 跳转到a标记的位置； - 这是一组很好的文档内标记方法，在文档中跳跃编辑时很有用    
```
#### macro
```
qa# 将之后的所有键盘操作录制下来，直到再次在命令模式按下 q ，并存储在 a 中；
@a # 执行刚刚记录在 a 里面的键盘操作；
@@ # 执行上一次的macro操作；宏操作是VIM最为神奇的操作之一，需要慢慢体会其强大之处；
```

### 底行操作
#### 文件操作
``` bash
:w # 保存文件
:wq # 保存文件并退出
:q! # 强制退出不保存
:e abc.txt # 打开文件abc.txt
:f abc.txt # 同上
:new abc.txt # 新建abc.txt
:w [filename] # 另存为filename
:r [filename] # 尾追加文件内容
:n1,n2 w [filename] # 部分另存为filename
```
#### 多文件操作

``` bash 
vim file1 file2 ... filen # 便可以打开所有想要打开的文件
vi -o file1 file2 file3... # .用分割屏幕窗口方式同时打开多个文件
:open file #可以再打开一个文件，并且此时vim里会显示出file文件的内容。
:files #查看当前打开了哪些文件 

# 当前窗格切换
Ctrl+6 #切换下一个文件
:bn # 切换下一个文件
:bp # 切换上一个文件
:bd # 
:b2 # 
:n 切换到下一个文件
:N 切换到上一个文件

## 新建多个窗格
:split # 水平切割显示多个文件
:vsplit # 垂直切割显示多个文件
:3split # 切割三行显示文件，
# 多个窗格间切换的方法
Ctrl+w+up #  换到前／下／上／后一个窗格
Ctrl+w+h/j/k/l # 同上
Ctrl+w+t/b # 历史记录前进后退窗格
Ctrl+w+H/J/K/L # 交换窗格位置
Ctrl+ww # 依次向后切换到下一个窗格中
ctrl+w +/- # 放缩窗格，难以控制
ctrl+w+_ # 尽可能放大窗格
:qall # 关闭所有窗格

```
#### 文件夹打开

``` bash
#vim命令模式下
:e
:Explore #当前窗口下打开
:Vexplore #竖直分割窗口打开
:Sexplore #水平分割窗口打开
i # 切换文件视图
```


#### 会话管理
:mksession Foo.vim
:source Foo.vim

#### 寄存器

1. 未命名寄存器
（unnamed register） `""` —— vim使用的默认寄存器，文本来源命令：d/c/s/x/y
2. GUI选择寄存器 `"*` `"+` `"~` —— vim缓存在GUI中选择的文本,非常重要，外部程序交互靠它。+对应剪切板。×对应复制板
3. 10个数字命名寄存器 `"0 `- `"9` —— vim缓存yank和delete行操作命令（y，d，x，c）产生的文本
4. 1个非行删除内容缓存寄存器 "- —— vim缓存delete操作在非行上时产生的文本
5.  26个字母命名寄存器 "a - "z / "A - "Z —— 完全由用户指定内容的寄存器
6.  4个只读寄存器 ". "% "# ":  
7.   表达式寄存器 "= —— 使用VIM强大的表达式功能（从来没用过，一点不懂）
8. 黑洞寄存器 "_ —— 类似Linux中的/dev/null文件，只进不出，可用来滤掉影响默认寄存器的内容
9. 最后搜索模式寄存器 "/ —— 缓存在vim中使用过的最后的搜索内容

寄存器操作可以搭配 复制剪切黏贴操作，
``` bash  
   "*y # 复制到系统剪切板
   "+Y # 复制当前行到系统剪切板
   "+nY #  复制当前行往下 n 行到系统剪切板
  :dis  # 显示寄存器
  :reg # 显示寄存器
  "*p  # 使用系统剪切板黏贴
  "+p  # 使用系统剪切板黏贴（然后清除"*寄存器）
```

##### 复制

更好的做法是，在vim中使用 "*y 使用进行复制，然后在应用程序中用ctrl+v粘贴。
从应用程序到vim则在应用程序中使用ctrl+c复制，在vim中使用shift+insert粘贴。
可以在vimrc中加入`
set clipboard=unnamed` 来使y和"+y等效。



#### misc
``` bash
:set nu	# 显示行号，设定之后，会在每一行的前缀显示该行的行号
:set nonu	# 为取消行号！
:h # 打印帮助文档
:syntax on # 语法高亮显示
:set tabstop=4
:set softtabstop=4
:set autoindent
:version
:highlight Normal ctermbg=1 guibg=red
```
#### shell调用
``` bash
:! command	# 暂时离开 vi 到指令行模式下执行 command 的显示结果！例如
#『:! ls /home』即可在 vi 当中察看 /home 底下以 ls 输出的档案信息！
:! cmd # 交互式显示cmd
```

**Q**: 如何在vim和shell之间重定向操作?
**A**: 操作如下：
希望把 .cc 后缀更名为 .cpp，可以在Vim中通过` :read !ls *.cc `命令将shell命令` ls *.cc`的输出重定向到Vim缓冲区中，再使用Vim替换命令` :%s/\(.*\).cc/mv & \1.cpp `生成shell重命名命令mv，最后使用 `:write !sh` 执行当前缓存区中的每一行，从而达到对所有 .cc 文件重命名为 .cpp 的目的。

### misc
vimdiff
gvimdiff
gvim

viewdiff

![cebaad1cced413d7e61369ea85b0a267.png](en-resource://database/7039:1)
![7cd866e532f63459ecba360a8b1afedc.png](en-resource://database/7041:1)
### 配置
gvim 配置
C:\Program Files (x86)\Vim\vim81\gvim.exe
C:\Program Files (x86)\Vim\_vimrc
vim 无法打开并写入文件
使用高级管理员权限



``` bash
""""""""""""""""""""""""""""""
" netrw setting
""""""""""""""""""""""""""""""
let g:netrw_winsize = 30
nmap <silent> <leader>fe :Sexplore!<cr> 
```
## 参考

http://yianwillis.github.io/vimcdoc/doc/help.html

##　精简化
考虑使用部分vim快捷键，加快效率
光标操作+ 编辑操作+ 命令操作切换
vfx 用法
/ sfsf
查找与替换
:s（substitute）命令用来查找和替换字符串。语法如下：
:{作用范围}s/{目标}/{替换}/{替换标志}
例如:%s/foo/bar/g会在全局范围(%)查找foo并替换为bar，所有出现都会被替换（g）
/foo\c

当前行：
:s/foo/bar/g
全文：
:%s/foo/bar/g
选区，在Visual模式下选择区域后输入:，Vim即可自动补全为 :'<,'>。
:'<,'>s/foo/bar/g


全局替换
行替换
块替换，注意 所有块选都会转换成行选模式，然后替换。
/g 有何作用？