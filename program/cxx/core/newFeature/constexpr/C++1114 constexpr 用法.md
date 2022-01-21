# C++11/14 constexpr 用法

![img](https://upload.jianshu.io/users/upload_avatars/13626533/1ba192d6-1dc2-4615-8555-8a3bae1fe084.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[0x55aa](https://www.jianshu.com/u/63be6d29cdd5)关注

12018.08.16 02:46:44字数 747阅读 71,769

constexpr是C++11开始提出的关键字，其意义与14版本有一些区别。
C++11中的constexpr指定的函数返回值和参数必须要保证是字面值，而且必须有且只有一行return代码，这给函数的设计者带来了更多的限制，比如通常只能通过return 三目运算符+递归来计算返回的字面值。
而C++14中只要保证返回值和参数是字面值就行了，函数体中可以加入更多的语句，方便了更灵活的计算。

很多人都把constexpr和const相比较。

其实，const并不能代表“常量”，它仅仅是对变量的一个修饰，告诉编译器这个变量只能被初始化，且不能被直接修改（实际上可以通过堆栈溢出等方式修改）。而这个变量的值，可以在运行时也可以在编译时指定。

constexpr可以用来修饰变量、函数、构造函数。一旦以上任何元素被constexpr修饰，那么等于说是告诉编译器 “请大胆地将我看成编译时就能得出常量值的表达式去优化我”。
如：

```go
const int func() {
    return 10;
}
main(){
  int arr[func()];
}
//error : 函数调用在常量表达式中必须具有常量值
```

对于func() ，胆小的编译器并没有足够的胆量去做编译期优化，哪怕函数体就一句return 字面值;
而

```go
constexpr func() {
    return 10;
}
main(){
  int arr[func()];
}
//编译通过
```

则编译通过
编译期大胆地将func()做了优化，在编译期就确定了func计算出的值10而无需等到运行时再去计算。

这就是constexpr的第一个作用：给编译器足够的信心在编译期去做被constexpr修饰的表达式的优化。

constexpr还有另外一个特性，虽然它本身的作用之一就是希望程序员能给编译器做优化的信心，但它却猜到了自己可能会被程序员欺骗，而编译器并不会对此“恼羞成怒”中止编译，如：

```go
constexpr int func(const int n){
  return 10+n;
}
main(){
 const  int i = cin.get();
 cout<<func(i);
}
//编译通过
```

程序员告诉编译器尽管信心十足地把func当做是编译期就能计算出值的程式，但却欺骗了它，程序员最终并没有传递一个常量字面值到该函数。没有被编译器中止编译并报错的原因在于编译器并没有100%相信程序员，当其检测到func的参数是一个常量字面值的时候，编译器才会去对其做优化，否则，依然会将计算任务留给运行时。
基于这个特性，constexpr还可以被用来实现编译期的type traits，比如STL中的is_const的完整实现：

```cpp
template<class _Ty,
    _Ty _Val>
struct integral_constant
{   // convenient template for integral constant types
    static constexpr _Ty value = _Val;

    typedef _Ty value_type;
    typedef integral_constant<_Ty, _Val> type;

    constexpr operator value_type() const noexcept
    {   // return stored value
        return (value);
    }

    constexpr value_type operator()() const noexcept
    {   // return stored value
        return (value);
    }
};

typedef integral_constant<bool, true> true_type;
typedef integral_constant<bool, false> false_type;

template<class _Ty>
struct is_const
    : false_type
{   // determine whether _Ty is const qualified
};

template<class _Ty>
struct is_const<const _Ty>
    : true_type
{   // determine whether _Ty is const qualified
};
int main() {

    static_assert(is_const<int>::value,"error");//error
    static_assert(is_const<const int>::value, "error");//ok
    return 0;
}
```

constexpr的更多信息可以参考维基（<https://zh.wikipedia.org/wiki/Constexpr>）。时间不早了，关于constexpr就写到这里。