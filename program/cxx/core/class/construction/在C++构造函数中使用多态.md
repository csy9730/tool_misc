# 在C++构造函数中使用多态

[![左未](https://pica.zhimg.com/v2-00f4ad021513d1194639ca2e63621193_l.jpg?source=172ae18b)](https://www.zhihu.com/people/sato-momeji)

[左未](https://www.zhihu.com/people/sato-momeji)

UE4开发者，偶尔会写一些和技术无关的回答。

4 人赞同了该文章

## 在C++构造函数中使用多态

## C++的构造函数被禁止使用多态

假设我们有这么一段代码。其中，`Foo`是虚函数。

```cpp
class Base
{
public:
    Base()
    {
        Foo();
    }

    virtual void Foo() { std::cout << "Base::Foo"; }
}

class Derived : public Base
{
    Derived() : Base() {}

    virtual void Foo { std::cout << "Derived::Foo"; }
}

int main()
{
    Derived* d = new Derived();
    return 0;
}
```

你会发现打印出来的是`Base::Foo`而不是`Derived::Foo`，虚函数`Foo`并没有正确地执行运行时多态。

为什么C++要这么规定呢？

先下结论，这是为了避免调用虚函数的派生类版本的时候，使用了一些未被初始化的字段，从而引发崩溃。

假设`Derived`类是这么定义的：

```cpp
class Derived : public Base
{
    Derived() : Base() {}

    virtual void Foo { std::cout << "Derived::Foo" << HelloStr; }

    std::string HelloStr;
}
```

如果你对C++类构造函数的执行顺序有所了解，应该会知道，基类的构造函数是先于派生类构造函数执行的。

也就是说假设构造函数中多态生效了，那么执行顺序是：

```cpp
Base::Base()
Derived::Foo()
Derived::Derived()
```

执行`Derived::Foo()`的时候，其实派生类中的字段还未被初始化，这个时候去访问它，就可能会发生crash。

为此，C++直接取消了构造函数中的多态。

## 如何绕过这个限制

目前来说，文章中提到有两种方案可以绕过这个限制。

### 自定义Init，在构造函数执行完之后执行

这个方法比较粗暴简单，既然无法在构造函数中使用多态，那么在别的函数里面（比如自己写一个`Init()`函数）执行虚函数就好啦。比如：

```cpp
class Base
{
public:
    Base()
    {
        // Foo(); 不要在构造函数里面调用虚函数
    }

    void Init()
    {
        Foo();
    }

    virtual void Foo() { std::cout << "Base::Foo"; }
}

class Derived : public Base
{
    Derived() : Base() {}

    virtual void Foo { std::cout << "Derived::Foo"; }
}

int main()
{
    Derived* d = new Derived();
    d->Init();
    return 0;
}
```

这个方案有仅有的一个问题：在哪里调用Init？我们必须保证使用者会在创建类实例之后，还要记得调用`Init()`方法，才能保证一些初始化被执行。假如使用者忘了调用`Init()`，可能会产生一些意料之外的结果。

想要避免这种问题，可以创建一个工厂类，或者模板工厂方法，在内部调用它的`Init`函数：

```cpp
template<class T>
T* NewInitiatedT()
{
    T* Ret = new T();
    Ret->Init();
    return Ret;
}
```

### 委托初始化

既然没办法在构造函数里面让「自己的」虚函数产生多态的效果...

那么就让别的类来做就行啦！

这个方案具体来说：

1. 原有类的一些虚函数抽取出去，放到另一个类`InitHelper`中
2. 原有类在构造函数中需要传入一个`InitHelper`来帮助初始化类
3. `InitHelper`可以定义一些虚函数，可以通过继承和覆写来定义不同的`InitHelper`
4. 原有类在构造函数中调用`InitHelper`的虚函数，可以实现多态

说这么多很难理解吧，看一段代码：

```cpp
// 定义在 abc.h 头文件中

#pragma once

#include <string>
#include <iostream>

// 前置声明，避免暴露helper类的定义给外界
class InitHelperBase;
class InitHelperDerived;

class Base
{
public:
    // 要有一个默认的
    Base();

    void PrintStr()
    {
        std::cout << Str << std::endl;
    }

protected:
    // 这个构造函数应该是protected的，不暴露给外界，参数得是「const引用」
    Base(const InitHelperBase& InitHelper);

    std::string Str;

    /*
     * 声明友元类，方便访问内部。个人感觉友元类还是不要乱用，
     * 但是这种不暴露给外部的helper类作为友元类倒是非常合适，这里的helper类基本可以当做是内部类看了。
     */
    friend class InitHelperBase;
    friend class InitHelperDerived;
};

class Derived : public Base
{
public:
    Derived();

protected:
    Derived(const InitHelperBase& InitHelper);
};

// 定义在 abc.cpp 源文件中
#include "abc.h"

class InitHelperBase
{
public:
    // 这里注意，由于是作为const引用被使用的，所以这里的虚方法也必须是const方法，才能够被调用
    virtual void InitOuter(Base* InBase) const
    {
        InBase->Str = "Init by HelperBase";
    }
};

class InitHelperDerived : public InitHelperBase
{
public:
    // 这里注意，由于是作为const引用被使用的，所以这里的虚方法也必须是const方法，才能够被调用
    virtual void InitOuter(Base* InBase) const
    {
        InBase->Str = "Init by HelperDerived";
    }
};

// 调用自己的另一个构造函数
Base::Base() : 
    Base(InitHelperBase()) { }

Base::Base(const InitHelperBase& InitHelper)
{
    // 调用Helper的虚方法来初始化自己
    InitHelper.InitOuter(this);
}

// 调用自己的另一个构造函数
Derived::Derived() : 
    Derived(InitHelperDerived()) {}

// 直接调用基类构造函数
Derived::Derived(const InitHelperBase& InitHelper) :
    Base(InitHelper) {}

int main()
{
    Derived* d = new Derived();
    d->PrintStr();
    // 正确地打印出来是derived哒！

    return 0;
}
```

上面这段代码有几个点是要注意的：

1. 为了避免把Helper暴露给外界，需要
2. 前置声明Helper类到头文件中，但不在头文件中定义Helper类
3. 把Helper类声明为友元类，能够完全控制它的依附类
4. 需要提供两个构造函数
5. 第一个构造函数的参数是「const 引用」的helper，而不是helper类的指针，这是因为不想管理指针的生命周期（何时new何时delete）。基类的这个构造函数中，需要调用Helper类的虚函数来初始化自身。另外，这个构造函数应该是protected的，不应该暴露给外界。
6. 第二个构造函数是无参的构造函数，它会去调用第一个构造函数，传入一个基类和派生类对应的Helper类
7. 由于上面说的构造函数里面要的是一个const引用，所以helper中的虚函数要定义为const函数

## 参考文献

1. [Inheritance — What your mother never told you](https://link.zhihu.com/?target=https%3A//isocpp.org/wiki/faq/strange-inheritance%23calling-virtuals-from-ctors)

发布于 2021-04-27 15:23

[多态](https://www.zhihu.com/topic/20011238)

[C++](https://www.zhihu.com/topic/19584970)

[虚函数（C++）](https://www.zhihu.com/topic/20029040)