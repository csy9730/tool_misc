# C++进阶：std::function

[Codemaxi](https://juejin.cn/user/1047163961900152/posts)

2022-06-131,128阅读4分钟

专栏： 

C++/CPP

持续创作，加速成长！这是我参与「掘金日新计划 · 6 月更文挑战」的第14天，[点击查看活动详情](https://juejin.cn/post/7099702781094674468)

## 概述

类模板 `std::function` 是通用多态函数封装器。 `std::function` 的实例能存储、复制及调用任何[*可调用*](https://link.juejin.cn/?target=https%3A%2F%2Fwww.apiref.com%2Fcpp-zh%2Fcpp%2Fnamed_req%2FCallable.html)[ ](https://link.juejin.cn/?target=https%3A%2F%2Fwww.apiref.com%2Fcpp-zh%2Fcpp%2Fnamed_req%2FCallable.html)[*(Callable)* ](https://link.juejin.cn/?target=https%3A%2F%2Fwww.apiref.com%2Fcpp-zh%2Fcpp%2Fnamed_req%2FCallable.html)*目标*——普通函数、 [lambda 表达式](https://link.juejin.cn/?target=https%3A%2F%2Fwww.apiref.com%2Fcpp-zh%2Fcpp%2Flanguage%2Flambda.html)、 [bind 表达式](https://link.juejin.cn/?target=https%3A%2F%2Fwww.apiref.com%2Fcpp-zh%2Fcpp%2Futility%2Ffunctional%2Fbind.html)或其他函数对象，还有指向成员函数指针和指向数据成员指针。

存储的可调用对象被称为 `std::function` 的目标。若 `std::function` 不含目标，则称它为空。调用空的`std::function` 的目标导致抛出 std::bad_function_call 异常。

`std::function` 包装器可拷贝，移动等，并且包装器类型仅仅依赖于调用特征，而不依赖于可调用元素自身的类型。std::function是C++11的新特性，包含在头文件``中。

## 引入

在C/C++中函数指针作为一种回调机制被广泛使用，但是函数指针在C++面向对象编程中有些不足，比如无法捕捉上下文。举个例子，使用对象的非静态成员函数作为函数指针就无法做到。

在C++11之前，在使用STL算法时，通常会使用到一种特别的对象，称为函数对象，或者仿函数（functor），如下：

```cpp
cpp复制代码#include <iostream>
#include <functional>

class Add {
 public:
     int operator()(int x, int y) { return x + y; }
 };

int main() {
     Add add;
     std::cout << add(1, 2);
     return add(3, 4);
 }
```

函数对象就是重新定义了成员函数operator()的一种对象，其使用在代码层面感觉跟函数的使用并无二样，但究其本质却并非函数。

相比函数，函数对象可以拥有初始状态，一般通过class定义私有成员，并在声明对象的时候对其进行初始化。私有成员的状态就成了仿函数的初始状态。声明一个仿函数对象可以拥有多个不同初始状态的实例，因此可以借由函数对象产生多个功能类似却不同的函数对象实例。

```cpp
cpp复制代码#include <functional>
#include <iostream>

class Add {
public:
    Add(float base) : base_(base) {}
    int operator()(int x, int y) { return base_ * (x + y); }
private:
    float base_;
 
};

int main() {
    Add add(0.5);
    std::cout << add(1, 2);

    Add add2(1.5);
    std::cout << add2(3, 4);

    return 0;
}
```

C++11中还有另外一个功能lambda表达式，lambda表达式功能虽然类似函数，但是在本质上并非函数，这样导致一个问题：函数指针不能指向lambda函数，因为lambda函数本质上并非函数。

而且函数对象，函数指针和lambda函数类型也不相同。当然可以通过C++模板(template)来接收这些类型，std::sort的实现就使用了模板，不论使用函数、函数对象还是lambda函数实现的排序算法，均可以传给std::sort。但是呢，采用模板最大的问题在于编译期展开，头文件会变得很大，编译时间也会很长。C++11引入std::function就能很好的解决了这一问题。 std::function简单来说就像是个接口，且能够把符合这个接口的对象（这里对象泛指一切类型，并非面向对象编程中的对象）储存起来，更神奇的是，两个std::function的内容可以交换。下面我们就来详细看看这个神奇的std::function。

## std::function模板类

```cpp
cpp复制代码template <class T>
class function;  // 只声明，不定义

template <class R, class... ArgTypes>
class function<R(ArgTypes...)> {
   public:
    using result_type = R;

    // 构造/复制/销毁
    function() noexcept;
    function(nullptr_t) noexcept;
    function(const function&);
    function(function&&) noexcept;
    template <class F>
    function(F);

    function& operator=(const function&);
    function& operator=(function&&);
    function& operator=(nullptr_t) noexcept;
    template <class F>
    function& operator=(F&&);
    template <class F>
    function& operator=(reference_wrapper<F>) noexcept;

    ~function();

    // function 修改器
    void swap(function&) noexcept;

    // function 容量
    explicit operator bool() const noexcept;

    // function 调用
    R operator()(ArgTypes...) const;

    // function 目标访问
    const type_info& target_type() const noexcept;
    template <class T>
    T* target() noexcept;
    template <class T>
    const T* target() const noexcept;
};

template <class R, class... ArgTypes>
function(R (*)(ArgTypes...)) -> function<R(ArgTypes...)>;

template <class F>
function(F) -> function</* see description */>;

// 空指针比较函数
template <class R, class... ArgTypes>
bool operator==(const function<R(ArgTypes...)>&, nullptr_t) noexcept;

// 特化的算法
template <class R, class... ArgTypes>
void swap(function<R(ArgTypes...)>&, function<R(ArgTypes...)>&) noexcept;
```

T：通用类型，但实际通用类型模板并没有被定义，只有当T的类型为形如`R(ArgTypes...)`的函数类型才能工作；

R ：调用函数返回值的类型；

ArgTypes：函数参数类型，对于指向成员函数的指针，第一个参数应该是指向该成员函数的引用或者对象。

从成员函数里我们知道std::function对象实例不允许进行`==`和`!=`比较操作，std::function模板类实例最终调用成员函数`R operator()(_ArgTypes...) const`进而调用包装的调用实体。std::function可包装下列可调用元素类型：

- 函数
- 函数指针
- 类成员函数(也包括模板类)
- 任意类型的函数可调用对象（比如重载了`operator()`操作符并且拥有函数闭包的函数体对象）
- lamda表达式

std::function对象可被拷贝和转移，并且可以使用指定的调用特征来直接调用目标元素。 当std::function对象未包裹任何实际的可调用元素，调用该std::function对象将抛出std::bad_function_call异常。

## 拷贝、移动

```cpp
cpp复制代码#include <iostream>
#include <functional>

int fun1(int a) {return a;}

int main() {
    std::cout << "Hello std::function" << std::endl;

    std::function<int(int)> fc1 = fun1; //拷贝赋值运算符
    std::cout << fc1(30) << std::endl;

    std::function<int(int)>&& fc2 = std::move(fun1); //移动赋值运算符
    std::cout << fc2(30) << std::endl;
    std::cout << fun1(30) << std::endl;

    std::function<int(int)> fc3(fun1); //拷贝
    std::cout << fc3(30) << std::endl;
    return 0;
}
```

## 包装模板类成员函数、静态函数、对象函数

```cpp
cpp复制代码#include <functional>
#include <iostream>

template <typename T>
struct Test {
    T operator()(T a) { return a * a; }
    T Square(T a) { return a * a; }
    static T Square2(T a) { return a * a; }
};

int main(int argc, char *argv[]) {
    // 模板类成员函数
    Test<int> test;
    std::function<int(int)> fc =
        std::bind(&Test<int>::Square, test, std::placeholders::_1);
    std::cout << fc(7) << std::endl;
    // 模板类静态函数
    std::function<int(int)> fc2 = Test<int>::Square2;
    std::cout << fc2(7) << std::endl;
    // 模板类对象函数
    std::function<int(int)> fc3 = Test<int>();
    std::cout << fc3(7) << std::endl;
    return 0;
}
```

## 包装类成员函数、静态函数

```cpp
cpp复制代码#include <functional>
#include <iostream>

struct Test {
    int Square(int a) { return a * a; }
    static int Square2(int a) { return a * a; }    
};

int main(int argc, char *argv[]) {
    // 类成员函数
    Test test;
    std::function<int(int)> fc =
        std::bind(&Test::Square, test, std::placeholders::_1);
    std::cout << fc(7) << std::endl;
    // 类静态函数
    std::function<int(int)> fc2 = Test::Square2;
    std::cout << fc2(7) << std::endl;
    return 0;
}
```

这里我们用到了std::bind，C++11中std::bind函数的意义就如字面上的意思一样，用来绑定函数调用的某些参数。std::bind的思想其实是一种延迟计算的思想，将可调用对象保存起来，然后在需要的时候再调用。而且这种绑定是非常灵活的，不论是普通函数还是函数对象还是成员函数都可以绑定，而且其参数可以支持占位符。

这里的std::placeholders::_1是一个占位符，且绑定第一个参数，若可调用实体有2个形参，那么绑定第二个参数的占位符是std::placeholders::_2。

## 包装普通模板函数、函数对象

```cpp
cpp复制代码#include <iostream>
#include <functional>

struct Add{
    int operator()(int x, int y) {
        return x + y;
    }
};

template<typename T>
T fun1(T a) {return a;}

int main() {
    // 普通模板函数
    std::function<int(int, int)> fc = Add(); 
    std::cout << fc(30, 12) << std::endl;
    // 普通函数对象
    std::function<int(int)> fc2 = fun1<int>;
    std::cout << fc2(42) << std::endl; 
    return 0;
}
```

## 包装普通函数、函数指针、lamda表达式

```cpp
cpp复制代码#include <iostream>     // std::cout
#include <functional>   // std::function, std::plus

int fun1(int a){return a;}
int (*fun_ptr)(int); // 函数指针

int main() {
    {//普通函数
        std::function<int(int)> fc = fun1;
        std::cout << fc(42) << std::endl; 
    }
    {// 函数指针
        std::function<int(int)> fc = fun1;
        std::cout << fc(42) << std::endl;
    }
    {//lamda表达式
        auto square = [](int a) {return a * a;}; 
        std::function<int(int)> fc = square;
        std::cout << fc(9) << std::endl;
    }
    return 0;
}
```

## **函数实参**

```cpp
cpp复制代码#include <functional>
#include <iostream>

void callback(int x, const std::function<void(int)>& f) {
    if (!(x & 1)) {
        f(x);
    }
}

void output(int x) { std::cout << x << " "; }

int main(void) {
    for (int i = 0; i < 10; ++i) {
        callback(i, output);
    }
}
```

## **回调函数**

std::function 可以取代函数指针，使得函数延迟执行，因此可以当成回调函数使用。

```cpp
cpp复制代码#include <functional>
#include <iostream>

class A {
    std::function<void()> callback_;

   public:
    A(const std::function<void()>& f) : callback_(f){};
    void notify(void) { callback_(); }
};

class Foo {
   public:
    void operator()(void) { 
        std::cout << "Foo operator()" << std::endl; 
    }
};

int main(void) {
    Foo foo;
    A aa(foo);
    aa.notify();
}
```

## 如何判断std::function为空？

要检查[`std::function`](https://link.juejin.cn/?target=http%3A%2F%2Fen.cppreference.com%2Fw%2Fcpp%2Futility%2Ffunctional%2Ffunction)中是否存储了可调用目标。可以使用`operator bool()`成员函数，该检查定义明确且有效，如下：

```cpp
cpp复制代码#include <iostream>     // std::cout
#include <functional>   // std::function, std::plus

int main () {
  std::function<int(int,int)> foo,bar;
  foo = std::plus<int>();

  foo.swap(bar);

  std::cout << "foo is " << (foo ? "callable" : "not callable") << ".\n";
  std::cout << "bar is " << (bar ? "callable" : "not callable") << ".\n";

  return 0;
}
```

## 总结

从上面的例子可以看出，std::function可以应用的范围很广，而且没有模板带来的头文件膨胀问题，非常适合取代函数指针。然而，std::function相较于函数指针，性能上会有一点点损失，如果不是在性能特别关键的场合，还是大胆拥抱C++ 11这一新特性吧！上面我们使用到了std::bind，这也是C++11的一个新特性，我们下一篇文章再详细介绍它。

标签：

[后端](https://juejin.cn/tag/后端)