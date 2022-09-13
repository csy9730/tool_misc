# findpackage

通过如下方式配置opencv时，有些时候，cmake找不到opencv而报错 `find_package(OpenCV REQUIRED)`


`find_package(OpenCV REQUIRED)`会在系统路径中找到 OpenCVConfig.cmake，该文件定义了 OpenCV_INCLUDE_DIRS 和 OpenCV_LIBS 等变量，因而可以使用 include_directories 和 target_link_libraries 来访问这两个变量。
## 配置方法

### 配置OpenCV_DIR
配置OpenCV_DIR变量，便于cmake发现OpenCVConfig。

#### 添加环境变量
添加OpenCVConfig所在的文件夹路径到环境变量中。
```
set OpenCV_DIR=H:\Project\Github\opencv_build
```
该方法推荐。
#### cmake脚本变量
在CMakeLists.txt中写死OpenCV_DIR

``` cmake
set(OpenCV_DIR /home/User/opencv/build/)
find_package( OpenCV REQUIRED )
```

该方法不推荐。

#### cmake-gui中配置entry
cmake-gui中，可以看到变量列表。
```
OpenCV_DIR = NOTFOUND
```
NOTFOUND 说明 这变量值无效。

直接把它改成指定路径：
```
OpenCV_DIR = /home/User/opencv/build/
```

该方法有可视化界面，易于使用，推荐使用。
#### 命令行中传入变量

类似?
``` bash
cmake -DOpenCV_DIR=/home/User/opencv/build/
```

该方法适合用于脚本编程。

### 绕过find_package
在CMake脚本中注释 find_package，自行定义库路径，`OpenCV_INCLUDE_DIRS` 和 `OpenCV_LIBS` 。

## misc

### demo

#### find opencv 

opencv 安装目录下有比较深的层级目录，如何正确选择cmake需要的目录？

opencvRelease/build/
- bin/opencv_ffmpeg3413_64.dll
- etc/
- include/
    - opencv/
    - opencv2/
- x64/
    - vc14
        - bin/
        - lib/
    - vc15
- OpenCVConfig.cmake
- OpenCVConfig-version.cmake


确保 `OpenCV_LIBS` 路径下 有 `OpenCVConfig.cmake`文件.

所以：
`export OpenCV_LIBS=opencvRelease\build`

以上配置的cmake的搜索路径，运行或调试程序时，仍然需要配置dll/so的路径变量。

#### caffe find opencv

caffe 中，对应的变量 是OpenCV_LIBS_DEBUG 和 OpenCV_LIBS_RELEASE

cmake-gui中，可以看到
```
OpenCV_LIBS_DEBUG = OpenCV_LIBS_DEBUG-NOTFOUND
OpenCV_LIBS_RELEASE = OpenCV_LIBS_DEBUG-NOTFOUND
```
NOTFOUND 说明 这变量值无意义。

直接把它改成指定路径：
```
OpenCV_LIBS_DEBUG = opencvRelease/build/
OpenCV_LIBS_RELEASE = opencvRelease/build/
```

#### google/benchmark find gtest

gtest 安装目录下有比较深的层级目录

googletets-distribution/
- include/
  - gtest/
    - gtest.h
  - gmock/
- lib/
  - cmake/
    - GTest/
      - GTestConfig.cmake
      - GTestTargets.cmake
  - gmock.lib
  - gtest.ib
  - gtest_main.lib
  - gmock_main.lib

这种情况下

``` bash
export GTest_DIR=googletets-distribution/lib/cmake/GTest/
```