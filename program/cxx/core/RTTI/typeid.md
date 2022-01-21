# typeid 

作者：RednaxelaFX

链接：https://www.zhihu.com/question/38997922/answer/79179526

来源：知乎

著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。

typeid operator

针对题主给的例子：

```cpp
int i = 1;
const char* name = typeid(i).name();
```

这里的typeid(i)根本不需要做任何运行时动作，而是纯编译时行为——它使用变量i的静态类型直接就知道这是对int类型做typeid运算，于是可以直接找出int对应的std::type_info对象返回出来。

> If expression is not a glvalue expression of polymorphic type, **typeid does not evaluate the expression**, and the std::type_info object it identifies represents the static type of the expression. Lvalue-to-rvalue, array-to-pointer, or function-to-pointer conversions are not performed.

此时的typeid运算符就跟[sizeof运算符](https://www.zhihu.com/search?q=sizeof运算符&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A79179526})的大部分情况一样，只需要编译器算出表达式的静态类型就足够了。

算出表达式的[静态类型](https://www.zhihu.com/search?q=静态类型&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A79179526})是C++编译器的基本功能了，类型检查、类型推导等许多功能都依赖它。

而当typeid运算符应用在一个指向多态类型对象的指针上的时候，typeid的实现才需要有运行时行为。

> If expression is a glvalue expression that identifies an object of a [polymorphic type](https://www.zhihu.com/search?q=polymorphic+type&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A79179526}) (that is, a class that declares or inherits at least one virtual function), the typeid expression evaluates the expression and then refers to the std::type_info object that represents the dynamic type of the expression. If the glvalue expression is obtained by applying the unary * operator to a pointer and the pointer is a null pointer value, an exception of type std::[bad_typeid](https://www.zhihu.com/search?q=bad_typeid&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A79179526}) or a type derived from std::bad_typeid is thrown.

实际实现的时候，通常是在类的vtable里会有个slot保存着指向该类对应的std::type_info对象的指针。

要形象的理解的话，请参考我在另一个回答里画的图：

为什么bs虚函数表的地址（int*）(&bs)与虚函数地址（int*）*(int*)(&bs) 不是同一个？ - RednaxelaFX 的回答

可以看到Clang++在LP64上用的vtable布局，不禁用RTTI时，在-8偏移量上的slot就是存typeinfo指针的。