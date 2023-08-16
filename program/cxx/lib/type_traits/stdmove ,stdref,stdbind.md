# std::move ,std::ref,std::bind

[![HipHopBoy](https://pica.zhimg.com/v2-e22e6a9725f082523f527893f7fb9ab0_l.jpg?source=172ae18b)](https://www.zhihu.com/people/dianyu-zhu)

[HipHopBoy](https://www.zhihu.com/people/dianyu-zhu)

8 人赞同了该文章

### 1. std::move

[std::move - cppreference.comzh.cppreference.com/w/cpp/utility/move](https://

std::move主要使用在以下场景：

1. C++ 标准库使用比如vector::push_back 等这类函数时,会对参数的对象进行复制,连数据也会复制.这就会造成对象内存的额外创建, 本来原意是想把参数push_back进去就行了.
2. C++11 提供了std::move 函数来把左值转换为xrvalue, 而且新版的push_back也支持&&参数的重载版本,这时候就可以高效率的使用内存了.
3. 对指针类型的标准库对象并不需要这么做.

- 使用前提：
- 1 定义的类使用了资源并定义了移动构造函数和移动赋值运算符，
- 2 该变量即将不再使用



### 2. std::ref

[std::ref, std::crefzh.cppreference.com/w/cpp/utility/functional/ref](https://zh.cppreference.com/w/cpp/utility/functional/ref)

C++11 中引入 `std::ref` 用于取某个变量的引用，这个引入是为了解决一些传参问题。

std::ref 用于包装按引用传递的值。

std::cref 用于包装按const引用传递的值。

我们知道 C++ 中本来就有引用的存在，为何 C++11 中还要引入一个 `std::ref` 了？主要是考虑函数式编程（如 `std::bind`）在使用时，是对参数直接拷贝，而不是引用。下面通过例子说明

```cpp
#include <functional>
#include <iostream>


void f(int& n1, int& n2, const int& n3)
{
    std::cout << "In function: " << n1 << ' ' << n2 << ' ' << n3 << '\n';
    ++n1; // increments the copy of n1 stored in the function object
    ++n2; // increments the main()'s n2
    // ++n3; // compile error
}

int main()
{
    int n1 = 1, n2 = 2, n3 = 3;
    std::function<void()> bound_f = std::bind(f, n1, std::ref(n2), std::cref(n3));
    n1 = 10;
    n2 = 11;
    n3 = 12;
    std::cout << "Before function: " << n1 << ' ' << n2 << ' ' << n3 << '\n';
    bound_f();
    std::cout << "After function: " << n1 << ' ' << n2 << ' ' << n3 << '\n';
}
```

输出：

Before function: 10 11 12
In function: 1 11 12
After function: 10 12 12

上述代码在执行`std::bind`后，在函数`f()`中`n1`的值仍然是 1，`n2`和`n3`改成了修改的值，**说明`std::bind`使用的是参数的拷贝而不是引用，因此必须显示利用`std::ref`来进行引用绑定**。具体为什么`std::bind`不使用引用，可能确实有一些需求，使得 C++11 的设计者认为默认应该采用拷贝，如果使用者有需求，加上`std::ref`即可。

```cpp
#include <thread>
#include <iostream>
#include <string>

void threadFunc(std::string &str, int a)
{
    str = "change by threadFunc";
    a = 13;
}

int main()
{
    std::string str("main");
    int a = 9;
    std::thread th(threadFunc, std::ref(str), a);

    th.join();

    std::cout<<"str = " << str << std::endl;
    std::cout<<"a = " << a << std::endl;

    return 0;
}

输出
str = change by threadFunc
a = 9
```

可以看到，和`std::bind`类似，多线程的`std::thread`也是必须显式通过`std::ref`来绑定引用进行传参，否则，形参的引用声明是无效的。

### 3. std::bind

[std::bind - cppreference.comzh.cppreference.com/w/cpp/utility/functional/bind](https://zh.cppreference.com/w/cpp/utility/functional/bind)

可将std::bind函数看作一个通用的函数适配器，它接受一个可调用对象，生成一个新的可调用对象来“适应”原对象的参数列表。
std::bind将可调用对象与其参数一起进行绑定，绑定后的结果可以使用std::function保存。

到 bind 的参数被复制或移动，而且决不按引用传递，除非包装于[std::ref](https://zh.cppreference.com/w/cpp/utility/functional/ref)或[std::cref](https://zh.cppreference.com/w/cpp/utility/functional/ref)。

std::bind主要有以下两个作用：

- 将可调用对象和其参数绑定成一个仿函数；
- 只绑定部分参数，减少可调用对象传入的参数。

3.1 std::bind绑定普通函数

```cpp
 double my_divide (double x, double y) {return x/y;}
auto fn_half = std::bind (my_divide,_1,2);  
std::cout << fn_half(10) << '\n';                        // 5
```

- bind的第一个参数是函数名，普通函数做实参时，会隐式转换成函数指针。因此std::bind (my_divide,_1,2)等价于std::bind (&my_divide,_1,2)；
- _1表示占位符，位于<functional>中，std::placeholders::_1；

std::bind绑定一个成员函数

```cpp
struct Foo {
    void print_sum(int n1, int n2)
    {
        std::cout << n1+n2 << '\n';
    }
    int data = 10;
};
int main() 
{
    Foo foo;
    auto f = std::bind(&Foo::print_sum, &foo, 95, std::placeholders::_1);
    f(5); // 100
}
```

bind绑定类成员函数时，第一个参数表示对象的成员函数的指针，第二个参数表示对象的地址。
必须显示的指定&Foo::print_sum，因为编译器不会将对象的成员函数隐式转换成函数指针，所以必须在Foo::print_sum前添加&；
使用对象成员函数的指针时，必须要知道该指针属于哪个对象，因此第二个参数为对象的地址 &foo；