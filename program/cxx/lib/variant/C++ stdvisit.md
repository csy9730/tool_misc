# C++ std::visit

[![未平](https://pica.zhimg.com/v2-072dc28947e4ebba35736f886ec5e544_l.jpg?source=172ae18b)](https://www.zhihu.com/people/fanxingnote)

[未平](https://www.zhihu.com/people/fanxingnote)

创作声明: 内容包含剧透



33 人赞同了该文章

`std::visit` 是 C++ 标准库中的一个函数，它的作用是将一个包含多种不同类型的可访问对象（如 `std::variant` 或 `std::any` 等）的容器中的对象传递给多个可调用对象中的一个，具体调用哪个可调用对象由该对象所包含的对象的实际类型决定。

使用`std::visit` 来遍历 `std::variant` 对象中包含的所有对象：

```cpp
 #include <iostream>
 #include <variant>
 
 int main() {
     std::variant<int, float, std::string> v;
 
     v = 10;
     std::visit([](auto&& arg) { std::cout << arg << '\n'; }, v);
 
     v = 3.14f;
     std::visit([](auto&& arg) { std::cout << arg << '\n'; }, v);
 
     v = "fanxing";
     std::visit([](auto&& arg) { std::cout << arg << '\n'; }, v);
 
     return 0;
 }
```

输出结果如下：

```text
 10
 3.14
 hello
```

std::visit原型：

```cpp
 template <class R, class Visitor, class... Variants>
 constexpr R visit( Visitor&& vis, Variants&&... vars );
```

接受一个可变参数列表，该参数列表中必须包含一个可以是多种不同类型的可访问对象的容器（如 `std::variant` 或 `std::any` 等），以及若干个可调用对象（如函数、函数指针、lambda 表达式等）。

`std::visit` 的作用是，将容器中的对象传递给可调用对象中的一个，具体调用哪个可调用对象由该对象所包含的对象的实际类型决定。



如果我们希望针对不同的类型有不同的操作：

```cpp
 #include <iostream>
 #include <variant>
 #include <type_traits>
 
 int main()
 {
     std::variant<int, float, std::string> v{10086};
 
     std::visit(
 
         [](auto&& arg)
         {
         
             using T = std::decay_t<decltype(arg)>;
             if constexpr (std::is_same_v<T, int>)
             {
                 std::cout << "arg is an integer with value: " << arg << '\n';
             }
 
             else if constexpr (std::is_same_v<T, float>)
             {
                 std::cout << "arg is a float with value: " << arg << '\n';
             }
 
             else if constexpr (std::is_same_v<T, std::string>)
             {
                 std::cout << "arg is a string with value: " << arg << '\n';
             }
         },
         v);
 
     return 0;
 }
 
```

与直接使用`std::variant`的`std::get`函数来获取值并手动判断其类型不同，`std::visit`可以在编译时自动匹配相应的处理函数，清晰易读。

编辑于 2022-12-06 16:48・IP 属地黑龙江

[C++](https://www.zhihu.com/topic/19584970)

[C / C++](https://www.zhihu.com/topic/19601705)

[计算机语言](https://www.zhihu.com/topic/19615452)