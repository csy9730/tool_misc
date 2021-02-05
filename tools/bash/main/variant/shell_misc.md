## [[转\] Bash中的if](https://www.cnblogs.com/haivey/archive/2012/09/04/2669870.html)



[if语法[Linux(bash_shell)\]](https://www.cnblogs.com/haivey/archive/2012/09/04/2669870.html#a1)

[BASH IF](https://www.cnblogs.com/haivey/archive/2012/09/04/2669870.html#a2)

[我使用过的Linux命令之if - Bash中的条件判断语句](https://www.cnblogs.com/haivey/archive/2012/09/04/2669870.html#a3)

[关于bash中if语法结构的广泛误解](https://www.cnblogs.com/haivey/archive/2012/09/04/2669870.html#a4)

[Linux 技巧：Bash的测试和比较函数（探密test，[，[[，((和if-then-else）](https://www.cnblogs.com/haivey/archive/2012/09/04/2669870.html#a5)

# if语法[Linux(bash_shell)]

<http://blog.csdn.net/ycl810921/article/details/4988778>

1:
定义变量时, =号的两边不可以留空格.
eg:
```
gender=femal------------right
gender =femal-----------wrong
gender= femal-----------wrong
```

2 条件测试语句 [ 符号的两边都要留空格.
eg:
```
if [ $gender = femal ]; then-------right.
     echo "you are femal";
fi

if[ $gender...-----------------------wrong
if [$gender...----------------------wrong.
```

3 条件测试的内容,如果是字符串比较的话, 比较符号两边要留空格!
eg:
```
if [ $gender = femal ]; then-------right.
if [ $gender= femal ]; then--------wrong.
if [ $gender=femal ]; then---------wrong.
```

4 如果if 和 then写在同一行, 那么,注意, then的前面要跟上 ; 号.
如果 then 换行写, 那么也没问题.
eg:
```
if [ $gender = femal ]; then-------right.
if [ $gender = femal ]
     then-------------------------------right.
if [ $gender = femal ] then-------wrong. then前面少了 ; 号.
```
提示出错信息:
`syntax error near unexpected token then`
同理,还有很多出错信息 比如
`syntax error near unexpected token fi` 等都是这样引起的.

5 if 后面一定要跟上 then. 同理
elif 后面一定要跟上 then.
不然提示出错信息:
syntax error near unexpected token else

[ top](https://www.cnblogs.com/haivey/archive/2012/09/04/2669870.html#a0)

 

# BASH IF  

<http://lhsblog01.blog.163.com/blog/static/10200451920081118105937818/>

Linux SHELL if 命令参数说明
2007年10月30日 星期二 08:47

- –b 当file存在并且是块文件时返回真
- -c 当file存在并且是字符文件时返回真
- -d 当pathname存在并且是一个目录时返回真
- -e 当pathname指定的文件或目录存在时返回真
- -f 当file存在并且是正规文件时返回真
- -g 当由pathname指定的文件或目录存在并且设置了SGID位时返回为真
- -h 当file存在并且是符号链接文件时返回真，该选项在一些老系统上无效
- -k 当由pathname指定的文件或目录存在并且设置了“粘滞”位时返回真
- -p 当file存在并且是命令管道时返回为真
- -r 当由pathname指定的文件或目录存在并且可读时返回为真
- -s 当file存在文件大小大于0时返回真
- -u 当由pathname指定的文件或目录存在并且设置了SUID位时返回真
- -w 当由pathname指定的文件或目录存在并且可执行时返回真。一个目录为了它的内容被访问必然是可执行的。
  - -o 当由pathname指定的文件或目录存在并且被子当前进程的有效用户ID所指定的用户拥有时返回真。

UNIX Shell 里面比较字符写法：

- -eq   等于
- -ne    不等于
- -gt    大于
- -lt    小于
- -le    小于等于
- -ge   大于等于
- -z    空串
- =    两个字符相等
- !=    两个字符不等
- -n    非空串 

 
``` bash
#这里的-d 参数判断$myPath是否存在
if [ ! -d "$myPath"]; then
mkdir "$myPath"
fi

# 这里的-f参数判断$myFile是否存在
if [ ! -f "$myFile" ]; then
touch "$myFile"
fi
```

[top](https://www.cnblogs.com/haivey/archive/2012/09/04/2669870.html#a0)


 