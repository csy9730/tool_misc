# C++接口和实现分离

在用C++写要导出类的库时，我们经常只想暴露接口，而隐藏类的实现细节。也就是说我们提供的头文件里只提供要暴露的公共成员函数的声明，类的其他所有信息都不会在这个头文件里面显示出来。这个时候就要用到接口与实现分离的技术。

## 例子
下面用一个最简单的例子来说明。

### 原始实现部分
类Foo是我们要实现功能的类，其中有一个私有成员变量是Bar类的对象，一个类的私有数据属于它的实现细节（implementation details），理想情况下应该隐藏起来，它的变化对于调用者不可见。虽然Bar类是作为private成员出现，但仍然暴露了其定义。
如果直接使用Foo作为接口，一旦实现需要改变，例如改变Bar，所有直接或间接包含(include)了bar.h的文件都将面临重新编译。

C++之所以不允许分割类定义的一大原因就是编译期需要确定对象的大小。考虑上面的main函数，在类定义分割开的情况下，这段代码将无法编译。因为编译器在编译`Foo foo`的时候需要知道对象foo有多大，而这个信息是通过查看Foo的定义得来的。而此时类的私有成员并不在其中，编译器将无法确定foo的大小。注意，Java中并不存在这样的问题，因为Java所有的对象默认都是引用，类似于C++中的指针，编译期并不需要知道对象的大小,指针的大小是固定的已知的。

包含以下文件
- foo.h 接口部分，依赖bar.h
- foo.cpp
- bar.h 实现部分
- bar.cpp


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

### Pimpl Idiom手法
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

### Object Interface
另一个能够同时满足两个需求的方法是使用接口类，也就是不包含私有数据的抽象类。调用端首先获得一个Foo对象的指针，然后通过接口指针`FooVirtual*`来进行操作。这种方法的代价是可能会多一个VPTR，指向虚表。


各个文件内容如下：
``` c++
// fooVirtual.h
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
## 总结

无论是Impl Idiom手法，还是Object Interface手法都实现了同样的接口，而且它们有一个共同的目的，降低用户（被提供接口的小组也称为客户）直接操作数据造成不必要错误的可能性。其实它们有一个重要的优点就是将模块的依赖性降到了最低，举个例子吧，假如客户在使用这些接口的时候，如果这些接口内部的实现细目变更了，客户也不需要再重新编译自己的代码，因为客户只依赖接口声明的头文件。如果客户依赖接口的代码量非常大，那么，这个时候，这样定义接口就非常有必要了，毕竟客户在不修改自己代码的前提下，不需要重新编译自己的代码，这样可以提高客户的效率。 

其实，这样来设计接口还是有缺点的，虽然接口定义在一个类中，但是真正实例化接口类的过程中，编译器会自动替我们生成必需的成员函数（比如构造函数、拷贝构造函数等），显然Animal也不例外。虽然有这样的缺点，但还是瑕不掩瑜。