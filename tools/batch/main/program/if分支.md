# if命令讲解
最近发现有些朋友一老问IF命令的用法,IF命令个人觉得很简单,所以就一直没把发放到新手教学贴里说,现在我给补上一文,希望对各位"非常BAT的"新手朋友们有所帮助.

现在开始:
在CMD使用IF /?打开IF的系统帮助(自己看我就不全部列出来了),我们会发现IF有3种基本的用法!
执行批处理程序中的条件处理。
IF [NOT] ERRORLEVEL number command
IF [NOT] string1==string2 command
IF [NOT] EXIST filename command
  NOT               指定只有条件为 false 的情况下， Windows XP 才
                    应该执行该命令。
  ERRORLEVEL number 如果最后运行的程序返回一个等于或大于
                    指定数字的退出编码，指定条件为 true。
  string1==string2  如果指定的文字字符串匹配，指定条件为 true。
  EXIST filename    如果指定的文件名存在，指定条件为 true。
  command           如果符合条件，指定要执行的命令。如果指定的
                     条件为 FALSE，命令后可跟一个执行 ELSE
                      关键字后的命令的 ELSE 命令。
ELSE 子句必须在 IF 之后出现在同一行上。例如:
    IF EXIST filename (
        del filename
    ) ELSE (
        echo filename missing
    )
第一种用法：IF [NOT] ERRORLEVEL number command
这个用法的基本做用是判断上一条命令执行结果的代码,以决定下一个步骤.
一般上一条命令的执行结果代码只有两结果,"成功"用0表示  "失败"用1表示.
举个例子:
``` bat
@echo off
net user
IF %ERRORLEVEL% == 0 echo net user 执行成功了!
pause
```
这是个简单判断上条命令是否执行成功.
细心的朋友可能会发现,这个用法和帮助里的用法不太一样,按照帮助里的写法"IF %ERRORLEVEL% == 0 echo net user 执行成功了!  "这一句代码应该写成:IF ERRORLEVEL 0 echo net user 执行成功了!
那为什么我要写成这样呢?各位自己把代码改掉执行后,就会发现错误了!用这种语法,不管你的上面的命令是否执行成功,他都会认为命令成功了,不知道是BUG还是本人理解错误...
补充：这不是bug，而是 if errorlevel 语句的特点：当使用 if errorlevel 0 …… 的句式时，它的含义是：如果错误码的值大于或等于0的时候，将执行某个操作；当使用 if %errorlevel%==0 …… 的句式时，它的含义是：如果错误码的值等于0的时候，将执行某操作。因为这两种句式含义的差别，如果使用前一种句式的时候，错误码语句的排列顺序是从大到小排列
%ERRORLEVEL% 这是个系统变量,返回上条命令的执行结果代码! "成功"用0表示  "失败"用1表示. 当然还有其他参数,用的时候基本就这两数字.
一般上一条命令的执行结果代码只有两结果,"成功"用0表示  "失败"用1表示
　　这只是一般的情况，实际上，errorlevel返回值可以在0~255之间，比如，xcopy默认的errorlevel值就有5个，分别表示5种执行状态：
退出码 说明
0 文件复制没有错误。
1 if errorlevel 2 echo。
2 用户按 CTRL+C 终止了 xcopy。
4 出现了初始化错误。没有足够的内存或磁盘空间，或命令行上输入了无效的驱动器名称或语法。
5 出现了磁盘写入错误。
要判断上面xcopy命令的5种退出情况，应写成：
if errorlevel 5 echo出现了磁盘写入错误
if errorlevel 4 echo出现了初始化错误
if errorlevel 2 echo用户按 CTRL+C 终止了 xcopy
if errorlevel 1 echo if errorlevel 2 echo
if errorlevel 0 echo文件复制没有错误。
才能正确执行。
补充完毕。


再举几个例子给新手理解
``` batch
@echo off
net usertest
IF %ERRORLEVEL% == 1 echo net user 执行失败了!
pause
这个是判断上一条命令是否执行失败的
@echo off
set /p var=随便输入个命令:
%var%
if %ERRORLEVEL% == 0 goto yes
goto no
:yes
echo !var! 执行成功了
pause
exit
:no
echo 基本上执行失败了..
pause
```

