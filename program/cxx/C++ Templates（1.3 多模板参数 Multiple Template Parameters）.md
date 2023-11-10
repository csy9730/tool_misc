# [C++ Templates（1.3 多模板参数 Multiple Template Parameters）](https://www.cnblogs.com/kaycharm/p/13449273.html)

[返回完整目录](https://www.cnblogs.com/kaycharm/p/13433381.html#第一部分章节目录)



目录

- 1.3 多模板参数 Multiple Template Parameters
  - [1.3.1 为返回类型设置模板参数参数 Template Parameters for Return Types](https://www.cnblogs.com/kaycharm/p/13449273.html#131-为返回类型设置模板参数参数-template-parameters-for-return-types)
  - [1.3.2 推断返回类型 Deducing the Return Type](https://www.cnblogs.com/kaycharm/p/13449273.html#132-推断返回类型-deducing-the-return-type)
  - [1.3.3 使用共同类型作为返回类型 Return Type as Common Type](https://www.cnblogs.com/kaycharm/p/13449273.html#133-使用共同类型作为返回类型-return-type-as-common-type)



# 1.3 多模板参数 Multiple Template Parameters

**函数模板（function template）**有两种类型的参数：

1. **模板参数（Template Parameter）**：模板参数在尖括号里声明，在函数模板名字前面

```cpp
template <typename T>      // T 是模板参数
```

1. **调用参数（Call Parameter）**:调用参数在圆括号中声明，在函数模板名字后面

```cpp
T max(T a, T b)      // a和b是调用参数
```

模板参数的数量没有限制，比如可以为`max()`模板的调用参数设置两种可能不同类型：

```cpp
template <typename T1, typename T2>
T1 max(T1 a, T2 b)
{
      return b < a ? a : b;
}
...
auto m = ::max(4, 7.2);      //OK，但是函数返回类型为第一个实参的类型
```

将不同类型的参数传递给`max()`模板看似合理，但该例子显示，这将引起一个问题。如果将一个参数类型作为返回类型，另外一个调用参数可能会转化为返回值类型，不管调用者是否有该意图。66.66和42的最大值将是double类型66.66，42和66.66的最大值为int类型的66。

C++提供了不同的方法来处理这个问题：

- 为返回值引入第三个模板参数；
- 让编译器确定返回值类型；
- 将返回值类型声明为两个参数类型的**“共同类型（common type）”**。

后续将详细讨论这些选择。

## 1.3.1 为返回类型设置模板参数参数 Template Parameters for Return Types

之前的讨论已经提到：**模板实参推断（template argument deduction）**使得调用函数模板和普通函数可以具有一样的语法形式，不需要显式指定模板参数的类型。

当然也可以显式指定模板参数的类型：

```cpp
template <typename T>
T max(T a, T b);
...
::max<double>(4, 7.2);      // 将T实例化为double类型
```

当模板参数和调用参数之间没有联系，模板参数不能确定时，必须在调用时显式指定模板实参类型。比如，可以引入第三个模板参数类型来定义函数模板的返回类型：

```cpp
template <typename T1, typename T2, typename RT>
RT max(T1 a, T2 b);
```

此时，模板实参推断将不会考虑返回类型[[1\]](https://www.cnblogs.com/kaycharm/p/13449273.html#fn1)，RT没有出现在函数调用参数的类型中。因此RT无法被推断[[2\]](https://www.cnblogs.com/kaycharm/p/13449273.html#fn2)。

后果便是必须显式指定模板实参列表，如：

```cpp
template <typename T1, typename T2, typename RT>
RT max(T1 a, T2 b);
...
::max<int, double, double>(4, 7.2);      //OK，但是很啰嗦
```

到目前为止，已经覆盖了“显式指定所有函数模板实参类型”或者“完全不指定函数模板实参类型”两种情形。另外一种情形是显式指定第一个模板实参类型，而让编译器推断剩余的模板参数类型。但通常需要显式指定无法隐式地推断类型的最后一个模板参数之前的所有参数类型。如果改变上述例子中模板参数的顺序，
调用者仅需显式指定返回类型：

```cpp
template <typename RT, typename T1, typename T2>
RT max(T1 a, T2 b);
...
::max<double>(4, 7.2);      //OK，返回类型为double，T1和T2类型推断而得
```

本例中，调用`max`将显式设置RT的类型为double，参数T1和T2将从调用实参中推断为int和double类型。

注意到这些`max()`的变体并没有带来很大的优势。单参数版本中，如果传入两个不同实参，已经可以确定参数和返回类型了。因此，为保持简洁，使用单参数版本的`max()`将是个好主意（在后续的几个小节中，讨论其他几个模板问题时，也遵循简洁）。

推断过程的详细介绍见第15章。

## 1.3.2 推断返回类型 Deducing the Return Type

如果返回类型依赖于模板参数，最简单也是最好的方法便是让编译器推断返回类型。从C++14起，可以不需要声明任何返回类型（但需要将返回类型声明为auto）:

```cpp
//basics/maxauto.hpp

template <typename T1, typename T2>
auto max(T1 a, T2 b)
{
      return b < a ? a : b;
}
```

事实上，使用auto作为返回类型并且不使用**尾置返回类型（trailing return turn type）**意味着**真实返回类型必须从函数体中的返回语句中推断**。当然从函数体中推断返回类型必须是可行的。因此，必须提供相应的返回语句并且多个返回语句必须匹配。

C++14以前，让编译器确定返回类型只能或多或少地让函数体的部分实现成为函数声明的一部分。在C++11中，可以使用尾置返回类型语法来使用函数调用参数。也就是说，可以声明返回类型从运算**operator ? :**中推导：

```cpp
//basics/maxdecltype.hpp

template <typename T1, typename T2>
auto max(T1 a, T2 b) -> decltype(b<a?a:b)
{
      return b < a ? a : b;
}
```

此处，返回类型由算子`operator ? :`的规则决定，这相当详尽但是通常会产生直观的所期望的结果（比如，如果 a 和 b有不同的算术类型，会寻找一个共同的算术类型作为结果）。

值得注意的是，

```cpp
template <typename T1, typename T2>
auto max(T1 a, T2 b) -> decltype(b<a?a:b);
```

是一个声明，编译器使用运算**operator ? : \**的规则来使用参数a和b，在编译期寻找`max()`的返回类型。实现并不一定要匹配。事实上，使用\**true**作为声明中运算**operator ? :**的条件就足够了：

```cpp
template <typename T1, typename T2>
auto max(T1 a, T2 b) -> decltype(true?a:b);
```

然而，任何情况下该定义都有一个重要的缺陷：返回类型可能是引用类型，因为部分场景下T可能是引用。基于这个原因，函数应该返回T的decay类型，如下：

```cpp
// basics/maxdecltypedecay.hpp

#include <type_traits>

template <typename T1, typename T2>
auto max(T1 a, T2 b) -> typename std::decay<decltype(true ? a: b)>::type
{
      return b < a ? a : b;
}
```

此处，使用了**类型特性（type traits）**并返回其**成员类型（member type）**，它定义在标准库中的<type_traits>中（详见补充D.4中）。由于成员类型也是类型，需要用关键字typename限定该表达式以访问（详见5.1节）。

需要注意的是，auto的初始类型总是退化（decay）的，这也适用于当返回类型仅仅包含auto的情形。auto作为返回类型时和如下代码的行为一致，其中a被声明为类型i的退化类型，即int：

```cpp
int i = 42;
int const& ir = i; // ir 指向 i 
auto a = ir;  // a 被声明为一个新的对象，其类型为int
```

## 1.3.3 使用共同类型作为返回类型 Return Type as Common Type

自从C++11起，C++标准库提供了一种方法指定选择“**更通用的类型（the more general type）**”。`std::common_type<>::type`推导两种或者更多种不同类型的共同类型，通过传递模板参数。比如：

```cpp
//basics/maxcommon.hpp

#include <type_traits>

template <typename T1, typename T2>
std::common_type<T1, T2> max(T1 a, T2 b)
{
      return b < a? a : b;
}
```

如前，**std::common_type**也是类型特性，定义在<type_traits>中，它将会推导出一个数据结构包含一个类型成员，指示得到的类型。因此，它的核心使用方法如下：

```cpp
typename std::common_type<T1, T2>::type      //从C++11起
```

然而，自从C++14起，可以简化特性的使用方式：在类型名称后面添加**_t**并且不需要**typename**关键字和**::type**类型成员（详见2.8节）。因此，返回类型定义可以简化为：

```cpp
std::common_type_t<T1, T2>      //等价方式，从C++14起
```

`std::common_type<>`的实现使用了模板编程的一些技巧，这将在第26.5.2中讨论。在内部，它根据运算**operator ? :**的语言规则选择最终类型或者特化特定的类型（specialization of specific type）。因此，`::max(4, 7.2)`和`::max(7.2, 4)`得到值7.2，类型为double。注意，`std::common_type<>`也会退化（decay）。详见附录D.5节。

**脚注**

------

1. 推断可以视为重载解析的一部分——同样也是一个不考虑返回类型的过程。唯一例外的是类型转换操作成员函数的返回类型（The sole exception is the return type of conversion operator members）。 [↩︎](https://www.cnblogs.com/kaycharm/p/13449273.html#fnref1)
2. C++中，返回类型不能从调用者调用的上下文中推断出返回类型。 [↩︎](https://www.cnblogs.com/kaycharm/p/13449273.html#fnref2)

分类: [C++ Templates](https://www.cnblogs.com/kaycharm/category/1821900.html)

标签: [C++](https://www.cnblogs.com/kaycharm/tag/C%2B%2B/)