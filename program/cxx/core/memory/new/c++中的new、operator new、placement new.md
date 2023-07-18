# [c++中的new、operator new、placement new](https://www.cnblogs.com/likaiming/p/9393083.html)

## 一、定义

### 1、new

new是c++中的关键字，，其行为总是一致的。它先调用operator new分配内存，然后调用构造函数初始化那段内存。

new 操作符的执行过程：
\1. 调用operator new分配内存 ；
\2. 调用构造函数在operator new返回的内存地址处生成类对象；

### 2、operator new

operator new是一个函数，就像重载任何一个符号如operator +，它用来分配内存（只不过new除了调用它还有其他步骤）。它可以被重载，**通过重载它，可以改变new操作符的功能**。它的功能介意类比c语言中的malloc，如果类中没有重载operator new，那么调用的就是全局的::operator new来从堆中分配内存。

### 2、placement new

placement new 是c++中对operator new 的一个标准、全局的重载版本。它并不分配内存，只是返回指向已经分配好的某段内存的一个指针，placement new允许你在一个已经分配好的内存中（栈或者堆中）构造一个新的对象。

## 二、使用方法

### 1、new的使用

在堆上分配分配一块内存

```
struct A* i0 = new A;
struct A* i1 = new A();
```

看new的原型：



```
void* operator new(std::size_t) _GLIBCXX_THROW (std::bad_alloc)
  __attribute__((__externally_visible__));
void* operator new[](std::size_t) _GLIBCXX_THROW (std::bad_alloc)
  __attribute__((__externally_visible__));
void operator delete(void*) _GLIBCXX_USE_NOEXCEPT
  __attribute__((__externally_visible__));
void operator delete[](void*) _GLIBCXX_USE_NOEXCEPT
  __attribute__((__externally_visible__));
void* operator new(std::size_t, const std::nothrow_t&) _GLIBCXX_USE_NOEXCEPT
  __attribute__((__externally_visible__));
void* operator new[](std::size_t, const std::nothrow_t&) _GLIBCXX_USE_NOEXCEPT
  __attribute__((__externally_visible__));
void operator delete(void*, const std::nothrow_t&) _GLIBCXX_USE_NOEXCEPT
  __attribute__((__externally_visible__));
void operator delete[](void*, const std::nothrow_t&) _GLIBCXX_USE_NOEXCEPT
  __attribute__((__externally_visible__));
```



发现它有一个参数，size_t，表示前面调用placement new分配的内存大小，new接下来会在这块内存中调用构造函数，new的操作也是c++来保证的。

### 2、operator new的使用

分配8个字节的内存，因为是未重载，所以这里调用的是全局operator new，从堆上分配了8个字节

```
void* i = operator new (8);
```

如果想重载operator new需要注意以下几点：

（1）重载时，返回类型必须声明为void*

（2）重载时，第一个参数类型必须为表达要求分配空间的大小（字节），类型为size_t

（3）重载时，可以带其它参数

（4）分配函数为类成员函数或全局函数;如果分配函数在全局范围之外的名称空间范围中声明，或者在全局范围中声明为静态，则程序是病态的

比如下面的例子中，在A重载了operator new打印出tag，返回全局的opereator new，然后在main函数中调用A的重载版本。



```
struct A{
    int a;
    char b;
    void* operator new(size_t size,int tag) throw(){
        cout << tag << endl;
        return ::operator new(size);
    }
};

int main()
{
    void* i = A::operator new (8,1);
    cout << i << endl;

    return 0;
}
```



最终结果即分配了内存，又打印出了tag的值

![img](https://images2018.cnblogs.com/blog/1184911/201807/1184911-20180730205934307-1363296662.png)

如果我们重载全局的operator new函数，然后调用new，则new的操作也会被更改，比如下面的例子(这个例子的operator new只有一个参数)



```
struct A{
    int a;
    char b;
};

void* operator new(size_t num) throw(){
    cout << num << endl;
    return nullptr;
}

int main()
{
    A* i = new A;
    cout << i << endl;

    return 0;
}
```



最终的结果是

![img](https://images2018.cnblogs.com/blog/1184911/201807/1184911-20180730212829310-1090639798.png)

可以看出，虽然没有直接调用operator new，但是new的操作已经被更改了。

还需要关注一个小地方，就是operator new调用时的参数和new的参数是有所区别的。new在调用的时候会忽略第一个size_t的参数，但是如果直接调用operator new来进行内存分配的时候是需要这个参数的。

也就是本节的第二个例子如果operator new的定义要像本节的第一个例子有两个参数的话，对new的调用应该如下：

```
A* i = new(1) A ;
```

### 3、placement new的使用

placement new是c++实现的operator new版本，它的实现如下



```
// Default placement versions of operator new.
inline void* operator new(std::size_t, void* __p) _GLIBCXX_USE_NOEXCEPT
{ return __p; }
inline void* operator new[](std::size_t, void* __p) _GLIBCXX_USE_NOEXCEPT
{ return __p; }

// Default placement versions of operator delete.
inline void operator delete  (void*, void*) _GLIBCXX_USE_NOEXCEPT { }
inline void operator delete[](void*, void*) _GLIBCXX_USE_NOEXCEPT { }
//@}
```



可以看到实际上它就返回了传进来的地址，根据operator的第二个例子，通过重载全局的operator new之后，new函数的操作就被改变了。也就能猜出，在调用new的时候参数需要加上一个地址，placement new的功能就是在这个地址之上进行构造。

placement new的使用步骤如下

1）分配内存

```
char* buff = new char[ sizeof(Foo) * N ];
memset( buff, 0, sizeof(Foo)*N );
```

2）构建对象

```
Foo* pfoo = new (buff)Foo;
```

3）使用对象

```
pfoo->print();
pfoo->set_f(1.0f);
pfoo->get_f();
```

4）析构对象，显式的调用类的析构函数。

```
pfoo->~Foo();
```

5）销毁内存

```
delete [] buff;
```

上面5个步骤是标准的placement new的使用方法。

 



分类: [C++](https://www.cnblogs.com/likaiming/category/1133044.html)

标签: [c++](https://www.cnblogs.com/likaiming/tag/c%2B%2B/), [placement new](https://www.cnblogs.com/likaiming/tag/placement new/)