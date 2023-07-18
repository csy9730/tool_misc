# c++ 类型擦除

[![叶余](https://pic1.zhimg.com/v2-b959568f523c545c6ccabdd02017a49a_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/zmw-3727)

[叶余](https://www.zhihu.com/people/zmw-3727)

一直在模仿，从来不专业



12 人赞同了该文章

**什么是类型擦除？**

类型擦除就是将原有类型消除或者隐藏。

**为什么要类型擦除？**

因为很多时候并不需要关心具体类型是什么或者根本就不需要这个类型，通过类型擦除可以获取很多好处，例如更好的扩展性、消除耦合以及一些重复行为，使程序更加简洁高效。

**c++中类型擦除方式主要有以下五种：**

- 多态
- 模板
- 容器
- 通用类型
- 闭包

### **通过多态擦除类型**

该方式最简单也是经常用的，将派生类型隐式转换成基类型，再通过基类去多态的调用行为。

在这种情况下，不用关心派生类的具体类型，只需要以统一的方式去做不同的事情，所以就把派生类型转成基类型隐藏起来，这样不仅仅可以多态调用还使程序具有良好的可扩展性。

然而这种方式的类型擦除仅仅是部分的类型擦除，因为基类型仍然存在，而且这种类型擦除的方式必须是继承的方式，继承使得两个对象强烈的耦合在一起。所以通过多态来擦除类型的方式有较多局限性。

### **通过模板擦除类型**

该方式本质上是对不同类型的共同行为进行抽象，不同类型彼此之间不需要通过继承这种强耦合的方式去获得共同的行为。仅通过模板就能获取共同行为，降低不同类型之间的耦合，是一种很好的类型擦除方式。

然而，虽然降低了对象间的耦合，但是基本类型始终需要指定，并没有消除基本类型。

### **通过容器擦除类型**

boost.variant 可以把各种类型包起来，从而获得一种统一的类型，而且不同类型的对象间没有耦合关系，它仅仅是一个类型的容器。示例：

```cpp
struct blob
{
    const char *pBuf;
    int size;
};

//定义通用的类型，这个类型可能容纳多种类型
typedef boost::variant<double, int, uint32_t, sqlite3_int64, char*, blob, NullType>Value;

vector<Value> vt; //通用类型的容器，这个容器现在就可以容纳上面的那些类型的对象了
vt.push_back(1);
vt.push_back("test");
vt.push_back(1.22);
vt.push_back({"test", 4}); 
```

示例中擦除了不同类型，使得不同的类型都可以放到一个容器中。取值的时候，通过get<T>（Value）就可以获取对应类型的值。

这种方式是通过某种容器把类型包起来，从而达到类型擦除的目的。缺点是这个通用的类型必须事先定义好，只能容纳声明的类型，增加一种新类型就不行了。

### **通过通用类型擦除类型**

该方式可以消除容器擦除类型的缺点，类似于c#和java中的object类型。这种通用类型是通过boost.any实现的，它不需要预先定义类型，不同类型都可以转成any。示例：

```cpp
unordered_map<string, boost::any> m_creatorMap;
m_creatorMap.insert(make_pair(strKey, new T)); //T may be any type

boost::any obj = m_creatorMap[strKey];
T t = boost::any_cast<T>(obj);
```

但是还存一个缺点，就是取值的时候仍然依赖于具体类型，无论是通过get<T>还是any_case<T>，都需要T的具体类型，这在某种情况下仍然有局限性。

### **通过闭包擦除类型**

闭包可以称为匿名函数或lamda表达式，c++11中的lamda表达式就是c++中的闭包。

c++11引入lamda，实际上引入了函数式编程的概念，函数式编程有很多优点，使代码更简洁，而且声明式的编码方式更贴近人的思维方式。函数式编程在更高的层次上对不同类型的公共行为进行了抽象，从而使我们不必去关心具体类型。示例：

```cpp
std::map<int, std::function <void()>> m_freeMap; //保存返回出去的内存块

template<typename R, typename T>
R GetResult()
{
    R result = GetTable<R, T>();    

    m_freeMap.insert(std::make_pair(result.sequenceId, [this, result]
    {
        FreeResult(result);        
    }));
}

bool FreeResultById(int& memId)
{
    auto it = m_freeMap.find(memId);
    if (it == m_freeMap.end())
        return false;

    it->second();       //delete by lamda
    m_freeMap.erase(memId);

    return true;
}   
```

**总结**

通过闭包去擦除类型，可以解决前面四种擦除方式遇到的问题，优雅而简单！

编辑于 2019-12-26 19:28

C++ 入门

C++ 编程

C++