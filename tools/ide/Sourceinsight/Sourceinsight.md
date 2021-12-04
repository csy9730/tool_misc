# 代码阅读神器——Sourceinsight

[![程序员良许](https://pic1.zhimg.com/v2-32b9e875a4369e9445e0d3a66677099c_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/yychuyu)

[程序员良许](https://www.zhihu.com/people/yychuyu)







120 人赞同了该文章

Sourceinsight（以下简称**SI**）是良许使用过的最好用，最顺手，最强大的编辑器，没有之一！它几乎支持所有的语言，包括：C，C++，ASM，HTML等等，能够自动创建并维护它自己高性能的符号数据库，包括函数、method、全局变量、结构、类和工程源文件里定义的其它类型的符号，对于大工程的源码阅读非常方便。

但是，作为Linux程序员，我们的代码一般放在Linux电脑里。Linux里也有一些好用的代码查看工具，比如sublime，以及著名的Vim。SI什么都好，但就是没有Linux版。如果我们一定要用前文介绍过的共享文件夹来实现。

## **01 安装SI**

安装过程也很简单，一路下一步即可。

## **02 界面介绍**

软件打开之后，界面如下图所示。

![img](https://pic2.zhimg.com/80/v2-84bd7265c48408f944589e5980b3fdad_1440w.jpg)

介绍几个比较陌生的：

**2.1** 工具栏最右侧的那个 「全工程搜索」 按钮。

这个名称不是官方的，是我起的。它的作用是在全工程所有文件，而不仅是当前文件里，搜索所有匹配的代码行。

利用倒数第三个框里的两个图标可以上下切换找到的匹配代码。

**2.2** 工具栏里倒数第二个红框里的两个深蓝色的左右箭头的图标。

这两个图标不是撤销与重做，它们的作用在如下场景：

> 我们在一个函数上跳转到它的定义，再在定义里又跳转到另一个变量的定义，如此一层跳一层，如何回到刚开始的位置？

这里就可以使用向左的那个箭头了，点一下往上跳一层，直到最初始的位置，而向右的箭头就是顺着你查看的方向去跳了。这对于代码的查看非常方便！

**2.3** 左下角的 「Context」 窗口，是快速预览区。

当你把鼠标放在函数、变量、宏等上面两秒，它就将它们的定义显示在此窗口里。

**2.4** 右下角的 「Relation」 窗口，是函数、变量引用关联区。

把鼠标放在函数、变量上两秒，它就会以树形形式显示此函数、变量被引用、调用的情况，通过点击可以快速跳到被引用、调用的地方。

## **03 快速建立工程**

**3.1** 点击 「Project」 --> 「New project…」，弹出 「New Project」 窗口。

上面一栏输入的是项目名称，本文以开源项目 「tinyhttpd」 为例，故相应输入此名字。

下面一栏输入项目数据文件保存位置，默认是在 「我的文档」 下面。

填写完毕之后点击「OK」，弹出的对话框选择「是」。

![img](https://pic4.zhimg.com/80/v2-8f488c80afb7b4f5b74157b33541dec7_1440w.jpg)

**3.2** 在 「New Project Settings」 里直接点击「OK」。

![img](https://pic3.zhimg.com/80/v2-6582f1edb591aa39dbd4979bf9d7d9b2_1440w.jpg)

**3.3** 现在来添加项目源文件。

我们的代码已经放在虚拟机共享文件夹share里，所以直接在最上面的输入框里输入虚拟机+共享文件夹即可，然后再点击一下回车，接着再点击项目文件夹 「Tinyhttpd-0.1.0」，最后再在右侧点击 「Add All」，即可完成源代码的添加。

![img](https://pic4.zhimg.com/80/v2-851f1a156395055521af0ad1462e69ff_1440w.jpg)

**3.4** 在上一步中，会出现如下对话框：

![img](https://pic1.zhimg.com/80/v2-10ae73b39800ca4d149e2ca6922a8530_1440w.jpg)

一般我们会将此对勾打上，因为如果我们的工程比较庞大，代码结构比较复杂，打上此勾会帮我们也添加此目录下的子目录，以及子目录的子目录，就会把所有需要的文件全部添加进去。

**3.5** 工程建立之后，就可以双击想要查看的文件来查看代码了。

## **04 常用操作**

**4.1 代码同步**

工程刚建立完成之后，一般代码还未同步，表现为有些变量颜色为黑色。这时可以通过 「Project」 --> 「synchronize files…」来同步代码。

![img](https://pic1.zhimg.com/80/v2-8cff04c1d801b6edad68a6f558ce1678_1440w.jpg)

**4.2 查看函数、变量、宏的定义**

有三种方法：

> ① 选中该变量，右键，选择 「Jump to Definition」，即可跳到定义；
> ② 按住ctrl，再用鼠标左键点击一下变量；
> ③ 光标放在变量处两秒，在 「Context」 窗口里显示定义。

**4.3 查找引用**

选择一个变量或方法后右键 「Lookup References…」 就可以进行查找。

**4.4 查找调用**

这个是针对方法的，选中方法名，然后右键 「Jump to Caller」 ，如果只有一次调用，则直接跳转，如果多次调用，则显示一个列表框，选择一项就会跳转过去。

## **05 小结**

本文介绍了SI的安装、界面、常用操作，都是比较基本的内容。但这些内容又是非常常用的，所以先拿出来讲。SI的功能非常强大，当然不仅限于本文所讲内容，比如它还可以安装各种各样的插件，这将更高级的功能留在后面继续更新，请继续关注！

**码字不易，如果您觉得有帮助，麻烦点个赞再走呗~**

编辑于 2020-06-12 16:42

Linux

程序员

互联网