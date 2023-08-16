# 算法


## 查找算法

### find find_if
1) 简单查找算法，要求输入迭代器（input iterator）

unaryPred 可以是函数，仿函数，匿名函数。
``` cpp
template< class InputIt, class T >
InputIt find( InputIt first, InputIt last, const T& value );


template< class InputIt, class UnaryPredicate >
constexpr InputIt find_if( InputIt first, InputIt last, UnaryPredicate p );


```

> 1) find searches for an element equal to value (using operator==)
> 3) find_if searches for an element for which predicate p returns true
> 5) find_if_not searches for an element for which predicate q returns false



```cpp
// 返回一个迭代器，指向输入序列中第一个等于 val 的元素，未找到返回 end
find(beg, end, val); 

// 返回一个迭代器，指向第一个满足 unaryPred 的元素，未找到返回 end
find_if(beg, end, unaryPred);

// 返回一个迭代器，指向第一个令 unaryPred 为 false 的元素，未找到返回 end
find_if_not(beg, end, unaryPred); 

count(beg, end, val); // 返回一个计数器，指出 val 出现了多少次

count_if(beg, end, unaryPred); // 统计有多少个元素满足 unaryPred

// 返回一个 bool 值，判断是否所有元素都满足 unaryPred
all_of(beg, end, unaryPred);

// 返回一个 bool 值，判断是否任意（存在）一个元素满足 unaryPred
any_of(beg, end, unaryPred);

// 返回一个 bool 值，判断是否所有元素都不满足 unaryPred
none_of(beg, end, unaryPred);
```


按如下方式使用 find_if() 来查找 numbers 中第一个大于 value 的元素
``` cpp
int value {5};
auto iter1 = std::find_if(std::begin(numbers), std::end(numbers),[value](int n) { return n > value; });
if(iter1 != std::end(numbers))
    std::cout << *iter1 << " was found greater than " << value << ".\n";
```

### 查找重复值的算法
查找重复值的算法，传入向前迭代器（forward iterator）

```cpp
// 返回指向第一对相邻重复元素的迭代器，无相邻元素则返回 end
adjacent_find(beg, end); 

// 返回指向第一对相邻重复元素的迭代器，无相邻元素则返回 end
adjacent_find(beg, end, binaryPred);


```
> Elements are compared using operator==.


adjacent_find() 函数用于在指定范围内查找 2 个连续相等的元素. 对于 {5,20,5,30,30,20,10,10,20 }数组，第一次会发现30，第二次会发现10


find_end() 函数定义在<algorithm>头文件中，常用于在序列 A 中查找序列 B 最后一次出现的位置。例如，有如下 2 个序列：
序列 A：1,2,3,4,5,1,2,3,4,5
序列 B：1,2,3

通过观察不难发现，序列 B 在序列 A 中出现了 2 次，而借助 find_end() 函数，可以轻松的得到序列 A 中最后一个（也就是第 2 个） {1,2,3}。
#### demo

``` cpp
#include <algorithm>
#include <functional>
#include <iostream>
#include <vector>
 
int main()
{
    std::vector<int> v1 {0, 1, 2, 3, 40, 40, 41, 41, 5};
 
    auto i1 = std::adjacent_find(v1.begin(), v1.end());
 
    if (i1 == v1.end())
        std::cout << "No matching adjacent elements\n";
    else
        std::cout << "The first adjacent pair of equal elements is at "
                  << std::distance(v1.begin(), i1) << ", *i1 = "
                  << *i1 << '\n';
 
    auto i2 = std::adjacent_find(v1.begin(), v1.end(), std::greater<int>());
    if (i2 == v1.end())
        std::cout << "The entire vector is sorted in ascending order\n";
    else
        std::cout << "The last element in the non-decreasing subsequence is at "
                  << std::distance(v1.begin(), i2) << ", *i2 = " << *i2 << '\n';
}
```
Output:
```
The first adjacent pair of equal elements is at 4, *i1 = 40
The last element in the non-decreasing subsequence is at 7, *i2 = 41
```

当前元素大于后一个的元素，则返回。 显然 41>5, 则返回7号索引的41 .
#### demo

``` cpp
#include <algorithm>
#include <iostream>
#include <iterator>
 
template<class Container, class Size, class T>
[[nodiscard]]
constexpr bool consecutive_values(const Container& c, Size count, const T& v)
{
    return std::search_n(std::begin(c), std::end(c), count, v) != std::end(c);
}
 
int main()
{
    constexpr char sequence[] = "1001010100010101001010101";
 
    static_assert(consecutive_values(sequence, 3, '0'));
 
    std::cout << std::boolalpha
              << "Has 4 consecutive zeros: "
              << consecutive_values(sequence, 4, '0') << '\n'
              << "Has 3 consecutive zeros: "
              << consecutive_values(sequence, 3, '0') << '\n';
}
```

