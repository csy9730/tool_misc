# java help


## bin
```
 C:\Program Files\Java\jdk-11.0.2\bin 的目录

jabswitch.exe
jaccessinspector.exe
jaccesswalker.exe
jaotc.exe
jar.exe
jarsigner.exe
java.exe
javac.exe
javadoc.exe
javap.exe
javaw.exe
jcmd.exe
jconsole.exe
jdb.exe
jdeprscan.exe
jdeps.exe
jhsdb.exe
jimage.exe
jinfo.exe
jjs.exe
jlink.exe
jmap.exe
jmod.exe
jps.exe
jrunscript.exe
jshell.exe
jstack.exe
jstat.exe
jstatd.exe
keytool.exe
kinit.exe
klist.exe
ktab.exe
pack200.exe
rmic.exe
rmid.exe
rmiregistry.exe
serialver.exe
unpack200.exe
```

## help
```
D:\Projects>java -h 
用法: java [-options] class [args...]
           (执行类)
   或  java [-options] -jar jarfile [args...]
           (执行 jar 文件)
其中选项包括:
    -d32          使用 32 位数据模型 (如果可用)
    -d64          使用 64 位数据模型 (如果可用)
    -server       选择 "server" VM
                  默认 VM 是 server.

    -cp <目录和 zip/jar 文件的类搜索路径>
    -classpath <目录和 zip/jar 文件的类搜索路径>
                  用 ; 分隔的目录, JAR 档案
                  和 ZIP 档案列表, 用于搜索类文件。
    -D<名称>=<值>
                  设置系统属性
    -verbose:[class|gc|jni]
                  启用详细输出
    -version      输出产品版本并退出
    -version:<值>
                  警告: 此功能已过时, 将在
                  未来发行版中删除。
                  需要指定的版本才能运行
    -showversion  输出产品版本并继续
    -jre-restrict-search | -no-jre-restrict-search
                  警告: 此功能已过时, 将在
                  未来发行版中删除。
                  在版本搜索中包括/排除用户专用 JRE
    -? -help      输出此帮助消息
    -X            输出非标准选项的帮助
    -ea[:<packagename>...|:<classname>]
    -enableassertions[:<packagename>...|:<classname>]
                  按指定的粒度启用断言
    -da[:<packagename>...|:<classname>]
    -disableassertions[:<packagename>...|:<classname>]
                  禁用具有指定粒度的断言
    -esa | -enablesystemassertions
                  启用系统断言
    -dsa | -disablesystemassertions
                  禁用系统断言
    -agentlib:<libname>[=<选项>]
                  加载本机代理库 <libname>, 例如 -agentlib:hprof
                  另请参阅 -agentlib:jdwp=help 和 -agentlib:hprof=help
    -agentpath:<pathname>[=<选项>]
                  按完整路径名加载本机代理库
    -javaagent:<jarpath>[=<选项>]
                  加载 Java 编程语言代理, 请参阅 java.lang.instrument
    -splash:<imagepath>
                  使用指定的图像显示启动屏幕
有关详细信息, 请参阅 http://www.oracle.com/technetwork/java/javase/documentation/index.html。
```

## **javaws.exe**

javaws.exe进程适用于启动通过web 配置的程序，简而言之就是在web应用程序中应用。

总结：

java.exe用于启动window console  控制台程序

javaw.exe用于启动 GUI程序

javaws.exe用于web程序。

jvm.dll就是java虚拟机规范在windows平台上的一种实现


java.exe  和 javaw.exe两种运行方式的区别还有一点  java运行GUI以后堵塞在那里直到窗口关闭。

javaw运行GUI后 直接就可以进行下一条命令的运行了。

