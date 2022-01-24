# 二叉堆(Heap)与二叉查找树(Binary Search Tree)的区别



[Daniel.Qin](https://blog.csdn.net/YUBANGSHUANGYUER) ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/newCurrentTime.png) 于 2020-05-08 22:55:59 发布 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/articleReadEyes.png) 1031 ![img](https://csdnimg.cn/release/blogv2/dist/pc/img/tobarCollect.png) 收藏 4

分类专栏： [Data Structures and Algorithms](https://blog.csdn.net/yubangshuangyuer/category_9667244.html) 文章标签： [数据结构](https://so.csdn.net/so/search/s.do?q=数据结构&t=blog&o=vip&s=&l=&f=&viparticle=) [二叉树](https://so.csdn.net/so/search/s.do?q=二叉树&t=blog&o=vip&s=&l=&f=&viparticle=)

版权

[![img](https://img-blog.csdnimg.cn/20200114204443399.jpg?x-oss-process=image/resize,m_fixed,h_224,w_224)Data Structures and Algorithms](https://blog.csdn.net/yubangshuangyuer/category_9667244.html)专栏收录该内容

18 篇文章0 订阅

订阅专栏

### 问题描述

通常我们在学习二叉堆和二叉查找树时是很容易混淆的，虽说堆也是一种完全二叉树，但二者差别还是挺大的，本文试做分析。

### 逻辑结构

二叉堆和二叉查找树都是结点带权重，并在父子结点间满足某种规则的数据结构。

二叉堆是一种完全二叉树，分大根堆、小根堆两种，子结点总是大于或小于父结点。
大根堆，顾名思义，根是最大的，每个子结点都要小于父结点，不区分左右儿子谁大谁小，也不必保证某个“孙子结点”一定要小于另一个“儿子结点”。
小根堆恰恰相反，根是最小的，每个子结点都要大于父结点，不区分左右儿子谁大谁小，也不必保证某个“孙子结点”一定要大于另一个“儿子结点”。

二叉查找树是一种特殊的二叉树，左儿子结点小于父结点，右儿子结点大于父结点。所谓的AVL树、红黑树等复杂一些的树状数据结构，很多都是二叉查找树优化得到的。

### 存储结构

二叉堆和二叉查找树看似都是“树”，实则在存储结构上差别很大。

我们也知道，顺序存储和链接存储是两种基本的存储结构。顺序存储减少了指针等的额外空间浪费，没有结点这个问题，却在某个元素的增删后的调整上很麻烦，且必须在内存中连续分配；链接存储反是。

由于二叉堆是一种完全二叉树，所以可以按照 id 编号，通过数组存取，更好的是用顺序表（Java党参考java.util.ArrayList，C++党参考STL-vecter），根据 id 访问父结点或子结点，既节约了指针空间的结构性开销，也能通过交换不必每次都重新开辟空间。

而二叉树是链接存储的，就像单链表是指针连接起来的，二叉查找树自然也是链接存储。父结点有指向两个儿子结点的指针（我们一般不设置儿子结点有指向父结点的双向指针）。

### 时空性能

二叉堆每次调整都是O(logN)，只考虑一个儿子节点和父结点的交换与否。建堆O(N)，一旦堆建起来就很方便很灵活，用堆进行排序也只需要O(NlogN)，堆排序属于插入排序，在频繁增删元素的情况下，维护一个堆往往很划算。

二叉查找树没什么神奇的功能，无非是树结构的搜索。搜起来每次丢弃一半（另一个儿子结点），好似顺序存储结构的二分查找，都是二分的，也算是减治法。只不过有可能很不平衡形成斜树，造成线性的搜索复杂度，故而需要AVL树、红黑树这些更“平衡”的树，稍有额外调整的损耗，却保证了对数的搜索时间。

### 实用功能

二叉堆和二叉查找树功能更是完全不同。

堆的话一般用于堆排序、构建优先队列这样的情形；而二叉查找树主要就是搜索。

Java编程实现

- [二叉大根堆](https://blog.csdn.net/weixin_43896318/article/details/101726560)
- [二叉搜索树](https://blog.csdn.net/weixin_43896318/article/details/102472549)

Python编程实现

- [二叉小根堆](https://blog.csdn.net/weixin_43896318/article/details/103052671)
- [二叉查找树](https://blog.csdn.net/weixin_43896318/article/details/102537536)

本文转自：<https://blog.csdn.net/weixin_43896318/article/details/104369428> 如有侵权，请留言联系，本人定及时删除！谢谢！