# C++接口和实现分离

在用C++写要导出类的库时，我们经常只想暴露接口，而隐藏类的实现细节。也就是说我们提供的头文件里只提供要暴露的公共成员函数的声明，类的其他所有信息都不会在这个头文件里面显示出来。这个时候就要用到接口与实现分离的技术。

## 实现分离
下面用一个最简单的例子来说明。
### 实现部分
类Foo是我们要实现功能的类，其中有一个私有成员变量是Bar类的对象，一个类的私有数据属于它的实现细节（implementation details），理想情况下应该隐藏起来，它的变化对于调用者不可见。虽然Bar类是作为private成员出现，但仍然暴露了其定义。
如果直接使用Foo作为接口，一旦实现需要改变，例如改变Bar，所有直接或间接包含(include)了bar.h的文件都将面临重新编译。

C++之所以不允许分割类定义的一大原因就是编译期需要确定对象的大小。考虑上面的main函数，在类定义分割开的情况下，这段代码将无法编译。因为编译器在编译”Foo foo"的时候需要知道对象foo有多大，而这个信息是通过查看Foo的定义得来的。而此时类的私有成员并不在其中，编译器将无法确定foo的大小。注意，Java中并不存在这样的问题，因为Java所有的对象默认都是引用，类似于C++中的指针，编译期并不需要知道对象的大小,指针的大小是固定的已知的。


各个文件内容如下：
``` c++
// foo.h
#include "bar.h"

class Foo 
{
public:
    Foo();
    ~Foo();

    void DoSomething();

private:
    Bar m_bar;
};
```
foo.cpp文件内容：
``` c++
#include "foo.h"

Foo::Foo()
{
}
Foo::~Foo()
{
}
void Foo::DoSomething()
{
    bar();
}
```

bar.h文件内容：
``` c++
class Bar 
{
public:
    Bar();
    virtual ~Bar();
 
    void DoSomething();
};
```
bar.cpp文件内容：
``` c++
#include "bar.h"
#include <iostream>
using namespace std;

Bar::Bar()
{
}

Bar::~Bar()
{
}

void Bar::DoSomething()
{
    cout << "Do something in class Bar!" << endl;
}
```

### 接口部分
设计一个封装的接口类FooWrap，在没有包括Foo的头文件定义的情况下，FooWrap包括了Foo的指针，通过动态构建（new）隐含了Foo的实现。

``` c++
// fooWrap.h
//  前置声明
class Foo;

class FooWrap 
{
public:
    FooWrap();
    virtual ~FooWrap();
    void DoSomething();
private:
    //  声明一个类ClxImplement的指针，不需要知道类ClxImplement的定义
    Foo *m_pImpl;
};
```

``` c++
// fooWrap.cpp
#include "fooWrap.h"

FooWrap::FooWrap()
{
    m_pImpl = new Foo;
}

FooWrap::~FooWrap()
{
    if (m_pImpl)
        delete m_pImpl;
}

void FooWrap::DoSomething()
{
    m_pImpl->DoSomething();
}
```
这种方法是需要付出代价的。代价就是多了一个FooWrap类需要维护，并且每次调用FooWrap的接口都将导致对于Foo相应接口的间接调用。
## interface类
另一个能够同时满足两个需求的方法是使用接口类，也就是不包含私有数据的抽象类。调用端首先获得一个Foo对象的指针，然后通过接口指针FooVirtual*来进行操作。这种方法的代价是可能会多一个VPTR，指向虚表。


各个文件内容如下：
``` c++
// fooVirtual.h
#include "bar.h"
class FooVirtual  
{
public:
    virtual ~FooVirtual();
    virtual void DoSomething()=0;
};
```

``` c++
// foo.h
#include "fooVirtual.h"
#include "bar.h"

class Foo:public FooVirtual
{
public:
    Foo();
    ~Foo();
    void DoSomething();
private:
    Bar m_bar;
};
```
