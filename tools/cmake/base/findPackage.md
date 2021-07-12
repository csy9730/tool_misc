# findpackage

通过如下方式配置opencv时，有些时候，cmake找不到opencv而报错 `find_package(OpenCV REQUIRED)`


`find_package(OpenCV REQUIRED)`会在系统路径中找到 OpenCVConfig.cmake，该文件定义了 OpenCV_INCLUDE_DIRS 和 OpenCV_LIBS 等变量，因而可以使用 include_directories 和 target_link_libraries 来访问这两个变量。
## 配置方法
### 修改环境变量
添加OpenCVConfig所在的文件夹路径到环境变量中，便于cmake发现OpenCVConfig
```
set OpenCV_DIR=H:\Project\Github\opencv_build
```
### cmake脚本配置 OpenCV_DIR 变量
find_package( OpenCV REQUIRED )
在CMakeLists.txt中指明OpenCV_DIR

```
set(OpenCV_DIR /home/User/opencv/build/)
find_package( OpenCV REQUIRED )
```

### cmake-gui中配置路径
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

### 绕过find_package
在CMake脚本中注释 find_package，自行定义库路径。

## misc
### opencv lib


opencvRelease\build
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


确保 OpenCV_LIBS 路径下 有 OpenCVConfig.cmake文件