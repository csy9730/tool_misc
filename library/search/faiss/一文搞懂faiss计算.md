# 一文搞懂faiss计算

[![沙漠之狐](https://pic1.zhimg.com/v2-39caf823a6025a5d232b573ef2589a84_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/sha-mo-zhi-hu-31)

[沙漠之狐](https://www.zhihu.com/people/sha-mo-zhi-hu-31)

寒江孤影，江湖故人， 相逢何必曾相识！



103 人赞同了该文章

```text
Faiss的全称是Facebook AI Similarity Search。
这是一个开源库，针对高维空间中的海量数据，提供了高效且可靠的检索方法。
暴力检索耗时巨大，对于一个要求实时人脸识别的应用来说是不可取的。
而Faiss则为这种场景提供了一套解决方案。
Faiss从两个方面改善了暴力搜索算法存在的问题：降低空间占用加快检索速度首先，
Faiss中提供了若干种方法实现数据压缩，包括PCA、Product-Quantization等。
```

（1）对于一个检索任务，我们的操作流程一定分为三步：训练、构建数据库、查询。因此下面将分别对这三个步骤详细介绍。

faiss的核心就是索引（index）概念，它封装了一组向量，并且可以选择是否进行预处理，帮忙高效的检索向量。faiss中由多种类型的索引，我们可以是呀最简单的索引类型：indexFlatL2，这就是暴力检索L2距离（[欧式距离](https://www.zhihu.com/search?q=%E6%AC%A7%E5%BC%8F%E8%B7%9D%E7%A6%BB&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A133210698%7D)）。不管建立什么类型的索引，我们都必须先知道向量的维度。另外，对于大部分索引类型而言，在建立的时候都包含了训练阶段，但是L2这个索引可以跳过。当索引被建立 和训练之后，我能就可以调用add，search着两种方法。

（2）精确搜索：faiss.indexFlatL2(欧式距离) faiss.indexFlatIP(内积)

在精确搜索的时候，选择上述两种索引类型，遍历计算[索引向量](https://www.zhihu.com/search?q=%E7%B4%A2%E5%BC%95%E5%90%91%E9%87%8F&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A133210698%7D)，不需要做训练操作。下面的例子中，给出了上面提到的两种索引实际应用。

```text
import sys
import faiss
import numpy as np 
d = 64  
nb = 100
nq = 10
np.random.seed(1234)
xb = np.random.random((nb,d)).astype('float32')
print xb[:2]
xb[:, 0] += np.arange(nb).astype('float32') / 1000
#sys.exit()
print xb[:2]
xq = np.random.random((nq, d)).astype('float32')
xq[:, 0] += np.arange(nq).astype('float32') / 1000
index = faiss.IndexFlatL2(d) # buid the index
print (index.is_trained),"@@"
index.add(xb)
print index.ntotal  # 加入了多少行数据

k = 4
D,I = index.search(xb[:5],k)
print "IIIIIIIIIIII" 
print I
print "ddddddddd"
print D

print "#########"
index = faiss.IndexFlatIP(d)
index.add(xb)
k = 4
D,I = index.search(xb[:5],k)
print I
print "ddddddddd"
print D
```

（3）如果存在的向量太多，通过暴力搜索索引indexFlatL2搜索时间会边长，这里介绍一种加速搜索的方法indexIVFFlat（[倒排文件](https://www.zhihu.com/search?q=%E5%80%92%E6%8E%92%E6%96%87%E4%BB%B6&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A133210698%7D)）。起始就是使用k-means建立聚类中心，然后通过查询最近的聚类中心，然后比较聚类中所有向量得到相似的向量。

创建IndexIVFFlat的时候需要指定一个其他的索引作为量化器（quantizer）来计算距离或者相似度。faiss提供了两种衡量相似度的方法：1）faiss.METRIC_L2、
2）faiss.METRIC_INNER_PRODUCT。一个是欧式距离，一个是[向量内积](https://www.zhihu.com/search?q=%E5%90%91%E9%87%8F%E5%86%85%E7%A7%AF&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A133210698%7D)。

还有其他几个参数：nlist：聚类中心的个数；k：查找最相似的k个向量；index.nprobe：查找聚类中心的个数，默认为1个。

```text
nlist = 50  #  聚类中心个数
k = 10      # 查找最相似的k个向量
quantizer = faiss.IndexFlatL2(d)  # 量化器
index = faiss.IndexIVFFlat(quantizer, d, nlist, faiss.METRIC_L2)
       # METRIC_L2计算L2距离, 或faiss.METRIC_INNER_PRODUCT计算内积
assert not index.is_trained   #倒排表索引类型需要训练
index.train(data)  # 训练数据集应该与数据库数据集同分布
assert index.is_trained
# index.nprobe :查找聚类中心的个数 默认为1 
#index.nprobe = 300 # default nprobe is 1, try a few more
index.add(data)
index.nprobe = 50  # 选择n个维诺空间进行索引,
dis, ind = index.search(query, k)

1.index.nprobe 越大，search time 越长，召回效果越好。
2.nlist=2500，不见得越大越好，需要与nprobe 配合，这两个参数同时大才有可能做到好效果。
3.不管哪种倒排的时间，在search 阶段都是比暴力求解快很多，0.9s与0.1s级别的差距。
以上的时间都没有包括train的时间。也暂时没有做内存使用的比较。

# -*- coding:utf-8 -*-
#coding:utf-8
import sys
import faiss
import numpy as np 
import os
import sys
reload(sys)
sys.setdefaultencoding('utf-8') 
d = 64  
nb = 100
nq = 10
np.random.seed(1234)
xb = np.random.random((nb,d)).astype('float32')
xb[:, 0] += np.arange(nb).astype('float32') / 1000
xq = np.random.random((nq, d)).astype('float32')
xq[:, 0] += np.arange(nq).astype('float32') / 1000

nlist = 50 # 聚类中心个数
k = 4   # 查询相似的k个向量
quantizer = faiss.IndexFlatL2(d)
index = faiss.IndexIVFFlat(quantizer,d,nlist,faiss.METRIC_L2)

print (index.is_trained),"@@"
index.train(xb)
index.add(xb)
index.nprobe = 3 # 搜索的聚类 个数
print index.ntotal  # 

D,I = index.search(xb[:5],k)
print "IIIIIIIIIIII" 
print I
print "ddddddddd"
print D
```

（4）上面我们在建立 IndexFlatL2 和IndexIVFFlat都会全量存储所有向量在内存中，为了满足大的数据需求，faiss提供了一种基于 Product Quantizer（乘积量化）的压缩算法，编码向量大小到指定的字节数。此时，存储的向量是压缩过的，查询的距离也是近似的。

**##注意这个时候 没有相似度 度量参数**

```text
### 乘积量化  
d = 64  
nb = 10000
nq = 10
np.random.seed(1234)
xb = np.random.random((nb,d)).astype('float32')
xb[:, 0] += np.arange(nb).astype('float32') / 1000
xq = np.random.random((nq, d)).astype('float32')
xq[:, 0] += np.arange(nq).astype('float32') / 1000

nlist = 50 # 聚类中心个数
k = 4   # 查询相似的k个向量
m = 8  # number of bytes per vector    每个向量都被编码为8个字节大小
quantizer = faiss.IndexFlatL2(d)
index = faiss.IndexIVFPQ(quantizer,d,nlist,m,8)   ##注意这个时候 没有相似度 度量参数

print (index.is_trained),"@@"
index.train(xb)
index.add(xb)
index.nprobe = 3 # 搜索的聚类 个数
print index.ntotal  # 

D,I = index.search(xq[:5],k)
print "IIIIIIIIIIII" 
print I
print "ddddddddd"
print D
```



\######什么是乘积量化 ########

（5）乘积量化

![img](https://pic4.zhimg.com/80/v2-80200e6dd064ce8fb4f5bedc2f34b61b_720w.jpg)

[图像检索 - 乘积量化PQ（Product Quantization）blog.csdn.net/guanyonglai/article/details/78468673![img](https://pic4.zhimg.com/v2-99c495668d226bec93b5b47c1f1ec74b_180x120.jpg)](https://link.zhihu.com/?target=https%3A//blog.csdn.net/guanyonglai/article/details/78468673)



（6）faiss 安装方法（python版本）

faiss 安装步骤： python 版本安装

[https://www.anaconda.com/distribution/#download-section](https://link.zhihu.com/?target=https%3A//www.anaconda.com/distribution/%23download-section)

（1） 下载最新版的 anaconda 之前遇到过 用老版本的 anconda 装不上 faiss 但是换成新版本的就可以了 最新版本的 已上传 网盘

（2） 安装 anaconda sh Anaconda2-2019.03-Linux-x86_64 .sh 参考 [https://blog.csdn.net/jobbofhe/article/details/79761526](https://link.zhihu.com/?target=https%3A//blog.csdn.net/jobbofhe/article/details/79761526)

有两点需要注意 一是 可以修改 安装路径

输入一个有权限的 路径 并追加一个文件夹 eg: anaconda2

二是，在最后 要把 [环境变量](https://www.zhihu.com/search?q=%E7%8E%AF%E5%A2%83%E5%8F%98%E9%87%8F&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A133210698%7D)加入

conda install faiss-cpu -c pytorch

编辑于 2020-04-18 19:30

人工智能

高维数据分析

机器学习

赞同 103

13 条评论

分享