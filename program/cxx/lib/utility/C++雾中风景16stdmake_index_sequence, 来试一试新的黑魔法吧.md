# [C++雾中风景16:std::make_index_sequence, 来试一试新的黑魔法吧](https://www.cnblogs.com/happenlee/p/14219925.html)



> C++14在标准库里添加了一个很有意思的元函数: `std::integer_sequence`。并且通过它衍生出了一系列的帮助模板：
> `std::make_integer_sequence`, `std::make_index_sequence`, `std:: index_sequence_for`。在新的黑魔法的加持下，它可以帮助我们完成在编译期间获取了一组编译期整数的工作。
> 接下来请系好安全带，准备发车，和大家聊聊新的黑魔法：`std::make_index_sequence`。

#### 1.what's std::make_index_sequence

##### 1.1 举个栗子

笔者这里先从一个简单的例子展开，先带大家看看`std::make_index_sequence`是如何使用的。

在C++之中有一个很常见的需求，定义一组编译期间的数组作为**常量**，并在运行时或者编译时利用这些常量进行计算。现在假如我们需编译期的一组1到4的平方值。你会怎么办呢？

嗯.... 思考一下，可以这些写：

```cpp
constexpr static size_t const_nums[] = {0, 1, 4, 9, 16};

int main() {
    static_assert(const_nums[3] == 9); 
}
```

Bingo, 这个代码肯定是正确的，但是如果4扩展到了20或者100？怎么办呢？

嗯~~，**先别着急骂脏话**，我们可以用`std::make_index_sequence`和`std::index_sequence`来帮助我们实现这个逻辑：

```cpp
template <size_t ...N>
static constexpr auto square_nums(size_t index, std::index_sequence<N...>) {
    constexpr auto nums = std::array{N * N ...};
    return nums[index];
}

template <size_t N>
constexpr static auto const_nums(size_t index) {
    return square_nums(index, std::make_index_sequence<N>{});
}

int main() {
    static_assert(const_nums<101>(100) == 100 * 100); 
}
```

这代码咋看之下有些吓人，不过没关系，我们来一点点的庖丁解牛的解释清楚它是如何工作的。

##### 1.2 做个解释

我们来拆解一下1.1的代码，首先我们定义了一个`constexpr`的静态函数`const_nums`。它通过我们本文的主角`std::make_index_sequence`来构造了一组`0,1,2,3 .... N - 1`的一组编译器的可变长度的整数列。(注意，这里调用`std::make_index_sequence{}`的构造函数没有任何意义，纯粹只是利用了它能够生成编译期整数列的能力。)
![const_nums函数](https://upload-images.jianshu.io/upload_images/8552201-1b7638a76c8c2f88.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

接着我们来看`squere_num`函数，这就是我们实际进行平方计算，并生成编译期静态数组的地方了，它的实现很简单，就是依次展开通过`std::make_index_sequence`生成的数字，并进行平方计算，最后塞到`std::array`的构造函数之中进行构造。

#### 2. How std::make_index_sequence

通过一个简单的栗子，大家想必已经见识到这个新的黑魔法的独特之处了。接下来，我们进一步的来剖析它的实现吧。

##### 2.1 std::integer_sequence

```cpp
template< class T, T... Ints >
class integer_sequence;
```

要了解`std::make_index_sequence`是如何工作的，就得先看看它的基础类：`std::integer_sequence`。由上面的代码看，它很简单，就是一个`int类型`，加上一组`int数字`，其实原理就是生成一组T类型的编译期间数字序列。**它本质上就是个空类，我们就是要获取这个编译期的数字序列。**

##### 2.2 std::index_sequence

```cpp
template<size_t.. Ints>
using index_sequence = std::integer_sequence<size_t,Ints...>;
```

通常我们不会直接使用`std::integer_sequence`，而是通过定义一个`size_t`的`std::integer_sequnece`命名为`index_sequence`。

##### 2.3 std::make_index_sequence

这里就是生成了一组数字序列`0,1,2,3...N - 1`的一组`std::index_sequence`。然后就可以利用这组序列的数字做任何我们想做的事情了。

那么问题来了，`std::make_index_sequence`是如何实现的呢？

- 可以通过元编程，生成N个元函数类，依次生成0到N - 1的序列，感兴趣的话可以参考这个[链接](https://blog.csdn.net/dboyguan/article/details/51706357)。
- 实际是由编译器内部在编译期间实现的，并不是基于现有的元编程的逻辑。

#### 3.std::make_index_sequence与std::tuple

通过第二节的介绍，想必大家应该了解了std::make_index_sequence的实现原理了。接下来将介绍它最为重要的使用场景:与**tuple**的结合。

现在请大家思考一个问题：**如何遍历一个std::tuple**。（不能使用C++17的`std::apply`）

这个时候就要再次请出我们今天的主角，使用`std::make_index_sequnce`和lambda表达式来完成这个工作了。我们来看下面这部分代码：

```cpp
template <typename Tuple, typename Func, size_t ... N>
void func_call_tuple(const Tuple& t, Func&& func, std::index_sequence<N...>) {
    static_cast<void>(std::initializer_list<int>{(func(std::get<N>(t)), 0)...});
}

template <typename ... Args, typename Func>
void travel_tuple(const std::tuple<Args...>& t, Func&& func) {
    func_call_tuple(t, std::forward<Func>(func), std::make_index_sequence<sizeof...(Args)>{});
}

int main() {
    auto t = std::make_tuple(1, 4.56, "happen lee");
    travel_tuple(t, [](auto&& item) {
        std::cout << item << ",";
    });
}
```

- 这个代码首先定义了一个`travel_tuple`的函数，并且利用了`std::make_index_sequence`将tuple类型的参数个数进行了展开，生成了0到N - 1的编译期数字。
- 接下来我们再利用`func_call_tuple`函数和展开的编译期数字，依次调用`std::get(tuple)`,并且通过lambda表达式依次的调用，完成了遍历tuple的逻辑。

嗯，标准库表示它也是这样想的，所以C++17利用了`std::make_index_sequence`实现了`std::apply`,开启了满屏幕堆满tuple的C++新时代了~~

#### 4.小结

C++14新提供的`std::make_index_sequence`给了我们在编译期操作tuple提供了更加便利的工具，并且在编译期间的整数列也能够帮助我们实现更多新的黑魔法。

大家可以尝试自己用元编程实现了一个`std::make_index_sequence`， 笔者觉得这是一个很有意思的挑战。

关于`std::make_index_sequence`就聊到这里。希望大家能够有所收获，笔者水平有限。成文之处难免有理解谬误之处，欢迎大家多多讨论，指教。

#### 5.参考资料

[cppreference](https://en.cppreference.com/w/cpp/utility/integer_sequence)
[make_index_sequence的原理](https://blog.csdn.net/dboyguan/article/details/51706357)

分类: [C++](https://www.cnblogs.com/happenlee/category/1102510.html)