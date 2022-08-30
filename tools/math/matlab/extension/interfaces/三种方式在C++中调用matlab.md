# 三种方式在C++中调用matlab

[![懒洋洋](https://pic2.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/lan-yang-yang-19-34)

[懒洋洋](https://www.zhihu.com/people/lan-yang-yang-19-34)





5 人赞同了该文章

## C/C++调用Matlab

在工程实践中，C/C++调用Matlab 的方法主要有调用Matlab 计算引擎、包含m 文件转换的C/C++文件，以及调用m文件生成的DLL 文件。

在调用Mallab方法、代码或DLL之前，先设置matlab的编译器。

（1）在命令行窗口下，输入并执行如下命令：mex –setup

（2）输入命令：mbuild –setup ，选择相应的VS编译器。

### 　　1 利用Matlab计算引擎

　　Matlab的引擎库为用户提供了一些接口函数，利用这些接口函数，用户在自己的程序中以计算引擎方式调用Matlab 文件。该方法采用客户机/服务器的方式，利用Matlab 引擎 将Matlab 和C/C++联系起来。在实际应用中，C/C++程序为客户机，Matlab 作为本地服务器。

　　C/C++程序向Matlab 计算引擎传递命令和数据信息，并从Matlab 计算引擎接收数据信息。

　　Matlab提供了以下几个C语言计算引擎访问函数供用户使用：engOpen，engClose，engGetVariable，engPutVariable，engEvalString，engOutputBuffer，engOpenSingleUse， engGetVisible，engSetVisible。

头文件 **#include "engine.h"** 这个文件在 %MATLAB_PATH%\extern\include里，我们在**VC++目录包含**过了。否则，就会提示 cannot find engine.h file之类的错误。然后，我们需要引用几个函数调用依赖库(lib) libeng.lib libmx.lib libmat.lib。

```cpp
#pragma comment(lib, "libeng.lib")
#pragma comment(lib, "libmx.lib")
#pragma comment(lib, "libmat.lib")
```

　　下面以C语言编写的、调用Matlab引擎计算方程x3-2x+5=0根的源程序example2.c为例，说明C/C++调用Matlab 计算引擎编程的原理和步骤：

```c
#include <windows.h>
#include <stdlib.h>
#include <stdio.h>
#include "engine.h"

int PASCAL WinMain (HANDLEhInstance, HANDLE hPrevInstance,LPSTR lpszCmdLine, intnCmdShow)
{ 
    Engine *ep;
    mxArray *P=NULL,*r=NULL;
　　char buffer[301]; 
    doublepoly[4]={1,0,-2,5};
　　if (!(ep=engOpen(NULL)))   //打开引擎
　　{
          fprintf(stderr,"\nCan'tstart MATLAB engine\n");
          return EXIT_FAILURE;
    }
　　P=mxCreateDoubleMatrix(1,4,mxREAL); //定义变量需要转换为matlab的格式
    mxSetClassName(P,"p");
　　memcpy((char*)mxGetPr(P),(char *)poly, 4*sizeof(double));
　　engPutVariable(ep,P); //将数据传入引擎使用
    engOutputBuffer(ep,buffer,300);
　　engEvalString(ep,"disp(['多项式',poly2str(p,'x'),'的根']),r=roots(p)"); //matlab的指令作为参数进行操作
　　MessageBox(NULL,buffer,"example2展示MATLAB 引擎的应用",MB_OK);
　　engClose(ep); //关闭引擎
    mxDestroyArray(P); //清理mxCreateDoubleMatrix 生成的变量
    return EXIT_SUCCESS; 
}
```

　　在Matlab 下运行example2.exe: mex -f example2.c。

**利用计算引擎调用Matlab的特点**是：**节省**大量的**系统资源**，应用程序整体性能较好，但**不能脱离Matlab的环境运行**，且运行速度较**慢**，但在一些特别的应用（例如需要进行三维图形显示）时可考虑使用。

### 　　2 利用mcc编译器生成的cpp 和hpp 文件

　　Matlab自带的C++ Complier--mcc，能将m文件转换为C/C++代码。因此，它为C/C++程序调用m文件提供了另一种便捷的方法。下面举例说明相应步骤：

***a.*** 新建example3.m，保存后在命令窗口中输入：mcc -t -L Cpp -hexample3.

```matlab
function y=exmaple3(n) 
y=0; 
for i=1:n 
y=y+i;
end   
```

　　则在工作目录下生成example3.cpp 和example3.hpp 两个文件。

**b.** 在VC中新建一个基于对话框的MFC应用程序Test2，添加一个按钮，并添加按钮响应函数，函数内容见f 步。将上面生成的两个文件拷贝到VC 工程的Test2 目录下。

**c.** 在VC中选择：工程->设置，选择属性表Link 选项，下拉菜单中选择Input，在对象 / 库模块中加入libmmfile.liblibmatlb.lib libmx.lib libmat.lib libmatpm.lib sgl.lib libmwsglm.liblibmwservices.lib ， 注意用空格分开； 而在忽略库中加入 msvcrt.lib；

**d.** 选择属性表C/C++选项，下拉菜单选General，在预处理程序定义中保留原来有的内容，并添加MSVC,IBMPC,MSWIND，并用逗号隔开。选择下拉菜单的PrecompiledHeaders选项，在“自动使用预补偿页眉”中添加stdafx.h，然后确定。

**e.** 选择:工具-> 选项， 属性页选择“ 目录” ，在include files 加入：C:\MATLAB6p5p1\extern\include ，C:\MATLAB6p5p1\extern\include\cpp ； 然后在 Library files 里面加入： C:\MATLAB6p5p1\bin\win32 ，C:\MATLAB6p5p1\extern\ lib\win32\microsoft\msvc60；注意根据用户的Matlab 安装位置，修改相应目录。

**f.** 在响应函数中添加头文件：#include "matlab.hpp" #include "example3.hpp" 函数响应代码为：

```text
int i; mwArray n; n=10;n=example3(n); i=n.ExtractScalar(1);
CString str;str.Format("example3 的返回值是:%d",i);AfxMessageBox(str);
```

**g.** 编译，连接，执行。

也可以使用：MATLAB Coder（MATLAB自带的工具）实现代码的转换，Coder会对要转换的MATLAB代码进行检测，并提示有哪些地方需要进行修改才能转换成C/C++代码。但是，

1、C/C++不允许像MATLAB一样对矩阵进行多行访问、拼接等操作，因此类似“A=[A B]；”这样的代码是无法成功转换的。解决方法是将这些代码改成C/C++语法允许的操作。

2、C/C++是强类型语言，需要先定义变量再使用，而MATLAB是弱类型语言，因此在代码转换之前需要对MATLAB代码中的变量添加定义和声明的代码语句。

3、MATLAB自带的一些函数是不允许MATLAB Coder直接进行转换的，因此需要将这些函数声明为“coder.extrinsic('函数名');”，或者使用相应的代码替换这些函数。

相关错误可以参考：[ 使用MATLAB Coder Generation将m语言转化为C++过程遇到的问题及解决](https://link.zhihu.com/?target=https%3A//blog.csdn.net/m0_46427461/article/details/124084542)

### 　　3 利用mcc编译器生成的的DLL 文件

　　Matlab的C++Complier不仅能够将Matlab的m文件转换为C/C++的源代码，还能产生完全脱离Matlab运行环境的独立可执行DLL程序。从而可以在C/C++程序中，通过调用DLL实现对Matlab代码的调用。下面通过一个简单的例子说明C/C++调用m文件生成的DLL：

**a.** 建立m文件example4.m。

```text
function result=example4(a,b)
  result =a+b
  stem(c)
end
```

　　然后在命令窗口中输入：

**mcc -W cpplib:example4 -T link:lib example4.m**

**或 mcc -W cpplib:example4 -T link:lib example4.m -C**

则在工作目录下会生成example4 .dll、example4 .lib和example4 .h三个文件。（第二种命令多一个文件：example4.ctf）

**解释：**

-W是控制编译之后的封装格式；
cpplib，是指编译成C++的lib；
cpplib冒号后面是指编译的库的名字；
-T表示目标，link:lib表示要连接到一个库文件的目标，目标的名字即是.m函数的名字。

**补充**：若example4.m中的函数调用了其他M文件中的函数，则只需要用mcc命令编译example4.m，生成**1**套相应的.h, .cpp, .lib, .dll文件。

**b.** 配置VS**包含目录**。在VS中，点项目属性然后在‘VC++目录'选项卡中，在"包含目录"中添加matlab相关的头文件：“matlab安装路径”\extern\include ;

**c.** 配置VS**库目录**。将matlab相关的静态链接库的路径加入其中：\extern\lib\win64\microsoft

**d.** 配置**链接器。**链接器->输入：mclmcrrt.lib; mclmcr.lib; libmat.lib; libmx.lib ( libmex.lib; libeng.lib;)

**e.** 将MATLAB编译为C++的文件（即DLL相关的文件）添加到项目中，并配置用户环境变量增加“MATLAB安装路径\bin\win64”。

　　将Matlab生成的三个（四个）文件放入该项目所在文件夹下，并将这三个（四个）文件添加到项目中。

**注意**：因为是使用DLL，所以不需要将MATLAB生成的**CPP**文件添加到项目中，否则会报错，因为.h中的方法DLL和CPP重复定义了多次。

**f.** 使用C++调用matlab的函数.

```objective-c++
#include"example4.h"
using namespace std;

int main()
{
    bool isOk = 0;
    if (!mclInitializeApplication(NULL, 0))
    {
        cout << "Could not initialize the application.\n";
        return -1;
    }
    cout << "isOk = " << isOk << endl;
    isOk = example4Initialize();
    cout << "isOk = " << isOk << endl;

    mwArray a(1, 1, mxDOUBLE_CLASS);  //函数参数类型为mwArray, 大小为1*1，数据类型为double
    mwArray b(1, 1, mxDOUBLE_CLASS);
    a(1, 1) = 1.8; //初始化参数
    b(1, 1) = 2.9;
    mwArray z(1, 1, mxDOUBLE_CLASS);

    example4(1, z, a, b);

    cout << a << "+" << b << "=" << z << endl;

    mclWaitForFiguresToDie(NULL);

    example4Terminate();
    mclTerminateApplication();

    return 0;
}
```

图像作为输入参数。

设计一个显示图像的matlab函数。

```matlab
function ImgShow(img)
imshow(img);
```

C++测试主函数。

```cpp
#include "cv.h"
#include "highgui.h"
#include "imgshow.h"

#include <opencv2/imgproc/imgproc.hpp>  // Gaussian Blur
#include <opencv2/core/core.hpp>        // Basic OpenCV structures (cv::Mat, Scalar)
#include <opencv2/highgui/highgui.hpp>  // OpenCV window I/O

using namespace std;
using namespace cv;

int main() {
    bool isOk = 0;//判断动态库是否初始化成功
    if (!mclInitializeApplication(NULL, 0))
    {
        cout << "Could not initialize the application.\n";
        return -1;
    }
    cout << "isOk = " << isOk << endl;// 0
    isOk = imgshowInitialize(); // 动态库初始化成功
    cout << "isOk = " << isOk << endl;// 1


    Mat disp_image = imread("lena.jpg", 1);//调用opencv读取图片

    /*将opencv图像数据转为Matlab图像数据*/
    //Mat数据类型转为mwArray
    mwSize  mdim[3] = { disp_image.rows,disp_image.cols,3 };
    mwArray mdisp_image(3, mdim, mxDOUBLE_CLASS, mxREAL);
    //C++输入转matlab  接口矩阵转化及像素归一化
    for (int j = 0; j < disp_image.rows; ++j) {
        for (int i = 0; i <disp_image.cols; ++i) {
            Vec3b& mp = disp_image.at<Vec3b>(j, i);  //C++用向量存储像素值
            double B = mp.val[0] * 1.0 / 255;       //像素归一化到0-1之间
            double G = mp.val[1] * 1.0 / 255;
            double R = mp.val[2] * 1.0 / 255;
            mdisp_image(j + 1, i + 1, 1) = R;            //matlab中用三个面R，G，B存储像素值
            mdisp_image(j + 1, i + 1, 2) = G;            //C++图像矩阵像素值赋给matlab矩阵
            mdisp_image(j + 1, i + 1, 3) = B;
        }
    }

    ImgShow(mdisp_image); //调用matlab函数

    mclWaitForFiguresToDie(NULL);  //等待图像显示，不加此句无法显示图像

    imgshowTerminate();  //关闭动态库
    mclTerminateApplication();
    return 0;
}
```

问题1：使用C++进行调用时，addtestInitialize()这一步初始化出现问题，报错是内存出错，程序中断，还会抛出报错信息。

问题2：error C3861: “mclInitializeApplication_proxy”: 找不到标识。

解决办法：将#include <mclmcr.h>注释掉，改为包含mclmcrrt.h，对mclInitializeApplication函数进行前置声明，具体代码如下：

```text
//#include "mclmcr.h"
#include <mclmcrrt.h>
 
EXTERN_C bool mclInitializeApplication(const char** options, size_t count);
```

问题3：LINK 2019:无法解析外部符号"array_ref_getV_int" 等类似的错误。

解决办法：项目的附加依赖项中关于MATLAB工具的可能少mclmcr.lib文件。

问题4：运行代码时，报错”找不到mclmcr.dll，无法继续执行代码"

配置环境变量（用户环境变量增加“MATLAB安装路径\bin\win64”，并且将其移到最高）或者VS中项目属性（项目属性->配置属性->调试一栏中设置“环境”，MATLAB安装路径\bin\win64）；之后可能需要重启VS软件，使配置生效。



如果是这个问题，经过多方查询，暂时没有找到原理性的解释和本质的解决方案，**但是可以在程序中断时选择继续执行，不管这些报错信息，程序仍然可以继续执行下去，并最终得到正确的结果。**在VS中设置不提示该错误，下次运行时就不会弹出中断，不过报错信息依然存在，但是不影响结果。



利用mcc 编译器生成的DLL 动态连接库文件，只需在C/C++编译环境中将其包含进来， 调用导出函数即可实现原m文件的功能，极大地方便了用户的代码设计。

编辑于 2022-05-31 12:00

MATLAB

C++

C / C++