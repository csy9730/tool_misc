# c++ 中CRTP的用途

[![creekee](https://picx.zhimg.com/cb617a439139532f1d07b3112ec95e42_l.jpg?source=32738c0c)](https://www.zhihu.com/people/creekee)

[creekee](https://www.zhihu.com/people/creekee)

与苟且安然相处，方能寻得诗和远方。

121 人赞同了该文章

今天我们来聊聊CRTP比较常见的用法，不知道何为CRPT的请看上一篇文章。

[creekee：c++ CRTP（奇异的递归模板模式)介绍52 赞同 · 4 评论文章![img](https://pic1.zhimg.com/v2-1ebd9dd004389a52558271764a8cc979_r.jpg?source=172ae18b)](https://zhuanlan.zhihu.com/p/136258767)

### 1. **静态多态（Static polymorphism）。**

下面通过一个例子来进行说明。

```cpp
template <class T> 
struct Base
{
    void interface()
    {
        // ...
        static_cast<T*>(this)->implementation();
        // ...
    }

    static void static_func()
    {
        // ...
        T::static_sub_func();
        // ...
    }
};

struct Derived : Base<Derived>
{
    void implementation()；

    static void static_sub_func();
};
```

以`Base::interface()` 为例，在`Derived : Base`中，`Base`是先于`Derived`而存在的，所以当`Base::interface()`被申明时，编译器并不知道`Derived`的存在的，但由于此时` Base::interface()` 并不会被实例化。只有当`Base::interface()`被调用时，才会被实例化，而此时编译器也已经知道了 `Derived::implementation()`的声明了。

这里等同于通过查询虚函数动态绑定以达到多态的效果，但省略了动态绑定虚函数查询的时间。

### **2. 轻松地实现各个子类实例创建和析构独立的计数。**

```cpp
template <typename T>
struct counter
{
    static int objects_created;
    static int objects_alive;

    counter()
    {
        ++objects_created;
        ++objects_alive;
    }
    
    counter(const counter&)
    {
        ++objects_created;
        ++objects_alive;
    }
protected:
    ~counter() // objects should never be removed through pointers of this type
    {
        --objects_alive;
    }
};
template <typename T> int counter<T>::objects_created( 0 );
template <typename T> int counter<T>::objects_alive( 0 );

class X : counter<X>
{
    // ...
};

class Y : counter<Y>
{
    // ...
};
```

每次X或者Y实例化时，`counter`或者` counter`就会被调用，对应的就会增加对创建对象的计数。同样，每次X或者Y悉构后，对应的减少`objects_alive`。这里最重要的是实现了对不同子类单独的计数。

### **3. 多态链（Polymorphic chaining）。**

还是通过一个具体的例子来对此进行说明。

```cpp
class Printer
{
public:
    Printer(ostream& pstream) : m_stream(pstream) {}
 
    template <typename T>
    Printer& print(T&& t) { m_stream << t; return *this; }
 
    template <typename T>
    Printer& println(T&& t) { m_stream << t << endl; return *this; }
private:
    ostream& m_stream;
};

class CoutPrinter : public Printer
{
public:
    CoutPrinter() : Printer(cout) {}

    CoutPrinter& SetConsoleColor(Color c)
    {
        // ...
        return *this;
    }
};
```

上面Printer定义打印的方法，`CoutPrinter`是`Printer`的子类，并且添加了一个设置打印颜色的方法。接下来我们看看下面这行代码：

```cpp
CoutPrinter().print("Hello ").SetConsoleColor(Color.red).println("Printer!");
```

前半段`CoutPrinter().print("Hello ")`调用的是`Printer`实例，后面接着`SetConsoleColor(Color.red)`实际上又需要调用`CoutPrinter`实例，这样编译器就会报错。

而CRTP就可以很好的解决这个问题，代码如下：

```cpp
// Base class
template <typename ConcretePrinter>
class Printer
{
public:
    Printer(ostream& pstream) : m_stream(pstream) {}
 
    template <typename T>
    ConcretePrinter& print(T&& t)
    {
        m_stream << t;
        return static_cast<ConcretePrinter&>(*this);
    }
 
    template <typename T>
    ConcretePrinter& println(T&& t)
    {
        m_stream << t << endl;
        return static_cast<ConcretePrinter&>(*this);
    }
private:
    ostream& m_stream;
};
 
// Derived class
class CoutPrinter : public Printer<CoutPrinter>
{
public:
    CoutPrinter() : Printer(cout) {}
 
    CoutPrinter& SetConsoleColor(Color c)
    {
        // ...
        return *this;
    }
};
 
// usage
CoutPrinter().print("Hello ").SetConsoleColor(Color.red).println("Printer!");
```

### **4. 多态的复制构造体（Polymorphic copy construction）。**

当我们用到多态时，经常会需要通过基类的指针来复制子对象。通常我们可以通过在基类里面构造一个`clone()`虚函数，然后在每个子类里面定义这个`clone()`函数。使用CRTP可以让我们避免反复地在子类中去定义`clone()`函数。

```cpp
// Base class has a pure virtual function for cloning
class AbstractShape {
public:
    virtual ~AbstractShape () = default;
    virtual std::unique_ptr<AbstractShape> clone() const = 0;
};

// This CRTP class implements clone() for Derived
template <typename Derived>
class Shape : public AbstractShape {
public:
    std::unique_ptr<AbstractShape> clone() const override {
        return std::make_unique<Derived>(static_cast<Derived const&>(*this));
    }

protected:
   // We make clear Shape class needs to be inherited
   Shape() = default;
   Shape(const Shape&) = default;
};

// Every derived class inherits from CRTP class instead of abstract class

class Square : public Shape<Square>{};

class Circle : public Shape<Circle>{};
```

## **参考文献**

[Curiously recurring template pattern](https://en.wikipedia.org/wiki/Curiously_recurring_template_pattern)



编辑于 2020-12-31 07:48

[C++](https://www.zhihu.com/topic/19584970)

[C++ 编程](https://www.zhihu.com/topic/19836485)

[C++ 应用](https://www.zhihu.com/topic/19629326)