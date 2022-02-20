撰写了文章 更新于 2019-07-26 13:46:10

# Twine学习笔记1：基础操作

## Twine是什么

Twine是一个免费的开源软件，由Chris Klimas创建，用于以网页的形式制作互动小说。可以方便地编辑非线性结构的剧本，最后以HTML5，Javascript和CSS形式输出。

## 安装

可以在官网上下载：https://twinery.org/

## 使用步骤

### 创建游戏

如下图，创建的游戏会保存在系统缓存中，不保存的话下次打开就会消失。

![40b7e8aa19bd8b2b912121f1ea033a27.jpg](https://pic1.cdncl.net/user/alpacas/common_pic/40b7e8aa19bd8b2b912121f1ea033a27.jpg?imageView2/2/w/1280)

### 添加片段

双击一开始的未命名片段，编辑如下：

![a77a0e49d8dfde7fe063d1dbf1c3d508.jpg](https://pic1.cdncl.net/user/alpacas/common_pic/a77a0e49d8dfde7fe063d1dbf1c3d508.jpg?imageView2/2/w/1280)

双中括号里的文字就会成为下一个片段的标题。

![47895debff7fef80cd7f874625efddb5.jpg](https://pic1.cdncl.net/user/alpacas/common_pic/47895debff7fef80cd7f874625efddb5.jpg?imageView2/2/w/1280)

### 添加分支

其实就是添加两个片段，如下图（“第三页”是“跟着我”的下一个片段）：

![71c46e0b547091c5191dc1189af4ca1a.jpg](https://pic1.cdncl.net/user/alpacas/common_pic/71c46e0b547091c5191dc1189af4ca1a.jpg?imageView2/2/w/1280)

上面的

```
[[我感觉很难受->选项1]]
```

代表的是“我感觉很难受”的选项会跳到“选项1”片段。

这样就会形成分支：

![a173663a41593a9cbedd0a2cbf86d976.jpg](https://pic1.cdncl.net/user/alpacas/common_pic/a173663a41593a9cbedd0a2cbf86d976.jpg?imageView2/2/w/1280)

### 保存游戏

点击“发布到文件”即可。

![af2e509dd787945b575d2ade5449916c.jpg](https://pic1.cdncl.net/user/alpacas/common_pic/af2e509dd787945b575d2ade5449916c.jpg?imageView2/2/w/1280)

## 测试

点击下面的测试按钮即可，测试界面如下图：

![7a1238aab37a56265be44166deb32849.jpg](https://pic1.cdncl.net/user/alpacas/common_pic/7a1238aab37a56265be44166deb32849.jpg?imageView2/2/w/1280)

另外可以点击某个片段的播放按钮从那个片段开始测试。

![aeb35d5fd0aa2babf1c6179472fc9f44.jpg](https://pic1.cdncl.net/user/alpacas/common_pic/aeb35d5fd0aa2babf1c6179472fc9f44.jpg?imageView2/2/w/1280)

[著作权归作者所有。商业转载请联系作者获得授权，非商业转载务必附上原作者名称，注明来自「奶牛关」并给出原文链接。不得以任何形式演绎或修改。](https://cowlevel.net/article/1864679)