## jcmd
```
D:\Projects\mylib\tool_misc\program\java\tutorial\eExtend>jcmd -help
Usage: jcmd <pid | main class> <command ...|PerfCounter.print|-f file>
   or: jcmd -l
   or: jcmd -h

  command must be a valid jcmd command for the selected jvm.
  Use the command "help" to see which commands are available.
  If the pid is 0, commands will be sent to all Java processes.
  The main class argument will be used to match (either partially
  or fully) the class used to start Java.
  If no options are given, lists Java processes (same as -l).

  PerfCounter.print display the counters exposed by this process
  -f  read and execute commands from the file
  -l  list JVM processes on the local machine
  -? -h --help print this help message
  ```

## jconsole
gui 

监视和管理控制平台

## javap

```
用法: javap <options> <classes>
其中, 可能的选项包括:
  -? -h --help -help               输出此帮助消息
  -version                         版本信息
  -v  -verbose                     输出附加信息
  -l                               输出行号和本地变量表
  -public                          仅显示公共类和成员
  -protected                       显示受保护的/公共类和成员
  -package                         显示程序包/受保护的/公共类
                                   和成员 (默认)
  -p  -private                     显示所有类和成员
  -c                               对代码进行反汇编
  -s                               输出内部类型签名
  -sysinfo                         显示正在处理的类的
                                   系统信息 (路径, 大小, 日期, MD5 散列)
  -constants                       显示最终常量
  --module <模块>, -m <模块>       指定包含要反汇编的类的模块
  --module-path <路径>             指定查找应用程序模块的位置
  --system <jdk>                   指定查找系统模块的位置
  --class-path <路径>              指定查找用户类文件的位置
  -classpath <路径>                指定查找用户类文件的位置
  -cp <路径>                       指定查找用户类文件的位置
  -bootclasspath <路径>            覆盖引导类文件的位置

GNU 样式的选项可使用 = (而非空白) 来分隔选项名称
及其值。

每个类可由其文件名, URL 或其
全限定类名指定。示例:
   path/to/MyClass.class
   jar:file:///path/to/MyJar.jar!/mypkg/MyClass.class
   java.lang.Object
```

## jar
```
用法: jar [OPTION...] [ [--release VERSION] [-C dir] files] ...
jar 创建类和资源的档案, 并且可以处理档案中的
单个类或资源或者从档案中还原单个类或资源。

 示例:
 # 创建包含两个类文件的名为 classes.jar 的档案:
 jar --create --file classes.jar Foo.class Bar.class
 # 使用现有的清单创建档案, 其中包含 foo/ 中的所有文件:
 jar --create --file classes.jar --manifest mymanifest -C foo/ .
 # 创建模块化 jar 档案, 其中模块描述符位于
 # classes/module-info.class:
 jar --create --file foo.jar --main-class com.foo.Main --module-version 1.0
     -C foo/ classes resources
 # 将现有的非模块化 jar 更新为模块化 jar:
 jar --update --file foo.jar --main-class com.foo.Main --module-version 1.0
     -C foo/ module-info.class
 # 创建包含多个发行版的 jar, 并将一些文件放在 META-INF/versions/9 目录中:
 jar --create --file mr.jar -C foo classes --release 9 -C foo9 classes

要缩短或简化 jar 命令, 可以在单独的文本文件中指定参数,
并使用 @ 符号作为前缀将此文件传递给 jar 命令。

 示例:
 # 从文件 classes.list 读取附加选项和类文件列表
 jar --create --file my.jar @classes.list


 主操作模式:

  -c, --create               创建档案
  -i, --generate-index=FILE  为指定的 jar 档案生成
                             索引信息
  -t, --list                 列出档案的目录
  -u, --update               更新现有 jar 档案
  -x, --extract              从档案中提取指定的 (或全部) 文件
  -d, --describe-module      输出模块描述符或自动模块名称

 在任意模式下有效的操作修饰符:

  -C DIR                     更改为指定的目录并包含
                             以下文件
  -f, --file=FILE            档案文件名。省略时, 基于操作
                             使用 stdin 或 stdout
      --release VERSION      将下面的所有文件都放在
                             jar 的版本化目录中 (即 META-INF/versions/VERSION/)
  -v, --verbose              在标准输出中生成详细输出

 在创建和更新模式下有效的操作修饰符:

  -e, --main-class=CLASSNAME 捆绑到模块化或可执行 
                             jar 档案的独立应用程序
                             的应用程序入口点
  -m, --manifest=FILE        包含指定清单文件中的
                             清单信息
  -M, --no-manifest          不为条目创建清单文件
      --module-version=VERSION    创建模块化 jar 或更新
                             非模块化 jar 时的模块版本
      --hash-modules=PATTERN 计算和记录模块的散列, 
                             这些模块按指定模式匹配并直接或
                             间接依赖于所创建的模块化 jar 或
                             所更新的非模块化 jar
  -p, --module-path          模块被依赖对象的位置, 用于生成
                             散列

 只在创建, 更新和生成索引模式下有效的操作修饰符:

  -0, --no-compress          仅存储; 不使用 ZIP 压缩

 其他选项:

  -?, -h, --help[:compat]    提供此帮助，也可以选择性地提供兼容性帮助
      --help-extra           提供额外选项的帮助
      --version              输出程序版本

 如果模块描述符 'module-info.class' 位于指定目录的
 根目录中, 或者位于 jar 档案本身的根目录中, 则
 该档案是一个模块化 jar。以下操作只在创建模块化 jar,
 或更新现有的非模块化 jar 时有效: '--module-version',
 '--hash-modules' 和 '--module-path'。

 如果为长选项提供了必需参数或可选参数, 则它们对于
 任何对应的短选项也是必需或可选的。

```

