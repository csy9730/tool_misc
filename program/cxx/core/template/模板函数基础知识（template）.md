# 模板函数基础知识（template）

首先，我们为什么要使用模板函数？原因就是想避免重复写代码。比如可以利用重载实现“将一个数乘以2”这个功能。
那么模板函数是怎么定义的呢？来看个例子：

```cpp
#include <iostream>

template <class T>
T twice(T t) {
    return t * 2;
}

int main() {
    std::cout << twice<int>(21) << std::endl;
    std::cout << twice<float>(3.14f) << std::endl;
    std::cout << twice<double>(2.718) << std::endl;
}
```

- 使用 `template <class T>` or `template <typename T>`
- 其中 T 可以变成任意类型。
- 调用时 `twice<int>` 即可将 T 替换为 int

在上面的例子中，我们需要手写`<int>`，`<float>`，很麻烦，但其实模板函数支持自动推导参数类型，当模板类型参数 T 作为函数参数时，则可以省略该模板参数。自动根据调用者的参数判断。所以可以直接写成下面这种。

```cpp
int main() {
    std::cout << twice(21) << std::endl;
    std::cout << twice(3.14f) << std::endl;
    std::cout << twice(2.718) << std::endl;
}
```



#### 模板特化

但有时候，一个统一的实现（比如 t * 2）满足不了某些特殊情况。比如 std::string 就不能用乘法来重复，这时候我们需要用 t + t 来替代，怎么办呢？没关系，只需添加一个 `twice(std::string)` 即可，他会自动和已有的模板 `twice<T>(T)` 之间相互重载。这就是模板函数中一个很重要的概念：特化的重载

```cpp
#include <iostream>

template <class T>
T twice(T t) {
    return t * 2;
}

std::string twice(std::string t) {
    return t + t;
}

int main() {
    std::cout << twice(21) << std::endl;
    std::cout << twice(3.14f) << std::endl;
    std::cout << twice(2.718) << std::endl;
    std::cout << twice("hello") << std::endl; // 会报错哦
}

//error: invalid operands of types ‘const char*’ and ‘int’ to binary ‘operator*’
//     return t * 2;
```

但是这样也有一个问题，那就是如果我用 `twice(“hello”)` 这样去调用，他不会自动隐式转换到 std::string 并调用那个特化函数，而是会去调用模板函数 `twice<char *>(“hello”)`，从而出错。怎么解决呢？方法就是使用SFINAE，SFINAE 是 substitution failure is not an error 的缩写，即匹配失败不是错误。就是说，匹配重载的函数 / 类时如果匹配后会引发编译错误，这个函数/类就不会作为候选。这是一个 C++11 的新特性，也是 enable_if 最核心的原理。

```cpp
#include <iostream>

template <class T, typename = typename std::enable_if<!std::is_pointer<T>::value, void>::type>
T twice(T t)
{
    return t * 2;
}

std::string twice(std::string t)
{
    return t + t;
}

int main() {
    std::string s{"hello"};
    std::cout << twice<int>(21) << std::endl;
    std::cout << twice(3.14f) << std::endl;
    std::cout << twice(2.718) << std::endl;
    std::cout << twice("hello") << std::endl;
    std::cout << twice(s) << std::endl;
}
```

上面就是使用了SFINAE，在重载匹配时，会判断T是不是个pointer，如果不是才重载第一个，否则继续去匹配其他的。

接下来我们用一个有趣的例子来解释模板函数的默认参数类型。在下面这个例子中，如果模板类型参数 T 没有出现在函数的参数中，那么编译器就无法推断，就不得不手动指定了。

```cpp
#include <iostream>

template <class T = int>
T two() {
    return 2;
}

int main() {
    std::cout << two<int>() << std::endl;
    std::cout << two<float>() << std::endl;
    std::cout << two<double>() << std::endl;
    std::cout << two() << std::endl;  // 等价于 two<int>()
}
```



#### 整数作为模板参数

