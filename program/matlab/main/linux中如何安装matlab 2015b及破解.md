# linux中如何安装matlab 2015b及破解

[zll](https://www.zhihu.com/people/zll-65-9)



感谢同门们在我学习数据处理过程中给予的帮助！！



1 人赞同了该文章

下载matlab工具包，下载链接[https://pan.baidu.com/s/1UZZVAnThRl78K1HRJTVTZQ](https://link.zhihu.com/?target=https%3A//pan.baidu.com/s/1UZZVAnThRl78K1HRJTVTZQ)，提取码：65k7

该链接里面包含matlab2015b镜像iso以及破解包crack

在主机里面解压破解包，然后将破解包和matlab镜像拉到虚拟中，此处我放在了/home/zll/Documents/下。

安装之前需要新建一个文件夹用于挂载matlab镜像iso，此处我就在iso和crack所在的文件夹下新建一个/home/zll/Documents/matlab/

![img](https://pic2.zhimg.com/80/v2-1af2f7b8db68d91e424fb3a755d1f15d_1440w.png)

在该目录下右键打开终端，输入sudo mount /home/zll/Documents/R2015b_glnxa64.iso /home/zll/Documents/matlab，将iso镜像挂载到该目录下，出现这句话则表示挂载成功

![img](https://pic4.zhimg.com/80/v2-851ee69adc012a283d3c090d604edb7f_1440w.png)

然后输入cd ./matlab进入挂载目录中，再输入./install执行安装程序

除了以下几步之外，其他全部选择next

选择use a file installation key

![img](https://pic1.zhimg.com/80/v2-b0f341640698657f3f899055b49367bc_1440w.jpg)

选择i have the file installation key for my license，然后输入密钥，密钥在crack文件夹下的readme里面（第一串数字）

![img](https://pic4.zhimg.com/80/v2-dc6e57ce99fd8597c561c610f6715e43_1440w.jpg)

之后就安装结束，需要取消刚刚的挂载文件夹，输入 sodu umount /home/zll/Documents/matlab

此时可能会提示busy，那么使用fuser来处理

fuser –m /home/zll/Documents/matlab 查看什么进程在使用挂载点

fuser –m –k –I /home/zll/Documents/matlab杀死在使用的进程

再次输入sodu umount /home/zll/Documents/matlab即可取消挂载



现在安装结束了，我们需要来破解matlab

首先把crack文件夹下/bin/glnxa64/中的三个文件拷贝到/usr/local/MATLAB/R2015b/bin/glnxa64中。注意！！！不能直接复制，必须在终端中执行，因为matlab所在的路径是用权限的，普通用户没有权限更改该路径下的内容。输入sudo cp home/zll/Documents/Matlab_2015b_Linux64_Crack/bin/glnxa64/* /usr/local/MATLAB/R2015b/bin/glnxa64

然后执行sudo /usr/local/MATLAB/R2015b/bin/matlab进行激活，选择activate manually without the internet

![img](https://pic1.zhimg.com/80/v2-184bc27603bdaa0ce1cccf13dd461f40_1440w.jpg)

选择Enter the full path to your license file, including the file name:

选中位于crack下的license_standalone.lic文件，点击next，此时matlab已经激活完成

![img](https://pic2.zhimg.com/80/v2-36f92098e46cf1435533d40613aa3bd5_1440w.jpg)

然后需要配置环境，需要修改bash.bashrc文件

执行sudo gedit /etc/bash.bashrc，在打开的文档末尾加上以下两句话：

```text
PATH=/usr/local/MATLAB/R2015b/bin:${PATH}
export PATH
```

然后保存该脚本

在终端中执行source /etc/bash.bashrc

注意，配置好环境之后，你可以执行sudo –i切换到root身份下，此时你在linux的任何目录下面打开终端，

执行matlab都可以直接运行matlab

但是如果你现在不是root身份，你需要在/usr/local/MATLAB/R2015b/bin/中打开终端，执行sudo ./matlab

发布于 07-12 15:33

Linux

赞同 1

添加评论

分享