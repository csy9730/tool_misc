# Merge-find set

在 计算机科学 中， 并查集 （英文：Disjoint-set data structure，直译为不交集数据结构）是一种 数据结构 ，用于处理一些 不交集 （Disjoint sets，一系列没有重复元素的集合）的合并及查询问题。. 并查集支持如下操作：. 查询：查询某个元素属于哪个集合，通常是返回集合内的一个"代表元素"。. 这个操作是为了判断两个元素是否在同一个集合之中。. 合并：将两个集合合并为一个。. 添加 ：添加一个新集合，其中有一个新元素。. 添加操作不如查询和合并操作重要，常常被忽略。. 由于支持查询和合并这两种操作，并查集在英文中也被称为联合-查找数据结构（Union-find data structure）或者合并-查找集合（Merge-find set）



并查集在《[算法导论](https://www.zhihu.com/search?q=算法导论&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A746570915})》中被称为“不相交集合森林”。

没人能否认并查集实现简单（除非毒瘤出题人进行毒瘤扩展），因为其核心函数一行就可以实现。

```cpp
int findSet(int x) {
    return par[x] == x ? x : par[x] = findSet(par[x]);
}
```