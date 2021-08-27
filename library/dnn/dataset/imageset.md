# imageset

## tutorial

### mnist

### cifar

#### cifar10
cifar10
#### cifar100


## image

[PASCAL VOC Challenge performance evaluation and download server](http://host.robots.ox.ac.uk:8080/)
### ImageNet分类数据集
ImageNet分类数据集

即大名鼎鼎ImageNet2012竞赛的数据集，在图像分类数据集中属于最常用的跑分数据集和预训练数据集。

主要内容可以参考ILSVRC2012_devkit_t12.gz的readme.txt

这里给出官网下载的链接：http://www.image-net.org/download-images
如果想要下载原始图片，需要注册一个账号，注册邮箱需要带有 edu，即学校邮箱。

本代码的操作主要针对原始图片的下载及分类任务数据集的处理，点击进入下载原图的页面后，
可以看到一系列内容，一般我们会下载 ILSVRC 2012 作为实验数据。

### ILSVRC2012
ILSVRC2012这个训练数据库（这是一个图片分类训练数据库），先进行网络图片分类训练。这个数据库有大量的标注数据，共包含了1000种类别物体，因此预训练阶段CNN模型的输出是1000个神经元

### PASCAL VOC2011
相当于一个竞赛，里面包含了20个物体类别：PASCAL VOC2011 Example Images 
还有一个背景，总共就相当于21个类别，