```
Has 4 consecutive zeros: false
Has 3 consecutive zeros: true
```

### search_n

``` cpp
// 返回一个迭代器，从此位置开始有 count 个相等元素，不存在则返回 end
search_n(beg, end, count, val);

// 返回一个迭代器，从此位置开始有 count 个相等元素，不存在则返回 end
search_n(beg, end, count, val, binaryPred);
```


search() 函数定义在<algorithm>头文件中，其功能恰好和 find_end() 函数相反，用于在序列 A 中查找序列 B 第一次出现的位置。

例如，仍以如下两个序列为例：
序列 A：1,2,3,4,5,1,2,3,4,5
序列 B：1,2,3

可以看到，序列 B 在序列 A 中出现了 2 次。借助 find_end() 函数，我们可以找到序列 A 中最后一个（也就是第 2 个）{1,2,3}；而借助 search() 函数，我们可以找到序列 A 中第 1 个 {1,2,3}。


在某些情境中，我们可能需要在 A 序列中查找和 B 序列中任意元素相匹配的第一个元素，这时就可以使用 find_first_of() 函数。

双循环搜索。虽然是双循环搜索，但是并不会返回双指针，只会返回A序列的指针，不返回B序列的指针。
### search

#### demo
``` cpp
#include <algorithm>
#include <functional>
#include <iomanip>
#include <iostream>
#include <string_view>
#include <vector>
 
using namespace std::literals;
 
bool contains(const auto& cont, std::string_view s)
{
    // str.find() (or str.contains(), since C++23) can be used as well
    return std::search(cont.begin(), cont.end(), s.begin(), s.end()) != cont.end();
}
 
int main()
{
    const auto str{"why waste time learning, when ignorance is instantaneous?"sv};
 
    std::cout << std::boolalpha
              << contains(str, "learning") << '\n'  // true
              << contains(str, "lemming")  << '\n'; // false
 
    const std::vector vec(str.begin(), str.end());
    std::cout << contains(vec, "learning") << '\n'  // true
              << contains(vec, "leaning")  << '\n'; // false
 
    // The C++17 overload with searchers demo:
    constexpr auto haystack
    {
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed "
        "do eiusmod tempor incididunt ut labore et dolore magna aliqua"sv
    };
 
    for (const auto needle : {"pisci"sv, "Pisci"sv})
    {
        const std::boyer_moore_searcher searcher(needle.begin(), needle.end());
        const auto it = std::search(haystack.begin(), haystack.end(), searcher);
        std::cout << "The string " << std::quoted(needle) << ' ';
        if (it == haystack.end())
            std::cout << "not found\n";
        else
            std::cout << "found at offset " << it - haystack.begin() << '\n';
    }
}
```


## 二分搜索算法

二分搜索算法，传入前向迭代器或随机访问迭代器（random-access iterator），要求序列中的元素已经是有序的

```cpp
// 返回一个非递减序列 [beg, end) 中的第一个大于等于值 val 的位置的迭代器，不存在则返回 end
lower_bound(beg, end, val); 
 
// 返回一个非递减序列 [beg, end) 中的第一个大于等于值 val 的位置的迭代器，不存在则返回 end
lower_bound(beg, end, val, comp);

// 返回一个非递减序列 [beg, end) 中第一个大于 val 的位置的迭代器，不存在则返回 end
upper_bound(beg, end, val);

// 返回一个非递减序列 [beg, end) 中第一个大于 val 的位置的迭代器，不存在则返回 end
upper_bound(beg, end, val, comp);

// 返回一个 pair，其 first 成员是 lower_bound 返回的迭代器，其 second 成员是 upper_bound 返回的迭代器
equal_range(beg, end, val);

// 返回一个 bool 值，指出序列中是否包含等于 val 的元素。对于两个值 x 和 y，当 x 不小于 y 且 y 也不小于 x 时，认为它们相等
binary_search(beg, end, val); 
```

equal_range 可以搜索有序序列中指定值，返回首个指针和尾部指针。对于序列{1,2,3,4,4,4,5,6,7}，查询4，返回左指针3和右指针6
### lower_bound

lower_bound 可以从给定的有序序列中，找到目标值的上确界，即目标值 <= 序列值[索引]

upper_bound 可以从给定的有序序列中，找到目标值的上界，即目标值 < 序列值[索引]


