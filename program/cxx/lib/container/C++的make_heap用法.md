# [C++的make_heap/pop_heap/push_heap用法](https://www.cnblogs.com/FdWzy/p/12487216.html)

make_heap：对一个容器建堆（**默认最大堆！**）

调用方法：make_heap(iter1,iter2,<cmp>);　　其中cmp为小于规则，不加就是默认最大堆。

cmp一般使用lambda表达式，比如：

```cpp
make_heap(data.begin(),data.end(),[](const int& a,const int& b){return a>b;});
```

或者利用仿函数，即类里重载函数运算符，注意加括号：


```cpp
class F{
        public:
        bool operator()(const int& a,const int& b){
            return a>b;
        }
    };

make_heap(data.begin(),data.end(),F());
```



push_heap：调用之前该容器一定已经为堆了，并且只能push_back一个元素在尾部才能调用push_heap。

官网解释：

**Given a heap in the range `[first,last-1)`, this function extends the range considered a heap to `[first,last)` by placing the value in `(last-1)` into its corresponding location within it.**

**A range can be organized into a heap by calling** **[make_heap](http://www.cplusplus.com/make_heap)****. After that, its heap properties are preserved if elements are added and removed from it using** **push_heap** **and** **[pop_heap](http://www.cplusplus.com/pop_heap)****, respectively.**

**
**所以一般的调用场景：make_heap过或者刚刚push_heap过，总之之前容器符合堆性质。接下来可以push_back一个元素，并调用push_heap。**需要注意的是，push_heap的参数也必须和之前make_heap的参数一样，主要就是那个cmp，如果建堆时cmp就是默认的，那么push_heap也可以不写参数，但最好写上，这样可以养成良好习惯。**

 

pop_heap：做两件事情，一：swap(data[0],data[n-1]);　　二：恢复0~n-2元素的堆性质。所以pop_heap是不删除元素的，只是把之前的堆顶放到了容器末尾，需要我们自己调用pop_back删除。**另外需要注意pop_heap内部也含有建堆过程，所以和push_heap一样需要注意函数调用的参数cmp。**

 

有趣小知识：push_heap复杂度为O(logN)，pop_heap复杂度为O(2logN)，虽然是常数项的区别。

原因：push_heap是把数字加到末尾，并不断上溯。每次上溯时它只和其父节点比较，所以是O(logN)。

pop_heap把原来的数组末尾元素放到堆顶，并不断下溯。每次下溯时它会和其两个子节点比较，所以是O(2logN)。

进击的小🐴农

分类: [C++](https://www.cnblogs.com/FdWzy/category/1644509.html)