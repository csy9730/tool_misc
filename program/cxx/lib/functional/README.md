# functional


#### 函数式编程
函数式编程，讲究参数复制进来，不能修改入参。无副作用。
和过程函数不同，过程函数可以有副作用，参数式引用传参进来，可以修改传进来的参数。
std::bind 就是遵循函数式编程，不能有副作用。所以参数默认不支持引用，必须使用std::ref来说明显式使用引用。

#### std::bind


用在bind 中是为了避免裸引用 `std::remove_reference_t<T>&` 的 & 被 decay 掉从而改变语义进而导致意外的复制发生。其他情况下也是这个目的。

bind 中强制使用decay 是通过强制改变语义以复制对象以避免引用一个已被RAII销毁的对象从而UAF，这也是一个典型的空引用的案例。

#### std ref
``` cpp
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


#### decay 

为类型T应用从左值到右值（lvalue-to-rvalue）、数组到指针（array-to-pointer）和函数到指针（function-to-pointer）的隐式转换。转换将移除类型T的cv限定符（const和volatile限定符），并定义结果类型为成员decay<T>::type的类型。这种转换很类似于当函数的所有参数按值传递时发生转换。

可以部分理解成 类型 擦除。只是侧重于擦除 const和 volatile，把数组或函数擦除成指针，
