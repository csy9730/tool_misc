
# gcc


```
Usage: gcc [options] file...
Options:
  -pass-exit-codes         Exit with highest error code from a phase
  --help                   Display this information
  --target-help            Display target specific command line options
  --help={common|optimizers|params|target|warnings|[^]{joined|separate|undocumented}}[,...]
                           Display specific types of command line options
  (Use '-v --help' to display command line options of sub-processes)
  --version                Display compiler version information
  -dumpspecs               Display all of the built in spec strings
  -dumpversion             Display the version of the compiler
  -dumpmachine             Display the compiler's target processor
  -print-search-dirs       Display the directories in the compiler's search path
  -print-libgcc-file-name  Display the name of the compiler's companion library
  -print-file-name=<lib>   Display the full path to library <lib>
  -print-prog-name=<prog>  Display the full path to compiler component <prog>
  -print-multiarch         Display the target's normalized GNU triplet, used as
                           a component in the library path
  -print-multi-directory   Display the root directory for versions of libgcc
  -print-multi-lib         Display the mapping between command line options and
                           multiple library search directories
  -print-multi-os-directory Display the relative path to OS libraries
  -print-sysroot           Display the target libraries directory
  -print-sysroot-headers-suffix Display the sysroot suffix used to find headers
  -Wa,<options>            Pass comma-separated <options> on to the assembler
  -Wp,<options>            Pass comma-separated <options> on to the preprocessor
  -Wl,<options>            Pass comma-separated <options> on to the linker
  -Xassembler <arg>        Pass <arg> on to the assembler
  -Xpreprocessor <arg>     Pass <arg> on to the preprocessor
  -Xlinker <arg>           Pass <arg> on to the linker
  -save-temps              Do not delete intermediate files
  -save-temps=<arg>        Do not delete intermediate files
  -no-canonical-prefixes   Do not canonicalize paths when building relative
                           prefixes to other gcc components
  -pipe                    Use pipes rather than intermediate files
  -time                    Time the execution of each subprocess
  -specs=<file>            Override built-in specs with the contents of <file>
  -std=<standard>          Assume that the input sources are for <standard>
  --sysroot=<directory>    Use <directory> as the root directory for headers
                           and libraries
  -B <directory>           Add <directory> to the compiler's search paths
  -v                       Display the programs invoked by the compiler
  -###                     Like -v but options quoted and commands not executed
  -E                       Preprocess only; do not compile, assemble or link
  -S                       Compile only; do not assemble or link
  -c                       Compile and assemble, but do not link
  -o <file>                Place the output into <file>
  -pie                     Create a position independent executable
  -shared                  Create a shared library
  -x <language>            Specify the language of the following input files
                           Permissible languages include: c c++ assembler none
                           'none' means revert to the default behavior of
                           guessing the language based on the file's extension

Options starting with -g, -f, -m, -O, -W, or --param are automatically
 passed on to the various sub-processes invoked by gcc.  In order to pass
 other options on to these processes the -W<letter> options must be used.

For bug reporting instructions, please see:
<http://sourceforge.net/projects/mingw-w64>.

```

