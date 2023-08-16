# 用variant实现多态

[![程序喵大人](https://pic1.zhimg.com/1360b56d4f4f01b6acdb8f390131802c_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/chengxumiao)

[程序喵大人](https://www.zhihu.com/people/chengxumiao)







40 人赞同了该文章

大家应该都知道C++17引入了variant，这篇文章我们来研究下它究竟有啥用。

**本期目录**

- variant是什么？
- 为什么要引入variant？
- 如何确定variant中当前存放的数据类型？
- variant为什么要搭配monostate？
- 如何用variant实现多态？

variant这货类似于union，可以存放多种类型的数据，但任何时刻最多只能存放其中一种类型。

这里大家可能有些疑问，既然有了union，那为啥还要引入variant呢？

那肯定是因为union有缺点呗。

看这段union的基本用法：

```cpp
union MyUnion {
    int a;
    float b;
    double c;
};

void test_simple_union() {
    MyUnion u;
    u.a = 1;
    std::cout << u.a << "\n";

    u.b = 1.32f;
    std::cout << u.b << "\n";

    u.c = 2.32;
    std::cout << u.c << "\n";
}
```

union貌似也只能这么使用，没有其他方法。

这里有一个很重要的点，我**没法获取当前存储的数据是什么类型**，比如我当前存储的是float，但是却按int方式获取，这不就坏事了吗。

再看一段代码：

```cpp
struct A {
    A() = default;
    A(int aa) : a{aa} { std::cout << "A() \n"; }
    ~A() { std::cout << "~A() \n"; }
    int a;
};

struct B {
    B() = default;
    B(float bb) : b{bb} { std::cout << "B() \n"; }
    ~B() { std::cout << "~B() \n"; }
    float b;
};

union MyStructUnion {
    A a;
    B b;
    /**
     * @brief 在析构函数中我要做什么？不知道当前类型究竟是A还是B
     * 那调用 a.~A() 还是 b.~B() ?
     */
    ~MyStructUnion() { std::cout << "~MyStructUnion() \n"; }
};

/**
 * @brief 需要手动调用析构函数
 *
 */
void test_struct_union() {
    MyStructUnion u;

    new (&u.a) A(1);
    std::cout << u.a.a << "\n";
    u.a.~A();

    u.b = B(2.3f);
    std::cout << u.b.b << "\n";
    u.b.~B();
}
```

这里可以看到，**union无法自动处理构造和析构等逻辑**，它需要用户手动调用相关函数才行，这就导致使用它union存储自定义类型时特别麻烦。

所以，variant诞生：

```cpp
struct C {
    C() = default;
    C(std::string cc) : c{cc} { std::cout << "C() \n"; }
    ~C() { std::cout << "~C() \n"; }
    std::string c;
};

/**
 * @brief 使用variant完全不需要手动调用构造和析构函数，它会自动处理好所有逻辑，非常方便
 *
 */
void test_variant() {
    std::variant<std::monostate, A, C> u; ///< 下面很快就会介绍monostate
    u = 1;
    std::cout << std::get<A>(u).a << "\n";
    u = std::string("dsd");
    std::cout << std::get<C>(u).c << "\n";
}
```

使用variant完全不需要手动调用构造和析构函数，它会自动处理好所有逻辑，非常方便。

这里还遗留个问题，即如何判断variant内部当前存储的数据是什么类型？别着急，后面会介绍。

在这之前还需要介绍个知识点：**monostate**。

首先，普通的variant使用方法如下：

```cpp
void test_variant() {
    std::variant<int, float> var;
    var = 12;
    std::cout << std::get<int>(var) << "\n";
    var = 12.1f;
    std::cout << std::get<float>(var) << "\n";
}
```

这也是常规的variant使用方法。那我如果存储个自定义类型呢？

```cpp
struct S {
    S(int i) : value{i} {}
    int value;
};

void test_monostate2() {
    ///< 编译失败，S如果没有构造函数，需要加monostate
    std::variant<S> var;
    var = 12;
    std::cout << std::get<S>(var).value << "\n";
}
```

这里会编译失败，因为S没有无参默认构造函数，无法默认直接声明，所以这里需要加个monostate，表示默认情况下它的存储类型就是monostate。

然后可以这样使用：

```cpp
struct S {
    S(int i) : value{i} {}
    int value;
};

void test_monostate() {
    std::variant<std::monostate, S> var;
    var = 12;
    std::cout << std::get<S>(var).value << "\n";
}
```

那如何获取variant内部存储的类型呢？

其实variant有一个index()方法可以做到。

看这段代码：

```cpp
void test_index() {
    std::variant<std::monostate, int, float, std::string> var; ///< 默认index是0
    var = 1;
    std::cout << var.index() << "\n"; ///< 1
    var = 2.90f;
    std::cout << var.index() << "\n"; ///< 2
    var = std::string("hello world");
    std::cout << var.index() << "\n"; ///< 3
}
```

在定义variant结束后，我们就会知道内部类型的index，然后在运行时我们就可以动态的获取当前var的index，进而确定内部数据的类型。

难道我们每次都要手动记录下variant内部数据类型的index吗？如果将来有一天我们要在中间新增数据类型，岂不是之前建立的index都错乱了。

这里可以使用可变参数模板+模板元编程的小技巧，看下面这段代码：

```cpp
template <typename T, typename>
struct get_index;

template <size_t I, typename... Ts>
struct get_index_impl {};

template <size_t I, typename T, typename... Ts>
struct get_index_impl<I, T, T, Ts...> : std::integral_constant<size_t, I> {};

template <size_t I, typename T, typename U, typename... Ts>
struct get_index_impl<I, T, U, Ts...> : get_index_impl<I + 1, T, Ts...> {};

template <typename T, typename... Ts>
struct get_index<T, std::variant<Ts...>> : get_index_impl<0, T, Ts...> {};

template <typename T, typename... Ts>
constexpr auto get_index_v = get_index<T, Ts...>::value;

using variant_t = std::variant<std::monostate, int, float, std::string>;

constexpr static auto kPlaceholderIndex = get_index_v<std::monostate, variant_t>;
constexpr static auto kIntIndex = get_index_v<int, variant_t>;
constexpr static auto kFloatIndex = get_index_v<float, variant_t>;
constexpr static auto kStringIndex = get_index_v<std::string, variant_t>;
```

通过get_index_v，我就可以知道数据类型在variant中的index，以后即使有改动也不需要担心，它都会自动处理。再贴一段它的测试代码：

```cpp
void test_using_index() {
    std::cout << "kPlaceholderIndex " << kPlaceholderIndex << "\n";
    std::cout << "kIntIndex " << kIntIndex << "\n";
    std::cout << "kFloatIndex " << kFloatIndex << "\n";
    std::cout << "kStringIndex " << kStringIndex << "\n";

    auto custom_visitor = [](const auto& value) {
        switch (value.index()) {
            case kPlaceholderIndex:
                std::cout << "placehodler value "
                          << "\n";
                break;
            case kIntIndex:
                std::cout << "int value " << std::get<int>(value) << "\n";
                break;
            case kFloatIndex:
                std::cout << "float value " << std::get<float>(value) << "\n";
                break;
            case kStringIndex:
                std::cout << "string value " << std::get<std::string>(value) << "\n";
                break;
        }
    };
    variant_t var;
    custom_visitor(var);

    var = 1;
    custom_visitor(var);

    var = 2.90f;
    custom_visitor(var);

    var = std::string("hello world");
    custom_visitor(var);

    var = std::string("hello type");
}

int main() { test_using_index(); }
```

结果在这：

```cpp
kPlaceholderIndex 0
kIntIndex 1
kFloatIndex 2
kStringIndex 3
placehodler value
int value 1
float value 2.9
string value hello world
```

是不是很方便？

其实上面的代码，个人认为它也是一种多态，尽管它就是一个普通的switch-case，然而，我们可以使用std::visit稍微改装一下。

那std::visit怎么用？看这段代码：

```cpp
struct Visitor {
    void operator()(int i) const { std::cout << "int " << i << "\n"; }

    void operator()(float f) const { std::cout << "float " << f << "\n"; }

    void operator()(std::string s) const { std::cout << "string " << s << "\n"; }
};

void test_visitor_functor() {
    std::variant<int, float, std::string> var;
    var = 1;
    std::visit(Visitor(), var);
    var = 2.90f;
    std::visit(Visitor(), var);
    var = std::string("hello world");
    std::visit(Visitor(), var);
}

// 输出
int 1
float 2.9
string hello world
```

visit内部会自动判断当前variant内部存储的类型，进而触发不同的行为。

上面是使用仿函数搭配的visit，其实使用lambda表达式更方便：

```cpp
void test_visitor_lambda() {
    std::variant<int, float, std::string> var;
    var = 1;
    std::visit([](const auto& value) { std::cout << "value " << value << "\n"; }, var);
    var = 2.90f;
    std::visit([](const auto& value) { std::cout << "value " << value << "\n"; }, var);
    var = std::string("hello world");
    std::visit([](const auto& value) { std::cout << "value " << value << "\n"; }, var);
    var = std::string("hello type");
    std::visit(
        [](const auto& value) {
            using T = std::decay_t<decltype(value)>;
            if constexpr (std::is_same_v<T, int>) {
                std::cout << "int value " << value << "\n";
            } else if constexpr (std::is_same_v<T, float>) {
                std::cout << "float value " << value << "\n";
            } else if constexpr (std::is_same_v<T, std::string>) {
                std::cout << "string value " << value << "\n";
            }
        },
        var);
}

// 输出
value 1
value 2.9
value hello world
string value hello type
```

看到这里大家应该也悟到了，可以使用std::visit搭配variant来实现多态。

下面是我写的几个variant的多态示例：

```cpp
struct A {
    void func() const { std::cout << "func A \n"; }
};

struct B {
    void func() const { std::cout << "func B \n"; }
};

struct CallFunc {
    void operator()(const A& a) { a.func(); }
    void operator()(const B& b) { b.func(); }
};

void test_no_param_polymorphism() {
    std::variant<A, B> var;
    var = A();
    std::visit(CallFunc{}, var);
    var = B();
    std::visit(CallFunc{}, var);
}
```

上面的是没有参数的多态，那如果想为函数添加一些参数怎么办？

可以利用仿函数中的成员变量，即：

```cpp
struct C {
    void func(int value) const { std::cout << "func C " << value << "\n"; }
};

struct D {
    void func(int value) const { std::cout << "func D " << value << "\n"; }
};

struct CallFuncParam {
    void operator()(const C& c) { c.func(value); }
    void operator()(const D& d) { d.func(value); }

    int value;
};

void test_param_polymorphism() {
    std::variant<C, D> var;
    var = C();
    std::visit(CallFuncParam{1}, var);
    var = D();
    std::visit(CallFuncParam{2}, var);
}
```

或者lambda表达式的捕获方式，即：

```cpp
void test_param_lambda_polymorphism() {
    std::variant<C, D> var;
    int value = 1;
    auto caller = [&value](const auto& v) { v.func(value); };
    std::visit(caller, var);
    value = 2;
    std::visit(caller, var);
}
```

到这里已经介绍了variant实现多态的完整方案。

认为继承是个洪水猛兽的朋友，其实也可以考虑variant来实现多态的行为哈。

那同样是实现多态，是用继承好呢，还是用variant好呢？可以看这个图：

![img](https://pic1.zhimg.com/80/v2-afde90da6d635a092d2ad5e7cae7395c_720w.jpg)

图片来源于这个链接：[http://cpptruths.blogspot.com/2018/02/inheritance-vs-stdvariant-based.html](https://link.zhihu.com/?target=http%3A//cpptruths.blogspot.com/2018/02/inheritance-vs-stdvariant-based.html)。大家感兴趣的可以直接移步哈。

另外大家应该也比较感兴趣variant是如何实现的。关于如何实现variant，我找到了这篇文章，写的很不错，大家可以看看：[https://www.cnblogs.com/qicosmos/p/3416432.html](https://www.cnblogs.com/qicosmos/p/3416432.html)

下面是本文参考链接：

- [https://www.cppstories.com/2020/04/variant-virtual-polymorphism.html/](https://www.cppstories.com/2020/04/variant-virtual-polymorphism.html/)
- [https://stackoverflow.com/questions/52296889/what-are-the-advantages-of-using-stdvariant-as-opposed-to-traditional-polymorp](https://stackoverflow.com/questions/52296889/what-are-the-advantages-of-using-stdvariant-as-opposed-to-traditional-polymorp)
- [https://www.cppstories.com/2018/06/variant/](https://www.cppstories.com/2018/06/variant/)
- [http://cpptruths.blogspot.com/2018/02/inheritance-vs-stdvariant-based.html](https://link.zhihu.com/?target=http%3A//cpptruths.blogspot.com/2018/02/inheritance-vs-stdvariant-based.html)

打完收工。

完整代码见：

[https://github.com/chengxumiaodaren/cpp-learning/tree/master/src/variant](https://github.com/chengxumiaodaren/cpp-learning/tree/master/src/variant)

![img](https://pic3.zhimg.com/80/v2-55b08fe6962d25c3e7cf43d544436866_720w.jpg)



发布于 2022-02-14 18:55

C / C++

多态

面向对象编程