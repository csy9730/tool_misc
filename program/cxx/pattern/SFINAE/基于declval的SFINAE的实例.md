#  基于declval的SFINAE的实例



作者：杜紫童
链接：https://www.zhihu.com/question/447107869/answer/1757635568
来源：知乎
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。



首先，并没有 `declvalue` 这个东西，我猜你想问的是 `std::declval`。 

简单地说，`decltype`是根据变量获得其类型，典型的用法是`using type = decltype(a)`；

`std::declval`是根据类型获得[基变量](https://www.zhihu.com/search?q=基变量&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1757635568})，典型的用法是`auto&& a = std::declval();`。

另外，由于`std::declval`并没有定义，所以仅能用于模板推导中。 

举个例子，有两个类如下：

```cpp
struct device1
{
	int get_id() const
	{
		return 1;
	}
	std::string get_name() const
	{
		return "device1"s;
	}
};

struct device2
{
	int get_id() const
	{
		return 2;
	}
};
```

假设在输出日志时，对某一种device，有`get_name`时，输出其[返回值](https://www.zhihu.com/search?q=返回值&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1757635568})；否则，输出其id，即`get_id`。

在使用[静态多态](https://www.zhihu.com/search?q=静态多态&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1757635568})的前提下，要实现该功能，需要一些[辅助工具](https://www.zhihu.com/search?q=辅助工具&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"answer"%2C"sourceId"%3A1757635568})，将会用到`decltype`和`std::declval`：

```cpp
// 注意 std::void_t 需要 C++14
template<class T, class = void>
struct has_get_name :std::false_type
{};

template<class T>
struct has_get_name<T, std::void_t<decltype(std::declval<T>().get_name())>> :std::true_type
{};
```

此时

```cpp
constexpr auto b1 = has_get_name<device1>::value; // true
constexpr auto b2 = has_get_name<device2>::value; // false
```

然后简单粗暴（SFINAE）地使用两个模板来得到输出的内容：

```cpp
template<class T, typename std::enable_if<has_get_name<T>::value, int>::type = 0>
std::string make_name(const T& device)
{
	return device.get_name();
}

template<class T, typename std::enable_if<!has_get_name<T>::value, int>::type = 0>
std::string make_name(const T& device)
{
	return "device (id: "s + std::to_string(device.get_id()) + ")"s;
}

// result
device1 d1;
device2 d2;
auto name1 = make_name(d1); // "device 1"
auto name2 = make_name(d2); // "device (id: 2)"
```

以下是废话。

到了C++20，通过Concept，可以更简单地搞SFINAE了。

```cpp
// C++20
template<class T>
concept has_get_name = requires(T a) { a.get_name(); };

template<class T>
concept has_no_get_name = !has_get_name<T>;

template<has_get_name T>
std::string make_name(const T& device)
{
	return device.get_name();
}

template<has_no_get_name T>
std::string make_name(const T& device)
{
	return std::format("device (id: {})", device.get_id());
}
```

如果搭配上C++17的`constexpr if`，代码会更简单：

```cpp
template<class T>
concept has_get_name = requires(T a) { a.get_name(); };

template<class T> 
std::string make_name(const T& device)
{
	if constexpr (has_get_name<T>)
	{
		return device.get_name();
	}
	else
	{
		return std::format("device (id: {})", device.get_id());
	}
}
```

好像跑题了？