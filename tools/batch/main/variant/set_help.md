# set

## set help
```
显示、设置或删除 cmd.exe 环境变量。

SET [variable=[string]]

  variable  指定环境变量名。
  string    指定要指派给变量的一系列字符串。

要显示当前环境变量，键入不带参数的 SET。

如果命令扩展被启用，SET 会如下改变:

可仅用一个变量激活 SET 命令，等号或值不显示所有前缀匹配
SET 命令已使用的名称的所有变量的值。例如:

    SET P

会显示所有以字母 P 打头的变量

如果在当前环境中找不到该变量名称，SET 命令将把 ERRORLEVEL
设置成 1。

SET 命令不允许变量名含有等号。

在 SET 命令中添加了两个新命令行开关:

    SET /A expression
    SET /P variable=[promptString]

/A 命令行开关指定等号右边的字符串为被评估的数字表达式。该表达式
评估器很简单并以递减的优先权顺序支持下列操作:

    ()                  - 分组
    ! ~ -               - 一元运算符
    * / %               - 算数运算符
    + -                 - 算数运算符
    << >>               - 逻辑移位
    &                   - 按位“与”
    ^                   - 按位“异”
    |                   - 按位“或”
    = *= /= %= += -=    - 赋值
      &= ^= |= <<= >>=
    ,                   - 表达式分隔符

如果你使用任何逻辑或取余操作符， 你需要将表达式字符串用
引号扩起来。在表达式中的任何非数字字符串键作为环境变量
名称，这些环境变量名称的值已在使用前转换成数字。如果指定
了一个环境变量名称，但未在当前环境中定义，那么值将被定为
零。这使你可以使用环境变量值做计算而不用键入那些 % 符号
来得到它们的值。如果 SET /A 在命令脚本外的命令行执行的，
那么它显示该表达式的最后值。该分配的操作符在分配的操作符
左边需要一个环境变量名称。除十六进制有 0x 前缀，八进制
有 0 前缀的，数字值为十进位数字。因此，0x12 与 18 和 022 
相同。请注意八进制公式可能很容易搞混: 08 和 09 是无效的数字，
因为 8 和 9 不是有效的八进制位数。(& )

/P 命令行开关允许将变量数值设成用户输入的一行输入。读取输入
行之前，显示指定的 promptString。promptString 可以是空的。

环境变量替换已如下增强:

    %PATH:str1=str2%

会扩展 PATH 环境变量，用 "str2" 代替扩展结果中的每个 "str1"。
要有效地从扩展结果中删除所有的 "str1"，"str2" 可以是空的。
"str1" 可以以星号打头；在这种情况下，"str1" 会从扩展结果的
开始到 str1 剩余部分第一次出现的地方，都一直保持相配。

也可以为扩展名指定子字符串。

    %PATH:~10,5%

会扩展 PATH 环境变量，然后只使用在扩展结果中从第 11 个(偏
移量 10)字符开始的五个字符。如果没有指定长度，则采用默认
值，即变量数值的余数。如果两个数字(偏移量和长度)都是负数，
使用的数字则是环境变量数值长度加上指定的偏移量或长度。

    %PATH:~-10%

会提取 PATH 变量的最后十个字符。

    %PATH:~0,-2%

会提取 PATH 变量的所有字符，除了最后两个。

终于添加了延迟环境变量扩充的支持。该支持总是按默认值被
停用，但也可以通过 CMD.EXE 的 /V 命令行开关而被启用/停用。
请参阅 CMD /?

考虑到读取一行文本时所遇到的目前扩充的限制时，延迟环境
变量扩充是很有用的，而不是执行的时候。以下例子说明直接
变量扩充的问题:

    set VAR=before
    if "%VAR%" == "before" (
        set VAR=after
        if "%VAR%" == "after" @echo If you see this, it worked
    )

不会显示消息，因为在读到第一个 IF 语句时，BOTH IF 语句中
的 %VAR% 会被代替；原因是: 它包含 IF 的文体，IF 是一个
复合语句。所以，复合语句中的 IF 实际上是在比较 "before" 和
"after"，这两者永远不会相等。同样，以下这个例子也不会达到
预期效果:

    set LIST=
    for %i in (*) do set LIST=%LIST% %i
    echo %LIST%

原因是，它不会在目前的目录中建立一个文件列表，而只是将
LIST 变量设成找到的最后一个文件。这也是因为 %LIST% 在
FOR 语句被读取时，只被扩充了一次；而且，那时的 LIST 变量
是空的。因此，我们真正执行的 FOR 循环是:

    for %i in (*) do set LIST= %i

这个循环继续将 LIST 设成找到的最后一个文件。

延迟环境变量扩充允许你使用一个不同的字符(惊叹号)在执行
时间扩充环境变量。如果延迟的变量扩充被启用，可以将上面
例子写成以下所示，以达到预期效果:

    set VAR=before
    if "%VAR%" == "before" (
        set VAR=after
        if "!VAR!" == "after" @echo If you see this, it worked
    )

    set LIST=
    for %i in (*) do set LIST=!LIST! %i
    echo %LIST%

如果命令扩展被启用，有几个动态环境变量可以被扩展，但不会出现在 SET 显示的变
量列表中。每次变量数值被扩展时，这些变量数值都会被动态计算。如果用户用这些
名称中任何一个明确定义变量，那个定义会替代下面描述的动态定义:

%CD% - 扩展到当前目录字符串。

%DATE% - 用跟 DATE 命令同样的格式扩展到当前日期。

%TIME% - 用跟 TIME 命令同样的格式扩展到当前时间。

%RANDOM% - 扩展到 0 和 32767 之间的任意十进制数字。

%ERRORLEVEL% - 扩展到当前 ERRORLEVEL 数值。

%CMDEXTVERSION% - 扩展到当前命令处理器扩展版本号。

%CMDCMDLINE% - 扩展到调用命令处理器的原始命令行。

%HIGHESTNUMANODENUMBER% - 扩展到此计算机上的最高 NUMA 节点号。
```

