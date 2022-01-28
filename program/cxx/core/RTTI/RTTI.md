# RTTI

RTTI（Run-Time Type Identification，运行时类型识别）

C++中，为了支持RTTI提供了两个操作符：dynamic_cast和typeid。dynamic_cast允许运行时刻进行类型转换，从而使程序能够在一个类层次结构中安全地转化类型

RTTI机制是指，typeid和typeinfo。和auto，decltype，typeof这些编译器机制不同，RTTI机制需要耗费额外的存储空间来保存类信息。

## type
### typeid
C++ 提供的 <typeinfo> 这个头文件保存了一些类型，这些类型和 typeid， dynamic_cast 操作符相关。

std::type_info 这个类型在 <typeinfo> 中定义。 typeid 操作符会返回一个该类型的 const 左值对象。但是这个 std::type_info 把拷贝构造函数设置成 private 的了，因此不能直接获取 std::type_info 对象。 std::type_info 这个类型主要提供了 operator==, operator!= 运算符和name()方法，name()方法会返回一个指示该类型的字符串。可以看出来，这个typeid主要是为了对比两个对象是否从属于一个类。

typeid 的主要用法：

``` cpp
class Person;
Person Potter;
if (typeid(Person) == typeid(Potter))
    cout << "Equal" << endl;
```

采用了 const 标识不影响类型，使用 typedef 定义的类型别名也不影响类型。

### typeof
typeof由编译器提供（目前仅gcc编译器支持），用于返回某个变量或表达式的类型，C++11标准新增的decltype是typeof的升级版本。

`typeof(a*b)`并不真的计算`a*b`的值，而是获得计算的结果的类型。
### decltype
和auto类似，可以在编译器时计算类型，不能计算多态类型。

## misc
typeof 和 typeid 不同，typeid 是 c++ 提供的，而 typeof 是编译器提供的（一般指gcc）。有人说 typeof 和 C++11 提供的关键字 decltype 类似。