## jdb

```
用法：jdb <选项> <类> <参数>

其中，选项包括：
    -? -h --help -help 输出此消息并退出
    -sourcepath <由 ";" 分隔的目录>
                      要在其中查找源文件的目录
    -attach <地址>
                      使用标准连接器附加到指定地址处正在运行的 VM
    -listen <地址>
                      等待正在运行的 VM 使用标准连接器在指定地址处连接
    -listenany
                      等待正在运行的 VM 使用标准连接器在任何可用地址处连接
    -launch
                      立即启动 VM 而不是等待 'run' 命令
    -listconnectors   列出此 VM 中的可用连接器
    -connect <连接器名称>:<名称 1>=<值 1>,...
                      使用所列参数值通过指定的连接器连接到目标 VM
    -dbgtrace [flags] 输出调试 jdb 的信息
    -tclient          在 HotSpot(TM) 客户机编译器中运行应用程序
    -tserver          在 HotSpot(TM) 服务器编译器中运行应用程序

转发到被调试进程的选项：
    -v -verbose[:class|gc|jni]
                      启用详细模式
    -D<名称>=<值>  设置系统属性
    -classpath <由 ";" 分隔的目录>
                      列出要在其中查找类的目录
    -X<选项>        非标准目标 VM 选项

<类> 是要开始调试的类的名称
<参数> 是传递到 <类> 的 main() 方法的参数

要获得命令的帮助，请在 jdb 提示下键入 'help'

```
## jlink

```
错误: 未知选项: -help
用法: jlink <选项> --module-path <模块路径> --add-modules <模块>[,<模块>...]
使用 --help 可列出可能的选项

```

