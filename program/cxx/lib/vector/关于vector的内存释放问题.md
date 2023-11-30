# [关于vector的内存释放问题](https://www.cnblogs.com/jiayouwyhit/p/3878047.html)

以前一直想当然的以为vector 的clear()函数会保证释放vector的内存，今天网上一查资料发现完全不是我想象的那样子。

比如有如下代码：

```cpp
class tempObject;
tempObject obj1;
tempObject obj2;
vector<tempObject> tempVector;

tempVector.pushback(obj1);
tempVector.pushback(obj2);
tempVector.clear();
```

调用clear()函数只会调用tempObject的析构函数，从而释放掉obj1和obj2两个对象，不会释放vector所占用的内存。真正释放vector所占用的内存，要到vector对象离开作用域时，自动调用vector的析构函数释放内存。当然有一种强制释放内存的方法，比如针对上面的代码：

```cpp
vector<tempObject>().swap(tempVector);

That will create an empty vector with no memory allocated and swap it with tempVector, effectively deallocating the memory.
```

 

需要注意的是：

vector  中的内建有内存管理，当  vector  离开它的生存期的时候，它的析构函数会把  vector  中的元素销毁，并释放它们所占用的空间，所以用  vector  一般不用显式释放  ——  不过，如果你  vector  中存放的是指针，那么当  vector  销毁时，那些指针指向的对象不会被销毁，那些内存不会被释放。

 

总结：

vector与deque不同，其内存占用空间只会增长，不会减小。比如你首先分配了10,000个字节，然后erase掉后面9,999个，则虽然有效元素只有一个，但是内存占用仍为10,000个。所有空间在vector析构时回收。

empty()是用来检测容器是否为空的，clear()可以清空所有元素。但是即使clear()，**所占用的内存空间依然如故。**如果你需要空间动态缩小，可以考虑使用deque。如果非要用vector，这里有一个办法：

在《effective STL》和其实很多C++文章中都有指明，用clear()无法保证内存回收。但是**swap技法**可以。具体方法如下所示：

``` cpp
vector<int> nums;
nums.push_back(1);
nums.push_back(1);
nums.push_back(2);
nums.push_back(2);
vector().swap(nums); //或者 nums.swap(vector())；
```



`vector<int>().swap(nums); `或者如下所示 加一对大括号都可以，意思一样的： 

``` cpp
{ 
  std::vector<int> tmp =  nums;  
  nums.swap(tmp); 
}   
```



加一对大括号是可以让tmp退出{}的时候自动析构

**swap技法就是通过交换函数swap（），使得vector离开其自身的作用域，从而强制释放vector所占的内存空间**

 

 

 

 

Reference

[1]http://stackoverflow.com/questions/10464992/c-delete-vector-objects-free-memory

[2]关于vector的内存释放.http://blog.csdn.net/shenshenjin/article/details/6003425

天行健，君子以自强不息；地势坤，君子以厚德载物。

分类: [编程学习-C/C++](https://www.cnblogs.com/jiayouwyhit/category/475238.html)