# [std::decay](https://www.cnblogs.com/heartchord/p/5039894.html)

## 参考资料

------

**• cplusplus.com**：http://www.cplusplus.com/reference/type_traits/decay/

**• cppreference.com**：http://en.cppreference.com/w/cpp/types/decay

## std::decay简介

------

## • 类模板声明



```cpp
// cplusplus.com
template <class T> 
    struct decay;// MS C++ 2013
template <class _Ty>
struct decay{ 
        // determines decayed version of _Ty
    ...
};

// GCC 4.8.2
template <typename _Tp>
class decay{    ...}; 

```



## • 类模板说明

​    为类型T应用从**左值到右值（lvalue-to-rvalue）**、**数组到指针（array-to-pointer）**和**函数到指针（function-to-pointer）**的隐式转换。转换将移除类型T的**cv限定符**（const和volatile限定符），并定义结果类型为成员decay<T>::type的类型。这种转换很类似于当函数的所有参数按值传递时发生转换。

​    ▶ 如果类型T是一个函数类型，那么从函数到指针的类型转换将被应用，并且T的衰变类型等同于：

​         `add_pointer::type`

​    ▶ 如果类型T是一个数组类型，那么从数组到指针的类型转换将被应用，并且T的衰变类型等同于：

​         `add_pointer::type>::type>::type`

​    ▶ 当左值到右值转换被应用时，T的衰变类型等同于：

​         `remove_cv::type>::type`

## • 模板参数说明

​    **T** : 某种类型。当T是引用类型，decay<T>::type返回T引用的元素类型；当T是非引用类型，decay<T>::type返回T的类型。

## std::decay详解

------

## • 基本类型



```cpp
#include <iostream>
#include <type_traits>
using namespace std;

typedef decay<int>::type         A;                                     // A is int
typedef decay<int &>::type       B;                                     // B is int
typedef decay<int &&>::type      C;                                     // C is int
typedef decay<const int &>::type D;                                     // D is int
typedef decay<int[2]>::type      E;                                     // E is int *
typedef decay<int(int)>::type    F;                                     // F is int(*)(int)

int main(){
    cout << boolalpha;
    cout << is_same<int, A>::value         << endl;                     // true
    cout << is_same<int, B>::value         << endl;                     // true
    cout << is_same<int, C>::value         << endl;                     // true
    cout << is_same<int, D>::value         << endl;                     // true
    cout << is_same<int *, E>::value       << endl;                     // true
    cout << is_same<int(int), F>::value    << endl;                     // false
    cout << is_same<int(*)(int), F>::value << endl;                     // true

    return 1;
}
```



## • 非基本类型



```cpp
#include <iostream>
#include <type_traits>
using namespace std;

class MyClass {};

typedef decay<MyClass>::type         A;                                 // A is MyClass
typedef decay<MyClass &>::type       B;                                 // B is MyClass
typedef decay<MyClass &&>::type      C;                                 // C is MyClass
typedef decay<const MyClass &>::type D;                                 // D is MyClass
typedef decay<MyClass[2]>::type      E;                                 // E is MyClass *
typedef decay<MyClass *>::type       F;                                 // E is MyClass *
typedef decay<MyClass *[2]>::type    G;                                 // G is MyClass **
typedef decay<MyClass **>::type      H;                                 // H is MyClass **

int main(){
    cout << boolalpha;
    cout << is_same<MyClass, A>::value    << endl;                      // true
    cout << is_same<MyClass, B>::value    << endl;                      // true
    cout << is_same<MyClass, C>::value    << endl;                      // true
    cout << is_same<MyClass, D>::value    << endl;                      // true
    cout << is_same<MyClass *, E>::value  << endl;                      // true
    cout << is_same<MyClass *, F>::value  << endl;                      // true
    cout << is_same<MyClass **, G>::value << endl;                      // true
    cout << is_same<MyClass **, H>::value << endl;                      // true

    return 1;
}
```



 

分类: [c++](https://www.cnblogs.com/heartchord/category/691393.html)

标签: [c++.0x11](https://www.cnblogs.com/heartchord/tag/c%2B%2B.0x11/)