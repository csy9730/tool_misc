# [c++之元组std::tuple常见用法](https://www.cnblogs.com/pandamohist/p/13630613.html)

 

元组，c++11中引入的新的类型，可类比std::pair。 但是std::pair只能支持两个元素。 理论上， 元组支持0~任意个元素。 

　　本文演示环境： VS2015 up3

## 0、头文件[#](https://www.cnblogs.com/pandamohist/p/13630613.html#1005345410)

```
#include <tuple>
```

 

## 1、创建和初始化[#](https://www.cnblogs.com/pandamohist/p/13630613.html#3490635237)

　　1.1、创建一个空的元组， 创建时，需要指定元组的数据类型。

```
std::tuple<int, float, double, long, long long> first;
```

　　1.2 、创建一个元组并初始化元组。　　

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
1     std::string str_second_1("_1");
2     std::string str_second_2("_2");
3 
4     // 指定了元素类型为引用 和 std::string, 下面两种方式都是可以的，只不过第二个参数不同而已
5     std::tuple<std::string, std::string> second_1(str_second_1, std::string("_2"));
6     std::tuple<std::string, std::string> second_2(str_second_1, str_second_2);
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

　　1.3、创建一个元素是引用的元组

```
1     //3、创建一个元组，元组的元素可以被引用, 这里以 int 为例
2     int i_third = 3;
3     std::tuple<int&> third(std::ref(i_third));
```

　　1.4、使用make_tuple创建元组

```
1     int i_fourth_1 = 4;
2     int i_fourth_2 = 44;
3     // 下面的两种方式都可以
4     std::tuple<int, int> forth_1    = std::make_tuple(i_fourth_1, i_fourth_2);
5     auto forth_2                    = std::make_tuple(i_fourth_1, i_fourth_2);
```

　　1.5、创建一个类型为引用的元组， 对元组的修改。 这里以 std::string为例

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1     std::string str_five_1("five_1");
 2     // 输出原址值
 3     std::cout << "str_five_1 = " << str_five_1.c_str() << "\n";
 4 
 5     std::tuple<std::string&, int> five(str_five_1, 5);
 6     // 通过元组 对第一个元素的修改，str_five_1的值也会跟着修改，因为元组的第一个元素类型为引用。
 7     // 使用get访问元组的第一个元素
 8     std::get<0>(five) = "five_2";
 9 
10     // 输出的将是： five_2
11     std::cout << "str_five_1 = " << str_five_1.c_str() << "\n";
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

　　输出结果（VS2015 up3输出）：

[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908091903048-1019385199.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908091903048-1019385199.png)

 

2、计算元组的元素个数

　　需要函数： std::tuple_size。 下面是一个例子， 

```
1     std::tuple<char, int, long, std::string> first('A', 2, 3, "4");
2         // 使用std::tuple_size计算元组个数
3         int i_count = std::tuple_size<decltype(first)>::value;
4         std::cout << "元组个数=" << i_count << "\n";
```

　　输出结果：

[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908092840820-1133471578.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908092840820-1133471578.png)

 

## 3、访问元素[#](https://www.cnblogs.com/pandamohist/p/13630613.html#2931821665)

　　访问元组的元素，需要函数： std::get<index>(obj)。其中：【index】是元组中元素的下标，0 ，1 ， 2， 3， 4，....   【obj】-元组变量。 　

　　一个例子：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
1 std::tuple<char, int, long, std::string> second('A', 2, 3, "4");
2 int index = 0;
3 std::cout << index++ << " = " << std::get<0>(second) << "\n";
4 std::cout << index++ << " = " << std::get<1>(second) << "\n";
5 std::cout << index++ << " = " << std::get<2>(second) << "\n";
6 std::cout << index++ << " = " << std::get<3>(second).c_str() << "\n";
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

　　输出结果：

[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908093806764-2064521107.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908093806764-2064521107.png)

