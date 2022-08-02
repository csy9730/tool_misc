# C++ 命名返回值优化（NRVO）

 

翻译

[XDATAPLUS](https://blog.51cto.com/xdataplus)2018-02-07 14:24:59博主文章分类：[C/C++](https://blog.51cto.com/xdataplus/category2)©著作权

*文章标签*[C++](https://blog.51cto.com/topic/c.html)[NRVO](https://blog.51cto.com/topic/nrvo.html)*文章分类*[C/C++](https://blog.51cto.com/nav/c-cpp)[编程语言](https://blog.51cto.com/nav/program)*阅读数*2881

** 命名的返回值优化（NRVO），这优化了冗余拷贝构造函数和析构函数调用，从而提高了总体性能。值得注意的是，这可能导致优化和非优化程序之间的不同行为。**

下面是代码段1中的一个简单示例，以说明优化及其实现方式：

```html
A MyMethod (B &var)
{
	A retVal;
	retVal.member = var.value + bar(var);
	return retVal;
}
1.2.3.4.5.6.
```





使用上述函数的程序可能具有如下构造：

```html
valA = MyMethod(valB);
1.
```





从MyMethod返回的值是在valA通过使用隐藏的参数所指向的内存空间中创建的。下面是当我们公开隐藏的参数并显示地显示构造函数和析构函数时的功能：

```html
A MyMethod(A &_hiddenArg, B &var)
{
	A retVal;
	retVal.A::A(); //constructor for retVal
	retVal.member = var.value + var(var);
	_hiddenArg.A::A(retVal); // the copy constructor for A
	return;
return.A::~A(); // destructor for retVal
}
1.2.3.4.5.6.7.8.9.
```





上段代码为不使用NRVO的隐藏参数代码（伪代码）
从上面的代码可以看出，有一些优化的机会。其基本思想是消除基于堆栈的临时值（retVal）并使用隐藏的参数。因此，这将消除基于堆栈的值的拷贝构造函数和析构函数。下面是基于NRVO的优化代码：

```html
A MyMethod(A &_hiddenArg, B &var)
{
	_hiddenArg.A::A();
	_hiddenArg.member = var.value + bar(var);
	Resurn
}
1.2.3.4.5.6.
```





带有NRVO的隐藏参数代码（伪代码）

代码示例
示例1：简单示例

```html
#include <stdio.h>

class RVO
{
public:
        RVO() { printf("I am in constructor\n"); }
        RVO( const RVO& c_RVO ) { printf("I am in copy constructor\n"); }
        ~RVO() { printf("I am in destructor\n"); }
        int mem_var;
};

RVO MyMethod(int i)
{
        RVO rvo;
        rvo.mem_var = i;
        return rvo;
}

int main()
{
        RVO rvo;
        rvo = MyMethod(5);
}
1.2.3.4.5.6.7.8.9.10.11.12.13.14.15.16.17.18.19.20.21.22.23.
```





代码：Sample1.cpp
如果没有NRVO，预期的输出将是：

```html
I am in constructor
I am in constructor
I am in copy constructor
I am in destructor
I am in destructor
I am in destructor
1.2.3.4.5.6.
```





使用NRVO，预期的输出将是：

```html
I am in constructor
I am in constructor
I am in destructor
I am in destructor
1.2.3.4.
```





示例2：更复杂的示例

```html
#include <stdio.h>
class A
{
public:
        A()
        {
                printf("A: I am in constructor\n");
                i = 1;
        }

        ~A()
        {
                printf("A: I am in destructor\n");
                i = 0;
        }

        A(const A& a)
        {
                printf("A: I am in copy constructor\n");
                i = a.i;
        }

        int i, x, w;
};

class B
{
public:
        A a;
        B()
        {
                printf("B: I am in constructor\n");
        }

        ~B()
        {
                printf("B: I am in destructor\n");
        }

        B(const B& b)
        {
                printf("B: I am in copy constructor\n");
        }
};

A MyMethod()
{
        B* b = new B();
        A a = b->a;
        delete b;
        return a;
}

int main()
{
        A a;
        a = MyMethod();
}
1.2.3.4.5.6.7.8.9.10.11.12.13.14.15.16.17.18.19.20.21.22.23.24.25.26.27.28.29.30.31.32.33.34.35.36.37.38.39.40.41.42.43.44.45.46.47.48.49.50.51.52.53.54.55.56.57.58.
```





代码Sample2.cpp
无NRVO的输出将如下所：

```html
A: I am in constructor
A: I am in constructor
B: I am in constructor
A: I am in copy constructor
B: I am in destructor
A: I am in destructor
A: I am in copy constructor
A: I am in destructor
A: I am in destructor
A: I am in destructor
1.2.3.4.5.6.7.8.9.10.
```





当NRVO优化启动时，输出将是：

```html
A: I am in constructor
A: I am in constructor
B: I am in constructor
A: I am in copy constructor
B: I am in destructor
A: I am in destructor
A: I am in destructor
A: I am in destructor
1.2.3.4.5.6.7.8.
```





**优化限制**
有些情况下，优化不会真正启动。以下是这些限制的样本
示例3：异常示例
在遇到异常时，隐藏的参数必须在它正在替换的临时范围内被破坏。

```html
// RVO class is defined above in figure 4
#include <stdio.h>
RVO MyMethod(int i)
{
	RVO rvo;
	cvo.mem_var = i;
	throw "I am throwing an exception!";
	return rvo;
}

int main()
{
	RVO rvo;
	try
	{
		rvo = MyMethod(5);
	}
	catch(char* str)
	{
		printf("I caught the exception\n");
	}
1.2.3.4.5.6.7.8.9.10.11.12.13.14.15.16.17.18.19.20.21.
```





代码Sample3.cpp
如果没有NRVO，预期的输出将是：

```html
I am in constructor
I am in constructor
I am in destructor
I caught the exception
I am in destructor
1.2.3.4.5.
```





如果“抛出”被注释掉，输出将是：

```html
I am in constructor
I am in constructor
I am in copy constructor
I am in destructor
I am in destructor
I am in destructor
1.2.3.4.5.6.
```





现在，如果“抛出”被注释掉，并且NRVO被触发，输出将如下所示：

```html
I am in constructor
I am in constructor
I am in destructor
I am in destructor
1.2.3.4.
```





也就是说sample3.cpp在没有NRVO的情况下，会表现出相同的行为。

示例4：不同的命名对象示例
若要使用优化，所有退出路径必须返回同一命名对象。

```html
#include <stdio.h>
class RVO
{
public:
        RVO()
        {
                printf("I am in construct\n");
        }

        RVO(const RVO& c_RVO)
        {
                printf("I am in copy construct\n");
        }

        int mem_var;
};

RVO MyMethod(int i)
{
        RVO rvo;
        rvo.mem_var = i;
        if( rvo.mem_var == 10 )
                return RVO();
        return rvo;
}

int main()
{
        RVO rvo;
        rvo = MyMethod(5);
}
1.2.3.4.5.6.7.8.9.10.11.12.13.14.15.16.17.18.19.20.21.22.23.24.25.26.27.28.29.30.31.
```





代码Sample4.cpp
启用优化时输出与不启用任何优化相同。NRVO实际上并不发生，因为并非所有返回都返回相同的对象。

```html
I am in constructor
I am in constructor
I am in copy constructor
1.2.3.
```





如果将上面的示例更改为返回rvo。在返回对象时，优化将消除复制构造函数：

```html
#include <stdio.h>
class RVO
{
public:
        RVO()
        {
                printf("I am in constructor\n");
        }

        RVO(const RVO& c_RVO)
        {
                printf("I am in copy constructor\n");
        }

        int mem_var;
};

RVO MyMethod(int i)
{
        RVO rvo;
        if( i == 10 )
                return rvo;
        rvo.mem_var = i;
                return rvo;
}

int main()
{
        RVO rvo;
        rvo = MyMethod(5);
}
1.2.3.4.5.6.7.8.9.10.11.12.13.14.15.16.17.18.19.20.21.22.23.24.25.26.27.28.29.30.31.
```





代码Sample4_Modified.cpp修改并使用NRVO，输出结果将如下所示：

```html
I am in constructor
I am in constructor
1.2.
```





**优化副作用**
程序员应该意识到这种优化可能会影响应用程序的流程。下面的示例说明了这种副作用：

```html
#include <stdio.h>

int NumConsCalls = 0;
int NumCpyConsCalls = 0;

class RVO
{
public:
        RVO()
        {
                NumConsCalls ++;
        }

        RVO(const RVO& c_RVO)
        {
                NumCpyConsCalls++;
        }
};

RVO MyMethod()
{
        RVO rvo;
        return rvo;
}

int main()
{
        RVO rvo;
        rvo = MyMethod();
        int Division = NumConsCalls / NumCpyConsCalls;
        printf("Construct calls / Copy constructor calls = %d\n", Division);
}
1.2.3.4.5.6.7.8.9.10.11.12.13.14.15.16.17.18.19.20.21.22.23.24.25.26.27.28.29.30.31.32.
```





代码段Sample5.cpp
编译未启用优化将产生大多数用户所期望的。“构造函数”被调用两次。“拷贝构造函数”被调用一次。因此除法生成2。

```html
Constructor calls / Copy constructor calls = 2
1.
```





另一方面，如果上面的代码通过启用优化进行编译，NRVO将会启用。因此“拷贝构造函数”调用将被删除。因此，NumCpyConsCalls将为零，导致异常。如果没有适当处理，可以导致应用程序崩溃。

------

引入自：[ https://msdn.microsoft.com/en-us/library/ms364057(v=vs.80).aspx](https://msdn.microsoft.com/en-us/library/ms364057(v=vs.80).aspx)