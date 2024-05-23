# cpp 模板知识

#### base
注意区分模板, 类和对象实例。

模板类+类 = 类
函数模板+类=函数

如果有多个模板类嵌套，应该是 ： 模板类+(模板类2+类) = 模板类+ 实例化类= 实例化类2


cpp 模板的核心就是用类去填充模板，在模板和类之间互相传递。

#### 模板调用函数
类是模板的核心，可以任意传递。 
对象实例不能充当模板参数，可以充当函数参数。

函数指针不能作为模板参数。

一般把具体函数封装成仿函数类，或者把具体函数封装成类静态函数，这样就把函数封装成类，就能充当模板参数。

std::function 可以容纳 函数，仿函数，匿名函数，但是它们三者的类型并不相同。


``` cpp
void hello(){ printf("hello\n");};

// 仿函数
struct HelloFunctor{
    void operator(){ hello();}
};

// 传入 仿函数类
template<typename F>
void wrapClassCall(){
    print("before call\n");
    // 先实例化对象
    F f;
    // 再运行函数
    f();
    print("after call\n");
}

// 传入 实例化对象
template<typename F>
void wrapObjectCall(F f){
    print("before call\n");
    f();
    print("after call\n");
}

// 使用静态函数封装
struct HelloStaticFunctor{
    staic void call(){ hello();}
};
template<typename F>
void wrapStaticCall(){
    print("before call\n");
    F::call();
    print("after call\n");
}

```
#### 模板类嵌套

以下代码，把两个模板类嵌套。
``` cpp

template <typename T>
class Ptr{
	T dat;
	void* p;
};

template <typename T>
class Wrap{
	
};

struct Foo{
	int a;
};

template<typename T>
using PtrWrap<T> = Wrap<Ptr<T>>;
using FooPtrWrap = Wrap<Ptr<Foo>>;

```

#### 可选模板

``` cpp
// std::vector<int, std::allocate<int>>;
```

### faq
一般使用模板，定义的是无状态内存分配器，如何定义有状态分配器？

- 有状态分配器：就是参数传递分配器对象。如果分配器是虚对象，则对应 dynamic dispatch。
- 无状态分配器：通过类型传递， 对应  static dispatch , 支持 inline

#### new

- operator new  分配内存
- placement new 指定地址构建对象


#### pointer
- bare pointer
-  fancy pointer  花式指针
-  iterator
-  fat pointer 原指针的基础上增加一个关联数据，该关联数据要么是原始指针数据的长度（slice）要么是指向vtable的指针（trait）


cpp 的含有四种编程范式
- 面向过程编程
- 面向对象编程
- GP generic programming 泛型编程
- 面向函数编程


