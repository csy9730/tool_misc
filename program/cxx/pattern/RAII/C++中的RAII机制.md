# C++中的RAII机制

[![img](https://upload.jianshu.io/users/upload_avatars/4717565/ea654134-b784-4f5a-8f25-1c230d703dd9.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)](https://www.jianshu.com/u/8530ab416e50)

[DayDayUpppppp](https://www.jianshu.com/u/8530ab416e50)关注

12017.05.03 23:17:01字数 1,108阅读 24,247

##### 什么是RAII？

RAII是Resource Acquisition Is Initialization（wiki上面翻译成 “资源获取就是初始化”）的简称，是C++语言的一种管理资源、避免泄漏的惯用法。利用的就是C++构造的对象最终会被销毁的原则。RAII的做法是使用一个对象，在其构造时获取对应的资源，在对象生命期内控制对资源的访问，使之始终保持有效，最后在对象析构的时候，释放构造时获取的资源。

##### 为什么要使用RAII？

上面说到RAII是用来管理资源、避免资源泄漏的方法。那么，用了这么久了，也写了这么多程序了，口头上经常会说资源，那么资源是如何定义的？在计算机系统中，资源是数量有限且对系统正常运行具有一定作用的元素。**比如：网络套接字、互斥锁、文件句柄和内存等等，它们属于系统资源。**由于系统的资源是有限的，就好比自然界的石油，铁矿一样，不是取之不尽，用之不竭的，所以，我们在编程使用系统资源时，都必须遵循一个步骤：
1 申请资源；
2 使用资源；
3 释放资源。
第一步和第二步缺一不可，因为资源必须要申请才能使用的，使用完成以后，必须要释放，如果不释放的话，就会造成资源泄漏。

一个最简单的例子：



```cpp
#include <iostream> 

using namespace std; 

int main() 

{ 
    int *testArray = new int [10]; 
    // Here, you can use the array 
    delete [] testArray; 
    testArray = NULL ; 
    return 0; 
}
```

**小结：**
但是如果程序很复杂的时候，需要为所有的new 分配的内存delete掉，导致极度臃肿，效率下降，更可怕的是，程序的可理解性和可维护性明显降低了，当操作增多时，处理资源释放的代码就会越来越多，越来越乱。如果某一个操作发生了异常而导致释放资源的语句没有被调用，怎么办？这个时候，RAII机制就可以派上用场了。

##### 如何使用RAII？

当我们在一个函数内部使用局部变量，当退出了这个局部变量的作用域时，这个变量也就别销毁了；当这个变量是类对象时，这个时候，就会自动调用这个类的析构函数，而这一切都是自动发生的，不要程序员显示的去调用完成。这个也太好了，RAII就是这样去完成的。

由于系统的资源不具有自动释放的功能，而C++中的类具有自动调用析构函数的功能。**如果把资源用类进行封装起来，对资源操作都封装在类的内部，在析构函数中进行释放资源。当定义的局部变量的生命结束时，它的析构函数就会自动的被调用，如此，就不用程序员显示的去调用释放资源的操作了。**

使用RAII 机制的代码：



```cpp
#include <iostream> 
using namespace std; 

class ArrayOperation 
{ 
public : 
    ArrayOperation() 
    { 
        m_Array = new int [10]; 
    } 

    void InitArray() 
    { 
        for (int i = 0; i < 10; ++i) 
        { 
            *(m_Array + i) = i; 
        } 
    } 

    void ShowArray() 
    { 
        for (int i = 0; i <10; ++i) 
        { 
            cout<<m_Array[i]<<endl; 
        } 
    } 

    ~ArrayOperation() 
    { 
        cout<< "~ArrayOperation is called" <<endl; 
        if (m_Array != NULL ) 
        { 
            delete[] m_Array;  // 非常感谢益可达非常犀利的review，详细可以参加益可达在本文的评论 2014.04.13
            m_Array = NULL ; 
        } 
    } 

private : 
    int *m_Array; 
}; 

bool OperationA(); 
bool OperationB(); 

int main() 
{ 
    ArrayOperation arrayOp; 
    arrayOp.InitArray(); 
    arrayOp.ShowArray(); 
    return 0;
}
```

不使用RAII（没有使用类的思想）的代码



```cpp
#include <iostream> 
using namespace std; 

bool OperationA(); 
bool OperationB(); 

int main() 
{ 
    int *testArray = new int [10]; 

    // Here, you can use the array 
    if (!OperationA()) 
    { 
        // If the operation A failed, we should delete the memory 
        delete [] testArray; 
        testArray = NULL ; 
        return 0; 
    } 

    if (!OperationB()) 
    { 
        // If the operation A failed, we should delete the memory 
        delete [] testArray; 
        testArray = NULL ; 
        return 0; 
    } 

    // All the operation succeed, delete the memory 
    delete [] testArray; 
    testArray = NULL ; 
    return 0; 
} 

bool OperationA() 

{ 
    // Do some operation, if the operate succeed, then return true, else return false 
    return false ; 
} 

bool OperationB() 

{ 
    // Do some operation, if the operate succeed, then return true, else return false 
    return true ; 
}
```

上面这个例子没有多大的实际意义，只是为了说明RAII的机制问题。下面说一个具有实际意义的例子：



```cpp
#include <iostream>
#include <windows.h>
#include <process.h>

using namespace std;

CRITICAL_SECTION cs;
int gGlobal = 0;

class MyLock
{
public:
    MyLock()
    {
        EnterCriticalSection(&cs);
    }

    ~MyLock()
    {
        LeaveCriticalSection(&cs);
    }

private:
    MyLock( const MyLock &);
    MyLock operator =(const MyLock &);
};

void DoComplex(MyLock &lock ) // 非常感谢益可达犀利的review 2014.04.13
{
}

unsigned int __stdcall ThreadFun(PVOID pv) 
{
    MyLock lock;
    int *para = (int *) pv;

    // I need the lock to do some complex thing
    DoComplex(lock);

    for (int i = 0; i < 10; ++i)
    {
        ++gGlobal;
        cout<< "Thread " <<*para<<endl;
        cout<<gGlobal<<endl;
    }
    return 0;
}

int main()
{
    InitializeCriticalSection(&cs);

    int thread1, thread2;
    thread1 = 1;
    thread2 = 2;

    HANDLE handle[2];
    handle[0] = ( HANDLE )_beginthreadex(NULL , 0, ThreadFun, ( void *)&thread1, 0, NULL );
    handle[1] = ( HANDLE )_beginthreadex(NULL , 0, ThreadFun, ( void *)&thread2, 0, NULL );
    WaitForMultipleObjects(2, handle, TRUE , INFINITE );
    return 0;
}
```

这个例子可以说是实际项目的一个模型，当多个进程访问临界变量时，为了不出现错误的情况，需要对临界变量进行加锁；上面的例子就是使用的Windows的临界区域实现的加锁。

但是，在使用CRITICAL_SECTION时，EnterCriticalSection和LeaveCriticalSection必须成对使用，很多时候，经常会忘了调用LeaveCriticalSection，此时就会发生死锁的现象。**当我将对CRITICAL_SECTION的访问封装到MyLock类中时，之后，我只需要定义一个MyLock变量，而不必手动的去显示调用LeaveCriticalSection函数。**

上述的两个例子都是RAII机制的应用，理解了上面的例子，就应该能理解了RAII机制的使用了。