## setx help
```

SetX 有三种使用方式: 

语法 1:
    SETX [/S system [/U [domain\]user [/P [password]]]] var value [/M]

语法 2:
    SETX [/S system [/U [domain\]user [/P [password]]]] var /K regpath [/M]

语法 3:
    SETX [/S system [/U [domain\]user [/P [password]]]]
         /F file {var {/A x,y | /R x,y string}[/M] | /X} [/D delimiters]

描述:
    在用户或系统环境创建或修改环境变量。能基于参数、注册表项或文件输
    入设置变量。

参数列表:
    /S     system          指定要连接到的远程系统。

    /U     [domain\]user   指定应该在哪个用户上下文执行命令。

    /P     [password]      指定给定用户上下文的密码。如果省略则
                           提示输入。

    var                    指定要设置的环境变量。

    value                  指定分配给环境变量的值。

    /K     regpath         指定变量是基于注册表项的信息而设置的。

                           路径的格式应该是 hive\key\...\value。例如
                           HKEY_LOCAL_MACHINE\System\CurrentControlSet\
                           Control\TimeZoneInformation\StandardName。

    /F     file            指定要使用的文本文件的文件名。

    /A     x,y             指定绝对文件坐标(线 X，项目 Y)作为在此文件
                           里搜索的参数。

    /R     x,y string      指定有关“字符串”作为搜索参数的相对文件坐标。

    /M                     指定应该在系统 (HKEY_LOCAL_MACHINE) 环境中设
                           置此变量。在 HKEY_CURRENT_USER 环境下，默认
                           将设置此变量。

    /X                     用 x，y 坐标显示文件内容。

    /D     delimiters      指定其他限定符，如 "," 或 "\"。
                           内置分隔符是空格、制表符、回车和换行符。所有
                           ASCII 字符都可作为限定符。限定符的最大数量，
                           包括内置分隔符，是 15。

    /?                     显示此帮助消息。

注意: 1) SETX 在注册表中将变量写入主机环境。

      2) 在本地系统，用此工具创建或修改的变量将在以后的命令窗口可用，但
         在当前的 CMD.exe 命令窗口。

      3) 在远程系统，用此工具创建或修改的变量在下次登录会话可用。

      4) 有效的注册表项数据类型是 REG_DWORD，REG_EXPAND_SZ，REG_SZ
         和 REG_MULTI_SZ。

      5) 受支持的配置单元:  HKEY_LOCAL_MACHINE (HKLM)，
         HKEY_CURRENT_USER (HKCU)。

      6) 限定符区分大小写。

      7) REG_DWORD 的值是从注册表里以十进制格式提取出来的。

示例:
    SETX MACHINE COMPAQ 
    SETX MACHINE "COMPAQ COMPUTER" /M
    SETX MYPATH "%PATH%"
    SETX MYPATH ~PATH~
    SETX /S system /U user /P password  MACHINE COMPAQ 
    SETX /S system /U user /P password MYPATH ^%PATH^% 
    SETX TZONE /K HKEY_LOCAL_MACHINE\System\CurrentControlSet\
         Control\TimeZoneInformation\StandardName
    SETX BUILD /K "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows
         NT\CurrentVersion\CurrentBuildNumber" /M
    SETX /S system /U user /P password TZONE /K HKEY_LOCAL_MACHINE\
         System\CurrentControlSet\Control\TimeZoneInformation\
         StandardName
    SETX /S system /U user /P password  BUILD /K 
         "HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\
         CurrentVersion\CurrentBuildNumber" /M
    SETX /F ipconfig.out /X 
    SETX IPADDR /F ipconfig.out /A 5,11 
    SETX OCTET1 /F ipconfig.out /A 5,3 /D "#$*." 
    SETX IPGATEWAY /F ipconfig.out /R 0,7 Gateway
    SETX /S system /U user /P password  /F c:\ipconfig.out /X
```

### demo
注意：

（1）在某些情况下会出现“setx无效语法 默认选项不能超过‘2’次”的错误，是因为原先的环境变量中存在空格导致的，可使用双引号进行避免。
（2）setx在设置变量的长度超过1024，会截取多出的字符。
（3）setx设置环境变量后，将在新打开的终端中生效，当前终端不会立即生效。
（4）setx在设置某一变量的值，如果已经存在该变量会覆盖之前的值。所以正确方式是：要保存值=获取当前该变量的值+新值。

例如：`set oldValue=获取当前变量值`
          `setx path %oldValue%;%newValue%`