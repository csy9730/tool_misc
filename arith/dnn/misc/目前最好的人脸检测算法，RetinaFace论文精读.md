# 目前最好的人脸检测算法，RetinaFace论文精读

[zero_f460](https://www.jianshu.com/u/57d67eef866a)关注

2020.04.05 20:15:38字数 5,057阅读 4,609

微信搜索：AI算法与图像处理，最新干货全都有

> 大家好，今天给大家分享一篇人脸算法领域非常知名的paper，RetinaFace(RetinaFace: Single-stage Dense Face Localisation in the Wild)。同时也在文末附上开源项目的链接。跟着我一起读这篇论文，希望论文的思路能够对你有所启发，如果觉得有用的，帮我分享出去，谢啦！

RetinaFace的主要贡献



![img](https://upload-images.jianshu.io/upload_images/15621521-26a1822dce1ee5b7?imageMogr2/auto-orient/strip|imageView2/2/w/885/format/webp)

# 摘要

尽管在不受控制的人脸检测方面已取得了长足的进步，但是在wilder数据集进行准确有效的面部定位仍然是一个公开的挑战。本文提出了一种鲁棒的single stage人脸检测器，名为RetinaFace，它利用 额外监督（extra-supervised）和自监督（self-supervised）结合的多任务学习（multi-task learning），对不同尺寸的人脸进行像素级定位。具体来说，我们在以下五个方面做出了贡献：（1）我们在WILDER FACE数据集中手工标注了5个人脸关键点（Landmark），并在这个额外的监督信号的帮助下，观察到在hard face检测的显著改善。（2）进一步添加自监督网络解码器（mesh decoder）分支，与已有的监督分支并行预测像素级的3D形状的人脸信息。（3）在WIDER FACE的hard级别的测试集中，RetinaFace超出the state of the art 平均精度（AP） 1.1%（达到AP=91.4%）。（4）在IJB-C测试集中，RetinaFace使state of the art 方法（Arcface）在人脸识别中的结果得到提升（FAR=1e6，TAR=85.59%）。（5）采用轻量级的backbone 网络，RetinaFace能在单个CPU上实时运行VGA分辨率的图像。

> FAR(False Accept Rate)表示错误接受的比例
>
> TAR(True Accept Rate)表示正确接受的比例
>
> VGA分辨率 320*240，目前主要应用于手机及便携播放器上

# 1、Introduction

人脸自动定位对许多应用而言都是人脸图像分析的前提步骤，例如人脸属性分析（比如表情，年龄）和人脸识别。人脸定位的狭义定义可以参考传统的人脸检测，其目的在没有任何尺度和位置先验的条件估计人脸边界框。然而，**本文提出的人脸定位的广义定义包括人脸检测、人脸对齐、像素化人脸解析（**pixel-wise face parsing**）和三维密集对应回归（**3D dense correspondence regression**）。**这种密集的人脸定位为所有不同的尺度提供了精确的人脸位置信息。受到一般目标检测方法的启发，即融合了深度学习的最新进展，人脸检测最近取得了显著进展。与一般的目标检测不同，**人脸检测具有较小的比例变化(从1:1到1:1.5)，但更大的尺度变化(从几个像素到数千像素)。**目前most state-of-the-art 的方法集中于single-stage设计，该设计密集采样人脸在特征金字塔上的位置和尺度，与two-stage方法相比，表现出良好的性能和更快的速度。在此基础上，我们**改进了single-stage人脸检测框架，并利用强监督和自监督信号的多任务损失，提出了一种most state-of-the-art的密集人脸定位方法**。我们的想法如图1所示。



![img](https://upload-images.jianshu.io/upload_images/15621521-909aee454b9d3b58.png?imageMogr2/auto-orient/strip|imageView2/2/w/730/format/webp)

image.png

通常，**人脸检测训练过程包含分类和框回归损失**。chen等人观察到对齐人脸能为人脸分类提供更好的特征，建议在联合级联框架中结合人脸检测和对齐。由此启发，MTCNN和STN同时检测人脸和五个人脸landmark。由于训练数据的限制，JDA、MTCNN和STN还没有验证微小的人脸检测是否可以从额外的五个人脸Landmark的监督中获益。我们在本文中所要回答的问题之一是，**能否利用由5个人脸关键点构成的额外监督信号，在WIDER FACE的hard测试集上推进目前最好的性能(90.3%)。**在Mask R-CNN中，通过添加一个用于预测目标Mask的分支，与现有的用于边界框识别和回归的分支并行，显著提高了检测性能。**这证实了密集的像素级标注也有助于改进检测**。遗憾的是，对于具有挑战性的人脸数据集WIDER FACE，无法进行密集的人脸标注(以更多的Landmark或语义分割)。由于有监督的信号不易获得，问题是我们能否应用无监督的方法进一步提高人脸检测。 在FAN中，提出了一种anchor-level注意力图（attention map）来改进遮挡人脸检测。然而，所提出的注意力图相当粗糙，不包含语义信息。近年来，自监督三维形态模型在wilder实现了很有前景的三维人脸建模。特别是Mesh decoder利用节点形状和纹理上的图卷积实现了超实时速度。然而, 应用mesh decoder到single-stage检测的主要挑战是：*(1) 相机参数难以准确去地估计 , (2) 联合潜在形状和纹理表示是从单个特征向量（特征金字塔上的11 Conv）而不是RoI池化的特征预测，这意味着特征转换的风险**。本文采与现有监督分支并行的用网格解码器（mesh decoder）通过自监督学习预测像素级的三维人脸形状。综上所述，我们的主要贡献如下:

- 在single-stage设计的基础上，**提出了一种新的基于像素级的人脸定位方法RetinaFace，该方法采用多任务学习策略**，**同时预测人脸评分、人脸框、五个人脸关键点以及每个人脸像素的三维位置和对应关系。**
- 在WILDER FACE hard子集上，RetinaFace的性能比目前the state of the art的two-stage方法(ISRN)的AP高出1.1% (AP等于91.4%)。
- 在IJB-C数据集上，RetinaFace有助于提高ArcFace的验证精度(FAR=1e-6时TAR等于89:59%)。这表明更好的人脸定位可以显著提高人脸识别。
- 通过使用轻量级backbone网络，RetinaFace可以在VGA分辨率的图片上实时运行
- 已经发布了额外的注释和代码，以方便将来的研究

# 2、Related Work

**图像金字塔 vs .特征金字塔：**滑动窗口范例，其中分类器应用于密集的图像网格，可以追溯到过去的几十年。Viola-Jones是里程碑式工作，它探索了级联结构，实时有效地从图像金字塔中剔除假人脸区域，使得这种尺度不变的人脸检测框架被广泛采用。**尽管图像金字塔上的滑动窗口是主要的检测范式，随着特征金字塔的出现，多尺度特征图上的滑动anchor迅速主导了人脸检测。\**\**Two-stage vs single-stage：**目前的人脸检测方法继承了一般目标检测方法的一些成果，可分为两类：Two-stage方法(如Faster R-CNN)和single-stageTwo-stage(如SSD和RetinaNet)。Two-stage方法采用了**一种具有高定位精度的“proposal与细化”机制**。相比之下，single-stage方法**密集采样人脸位置和尺度，导致训练过程中positive和negative样本极不平衡。**为了解决这种不平衡，广泛采用了**采样（Training region-based object detectors with online hard example mining）和重加权(re-weighting)方法。**与two-stage方法相比，s**ingle-stage方法效率更高，召回率更高，但存在假阳性率更高和定位准确性降低的风险**。**Context Modelling：**提升模型的上下文模块推理能力以捕获微小人脸，SSH和PyramidBox在特征金字塔上用context modules扩大欧几里德网格的感受野。为了提高CNNs的非刚性变换建模能力，可变形卷积网络(deformable convolution network, DCN)采用了一种新的可变形层对几何变换进行建模。WILDER FACE 2018[冠军方案]表明，对于提高人脸检测的性能而言，刚性(expansion)和非刚性(deformation)上下文建模是互补和正交的（orthogonal）。



![img](https://upload-images.jianshu.io/upload_images/15621521-e35f8491d905e80b?imageMogr2/auto-orient/strip|imageView2/2/w/846/format/webp)

image

**多任务学习：**在目前广泛使用的方案是结合人脸检测和人脸对齐，对齐后的人脸形状为人脸分类提供了更好的特征。在Mask R-CNN中，通过添加一个并行分支来预测目标Mask，显著提高了检测性能。Densepose采用Mask-RCNN的结构，在每个选定区域内获得密集的part标签和坐标。然而，[20,1]中的dense回归分支是通过监督学习训练的。此外，dense分支是一个小的FCN应用于每个RoI预测像素到像素的密集映射。

# 3、RetinaFace

**3.1. Multi-task Loss**

对于任何训练的anchor i，我最小化下面的多任务的 loss：



![img](https://upload-images.jianshu.io/upload_images/15621521-2bbea5c0971cefe4?imageMogr2/auto-orient/strip|imageView2/2/w/399/format/webp)

image

（1）人脸分类loss Lcls(pi,pi*)，这里的pi是anchor i为人脸的预测概率，对于pi \* 是1是positive anchor，0代表为negative anchor。分类loss Lcls是softmax loss 在二分类的情况（人脸/非人脸）。（2）人脸框回归loss，Lbox(ti,ti*)，这里的ti={tx,ty,tw,th}，ti * ={tx *,ty ,tw \* ,th }分别代表positive anchor相关的预测框和真实框（ground-truth box）的坐标。我们按照 [16]对回归框目标（中心坐标，宽和高）进行归一化，使用Lbox(ti,ti )=R(ti-ti )，这里R 是 Robust loss function（smooth-L1）(参考文献16中定义）（3）人脸的landmark回归loss Lpts(li,li )，这里li={l x1,l y1,...l x5,l y5},li ={l x1 ,l y1 ,...l x5 ,l y5 }代表预测的五个人脸关键点和基准点（ground-truth）。五个人脸关键点的回归也采用了基于anchor中心的目标归一化。（4）Dense回归loss Lpixel （参考方程3）。loss调节参数 λ1-λ3 设置为0.25,0.1和0.01，这意味着在监督信号中，我们增加了边界框和关键点定位的重要性。3.2. Dense Regression Branch****Mesh Decoder：我们直接使用[70,40]中的网格解码器(mesh convolution and mesh up-sampling) ，这是一种基于快速局部谱滤波的图卷积方法。为了实现进一步的加速**，我们还使用了类似于[70]中方法的**联合形状和纹理解码器**，而不是只解码形状的。下面我们将简要解释图卷积的概念，并概述为什么它们可以用于快速解码。如图3(a)所示，二维卷积运算是欧几里德网格感受野内的“核加权邻域加和”。同样，图卷积也采用了图3(b)所示的相同概念。然而，**邻域距离是通过计算连接两个顶点的最小边数来计算的**。我们遵循[70]来定义一个着色的脸部网格（mesh）G=(ν, ε), 其中ν∈R ^(n*6) 是一组包含联合形状和纹理信息的人脸顶点集合， ε∈{0,1}^(n * n)是一个稀疏邻接矩阵，它编码了顶点之间的连接状态。图拉普拉斯行列式定义为 L = D - ε ∈R ^(n * n)，D ∈ R ^(n * n)其中是一个对角矩阵 。



![img](https://upload-images.jianshu.io/upload_images/15621521-70c75be9a5e34e2d.png?imageMogr2/auto-orient/strip|imageView2/2/w/414/format/webp)

image.png

遵循[10,40,70 ], 图卷积的内核g0可以表示为K 项的递归切比雪夫（Chebyshev）多项式



![img](https://upload-images.jianshu.io/upload_images/15621521-52a09dd731355527.png?imageMogr2/auto-orient/strip|imageView2/2/w/400/format/webp)

image.png

这里θ ∈ R^K 是一个切比雪夫系数向量，Tk∈ R^(n * n)是在缩放的拉普拉斯中（L～）中评估K项的切比雪夫多项式。



![img](https://upload-images.jianshu.io/upload_images/15621521-1d9af2ccbf4b4444.png?imageMogr2/auto-orient/strip|imageView2/2/w/685/format/webp)

image.png



![img](https://upload-images.jianshu.io/upload_images/15621521-f527ab3c6f04e264.png?imageMogr2/auto-orient/strip|imageView2/2/w/798/format/webp)

image.png

其中 W和H分别表示anchor crop I*i,j的宽度和高度。

# 4、Experiments

**4.1. Dataset**

WIDER FACE数据集包括32203幅图像和393703个人脸边界框，在尺度、姿态、表情、遮挡和光照方面具有高度差异性。通过随机抽取61个场景类别，将WIDER FACE数据集分为训练(40%)、验证(10%)和测试(50%)子集。基于EdgeBox的检测率，通过逐步合并困难样本来定义三个难度等级(Easy、Medium和Hard)。**额外的标注：**见图4和表1,我们定义五个级别的脸图像质量(根据在人脸上的难度去标注Landmark)并在WIDER FACE的训练和验证子集上标注五个人脸Landmark(即眼中心,鼻子和嘴角)。我们总共在训练集上标注了**84.6k个人脸**，在验证集上标注了**18.5k个人脸**。



![img](https://upload-images.jianshu.io/upload_images/15621521-91f0e5cd2d9c7913.png?imageMogr2/auto-orient/strip|imageView2/2/w/417/format/webp)

image.png



![img](https://upload-images.jianshu.io/upload_images/15621521-9439fd1b480b315c.png?imageMogr2/auto-orient/strip|imageView2/2/w/424/format/webp)

image.png

**4.2. Implementation details**

**特征金字塔：**RetinaFace采用从P2到P6的特征金字塔层，其中P2到P5通过使用自顶向下和横向连接（如[28,29]）计算相应的ResNet残差阶段(C2到C5)的输出。P6是在C5处通过一个步长2的3x3卷积计算得到到。C1-C5是在ImageNet-11k数据集上预先训练好的ResNet-152[21]分类网络，P6是用“Xavier”方法[17]随机初始化的。**上下文模块：**受 SSH [36] 和 PyramidBox [49]启发, 我们 还在五个特征金字塔层应用单独的上下文模块来提高 感受野并增加刚性上下文建模的能力。从2018年 WIDER Face 冠军方案中受到的启发, 我们也在横向连接和使用可变形卷积网络（DCN）的上下文模块中替换所有 3x3的卷积，进一步加强非刚性的上下文建模能力。 **Loss Head：\**\**对于**negative acnhors，只应用分类损失**。对于**positive anchors，计算了多任务损失**。我们使用 一 个跨越不同特征图，**



![img](https://upload-images.jianshu.io/upload_images/15621521-797856fba93ea626.gif?imageMogr2/auto-orient/strip|imageView2/2/w/1/format/webp)

image.gif

，n∈{2,...6}的共享loss head (1x1 conv);对于网格解码器(mesh decoder)，我们采用了预训练模型，这是一个很小的计算开销，允许有效的推理。

Anchor 设置：*

如表2所示，我们在特性金字塔层(从P2到P6)上使用特定于尺度的anchor，类似[56]。在这里，P2被设计成通过平铺小anchor来捕捉微小的人脸，这样做的代价是花费更多的计算时间和更多的误报风险。我们将scale step设置为2^(1/3)，aspect ratio设置为1:1。输入图像大小为 640

640 , anchors可以 覆盖 从16x16 到 406x406的特征金字塔层。总共有102300个anchors，其中75%来自P2。





![img](https://upload-images.jianshu.io/upload_images/15621521-47df4fde206bef5c.png?imageMogr2/auto-orient/strip|imageView2/2/w/404/format/webp)

image.png

在训练过程中，当IoU大于0.5时，anchors匹配到ground-truth box，当IoU小于0.3时匹配到background。不匹配的anchor在训练中被忽略。由于大多数anchor(> 99%)在匹配步骤后为负，我们采用标准OHEM来缓解正、负训练样本之间的显著不平衡。更具体地说，我们根据损失值对负锚进行排序，并选择损失最大的anchors，这样负样本和正样本之间的比例至少为3:1。**数据增强：**由于WIDER FACE训练集中大约 有 20% 的小人脸 , 我们 遵循 [68, 49 ) 并从原始图像随机crop方形patches并调整这些 patches到 640*640 产生更大的训练人脸。更具体地说，在原始图像的短边[0.3,1]之间随机裁剪正方形patches。对于crop边界上的人脸，如果人脸框的中心在crop patches内，则保持人脸框的重叠部分。除了随机裁剪，我们还通过0.5概率的随机水平翻转和光度颜色蒸馏来增加训练数据[68]。**训练细节**：我们早四个 NVIDIA Tesla P40 (24GB) GPUs上使用 SGD 优化器 (momentum为0.9, 权重衰减为0.0005, batch size为8*4 )训练 RetinaFace 。学习速率从10e-3,在5个epoch后上升到10e-2，然后在第55和第68个epochs时除以10。训练过程在第80个epochs结束。**测试细节：**对于WIDER FACE的测试，我们遵循[36,68]的标准做法，采用flip以及多尺度(图像的短边在[500, 800, 1100, 1400, 1700])策略。使用IoU阈值为0.4，将Box voting[15]应用于预测的人脸boxes的并集。**4.3. Ablation Study**省略**4.4. Face box Accuracy**RetinaFace与其他24个stage-of-the-art的人脸检测算法对比。RetinaFace在所有的验证集和测试集都达到的最好的AP，在验证集上的AP是96.9%（easy），96.1%（Medium）和91.8%（hard）。在测试集的AP是96.3%,95.6%,91.4%.相比与当前最好的方法(Improved selective refinement network for face detection)在困难的数据集（包含大量的小人脸）的AP对比（91.4% vs 90.3%）



![img](https://upload-images.jianshu.io/upload_images/15621521-49df4548c2d91517.png?imageMogr2/auto-orient/strip|imageView2/2/w/1080/format/webp)

image.png



在图6中，我们展示了在一张密集人脸自拍的定性结果。RetinaFace在报告的1,151张面孔中成功找到约900张脸（阈值为0.5）。除了精确的边界框外，在姿势，遮挡和分辨率的变化下利用RetinaFace的预测五个人脸关键点也是非常强大。即使在遮挡严重的条件下出现密集面部定位失败的情况下，但在一些清晰而大的面部上的密集回归结果还是不错的，甚至对表情变化大也能检测出来。



![img](https://upload-images.jianshu.io/upload_images/15621521-a844bdaa9132f55e.png?imageMogr2/auto-orient/strip|imageView2/2/w/1080/format/webp)

image.png

**4.5. Five Facial Landmark Accuracy**

RetinaFace与MTCNN在五个人脸关键点定位上的定量比较。



![img](https://upload-images.jianshu.io/upload_images/15621521-f582e99d66aebc40.png?imageMogr2/auto-orient/strip|imageView2/2/w/853/format/webp)

image.png

**4.6. Dense Facial Landmark Accuracy**我们评估了AFLW2000-3D数据集上密集人脸关键点定位的准确性[75]，该数据集考虑（1）具有2D投影坐标的68个关键点和（2）具有3D坐标的所有关键点。



![img](https://upload-images.jianshu.io/upload_images/15621521-e42ea143aa3f1495.png?imageMogr2/auto-orient/strip|imageView2/2/w/735/format/webp)

image.png

**4.7. Face Recognition Accuracy**表4，我们对比了广泛使用的MTCNN和推荐的RetinaFace上人脸检测和对齐对深度人脸识别（即ArcFace）的影响。这表明了（1）人脸检测和对准会严重影响人脸识别性能，并且（2）对于人脸识别应用，RetinaFace比MTCNN具有更强的基准。



![img](https://upload-images.jianshu.io/upload_images/15621521-4ef9b56fc2ef3baa.png?imageMogr2/auto-orient/strip|imageView2/2/w/700/format/webp)

image.png

在图9中，我们在每个图例的末尾显示了IJB-C数据集上的ROC曲线以及FAR = 1e-6的TAR。我们采用两种技巧（即翻转测试和人脸检测得分来权衡模板中的样本），以逐步提高人脸识别的准确性。



![img](https://upload-images.jianshu.io/upload_images/15621521-5246124690138d1c.png?imageMogr2/auto-orient/strip|imageView2/2/w/515/format/webp)

image.png

**4.8. Inference Efficiency**

RetinaFace进行人脸定位，除了使用ResNet-152（262MB，AP 91.8% 在WIDER FACE hard set）的重模型外，还有MobileNet-0.25（1MB，AP78.25 在WIDER FACE hard set）的轻模型。



![img](https://upload-images.jianshu.io/upload_images/15621521-5d0586706b554263?imageMogr2/auto-orient/strip|imageView2/2/w/435/format/webp)

image

# 5、Conclusions

我们研究了具有挑战性的问题，即同时进行密集定位和图像中任意比例尺的人脸对齐，并据我们所知，我们是第一个single-stage解决方案（RetinaFace）。在当前最具挑战性的人脸检测基准测试中，我们的解决方案优于state of the art的方法。此外，将RetinaFace与state-of-the-art的实践相结合进行人脸识别后，显然可以提高准确性。数据和模型已公开提供，以促进对该主题的进一步研究。

END

参考文献：

[https://blog.csdn.net/weixin_40671425/article/details/97804981](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fweixin_40671425%2Farticle%2Fdetails%2F97804981)

论文地址：[https://arxiv.org/pdf/1905.00641.pdf](https://links.jianshu.com/go?to=https%3A%2F%2Farxiv.org%2Fpdf%2F1905.00641.pdf)

源码地址：（MXNet实现）[https://github.com/deepinsight/insightface/tree/master/RetinaFace](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fdeepinsight%2Finsightface%2Ftree%2Fmaster%2FRetinaFace)

Pytorch实现：[https://github.com/biubug6/Pytorch_Retinaface](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fbiubug6%2FPytorch_Retinaface)

caffe实现：[https://github.com/wzj5133329/retinaface_caffe](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fwzj5133329%2Fretinaface_caffe)

人脸识别中的评价指标：[https://blog.csdn.net/liuweiyuxiang/article/details/81259492](https://links.jianshu.com/go?to=https%3A%2F%2Fblog.csdn.net%2Fliuweiyuxiang%2Farticle%2Fdetails%2F81259492)

切比雪夫[https://zhuanlan.zhihu.com/p/49197590](https://links.jianshu.com/go?to=https%3A%2F%2Fzhuanlan.zhihu.com%2Fp%2F49197590)

