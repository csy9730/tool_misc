# CMAKE

## overview

cmake 支持 源码目录和build目录分离。
- Source Tree 源码目录树
- Build Tree 生成的目录树

### target

#### add_libary
> Add a library to the project using the specified source files.

- SHARED  对应动态链接文件
- static  静态库
- MODULE  插件类型
-  无参数 依赖于BUILD_SHARED_LIBS

#### add_execute

### project target
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

编译和安装
0. 工程准备
1. 配置
2. 生成
3. 编译
4. 安装


### configure
#### toolchain
选择编译工具链，只适用于gcc类型的编译工具配置。

#### cmake配置

cmake 生成的核心配置文件：CMakeCache.txt

CMakeFiles/CMakeOutput.log，cmake 生成的配置输出日志文件

CMakeFiles/CMakeError.log，cmake 生成的配置错误日志文件
### 生成
调用生成器（项目工程IDE），生成工程项目。

#### generator
选择生成器/工具链，注意选择 gcc路径，查看32位还是64位。

``` bash
# 
cmake .. -G "Visual Studio 14 2015"

# 
cmake .. -G "Visual Studio 14 2015 Win64"
```

完整的生成器工具列表
```
C:\Project>cmake -G
CMake Error: No generator specified for -G

Generators
* Visual Studio 17 2022        = Generates Visual Studio 2022 project files.
                                 Use -A option to specify architecture.
  Visual Studio 16 2019        = Generates Visual Studio 2019 project files.
                                 Use -A option to specify architecture.
  Visual Studio 15 2017 [arch] = Generates Visual Studio 2017 project files.
                                 Optional [arch] can be "Win64" or "ARM".
  Visual Studio 14 2015 [arch] = Generates Visual Studio 2015 project files.
                                 Optional [arch] can be "Win64" or "ARM".
  Visual Studio 12 2013 [arch] = Generates Visual Studio 2013 project files.
                                 Optional [arch] can be "Win64" or "ARM".
  Visual Studio 11 2012 [arch] = Deprecated.  Generates Visual Studio 2012
                                 project files.  Optional [arch] can be
                                 "Win64" or "ARM".
```

linux下如下
```
CMake Error: No generator specified for -G

Generators
* Unix Makefiles               = Generates standard UNIX makefiles.
  Green Hills MULTI            = Generates Green Hills MULTI files
                                 (experimental, work-in-progress).
  Ninja                        = Generates build.ninja files.
  Ninja Multi-Config           = Generates build-<Config>.ninja files.
  Watcom WMake                 = Generates Watcom WMake makefiles.
  CodeBlocks - Ninja           = Generates CodeBlocks project files.
  CodeBlocks - Unix Makefiles  = Generates CodeBlocks project files.
  CodeLite - Ninja             = Generates CodeLite project files.
  CodeLite - Unix Makefiles    = Generates CodeLite project files.
  Sublime Text 2 - Ninja       = Generates Sublime Text 2 project files.
  Sublime Text 2 - Unix Makefiles
                               = Generates Sublime Text 2 project files.
  Kate - Ninja                 = Generates Kate project files.
  Kate - Unix Makefiles        = Generates Kate project files.
  Eclipse CDT4 - Ninja         = Generates Eclipse CDT 4.0 project files.
  Eclipse CDT4 - Unix Makefiles= Generates Eclipse CDT 4.0 project files.
```

### build
指定 debug 或 release ： 

```
cmake --build . --config debug
cmake --build . --config release
```
### install


### build shell

``` bash

git clone https://www.github.com/abc/def
cd def
mkdir -p build
cd build
cmake ..
cmake --build . --config release
cmake --install . --config release
```


## misc
