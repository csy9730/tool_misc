# std swap


#### std swap
std::swap是移动语义的一种常用实现方案。而赋值有两种，需要按语义区分开：`operator = (const T& t)`：拷贝赋值 `operator = (T&& t)`：移动赋值，可用`std::swap`实现C++11前由于没有右值引用，所以大家都用`std::swap`来达到类似的效果。


在C++11前，没有移动语义。赋值等于做了一次复制，开销比较大。而swap的可以用作移动。大部分类，比如string，vector等等，swap就是交换一下指针，效率较高。如果是自己定义的类，就要自己去实现交换指针的swap。

#### code


定义一元swap 函数
``` cpp
class T{
    void swap(T& t) noexcept{
        // ...
    };

    friend void swap(T& a, T& b) noexcept;
}

```

在类T的同一命名空间里添加一个非成员函数swap，用于调用类中的成员函数swap

``` cpp
void swap(T& a, T& b) noexcept
{
    a.swap(b);
}
```