## jshell
```
用法：   jshell <选项>... <加载文件>...
其中，可能的选项包括：
    --class-path <路径>   指定查找用户类文件的位置
    --module-path <路径>  指定查找应用程序模块的位置
    --add-modules <模块>(,<模块>)*
                          指定要解析的模块；如果 <模块> 
                          为 ALL-MODULE-PATH，则为模块路径中的所有模块
    --enable-preview      允许代码依赖于此发行版的预览功能
    --startup <文件>      对启动定义执行单次替换
    --no-startup          不运行启动定义
    --feedback <模式>     指定初始反馈模式。该模式可以是
                            预定义的（silent、concise、normal 或 verbose），
                            也可是以前用户定义的
    -q                    无提示反馈。等同于：--feedback concise
    -s                    真正无提示反馈。等同于：--feedback silent
    -v                    详细反馈。等同于：--feedback verbose
    -J<标记>              直接将 <标记> 传递到运行时系统。
                            为每个运行时标记或标记参数使用一个 -J
    -R<标记>              将 <标记> 传递到远程运行时系统。
                            为每个远程标记或标记参数使用一个 -R
    -C<标记>              将 <标记> 传递到编译器。
                            为每个编译器标记或标记参数使用一个 -C
    --version             输出版本信息并退出
    --show-version        输出版本信息并继续
    --help, -?, -h        输出标准选项的此提要并退出
    --help-extra, -X      输出非标准选项的帮助并退出

文件参数可以是文件名，或者是预定义的文件名之一：DEFAULT、
PRINTING 或 JAVASE。
加载文件也可以是 "-"，用于指明标准输入，没有交互式 I/O。

有关评估上下文选项（--class-path、
--module-path 和 --add-modules）的详细信息，请参见：
	/help context

路径列出要搜索的目录和档案。对于 Windows，请使用
分号 (;) 来分隔路径中的项。在其他平台上，请使用
冒号 (:) 来分隔各项。

```

## javadoc

