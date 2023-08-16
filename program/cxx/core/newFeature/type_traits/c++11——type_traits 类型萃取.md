# [c++11——type_traits 类型萃取](https://www.cnblogs.com/gtarcoder/p/4807670.html)

#### 一、 c++ traits**

​    traits是c++模板编程中使用的一种技术，主要功能： 
​    把功能相同而参数不同的函数抽象出来，通过traits将不同的参数的相同属性提取出来，在函数中利用这些用traits提取的属性，使得函数对不同的参数表现一致。

> ​    traits是一种特性萃取技术,它在Generic Programming中被广泛运用,常常被用于使不同的类型可以用于相同的操作,或者针对不同类型提供不同的实现.traits在实现过程中往往需要用到以下三种C++的基本特性: 
> enum、typedef、template (partial) specialization 
> 其中: 
> ​    enum用于将在不同类型间变化的标示统一成一个,它在C++中常常被用于在类中替代define,你可以称enum为类中的define; 
> ​    typedef则用于定义你的模板类支持特性的形式,你的模板类必须以某种形式支持某一特性,否则类型萃取器traits将无法正常工作 
> ​    template (partial) specialization被用于提供针对特定类型的正确的或更合适的版本.

参考 [c++ traits](http://www.cnblogs.com/gtarcoder/articles/4806889.html)

#### **二、 c++11 中 type_traits**

> ​    通过type_traits可以实现在编译期计算、查询、判断、转换和选择，增强了泛型编程的能力，也增强了程序的弹性，使得我们在编译期就能做到优化改进甚至排错，能进一步提高代码质量。

#### **1. 基本的type_traits**

###### **1.1 简单的type_traits（以定义结构体/类中的常量为例）**

``` cpp
// 定义一个编译期常量
template<typename T>
struct GetLeftSize{
    //使用静态常量
    static const int value = 1;//或者使用 enum    
    enum{value = 1};
}; 

// 在c++11中直接继承 std::integral_constant即可。
template<typename T>
struct GetLeftSize : std::integral_constant < int, 1 >{};

int main(){
    cout << GetLeftSize<float>::value << endl;
    return 0;
} 
```


std::integral_constant的实现:
``` cpp
// TEMPLATE CLASS integral_constant
template<class _Ty,_Ty _Val>
struct integral_constant{   // convenient template for integral constant types
    static const _Ty value = _Val;     
    typedef _Ty value_type;
    typedef integral_constant<_Ty, _Val> type;     
    operator value_type() const {   // return stored value        
        return (value);        
    }
};
```

 

这样，在想要在结构体或类中定义一个整型常量，则可以使该结构体或类继承自 std::integral_constant< int/unsigned int/short/uint8_t/....等整型类型, 想要的值>，则该结构体内部就有了一个 static const的value，访问该value即可。 
std::true_type, std::false_type分别定义了编译期的true和false类型。

``` cpp
typedef integral_constant<bool, true> true_type;
typedef integral_constant<bool, false> false_type;`
```

 

###### **1.2 类型判断的type_traits**

​    这些类型判断的type_traits从std::integral_constant派生，用来检查模板类型是否为某种类型，通过这些traits可以获取编译期检查的bool值结果。

``` cpp
template<typename T>struct is_integral; // 用来检查T是否为bool、char、char16t_t、char32_t、short、long、long long或者这些类型的无符号整数类型。如果T是这些类型中的某一类型，则std::is_integral::value 为true， 否则为false。其他的一些类型判断type_traits
template<typename T>struct is_void; //是否为void类型
template<typename T>struct is_floating_point; //是否为浮点类型
// is_const, is_function, is_pointer, is_compound....

std::is_const<int>::value //false
std::is_const<const int>::value //true
```

 

###### **1.3 判断两个类型之间关系的traits**

| traits 类型                                              | 说明                       |
| -------------------------------------------------------- | -------------------------- |
| template< typename T, typename U> struct is_same;        | 判断两个类型是否相同       |
| template< typename T, typename U> struct is_base_of;     | 判断类型T是否是类型U的基类 |
| template< typename T, typename U> struct is_convertible; | 判断类型T能否转换为类型U   |

​    和type_traits的其他使用一样，通过 is_xxx::value 获得结果(true/false).

###### **1.4 类型的转换 traits**

| traits类型                                         | 说明                                                    |
| -------------------------------------------------- | ------------------------------------------------------- |
| template< typename T> struct remove_const;         | 移除const                                               |
| template< typename T> struct add_const;            | 添加const                                               |
| template< typename T> struct remove_reference;     | 移除引用                                                |
| template< typename T> struct add_lvalue_reference; | 添加左值引用                                            |
| template< typename T> struct add_rvalue_reference; | 添加右值引用                                            |
| template< typename T> struct remove_extent;        | 移除数组顶层的维度， 比如 int [3][3][2] 变为 int [3][2] |
| template< typename T> struct remove_all_extent;    | 移除数组所有的维度，比如 int [3][3][2] 变为 int         |
| template< typename T> struct remove_pointer;       | 移除指针                                                |
| template< typename T> struct add_pointer;          | 添加指针                                                |
| template< typename T> struct decay;                | 移除cv或者添加指针                                      |
| template< typename .... T> struct common_type;     | 获取公共类型                                            |

​    通过 ::type来访问这些类型。

``` cpp
std::cout << std::is_same<const int, std::add_const<int>::type>::value << endl; //结果为true
std::cout << std::is_same<int, std::remove_all_extent<int[2][2][3]>::type>::value<<endl; //在根据模板参数创建对象时，要注意移除引用：
template<typename T>
typename std::remove_reference<T>::type* Create(){    
    typedef typename std::remove_reference<T>::type U;    
    return new U();
}// 因为模板参数可能是引用类型，而创建对象时，需要原始的类型，不能用引用类型，所以需要将可能的引用移除 

//如果给的模板参数是一个带cv描述符的引用类型，要获取它的原始类型，可以使用decay
template<typename T>
typename std::decay<T>::type* Create(){    
    typedef typename std::decay<T>::type U;    
    return new U();
} 
    // decay还可以获得函数的指针类型，从而将函数指针变量保存起来，以便在后面延迟调用。
typdef std::decay<int(double)>::type F; //F为一个函数指针类型， int(*)(double)
template<typename F>
struct SimpleFunction{    
    using FnTyppe = typename std::decay<F>::type;    
    SimpleFunction(F& f): m_fn(f){};    
    void Run(){        
        m_fn();    
    }
    FnType m_fn;
};`
```

 

#### **2. 根据条件选择的traits**

std::conditional在编译期根据一个判断式选择两个类型中的一个，和条件表达式的语义类似，类似于一个三元表达式：

``` cpp
template<bool B, class T, class F>
struct conditional; // 在std::conditonal模板参数中，如果B为true，则conditional::type为T，否则为F。
std::conditional<true, int, double>::type //= int`
```

 

#### **3. 获取可调用对象返回类型的traits**

​在类型推导的时候，decltype和auto可以实现模板函数的返回类型。比如

``` cpp
//返回类型后置
template<typename F, typename Arg>
auto Func(F f, Arg arg)->decltype(f(arg)){    
    return f(arg);
}
```

 

c++11提供了另一个traits——result_of，用来在编译期获取一个可调用对象的返回类型。

``` cpp
template<typename F, class... ArgTypes>
class result_of<F(ArgTypes...)>;

int fn(int) {
    return int();
};
typedef int(&fn_ref)(int);
typedef int(*fn_ptr)(int);
struct fn_class{    
    int operator()(int i){        
        return i;    
    }
};
int main(){    
    typedef std::result_of<decltype(fn)&(int)>::type A;  //int    
    typedef std::result_of<fn_ref(int)>::type B;        //int    
    typedef std::result_of<fn_ptr(int)>::type C;        //int    
    typedef std::result_of<fn_class(int)>::type D;      //int    
    return 0;
}

// 需要注意 std::result_of<Fn(ArgTypes)> 要去Fn为一个可调用对象，而函数类型不是一个可调用对象，因此，不能使用
typedef std::result_of<decltype(fn)(int)>::type A:  //错误

// 需要先将fn转换为一个可调用对象类型，比如：
typedef std::result_of<decltype(fn)&(int)>::type A;
typedef std::result_of<decltype(fn)*(int)>::type B;
typedef std::result_of<std::decay<decltype(fn)>::type(int)>::type C;`
```

 

#### **4. 根据条件禁用或启用某种或某些类型traits**

std::enable_if利用SFINAE实现条件选择重载函数

``` cpp
template< bool B, class T = void>   //T为返回类型，常用作函数的返回类型
struct enable_if;当B为true的时候，返回类型T，否则编译出错。template<class T>       
//T只有为合法的类型，才能调用该函数，否则编译出错
typename std::enable_if<std::is_arithmetic<T>::value, T>::type foo(T t){    
    return t;
}

auto r = foo(1);    //返回1
auto r1 = foo(1.2); //返回1.2
auto r2 = foo("hello"); //编译出错`
```

 

可以利用这一点来实现相同函数名，但不同类型参数的函数的重载：

``` cpp
//对于arithmetic类型的入参返回0，对于非arithmetic类型返回1，通过arithmetic将所有的入参分为两大类进行处理。
template<class T>
typename std::enable_if<std::is_arithmetic<T>::value, int>::type foo(T t){
    //函数返回类型为int    
    cout << t << endl;    
    return t;
} 

template<class T>
typename std::enable_if<! std::is_arithmetic<T>::value, int>::type foo(T t){
    //函数返回类型为int    
    cout << typeid(T).name() << endl;    
    return 1;
}
```

 



标签: [c++11](https://www.cnblogs.com/gtarcoder/tag/c%2B%2B11/)