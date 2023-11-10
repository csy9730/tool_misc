# make_shared和shared_ptr的区别

```cpp
struct A;
std::shared_ptr<A> p1 = std::make_shared<A>();
std::shared_ptr<A> p2(new A);
```

上面两者有什么区别呢？ 区别是：std::shared_ptr构造函数会执行两次内存申请，而std::make_shared则执行一次。

std::shared_ptr在实现的时候使用的refcount技术，因此内部会有一个计数器（控制块，用来管理数据）和一个指针，指向数据。因此在执行`std::shared_ptr p2(new A)`的时候，首先会申请数据的内存，然后申请内控制块，因此是两次内存申请，而`std::make_shared()`则是只执行一次内存申请，将数据和控制块的申请放到一起。那这一次和两次的区别会带来什么不同的效果呢？

## 异常安全

考虑下面一段代码：

```php
void f(std::shared_ptr<Lhs> &lhs, std::shared_ptr<Rhs> &rhs){...}

f(std::shared_ptr<Lhs>(new Lhs()),
  std::shared_ptr<Rhs>(new Rhs())
);
```

因为C++允许参数在计算的时候打乱顺序，因此一个可能的顺序如下:

1. new Lhs()
2. new Rhs()
3. std::shared_ptr
4. std::shared_ptr

此时假设第2步出现异常，则在第一步申请的内存将没处释放了，上面产生内存泄露的本质是当申请数据指针后，没有马上传给std::shared_ptr，因此一个可能的解决办法是：

```mipsasm
auto lhs = std::shared_ptr<Lhs>(new Lhs());
auto rhs = std::shared_ptr<Rhs>(new Rhs());
f(lhs, rhs);
```

而一个比较好的方法是使用`std::make_shared`。

```lisp
f(std::make_shared<Lhs>(),
  std::make_shared<Rhs>()
);
```

## make_shared的缺点

因为make_shared只申请一次内存，因此控制块和数据块在一起，只有当控制块中不再使用时，内存才会释放，但是weak_ptr却使得控制块一直在使用。

### 什么是weak_ptr？

weak_ptr是用来指向shared_ptr，用来判断shared_ptr指向的数据内存是否还存在了（通过方法lock），下面是一段示例代码：

```cpp
#include <memory>
#include <iostream>
using namespace std;
struct A{
    int _i;
    A(): _i(int()){}
    A(int i): _i(i){}
};

int main()
{
    shared_ptr<A> sharedPtr(new A(2));
    weak_ptr<A> weakPtr = sharedPtr;
    sharedPtr.reset(new A(3)); // reset，weakPtr指向的失效了。
    cout << weakPtr.use_count() <<endl;
}
```

通过lock（）来判断是否存在了，lock（）相当于

```kotlin
expired（）？shared_ptr<element_type>() ： shared_ptr<element_type>(*this)
```

当不存在的时候，会返回一个空的shared_ptr，weak_ptr在指向shared_ptr的时候，并不会增加ref count，因此weak_ptr主要有两个用途：

1. 用来记录对象是否存在了
2. 用来解决shared_ptr环形依赖问题

#### weak_ptr解决环形依赖

下面是存在环形依赖的代码：

```cpp
include <memory>
include <iostream>

using namespace std;
struct B;
struct A { shared_ptr<B> b;};
struct B { shared_ptr<A> a;};


int main()
{
    shared_ptr<A> x(new A);
    //x->b = new B; // wrong
    //x->b = shared_ptr<B>(new B);
    x->b = make_shared<B>();
    x->b->a = x;
    cout << x.use_count() <<endl;
    cout << x->b.use_count() <<endl;
    // Ref count of 'x' is 2.
    // Ref count of 'x->b' is 1.
    // When 'x' leaves the scope, there will be a memory leak:
    // 2 is decremented to 1, and so both ref counts will be 1.
    // (Memory is deallocated only when ref count drops to 0)
}
```

下面是解决方案：

```sql
shared_ptr<A> x(new A);
//x->b = new B; // wrong
//x->b = shared_ptr<B>(new B);
x->b = make_shared<B>();
x->b->a = x;
cout << x.use_count() <<endl;
cout << x->b.use_count() <<endl;
// Ref count of 'x' is 1.
// Ref count of 'x->b' is 1.
// When 'x' leaves the scope, its ref count will drop to 0.
// While destroying it, ref count of 'x->b' will drop to 0.
// So both A and B will be deallocated.   cout << x->b.use_count() <<endl;
```

一个自然而然的问题是：`weak_ptr`是否能够当编程人员不清楚拥有权的情况下解决环形依赖呢？

答案是不能，当对象之间的拥有权不清楚的时候，weak_ptr并不能带来帮助。如果存在环，必须要找出来，然后手动打破。那怎么能够解决环形依赖呢？可以使用有完整垃圾回收机制的语言如Java，Go，Haskell，或者使用有些缺陷的垃圾回收器（C/C++）[Boehm GC)](http://en.wikipedia.org/wiki/Boehm_garbage_collector)。

### 为什么weak_ptr使得控制块一直使用呢？

我们想下，当要使用weak_ptr来获取shared_ptr的时候，需要得到指向数据的shared_ptr数目，而这正是通过user-count来得到的，而这块内存是分配在shared_ptr中的，自然有使用的，那就不会释放了，即使数据引用数为0了，但是由于make_shared（）使得数据和控制块一起分配，自然只要有weak_ptr指向了控制块，就不会释放整块内存了。

### weak_ptr的使用注意

下面有段代码：

```perl
shared_ptr<int> p(new int(5));
weak_ptr<int> q(p);

// some time later

if(int * r = q.get())
{
    // use *r
}
```

如果在多线程中，在if之后，但是在使用*r之前，另一个线程对p进行了reset，那次后在使用*r则会抛出异常，一个解决方法就是:

```perl
shared_ptr<int> p(new int(5));
weak_ptr<int> q(p);

// some time later

if(shared_ptr<int> r = q.lock())
{
    // use *r
}
```

此时r指向了数据，就不怕被释放了，因此在使用weak_ptr的时候，应使用lock方法转换成shared_ptr后使用。