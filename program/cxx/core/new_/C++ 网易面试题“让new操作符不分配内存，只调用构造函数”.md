# C++ 网易面试题“让new操作符不分配内存，只调用构造函数”

![img](https://upload.jianshu.io/users/upload_avatars/3262084/f5a505d42bb8?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[周肃](https://www.jianshu.com/u/288a7b76b426)关注

0.2952017.03.07 11:55:46字数 1,404阅读 5,646

## 问题

> c++中的new操作符　通常完成两个工作　分配内存及调用相应的构造函数。
> 请问：
> 1）如何让new操作符不分配内存，只调用构造函数？
> 2）这样的用法有什么用？

## placement new的含义

placement new可以实现不分配内存，只调用构造函数。

```cpp
void *operator new( size_t, void *p ) throw()     { return p; }
```

placement new的执行忽略了size_t参数，只返还第二个参数。
其结果是允许用户把一个对象放到一个特定的地方，达到调用构造函数的效果。

用法如下：

```cpp
#include <iostream>
#include <new>

class Test
{
public:
    Test()
    {
        std::cout << "Constructor" << std::endl;
    };
    ~Test()
    {
        std::cout << "Destructor" << std::endl;
    }
private:
    char mA;
    char mB;
};

char* gMemoryCache = (char *)malloc(sizeof(Test));

int main()
{
    {
        Test* test = new(gMemoryCache) Test();
    }
    {
        Test* test = new(gMemoryCache) Test();
        test->~Test();
    }
}
```

输出：

```undefined
Constructor
Constructor
Destructor
```

和其他普通的new不同的是，它在括号里多了另外一个参数。比如：

```cpp
Widget * p = new Widget; - - - - - - - - - //ordinary new 
pi = new (ptr) int; pi = new (ptr) int;     //placement new
```

括号里的参数ptr是一个指针，它指向一个内存缓冲器，placement new将在这个缓冲器上分配一个对象。
Placement new的返回值是这 个被构造对象的地址(比如括号中的传递参数)。

> placement new主要适用于：在对时间要求非常高的应用程序中，因为这些程序分配的时间是确定 的；长时间运行而不被打断的程序；以及执行一个垃圾收集器 (garbage collector)。

## new 、operator new 和 placement new 区别

- new ：不能被重载，其行为总是一致的。它先调用operator new分配内存，然后调用构造函数初始化那段内存。
- operator new：要实现不同的内存分配行为，应该重载operator new，而不是new。
- delete和operator delete类似。 delete首先调用对象的析构函数，然后调用operator delete释放掉所使用的内存。
- placement new：只是operator new重载的一个版本。它并不分配内存，只是返回指向已经分配好的某段内存的一个指针。因此不能删除它，但需要调用对象的析构函数。

> new 操作符的执行过程
> 　　(1). 调用operator new分配内存 ；
> 　　(2). 调用构造函数生成类对象；
> 　　(3). 返回相应指针。

placement new允许你在一个已经分配好的内存中（栈或者堆中）构造一个新的对象。原型中void*p实际上就是指向一个已经分配 好的内存缓冲区的的首地址。

## Placement new 存在的理由

### 用Placement new 解决buffer的问题

问题描述：用new分配的数组缓冲时，由于调用了默认构造函数，因此执行效率上不佳。若没有默认构造函数则会发生编译时错误。如果你想在预分配的内存上创建对象，用缺省的new操作符是行不通的。要解决这个问题，你可以用placement new构造。它允许你构造一个新对象到预分配的内存上。

### 增大时空效率的问题

使用new操作符分配内存需要在堆中查找足够大的剩余空间，显然这个操作速度是很慢的，而且有可能出现无法分配内存的异常（空间不够）。
placement new 就可以解决这个问题。我们构造对象都是在一个预先准备好了的内存缓冲区中进行，不需要查找内存，内存分配的时间是常数；而且不会出现在程序运行中途出现内 存不足的异常。所以，placement new非常适合那些对时间要求比较高，长时间运行不希望被打断的应用程序。

## 使用步骤

在很多情况下，placement new的使用方法和其他普通的new有所不同。这里提供了它的使用步骤。

### 第一步 缓存提前分配

有三种方式：
1.为了保证通过placement new使用的缓存区的memory alignmen(内存队列)正确准备，使用普通的new来分配它：在堆上进行分配

```cpp
class Task ;
char * buff = new [sizeof(Task)]; //分配内存
```

(请注意auto或者static内存并非都正确地为每一个对象类型排列，所以，你将不能以placement new使用它们。)

2.在栈上进行分配

```csharp
class Task ;
char buf[N*sizeof(Task)]; //分配内存
```

3.还有一种方式，就是直接通过地址来使用。(必须是有意义的地址)

```cpp
void* buf = reinterpret_cast<void*> (0xF00F);
```

### 第二步：对象的分配

在刚才已分配的缓存区调用placement new来构造一个对象。

```cpp
Task *ptask = new (buf) Task
```

### 第三步：使用

按照普通方式使用分配的对象：

```rust
ptask->memberfunction();
ptask-> member;
//...
```

### 第四步：对象的析构

一旦你使用完这个对象，你必须调用它的析构函数来毁灭它。按照下面的方式调用析构函数：

```rust
ptask->~Task(); //调用外在的析构函数
```

### 第五步：释放

你可以反复利用缓存并给它分配一个新的对象（重复步骤2，3，4）如果你不打算再次使用这个缓存，你可以象这样释放它：

```cpp
delete [] buf;
```

跳过任何步骤就可能导致运行时间的崩溃，内存泄露，以及其它的意想不到的情况。如果你确实需要使用placement new，请认真遵循以上的步骤。

## 性能对比

采用placement new和new的方式创建和删除对象一万次，统计时间，单位是us。

```cpp
int main()
{
    {
        uint64_t start = GetCurrentTimeInMicroSeconds();
        for (uint32_t i = 0; i < 10000; ++i)
        {
            Test* test = new(gMemoryCache) Test();
            test->~Test();
        }
        std::cout << GetCurrentTimeInMicroSeconds() - start << std::endl;
    }
    {
        uint64_t start = GetCurrentTimeInMicroSeconds();
        for (uint32_t i = 0; i < 10000; ++i)
        {
            Test* test = new Test();
            delete test;
        }
        std::cout << GetCurrentTimeInMicroSeconds() - start << std::endl;
    }
}
```

结果：

```cpp
placement new: 186
new : 1448
```

> 结论：在频繁构造和析构对象的场景中，placement new对性能有7倍的提升。

