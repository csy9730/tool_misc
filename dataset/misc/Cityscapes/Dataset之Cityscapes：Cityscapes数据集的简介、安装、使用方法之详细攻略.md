# Dataset之Cityscapes：Cityscapes数据集的简介、安装、使用方法之详细攻略



一个处女座的程序猿 2018-10-07 20:18:44  43370  收藏 96
分类专栏： Dataset
版权

Dataset
专栏收录该内容
50 篇文章9 订阅
订阅专栏
Dataset之Cityscapes：Cityscapes数据集的简介、安装、使用方法之详细攻略

 



目录

Cityscapes数据集的简介

1、Cityscapes数据集的特点

2、Cityscapes数据集的目的

3、样例解释

4、Features

5、标签政策

6、Class Definitions

Cityscapes数据集的安装

Cityscapes数据集的使用方法

1、细致的注释

2、粗糙的注释

 

 

 

 

 

 

## Cityscapes数据集的简介

 Cityscapes拥有5000张在城市环境中驾驶场景的图像（2975train，500 val,1525test）。它具有19个类别的密集像素标注（97％coverage），其中8个具有实例级分割。Cityscapes数据集，即城市景观数据集，这是一个新的大规模数据集，其中包含一组不同的立体视频序列，记录在50个不同城市的街道场景。
   城市景观数据集中于对城市街道场景的语义理解图片数据集，该大型数据集包含来自50个不同城市的街道场景中记录的多种立体视频序列，除了20000个弱注释帧以外，还包含5000帧高质量像素级注释。因此，数据集的数量级要比以前的数据集大的多。Cityscapes数据集共有fine和coarse两套评测标准，前者提供5000张精细标注的图像，后者提供5000张精细标注外加20000张粗糙标注的图像。
   Cityscapes数据集包含2975张图片。包含了街景图片和对应的标签。大小为113MB。Cityscapes数据集，包含戴姆勒在内的三家德国单位联合提供，包含50多个城市的立体视觉数据。



### 1、Cityscapes数据集的特点
像素级标注；
提供算法评估接口。

### 2、Cityscapes数据集的目的
评价视觉算法在城市场景语义理解的主要任务中的性能:像素级、实例级、泛光语义标注;
支持旨在利用大量(弱)注释数据的研究，例如用于训练深度神经网络。

### 3、样例解释
​         第一张图是的高质量密集像素注释的示例，提供了5 000张图像。重叠颜色编码语义类（参见类定义）。请注意，交通参与者的单个实例是单独标注的。第二张是粗略注释，除了精细的注释外，我们还与pallas ludens合作，为一组20000图像提供更粗的多边形注释。同样，重叠的颜色对语义类进行编码（参见类定义）。注意，我们的目标不是注释单个实例，但是，我们标记了覆盖单个对象的多边形。



数据集官网：https://www.cityscapes-dataset.com/

 

 

### 4、Features
Type of annotations

Semantic
Instance-wise
Dense pixel annotations
Complexity

30 classes
See Class Definitions for a list of all classes and have a look at the applied labeling policy.
Diversity

50 cities
Several months (spring, summer, fall)
Daytime
Good/medium weather conditions
Manually selected frames
Large number of dynamic objects
Varying scene layout
Varying background
Volume

5 000 annotated images with fine annotations (examples)
20 000 annotated images with coarse annotations (examples)
Metadata

Preceding and trailing video frames. Each annotated image is the 20th image from a 30 frame video snippets (1.8s)
Corresponding right stereo views
GPS coordinates
Ego-motion data from vehicle odometry
Outside temperature from vehicle sensor
Benchmark suite and evaluation server

Pixel-level semantic labeling
Instance-level semantic labeling

### 5、标签政策
​      被标记的前景对象不能有洞，也就是说，如果有一些背景是可见的“通过”一些前景对象，它被认为是前景的一部分。这也适用于高度混合了两个或多个类的区域:它们被用前台类标记。例如:房子前的树叶或天空(一切树木)，透明的车窗(一切汽车)。

 

### 6、Class Definitions
Please click on the individual classes for details on their definitions.

Group	Classes
flat	road · sidewalk · parking+ · rail track+
human	person* · rider*
vehicle	car* · truck* · bus* · on rails* · motorcycle* · bicycle* · caravan*+ · trailer*+
construction	building · wall · fence · guard rail+ · bridge+ · tunnel+
object	pole · pole group+ · traffic sign · traffic light
nature	vegetation · terrain
sky	sky
void	ground+ · dynamic+ · static+



### Cityscapes数据集的安装
T1、数据集下载：https://www.cityscapes-dataset.com/login/

1 -> gtFine_trainvaltest.zip (241MB)
2 -> gtCoarse.zip (1.3GB)
3 -> leftImg8bit_trainvaltest.zip (11GB)
4 -> leftImg8bit_trainextra.zip (44GB)
8 -> camera_trainvaltest.zip (2MB)
9 -> camera_trainextra.zip (8MB)
10 -> vehicle_trainvaltest.zip (2MB)
11 -> vehicle_trainextra.zip (7MB)
12 -> leftImg8bit_demoVideo.zip (6.6GB)
28 -> gtBbox_cityPersons_trainval.zip (2.2MB)



 

Cityscapes数据集的使用方法
1、细致的注释
下面是我们的高质量的密集的像素注释的例子为一卷000 图像。覆盖颜色编码语义类(参见类定义)。注意，流量参与者的单个实例是单独注释的。



 

2、粗糙的注释
除了优良的注释,我们提供一组粗多边形注释000 图像与帕拉斯合作Ludens。同样，覆盖的颜色编码语义类(参见类定义)。注意，我们的目标不是注释单个实例，但是，我们标记了覆盖单个对象的多边形。



 

 

 https://blog.csdn.net/qq_41185868/article/details/82960880



https://github.com/mcordts/cityscapesScripts

 

 

 

 

 