# NCL的安装

[姬非](https://www.jianshu.com/u/aacd4f0c0e3c)关注

0.1822017.07.28 22:48:33字数 2,042阅读 8,802

Hello大家好~刚刚整理电脑里的东西，发现前些阵子写毕业论文的间歇自己瞎整理的一些文件。
大气科学本来就是门很小众的学科，NCL这种只有我们气象人使用的软件，可以用来自学的材料更是少之又少。我本人大二的时候自学这个软件真的步！履！维！艰！正好大四写毕业论文又捡起来了它，在导师强迫症下使用了这个软件画图上的各种函数各种参数，3个月以来把网站都翻烂了。可惜工作没有从事本专业相关的岗位，所以恐怕以后再也不会用啦！趁着现在还没忘光，希望能整理出一些学习思路和主要知识点，能让大气科学的学弟学妹们更容易上手这个软件~

# NCL简介

------

想学NCL，首先你得知道NCL是个啥玩意儿？

> NCL (NCAR Command Language) 是一款专为大气科学设计的数据分析和可视化程序设计语言。
>
> 官方网站： [http://www.ncl.ucar.edu](https://link.jianshu.com/?t=http://www.ncl.ucar.edu)

好的嘛，以上是很官方的解释。个人理解：NCL = 画图软件

------

NCL有什么好处？我们为什么要学习NCL呢？

就目前来讲，我们学气象使用的画图工具主要有三种，分别是Matlab，GrADs和NCL。

Matlab的好处很明显，使用的人多，相对教程也比较多，但它并不是气象专用的，如果要叠加地图之类的会比较麻烦，而且，占！用！空！间！非！常！大！一个Matlab完全安装下来十几个G的空间还是需要的，对电脑来说是个相当高的负荷。

而GrADs和NCL就不一样了，占用空间非常小，计算和出图速度也会快很多。为什么我建议大家一开始就学习NCL而不是grADs？原因一，NCL画出来的图好看，GrADs巨丑！原因二，老师们爱用NCL，而且刚开始学习GrADs的同学到后来(毕业论文)还是要学NCL，摊手，我一开始就学的NCL诶嘿嘿嘿，虽然是因为GrADs没有mac版本才选择的NCL。原因三，服务器是Linux系统，只有装NCL。

（刚刚查了一下，貌似GrADs也有linux和mac版本？？？）

NCL画出的图：



![img](https://upload-images.jianshu.io/upload_images/3851306-2446568bbe1c5507.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

Fig.1.NCL (图片来源于我的本科毕业论文)

GrADs画出的图：



![img](https://upload-images.jianshu.io/upload_images/3851306-e3b2cd9e7a732e0b.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

Fig.2.grads (图片来源于网络)

------

NCL大概要怎么用呢？安装好以后，打开电脑的Terminal/终端/Shell。

然后，主要有两种使用NCL的方式。

一种是交互模式：交互模式类似于使用Matlab的命令行，需要用户一行命令输入进去，回车，执行，再输入一行，回车，执行。

交互模式的使用：输入ncl，按回车即可进入NCL交互模式。
如果出现如下提示即成功。



![img](https://upload-images.jianshu.io/upload_images/3851306-0c8764a364674153.png?imageMogr2/auto-orient/strip|imageView2/2/w/1146/format/webp)

Fig.3.NCL交互模式

一种是Batch模式：Batch模式就是把NCL代码全写好存在.ncl的文件中，然后一次性执行整个文件中的代码。

Batch模式的使用：输入ncl + [**相对**/**绝对**路径] + [NCL程序名(.ncl结尾)]



![img](https://upload-images.jianshu.io/upload_images/3851306-0e0edd3bb50fe4e8.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

Fig.4.NCL Batch模式

------

# NCL的安装

- NCL的安装主要分为以下几个步骤:
  1. 安装XQuartz
  2. 安装gcc和gfortran
  3. 安装NCL

## 1.安装XQuartz

- XQuartz是什么？

  > 简单来说就是一个图形系统。XQuartz是X Window系统，可以让你的屏幕显示图形，是X11软件的开源版本，可以在OS X系统上运行。

  我们是要画图的嘛，没有这个图形系统就画不出图，就这么简单粗暴的解释hhhhh

- 如何安装XQuartz？

  > 一般来说OS X系统安装盘里自带了X11软件，但是根据度娘的说法，从10.8版本以后都不在安装盘提供了。所以，不是所有人都要手动安装XQuartz。

  XQuartz安装文件下载地址: [www.xquartz.org](https://link.jianshu.com/?t=https://www.xquartz.org/)

  .dmg文件，如果告诉我不会安装你就去面壁吧！安装好了就可以把安装包删了呦~

- 如何检查你的电脑上是否有安装X11软件？

  可以打开Terminal输入:

  ```undefined
  ng4ex xy01n -clean
  ```

如果电脑上已有X11软件，此时会自动启动一个画着XY图的窗口。

如果没有窗口弹出或者出现报错，你需要重新下载并安装XQuartz。地址见上条。

## 2.安装gcc和gfortran

- 为啥要安装gcc,gfortran?

  > NCL的执行有时候依赖于gcc和gfortran。说白了就是NCL是由C语言和Fortran语言编写的，需要有这两种语言的编译器，所以需要gcc和gfortran。

- 如何检查电脑上是否有安装gcc和gfortran?

  打开Terminal输入:

  ```bash
  which gcc
  which gfortran
  gcc --version       // 查看gcc版本
  gfortran --version  // 查看gfortran版本
  ```

  下图为已安装gcc和gfortran的结果：



![img](https://upload-images.jianshu.io/upload_images/3851306-2a90b6920119036c.png?imageMogr2/auto-orient/strip|imageView2/2/w/1128/format/webp)

Fig.5.已安装GCC/GFortran

- 如何安装？

  什么？？你都要开始用NCL了我不信你没用过gcc和gfortran！
  gcc和gfortran下载地址：[http://hpc.sourceforge.net/](https://link.jianshu.com/?t=http://hpc.sourceforge.net/)

## 3.下载和安装NCL

在这一步中，你需要:

1. 选择合适自己系统的NCL文件并下载安装
2. 设置环境变量，使其指向你的NCL安装路径
3. 测试NCL是否安装成功

- 如何选择合适的NCL文件？

  请打开Terminal并输入：

  ```undefined
  sw_vers -productVersion
  uname -m
  ```

  结果如:



![img](https://upload-images.jianshu.io/upload_images/3851306-f5fb965ed14cfef9.png?imageMogr2/auto-orient/strip|imageView2/2/w/1140/format/webp)

Fig.6.查看所需版本

意味着你需要下载: `ncl_ncarg-6.4.0.MacOS_10.11_64bit_gnu540.tar.gz`

所有的NCL二进制源文件都在 Earth System Grid [https://www.earthsystemgrid.org/dataset/ncl.html](https://link.jianshu.com/?t=https://www.earthsystemgrid.org/dataset/ncl.html)中列出。

目前最新的版本是 [NCL 6.4.0 binaries](https://link.jianshu.com/?t=https://www.earthsystemgrid.org/dataset/ncl.640.html)

找到你需要的版本，下载吧~

- 如何安装NCL二进制文件？

  首先需要确定的是，你想把文件安装在哪里。

  比如你想安装在`/usr/local/ncl-6.4.0`这个文件夹中:

  那么首先你需要创建这个文件夹:

  ```bash
  mkdir /usr/local/ncl-6.4.0          // mkdir 创建目录
  ```

  然后将安装文件解压缩到目标文件夹中，注意当前路径问题:

  ```jsx
  // tar -zxf <安装文件> -C <想要安装到的目录>
  tar -zxf ~/ncl_ncarg-6.4.0-MacOS_10.12_64bit_gnu530.tar.gz -C /usr/local/ncl-6.4.0
  ```

- 如何设置环境变量，使其指向NCL路径？

  打开Terminal，输入:

  ```cpp
  ls -a ~/        // 显示home路径下所有隐藏文件目录
  ```

  你会看到一个名为`.bash_profile`的文件。打开这个文件(可利用命令`open .bash_profile`)，在文件最后加上以下两行命令:

  ```bash
  export NCARG_ROOT=/usr/local/ncl-6.4.0
  export PATH=$NCARG_ROOT/bin:$PATH
  ```

  注意，其中第一行的`/usr/local/ncl-6.4.0`不是固定的，要看你上一步安装在哪里，记得替换！

  修改后记得command+s保存，并重启Terminal使其生效。一定要记得重启！关掉！再重新打开！不然没有用！

  Ok~环境变量修改好啦！

- 如何测试是否安装好？

  再问一次，设置了环境变量以后，你的Terminal重启了嘛？重启了嘛？不重启的话，刚刚的设置没有生效，你会以为自己安装出现了问题，启动不了NCL哦~

  重启后，输入:

  ```undefined
  ng4ex gsun01n -clean
  ```

  好啦~ 如果出现了图形界面，证明你已经安装成功！可以尽情"享受"美妙的NCL了~

  **如果仍有问题**，建议你自己去官网上对照各种报错看一下~ 学会看软件的说明文档是一个程序猿/媛必备的素质，一边看还能提高英语能力呢！(嗯对我就是懒得继续写那些错误的解决方法了！)





12人点赞



NCL学习