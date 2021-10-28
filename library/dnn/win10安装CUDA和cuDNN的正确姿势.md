# win10安装CUDA和cuDNN的正确姿势


[西河沿的风](https://www.zhihu.com/people/ymg-90)

只要我代码敲得够快，bug就追不上我！



203 人赞同了该文章

在win10上安装CUDA和cuDNN总是有很多人安装失败。

软件明明安装成功了为什么还是无法运行呢？

原因是你安装的姿势可能出了点问题（你安装的版本不对）

**正确的安装姿势：**

**1、查看本机的CUDA驱动适配版本**

桌面右键打开英伟达控制面板，点击帮助->系统信息->组件

![img](https://pic3.zhimg.com/80/v2-ab22bdd82ecba2aa51c9e8af172ae89a_720w.jpg)

可以看到本机支持的是CUDA 10.2 版本，表示是不支持更高版本的。如果你升级了驱动，可能会支持更高版本，也可能不会提升。

所以就必须安装 10.2 及以下的版本。

**2、下载CUDA和cuDNN**

CUDA下载页面：[https://developer.nvidia.com/cuda-downloads](https://developer.nvidia.com/cuda-downloads)

![img](https://pic1.zhimg.com/80/v2-24fb4e6fa1c10c806ad06e4dd1e28040_720w.jpg)

点击下载就行了，这个页面卡的一批，下载速度也十分感人。

大家可以使用迅雷下载或者使用阿里云、腾讯云等服务器 wget命令下载，然后转储本地。

实测，阿里云、腾讯云下载CUDA的速度在40MB/s左右

cuDNN下载页面：[https://developer.nvidia.com/rdp/cudnn-download](https://developer.nvidia.com/rdp/cudnn-download)

下载cuDNN是需要登录英伟达开发者账户的，注册一个并填写问卷就行了，很简单。

注意：必须选择和你安装的CUDA匹配的版本。

![img](https://pic3.zhimg.com/80/v2-8a620612bab1e9290f1541ffe838dfde_720w.jpg)

这是个zip包，下载速度还行。

**3、安装CUDA和cuDNN**

找到你下载的CUDA，无脑安装就行了。当然如果你想自定义的话要记住你选择的安装路径。

CUDA安装完成后，打开powershell，执行nvcc -V ，成功的话会返回cuda版本号。

解压cuDNN压缩包，可以看到bin、include、lib目录

![img](https://pic1.zhimg.com/80/v2-dd701f9179792aa78c7f428aa6c8555c_720w.jpg)

打开 C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA

找到你安装的版本目录，打开，找到bin、include、lib目录，将cuDNN压缩包内对应的文件复制到bin、include、lib目录。

注意：是复制文件到bin、include、lib目录，不是复制目录。

**4、添加环境变量**

你需要在系统环境变量的Path项下添加几个路径

![img](https://pic2.zhimg.com/80/v2-3c249fa91df62d252ff8e7c3a435c9d9_720w.jpg)

点击 编辑 -- > 新建、浏览

![img](https://pic1.zhimg.com/80/v2-2ae13a703ae409b883541fc2badcab7c_720w.jpg)

需要添加下面两个路径，这就是说为什么要记住你的安装路径了，我使用的是默认的安装路径。

C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v10.2

C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v10.2\lib\x64

注意：选择你安装的路径

**5、检查安装结果**

打开 C:\Program Files\NVIDIA GPU Computing Toolkit\CUDA\v10.2\extras\demo_suite

在此路径下打开powershell

执行：

![img](https://pic2.zhimg.com/80/v2-007cd911a0120aae71b932084f42e279_720w.jpg)



发布于 2019-11-28

CUDA

cudnn

Windows 10