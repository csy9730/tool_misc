互联网

计算机科学

图像检索

神经网络

卷积神经网络（CNN）

# 现在有哪些优秀的图像检索的近似最近邻方法？互联网公司落地使用的ANN算法有哪些？相关会议有哪些推荐？



作者：付聪Ben

链接：https://www.zhihu.com/question/280496610/answer/429491463

来源：知乎

著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

更新，久等了，干货来了。

[Dr.Frankenstein：Search Engine For AI：高维数据检索工业级解决方案zhuanlan.zhihu.com/p/50143204?utm_source=wechat_timeline&utm_medium=social&utm_oi=768464210475622400&from=timeline&isappinstalled=0![img](https://pic1.zhimg.com/v2-de9ad6cd36e291124ce90c73cea92fcc_180x120.jpg)](https://zhuanlan.zhihu.com/p/50143204?utm_source=wechat_timeline&utm_medium=social&utm_oi=768464210475622400&from=timeline&isappinstalled=0)

推广一下我的论文

[[1707.00143\] Fast Approximate Nearest Neighbor Search With The Navigating Spreading-out GraphFast%20Approximate%20Nearest%20Neighbor%20Search%20With%20The%20Navigating%20Spreading-out%20Graph%20%20](https://link.zhihu.com/?target=http%3A//Fast%2520Approximate%2520Nearest%2520Neighbor%2520Search%2520With%2520The%2520Navigating%2520Spreading-out%2520Graph%2520%2520)

NSG算法，目前我看到的算法里，我们的性能是最优的。目前被集成到阿里淘宝主搜索引擎中，支持图像、推荐、多媒体等向量数据的大规模检索，在千万、上亿级别高维向量上10ms内返回结果，精度98%以上。



搜索最近k个近邻的，时间复杂度接近于log N，文章中做了证明。



相同精度下，速度上比局部敏感哈希（LSH）、KD-tree这一类快几百倍，比积量化方法（IVF-PQ）快数十倍。



有空我会写一个专栏再仔细讲解这个算法。

[编辑于 2018-11-17 12:30](http://www.zhihu.com/question/280496610/answer/429491463)

赞同 10826 条



作者：论智

链接：https://www.zhihu.com/question/280496610/answer/440556256

来源：知乎

著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

近似最近邻方法，也就是**approximate nearest neighbor（ANN）。**ANN算法很多，当前最优的ANN算法基本上都是基于图（graph）的算法。

Annoy（Spotify开源的ANN库）的作者[Erik Bernhardsson](https://link.zhihu.com/?target=https%3A//erikbern.com/)做了一个[ANN-benchmarks](https://link.zhihu.com/?target=https%3A//github.com/erikbern/ann-benchmarks)。下面是最近（2018年6月）ANN-benchmarks在Fashion-MNIST（服饰图像数据集）上的评测结果：

![img](https://pica.zhimg.com/50/v2-97d6a370e0ae3faf103f93594388936e_720w.jpg?source=1940ef5c)![img](https://pica.zhimg.com/80/v2-97d6a370e0ae3faf103f93594388936e_720w.jpg?source=1940ef5c)图片来源：ANN-benchmarks

简单说明一下上图中涉及的[ANN算法](https://www.zhihu.com/search?q=ANN%E7%AE%97%E6%B3%95&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A440556256%7D)：

- [Annoy](https://link.zhihu.com/?target=https%3A//github.com/spotify/annoy) Spotify出品的C++库，提供Python绑定。
- [NMSLIB (Non-Metric Space Library)](https://link.zhihu.com/?target=https%3A//github.com/nmslib/nmslib) C++库，提供Python绑定，并且支持通过Java或其他任何支持Apache Thrift协议的语言查询。提供了BallTree、bruteforce-blas、HNSW、SWGraph等实现。
- [hnswlib（NMSLIB项目的一部分）](https://link.zhihu.com/?target=https%3A//github.com/nmslib/hnsw) 与NMSLIB相比，hnswlib内存占用更少。
- [FLANN](https://link.zhihu.com/?target=http%3A//www.cs.ubc.ca/research/flann/) [加拿大英属哥伦比亚大学](https://www.zhihu.com/search?q=%E5%8A%A0%E6%8B%BF%E5%A4%A7%E8%8B%B1%E5%B1%9E%E5%93%A5%E4%BC%A6%E6%AF%94%E4%BA%9A%E5%A4%A7%E5%AD%A6&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22answer%22%2C%22sourceId%22%3A440556256%7D)出品的C++库，提供C、MATLAB、Python、Ruby绑定。
- [FAISS](https://link.zhihu.com/?target=https%3A//github.com/facebookresearch/faiss.git) Facebook出品的C++库，提供可选的GPU支持（基于CUDA）和Python绑定。同样提供了HNSW实现。
- KDTree实现（上图中的kd），由[scikit-learn](https://link.zhihu.com/?target=http%3A//scikit-learn.org/stable/modules/neighbors.html)提供。
- [KGraph](https://link.zhihu.com/?target=https%3A//github.com/aaalgo/kgraph) C++库，提供Python绑定。基于图（graph）算法。
- [MRPT](https://link.zhihu.com/?target=https%3A//github.com/teemupitkanen/mrpt) C++ 11库，基于随机投影树（random projection trees）。
- [NGT](https://link.zhihu.com/?target=https%3A//github.com/yahoojapan/NGT) Yahoo Japan出品的C++库，提供Python和Go绑定，提供了PANNG实现。
- [PyNNDescent](https://link.zhihu.com/?target=https%3A//github.com/lmcinnes/pynndescent) 纯Python实现。基于k-近邻图构造（k-neighbor-graph construction）。

上图中，纵轴为每秒操作数，横轴为召回，所以曲线越靠上、越靠右，就说明算法的表现越好。我们看到，最好的算法是HNSW，这是一个基于图的算法。除了HNSW以外，其他位于前列的算法，基本上也都是基于图的。

另外，最近阿里和浙大的研究人员新提出的[NSG算法](https://link.zhihu.com/?target=https%3A//arxiv.org/abs/1707.00143)，同样是一个基于图的算法，表现更好：

![img](https://pic1.zhimg.com/50/v2-dc258f4a66b23ff953066f4b55347640_720w.jpg?source=1940ef5c)![img](https://pic1.zhimg.com/80/v2-dc258f4a66b23ff953066f4b55347640_720w.jpg?source=1940ef5c)图片来源：NSG论文

据作者 

[@Dr.Frankenstein](http://www.zhihu.com/people/8130588d0b3fde25618fd0fd71e45730)

 介绍，该算法已经被集成到淘宝主搜索引擎中，具体可以参考他本人的回答。



[编辑于 2018-07-12 14:42](http://www.zhihu.com/question/280496610/answer/440556256)



ANN算法很多，但目前为止，没有一个召回高、内存占用又小的算法，或者说这样的算法也许压根不存在。实际在应用的时候，一定是召回与计算资源的折中。

个人觉得，基于矢量量化的PQ算法，是一个非常优秀且经过工业界检验过很有效的算法：基于图ANN算法，比如HNSW算法，召回很高，缺点是内存占用较大，实际在应用的时候，需要根据具体的场景来选用和优化，没有万金油。

参考：

[图像检索：OPQ索引与HNSW索引yongyuan.name/blog/opq-and-hnsw.html![img](https://pic2.zhimg.com/v2-6feb7a7a53575240c275e39bc466915d_180x120.jpg)](https://link.zhihu.com/?target=http%3A//yongyuan.name/blog/opq-and-hnsw.html)



[图像检索：Spreading Vectors for Similarity Searchyongyuan.name/blog/spreading-vector.html![img](https://pic4.zhimg.com/v2-9b883a40ba0172be0305e6c5337f2daf_180x120.jpg)](https://link.zhihu.com/?target=http%3A//yongyuan.name/blog/spreading-vector.html)



[图像检索：再叙ANN Searchyongyuan.name/blog/ann-search.html![img](https://pic1.zhimg.com/v2-946d541d983c3c10fe5e68406b5c1b28_180x120.jpg)](https://link.zhihu.com/?target=http%3A//yongyuan.name/blog/ann-search.html)



[发布于 2019-07-10 19:16](http://www.zhihu.com/question/280496610/answer/744184271)

作者：小白菜

链接：https://www.zhihu.com/question/280496610/answer/744184271

来源：知乎

著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。