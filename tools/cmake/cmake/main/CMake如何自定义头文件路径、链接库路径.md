# CMake如何自定义头文件路径、链接库路径

[![Justa](https://picx.zhimg.com/v2-d877a5c2880d3f4a0ff7bf1baf1c1b33_l.jpg?source=172ae18b)](https://www.zhihu.com/people/justa-26)

[Justa](https://www.zhihu.com/people/justa-26)[](https://www.zhihu.com/question/48510028)![img](https://picx.zhimg.com/v2-4812630bc27d642f7cafcd6cdeca3d7a.jpg?source=88ceefae)

计算机技术与软件专业技术资格证持证人

创作声明：包含 AI 辅助创作



4 人赞同了该文章

## CMake常见的变量

在 CMake 中，有许多常见的变量可用于配置和管理构建过程。以下是一些常见的变量，包括当前源码路径：

1. `CMAKE_SOURCE_DIR`：当前 CMakeLists.txt 所在的源码目录的根路径。
2. `CMAKE_BINARY_DIR`：构建目录的根路径，即构建生成的可执行文件、库和其他构建输出的存放位置。
3. `CMAKE_CURRENT_SOURCE_DIR`：当前处理的 CMakeLists.txt 所在的源码目录的路径。
4. `CMAKE_CURRENT_BINARY_DIR`：当前处理的 CMakeLists.txt 所在的构建目录的路径。
5. `CMAKE_CURRENT_LIST_DIR`：当前处理的 CMakeLists.txt 所在的路径（源码目录或构建目录）。
6. `CMAKE_CURRENT_LIST_LINE`：当前正在处理的 CMakeLists.txt 的行号。
7. `CMAKE_MODULE_PATH`：一个用于指定额外的 CMake 模块（.cmake 文件）的搜索路径的列表。
8. `CMAKE_INCLUDE_CURRENT_DIR`：如果设置为 `ON`，则在构建过程中自动将当前处理的 CMakeLists.txt 所在的目录添加到包含路径中。
9. `CMAKE_LIBRARY_OUTPUT_DIRECTORY`：库文件的输出目录。
10. `CMAKE_RUNTIME_OUTPUT_DIRECTORY`：可执行文件的输出目录。

以上是一些常用的 CMake 变量，其中包含了当前源码路径相关的变量。您可以在 CMakeLists.txt 文件中使用这些变量来设置路径、配置目录结构以及管理构建过程中的输出位置。

## CMake方法

在 CMake 中，你可以使用以下方式自定义头文件路径和链接库路径：

### 自定义头文件路径：

可以使用 `include_directories` 命令来指定自定义的头文件路径。该命令会将指定的路径添加到编译器的头文件搜索路径中。

```cmake
include_directories(path/to/include/dir)
```

你可以多次调用 `include_directories` 命令，以添加多个头文件路径。

### 自定义链接库路径：

可以使用 `link_directories` 命令来指定自定义的链接库路径。该命令会将指定的路径添加到链接器的库搜索路径中。

```cmake
link_directories(path/to/library/dir)
```

你可以多次调用 `link_directories` 命令，以添加多个链接库路径。

需要注意的是，尽量避免在 CMake 中使用 `include_directories` 和 `link_directories` 命令来处理第三方库的头文件和链接库路径。更好的做法是使用 `find_package` 命令或编写 Find 模块来查找和链接第三方库，这样可以更好地管理依赖关系和跨平台兼容性。

另外，对于特定的库，你还可以使用 `target_include_directories` 命令和 `target_link_directories` 命令，将自定义的头文件路径和链接库路径应用于特定的目标。

```cmake
target_include_directories(target_name PUBLIC path/to/include/dir)
target_link_directories(target_name PUBLIC path/to/library/dir)
```

这样可以确保自定义路径只应用于特定的目标，并使得相关路径不会泄漏到其他目标中。

通过以上方式，你可以在 CMake 中自定义头文件路径和链接库路径，以满足项目的需求。

编辑于 2023-05-24 14:26・IP 属地福建