# C++基类的析构函数为何要声明为虚函数

[![算法集市](https://picx.zhimg.com/v2-9f47f8c6d5fb8332042f14bfc5fb4bfc_l.jpg?source=172ae18b)](https://www.zhihu.com/people/zhimakaimencsd)

[算法集市](https://www.zhihu.com/people/zhimakaimencsd)

算法工程师

C++的类中，构造函数用于初始化对象及相关操作，构造函数是不能声明为虚函数的，因为在执行构造函数前对象尚未完成创建，虚函数表还不存在。

析构函数则用于销毁对象完成时相应的资源释放工作，析构函数可以被声明为虚函数。在继承层次中，基类的析构函数一般建议声明为虚函数。

下面通过一个例子来说明下基类析构函数声明为虚函数的必要性。

```cpp
#include <iostream>
using namespace std;

class base {
public:
    base() {
        cout << "base constructor" << endl;
        int *b = new int[5];
    }
    ~base() {
        cout << "base destructor" << endl;
        delete[] b;
    }

private:
    int *b;
};

class derived : public base {
public:
    derived() {
        cout << "derived constructor" << endl;
        int *d = new int[8];
    }
    ~derived() {
        cout << "derived destructor" << endl;
        delete[] d;
    }

private:
    int *d;
};

int main()
{
    base *pBase = new derived;
    cout << "---" << endl;
    delete pBase;

    return 0;
}
```

运行结果：

```text
base constructor
derived constructor
---
base destructor
```

上面定义了两个类：一个基类base，一个派生类derived。

基类和派生类都分别定义了各自的构造函数和析构函数。

基类和派生类中各有一个int型指针成员变量：

- 在基类的构造函数中，给指针变量b分配了5个int型空间；基类的析构函数用于将b所指的空间释放掉；
- 在派生类的构造函数中，指针成员变量d被分配了8个int型空间；派生类的析构函数是为了释放掉d指针所指向的存储空间。

在主函数中创建一个基类类型的指针pBase，指向一个派生类对象，之后释放掉pBase指针所指向的对象的存储空间。

观察程序的运行结果，说明：

- 首先，基类的构造函数被调用（base constructor）；
- 其次，派生类的构造函数也被调用（derived constructor）；
- 最后，基类的析构函数被调用（base destructor）。

但是却没有调用派生类的析构函数，这样会导致d指针所指向的整型存储空间不会被释放，从而造成内存泄漏。

为了解决这个问题，需要**将基类的析构函数声明为虚函数**。修改如下：

```cpp
virtual ~base() {
    cout << "base destructor" << endl;
    delete[] b;
}
```

运行结果：

```cpp
base constructor
derived constructor
---
derived destructor
base destructor
```

将基类的析构函数声明为虚函数之后，派生类的析构函数也自动成为虚析构函数，在主函数中基类指针pBase指向的是派生类对象，当delete释放pBase指针所指向的存储空间时，

- 首先执行派生类的析构函数（derived destructor）；
- 然后执行基类的析构函数（base destructor）。

综上所述，将基类的析构函数设为虚函数，可以保证派生类被正确地释放。



编辑于 2020-06-14 22:07

[虚函数（C++）](https://www.zhihu.com/topic/20029040)

[C++](https://www.zhihu.com/topic/19584970)

[函数构造](https://www.zhihu.com/topic/20030822)