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


### 配置
gvim 配置
windows 下，gvim路径是
`C:\Program Files (x86)\Vim\vim81\gvim.exe`
对应配置文件：
`C:\Program Files (x86)\Vim\_vimrc`


vim 无法打开并写入文件,使用高级管理员权限



``` bash
""""""""""""""""""""""""""""""
" netrw setting
""""""""""""""""""""""""""""""
let g:netrw_winsize = 30
nmap <silent> <leader>fe :Sexplore!<cr> 
```
## 参考

[vimcdoc](http://yianwillis.github.io/vimcdoc/doc/help.html)

##　精简化

vim工具经过了长期的更新，增加了很多特性：类似tmux的面板管理，支持shell交互，文件夹预览特性，插件特性，配置控制，会话管理。
但vim的核心还是通过键盘，替换鼠标的工作，完成文本编辑。许多的现代IDE如VisualStudio，Vsocde，都有vim-like插件。vim终究是没有开箱即用的IDE好用。
曾经的VIM承载了许多geek的传说，人们热烈的讨论着什么工具才是最好用的IDE，承载了对编程工作的想象，现在有更多更好的工具之后，对编程的幻想却薄弱了。

考虑使用部分vim快捷键，加快效率
光标操作+ 编辑操作+ 命令操作切换
`vfx` 用法
查找: `/ sfsf`
查找与替换
:s（substitute）命令用来查找和替换字符串。语法如下：
:{作用范围}s/{目标}/{替换}/{替换标志}
例如:`%s/foo/bar/g`会在全局范围(%)查找foo并替换为bar，所有出现都会被替换（g）
/foo\c

当前行：
`:s/foo/bar/g`
全文：
`:%s/foo/bar/g`
选区，在Visual模式下选择区域后输入:，Vim即可自动补全为 :'<,'>。
`:'<,'>s/foo/bar/g`


全局替换
行替换
块替换，注意 所有块选都会转换成行选模式，然后替换。
/g 有何作用？

### encoding

$vim ~/.vimrc
``` 
let &termencoding=&encoding
set fileencodings=utf-8,gbk
```
