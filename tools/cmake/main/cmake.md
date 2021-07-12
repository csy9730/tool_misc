# CMAKE

## overview

cmake 支持 源码目录和build目录分离。
- Source Tree 源码目录树
- Build Tree 生成的目录树

### target
cmake会额外生成一些特殊目标。
- ALL_BUILD
- ZERO_CHECK
- INSTALL

ALL_BUILD用于编译整个项目的工程。ALL_BUILD相当于makefile里面的默认目标，构建整个项目，但不包括install和单元测试等。

ZERO_CHECK监视CMakeLists.txt，如果CMakeLists.txt发生变化，则告诉编译器重新构建整个工程环境。ZERO_CHECK是首先执行的构建目标，会检查生成出的VS项目相比CMakeLists.txt是否过期，如果过期会首先重新生成VS项目。所有其它目标都会依赖这个ZERO_CHECK，于是构建别的目标都会先走一下ZERO_CHECK，保证了所生成项目的即时性。当然，你也可以手工跑这个目标。

INSTALL是把cmake脚本里install指令指定的东西安装到CMAKE_INSTALL_DIR里面。详见CMake的INSTALL指令。

## cmake script


变量

``` cmake
list(APPEND SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/src/a.cpp) # 设置列表变量
```


``` cmake
file(GLOB IMG_INSTALL          ${PROJECT_SOURCE_DIR}/img/*.*)
install(TARGETS  hello  DESTINATION  ${PROJECT_BINARY_DIR}/Bin)
# install(FILES   ${RES_INSTALL} ${IMG_INSTALL} DESTINATION  ${PROJECT_BINARY_DIR}/Bin/)
install(DIRECTORY    ${PROJECT_SOURCE_DIR}/res/ DESTINATION  ${PROJECT_BINARY_DIR}/Bin/res)
```

## build/install


### generator
选择生成器/工具链，注意选择 gcc路径，查看32位还是64位。

### build
指定 debug 或 release ： --config debug

### install


### build shell

``` bash

git clone https://www.github.com/abc/def
cd def_build
cmake ../def

cmake .
cmake --build . --config release
cmake --install . --config release


```
`
## help


常用命令：
- --build
- --install
-  defalt (generate makefile)
    - -G <generator-name>
    - -D <var>:<type>=<value>, -D <var>=<value> 设置变量
    - --toolchain <path-to-file>

```
Generate a Project Buildsystem
 cmake [<options>] <path-to-source>
 cmake [<options>] <path-to-existing-build>
 cmake [<options>] -S <path-to-source> -B <path-to-build>

Build a Project
 cmake --build <dir> [<options>] [-- <build-tool-options>]

Install a Project
 cmake --install <dir> [<options>]

Open a Project
 cmake --open <dir>

Run a Script
 cmake [{-D <var>=<value>}...] -P <cmake-script-file>

Run a Command-Line Tool
 cmake -E <command> [<options>]

Run the Find-Package Tool
 cmake --find-package [<options>]

View Help
 cmake --help[-<topic>]
```

### help
```

C:\Users\csy_acer_win8>call D:\GreenSoftware\runpath\..\cmake-3.9.0-win64-x64\bin\cmake.exe --help 
Usage

  cmake [options] <path-to-source>
  cmake [options] <path-to-existing-build>

Specify a source directory to (re-)generate a build system for it in the
current working directory.  Specify an existing build directory to
re-generate its build system.

Options
  -C <initial-cache>           = Pre-load a script to populate the cache.
  -D <var>[:<type>]=<value>    = Create a cmake cache entry.
  -U <globbing_expr>           = Remove matching entries from CMake cache.
  -G <generator-name>          = Specify a build system generator.
  -T <toolset-name>            = Specify toolset name if supported by
                                 generator.
  -A <platform-name>           = Specify platform name if supported by
                                 generator.
  -Wdev                        = Enable developer warnings.
  -Wno-dev                     = Suppress developer warnings.
  -Werror=dev                  = Make developer warnings errors.
  -Wno-error=dev               = Make developer warnings not errors.
  -Wdeprecated                 = Enable deprecation warnings.
  -Wno-deprecated              = Suppress deprecation warnings.
  -Werror=deprecated           = Make deprecated macro and function warnings
                                 errors.
  -Wno-error=deprecated        = Make deprecated macro and function warnings
                                 not errors.
  -E                           = CMake command mode.
  -L[A][H]                     = List non-advanced cached variables.
  --build <dir>                = Build a CMake-generated project binary tree.
  -N                           = View mode only.
  -P <file>                    = Process script mode.
  --find-package               = Run in pkg-config like mode.
  --graphviz=[file]            = Generate graphviz of dependencies, see
                                 CMakeGraphVizOptions.cmake for more.
  --system-information [file]  = Dump information about this system.
  --debug-trycompile           = Do not delete the try_compile build tree.
                                 Only useful on one try_compile at a time.
  --debug-output               = Put cmake in a debug mode.
  --trace                      = Put cmake in trace mode.
  --trace-expand               = Put cmake in trace mode with variable
                                 expansion.
  --trace-source=<file>        = Trace only this CMake file/module.  Multiple
                                 options allowed.
  --warn-uninitialized         = Warn about uninitialized values.
  --warn-unused-vars           = Warn about unused variables.
  --no-warn-unused-cli         = Don't warn about command line options.
  --check-system-vars          = Find problems with variable usage in system
                                 files.
  --help,-help,-usage,-h,-H,/? = Print usage information and exit.
  --version,-version,/V [<f>]  = Print version number and exit.
  --help-full [<f>]            = Print all help manuals and exit.
  --help-manual <man> [<f>]    = Print one help manual and exit.
  --help-manual-list [<f>]     = List help manuals available and exit.
  --help-command <cmd> [<f>]   = Print help for one command and exit.
  --help-command-list [<f>]    = List commands with help available and exit.
  --help-commands [<f>]        = Print cmake-commands manual and exit.
  --help-module <mod> [<f>]    = Print help for one module and exit.
  --help-module-list [<f>]     = List modules with help available and exit.
  --help-modules [<f>]         = Print cmake-modules manual and exit.
  --help-policy <cmp> [<f>]    = Print help for one policy and exit.
  --help-policy-list [<f>]     = List policies with help available and exit.
  --help-policies [<f>]        = Print cmake-policies manual and exit.
  --help-property <prop> [<f>] = Print help for one property and exit.
  --help-property-list [<f>]   = List properties with help available and
                                 exit.
  --help-properties [<f>]      = Print cmake-properties manual and exit.
  --help-variable var [<f>]    = Print help for one variable and exit.
  --help-variable-list [<f>]   = List variables with help available and exit.
  --help-variables [<f>]       = Print cmake-variables manual and exit.

