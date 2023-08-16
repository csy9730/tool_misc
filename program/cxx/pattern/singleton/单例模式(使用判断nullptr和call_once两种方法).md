# [单例模式(使用判断nullptr和call_once两种方法)](https://www.cnblogs.com/Stephen-Qin/p/14642192.html)

转载请注明: https://blog.csdn.net/Stephen___Qin/article/details/115583694

#### 使用判断nullptr (这一种不能保证线程安全,说有双重锁定检测问题,待进一步学习)

```cpp
#include <thread>
#include <iostream>
using namespace std;

class Singleton
{
private:
    Singleton()
    {
    }
    
    static Singleton * m_singleton;//C++类中不可以定义自己类的对象,但是可以定义自己类的指针和引用.
    
public:
    static Singleton * getInstance();
};

Singleton * Singleton::m_singleton = nullptr;
Singleton * Singleton::getInstance()
{
    if(m_singleton == nullptr)
        m_singleton = new Singleton();
    
    return m_singleton;
}

int main()
{
    Singleton* pst = Singleton::getInstance();
    Singleton st;    //会报错,不允许其他方式生成该类的对象
}
```

注意:
1.构造函数要定义为private,这样就无法创建对象,保证只能通过类名来访问单例.
2.static变量需要在类外初始化.为什么呢?因为静态变量不属于某个对象,而是属于类,如果放在类内初始化,则变成了这个对象的了,这就和之前的假设矛盾了

#### 使用call_once(这一种是线程安全的)

```cpp
#include <thread>
#include <iostream>
#include <mutex>	
using namespace std;

static std::once_flag of;

class Singleton
{
private:
    Singleton()
    {
    }
    
    static Singleton * m_singleton;
    
public:
    static Singleton * getInstance();
};

Singleton * Singleton::m_singleton = nullptr;

Singleton * Singleton::getInstance()
{
    std::call_once(of, []()
    {
        m_singleton = new Singleton();    
    }
    );

    return m_singleton;
}

void ThreadFunc()
{
    Singleton *s = Singleton::getInstance();
    std::cout << "s:" << s << std::endl;
}

int main()
{
    thread t1(ThreadFunc);
    t1.join();

    thread t2(ThreadFunc);
    t2.join();

    thread t3(ThreadFunc);
    t3.join();

    return 0;
}
```

注意:
1.call_once和once_flag的头文件是<mutex>
2.once_flag定义为static或者全局对象,否则不同线程间不可见,则无法起到作用.

参考文章:
https://zhuanlan.zhihu.com/p/71900518

新战场:https://blog.csdn.net/Stephen___Qin

分类: [C++](https://www.cnblogs.com/Stephen-Qin/category/1221954.html) , [多线程](https://www.cnblogs.com/Stephen-Qin/category/1529475.html) , [设计模式](https://www.cnblogs.com/Stephen-Qin/category/1557669.html)