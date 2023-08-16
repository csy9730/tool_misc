# C++20尝鲜：<=>三路比较运算符(Three-way comparison)

[![我是小小怪](https://pic1.zhimg.com/v2-82875782d4282afe576acedb07e37eeb_l.jpg?source=172ae18b)](https://www.zhihu.com/people/ping-mian-she-ji-xiao-guai-shou)

[我是小小怪](https://www.zhihu.com/people/ping-mian-she-ji-xiao-guai-shou)

5 人赞同了该文章

三路比较运算符 <=> 也被称为宇宙飞船运算符(spaceship operator)。

三路比较运算符表达式的形式为：

*左操作数***<=>***右操作数*

## 为什么引入

如果项目中使用struct的值用作std::map的key，因此就需要自己实现比较运算符。如果实现得不对（可能会出现自相矛盾，a < b 且 b < a），程序可能会崩溃。

```cpp
struct Name {
  string first_name;
  string mid_name;
  string last_name;
};
//C++11前
bool operator<(const Name& other) const {
  return first_name<other.first_name
      || first_name == other.first_name && mid_name < other.mid_name
      || first_name == other.first_name && mid_name == other.mid_name && last_name < other.last_name;
}
   //C++11后
bool operator<(const Name& other) const {
  return std::tie(first_name, mid_name, last_name) < 
      std::tie(other.first_name, other.mid_name, other.last_name);
}
//C++20
struct Name {
  string first_name;
  string mid_name;
  string last_name;
  //编译器默认实现，注入语义，强序
  std::strong_ordering operator<=>(const Name&) const = default;
};
```

**在C++17, 需要 18 比较函数：**

```cpp
class CIString {
  string s;
public:
  friend bool operator==(const CIString& a, const CIString& b) {
    return a.s.size() == b.s.size() &&
      ci_compare(a.s.c_str(), b.s.c_str()) == 0;
  }
  friend bool operator< (const CIString& a, const CIString& b) {
    return ci_compare(a.s.c_str(), b.s.c_str()) <  0;
  }
  friend bool operator!=(const CIString& a, const CIString& b) {
    return !(a == b);
  }
  friend bool operator> (const CIString& a, const CIString& b) {
    return b < a;
  }
  friend bool operator>=(const CIString& a, const CIString& b) {
    return !(a < b);
  }
  friend bool operator<=(const CIString& a, const CIString& b) {
    return !(b < a);
  }

  friend bool operator==(const CIString& a, const char* b) {
    return ci_compare(a.s.c_str(), b) == 0;
  }
  friend bool operator< (const CIString& a, const char* b) {
    return ci_compare(a.s.c_str(), b) <  0;
  }
  friend bool operator!=(const CIString& a, const char* b) {
    return !(a == b);
  }
  friend bool operator> (const CIString& a, const char* b) {
    return b < a;
  }
  friend bool operator>=(const CIString& a, const char* b) {
    return !(a < b);
  }
  friend bool operator<=(const CIString& a, const char* b) {
    return !(b < a);
  }

  friend bool operator==(const char* a, const CIString& b) {
    return ci_compare(a, b.s.c_str()) == 0;
  }
  friend bool operator< (const char* a, const CIString& b) {
    return ci_compare(a, b.s.c_str()) <  0;
  }
  friend bool operator!=(const char* a, const CIString& b) {
    return !(a == b);
  }
  friend bool operator> (const char* a, const CIString& b) {
    return b < a;
  }
  friend bool operator>=(const char* a, const CIString& b) {
    return !(a < b);
  }
  friend bool operator<=(const char* a, const CIString& b) {
    return !(b < a);
  }
};
```

**在C++20, 只需要4个：**

```cpp
class CIString {
  string s;
public:
  bool operator==(const CIString& b) const {
    return s.size() == b.s.size() &&
      ci_compare(s.c_str(), b.s.c_str()) == 0;
  }
  std::weak_ordering operator<=>(const CIString& b) const {
    return ci_compare(s.c_str(), b.s.c_str()) <=> 0;
  }

  bool operator==(char const* b) const {
    return ci_compare(s.c_str(), b) == 0;
  }
  std::weak_ordering operator<=>(const char* b) const {
    return ci_compare(s.c_str(), b) <=> 0;
  }
};
```

## 类似strcmp用法

三路比较运算结果支持用表达式 a <=> b == 0 或 a <=> b < 0 将转换三路比较的结果为布尔关系。

```cpp
#include <compare>
#include <iostream>
 
int main(int argc, char *argv[]) {
    double val1 = -1.0;
    double val2 = 1.0;
 
    auto res = val1 <=> val2; //三路比较
 
    if (res < 0)
        std::cout << "val1 小于 val2";
    else if (res > 0)
        std::cout << "val1 大于 val2";
    else // (res == 0)
        std::cout << "val1 与 val2 相等";
    return 0;
}
```

## 缺省比较

- 对于如下运算符：<、<=、>=、>， 如果<=>没有被定义，则这些运算符的默认实现即是将它们声明为deleted；否则，这些运算符将通过调用并判断<=>的返回值以确定两个操作数的大小关系。
- 对于!=运算符：如果==没有被定义，则!=的默认实现即是将它声明为deleted；否则，!=的默认实现将调用==并将其返回值逻辑求反作为!=的返回值。



|      |
| ---- |
|      |
|      |



```cpp
#include <compare>
#include <iostream>
 
template<typename T1, typename T2>
void TestComparisons(T1 a, T2 b)
{
    //测试<=>
    (a < b), (a <= b), (a > b), (a >= b);
    //测试 ==
    (a == b), (a != b);
}

struct S2
{
    int a;
    int b;
};

struct S1
{
    int x;
    int y;
    // 生成默认的
    auto operator<=>(const S1&) const = default;
    bool operator==(const S1&) const = default;
    // 实现S2
    std::strong_ordering operator<=>(const S2& other) const
    {
        if (auto cmp = x <=> other.a; cmp != 0)
            return cmp;
        return y <=> other.b;
    }

    bool operator==(const S2& other) const
    {
        return (*this <=> other) == 0;
    }
};

int main(int argc, char *argv[]) {
   TestComparisons(S1{}, S1{});
   TestComparisons(S1{}, S2{});
   TestComparisons(S2{}, S1{});
   return 0;
}
```

## 比较的类别（序关系）

- std::partial_ordering，表示**偏序关系**；

在偏序关系中，两个值可能会存在序关系，但并非任意两个值都存在序关系。

```cpp
#include <iostream>
#include <cstdlib>
#include <cassert>
#include <limits>
#include <cmath>
 
int main()
{
    double a = 1.0;
    double b = 2.0;
    double c = std::numeric_limits<double>::quiet_NaN();
    //double比较是弱序
    std::partial_ordering ordering1 = a <=> b;;
    assert(ordering1 == std::partial_ordering::less);  // a < b

    std::partial_ordering ordering2 = b <=> a;
    assert(ordering2 == std::partial_ordering::greater);  // a > b

    std::partial_ordering ordering3 = a <=> c;
    assert(ordering3 == std::partial_ordering::unordered);  // NaN does not have partial ordering
}
```

浮点值之间的内建运算符 <=> 使用此顺序：正零与负零比较为 equivalent ，但能辨别，而 NaN 值与任何其他值比较为 unordered 。

- std::weak_ordering，表示**弱序关系**。

在弱序关系中，任意的两个值都存在序关系，可以比较大小。但序关系为相等的两个值**不一定是不可辨别**的。

```cpp
// This file is a "Hello, world!" in C++ language by GCC for wandbox.
#include <iostream>
#include <cassert>
#include <string>
#include <algorithm>

struct Name {
    std::string name;
    //std::weak_ordering  operator<=>(const Name&) const = default;
};
std::weak_ordering operator<=>(const Name& lhs, const Name& rhs) noexcept {
    std::string s1 = lhs.name;
    std::transform(s1.begin(), s1.end(), s1.begin(),
                   [](unsigned char c){ return std::tolower(c); });
    std::string s2 = rhs.name;
    std::transform(s2.begin(), s2.end(), s2.begin(),
                   [](unsigned char c){ return std::tolower(c); });    

    return s1 <=> s2;
}

int main()
{
    Name a = {"WU"};
    Name b = {"wu"};
    std::weak_ordering ordering = a <=> b;
    assert(ordering == std::weak_ordering::equivalent);  // a == b
}
```

一个弱序类型的例子是 CaseInsensitiveString（大小写忽略字符串），它可以按原样存储原始字符串，但是以不区分大小写的方式比较。

- std::strong_ordering，表示**强序关系**。

在强序关系中，任意的两个值都存在序关系，可以比较大小。序关系为相等的两个值是**不可辨别**的。

```cpp
#include <iostream>
#include <cstdlib>
#include <cassert>
#include <limits>
#include <cmath>

int main()
{
    int a = 1;
    int b = 2;
    int c = 2;
    //int 比较是强序
    std::strong_ordering ordering = a <=> b;
    assert(ordering == std::strong_ordering::less);  // a < b

    ordering = b <=> c;
    assert(ordering == std::strong_ordering::equivalent);  // b = c
```



发布于 2021-06-22 14:22

[C++20](https://www.zhihu.com/topic/20744508)