# cmake添加第三方包的方法

cmake在项目中添加第三方包的方法：
- 使用绝对路径
- 使用相对路径
- 使用find_library
- 使用find_package

## 绝对路径
```
file(GLOB cv_rknn_lib ${SDK}/host/aarch64-buildroot-linux-gnu/sysroot/usr/lib/librknn*.*
    ${SDK}/host/aarch64-buildroot-linux-gnu/sysroot/usr/lib/libopencv_*.so
    # ${SDK}/host/aarch64-buildroot-linux-gnu/sysroot/usr/lib/*pthread.*
)

target_link_libraries(rknn_farward 
    ${cv_rknn_lib}
)
```

直接写绝对路径，语义明确，不会造成误调用。使用起来不够灵活。

## 相对路径
```
SET(libopencv -lopencv_core -lopencv_highgui -lopencv_imgproc -lopencv_imgcodecs -lopencv_video -lopencv_videoio)

# set(SDK /opt/zlg/m1808-sdk-v1.6.0-ga_2021.07.16)
# link_directories(${SDK}/host/aarch64-buildroot-linux-gnu/sysroot/usr/lib)

target_link_libraries(rknn_farward 
    ${libopencv}
)
```

缺点：
由于是相对路径，需要系统搜索环境变量来生成绝对路径：
- 需要把库文件添加到/lib公共路径中
- 通过link_directories把库的私有路径添加到lib变量中。

当lib路径存在多个版本的库时，可能导致使用混乱。

## find_library
cmake 提供的库发现机制，更推荐使用find_package
使用略。

## find_package
cmake 提供的库发现机制，发现机制非常强大，灵活，推荐使用。

```
find_package(OPENCV)
message(${OpenCV_INCLUDE_DIRS})
message("OpenCV_LIBS:${OpenCV_LIBS}")

include_directories(${OpenCV_INCLUDE_DIRS})

target_link_libraries(rknn_farward 
    ${OpenCV_LIBS}
)

```