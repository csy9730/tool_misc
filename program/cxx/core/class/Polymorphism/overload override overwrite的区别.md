# overload override overwrite的区别


重载overload，覆盖（重写）override，隐藏（重定义）overwrite，这三者之间的区别

## overload
- overload，将语义相近的几个函数用同一个名字表示，但是参数列表（参数的类型，个数，顺序不同）不同，这就是函数重载，返回值类型可以不同

特征：相同范围（同一个类中）、函数名字相同、参数不同、virtual关键字可有可无.


## overwrite
overwrite，派生类屏蔽了其同名的基类函数，返回值类型可以不同

特征：不同范围（基类和派生类）、函数名字相同、参数不同或者参数相同且无virtual关键字


## override
override，派生类覆盖基类的虚函数，实现接口的重用，返回值类型必须相同

特征：不同范围（基类和派生类）、函数名字相同、参数相同、基类中必须有virtual关键字（必须是虚函数）

## 总结

override 是通过对象多态（虚函数机制）实现，是真正的运动时多态。

overload和overwrite类似，都是编译期多态，两者的区别是：overload是指同名函数位于同一个类内，overwrite是指同名函数位于基类和衍生类。



