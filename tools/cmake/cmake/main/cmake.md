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
