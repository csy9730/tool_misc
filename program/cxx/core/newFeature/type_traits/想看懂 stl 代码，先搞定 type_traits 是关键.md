# 想看懂 stl 代码，先搞定 type_traits 是关键

作者：圣保罗爷爷

- 2020 年 5 月 09 日

- 本文字数：4075 字

  阅读完需：约 13 分钟

![想看懂stl代码，先搞定type_traits是关键](https://static001.geekbang.org/infoq/cb/cb31fe0c543ffe33c1b1890e65a407a8.jpeg)

type_traits 在 C++中是非常有用的技巧，可以说如果不懂 type_traits，那根本看不懂 stl 相关代码，最近对 type_traits 比较感兴趣，于是找到了 gcc 的 type_traits 源码通读了一遍，总结一下。



type_traits 称为类型萃取技术，主要用于编译期获取某一参数、某一变量、某一个类等等任何 C++相关对象的类型，以及判断他们是否是某个类型，两个变量是否是同一类型，是否是标量、是否是引用、是否是指针、是左值还是右值，还可以将某个为某个类型去掉 cv(const volitale)属性或者增加 cv 属性等等。

#### SFINAE

SFINAE 技术，Substitution Failure is Not An Error，在编译期编译时，会将函数模板的形参替换为实参，如果替换失败编译器不会当作是个错误，直到找到那个最合适的特化版本，如果所有的模板版本都替换失败那编译器就会报错，以 `std::enable_if` 举个例子。


``` cpp
#include <iostream>
#include <type_traits>
using std::cout;using std::endl;
template <class T>auto func(T t) -> std::enable_if_t<std::is_same<int, std::remove_cv_t<T>>::value, int>
{    
  cout << "int" << endl;
}
template <class T>auto func(T t) -> std::enable_if_t<std::is_same<double, std::remove_cv_t<T>>::value, double>{    
  cout << "double" << endl;
}
int main(){    
  int a = 1;    
  double b = 2.9;    
  func(a);    
  func(b);
  // float c = 34.5;    
  // func(c);
  return 0;
}

```
编译运行：`g++ test.cc -std=c++14; ./a.outintdouble`

注释部分的代码如果打开就会编译失败，代码中明确规定了 func 函数只接收类型为 int 和 double 的参数，向 func 中传入其它类型参数编译器则会报错。



通过 SFINAE 技术可以完成很多有趣的事，比如根据参数类型做不同的定制化操作。

#### type_traits 原理

type_traits 最核心的结构体应该就是 integral_constant，它的源代码如下：


#### integral_constant
它的源代码如下：
``` cpp
template<typename _Tp, _Tp __v>    
struct integral_constant    {      
  static constexpr _Tp                  value = __v;      
  typedef _Tp                           value_type;      
  typedef integral_constant<_Tp, __v>   type;      
  constexpr operator value_type() const noexcept { return value; }      
  constexpr value_type operator()() const noexcept { return value; }    
};

typedef integral_constant<bool, true>     true_type;    
typedef integral_constant<bool, false>    false_type;
```
#### true_type 和 false_type
#### operator
基本上 type_traits 的每个功能都会使用到 true_type 和 false_type，后续会介绍，这里先介绍代码中那两个 operator 函数的具体含义，`operator value_type() const` 用于类型转换，而 `value_type operator()() const` 用于仿函数，见代码。



``` cpp
#include <iostream>#include <type_traits>
using std::cout;using std::endl;
class Test{
  public:    
  operator int() const    {       
     cout << "operator type const " << endl;        
     return 1;    
    }
  int operator()() const    {        
    cout << "operator()()" << endl;        
    return 2;    }
};
int main(){    
  Test t;    
  int x(t);    
  int xx = t;    
  t();    
  return 0;
}

```
编译运行：`g++ test.cc; ./a.outoperator type constoperator type constoperator()()`

#### conditional

还有个主要的模板是 conditional


``` cpp
template<bool, typename, typename>    struct conditional;
template<bool _Cond, typename _Iftrue, typename _Iffalse>    
struct conditional    { 
  typedef _Iftrue type; 
};
  // Partial specialization for false.  
template<typename _Iftrue, typename _Iffalse>    
struct conditional<false, _Iftrue, _Iffalse> { 
  typedef _Iffalse type; 
};
```


#### disjunction
当模板的第一个参数为 true 时 type 就是第二个参数的类型，当第一个参数为 false 时 type 就是第三个参数的类型，通过 conditional 可以构造出 or and 等功能，类似我们平时使用的带短路功能的|| &&，具体实现如下:



``` cpp
template<bool, typename, typename>    struct conditional;
template<typename...>    struct __or_;

template<>    
struct __or_<>    : public false_type    { 
};

template<typename _B1>    
struct __or_<_B1>    : public _B1    { 
};

template<typename _B1, typename _B2>    
struct __or_<_B1, _B2>: public conditional<_B1::value, _B1, _B2>::type    {
};

template<typename _B1, typename _B2, typename _B3, typename... _Bn>    
struct __or_<_B1, _B2, _B3, _Bn...>    : public conditional<_B1::value, _B1, __or_<_B2, _B3, _Bn...>>::type    { 
};

template<typename... _Bn>    
  struct disjunction    : __or_<_Bn...>    { };
```

#### disjunction demo


通过 disjunction 可以实现析取功能，type 为 B1, B2, B…中第一个 value 为 true 的类型。



``` cpp
// cpp reference中的示例代码
struct Foo {    
  template <class T>    
  struct sfinae_unfriendly_check {        
    static_assert(!std::is_same_v<T, double>);   
  };
  template <class T>    
  Foo(T, sfinae_unfriendly_check<T> = {});
};

template <class... Ts>
struct first_constructible {    
  template <class T, class... Args>    
  struct is_constructible_x : std::is_constructible<T, Args...> {        
    using type = T;    
  };    
  struct fallback {        
    static constexpr bool value = true;        
    using type = void;  // type to return if nothing is found    
  };
  template <class... Args>    
  using with = typename std::disjunction<is_constructible_x<Ts, Args...>..., fallback>::type;
};
// OK, is_constructible<Foo, double> not instantiatedstatic_assert(std::is_same_v<first_constructible<std::string, int, Foo>::with<double>, int>);
static_assert(std::is_same_v<first_constructible<std::string, int>::with<>, std::string>);
static_assert(std::is_same_v<first_constructible<std::string, int>::with<const char*>, std::string>);static_assert(std::is_same_v<first_constructible<std::string, int>::with<void*>, void>);
```


#### conjunction
再看看 conjunction 的实现


``` cpp
template<typename...>    struct __and_;
template<>    
struct __and_<>    : public true_type { };
template<typename _B1>    
struct __and_<_B1>    : public _B1    { };
template<typename _B1, typename _B2>    
struct __and_<_B1, _B2> : public conditional<_B1::value, _B2, _B1>::type    { 
};
template<typename _B1, typename _B2, typename _B3, typename... _Bn>    
struct __and_<_B1, _B2, _B3, _Bn...>    : public conditional<_B1::value, __and_<_B2, _B3, _Bn...>, _B1>::type    { 

};
template<typename... _Bn>    
struct conjunction    : __and_<_Bn...> { 
};
```

#### conjunction demo

通过 conjunction 可以判断函数的参数类型是否相同，代码如下：



``` cpp
#include <iostream>
#include <type_traits>
// func is enabled if all Ts... have the same type as T
template <typename T, typename... Ts>
std::enable_if_t<std::conjunction_v<std::is_same<T, Ts>...>> func(T, Ts...) {    
  std::cout << "all types in pack are T\n";
}

// otherwise
template <typename T, typename... Ts>
std::enable_if_t<!std::conjunction_v<std::is_same<T, Ts>...>> func(T, Ts...) {    
  std::cout << "not all types in pack are T\n";
}
int main() {    
  func(1, 2, 3);    
  func(1, 2, "hello!");
}
```
输出：all types in pack are Tnot all types in pack are T



#### is_const demo

再举一些平时用的很多的例子，还可以判断某个类型是否有 const 属性，添加去除某个类型的左值引用或者右值引用，添加去除某个类型的 const 或者 volatile。



``` cpp
#include <iostream>
#include <type_traits>
int main(){    
  std::cout << std::boolalpha;    
  std::cout << std::is_const<int>::value << '\n'; // false    
  std::cout << std::is_const<const int>::value  << '\n'; // true    
  std::cout << std::is_const<const int*>::value  << '\n'; // false    
  std::cout << std::is_const<int* const>::value  << '\n'; // true    
  std::cout << std::is_const<const int&>::value  << '\n'; // false
}
```
#### is_const
is_const 实现很简单，就是利用模板匹配特性，其它的 is_volatile 等类似



``` cpp
template<typename>    
struct is_const    : public false_type { 
};
template<typename _Tp>    
struct is_const<_Tp const>    : public true_type { };
```

#### is_same
is_same 的实现如下：



``` cpp
template<typename, typename>    
struct is_same    : public false_type { };
template<typename _Tp>    
struct is_same<_Tp, _Tp>    : public true_type { };
```

#### remove_reference
包括移除引用的功能, remove_reference


``` cpp
 /// remove_reference  
template<typename _Tp>    
struct remove_reference    { 
  typedef _Tp   type; 
};

template<typename _Tp>    
struct remove_reference<_Tp&>    { 
  typedef _Tp   type; 
};
template<typename _Tp>    
struct remove_reference<_Tp&&>    { 
  typedef _Tp   type; 
};

// C++14之后这种xxx_t=xxx::type  

template<typename _Tp>    using remove_reference_t = typename remove_reference<_Tp>::type;
```




#### add_const

add_const, add_volatile, add_cv 等的实现



``` cpp
template<typename _Tp>    
struct add_const    { 
  typedef _Tp const     type; 
};

/// add_volatile  
template<typename _Tp>    
struct add_volatile    { typedef _Tp volatile     type; };

/// add_cv 
template<typename _Tp>    
struct add_cv    {      
  typedef typename  add_const<typename add_volatile<_Tp>::type>::type     type;    
};
```

欢迎私信或评论，我每天都会上线。


发布于: 2020 年 05 月 09 日阅读数: 1359

版权声明: 本文为 InfoQ 作者【圣保罗爷爷】的原创文章。

原文链接:【<https://xie.infoq.cn/article/79719d0662ed5ac40bbdd6d5f>】。文章转载请联系作者。