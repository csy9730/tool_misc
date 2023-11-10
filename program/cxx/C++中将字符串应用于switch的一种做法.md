# C++中将字符串应用于switch的一种做法

[![realxie](https://pica.zhimg.com/d063081c97d2055ccb93f12d7a44dc46_l.jpg?source=172ae18b)](https://www.zhihu.com/people/realxie-76)

[realxie](https://www.zhihu.com/people/realxie-76)

创作声明：内容包含虚构创作



10 人赞同了该文章

众所周知，C++中的switch-case仅受可以enum或可隐式转换成整型的数据类型，对于像字符串这种类型则无能无力，但是有些时候我们又需要根据字符串做不同的逻辑。

针对这个需要可以有很多不同的解决方案，比如使用if-else-if-else结构，再比如使用map结构等等。这些都有其局限性，如if-else结构相当比较不清晰，map结构的overhead相对较大。

本文探讨使用switch-case结构来解决这一类型的问题，那么如何解决switch不接受字符串这一事实呢，答案无非是选择一种策略将字符串转换成整型，这里可以选择使用Map，也可以选择hash，从效率的角度来说，hash的性能会更高一些。

因为case接受的是一个常量，因此也需要将目标字符串转换成常量整型，为了达到常量效果，我们需要使用由C++11引入的constexpr这一关键字，具体constexpr的内容不再详细展开，另外由于C++11中对constexpr要求比较苛刻，在实际使用本人使用的是C++14。

首先定义一个hash函数：

```cpp
constexpr std::uint32_t hash_str_to_uint32(const char* data)
{
    std::uint32_t h(0);
    for (int i = 0; data && ('\0' != data[i]); i++)
        h = (h << 6) ^ (h >> 26) ^ data[i];
    return h;
}
```

为什么要constexpr来修饰一下呢？因为如果不使用constexpr，是没有办法做到编译时计算的(编译器相关，clang/gcc在-O2时即使不加constexpr也会对一些简单的函数调用在编译时进行计算，很tricky)。

下面是具体的使用方法

```cpp
StencilOperation Translate(const char* target)
{
    switch (hash_str_to_uint32(target))
    {
        case hash_str_to_uint32("keep"):
            return StencilOperation::KEEP;
        case hash_str_to_uint32("zero"):
            return StencilOperation::ZERO;
        case hash_str_to_uint32("replace"):
            return StencilOperation::REPLACE;
        case hash_str_to_uint32("invert"):
            return StencilOperation::INVERT;
        case hash_str_to_uint32("increment-clamp"):
            return StencilOperation::INCREMENT_CLAMP;
        case hash_str_to_uint32("decrement-clamp"):
            return StencilOperation::DECREMENT_CLAMP;
        case hash_str_to_uint32("increment-wrap"):
            return StencilOperation::INCREMENT_WRAP;
        case hash_str_to_uint32("decrement-wrap"):
            return StencilOperation::DECREMENT_WRAP;
        default:
            return StencilOperation::KEEP;
    }
}
```

上面是一种使用场景，由于不同的字符串可能会被hash成同样的值，因此需要慎重处理，`如果对正确性要求比较严格，需要在case中进行二次判断`，如下所示：

```cpp
case hash_str_to_uint32("increment-clamp"):
    if (strcmp("increment-clamp", target) == 0)
        return StencilOperation::INCREMENT_CLAMP;
    else 
        throw ...;
```

因为这种只是简单的值映射，其实也可以使用unordered_map来映射，效率也一样不错。

发布于 2020-03-27 10:40