需要注意的是：整数也可以作为模板参数，这个时候T就不是代表类型了，而是一个整数类型，使用后会被实例化为一个整数。

```cpp
#include <iostream>

template <int N>
void show_times(std::string msg) {
    for (int i = 0; i < N; i++) {
        std::cout << msg << std::endl;
    }
}

int main() {
    show_times<1>("one");
    show_times<3>("three");
    show_times<4>("four");
}
```

但是模板参数只支持整数类型（包括 enum）。
int N 和 class T 可以一起使用。你只需要指定其中一部分参数即可，这里不需要像函数那样只能最后一个参数指定，因为编译器会自动根据参数类型（T msg）、默认值（int N = 1），推断尖括号里没有指定的那些参数。

```cpp
#include <iostream>

template <int N = 1, class T>
void show_times(T msg) {
    for (int i = 0; i < N; i++) {
        std::cout << msg << std::endl;
    }
}

int main() {
    show_times("one");
    show_times<3>(42);
    show_times<4>('%');
}
```

#### 模板参数的部分特化

还有一个比较神奇的操作是模板参数的部分特化，看以下的例子

```cpp
#include <iostream>
#include <vector>

template <class T>
T sum(std::vector<T> const &arr) {
    T res = 0;
    for (int i = 0; i < arr.size(); i++) {
        res += arr[i];
    }
    return res;
}

int main() {
    std::vector<int> a = {4, 3, 2, 1};
    std::cout << sum(a) << std::endl;
    std::vector<float> b = {3.14f, 2.718f};
    std::cout << sum(b) << std::endl;
}
```

`func(T t)` 完全让参数类型取决于调用者。`func(vector<T> t)` 这样则可以限定仅仅为 vector 类型的参数。这里编译器也是会为模板自动匹配类型的，不过，这种部分特化不支持隐式转换。

上面我们提到了整数作为模板参数，那c++为什么要支持整数作为模板参数呢，你可能会想，模板只需要支持 class T 不就行了？反正 `int N` 可以作为函数的参数传入，模板还不支持浮点。
`template <int N> void func();`和`void func(int N);`一个是模板参数，一个是函数参数，有什么区别？有很大区别！

- template <int N> 传入的 N，是一个编译期常量，每个不同的 N，编译器都会单独生成一份代码，从而可以对他做单独的优化。
- 而 func(int N)，则变成运行期常量，编译器无法自动优化，只能运行时根据被调用参数 N 的不同。
- 比如 `show_times<0>()` 编译器就可以自动优化为一个空函数。因此模板元编程对高性能编程很重要。
- 通常来说，模板的内部实现需要被暴露出来，除非使用特殊的手段，否则，定义和实现都必须放在头文件里。
- 但也正因如此，如果过度使用模板，会导致生成的二进制文件大小剧增，编译变得很慢等。

#### 编译期优化

接下来展示一个编译期优化案例：

```cpp
#include <iostream>

int sumto(int n, bool debug) {
    int res = 0;
    for (int i = 1; i <= n; i++) {
        res += i;
        if (debug)
            std::cout << i << "-th: " << res << std::endl;
    }
    return res;
}

int main() {
    std::cout << sumto(4, true) << std::endl;
    std::cout << sumto(4, false) << std::endl;
    return 0;
}
```

这个案例中，我们声明了一个 sumto 函数，作用是求出从 1 到 n 所有数字的和。用一个 debug 参数控制是否输出调试信息。但是这样 debug 是运行时判断，这样即使是 debug 为 false 也会浪费 CPU 时间。

因此可以把 debug 改成模板参数，这样就是编译期常量。编译器会生成两份函数 sumto<true> 和 sumto<false>。前者保留了调试用的打印语句，后者则完全为性能优化而可以去掉打印语句。后者其实在编译器看来就是`if (false) std::cout << ...`这样显然是会被他自动优化掉的。

