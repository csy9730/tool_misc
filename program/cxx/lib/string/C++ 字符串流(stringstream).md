# C++ 字符串流(stringstream)

[![CG6316](https://pica.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=32738c0c)](https://www.zhihu.com/people/cg6316)

[CG6316](https://www.zhihu.com/people/cg6316)

1 人赞同了该文章

在 C++ 中，字符串流（stringstream）是一种特殊的流类，它允许将字符串作为输入和输出流进行处理。字符串流提供了一种方便的方式，可以将字符串与其他基本类型进行转换、拼接、解析等操作。

使用字符串流需要包含头文件 <sstream>。以下是一些常见的使用字符串流的示例：



使用字符串流需要包含头文件 '<sstream>'. 以下是一些常见的使用字符串流的示例：

**1. 将其他类型转换为字符串：**

```cpp
#include <iostream>
#include <string>
#include <sstream>




int main() {
    int num = 42;
    double pi = 3.14159;




    std::stringstream ss;
    ss << "Number: " << num << ", Pi: " << pi;




    std::string str = ss.str();
    std::cout << str << std::endl;




    return 0;
}
```

**这段代码将整数 'num' 和浮点数 'pi' 转换为字符串，并通过字符串流 'ss' 进行拼接。最后，使用 'ss.str()' 获取拼接后的字符串。**



**2.** **将字符串解析为其他类型：**

```cpp
#include <iostream>
#include <string>
#include <sstream>




int main() {
    std::string str = "42 3.14159";




    std::stringstream ss(str);
    int num;
    double pi;




    ss >> num >> pi;




    std::cout << "Number: " << num << std::endl;
    std::cout << "Pi: " << pi << std::endl;




    return 0;
}
```



**这段代码使用字符串流** **ss** **将字符串** **str** **解析为整数** **num** **和浮点数** **pi。通过连续使用流提取运算符** **>>，可以从字符串流中按顺序提取不同类型的值。**

**字符串流提供了与标准输入输出流（如** **std::cin** **和** **std::cout）类似的操作，但其操作对象是字符串而不是标准输入输出。你可以根据需要使用字符串流进行字符串与其他类型之间的转换、拼接和解析等操作，使得字符串处理更加灵活和方便。**



发布于 2023-07-06 15:02・IP 属地新加坡