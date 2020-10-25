# c++ 笔记


### misc

区分 对象的移动和对象的复制。


## 类class
### 构造函数
* 默认构造函数(无参数)
* 带参数构造函数
* 复制构造函数

前置构造classname(): a(val){};
new构造
const修饰


构造函数需要设为public，设为private或protect会导致不可用。
没有默认构造函数和复制构造函数，会导致该类难以使用，使该类用途受限。
通过把构造函数设为private，实现一些功能禁用。

#### 复制构造函数
复制构造函数又叫做拷贝构造函数
如果一个构造函数的第一个参数是自身类类型的引用，且任何额外的参数都有默认值，则此构造函数是拷贝构造函数。（C++ premier里的定义）

拷贝构造函数应用的场景：
* 用一个对象初始化另外一个对象
* 函数的参数是一个对象，并且是值传递方式
* 函数的返回值是一个对象，并且是值传递方式

特别注意的是定义一个类时，编译器会给我们定义一个默认拷贝构造函数

对于类中普通的成员变量，如int, double, char等，c++提供默认的拷贝构造函数，我们可以不用写拷贝构造函数。
如果类中成员有*指针（深拷贝，浅拷贝问题），那么我们就需要写自己的拷贝构造函数。

关于深拷贝和浅拷贝的描述如下：

通常，默认生成的拷贝构造函数和赋值运算符，只是简单的进行值的复制。如果类的数据成员有指针，仅仅通过值传递进行拷贝构造的话会造成两个对象的成员指针指向同一块内存，当两个对象析构的时候会对同一个内存释放两次，从而会造成指针空悬。
深拷贝即以上第二种情况，数据成员中有指针变量的时候拷贝构造函数使用深拷贝，即构造函数中重新指定初始化对象的地址空间。
#### 区分直接构造函数和复制构造函数　

两者有微妙的区别。

**Q**: `A a两者有何区别
**A**: 

#### 区分复制构造函数和复制重载运算符　
**Q**: 如何区分复制构造函数和复制重载运算符　
**A**: 

下面的表达式：调用test1的拷贝构造函数初始化对象test2
``` C++
CTest test1;
CTest test2 = test1;
CTest test2 (test1); 
```

对于下面的表达式：调用的是重载的赋值运算符
```
CTest test1，test2;
test2 = test1;
```

拷贝构造函数和赋值的区别

* 用一个已存在的对象去构造一个不存在的对象(构造之前不存在),就是拷贝构造.
* 用一个已存在的对象去覆盖另一个已存在的对象,就是赋值运算.
* 拷贝构造函数从一个已经存在的变量来初始化一个新声明的变量，不需要清除现有的值（因为是新创建，所以没有现有值）
* 拷贝构造函数没有返回值。
* 赋值运算符`return *this.（This is necessary to allow multiple assignment, eg x = y = z;）`



#### 类型转换
类型转换的方式可以有以下两种：
将定义的T类型转换成C类

1、 -if C(T) is a valid constructor call for C
``` c++
class C{
public:
    C(T); //C(const C& T)..etc
};
```
2、 -if operator C() is defined for T
``` c++
class T{
public:
    operator C()const;
};
```
虽然两种方法都可以实现类型转换，但是如果两种都写，那么就会发生二义性。


C++提供了关键字explicit，可以阻止不被允许的经过转换构造函数进行的隐式转换的发生。声明为explicit的构造函数不能在隐式转换中使用。
``` c++
#include <iostream>
class One
{
public:
    One() {}
};

class Two
{
public:
    explicit Two(const One&) {}
};

void f(Two) {}

int main()
{
    One one;

    //f(one);//error C2664: “void f(Two)”: 无法将参数 1 从“One”转换为“Two”

    f(Two(one));//构造一个类Two
    return 0;
};
```

### 析构函数

delete和delete[]
一直对C++中的delete和delete[]的区别不甚了解，今天遇到了，上网查了一下，得出了结论。做个备份，以免丢失。

C++告诉我们在回收用 new 分配的单个对象的内存空间的时候用 delete，回收用 new[] 分配的一组对象的内存空间的时候用 delete[]。
关于 new[] 和 delete[]，其中又分为两种情况：(1) 为基本数据类型分配和回收空间；(2) 为自定义类型分配和回收空间。

请看下面的程序。
```
#include <iostream>;
using namespace std;
 
class T {
public:
  T() { cout << "constructor" << endl; }
  ~T() { cout << "destructor" << endl; }
};
 
int main()
{
  const int NUM = 3;
 
  T* p1 = new T[NUM];
  cout << hex << p1 << endl;
  //  delete[] p1;
  delete p1;
 
  T* p2 = new T[NUM];
  cout << p2 << endl;
  delete[] p2;
}
 ```

大家可以自己运行这个程序，看一看 delete p1 和 delete[] p1 的不同结果，我就不在这里贴运行结果了。

 从运行结果中我们可以看出，delete p1 在回收空间的过程中，只有 p1[0] 这个对象调用了析构函数，其它对象如 p1[1]、p1[2] 等都没有调用自身的析构函数，这就是问题的症结所在。如果用 delete[]，则在回收空间之前所有对象都会首先调用自己的析构函数。
基本类型的对象没有析构函数，所以回收基本类型组成的数组空间用 delete 和 delete[] 都是应该可以的；但是对于类对象数组，只能用 delete[]。对于 new 的单个对象，只能用 delete 不能用 delete[] 回收空间。
所以一个简单的使用原则就是：new 和 delete、new[] 和 delete[] 对应使用

**Q**: delete只删除一个对象，而delete[]可以删除多个对象，请问delete[] ，如何知道该删除几个对象？

现在通常的 C++ 实现会在 new[] 的时候多分配 sizeof(size_t) 字节用于保存数组大小，在 delete[] 的时候会依次逆序调用数组中各对象的析构函数。有的文献管这多分配的几个字节叫 new cookie (Itanium C++ ABI)。
new/malloc 会记录分配的内存的长度，delete/free 的时候无需指定长度，只要传入首地址即可。


### 总结
一个空类包含什么呢？
``` c++
class Empty{};
```
和这样写是一样的（默认包含六个函数）
``` c++
class Empty {
public:
  Empty();                               // 缺省构造函数
  Empty(const Empty& rhs);               // 拷贝构造函数
  ~Empty();                              // 析构函数
  Empty&  operator=(const Empty& rhs);   // 赋值运算符
  Empty* operator&();                    // 取址运算符
  const Empty* operator&() const;	 //取址运算符 const
};
```
但是，C++默认生成的函数，只有在被需要的时候，才会产生。即当我们定义一个类，而不创建类的对象时，就不会创建类的构造函数、析构函数等。
但是，C++默认生成的函数，只有在被需要的时候，才会产生。即当我们定义一个类，而不创建类的对象时，就不会创建类的构造函数、析构函数等。

下面的代码将使得每个函数被生成
``` c++
const Empty e1;             // 缺省构造函数
Empty e2(e1);               // 拷贝构造函数
e2 = e1;                    //  赋值运算符
Empty *pe2 = &e2;           // (非const)取址运算符
const Empty *pe1 = &e1;     // (const)取址运算符
```