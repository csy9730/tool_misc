# vector

vector 的底层实现是array，通过重新分配内存，复制，清理内存的方法实现扩容。

由于存在扩容机制，导致指针的可能失效。

为了支持快速的随机访问，vector将元素连续存储。

当添加新的元素时，容器必须分配新的内存空间来存储改变后的元素。将已有的元素从旧位置移动到新空间中，然后添加新元素。释放原有的存储空间。这样的操作性能较差，难以应对连续的不断增长。

故为了避免这个问题，采用了可以减少容器重新分配空间的策略。在分配新的空间时，容器会申请比需求更大的内存空间，作为备用。这种操作效率很高，vector的增长速度可以超过list或deque。在当迫不得已的时候分配新的内存给容器。
## api

WARNING: STL容器并非是线程安全的。


#### size
size表示已经保存的元素数目；
#### capacity
而capacity表示不分配新的内存空间下，最多可保存的元素数目。

capacity - 容器的成员函数capacity()取得

STL容器的capacity属性，表示STL在发生realloc前能允许的最大元素数，也可以理解为预分配的内存空间。例如一个vector<int> v的capacity为5，当插入第6个元素时，vector会realloc，vector内部数据会复制到另外一个内存区域。这样之前指向vector中的元素的指针、迭代器等等均会失效。

STL容器的capacity属性，表示STL在发生realloc前能允许的最大元素数，也可以理解为预分配的内存空间。
capacity = 0

实际具有capacity属性的容器只有vector和string，在不同实现下，capacity也不尽相同

### max_size
max_size - 容器的成员函数max_size()取得
max_size属性和capacity不同，表示STL容器允许的最大元素数，通常，这个数是一个很大的常整数，可以理解为无穷大。这个数目与平台和实现相关，在我的机器上`vector<int>`的max_size为1073741823，而string的max_size为4294967294。因为max_size很大~所以基本不会发生元素数超过max_size的情况，只需知道两者区别即可。

#### swap
swap操作不会对任何元素进行拷贝，删除插入，可以在常数时间内完成操作。故指向容器的迭代器，引用，指针在swap操作之后不会失效。

#### assign
由于赋值运算符要求左边和右边的运算对象具有相同的类型。所以定义assign的成员，允许从一个不同但相容的类型赋值，或者从容器的一个子序列赋值。

#### 插入
``` cpp
push_front()
push_back()
insert();
```
#### 删除
``` cpp
c.pop_back()      // 删除末尾的元素。
c.pop_front()     //  删除第一个元素。
```


### copy vector by another vector

优先使用copy assignment，甚于 copy construction

### union切换短数组和容器
根据数据长度，通过union选择性保存到短数组或容器
### 移动构造
移动构造之后，是否会调用析构函数？
#### emplace

c++11引入了emplace等操作。对应原有的push等操作。当调用一个emplace成员函数时，将参数传递给元素类型的构造函数。emplace成员使用这些参数在容器管理的内存空间中直接构造元素，避免了拷贝。传递的参数必须与元素类型的构造函数相对应。
### 扩展容器内存
空间不足时，将会触发内存扩展动作。调用realloc函数，重新分配更多的内存。

### 扩展倍数
gcc的扩展倍数是2，msvc的扩展倍数是1.5
### 收缩容器
容器会自动扩容，但是不会收缩内存。需要用户显示调用收缩函数，收缩容器的内存占用空间

### misc

**Q**: “vector”: 不是“std”的成员

**A**:


``` cpp
#include<vector>

std::vector<int> a;

```
