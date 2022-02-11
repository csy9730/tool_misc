# iterator

迭代器(iterator)

迭代器类似于指针，w提供对对象的间接访问。

迭代器范围由一对迭代器表示。迭代器的end标识指向容器最后一个容器之后的元素。故迭代器的范围是一个左闭合区间（左闭合右开放区间）。
正序和倒序的迭代器不一样。
``` cpp
auto it1 = a.begin(); // 标准迭代器
auto it2 = a.rbegin(); // 反向迭代器
auto it3 = a.cbegin(); // 常量迭代器
auto it4 = a.crbegin(); // 反向常迭代器

lst.cbegin(); // 意思就是不能通过这个指针来修改所指的内容，但还是可以通过其他方式修改的，而且指针也是可以移动的。
lst.cend(); // 指向常量的末尾迭代器指针：
```

### 迭代器类别
- input Iterator 输入,从容器读取元素
- output Iterator 输出，从容器中写入元素
- forward Iterator 正向，支持读取和写入功能，保留容器位置作为状态信息
- bidirectional Iterator 双向
- random access Iterator 随机访问


- 支持迭代器
  - list 双向迭代器
  - vector 随机访问
  - deque 随机访问
- 支持迭代器
  - set 双向迭代器
  - map 双向迭代器
- 不支持迭代器：
  - stack
  - queue
  - priority_queue


预先提供的默认迭代器

- iterator
- const_iterator
- reverse_iterator
- const_reverset_iterator

## 支持运算

``` cpp
++p;
p++ ;

// 双向迭代器
p--;
--p;

// 随机访问迭代器
p+i;
p-i;
p+=i;
p-=i;
p[i];
p>p1;
p<p1;



```