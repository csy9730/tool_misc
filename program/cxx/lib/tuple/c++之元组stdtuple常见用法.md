# [c++之元组std::tuple常见用法](https://www.cnblogs.com/pandamohist/p/13630613.html)

 

元组，c++11中引入的新的类型，可类比std::pair。 但是std::pair只能支持两个元素。 理论上， 元组支持0~任意个元素。 

　　本文演示环境： VS2015 up3

## 0、头文件[#](https://www.cnblogs.com/pandamohist/p/13630613.html#1005345410)

``` cpp
#include <tuple>
```

 

## 1、创建和初始化[#](https://www.cnblogs.com/pandamohist/p/13630613.html#3490635237)

　　1.1、创建一个空的元组， 创建时，需要指定元组的数据类型。

``` cpp
std::tuple<int, float, double, long, long long> first;
```

　　1.2 、创建一个元组并初始化元组。　　



``` cpp
std::string str_second_1("_1");
std::string str_second_2("_2");

// 指定了元素类型为引用 和 std::string, 下面两种方式都是可以的，只不过第二个参数不同而已
std::tuple<std::string, std::string> second_1(str_second_1, std::string("_2"));
std::tuple<std::string, std::string> second_2(str_second_1, str_second_2);
```



　　1.3、创建一个元素是引用的元组

``` cpp
1     //3、创建一个元组，元组的元素可以被引用, 这里以 int 为例
2     int i_third = 3;
3     std::tuple<int&> third(std::ref(i_third));
```

　　1.4、使用make_tuple创建元组

``` cpp
int i_fourth_1 = 4;
int i_fourth_2 = 44;
// 下面的两种方式都可以
std::tuple<int, int> forth_1    = std::make_tuple(i_fourth_1, i_fourth_2);
auto forth_2                    = std::make_tuple(i_fourth_1, i_fourth_2);
```

　　1.5、创建一个类型为引用的元组， 对元组的修改。 这里以 std::string为例



``` cpp
std::string str_five_1("five_1");
// 输出原址值
std::cout << "str_five_1 = " << str_five_1.c_str() << "\n";

std::tuple<std::string&, int> five(str_five_1, 5);
// 通过元组 对第一个元素的修改，str_five_1的值也会跟着修改，因为元组的第一个元素类型为引用。
// 使用get访问元组的第一个元素
std::get<0>(five) = "five_2";

// 输出的将是： five_2
std::cout << "str_five_1 = " << str_five_1.c_str() << "\n";
```



　　输出结果（VS2015 up3输出）：

[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908091903048-1019385199.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908091903048-1019385199.png)

 

2、计算元组的元素个数

　　需要函数： std::tuple_size。 下面是一个例子， 

``` cpp
std::tuple<char, int, long, std::string> first('A', 2, 3, "4");
    // 使用std::tuple_size计算元组个数
    int i_count = std::tuple_size<decltype(first)>::value;
    std::cout << "元组个数=" << i_count << "\n";
```

　　输出结果：

[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908092840820-1133471578.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908092840820-1133471578.png)

 

## 3、访问元素[#](https://www.cnblogs.com/pandamohist/p/13630613.html#2931821665)

　　访问元组的元素，需要函数： std::get<index>(obj)。其中：【index】是元组中元素的下标，0 ，1 ， 2， 3， 4，....   【obj】-元组变量。 　

　　一个例子：



``` cpp
std::tuple<char, int, long, std::string> second('A', 2, 3, "4");
int index = 0;
std::cout << index++ << " = " << std::get<0>(second) << "\n";
std::cout << index++ << " = " << std::get<1>(second) << "\n";
std::cout << index++ << " = " << std::get<2>(second) << "\n";
std::cout << index++ << " = " << std::get<3>(second).c_str() << "\n";
```



　　输出结果：

[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908093806764-2064521107.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908093806764-2064521107.png)

　　【**注意**】元组**不支持**迭代访问， 且只能通过索引（或者tie解包：将元组的中每一个元素提取到指定变量中）访问， 且索引**不能**动态传入。上面的代码中，索引都是在编译器编译期间就确定了。 下面的演示代码将会在编译期间出错。

``` cpp
for (int i = 0; i < 3; i++)
        std::cout << index++ << " = " << std::get<i>(second) << "\n";　　// 无法通过编译
```

　　

## 4、获取元素的类型[#](https://www.cnblogs.com/pandamohist/p/13630613.html#2137153913)

　　获取元组中某个元素的数据类型，需要用到另外一个类型： std::tuple_element 。 语法： std::tuple_element<index, tuple> 。 【index】-元组中元素的索引，【tuple】哪一个元组

　　一个例子：



``` cpp
std::tuple<int, std::string> third(9, std::string("ABC"));

// 得到元组第1个元素的类型，用元组第一个元素的类型声明一个变量
std::tuple_element<1, decltype(third)>::type val_1;

// 获取元组的第一个元素的值
val_1 = std::get<1>(third);
std::cout << "val_1 = " << val_1.c_str() << "\n";
```



　　输出结果：

[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908095558921-1861873773.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908095558921-1861873773.png)

　　　用获取元组第一个元素的类型声明了一个变量，再对变量赋值。

 

## 5、使用 std::tie解包[#](https://www.cnblogs.com/pandamohist/p/13630613.html#481120311)

　　元组，可以看作一个包，类比结构体。 需要访问元组的元素时，2 种方法： A、索引访问，B、std::tie 。

