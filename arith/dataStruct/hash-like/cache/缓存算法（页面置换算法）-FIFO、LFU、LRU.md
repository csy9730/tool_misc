# [缓存算法（页面置换算法）-FIFO、LFU、LRU](https://www.cnblogs.com/dolphin0520/p/3749259.html)

缓存算法（页面置换算法）-FIFO、LFU、LRU

　　在前一篇文章中通过leetcode的一道题目了解了LRU算法的具体设计思路，下面继续来探讨一下另外两种常见的Cache算法：FIFO、LFU

## 1.FIFO算法

　　FIFO（First in First out），先进先出。其实在操作系统的设计理念中很多地方都利用到了先进先出的思想，比如作业调度（先来先服务），为什么这个原则在很多地方都会用到呢？因为这个原则简单、且符合人们的惯性思维，具备公平性，并且实现起来简单，直接使用数据结构中的队列即可实现。

　　在FIFO Cache设计中，核心原则就是：如果一个数据最先进入缓存中，则应该最早淘汰掉。也就是说，当缓存满的时候，应当把最先进入缓存的数据给淘汰掉。在FIFO Cache中应该支持以下操作;

　　get(key)：如果Cache中存在该key，则返回对应的value值，否则，返回-1；

　　set(key,value)：如果Cache中存在该key，则重置value值；如果不存在该key，则将该key插入到到Cache中，若Cache已满，则淘汰最早进入Cache的数据。

　　举个例子：假如Cache大小为3，访问数据序列为set(1,1),set(2,2),set(3,3),set(4,4),get(2),set(5,5)

　　则Cache中的数据变化为：

　　(1,1)                               set(1,1)

　　(1,1) (2,2)                       set(2,2)

　　(1,1) (2,2) (3,3)               set(3,3)

　　(2,2) (3,3) (4,4)               set(4,4)

　　(2,2) (3,3) (4,4)               get(2)

　　(3,3) (4,4) (5,5)               set(5,5)

 　　那么利用什么数据结构来实现呢？

　　下面提供一种实现思路：

　　利用一个双向链表保存数据，当来了新的数据之后便添加到链表末尾，如果Cache存满数据，则把链表头部数据删除，然后把新的数据添加到链表末尾。在访问数据的时候，如果在Cache中存在该数据的话，则返回对应的value值；否则返回-1。如果想提高访问效率，可以利用hashmap来保存每个key在链表中对应的位置。

## 2.LFU算法

　　LFU（Least Frequently Used）最近最少使用算法。它是基于“如果一个数据在最近一段时间内使用次数很少，那么在将来一段时间内被使用的可能性也很小”的思路。

　　注意LFU和LRU算法的不同之处，LRU的淘汰规则是基于访问时间，而LFU是基于访问次数的。举个简单的例子：

　　假设缓存大小为3，数据访问序列为set(2,2),set(1,1),get(2),get(1),get(2),set(3,3),set(4,4)，

　　则在set(4,4)时对于LFU算法应该淘汰(3,3)，而LRU应该淘汰(1,1)。

　　那么LFU Cache应该支持的操作为：

　　get(key)：如果Cache中存在该key，则返回对应的value值，否则，返回-1；

　　set(key,value)：如果Cache中存在该key，则重置value值；如果不存在该key，则将该key插入到到Cache中，若Cache已满，则淘汰最少访问的数据。

　　为了能够淘汰最少使用的数据，因此LFU算法最简单的一种设计思路就是 利用一个数组存储 数据项，用hashmap存储每个数据项在数组中对应的位置，然后为每个数据项设计一个访问频次，当数据项被命中时，访问频次自增，在淘汰的时候淘汰访问频次最少的数据。这样一来的话，在插入数据和访问数据的时候都能达到O(1)的时间复杂度，在淘汰数据的时候，通过选择算法得到应该淘汰的数据项在数组中的索引，并将该索引位置的内容替换为新来的数据内容即可，这样的话，淘汰数据的操作时间复杂度为O(n)。

　　另外还有一种实现思路就是利用 小顶堆+hashmap，小顶堆插入、删除操作都能达到O(logn)时间复杂度，因此效率相比第一种实现方法更加高效。

　　如果哪位朋友有更高效的实现方式（比如O(1)时间复杂度），不妨探讨一下，不胜感激。

## 3.LRU算法

　　LRU算法的原理以及实现在前一篇博文中已经谈到，在此不进行赘述：

　　<http://www.cnblogs.com/dolphin0520/p/3741519.html>

　　参考链接：<http://blog.csdn.net/hexinuaa/article/details/6630384>

　　　　　　   <http://blog.csdn.net/beiyetengqing/article/details/7855933>

　　　　　　　<http://outofmemory.cn/wr/?u=http%3A%2F%2Fblog.csdn.net%2Fyunhua_lee%2Farticle%2Fdetails%2F7648549>

　　　　　　　<http://blog.csdn.net/alexander_xfl/article/details/12993565>

作者：[Matrix海子](http://www.cnblogs.com/dolphin0520/)

出处：<http://www.cnblogs.com/dolphin0520/>

本博客中未标明转载的文章归作者[Matrix海子](http://www.cnblogs.com/dolphin0520/)和博客园共有，欢迎转载，但未经作者同意必须保留此段声明，且在文章页面明显位置给出原文连接，否则保留追究法律责任的权利。



分类: [算法与数据结构](https://www.cnblogs.com/dolphin0520/category/291774.html)