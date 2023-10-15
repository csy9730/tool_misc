# c++filt

c++filt是C++源码编译后生成二进制文件中符号表中的符号名还原工具。

## usage
``` bash
nm a.o | c++filt
```
## help

```
# c++filt --help
Usage: c++filt [options] [mangled names]
Options are:
  [-_|--strip-underscore]     Ignore first leading underscore
  [-n|--no-strip-underscore]  Do not ignore a leading underscore (default)
  [-p|--no-params]            Do not display function arguments
  [-i|--no-verbose]           Do not show implementation details (if any)
  [-t|--types]                Also attempt to demangle type encodings
  [-s|--format {none,auto,gnu,lucid,arm,hp,edg,gnu-v3,java,gnat,dlang,rust}]
  [@<file>]                   Read extra options from <file>
  [-h|--help]                 Display this information
  [-v|--version]              Show the version information
Demangled names are displayed to stdout.
If a name cannot be demangled it is just echoed to stdout.
If no names are provided on the command line, stdin is read.
Report bugs to <http://www.sourceware.org/bugzilla/>.
```