　　元组包含一个或者多个元素，使用std::tie解包： 首先需要定义对应元素的变量，再使用tie。 比如，元素第0个元素的类型时 char, 第1个元素类型时int, 那么， 需要定义 一个 char的变量和int的变量， 用来储存解包元素的结果。 

　　一个例子：



``` cpp
std::tuple<char, int, long, std::string> fourth('A', 2, 3, "4");

// 定义变量，保存解包结果
char tuple_0    = '0';
int tuple_1        = 0;
long tuple_2    = 0;
std::string tuple_3("");

// 使用std::tie, 依次传入对应的解包变量
std::tie(tuple_0, tuple_1, tuple_2, tuple_3) = fourth;

// 输出解包结果
std::cout << "tuple_0 = " << tuple_0 << "\n";
std::cout << "tuple_1 = " << tuple_1 << "\n";
std::cout << "tuple_2 = " << tuple_2 << "\n";
std::cout << "tuple_3 = " << tuple_3.c_str() << "\n";
```



　　输出结果：
[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908100848991-1247269133.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908100848991-1247269133.png)

　　说到 std::tie , 看下 VS2015 up3中的定义：



``` cpp
template<class... _Types> inline
    constexpr tuple<_Types&...>
        tie(_Types&... _Args) _NOEXCEPT
    {    // make tuple from elements
    typedef tuple<_Types&...> _Ttype;
    return (_Ttype(_Args...));
    }
```



　　接着 std::tie 解包。 如果一个元组，只需要取出其中特定位置上的元素，不用把每一个元素取出来， 怎么做？ 

　　比如： 只要索引为 偶数的元素。

　　元组提供了类似占位符的功能： **std::ignore** 。满足上面的需求，只需要在索引为奇数的位置填上 **std::ignore** 。 一个例子：



``` cpp
std::tuple<char, int, long, std::string> fourth('A', 2, 3, "4");
        
// 定义变量，保存解包结果
char tuple_0    = '0';
int tuple_1        = 0;
long tuple_2    = 0;
std::string tuple_3("");

// 使用占位符
std::tie(tuple_0, std::ignore, tuple_2, std::ignore) = fourth;

// 输出解包结果
std::cout << "tuple_0 = " << tuple_0 << "\n";
std::cout << "tuple_1 = " << tuple_1 << "\n";
std::cout << "tuple_2 = " << tuple_2 << "\n";
std::cout << "tuple_3 = " << tuple_3.c_str() << "\n";
```



　　输出结果：

[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908101823196-558442361.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908101823196-558442361.png)

　　

## 6、元组连接（拼接）[#](https://www.cnblogs.com/pandamohist/p/13630613.html#275619927)

　　使用 std::tuple_cat 执行拼接

　　一个例子：



``` cpp
std::tuple<char, int, double> first('A', 1, 2.2f);

// 组合到一起, 使用auto， 自动推导
auto second = std::tuple_cat(first, std::make_tuple('B', std::string("-=+")));
// 组合到一起，可以知道每一个元素的数据类型时什么 与 auto推导效果一样
std::tuple<char, int, double, char, std::string> third = std::tuple_cat(first, std::make_tuple('B', std::string("-=+")));

// 输出合并后的元组内容
int index = 0;
std::cout << index++ << " = " << std::get<0>(second) << "\n";
std::cout << index++ << " = " << std::get<1>(second) << "\n";
std::cout << index++ << " = " << std::get<2>(second) << "\n";

std::cout << index++ << " = " << std::get<3>(second) << "\n";
std::cout << index++ << " = " << std::get<4>(second).c_str() << "\n";
```



　　输出结果：

[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908103752661-1751689449.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908103752661-1751689449.png)

 

## 7、遍历[#](https://www.cnblogs.com/pandamohist/p/13630613.html#3601031234)

　　这里将采用的时 递归遍历，需要注意，考虑爆栈的情况。其实，tuple也是基于模板的STL容器。 因为其可以容纳多个参数，且每个参数类型可不相同，遍历输出则涉及到参数展开的情况，这里以递归的方式实现遍历， 核心代码：



``` cpp
template<typename Tuple, size_t N>
struct tuple_show
{
    static void show(const Tuple &t, std::ostream& os)
    {
        tuple_show<Tuple, N - 1>::show(t, os);
        os << ", " << std::get<N - 1>(t);
    }
};


// 偏特性，可以理解为递归的终止
template<typename Tuple>
struct tuple_show < Tuple, 1>
{
    static void show(const Tuple &t, std::ostream &os)
    {
        os <<  std::get<0>(t);
    }
};



// 自己写个函数，调用上面的递归展开，
template<typename... Args>
std::ostream& operator << (std::ostream &os, const std::tuple<Args...>& t)
{
    os << "[";
    tuple_show<decltype(t), sizeof...(Args)>::show(t, os);
    os << "]";

    return os;
}
```



　　调用示例：

``` cpp
auto t1 = std::make_tuple(1, 'A', "-=+", 2);
std::cout << t1;
```

　　输出结果：

[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908234051855-502888564.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908234051855-502888564.png)

 

作者：[ mohist](https://www.cnblogs.com/pandamohist/)

出处：https://www.cnblogs.com/pandamohist/p/13630613.html

版权：本站使用「[CC BY 4.0](https://creativecommons.org/licenses/by/4.0)」创作共享协议，未经作者同意，请勿转载；若经同意转载，请在文章明显位置注明作者和出处。

分类: [c++基础知识](https://www.cnblogs.com/pandamohist/category/1826932.html)