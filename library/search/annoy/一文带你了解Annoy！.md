# 一文带你了解Annoy！

[![一小撮人](https://pic3.zhimg.com/v2-618a39ec740c08cb1efcd69a9199d6d0_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/yi-xiao-cuo-ren)

[一小撮人](https://www.zhihu.com/people/yi-xiao-cuo-ren)

山中何事？松花酿酒，春水煎茶。



33 人赞同了该文章

Annoy(Approximate Nearest Neighbors Oh Yeah)是一个带有Python bindings的C ++库，用于搜索空间中给定查询点的近邻点。它还会创建大型的基于文件的[只读数据](https://www.zhihu.com/search?q=%E5%8F%AA%E8%AF%BB%E6%95%B0%E6%8D%AE&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A109633593%7D)结构，并将其映射到内存中，以便许多进程可以共享相同的数据。

## 安装

要安装，只需`pip install --user annoy`从[PyPI](https://link.zhihu.com/?target=https%3A//pypi.python.org/pypi/annoy)下拉最新版本。

对于C ++版本，只需克隆整个[repo](https://link.zhihu.com/?target=https%3A//github.com/spotify/annoy)以及使用`#include "annoylib.h"`。

## 背景

还有其他一些库可以进行最近邻搜索。Annoy是几乎最快的库（见下文），但实际上还有另一个功能使Annoy与众不同：它具有**使用静态文件作为索引的功能**，这意味着您可以**跨进程共享索引**。Annoy还使创建索引与加载索引“脱钩”，因此您可以将索引作为文件传递，并快速将它们映射到内存中。Annoy的另一个好处是，它试图最小化内存占用，因此索引很小。

这有用吗？如果要查找最近的邻居并且有很多CPU，则只需建立一次索引。您还可以传递和分发静态文件以用于生产环境，Hadoop作业等中。任何进程都将能够将索引加载到内存中，并且能够立即执行查找。

用在哪呢？如在[Spotify上](https://www.spotify.com/)使用它来推荐音乐。运行[矩阵分解算法](https://www.zhihu.com/search?q=%E7%9F%A9%E9%98%B5%E5%88%86%E8%A7%A3%E7%AE%97%E6%B3%95&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A109633593%7D)后，每个用户/项目都可以表示为f-维空间中的向量。该库可帮助我们搜索相似的用户/物品。当在[高维空间](https://www.zhihu.com/search?q=%E9%AB%98%E7%BB%B4%E7%A9%BA%E9%97%B4&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A109633593%7D)中有数百万条查找对象时，内存使用是首要考虑的问题。

> **相比于其他的最近邻搜索库，annoy的学习成本非常低，能较快的掌握，非常适合项目的快速开发，于此对比的是，faiss的学习成本较高，用起来较为复杂。**

**功能概要**

- 支持 [欧氏距离](https://link.zhihu.com/?target=https%3A//en.wikipedia.org/wiki/Euclidean_distance)，[曼哈顿距离](https://link.zhihu.com/?target=https%3A//en.wikipedia.org/wiki/Taxicab_geometry)，[余弦距离](https://link.zhihu.com/?target=https%3A//en.wikipedia.org/wiki/Cosine_similarity)，[汉明距离](https://www.zhihu.com/search?q=%E6%B1%89%E6%98%8E%E8%B7%9D%E7%A6%BB&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A109633593%7D)或点(内)乘积距离；
- 余弦距离等于向量归一化后的欧式距离，即 ![[公式]](https://www.zhihu.com/equation?tex=sqrt%282-2+%2A+cos%28u%2Cv%29%29) ；
- 如果向量维度不是太多，例如<100维，效果会比较好，但即使在维度多达1000维上，其效果也出乎意料；
- 小的内存使用；
- 让您在多个进程之间共享内存；
- 索引的创建与查找是分开的（特别是在创建树之后，您无法添加更多查找内容）；
- 支持Python，已通过2.7、3.6和3.7测试；
- 在磁盘上建立索引，以适用无法放入内存的大型数据集索引；

## Python代码示例

```python
from annoy import AnnoyIndex
import random

f = 40
t = AnnoyIndex(f, 'angular')  # Length of item vector that will be indexed
for i in range(1000):
    v = [random.gauss(0, 1) for z in range(f)]
    t.add_item(i, v)

t.build(10) # 10 trees
t.save('test.ann')

# ...

u = AnnoyIndex(f, 'angular')
u.load('test.ann') # super fast, will just mmap the file
print(u.get_nns_by_item(0, 1000)) # will find the 1000 nearest neighbors
```

目前annoy仅接受整数作为查找item的标识。请注意，它将为 ![[公式]](https://www.zhihu.com/equation?tex=max%28id%29%2B1) 个项目分配内存，因为它假定您的item编号为0…n-1。**如果您需要其他ID，则必须自己构建好映射关系。**

## 完整的Python API

- `AnnoyIndex(f, metric)`返回可读写的新索引，用于存储`f`维度向量。metric 可以是`"angular"`，`"euclidean"`，`"manhattan"`，`"hamming"`，或`"dot"`。
- `a.add_item(i, v)`用于给索引添加向量v，i（任何非负整数）是给向量v的表示。
- `a.build(n_trees)`用于构建 n_trees 的森林。查询时，树越多，精度越高。在调用`build`后，无法再添加任何向量。
- `a.save(fn, prefault=False)`将索引保存到磁盘。保存后，不能再添加任何向量。
- `a.load(fn, prefault=False)`从磁盘加载索引。如果prefault设置为True，它将把整个文件预读到内存中。默认值为False。
- `a.unload()` 释放索引。
- `a.get_nns_by_item(i, n, search_k=-1, include_distances=False)`返回第i 个item的`n`个最近邻的item。在查询期间，它将检索多达`search_k`（默认`n_trees * n`）个点。`search_k`为您提供了更好的准确性和速度之间权衡。如果设置`include_distances`为`True`，它将返回一个包含两个列表的2元素元组：第二个包含所有对应的距离。
- `a.get_nns_by_vector(v, n, search_k=-1, include_distances=False)`与上面的相同，但按向量v查询。
- `a.get_item_vector(i)`返回第`i`个向量前添加的向量。
- `a.get_distance(i, j)`返回向量`i`和向量`j`之间的距离。注意：此函数用于返回平方距离。
- `a.get_n_items()` 返回索引中的向量数。
- `a.get_n_trees()` 返回索引中的树的数量。
- `a.on_disk_build(fn)` 用以在指定文件而不是RAM中建立索引（在添加向量之前执行，在建立之后无需保存）。

Notes：

- Annoy使用归一化向量的欧式距离作为其角距离，对于两个向量u，v，其等于 `sqrt(2(1-cos(u,v)))`
- C ++ API非常相似：调用annoy只需使用`#include "annoylib.h"`。

## 权衡

调整Annoy仅需要两个主要参数：树的数量 n_trees 和搜索期间要检查的节点的数量`search_k`。

- `n_trees`在构建索引期间提供该值，并且会影响构建时间和索引大小。较大的值将给出更准确的结果，但索引较大。
- `search_k`是在运行时提供的，并且会影响搜索性能。较大的值将给出更准确的结果，但返回时间将更长。

如果`search_k`未提供，它将默认为`n * n_trees * D，n`是近似最近邻居的数目，并且`D`是一个常数，取决于[向量维度](https://www.zhihu.com/search?q=%E5%90%91%E9%87%8F%E7%BB%B4%E5%BA%A6&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A109633593%7D)。否则，`search_k`和`n_trees`是大致独立的，即如果search_k保持不变，`n_trees`不会影响搜索时间，反之亦然。基本上，在您可以负担的内存使用量的情况下建议在`n_trees`可能大的值，并且在给定查询时间的限制的情况下建议设置search_k尽可能大。

## 它是如何工作的

![img](https://pic4.zhimg.com/80/v2-c05afeeb7c293e68ec8e462f1c635fc3_720w.jpg)

使用[随机投影](https://link.zhihu.com/?target=http%3A//en.wikipedia.org/wiki/Locality-sensitive_hashing%23Random_projection)并构建一棵树。在树中的每个中间节点处，选择一个随机超平面，该平面将空间划分为两个子空间。通过从子集中采样两个点并选择与它们等距的[超平面](https://www.zhihu.com/search?q=%E8%B6%85%E5%B9%B3%E9%9D%A2&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A109633593%7D)来选择此超平面。

我们这样做k次，所以我们得到了一片森林。必须通过精度和性能之间的权衡来调整k。

汉明距离在后台将数据打包为[64位整数](https://www.zhihu.com/search?q=64%E4%BD%8D%E6%95%B4%E6%95%B0&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A109633593%7D)，并使用内置的位计数原语，因此速度可能非常快。所有拆分均与轴对齐。

点积距离使用[2014年出版的Microsoft Research的Bachrach等人的方法，](https://link.zhihu.com/?target=https%3A//www.microsoft.com/en-us/research/wp-content/uploads/2016/02/XboxInnerProduct.pdf)将提供的向量从点（或“内积”）空间减少到更便于查询的[余弦空间](https://www.zhihu.com/search?q=%E4%BD%99%E5%BC%A6%E7%A9%BA%E9%97%B4&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A109633593%7D)。

更多关于相似性检索的文章，关注 

[@一小撮人](https://www.zhihu.com/people/7c0ffe94fe840ca847ba2cfeea79f692)

 

！



发布于 2020-02-28 11:38

推荐系统

相似性比较

大数据处理

赞同 33

8 条评论

分享