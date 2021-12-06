# DBSCAN 算法

![img](https://cdn3.jianshu.io/assets/default_avatar/4-3397163ecdb3855a0a4139c34a695885.jpg)

[dreampai](https://www.jianshu.com/u/d5c91ac3f4d3)关注

0.3742019.01.15 17:03:20字数 974阅读 24,237

## 1、DBSCAN 算法由来

基于距离的聚类算法的聚类结果是球状的簇，当数据集中的聚类结果是非球状结构时，基于距离的聚类算法的聚类效果并不好。



![img](https://upload-images.jianshu.io/upload_images/13140540-4a69e82e2ab74e0d.png?imageMogr2/auto-orient/strip|imageView2/2/w/628/format/webp)

image

与基于距离的聚类算法不同的是，**基于密度的聚类算法可以发现任意形状的聚类。**在基于密度的聚类算法中，**通过在数据集中寻找被低密度区域分离的高密度区域，将分离出的高密度区域作为一个独立的类别。**

## 2、DBSCAN 算法原理

DBSCAN（Density-Based Spatial Clustering of Applications with Noise，具有噪声的基于密度的聚类方法）是一种基于密度的空间聚类算法。该算法将具有足够密度的区域划分为簇，并在具有噪声的空间数据库中发现任意形状的簇，它将簇定义为密度相连的点的最大集合。



![img](https://upload-images.jianshu.io/upload_images/13140540-0d7878e0e40cc86a.png?imageMogr2/auto-orient/strip|imageView2/2/w/734/format/webp)

数据点的分类.png



![img](https://upload-images.jianshu.io/upload_images/13140540-b5d30714dfab0992.png?imageMogr2/auto-orient/strip|imageView2/2/w/772/format/webp)

密度相关定义.png



![img](https://upload-images.jianshu.io/upload_images/13140540-08762e185a4bac4f.png?imageMogr2/auto-orient/strip|imageView2/2/w/620/format/webp)

图示.png

## 3、算法步骤

- 首选任意选取一个点，然后找到到这个点距离小于等于 eps 的所有的点。如果距起始点的距离在 eps 之内的数据点个数小于 min_samples，那么这个点被标记为**噪声。**如果距离在 eps 之内的数据点个数大于 min_samples，则这个点被标记为**核心样本**，并被分配一个新的簇标签。
- 然后访问该点的所有邻居（在距离 eps 以内）。如果它们还没有被分配一个簇，那么就将刚刚创建的新的簇标签分配给它们。如果它们是核心样本，那么就依次访问其邻居，以此类推。簇逐渐增大，直到在簇的 eps 距离内没有更多的核心样本为止。
- 选取另一个尚未被访问过的点，并重复相同的过程。



![img](https://upload-images.jianshu.io/upload_images/13140540-368039dfc3b69b4a.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

在这幅图里，minPts = 4，点 A 和其他红色点是核心点，因为它们的 ε-邻域（图中红色圆圈）里包含最少 4 个点（包括自己），由于它们之间相互相可达，它们形成了一个聚类。点 B 和点 C 不是核心点，但它们可由 A 经其他核心点可达，所以也属于同一个聚类。点 N 是局外点，它既不是核心点，又不由其他点可达.png

## 4、DBSCAN 的参数选择

- eps 设置得非常小，则意味着没有点是核心样本，可能会导致所有点被标记为噪声
- eps 设置得非常大，可能会导致所有点形成单个簇。
- 虽然不需要显示设置簇的个数，但设置 eps 可以隐式地控制找到 eps 的个数。
- 使用 StandarScaler 或 MinMaxScaler 对数据进行缩放，有时更容易找到 eps 的较好取值。因为使用缩放技术将确保所有特征具有相似的范围。



![img](https://upload-images.jianshu.io/upload_images/13140540-5ae4ac1b78fb6ba6.png?imageMogr2/auto-orient/strip|imageView2/2/w/863/format/webp)

属于簇的点是实心，噪声点则显示为空心，核心样本点显示为较大的标记，而边界点则显示为较小的标记.png

```python
from sklearn.cluster import DBSCAN
from sklearn.datasets import make_blobs
import matplotlib.pyplot as plt
import mglearn

X,y=make_blobs(random_state=0,n_samples=12)
dbscan=DBSCAN()
clusters=dbscan.fit_predict(X)
# 都被标记为噪声
print('Cluster memberships:\n{}'.format(clusters))
mglearn.plots.plot_dbscan()

plt.show()
```

## 5、Scikit-learn中的DBSCAN的使用

```ruby
def __init__(self, eps=0.5, min_samples=5, metric='euclidean',
                 metric_params=None, algorithm='auto', leaf_size=30, p=None,
                 n_jobs=1):
```

**核心参数：**

- eps: float，ϵ-邻域的距离阈值
- min_samples ：int，样本点要成为核心对象所需要的 ϵ-邻域的样本数阈值

**属性：**

- core_sample_indices_ : 核心点的索引，因为labels_不能区分核心点还是边界点，所以需要用这个索引确定核心点
- components_：训练样本的核心点
- labels_：每个点所属集群的标签，-1代表噪声点

## 6、优点和缺点

**优点**

- 不需要用户先验地设置簇的个数，可以划分具有复杂形状的簇，还可以找出不属于任何簇的点。
- 可以对任意形状的稠密数据集进行聚类，相对的，K-Means之类的聚类算法一般只适用于凸数据集。
- 可以在聚类的同时发现异常点，对数据集中的异常点不敏感。
- DBSCAN 比凝聚聚类和 k 均值稍慢，但仍可以扩展到相对较大的数据集。

**缺点**

- 需要设置 eps

# 参考链接

**本文作为笔记记录，如果侵权，联系我删除**

- <https://zh.wikipedia.org/wiki/DBSCAN>
- <https://www.biaodianfu.com/dbscan.html>
- <https://www.imooc.com/article/257210>