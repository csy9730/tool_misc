# [window10 visual studio 2019 使用 vcpkg 安装 opencv 教程 (window10 visual studio 2019 use vcpkg install opencv)](https://www.cnblogs.com/ttweixiao-IT-program/p/12419876.html)

 

电脑配置：window10, 电脑型号：HUAWEI MateBook D, 64位操作系统，基于x64的处理器。 Microsoft Visual Studio 2019

早就听闻 c++ 是最不简单的编程语言，但是没想到连安装包都那么费劲，不像 python 安装完 pip 之后，只要通过 pip install package-name 就可以进行安装。

想在 visual studio 上使用 opencv 包，搜索了资料，发现 c++ 有个包管理器 vcpkg，心中顿时十分欢喜，但是过程没有想象的那么顺利，心酸历程记录如下。

 

## **1. 在电脑上安装 vcpkg**

参考 <https://github.com/microsoft/vcpkg> 上的安装步骤

（1）先想好 vcpkg 的安装目录，比如我打算放在 d:software 下面。再点击 win+r, 输入 cmd, 再输入**d:**（一定要加冒号），再输入 **cd software**

（2）接下来就可以把 vcpkg 的资料 clone下来了，即输入 git clone https://github.com/Microsoft/vcpkg.git

（3）输入 .\bootstrap-vcpkg.bat  （我在运行这个的时候出现了问题，所以我就直接到 D:\software\vcpkg 下双击 bootstrap-vcpkg.bat 文件，效果是一样的）



## **2. 使用 vcpkg 安装 opencv**

 

（题外话：这边先和大家分析下我的辛酸历程，我首先输入的是 ： .\vcpkg.exe install opencv，但是安装的过程中出现了多次 Error: Building package X failed with: BUILD_FAILED 类似的这样的错误，查阅了资料我也没有头绪，后来就认真看错误解释，发现出现这个问题之后，你选择的解决方案要依据出现这句话前面的内容采取像应的措施，如果出现这句红色的话的前面内容是：Failed to download file.If you use a proxy, please set the HTTPS_PROXY and HTTP_PROXY environment variables to "https://user:password@your-proxy-ip-address:port/". Otherwise, please submit an issue at https://github.com/Microsoft/vcpkg/issues  ，那么极大的可能就是和网络有关系，所以我就重复执行以上命令。结果多试几次，发现后面的运行都会比前面更近一步，所以我更加坚定是因为网络的原因。后来一直停在了 downloading ..... 我就知道因为下载慢的问题一直卡在这里，所以就让按下ctrl+d 终止运行，然后让网络好的同学帮我下载，下载好之后我就放在 -> 后面相应的路径，一般是 vcpkg\downloads 。我们家的是移动100M的宽带，平常手机没什么问题，下载国内的东西速度还算过的去，但是一涉及到访问外网就特别差，所以建议会经常在家里办公又需要连接外网的朋友们最好选择安装电信，电信访问外网比移动快很多，就算是50M的电信，也比移动100M访问外网能力强。为了减少 downloading 的时候，我还背上我的笔记本到肯德基去蹭网，不容易啊。。。后来，我又看到了一些关于 x86 的错误提示，后来想想我的系统是 x64 的，所以我觉得我应该把命令改成 .\vcpkg.exe install opencv:x64-windows ，发现改了以后速度又快了许多。所以在这个过程中，安装完 opencv 就意味着最难的工作已经完成了。）

 

**这一步的工作就是输入命令： `.\vcpkg.exe install opencv:x64-windows`**

其次，要注意了，如果你遇到了以下错误，相应的处理方法：

类似 Error: Building package X failed with: BUILD_FAILED，Please ensure you're using the latest portfiles with `.\vcpkg update`, then submit an issue at https://github.com/Microsoft/vcpkg/issues including:

解决方案：这时候要认真审题，审的是出现这段话上面的内容。

（1）. 如果出现这个红色语句时上面的内容是：Failed to download file. If you use a proxy, please set the HTTPS_PROXY and HTTP_PROXY environment variables to "https://user:password@your-proxy-ip-address:port/". Otherwise, please submit an issue at https://github.com/Microsoft/vcpkg/issues 。那么就是网络问题，再次运行 .\vcpkg.exe install opencv:x64-windows，或者找个网络好的地方网络好的时候再次运行。

（2）. 如果出现这个红色语句时上面的内容是：Cannot find Windows 10.0.18362.0 SDK. File does not exist: C:\Program Files (x86)\Windows Kits\10\Lib\10.0.18362.0\um\x64\OpenGL32.Lib。那么就把 windows kit 拷贝到 C 盘的这个目录下。这边注意了，在 visual studio installer 上需要安装 windows 10 SDK，我在 visual studio 的单个组件中 .SDK、库和框架这一栏选择了最新的 windows 10 SDK (10.0.18362.0) 进行安装，安装完之后，会在我的 D 盘下出现一个名叫 Windows Kits 的文件，我就把这个文件拷到了 C:\Program Files (x86)\ 下就可以解决这个错误了。

目前我遇到的错误就这两个，还有个问题就是要是一直停在 downloading ... ，那么可以先下载好文件然后放在 vckpg 的 downloads 文件夹下，这样可以加快下载速度。

当看到没有错误提示时，就说明下载成功了，为了确认是否成功，你也可以输入 ： .\vcpkg.exe list 查看已经安装的包是否包含 opencv

 

## **3. 把 vcpkg 和 visual studio 联系起来**

关于这一部分的教程我不多说，网上的例子很多，大家可以参考 <https://blog.csdn.net/cjmqas/article/details/79282847> 这个教程的第 4 点：Vcpkg和Visual Studio的集成。写的还是不错的。大家只要把按照步骤 4.4 做完就可以了。

这边有两点需要注意的：

\1. 新建 visual studio 工程的时候需要先用 visual studio installer 工作负载中需要安装 “使用c++桌面开发” 这个内容以便在新建工程的时候可以选择 C++ 相关的项目类型。

\2. 特别要注意，那就是需要把 Debug 旁边的平台改成 x64，这个特别重要！！！

![img](https://img2020.cnblogs.com/blog/1703588/202003/1703588-20200305150311066-824221795.png)

 

## **4. 输入代码进行测试**

输入以下代码：

```cpp
#include <iostream>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

int main()
{
    cout << "Hello world!" << endl;
    Mat imageMat = imread("e:/phototest.tif");
    namedWindow("figure1", WINDOW_AUTOSIZE);
    imshow("figure1", imageMat);
    waitKey(0);    
    return 0;
}
```

要是出现了图片就说明一切都搞定啦！其次可能有一些细节被我忽略了，大家要是还遇到什么问题可以查查资料或者咨询我。

