# 设置OpenCV_DIR，使cmake自动找到opencv

[book_02](https://www.jianshu.com/u/72d817935da2)关注

0.0812020.08.13 18:31:57字数 194阅读 4,049

通过如下方式配置opencv时，有些时候，cmake找不到opencv而报错

```cmake
find_package( OpenCV REQUIRED )
```

这时有两种方式解决这个问题。分别如下：

## 1. 在CMakeLists.txt中配置

在CMakeLists.txt中指明OpenCV_DIR

```cmake
set(OpenCV_DIR /home/User/opencv/build/)
find_package( OpenCV REQUIRED )
```

## 2. 添加系统环境变量

### 2.1 windows系统

添加环境变量 OpenCV_DIR ，值为能找到OpenCVConfig.cmake或者OpenCVConfig-version.cmake的opencv路径



![img](https://upload-images.jianshu.io/upload_images/624914-0f12196bf01951ec.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

这样就不用在CMakeLists.txt中添加 OpenCV_DIR 的配置了。cmake会自动找到opencv。

### 2.2 linux系统

#### 临时生效方案

在终端窗口中输入：
`export OpenCV_DIR=/usr/local/opencv-3.1.0`

#### 永久生效方案：

编辑/edt/profile 文件
`sudo gedit /edt/profile`

添加如下语句
`export OpenCV_DIR=/usr/local/opencv-3.1.0`
编辑完退出

使配置生效
`source /etc/profile`