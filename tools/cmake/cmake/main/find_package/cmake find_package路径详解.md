# cmake find_package路径详解

[![沙也博士](https://pic1.zhimg.com/v2-3a60c93c56441eb28f8e8866785227c6_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/meng-yan-shi)

[沙也博士](https://www.zhihu.com/people/meng-yan-shi)



中国科学院大学 计算机应用技术博士在读



215 人赞同了该文章

## **Motivation**

经常在Linux下面写C++程序，尤其是需要集成各种第三方库的工程，肯定对`find_package`指令不陌生。

这是条很强大的指令。可以直接帮我们解决整个工程的依赖问题，自动把头文件和动态链接文件配置好。比如说，在Linux下面工程依赖了`OpenCV`，只需要下面几行就可以完全配置好：

```cmake
add_executable(my_bin src/my_bin.cpp)
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})
target_link_libraries(my_bin, ${OpenCV_LIBS})
```

工作流程如下：

1. `find_package`在一些目录中查找OpenCV的配置文件。
2. 找到后，`find_package`会将头文件目录设置到`${OpenCV_INCLUDE_DIRS}`中，将链接库设置到`${OpenCV_LIBS}`中。
3. 设置可执行文件的链接库和头文件目录，编译文件。

到现在为止出现了第一个问题。那就是：
**find_package会在哪些目录下面寻找OpenCV的配置文件？**

## **find_package目录**

为什么我们要知道这个问题呢？因为很多库，我们都是自己编译安装的。比如说，电脑中同时编译了`OpenCV2`和`OpenCV3`，我该如何让cmake知道到底找哪个呢？

其实这个问题在CMake官方文档中有非常详细的解答。

首先是查找路径的根目录。我把几个重要的默认查找目录总结如下：

```text
<package>_DIR
CMAKE_PREFIX_PATH
CMAKE_FRAMEWORK_PATH
CMAKE_APPBUNDLE_PATH
PATH
```

其中，`PATH`中的路径如果以`bin`或`sbin`结尾，则自动回退到上一级目录。
找到根目录后，cmake会检查这些目录下的

```text
<prefix>/(lib/<arch>|lib|share)/cmake/<name>*/          (U)
<prefix>/(lib/<arch>|lib|share)/<name>*/                (U)
<prefix>/(lib/<arch>|lib|share)/<name>*/(cmake|CMake)/  (U)
```

cmake找到这些目录后，会开始依次找`<package>Config.cmake`或`Find<package>.cmake`文件。找到后即可执行该文件并生成相关链接信息。

现在回过头来看查找路径的根目录。我认为最重要的一个是`PATH`。由于`/usr/bin/`在`PATH`中，cmake会自动去`/usr/(lib/<arch>|lib|share)/cmake/<name>*/`寻找模块，这使得绝大部分我们直接通过`apt-get`安装的库可以被找到。

另外一个比较重要的是`<package>_DIR`。我们可以在调用cmake时将这个目录传给cmake。由于其优先级最高，因此cmake会优先从该目录中寻找，这样我们就可以随心所欲的配置cmake使其找到我们希望它要找到的包。而且除上述指定路径外，cmake还会直接进入`<package>_DIR`下寻找。如我在`3rd_parties`目录下编译了一个`OpenCV`，那么执行cmake时可以使用

```text
OpenCV_DIR=../../3rd-party/opencv-3.3.4/build/ cmake .. 
```

这样做以后，cmake会优先从该目录寻找`OpenCV`。

配置好编译好了以后，我感兴趣的是另一个问题：
我现在编译出了可执行文件，并且这个可执行文件依赖于`opencv`里的动态库。这个动态库是在cmake时显式给出的。那么，

1. 该执行文件在运行时是如何找到这个动态库的？
2. 如果我把可执行文件移动了，如何让这个可执行文件依然能找到动态库？
3. 如果我把该动态库位置移动了，如何让这个可执行文件依然能找到动态库？
4. 如果我把可执行文件复制到别的电脑上使用，我该把其链接的动态库放到新电脑的什么位置？

## **可执行文件如何寻找动态库**

在ld的官方文档中，对这个问题有详尽的描述。

> The linker uses the following search paths to locate required
> shared libraries:
> \1. Any directories specified by -rpath-link options.
>
> \2. Any directories specified by -rpath options. The difference
> between -rpath and -rpath-link is that directories specified by
> -rpath options are included in the executable and used at
> runtime, whereas the -rpath-link option is only effective at
> link time. Searching -rpath in this way is only supported by
> native linkers and cross linkers which have been configured
> with the --with-sysroot option.
>
> \3. On an ELF system, for native linkers, if the -rpath and
> -rpath-link options were not used, search the contents of the
> environment variable "LD_RUN_PATH".
>
> \4. On SunOS, if the -rpath option was not used, search any
> directories specified using -L options.
>
> \5. For a native linker, the search the contents of the environment
> variable "LD_LIBRARY_PATH".
>
> \6. For a native ELF linker, the directories in "DT_RUNPATH" or
> "DT_RPATH" of a shared library are searched for shared
> libraries needed by it. The "DT_RPATH" entries are ignored if
> "DT_RUNPATH" entries exist.
>
> \7. The default directories, normally /lib and /usr/lib.
>
> \8. For a native linker on an ELF system, if the file
> /etc/ld.so.conf exists, the list of directories found in that
> file.
>
> If the required shared library is not found, the linker will issue
> a warning and continue with the link.

最重要的是第一条，即`rpath`。这个`rpath`会在编译时将动态库绝对路径或者相对路径（取决于该动态库的cmake）写到可执行文件中。`chrpath`工具可以查看这些路径。

```text
>>> chrpath extract_gpu
extract_gpu: RPATH=/usr/local/cuda/lib64:/home/dechao_meng/data/github/temporal-segment-networks/3rd-party/opencv-3.4.4/build/lib
```

可以看到，OpenCV的动态库的绝对路径被写到了可执行文件中。因此即使可执行文件的位置发生移动，依然可以准确找到编译时的`rpath`。

接下来的问题：如果我把可执行文件复制到了别人的电脑上，或者我的动态库文件的目录发生了改变，怎样让可执行文件继续找到这个动态库呢？其实是在第五条：`LD_LIBRARY_PATH`。只要将存储动态库的目录加入到`LD_LIBRARY_PATH`中，可执行文件就能正确找到该目录。

这种做法十分常见，比如我们在安装`CUDA`时，最后一步是在`.bashrc`中配置

```bash
export LD_LIBRARY_PATH=/usr/local/cuda/lib64:$LD_LIBRARY_PATH
```

这样做之后，依赖`cuda`的可执行文件就能够正常运行了。

## **总结**

写这篇文章是因为从我第一次使用cmake以来，经常因为动态链接的问题而耽误很长时间。清楚理解`find_package`的运行机制在Linux的C++开发中是非常重要的，而相关的资料网上又比较稀少。其实官网上解释的非常清楚，不过之前一直没有认真查。做事情还是应该一步一个脚印，将原理搞清楚再放心使用。

## **Reference**

1. [https://cmake.org/cmake/help/v3.0/command/find_package.html](https://link.zhihu.com/?target=https%3A//cmake.org/cmake/help/v3.0/command/find_package.html)
2. [https://unix.stackexchange.com/questions/22926/where-do-executables-look-for-shared-objects-at-runtime](https://link.zhihu.com/?target=https%3A//unix.stackexchange.com/questions/22926/where-do-executables-look-for-shared-objects-at-runtime)
3. [https://codeyarns.com/2017/11/02/how-to-change-rpath-or-runpath-of-executable/](https://link.zhihu.com/?target=https%3A//codeyarns.com/2017/11/02/how-to-change-rpath-or-runpath-of-executable/)

编辑于 2018-11-26

C++