Generators

The following generators are available on this platform:
  Visual Studio 15 2017 [arch] = Generates Visual Studio 2017 project files.
                                 Optional [arch] can be "Win64" or "ARM".
  Visual Studio 14 2015 [arch] = Generates Visual Studio 2015 project files.
                                 Optional [arch] can be "Win64" or "ARM".
  Visual Studio 12 2013 [arch] = Generates Visual Studio 2013 project files.
                                 Optional [arch] can be "Win64" or "ARM".
  Visual Studio 11 2012 [arch] = Generates Visual Studio 2012 project files.
                                 Optional [arch] can be "Win64" or "ARM".
  Visual Studio 10 2010 [arch] = Generates Visual Studio 2010 project files.
                                 Optional [arch] can be "Win64" or "IA64".
  Visual Studio 9 2008 [arch]  = Generates Visual Studio 2008 project files.
                                 Optional [arch] can be "Win64" or "IA64".
  Visual Studio 8 2005 [arch]  = Deprecated.  Generates Visual Studio 2005
                                 project files.  Optional [arch] can be
                                 "Win64".
  Borland Makefiles            = Generates Borland makefiles.
  NMake Makefiles              = Generates NMake makefiles.
  NMake Makefiles JOM          = Generates JOM makefiles.
  Green Hills MULTI            = Generates Green Hills MULTI files
                                 (experimental, work-in-progress).
  MSYS Makefiles               = Generates MSYS makefiles.
  MinGW Makefiles              = Generates a make file for use with
                                 mingw32-make.
  Unix Makefiles               = Generates standard UNIX makefiles.
  Ninja                        = Generates build.ninja files.
  Watcom WMake                 = Generates Watcom WMake makefiles.
  CodeBlocks - MinGW Makefiles = Generates CodeBlocks project files.
  CodeBlocks - NMake Makefiles = Generates CodeBlocks project files.
  CodeBlocks - NMake Makefiles JOM
                               = Generates CodeBlocks project files.
  CodeBlocks - Ninja           = Generates CodeBlocks project files.
  CodeBlocks - Unix Makefiles  = Generates CodeBlocks project files.
  CodeLite - MinGW Makefiles   = Generates CodeLite project files.
  CodeLite - NMake Makefiles   = Generates CodeLite project files.
  CodeLite - Ninja             = Generates CodeLite project files.
  CodeLite - Unix Makefiles    = Generates CodeLite project files.
  Sublime Text 2 - MinGW Makefiles
                               = Generates Sublime Text 2 project files.
  Sublime Text 2 - NMake Makefiles
                               = Generates Sublime Text 2 project files.
  Sublime Text 2 - Ninja       = Generates Sublime Text 2 project files.
  Sublime Text 2 - Unix Makefiles
                               = Generates Sublime Text 2 project files.
  Kate - MinGW Makefiles       = Generates Kate project files.
  Kate - NMake Makefiles       = Generates Kate project files.
  Kate - Ninja                 = Generates Kate project files.
  Kate - Unix Makefiles        = Generates Kate project files.
  Eclipse CDT4 - NMake Makefiles
                               = Generates Eclipse CDT 4.0 project files.
  Eclipse CDT4 - MinGW Makefiles
                               = Generates Eclipse CDT 4.0 project files.
  Eclipse CDT4 - Ninja         = Generates Eclipse CDT 4.0 project files.
  Eclipse CDT4 - Unix Makefiles= Generates Eclipse CDT 4.0 project files.

```

## misc


[https://cmake.org/cmake/help/latest/manual/cmake.1.html](https://cmake.org/cmake/help/latest/manual/cmake.1.html)





requests linking to directory "H:/Project/Github/opencv_build/install".  Targets may link only to libraries.  CMake is dropping the item.

可能是连接错误，例如 x86工程尝试连接x64的lib，导致出错。