```cpp
#include <iostream>

template <bool debug>
int sumto(int n) {
    int res = 0;
    for (int i = 1; i <= n; i++) {
        res += i;
        if constexpr (debug)
            std::cout << i << "-th: " << res << std::endl;
    }
    return res;
}

int main() {
    std::cout << sumto<true>(4) << std::endl;
    std::cout << sumto<false>(4) << std::endl;
    return 0;
}
```

更进一步，可以用C++17的 if constexpr 语法，保证是编译期确定的分支：

```cpp
#include <iostream>

template <bool debug>
int sumto(int n) {
    int res = 0;
    for (int i = 1; i <= n; i++) {
        res += i;
        if constexpr (debug)
            std::cout << i << "-th: " << res << std::endl;
    }
    return res;
}

constexpr bool isnegative(int n) {
    return n < 0;
}

int main() {
    constexpr bool debug = isnegative(-2014);
    std::cout << sumto<debug>(4) << std::endl;
    return 0;
}
```

编译期常量的限制就在于他不能通过运行时变量组成的表达式来指定。除了 `if constexpr` 的表达式不能用运行时变量，模板尖括号内的参数也不能。可以在 bool debug 变量的定义前面加上 constexpr 来解决，但这样 debug = 右边的值也必须为编译期常量，否则出错。

```cpp
#include "sumto.h"
#include <iostream>

int main() {
    constexpr bool debug = true; // bool debug = time(NULL);会出错。不加constexpr也会出错。
    std::cout << sumto<debug>(4) << std::endl;
    return 0;
}
```

编译期 constexpr 的表达式，一般是无法调用其他函数的。但是如果能保证被调用的函数可以在编译期求值，将被调用的函数前面也标上 constexpr 即可。

```cpp
constexpr bool istrue(){
    return true
}

int main() {
    constexpr bool debug = istrue();
    std::cout << sumto<debug>(4) << std::endl;
    return 0;
}
```

注意：constexpr 函数不能调用 non-constexpr 函数。而且 constexpr 函数必须是内联（inline）的，不能分离声明和定义在另一个文件里。标准库的很多函数如 `std::min` 也是 constexpr 函数，可以放心大胆在模板尖括号内使用。

模板的难题：移到另一个文件中定义，如果我们试着像传统函数那样分离模板函数的声明与实现，比如把sumto分为，main.cc,sumto.cc,sumto.h。就会出现 undefined reference 错误。

这是因为编译器对模板的编译是惰性的，即只有当前 .cpp 文件用到了这个模板，该模板里的函数才会被定义。而我们的 sumto.cpp 中没有用到 sumto<> 函数的任何一份定义，所以 main.cpp 里只看到 sumto<> 函数的两份声明，从而出错。

解决：在看得见 sumto<> 定义的 sumto.cpp 里，增加两个显式编译模板的声明：

![img](https://pic4.zhimg.com/80/v2-9b61dfe3ba3d1829f7f04c83dbd4126b_720w.webp)


一般来说，会建议模板不要分离声明和定义，直接写在头文件里即可。如果分离还要罗列出所有模板参数的排列组合，违背了开-闭原则。
模板的惰性：延迟编译，要证明模板的惰性，只需看这个例子：

```cpp
#include <iostream>

template <class T = void>
void func_that_never_pass_compile() {
    "字符串" = 2333;
}

int main() {
    return 0;
}
```

要是编译器哪怕细看了一眼：字符串怎么可能被写入呢？肯定是会出错的。但是却没有出错，这是因为模板没有被调用，所以不会被实际编译！而只有当 main 调用了这个函数，才会被编译，才会报错！用一个假模板实现延迟编译的技术，可以加快编译的速度，用于代理模式等。

#### 总结

模板函数总结：

1. 类型作为参数：`template <class T>`
2. 整数值作为参数：`template <int N>`
3. 定义默认参数：`template <int N = 0, class T = int>`
4. 使用模板函数：`myfunc<T, N>(...)`
5. 模板函数可以自动推断类型，从而参与重载
6. 模板具有惰性、多次编译的特点