```
用法:
    javadoc [options] [packagenames] [sourcefiles] [@files]
其中, 选项包括:
    --add-modules <模块>(,<模块>)*
                  除了初始模块之外要解析的根模块; 
                  如果 <模块> 为 ALL-MODULE-PATH, 
                  则为模块路径中的所有模块。
    -bootclasspath <路径>
                  覆盖用于非模块化发行版的
                  平台类文件的位置
    -breakiterator
                  计算带有 BreakIterator 的第一个语句
    --class-path <路径>, -classpath <路径>, -cp <路径>
                  指定查找用户类文件的位置
    -doclet <类>   通过替代 doclet 生成输出
    -docletpath <路径>
                  指定查找 doclet 类文件的位置
    --enable-preview
                  启用预览语言功能。与 -source 或 --release 
                  一起使用。
    -encoding <名称>
                  源文件编码名称
    -exclude <程序包列表>
                  指定要排除的程序包列表
    --expand-requires <值>
                  指示工具展开要文档化的模块集。
                  默认情况下, 将仅文档化命令行中明确
                  指定的模块。值 "transitive" 将额外包含
                  这些模块的所有 "requires transitive"
                  被依赖对象。值 "all" 将包含这些模块
                  的所有被依赖对象。
    -extdirs <目录列表>
                  覆盖所安装扩展的位置
    --help, -help, -?, -h
                  显示命令行选项并退出
    --help-extra, -X
                  输出非标准选项的提要并退出
    -J<标记>        直接将 <标记> 传递给运行时系统
    --limit-modules <模块>(,<模块>)*
                  限制可观察模块的领域
    -locale <名称>  要使用的区域设置, 例如, en_US 或 en_US_WIN
    --module <模块>(,<模块>)*
                  文档化指定模块
    --module-path <路径>, -p <路径>
                  指定查找应用程序模块的位置
    --module-source-path <路径>
                  指定查找多个模块的输入源文件的位置
    -package
                  显示程序包/受保护/公共类型和成员。对于 
                  命名模块, 显示所有程序包和所有模块详细信息。
    -private
                  显示所有类型和成员。对于命名模块,
                  显示所有程序包和所有模块详细信息。
    -protected
                  显示受保护/公共类型和成员 (默认设置)。对于
                  命名模块, 显示导出的程序包和模块的 API。
    -public
                  只显示公共类型和成员。对于命名模块,
                  显示导出的程序包和模块的 API。
    -quiet        不显示状态消息
    --release <发行版>
                  提供与指定发行版的源兼容性
    --show-members <值>
                  指定将文档化的成员 (字段, 方法等), 其值可以
                  为 "public", "protected", "package" 或 
                  "private" 之一。默认值为 "protected", 该值将
                  显示公共和受保护成员, "public" 将仅显示
                  公共成员, "package" 将显示公共, 受保护和
                  程序包成员, "private" 将显示所有成员。
    --show-module-contents <值>
                  指定模块声明的文档粒度。
                  可能的值为 "api" 或 "all"。
    --show-packages <值>
                  指定将文档化的模块的程序包。
                  可能的值为 "exported" 或 "all" 程序包。
    --show-types <值>
                  指定将文档化的类型 (类, 接口等), 其值可以
                  为 "public", "protected", "package" 或 
                  "private" 之一。默认值为 "protected", 该值将
                  显示公共和受保护类型, "public" 将仅显示
                  公共类型, "package" 将显示公共, 受保护和
                  程序包类型, "private" 将显示所有类型。
    -source <发行版>
                  提供与指定发行版的源兼容性
    --source-path <路径>, -sourcepath <路径>
                  指定查找源文件的位置
    -subpackages <子程序包列表>
                  指定要递归加载的子程序包
    --system <jdk>
                  覆盖用于模块化发行版的系统模块的位置
    --upgrade-module-path <路径>
                  覆盖可升级模块位置
    -verbose      输出有关 Javadoc 正在执行的操作的消息
    --version     输出版本信息

由 Standard doclet 提供:
    --add-stylesheet <file>
                  用于所生成文档的其他样式表文件
    --allow-script-in-comments
                  允许在选项和注释中使用 JavaScript
    -author       包含 @author 段
    -bottom <html-code>
                  包含每个页面的底部文本
    -charset <charset>
                  用于跨平台查看生成的文档的字符集
    -d <directory>
                  输出文件的目标目录
    -docencoding <name>
                  指定输出的字符编码
    -docfilessubdirs
                  递归复制文档文件子目录
    -doctitle <html-code>
                  包含概览页面的标题
    -excludedocfilessubdir <name>:..
                  排除具有给定名称的所有文档文件子目录
    -footer <html-code>
                  包含每个页面的页脚文本
    --frames      允许在生成的输出中使用帧
    -group <name> <g1>:<g2>...
                  将指定的元素在概览页面上分组在一起
    -header <html-code>
                  包含每个页面的页眉文本
    -helpfile <file>
                  包含帮助链接所链接到的文件
    -html4        生成 HTML 4.01 输出
    -html5        生成 HTML 5 输出
    --javafx, -javafx
                  启用 JavaFX 功能
    -keywords     随程序包, 类和成员信息一起附带 HTML 元标记
    -link <url>   创建指向 <url> 中的 javadoc 输出的链接
    -linkoffline <url1> <url2>
                  使用 <url2> 中的程序包列表链接到 <url1> 中的文档
    -linksource   以 HTML 格式生成源文件
    --main-stylesheet <file>, -stylesheetfile <file>
                  用于更改生成文档的样式的文件
    -nocomment    不生成说明和标记, 只生成声明
    -nodeprecated
                  不包含 @deprecated 信息
    -nodeprecatedlist
                  不生成已过时的列表
    --no-frames   禁止在生成的输出中使用帧（默认值）
    -nohelp       不生成帮助链接
    -noindex      不生成索引
    -nonavbar     不生成导航栏
    -noqualifier <name1>:<name2>:..
                  输出中不包括限定符的列表
    -nosince      不包括 @since 信息
    -notimestamp  不包括隐藏的时间戳
    -notree       不生成类分层结构
    --override-methods (detail|summary)
                  在详细资料部分或概要部分中的文档覆盖方法
    -overview <file>
                  从 HTML 文件读取概览文档
    -serialwarn   生成有关 @serial 标记的警告
    -sourcetab <tab length>
                  指定源中每个制表符占据的空格数
    -splitindex   将索引分为每个字母对应一个文件
    -tag <name>:<locations>:<header>
                  指定单个参数定制标记
    -taglet       要注册的 Taglet 的全限定名称
    -tagletpath   Taglet 的路径
    -top <html-code>
                  包含每个页面的顶部文本
    -use          创建类和程序包用法页面
    -version      包含 @version 段
    -windowtitle <text>
                  文档的浏览器窗口标题

GNU 样式的选项可使用 = (而非空白) 来分隔选项名称
及其值。

```