　　【**注意**】元组**不支持**迭代访问， 且只能通过索引（或者tie解包：将元组的中每一个元素提取到指定变量中）访问， 且索引**不能**动态传入。上面的代码中，索引都是在编译器编译期间就确定了。 下面的演示代码将会在编译期间出错。

```
for (int i = 0; i < 3; i++)
        std::cout << index++ << " = " << std::get<i>(second) << "\n";　　// 无法通过编译
```

　　

## 4、获取元素的类型[#](https://www.cnblogs.com/pandamohist/p/13630613.html#2137153913)

　　获取元组中某个元素的数据类型，需要用到另外一个类型： std::tuple_element 。 语法： std::tuple_element<index, tuple> 。 【index】-元组中元素的索引，【tuple】哪一个元组

　　一个例子：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
1 std::tuple<int, std::string> third(9, std::string("ABC"));
2 
3 // 得到元组第1个元素的类型，用元组第一个元素的类型声明一个变量
4 std::tuple_element<1, decltype(third)>::type val_1;
5 
6 // 获取元组的第一个元素的值
7 val_1 = std::get<1>(third);
8 std::cout << "val_1 = " << val_1.c_str() << "\n";
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

　　输出结果：

[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908095558921-1861873773.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908095558921-1861873773.png)

　　　用获取元组第一个元素的类型声明了一个变量，再对变量赋值。

 

## 5、使用 std::tie解包[#](https://www.cnblogs.com/pandamohist/p/13630613.html#481120311)

　　元组，可以看作一个包，类比结构体。 需要访问元组的元素时，2 种方法： A、索引访问，B、std::tie 。

　　元组包含一个或者多个元素，使用std::tie解包： 首先需要定义对应元素的变量，再使用tie。 比如，元素第0个元素的类型时 char, 第1个元素类型时int, 那么， 需要定义 一个 char的变量和int的变量， 用来储存解包元素的结果。 

　　一个例子：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 std::tuple<char, int, long, std::string> fourth('A', 2, 3, "4");
 2 
 3 // 定义变量，保存解包结果
 4 char tuple_0    = '0';
 5 int tuple_1        = 0;
 6 long tuple_2    = 0;
 7 std::string tuple_3("");
 8 
 9 // 使用std::tie, 依次传入对应的解包变量
10 std::tie(tuple_0, tuple_1, tuple_2, tuple_3) = fourth;
11 
12 // 输出解包结果
13 std::cout << "tuple_0 = " << tuple_0 << "\n";
14 std::cout << "tuple_1 = " << tuple_1 << "\n";
15 std::cout << "tuple_2 = " << tuple_2 << "\n";
16 std::cout << "tuple_3 = " << tuple_3.c_str() << "\n";
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

　　输出结果：
[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908100848991-1247269133.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908100848991-1247269133.png)

　　说到 std::tie , 看下 VS2015 up3中的定义：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
1 template<class... _Types> inline
2     constexpr tuple<_Types&...>
3         tie(_Types&... _Args) _NOEXCEPT
4     {    // make tuple from elements
5     typedef tuple<_Types&...> _Ttype;
6     return (_Ttype(_Args...));
7     }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

　　接着 std::tie 解包。 如果一个元组，只需要取出其中特定位置上的元素，不用把每一个元素取出来， 怎么做？ 

　　比如： 只要索引为 偶数的元素。

　　元组提供了类似占位符的功能： **std::ignore** 。满足上面的需求，只需要在索引为奇数的位置填上 **std::ignore** 。 一个例子：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 std::tuple<char, int, long, std::string> fourth('A', 2, 3, "4");
 2         
 3 // 定义变量，保存解包结果
 4 char tuple_0    = '0';
 5 int tuple_1        = 0;
 6 long tuple_2    = 0;
 7 std::string tuple_3("");
 8 
 9 // 使用占位符
