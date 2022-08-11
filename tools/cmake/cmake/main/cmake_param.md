# cmake param


cmake 的参数,宏的传递

- 输入参数
  - cmake的环境变量
  - cmake命令行参数 `cmake .. -DFOO`
  - cmake脚本参数 `set(CFLAGS "qwerty")`
  - cmake_gui的option参数 `option(Foo "use foo" OFF)`
  - gcc 的 命令行参数 `add_definitions(-ABC)` ; `add_definitions(-DLLEXPORT=extern) `
- 输出参数
  - 直接使用宏定义
  - 把宏参数注入到头文件

直接使用宏定义过于松散；推荐使用注入头文件方法，可以体现在头文件中，代码清晰可见可配置。cmake支持全局配置include_directories。

option支持cmake的界面配置。

gcc的命令行参数，需要为每个库都要配置编译参数，~~cmake不支持全局配置add_definitions~~。

### 宏参数生成头文件

``` cmake
# 版本号
set (Tutorial_VERSION_MAJOR 1)
set (Tutorial_VERSION_MINOR 0)

# 配置一个头文件，通过它向源代码中传递一些CMake设置。
configure_file (
"${PROJECT_SOURCE_DIR}/TutorialConfig.h.in"
"${PROJECT_BINARY_DIR}/TutorialConfig.h"
)           

# 我们应该使用我们自己的数学函数吗？
option (USE_MYMATH
"Use tutorial provided math implementation" ON)

# 将二进制文件树添加到包含文件的搜索路径中，这样我们可以找到TutorialConfig.h
include_directories("${PROJECT_BINARY_DIR}")
```

参数注入的头文件
``` cpp
// 与tutorial相关的配置好的选项与设置；
#define Tutorial_VERSION_MAJOR @Tutorial_VERSION_MAJOR@
#define Tutorial_VERSION_MINOR @Tutorial_VERSION_MINOR@

#cmakedefine USE_MYMATH
```