```
admin@DESKTOP-CTAGE42 MSYS /d/AlBrowserDownloads/cryptopp600a
$ g++ --help
用法：g++ [选项] 文件...
选项：
  -pass-exit-codes         在某一阶段退出时返回其中最高的错误码。
  --help                   显示此帮助说明。
  --target-help            显示目标机器特定的命令行选项。
  --help={common|optimizers|params|target|warnings|[^]{joined|separate|undocumented}}[,...]。
                           显示特定类型的命令行选项。
 （使用‘-v --help’显示子进程的命令行参数）。
  --version                显示编译器版本信息。
  -dumpspecs               显示所有内建 spec 字符串。
  -dumpversion             显示编译器的版本号。
  -dumpmachine             显示编译器的目标处理器。
  -print-search-dirs       显示编译器的搜索路径。
  -print-libgcc-file-name  显示编译器伴随库的名称。
  -print-file-name=<库>    显示 <库> 的完整路径。
  -print-prog-name=<程序>  显示编译器组件 <程序> 的完整路径。
  -print-multiarch         显示目标的标准 GNU 三元组（被用于库路径的一部分）。
  -print-multi-directory   显示不同版本 libgcc 的根目录。
  -print-multi-lib         显示命令行选项和多个版本库搜索路径间的映射。
  -print-multi-os-directory 显示操作系统库的相对路径。
  -print-sysroot           显示目标库目录。
  -print-sysroot-headers-suffix 显示用于寻找头文件的 sysroot 后缀。
  -Wa,<选项>               将逗号分隔的 <选项> 传递给汇编器。
  -Wp,<选项>               将逗号分隔的 <选项> 传递给预处理器。
  -Wl,<选项>               将逗号分隔的 <选项> 传递给链接器。
  -Xassembler <参数>       将 <参数> 传递给汇编器。
  -Xpreprocessor <参数>    将 <参数> 传递给预处理器。
  -Xlinker <参数>          将 <参数> 传递给链接器。
  -save-temps              不删除中间文件。
  -save-temps=<参数>       不删除中间文件。
  -no-canonical-prefixes   生成其他 gcc 组件的相对路径时不生成规范化的
                           前缀。
  -pipe                    使用管道代替临时文件。
  -time                    为每个子进程计时。
  -specs=<文件>            用 <文件> 的内容覆盖内建的 specs 文件。
  -std=<标准>              假定输入源文件遵循给定的标准。
  --sysroot=<目录>         将 <目录> 作为头文件和库文件的根目录。
  -B <目录>                将 <目录> 添加到编译器的搜索路径中。
  -v                       显示编译器调用的程序。
  -###                     与 -v 类似，但选项被引号括住，并且不执行命令。
  -E                       仅作预处理，不进行编译、汇编或链接。
  -S                       编译到汇编语言，不进行汇编和链接，
  -c                       编译、汇编到目标代码，不进行链接。
  -o <文件>                输出到 <文件>。
  -pie                     生成位置无关可执行文件。
  -shared                  生成一个共享库。
  -x <语言>                指定其后输入文件的语言。
                           允许的语言包括：c、c++、assembler、none
                           ‘none’意味着恢复默认行为，即根据文件的扩展名猜测
                           源文件的语言。

以 -g、-f、-m、-O、-W 或 --param 开头的选项将由 g++ 自动传递给其调用的
 不同子进程。若要向这些进程传递其他选项，必须使用 -W<字母> 选项。

报告程序缺陷的步骤请参见：
<https://gcc.gnu.org/bugs/>.

admin@DESKTOP-CTAGE42 MSYS /d/AlBrowserDownloads/cryptopp600a
```

预处理，编译、汇编、链接

``` bash
-E # 仅作预处理。生成后缀为.i 的文件。
gcc -S   # 编译到汇编语言，生成.s汇编源文件
gcc -c  #编译、汇编到目标代码,生成 .o文件
-o output_filename    # 确定输出文件的名称为output_filename。默认的名a.out 。
gcc -O # 优化编译、链接
gcc -O2 #比-O 更好的优化编译、链接。如处理器指令调度等。编译链接过程更慢。
-O3  # 除了完成所有-O2级别的优化之外，还包括循环展开和其他一些与处理器特性相关的优化工作。
gcc -Idirname # 将 dirname 所指出的目录加入到程序头文件目录列表中
gcc -Ldirname #将dirname所指出的目录加入到程序函数库文件的目录列表中
-lname #链接时装载名为 libname.a 的函数库。该函数库位于系统默认的目录或者由 -L 选项确定的目录下。例如，-lm 表示链接名为 libm.a 的数学函数库。
-static # 强制使用静态链接库。
-shared # 
-fPIC # 作用于编译阶段，告诉编译器产生与位置无关代码（Position-Independent Code）；这样一来，产生的代码中就没有绝对地址了，全部使用相对地址，所以代码可以被加载器加载到内存的任意位置，都可以正确的执行。这正是共享库所要求的，共享库被加载时，在内存的位置不是固定的。
-g2   默认的级别是2（-g2），此时产生的调试信息包括：扩展的符号表、行号、局部或外部变量信息。
-pipe # 避免使用临时文件，但编译时却需要消耗更多的内存,可以加快编译速度。
-Wall #在发生警报时取消编译操作，即将警报看作是错误
-w #禁止所有的报警
  ```
  
  ##### misc
  
  g++ -DNDEBUG  -D_XOPEN_SOURCE=600  -pthread ???