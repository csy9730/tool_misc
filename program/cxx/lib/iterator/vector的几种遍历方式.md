# vector的几种遍历方式

- 数组索引访问
- 索引访问
- 迭代器指针
- for
- for_each

### c-style

```cpp
Vector<int> vec;
int* dat=vec.data;
size_t len = vec.size();
for (size_t i =0; i < len; i ++) {
    int d = dat[i];
}
```

### c-style 2

```cpp
for (size_t i =0; i < vec.size(); i ++) {
    int d = vec[i];
}
```

### iterator
```cpp
for (auto it = vec.begin(); it != vec.end(); it ++) {
	int d = *it;
}
```

2
```cpp
for (auto it = vec.rbegin(); it != vec.rend(); it ++) {
	int d = *it;
}
```


使用迭代器it循环，迭代器本身不是内部数据，它的各种操作（比较，偏移，取值操作）都是一系列内联函数操作，暗地里干的事远比看到的复杂。这个迭代器给自己套上伪装，让你可以像使用指针一样利用它去访问对象，但是毕竟中间隔了一层。个人觉得迭代器的实用主要是便于stl中算法的实现，有一种通用的数据类型来访问各种容器中的元素。

### for:

```cpp
for (auto i:vec) {
    auto d = i;

}
// for(auto const& value: a){}
```

这是C++11的新特性

### for_each

这个需要C++17才能够支持

使用了遍历函数和匿名函数
```cpp
std::for_each(vec.begin(), vec.end(), [](int i){
    int d = i;

});
```