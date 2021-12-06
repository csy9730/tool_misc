# 关于ANN的一点思考

[![Chao.G](https://pica.zhimg.com/v2-7a6bdfcbb4f43ece759af3ef3fefb9b7_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/chao-g-77)

[Chao.G](https://www.zhihu.com/people/chao-g-77)

分布式/数据库



3 人赞同了该文章

这里的 ANN，是 Approximate Nearest Neighbor 的意思，从数据中找到和查询数据最接近的结果，实际上这个问题往往都被扩展成 Approximate K Nearest Neighbors 问题，在之后的介绍里 ANN 指代都是这一种更为一般的情况。

在过去的一年左右时间里，我都在做 ANN 上的一些研究，算是经历了一个小白入门科研的完整阶段，也算有了一点体会。本文中的 ANN 查询都是针对[高维向量](https://www.zhihu.com/search?q=%E9%AB%98%E7%BB%B4%E5%90%91%E9%87%8F&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A358559330%7D)进行的，所以有时也常常被称为[向量检索](https://www.zhihu.com/search?q=%E5%90%91%E9%87%8F%E6%A3%80%E7%B4%A2&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A358559330%7D)。这里不对算法进行很具体的分析，希望从一个较为宏观的角度来看待这个问题。

## 背景

ANN [查询问题](https://www.zhihu.com/search?q=%E6%9F%A5%E8%AF%A2%E9%97%AE%E9%A2%98&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A358559330%7D)是一个十分基础的问题，有着很丰富的应用，比如在图片数据库中找到跟我的照片最相似的照片，每个图片通过特征提取模型以后就是一个个的高维向量（一般在 100 维到 1000 维之间），相似照片的检索其实质就是 ANN 查询。使用数学语言表达如下：

令 ![[公式]](https://www.zhihu.com/equation?tex=%5Cmathcal%7BD%7D%3D%5C%7Bx_1%2C+x_2%2C+%5Ccdots%2C+x_n%5C%7D) 为数据集， ![[公式]](https://www.zhihu.com/equation?tex=x_i+%5Cin+R%5Ed%2C+dist%28x_i%2C+x_j%29)为[距离函数](https://www.zhihu.com/search?q=%E8%B7%9D%E7%A6%BB%E5%87%BD%E6%95%B0&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A358559330%7D) (一般为欧式距离)，距离越小，则代表相似度越高。给定查询向量 ![[公式]](https://www.zhihu.com/equation?tex=q) , k 近邻 ![[公式]](https://www.zhihu.com/equation?tex=TopK_q)都满足， ![[公式]](https://www.zhihu.com/equation?tex=%5Cforall+v+%5Cin+TopK_q%2C+%5Cforall+x+%5Cin+%5Cmathcal%7BD%7D+%5Csetminus+TopK_q%2C+dist%28v%2C+q%29+%5Cleq+dist%28x%2C+q%29) .

而实际返回的结果可能有误差，令返回结果为 ![[公式]](https://www.zhihu.com/equation?tex=TopK_q%27)，使用 ![[公式]](https://www.zhihu.com/equation?tex=Recall)来衡量准确度，即 ![[公式]](https://www.zhihu.com/equation?tex=Recall+%3D+%5Cfrac%7B%7C+TopK%27_q+%5Ccap+TopK_q+%7C%7D%7Bk%7D)∣.

所以实际上衡量一个算法性能的时候，我们是通过参数改变查询的范围，使用 曲线来直观地展示不同 ![[公式]](https://www.zhihu.com/equation?tex=+Recall)下的查询性能。

## 索引

ANN 是一个古老的问题，经过了几十年的发展，主要有树，哈希，[量化编码](https://www.zhihu.com/search?q=%E9%87%8F%E5%8C%96%E7%BC%96%E7%A0%81&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A358559330%7D)，图这几类具有代表性的索引算法。这里要非常感谢[袁勇](https://link.zhihu.com/?target=https%3A//yongyuan.name/)同学，详细归纳了 ANN 的发展，同时还维护了信息检索的一些最新论文。在我入门这个领域的时候，这几乎是我看过的中文博客里面最为用心，理解也非常深刻的高质量文章了，强烈推荐刚入门的小伙伴去阅读他的文章。

对于 ANN 来说，我们希望查询使候选集合较小，过滤掉大部分向量，另外在计算向量距离时希望可以对向量进行降维，编码等操作使得距离计算的时间（对两个几百维的向量进行[欧式距离](https://www.zhihu.com/search?q=%E6%AC%A7%E5%BC%8F%E8%B7%9D%E7%A6%BB&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A358559330%7D)计算是一波很大的开销）可以大幅降低，并减轻存储压力。这两者也常常会结合起来。

首先看第一点，如何过滤掉无用的向量。回忆我们在学习[二叉树](https://www.zhihu.com/search?q=%E4%BA%8C%E5%8F%89%E6%A0%91&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A358559330%7D)时候的情景，我们通过比较和根节点的大小关系，来确定我们接下来要搜索左子树还是右子树不断深入，因为我们要的是近邻，所以有可能会回溯。所以基于树的索引基本沿用了这样一个思路，关键在于如何将数据分裂，可以选择方差最大的维度来分，这是 KD-Tree 的思路，也可以使用 Kmeans，这是 Kmeans-Tree，也可以使用哈希来分桶。

再看第二点，我们如何加快向量距离计算呢？我们可以来看量化编码的思路，尤其是**乘积量化**，我们可以将距离计算转化为查表操作。将向量等分成若干段，每一段使用[聚类算法](https://www.zhihu.com/search?q=%E8%81%9A%E7%B1%BB%E7%AE%97%E6%B3%95&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A358559330%7D)分成若干聚类中心，那么所有向量都可以视作是这一些聚类中心的组合。所以我们现在只需要存储少量的聚类中心，并且可以预计算好聚类中心之间的距离。

最后单独来说一说图索引，2016 年的论文 HNSW 已经成为了现在使用相当广泛的索引算法，在数据可以全部放进内存的前提下，图索引几乎都是最快的选择。但事实上，每个刚入门的同学都会有些疑惑，平时提到索引几乎都是树型索引，图这个结构是如何作为索引来使用呢？在我看来，图具备很好的连通性，不像树结构，只有一个方向，否则就要进行回溯，而图的话通路就四通八达。一般我们在一维条件下很容易对数据按照某个数值分成大小两堆，这是一种很完美的分割。**而在高维的相似度查询场景下，事实上你很难完美对数据分割，做到一个通路无须回溯的**，而图就可以绕过这个限制，达到树索引几倍甚至几十倍的性能。

[ANN-Benchmarks](https://link.zhihu.com/?target=http%3A//ann-benchmarks.com/) 里面列举了不同算法的单机查询性能，有兴趣的读者可以参考。

## [机器学习](https://www.zhihu.com/search?q=%E6%9C%BA%E5%99%A8%E5%AD%A6%E4%B9%A0&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A358559330%7D)

使用机器学习的方法代替传统的[查询算法](https://www.zhihu.com/search?q=%E6%9F%A5%E8%AF%A2%E7%AE%97%E6%B3%95&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A358559330%7D)或者是[数据结构](https://www.zhihu.com/search?q=%E6%95%B0%E6%8D%AE%E7%BB%93%E6%9E%84&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A358559330%7D)，已经成为了很重要的研究话题。当然这在实际生产环境中能否使用就是另一个问题了，大都会有这样一些问题：无法实时更新，训练时间长等。但无法否认的是，AI 确实是未来。

反映到 ANN 这个问题上，怎么把机器学习的思路用到这上面，有很多思路。一个直接的思路是将查询向量作为输入，它的近邻作为输出，然后拿一些向量用来训练，对实际的查询再做模型推导。还有的方法是构建图索引的时候构建 cost model 来选择边，在查询的时候使用模型选择最佳路径等。

其实我对机器学习是比较不感冒的，有些模型的建立我觉得需要很强的 AI 背景，而且获得的收益很小，overhead（模型大小，模型训练时间）倒是很大。但是有一篇论文让我有了一个新的认识，是 SIGMOD2020 的一篇文章，[Improving Approximate Nearest Neighbor Search through Learned Adaptive Early Termination](https://link.zhihu.com/?target=https%3A//dl.acm.org/doi/pdf/10.1145/3318464.3380600)，这篇文章其实讲了一个很简单的故事，作者发现索引上查询的时候，不同查询向量所需的 “step” 是不同的，对于那些 “简单” 的查询向量，短短几步就可以结束查询，对于某些 “困难” 的查询向量，则需要在索引上查询很多的步数才能找到真正的近邻。那么机器学习就可以来学习每个向量所需要的步数。这其实就转化为了一个非常基础的机器学习问题，这种简单性为我们真正使用机器学习方法其实降低了不少门槛。

这篇文章也直接影响了我们做的 ANN 研究，从茫然中逐渐提炼出了属于我们的一些想法，在我看来，我们的思路也是非常简单，且具有美感的。等着 paper 中了再好好来讲讲我们的工作，希望不要等太久。。

## 系统

支持 ANN 查询在大数据时代逐渐演变为一个系统所需要支持的需求（也可能是伪需求？）。这一部分阿里巴巴做的很不错，也可能是阿里本身打广告的能力非常之强（误），阿里云数据库团队和蚂蚁的团队分别在自研数据库 AnalyticDB 和开源数据库 Postgres 上集成了向量索引，系统名字分别是 ADBV 和 PASE，也分别在 VLDB2020 和 SIGMOD2020 的 Industrial Track 上都发表了论文。有家明星创业公司 Zilliz 开源了他们的向量检索产品 Milvus，当然在我看来这个业务是否太过单一了，但确实人家拿到了相当多的融资，吹水能力也是相当不俗，当然这作为一家初出茅庐的公司是非常重要的。很偶然的机会也接触过这家公司的 HR，差点就加入了，不过我应该还会持续关注这家公司的。

对于系统来说，算法的创新不是重点，重点是生产上的落地。如何做好数据的增删改查，如何管理实时数据和历史数据，如何将索引改造成适合数据库的内存管理等。上述几个系统也都提到了 ANN 查询和普通[结构化查询](https://www.zhihu.com/search?q=%E7%BB%93%E6%9E%84%E5%8C%96%E6%9F%A5%E8%AF%A2&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A358559330%7D)相结合的融合查询，ADBV 较为系统地讨论了[融合查询](https://www.zhihu.com/search?q=%E8%9E%8D%E5%90%88%E6%9F%A5%E8%AF%A2&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra=%7B%22sourceType%22%3A%22article%22%2C%22sourceId%22%3A358559330%7D)的优化思路，把它做到了数据库的优化器里面。

## 总结

像 ANN 这样的 “古老” 话题，在初期一定是要看很多的论文来加深理解，而且不同的方法又非常多，在调研上就已经需要花上非常长的时间，需要比较归纳算法的特点，并需要一些实验结果的佐证。当然想在上面做出点东西确实是很难很难的。这时候尝试用机器学习或者系统层面来看待问题，也许会有新的发现。

发布于 2021-03-21 23:06

数据库与信息检索

赞同 3

1 条评论

分享