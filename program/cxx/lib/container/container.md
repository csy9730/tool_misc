# container

``` cpp
container() // 构造函数
container() // 复制构造函数
~container() // 析构函数

size() //
max_size() //
operator=() //
operator<() //
operator>() //
operator==() //
operator!=() //
swap()

begin() // 指向第一个元素
end() // 调用迭代器，指向最后一个元素的后一个
rbegin() // 调用反向迭代器，指向最后一个元素
rend() // 调用反向迭代器，指向第一个元素的前一个

```
### hash
而无序容器中的元素是不进行排序的，内部通过 Hash 表实现，插入和搜索元素的平均复杂度为 O(constant)， 在不关心容器内部元素顺序时，能够获得显著的性能提升。

C++11 引入了两组无序容器：std::unordered_map/std::unordered_multimap 和 std::unordered_set/std::unordered_multiset。

