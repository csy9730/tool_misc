# Draw.io--在线流程图UML图绘制软件简易教程

## 概述

[draw.io](https://link.jianshu.com/?t=http%3A%2F%2Fwww.draw.io) 是一个强大简洁的在线的绘图网站，支持流程图，UML图，架构图，原型图等图标。支持Github，Google Drive, One drive等网盘同步，并且永久免费。如果觉得使用Web版不方便，draw.io 也提供了多平台的离线桌面版可供[下载](https://link.jianshu.com/?t=https%3A%2F%2Fabout.draw.io%2Fintegrations%2F%23integrations_offline)。

本文的主要内容如下:

- draw.io 的核心设计元素
- draw.io 的基本操作
- 使用 draw.io 绘制简单流程图

![img](https://upload-images.jianshu.io/upload_images/1762071-b98d8ff42a0e454d.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

image.png

## 核心设计

在学习基本操作之前我们先来了解一下draw.io的基本设计，对网页的元素有一个直观的认识。有了基本的框架，学习起来就有迹可循了。大部分的绘图应用都离不开三个基本的元素，**图形**，**链接**，**文本**。每个元素都有基本的操作和样式，元素与元素之间又可以进行组合，“三生万物”，生成各种各样的图表。

首先打开draw.io的网站，加载之后会出现以下的画面。这里是选择图表保存的方式，你可以选择常用的网盘，也可以选择decide later 在之后绘图结束保存的时候在进行选择。



![img](https://upload-images.jianshu.io/upload_images/1762071-7fe2ac34b6faa98f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

image.png

![img](https://upload-images.jianshu.io/upload_images/1762071-85c61f38c0a7c971.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

image.png

### 绘图区

进入应用后，界面非常直观简洁。顶部菜单栏提供各项基本操作，左侧是图形区，中间部分是画布，右侧部分是检查器，根据当前的元素显示不同的操作。



![img](https://upload-images.jianshu.io/upload_images/1762071-6111eb50d0ecb46f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

image.png

### 快速开始

整个界面的操作非常直观，如果有相关绘图软件的使用经验，相信已经可以上手绘图了。

- 添加图形
  - 通过简单的拖拽，即可在画布上面添加图形。
- 添加文本
  - 在画布上任何位置双击都可以添加文本框，在其中输入文字
- 添加链接
  - 在图形上鼠标悬浮，在图形上会浮现基本的链接点。这里分为外边界蓝色的大箭头和边上的x型焦点。这两种链接方式稍有不同，在后面我会详细说明。

![img](https://upload-images.jianshu.io/upload_images/1762071-c99bdf9894aeac7f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

image.png

## 基本操作

### 移动、多选、复制与删除

图形、链接、文本这三个元素都可以被选中。可以使用cmd(windows下为ctrl，下同) + A 选择全部元素，也可以使用cmd + click(鼠标左键点击)来进行特定元素的多选。选择元素后可以进行以下操作

- 移动：拖拽
- 复制： cmd + C
- 复制并粘贴： cmd + D
- 删除：delete键

### 创建链接

上面提到过在图形上面悬浮鼠标会出现图形的链接点。

- 使用蓝色箭头进行快速链接
  - 点击蓝色箭头，会在指定方向创建链接，并在链接末端生成一个完全一致的元素
  - 如果需要控制链接位置，可以按住ctrl键，拖拽蓝色箭头到指定位置

![img](https://upload-images.jianshu.io/upload_images/1762071-6783772f8eb8358f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

image.png



![img](https://upload-images.jianshu.io/upload_images/1762071-84118515bdccca63.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

image.png

- 链接图形
  - 在悬浮图形后选择x型焦点（会高亮为绿色）可以创建链接，拖拽链接线到目标图形上的x型焦点，完成**固定链接**
  - 在悬浮图形后选择x型焦点（会高亮为绿色）可以创建链接，拖拽链接线到目标图形的边上，直到图形外边变成蓝色，松开鼠标，完成**浮动链接**

![img](https://upload-images.jianshu.io/upload_images/1762071-32b35a78656faef2.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

image.png



![img](https://upload-images.jianshu.io/upload_images/1762071-3a7e79e2db7579e9.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

image.png

**固定链接是指链接始终固定在图形的链接点上，不会随着图形移动而变化，浮动链接则会根据图形的移动在图形的边上进行移动自适应。如下图，固定链接始终固定在右边，而浮动链接则从上边移动到了下边**

![img](https://upload-images.jianshu.io/upload_images/1762071-2d7726ac861d598d.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

image.png



### 图形替换与旋转

通过快速创建链接的方式可以快速的创建图形并进行链接，但是如果需要不同的图形呢？

- 替换：从左侧图形库选择需要的图形，拖拽到要替换的图形中央，直到出现了一个替换的褐色标志，松开即可实现替换

  ![img](https://upload-images.jianshu.io/upload_images/1762071-ea1e3087d156b435.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

  image.png

- 旋转：选中图形，拖拽上方的旋转箭头即可
  [图片上传失败...(image-9629c4-1523589315413)]

## 制作流程图

### 基本绘图

掌握了图形，文本和链接的基本操作，就可以实操来画一个流程图了，检验一下学习效果，如果哪一个部分不够熟练可以温习一下上面的教程



![img](https://upload-images.jianshu.io/upload_images/1762071-7c71a4319aeb15a8.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

image.png

### 编辑样式

选中元素在右侧的检查器可以修改元素的颜色，大小，布局等等。请读者自行操作。



![img](https://upload-images.jianshu.io/upload_images/1762071-58661b0ae227b284.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

image.png

### 保存和导出

在File菜单可以执行保存，并将图片导出成图片或其他格式的文件。

## 总结

- 介绍draw.io的基本组成元素：图形、链接、文本
- 介绍元素的基本操作
- 介绍链接的创建方式
- 介绍元素的替换方法

实际上借助draw.io的模板库还可以绘制更多种类的图，包括UML图，结构图等等。限于篇幅本文就不进行介绍了，但是总体还是离不开本文介绍的基本操作。希望大家阅读完本文能够有所收获，绘制简洁大方的图表，提升自己的软实力！