这个是根据你输入的命令,自动判断是成功还是失败了!

在来一个简化版的
``` batch
@echo off
set /p var=随便输入个命令:
%var%
if %ERRORLEVEL% == 0 (echo %var%执行成功了) ELSE echo %var%执行失败了!
pause
else后面写上执行失败后的操作!
当然我门还可以把if else这样的语句分成几行写出来,使他看上去好看点...
@echo off
set /p var=随便输入个命令:
%var%
if %ERRORLEVEL% == 0  (
   echo !var! 执行成功了
   ) ELSE (
   echo 基本上执行失败了..
   )
pause
```

这里介绍的两种简写对IF的三种语法都可以套用,不单单是在IF [NOT] ERRORLEVEL number command
这种法上才能用


第二种用法：IF [NOT] string1==string2 command
这个呢就是用来比较变量或者字符的值是不是相等的.
例子

``` batch
@echo off
set /p var=请输入第一个比较字符:
set /p var2=请输入第二个比较字符:
if %var% == %var2% (echo 我们相等) ELSE echo 我们不相等
pause
```

上面这个例子可以判断你输入的值是不是相等,但是你如果输入相同的字符,但是如果其中一个后面打了一个空格,
这个例子还是会认为相等,如何让有空格的输入不相等呢?我们在比较字符上加个双引号就可以了.
@echo off
set /p var=请输入第一个比较字符:
set /p var2=请输入第二个比较字符(多输入个空格试试):
if "%var%" == "%var2%" (echo 我们相等) ELSE echo 我们不相等
pause


第三种用法：IF [NOT] EXIST filename command
这个就是判断某个文件或者文件夹是否存在的语法
例子
@echo off
if exist "c:\test" (echo 存在文件) ELSE echo 不存在文件
pause
判断的文件路径加引号是为了防止路径有空格,如果路径有空格加个双引号就不会出现判断出错了!
这个语法没什么太多的用法,基本就这样了,就不多介绍了.
另外我们看到每条IF用法后都有个[NOT]语句,这啥意思?其他加上他的话,就表示先判断我们的条件不成立时,
没加他默认是先判断条件成立时,比如上面这个例子
```
@echo off
if not exist "c:\test" (echo 存在文件) ELSE echo 不存在文件
pause
```
加个NOT,执行后有什么结果,如果你的C盘下根本就没c:\test,他还是会显示"存在文件",这就表示了加了NOT就
会先判断条件失败!懂了吧,上面例子改成这样就正确了!
@echo off
if not exist "c:\test" (echo 不存在文件) ELSE echo 存在文件
pause

第四种用法：IF增强的用法
  IF [/I] string1 compare-op string2 command
  IF CMDEXTVERSION number command
  IF DEFINED variable command
后面两个用法,我不做介绍,因为他们和上面的用法表示的意义基本一样,只简单说说  IF [/I] string1 compare-op string2 command这个语句在判断字符时不区分字符的大小写。
CMDEXTVERSION 条件的作用跟 ERRORLEVEL 的一样，除了它
是在跟与命令扩展名有关联的内部版本号比较。第一个版本
是 1。每次对命令扩展名有相当大的增强时，版本号会增加一个。
命令扩展名被停用时，CMDEXTVERSION 条件不是真的。
如果已定义环境变量，DEFINED 条件的作用跟 EXISTS 的一样，
除了它取得一个环境变量，返回的结果是 true。


@echo off
if a == A (echo 我们相等) ELSE echo 我们不相等
pause
执行后会显示：我们不相等
@echo off
if /i a == A (echo 我们相等) ELSE echo 我们不相等
pause
加上/I不区分大小写就相等了!
最后面还有一些用来判断数字的符号
    EQU - 等于
    NEQ - 不等于
    LSS - 小于
    LEQ - 小于或等于
    GTR - 大于
    GEQ - 大于或等于
我就举一个例子,大家都懂数学...不讲多了
@echo off
set /p var=请输入一个数字:
if %var% LEQ  4 (echo 我小于等于4) ELSE echo 我不小于等于4
pause
