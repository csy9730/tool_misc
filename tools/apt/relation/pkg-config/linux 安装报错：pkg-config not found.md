# linux 安装报错：pkg-config not found


使用编译安装时，在执行./configure时报如下错误：

```
checking for pkg-config... no
pkg-config not found
configure: error: Please reinstall the pkg-config distribution
```

提示，配置错误，请重新安装pkg配置分发。

解决方法，根据提示，安装pkg-config：

```
sudo apt-get install pkg-config
```

------

### 扩展知识

关于pkg-config的简介：

> pkg-config is a helper tool used when compiling applications and libraries. It helps you insert the correct compiler options on the command line so an application can use gcc -o test test.c `pkg-config --libs --cflags glib-2.0` for instance, rather than hard-coding values on where to find glib (or other libraries). It is language-agnostic, so it can be used for defining the location of documentation tools, for instance.

翻译：

PKG CONFIG是编译应用程序和库时使用的辅助工具。它帮助您在命令行中插入正确的编译器选项，以便应用程序可以使用gcc -o test test.c 'pkg-config --libs --cflags glib-2.0'，例如，而不是硬编码在哪里找到glib（或其他库）的值。它是语言不可知的，因此它可以用来定义文档工具的位置。

------

 

## help
```
➜  ~ pkg-config --help
Usage:
  pkg-config [OPTION?]

Help Options:
  -h, --help                              Show help options

Application Options:
  --version                               output version of pkg-config
  --modversion                            output version for package
  --atleast-pkgconfig-version=VERSION     require given version of pkg-config
  --libs                                  output all linker flags
  --static                                output linker flags for static linking
  --short-errors                          print short errors
  --libs-only-l                           output -l flags
  --libs-only-other                       output other libs (e.g. -pthread)
  --libs-only-L                           output -L flags
  --cflags                                output all pre-processor and compiler flags
  --cflags-only-I                         output -I flags
  --cflags-only-other                     output cflags not covered by the cflags-only-I option
  --variable=NAME                         get the value of variable named NAME
  --define-variable=NAME=VALUE            set variable NAME to VALUE
  --exists                                return 0 if the module(s) exist
  --print-variables                       output list of variables defined by the module
  --uninstalled                           return 0 if the uninstalled version of one or more module(s) or their dependencies will be used
  --atleast-version=VERSION               return 0 if the module is at least version VERSION
  --exact-version=VERSION                 return 0 if the module is at exactly version VERSION
  --max-version=VERSION                   return 0 if the module is at no newer than version VERSION
  --list-all                              list all known packages
  --debug                                 show verbose debug information
  --print-errors                          show verbose information about missing or conflicting packages,default if --cflags or --libs given on the command line
  --silence-errors                        be silent about errors (default unless --cflags or --libsgiven on the command line)
  --errors-to-stdout                      print errors from --print-errors to stdout not stderr
  --print-provides                        print which packages the package provides
  --print-requires                        print which packages the package requires
  --print-requires-private                print which packages the package requires for static linking

```

分类: [Linux](https://www.cnblogs.com/gyfluck/category/871917.html)