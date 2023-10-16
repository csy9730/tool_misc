# cmake 管理debug release

[![spiritsaway](https://pic1.zhimg.com/56fa7e12c149b864ee002b4747293c4e_l.jpg?source=172ae18b)](https://www.zhihu.com/people/spiritsaway)

[spiritsaway](https://www.zhihu.com/people/spiritsaway)

29 人赞同了该文章

## CMake 管理项目的release 和debug

一个`c/c++`库，在编译的时候，可以选择编译是否带调试信息，带调试信息的就是`Debug`版，不带调试信息的就是`Release`版。 在`CMakeLists.txt`里一般不会制定当前工程是否是`Debug`还是`Release`， 这个信息可以通过`CMake`的命令参数传输进去，使用方法如下：

```cmake
cmake .. -DCMAKE_BUILD_TYPE=Debug
cmake .. -DCMAKE_BUILD_TYPE=Release
```

其实我们在`Visual Studio`的配置管理那里，可以看到工程的设置不仅仅是这两个选项，而是有四个选项。

\1. Debug

\2. MinSizeRel

\3. RelWithDebInfo

\4. Release

![img](https://pic4.zhimg.com/80/v2-02817dc6bdf66df4b3be8bda01a46deb_720w.webp)

常用的一般来说就只有`Debug`和`Release`。 当然，我们也可以在`CMakeLists.txt`里手动指定`CMAKE_BUILD_TYPE`， 下面的就是`mongo c driver`里的一段代码:

```cmake
if (NOT CMAKE_BUILD_TYPE)
   set (CMAKE_BUILD_TYPE "RelWithDebInfo")
   message (
      STATUS "No CMAKE_BUILD_TYPE selected, defaulting to ${CMAKE_BUILD_TYPE}"
   )
endif ()
```

一般来说这样设置就好了，但是在尝试使用`mongo-cxx-driver`的时候，发现一个很小的样例程序都会导致崩溃，最后的最简代码就如下两行：

```cpp
std::string temp_str = bsoncxx::oid().to_string();
std::string temp_str2 = temp_str + "_" + temp_str;
```

执行到最下面一行就直接崩溃，一路跟踪`to_string`，发现这个函数最后会调用到`mongo-c-driver`那个`dll`里，看了一会代码发现我自己的测试工程是`Release`的，而依赖的两个`dll`是`Debug`的。于是重新用`cmake`生成两个`mongo`相关的工程，加入参数`-DCMAKE_BUILD_TYPE`。重新来一遍，然而又崩了。切换到`Debug`模式准备单步调试，发现结果又是对的。只能继续怀疑原来的两个`mongo`项目，打开`Visual Studio`发现，两个项目居然还都是`Debug`的, `Cmake`传进来的工程类型不起作用。手动在配置管理器里切换这两个工程为`Release`，重新编译一下，再运行测试项目，完美。 看来在命令行里传递`CMAKE_BUILD_TYPE`有问题，于是去`stackoverflow`上搜，发现`Windows`上这个参数还真的不起作用。WTF！

`Cmake`的项目生成器总的来说可以分为两种：

\1. `single configuration` 包括`Unix Makefile` , `NMake Makefile`, `MinGw Makefile`

\2. `multi configuration` 包括`Visual Studio` 和`Xcode`， 看上去带`IDE`的都属于这个类别

`CMAKE_BUILD_TYPE`只能指定`single configuration`类型的项目配置， 无法指定`multi configuration`的项目配置。`multi configuration`的项目配置是在使用者手动指定的时候修改的，默认都是`Debug`。 但是对于`multi configuration`的项目，我们可以在触发编译的时候指定是`Debug`还是`Release`:

```cmake
cmake --build ./  --target install --config Release
cmake --build ./  --target install --config Debug
```

所以为了确保在跨平台的时候万无一失，最好在构建项目的时候传入`CMAKE_BUILD_TYPE`然后`build`的时候传入对tying的`--config`。

但是这样搞，需要在两个地方传入参数，我们还有一个只修改一个地方的方式，修改`CMAKE_CONFIGURATION_TYPES`:

```cmake
# Somewhere in CMakeLists.txt
message("Generated with config types: ${CMAKE_CONFIGURATION_TYPES}")
Default output:
-- Detecting CXX compiler ABI info - done
Generated with config types: Debug;Release;MinSizeRel;RelWithDebInfo
-- Configuring done
```

这个变量存储的是最终的项目的可选配置列表，我们可以通过手动指定来处理`Debug|Release`的问题。

```cmake
cmake -H.  -DCMAKE_CONFIGURATION_TYPES="Debug;Release" 
-- Detecting CXX compiler ABI info - done
Generated with config types: Debug;Release
```

一般的项目里面，都没有做这些`Debug` `Release`的区分，生成的`lib|dll|exe`文件名都是一样的，这对我们在使用相应的库的时候会带来一些困扰。我们可以通过给对应配置的文件加后缀来区分，

```cmake
set(CMAKE_DEBUG_POSTFIX "_d") 
set(CMAKE_RELEASE_POSTFIX "_r") 
set_target_properties(${TARGET_NAME} PROPERTIES DEBUG_POSTFIX "_d") 
set_target_properties(${TARGET_NAME} PROPERTIES RELEASE_POSTFIX "_r") 
```



发布于 2020-03-26 00:54

[软件调试](https://www.zhihu.com/topic/19660363)

[CMake](https://www.zhihu.com/topic/19834837)

[编译](https://www.zhihu.com/topic/19629384)