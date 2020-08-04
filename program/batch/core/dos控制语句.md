# DOS编程高级技巧
本章节乃龙卷风根据自己平时学用批处理的经验而总结的，不断补充中……。



## if…else…条件语句
前面已经谈到，DOS条件语句主要有以下形式
IF [NOT] ERRORLEVEL number command
IF [NOT] string1==string2 command
IF [NOT] EXIST filename command
增强用法：IF [/I] string1 compare-op string2 command
增强用法中加上/I就不区分大小写了!
增强用法中还有一些用来判断数字的符号：
EQU - 等于
NEQ - 不等于
LSS - 小于
LEQ - 小于或等于
GTR - 大于
GEQ - 大于或等于

上面的command命令都可以用小括号来使用多条命令的组合，包括else子句，组合命令中可以嵌套使用条件或循环命令。
例如:
    IF EXIST filename (
        del filename
    ) ELSE (
        echo filename missing
    )
也可写成：
if exist filename (del filename) else (echo filename missing)
但这种写法不适合命令太多或嵌套命令的使用。
## 循环语句
### 指定次数循环
FOR /L %variable IN (start,step,end) DO command [command-parameters]
组合命令：
FOR /L %variable IN (start,step,end) DO (
Command1
Command2
……
) 
### 对某集合执行循环语句。
FOR %%variable IN (set) DO command [command-parameters]
  %%variable  指定一个单一字母可替换的参数。
  (set)      指定一个或一组文件。可以使用通配符。
  command   对每个文件执行的命令，可用小括号使用多条命令组合。
FOR /R [[drive:]path] %variable IN (set) DO command [command-parameters]
    检查以 [drive:]path 为根的目录树，指向每个目录中的
    FOR 语句。如果在 /R 后没有指定目录，则使用当前
目录。如果集仅为一个单点(.)字符，则枚举该目录树。
同前面一样，command可以用括号来组合：
FOR /R [[drive:]path] %variable IN (set) DO (
Command1
Command2
……
commandn
)
### 条件循环
利用goto语句和条件判断，dos可以实现条件循环，很简单啦，看例子：

``` batch
@echo off
set var=0
rem ************循环开始了
:continue
set /a var+=1
echo 第%var%此循环
if %var% lss 100 goto continue
rem ************循环结束了
echo 循环执行完毕
pause
```


