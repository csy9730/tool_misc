# Visual Studio 2017 （VS2017）安装、配置和使用

![img](https://cdn2.jianshu.io/assets/default_avatar/13-394c31a9cb492fcb39c27422ca7d2815.jpg)

[hwdong](https://www.jianshu.com/u/54149e14eb19)关注

12018.10.20 19:08:11字数 1,049阅读 177,222

作者：hw-dong

1.在Visual Studio 2017中安装C++支持

1)下载最新的免费的Visual Studio 2017 Community（社区版）：

[https://visualstudio.microsoft.com/downloads](https://links.jianshu.com/go?to=https%3A%2F%2Fvisualstudio.microsoft.com%2Fdownloads)

图1 选择免费的“社区”版



![img](https://upload-images.jianshu.io/upload_images/14545491-871dd43a0d5c8d8b.png?imageMogr2/auto-orient/strip|imageView2/2/w/379/format/webp)

2) “以管理员身份运行”安装程序(Visual Studio Installer)

鼠标右键点击下载的安装程序（如vs_community__1668434001.1539444457.exe），在弹出的右键菜单中选择“以管理员身份运行”。VS安装器将开始下载提取文件…



![img](https://upload-images.jianshu.io/upload_images/14545491-138a72e03cfff954.png?imageMogr2/auto-orient/strip|imageView2/2/w/311/format/webp)

图2 右键菜单中选择“以管理员身份运行”



![img](https://upload-images.jianshu.io/upload_images/14545491-dea65ff543ad56d3.png?imageMogr2/auto-orient/strip|imageView2/2/w/315/format/webp)

图3 Visual Studio Installer开始提取文件

3) 勾选“使用c + +的桌面开发”、修改安装路径（目录）

对于C + +，勾选“ **使用C++的桌面开发** ”，然后选择“**安装**”。



![img](https://upload-images.jianshu.io/upload_images/14545491-8069e52310b857c4.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

图4 勾选“使用c + +的桌面开发”

默认安装到C盘（C:\Program Files (x86)\Microsoft Visual Studio\2017\Community），也可以点击下面的“**更改**”修改VS2017的安装路径（目录），比如安装到比如“F盘”: F:\Program Files (x86)\Microsoft Visual Studio\2017\Community。然后选择“**安装**”。



![img](https://upload-images.jianshu.io/upload_images/14545491-9bf052ab1b6d9fd3.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

图5 选择安装路径（目录）

在弹出的对话框中选择“**继续使用我的选择**”。然后选择“**确定**”开始安装。



![img](https://upload-images.jianshu.io/upload_images/14545491-fd8d36e3614771cc.png?imageMogr2/auto-orient/strip|imageView2/2/w/603/format/webp)

图6 选择“继续使用我的选择”

请耐心等到漫长的下载安装过程…



![img](https://upload-images.jianshu.io/upload_images/14545491-1a08b3d727f7f91c.png?imageMogr2/auto-orient/strip|imageView2/2/w/664/format/webp)

图7 漫长的下载安装过程

4) 首次启动，需要登录Microsoft 帐户

安装完成后，选择**启动**按钮以启动 Visual Studio。



![img](https://upload-images.jianshu.io/upload_images/14545491-582417d5e344fadb.png?imageMogr2/auto-orient/strip|imageView2/2/w/509/format/webp)

图8 点击“**启动**” 按钮

首次运行 Visual Studio ，需要使用 Microsoft 帐户登录。 如果你没有帐户，则可以免费创建一个。



![img](https://upload-images.jianshu.io/upload_images/14545491-d4ed1f87569391ee.png?imageMogr2/auto-orient/strip|imageView2/2/w/580/format/webp)

图9 注册/登陆Microsoft 帐户

\2. 创建一个 c + + 控制台应用程序项目

1) 打开新项目对话框

在 Visual Studio 中打开**文件**菜单，然后选择**新建** -> **项目**以打开**新项目**对话框。



![img](https://upload-images.jianshu.io/upload_images/14545491-917b0977b8082652.png?imageMogr2/auto-orient/strip|imageView2/2/w/746/format/webp)

2）创建一个“空项目”

在新项目对话框中，选择**已安装**， 选择 **Visual c++**, 然后选择 **空项目**模板。 在**名称**字段中，输入“HelloWorld”。 选择**确定**创建项目。



![img](https://upload-images.jianshu.io/upload_images/14545491-10e976c82b30d10f.png?imageMogr2/auto-orient/strip|imageView2/2/w/941/format/webp)

3）使项目成为“控制台程序(console app)”

在 Visual Studio 中打开项目菜单，然后选择**属性**以打开HelloWorld **属性页对话框**。



![img](https://upload-images.jianshu.io/upload_images/14545491-b676a52d507c7c17.png?imageMogr2/auto-orient/strip|imageView2/2/w/482/format/webp)

在**属性页**对话框下**配置属性**，选择**链接器**-> **系统**，然后选择编辑框旁边**子系统**属性。 在显示的下拉列表菜单，选择**控制台 (/SUBSYSTEM: CONSOLE)**。 选择**确定**以保存所做的更改。



![img](https://upload-images.jianshu.io/upload_images/14545491-5b0c8f22e3169d7c.png?imageMogr2/auto-orient/strip|imageView2/2/w/875/format/webp)

4）向项目添加文件

在解决方案资源管理器，选择 **HelloWorld** 项目，在鼠标右键菜单栏上依次选“**添加**”->“**新建项**”以打开添加新项对话框。



![img](https://upload-images.jianshu.io/upload_images/14545491-abcbf7386ae8f49e.png?imageMogr2/auto-orient/strip|imageView2/2/w/893/format/webp)

在**添加新项**对话框中，选择**Visual c++** ，在中心窗格中，选择**c++文件(.cpp)** 。 更改名称为 **HelloWorld.cpp**。 选择添加以关闭对话框并创建该文件。



![img](https://upload-images.jianshu.io/upload_images/14545491-ebe4c46410f522b8.png?imageMogr2/auto-orient/strip|imageView2/2/w/941/format/webp)

5）编写程序代码

将下列代码复制到 HelloWorld.cpp 编辑器窗口。

\#include  intmain(){std::cout<<"Hello, world!"<<std::endl;return0;}



![img](https://upload-images.jianshu.io/upload_images/14545491-e1c3452d2499b552.png?imageMogr2/auto-orient/strip|imageView2/2/w/1061/format/webp)

\3. 生成并运行 c + + 控制台应用程序项目

1)生成可执行程序

若要生成项目时，从**生成**菜单选择**生成解决方案**或者直接按快捷键**F7**。 输出窗口会显示生成过程的结果。



![img](https://upload-images.jianshu.io/upload_images/14545491-2462256e12756c80.png?imageMogr2/auto-orient/strip|imageView2/2/w/797/format/webp)

2）运行程序

若要运行代码，在菜单栏上，选择**调试**，选择**开始执行但不调试**或者选择**开始调试**。



![img](https://upload-images.jianshu.io/upload_images/14545491-da17b7d05a3ded85.png?imageMogr2/auto-orient/strip|imageView2/2/w/772/format/webp)

将出现一个黑色背景的控制台窗口，其中是程序的输出：



![img](https://upload-images.jianshu.io/upload_images/14545491-0a86dac6cd5ce279.png?imageMogr2/auto-orient/strip|imageView2/2/w/835/format/webp)

\4. 选择C++17语言标准

在项目的属性页对话框中选择 **C/C++**->“**语言**” ->“**C++标准**”,在右边的三角箭头下来列表中选择“c++17”



![img](https://upload-images.jianshu.io/upload_images/14545491-5023378060aa6692.png?imageMogr2/auto-orient/strip|imageView2/2/w/879/format/webp)

关注我的B站:hw-dong和YouTube:hwdong





13人点赞



日记本