#### code
``` cpp
template<class ForwardIt, class T>
ForwardIt upper_bound(ForwardIt first, ForwardIt last, const T& value)
{
    ForwardIt it;
    typename std::iterator_traits<ForwardIt>::difference_type count, step;
    count = std::distance(first, last);
 
    while (count > 0)
    {
        it = first; 
        step = count / 2; 
        std::advance(it, step);
 
        if (!(value < *it))
        {
            first = ++it;
            count -= step + 1;
        } 
        else
            count = step;
    }
 
    return first;
}
```


#### demo

``` cpp
#include <algorithm>
#include <iostream>
#include <vector>
 
struct PriceInfo { double price; };
 
int main()
{
    const std::vector<int> data{1, 2, 4, 5, 5, 6};
 
    for (int i = 0; i < 8; ++i)
    {
        // Search for first element x such that i ≤ x
        auto lower = std::lower_bound(data.begin(), data.end(), i);
 
        std::cout << i << " ≤ ";
        lower != data.end()
            ? std::cout << *lower << " at index " << std::distance(data.begin(), lower)
            : std::cout << "not found";
        std::cout << '\n';
    }
 
    std::vector<PriceInfo> prices{{100.0}, {101.5}, {102.5}, {102.5}, {107.3}};
 
    for (double to_find : {102.5, 110.2})
    {
        auto prc_info = std::lower_bound(prices.begin(), prices.end(), to_find,
            [](const PriceInfo& info, double value)
            {
                return info.price < value;
            });
 
        prc_info != prices.end()
            ? std::cout << prc_info->price << " at index " << prc_info - prices.begin()
            : std::cout << to_find << " not found";
        std::cout << '\n';
    }
}
```

```
0 ≤ 1 at index 0
1 ≤ 1 at index 0
2 ≤ 2 at index 1
3 ≤ 4 at index 2
4 ≤ 4 at index 2
5 ≤ 5 at index 3
6 ≤ 6 at index 5
7 ≤ not found
102.5 at index 2
110.2 not found
```


### 如何搜索下确界
如何搜索 下确界？即序列值[索引]  <= 目标值 < 序列值[索引+1]
 - 使用 lower_bound 搜索 reverse 反向序列，数值取负（使小于运算变成大于运算）
 - 反向搜索
 - 正向搜索


## 排序算法
4) 排序算法，要求随机访问迭代器（random-access iterator）

```cpp
sort(beg, end); // 排序整个范围
stable_sort(beg, end); // 排序整个范围（稳定排序）
sort(beg, end, comp); // 排序整个范围
stable_sort(beg, end, comp); // 排序整个范围（稳定排序）

// 返回一个 bool 值，指出整个输入序列是否有序
is_sorted(beg, end);
 
// 返回一个 bool 值，指出整个输入序列是否有序
is_sorted(beg, end, comp);
 
// 在输入序列中査找最长初始有序子序列，并返回子序列的尾后迭代器
is_sorted_until(beg, end);

// 在输入序列中査找最长初始有序子序列，并返回子序列的尾后迭代器
is_sorted_until(beg, end, comp);

// 排序 mid-beg 个元素。即，如果 mid-beg 等于 42，则此函数将值最小的 42 个元素有序放在序列前 42 个位置
partial_sort(beg, mid, end); 

// 排序 mid-beg 个元素。即，如果 mid-beg 等于 42，则此函数将值最小的 42 个元素有序放在序列前 42 个位置
partial_sort(beg, mid, end, comp);

// 排序输入范围中的元素，并将足够多的已排序元素放到 destBeg 和 destEnd 所指示的序列中
partial_sort_copy(beg, end, destBeg, destEnd);

// 排序输入范围中的元素，并将足够多的已排序元素放到 destBeg 和 destEnd 所指示的序列中
partial_sort_copy(beg, end, destBeg, destEnd, comp);

// nth 是一个迭代器，指向输入序列中第 n 大的元素。nth 之前的元素都小于等于它，而之后的元素都大于等于它
nth_element(beg, nth, end);

// nth 是一个迭代器，指向输入序列中第 n 大的元素。nth 之前的元素都小于等于它，而之后的元素都大于等于它
nth_element(beg, nth, end, comp);
```

其他还有只读算法，使用输入迭代器的写算法，划分算法，使用前向迭代器的重排算法，使用双向迭代器的重排算法，使用随机访问迭代器的重排算法，最小值和最大值等，请参考：

[唐唐：STL总结与常见面试题+资料38 赞同 · 0 评论文章](https://zhuanlan.zhihu.com/p/147676383)