10 std::tie(tuple_0, std::ignore, tuple_2, std::ignore) = fourth;
11 
12 // 输出解包结果
13 std::cout << "tuple_0 = " << tuple_0 << "\n";
14 std::cout << "tuple_1 = " << tuple_1 << "\n";
15 std::cout << "tuple_2 = " << tuple_2 << "\n";
16 std::cout << "tuple_3 = " << tuple_3.c_str() << "\n";
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

　　输出结果：

[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908101823196-558442361.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908101823196-558442361.png)

　　

## 6、元组连接（拼接）[#](https://www.cnblogs.com/pandamohist/p/13630613.html#275619927)

　　使用 std::tuple_cat 执行拼接

　　一个例子：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 std::tuple<char, int, double> first('A', 1, 2.2f);
 2 
 3 // 组合到一起, 使用auto， 自动推导
 4 auto second = std::tuple_cat(first, std::make_tuple('B', std::string("-=+")));
 5 // 组合到一起，可以知道每一个元素的数据类型时什么 与 auto推导效果一样
 6 std::tuple<char, int, double, char, std::string> third = std::tuple_cat(first, std::make_tuple('B', std::string("-=+")));
 7 
 8 // 输出合并后的元组内容
 9 int index = 0;
10 std::cout << index++ << " = " << std::get<0>(second) << "\n";
11 std::cout << index++ << " = " << std::get<1>(second) << "\n";
12 std::cout << index++ << " = " << std::get<2>(second) << "\n";
13 
14 std::cout << index++ << " = " << std::get<3>(second) << "\n";
15 std::cout << index++ << " = " << std::get<4>(second).c_str() << "\n";
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

　　输出结果：

[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908103752661-1751689449.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908103752661-1751689449.png)

 

## 7、遍历[#](https://www.cnblogs.com/pandamohist/p/13630613.html#3601031234)

　　这里将采用的时 递归遍历，需要注意，考虑爆栈的情况。其实，tuple也是基于模板的STL容器。 因为其可以容纳多个参数，且每个参数类型可不相同，遍历输出则涉及到参数展开的情况，这里以递归的方式实现遍历， 核心代码：

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

```
 1 template<typename Tuple, size_t N>
 2 struct tuple_show
 3 {
 4     static void show(const Tuple &t, std::ostream& os)
 5     {
 6         tuple_show<Tuple, N - 1>::show(t, os);
 7         os << ", " << std::get<N - 1>(t);
 8     }
 9 };
10 
11 
12 // 偏特性，可以理解为递归的终止
13 template<typename Tuple>
14 struct tuple_show < Tuple, 1>
15 {
16     static void show(const Tuple &t, std::ostream &os)
17     {
18         os <<  std::get<0>(t);
19     }
20 };
21 
22 
23 
24 // 自己写个函数，调用上面的递归展开，
25 template<typename... Args>
26 std::ostream& operator << (std::ostream &os, const std::tuple<Args...>& t)
27 {
28     os << "[";
29     tuple_show<decltype(t), sizeof...(Args)>::show(t, os);
30     os << "]";
31 
32     return os;
33 }
```

[![复制代码](https://common.cnblogs.com/images/copycode.gif)](javascript:void(0);)

　　调用示例：

```
1     auto t1 = std::make_tuple(1, 'A', "-=+", 2);
2     std::cout << t1;
```

　　输出结果：

[![img](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908234051855-502888564.png)](https://img2020.cnblogs.com/blog/1630599/202009/1630599-20200908234051855-502888564.png)

 

作者：[ mohist](https://www.cnblogs.com/pandamohist/)

出处：https://www.cnblogs.com/pandamohist/p/13630613.html

版权：本站使用「[CC BY 4.0](https://creativecommons.org/licenses/by/4.0)」创作共享协议，未经作者同意，请勿转载；若经同意转载，请在文章明显位置注明作者和出处。

分类: [c++基础知识](https://www.cnblogs.com/pandamohist/category/1826932.html)