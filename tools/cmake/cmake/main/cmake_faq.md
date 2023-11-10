# cmake faq

#### 头文件未找到

### 如何指定编译器
``` bash
cmake  .. -G "Visual Studio 14 2015 Win64"
```
### 如何指定配置变量
``` bash
cmake  .. -DZAL_LIB_SHARED:BOOL=ON -DCMAKE_BUILD_TYPE=Release 
```
### 通过cmake-gui配置变量


``` cmake
set(PROJECT_VERSION "1.0.0.0" CACHE STRING "默认版本号")
option(ZAL_LIB_SHARED "Use shared" ON)
```


### CMAKE 调用动态库

#### CMAKE 引用DLL
- msvc 编译器下，需要准备 foo.h foo.lib foo.dll
- 提供头文件 foo.h
- 指出 连接路径 foo.lib
- 运行时需要 foo.dll

如果没有使用  `__declspec (dllexport)` 装饰函数，会导致没有函数导出，无法生成 foo.lib


### CMAKE 引用 so
- gcc编译器下，需要准备 foo.h  libfoo.so
- 提供头文件 foo.h
- 无需指出 libfoo.a
- 需指出 连接路径 libfoo.so
- 运行时需要 libfoo.so

gcc 下默认导出函数，`__attribute__((visibility("default")))`
#### LNK1104


`LNK1104: cannot open file cmake dll`

需要配置 lib 路径
```

```
### 如何指定 debug/release

### 一键编译脚本
``` bash
mkdir build
cd build
cmake ..
cmake --build . 
cmake --install . --config debug

```