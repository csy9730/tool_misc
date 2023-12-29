# [thread_local与__thread的区别](https://www.cnblogs.com/lizhaolong/p/16437261.html)

gcc版本为（gcc version 7.3.0 (Debian 7.3.0-19)）

# 引言

两个关键字都是关于线程存储的，不过一个是C语言的，一个是C++11的特性。它们之间有什么区别呢？因为在CSDN没有找到解答，遂在解答中对过程进行记录，以帮助有同样疑惑的同学。

## 过程

> __thread is supported on GNU, clang and more. It was available before thread_local… they are not equivalent and both are supported. the difference is that thread_local uses lazy initialization to initialize the variable in only threads that access it. __thread does not initialize at all and you must manually initialize it per thread. thread_local thus has an overhead per access and __thread does not. Apple’s compilers disable thread_local and not thread because of this inefficiency, Although __thread is not available on all compilers, __thread is available with GNU tools

> __thread被GNU支持,clang等支持.它在thread_local之前是很有用的…它们之间并不相等,而且一般都被支持.**它们之间的不同就是thread_local在访问变量的线程中使用延迟初始化来初始话变量.而__thread并不初始化,您必须手动初始化.所以每一次thread_local都是有开销的,而__thread没有.因为这种低效率，Apple的编译器禁用thread_local而不禁用thread，尽管__thread不是在所有编译器上都可用，但_其在GNU工具中可用.(thread_local是C++11的特性)**

我们可以看到区别就是延迟初始化带来的效率上的区别，这里的的开销指的是什么呢？**开销就是 thread_local 变量的每次使用都将成为一个函数调用**。这让人感到不可思议。

这里的过程可以查看参考[4]，因为C++生成的汇编代码实在是过于复杂，我在我机子上生成汇编以后看了半天没看出来，所以大家直接查看参考即可，那篇文章还是比较详细的。

看到有些地方说__thread不支持class相关的构造，析构，我们写一个代码看看：

```cpp
#include <bits/stdc++.h>
#include <pthread.h>
using namespace std;

class local_{
    public:
    local_(){
        cout << ::pthread_self() << endl;
        cout << "hello world\n";
    }
    void show(){
        cout << "hello world1\n";
    }
    ~local_(){
        cout << "hollo world2\n";
    }
};

thread_local local_ Temp;
//__thread local_ TT;

void test(){
    std::cout << "test : " << ::pthread_self()<< endl; 
    Temp.show();
}

int main(){
    std::cout << "main : " << ::pthread_self()<< endl; 
    auto T = std::thread(&test);
    Temp.show();
    T.join();
    cout << "end\n";
    return 0;
}
CPP 复制 全屏
```

输出：

```cpp
main : 140093008275264
140093008275264
hello world
hello world1
test : 140093008270912
140093008270912
hello world
hello world1
hollo world2
end
hollo world2
```

没有什么问题，线程局部变量和全局的Temp都经历了一次构造和析构。

但是如果我们修改`test`函数如下，也就是不使用子线程内的`Temp`：

```cpp
void test(){
    std::cout << "test : " << ::pthread_self()<< endl; 
}
```

此时输出为：

```cpp
main : 139735341807424
139735341807424
test : hello world
139735341803072
hello world1
end
hollo world2
```

我们可以看到子线程内的`Temp`没有被初始化，这难道就是延迟初始化？我们在把`main`函数中的`Temp`去掉，并重新使用子线程内的`Temp`，结果如下：

```cpp
main : 139983638738752
test : 139983638734400
139983638734400
hello world
hello world1
hollo world2
end
```

主线程内的`Temp`没有被创建。

最后把`thread_loacl`声明为`static`看一看：

```cpp
static thread_local local_ Temp;

void test(){
    std::cout << "test : " << ::pthread_self()<< endl; 
    Temp.show();
}
main : 140635869771584
test : 140635869767232
140635869767232
hello world
hello world1
hollo world2
end
```

可看到仍然进行了初始化。

那么如果使用__thread的话呢？我们注释掉`thread_local local_ Temp`这一句，使用__thread，得到这样的结果：

```cpp
non-local variable ‘Temp’ declared ‘__thread’ needs dynamic initialization
```

我们可以在[6]中找到如下资料：

> - The __thread specifier may be applied to any global, file-scoped static, function-scoped static, or static data member of a class. It may not be applied to block-scoped automatic or non-static data member.
> - __thread可以被用于类的全局静态、文件作用域静态、函数作用域静态或静态数据成员。它可能不适用于块作用域自动或非静态数据成员。

在[8]中可以看到如下描述，我没找到他这段话的出处，所以只能抱着半信半疑的态度来看：

> 只能修饰POD类型(类似整型指针的标量，不带自定义的构造、拷贝、赋值、析构的类型，二进制内容可以任意复制memset,memcpy,且内容可以复原)，

需要动态初始化，__thread是不支持非函数本地变量的。那么如果让它跑起来呢，我们执行动态初始化，且修改类型为指针就可以，我们把代码修改成如下：

```cpp
static __thread local_* Temp;
//__thread local_ TT;

void test(){
    std::cout << "test : " << ::pthread_self()<< endl; 
    static __thread local_ T;
    Temp = new local_();
    Temp->show();
    delete Temp;
}
```

输出为：

```cpp
main : 140161363343168
test : 140161363338816
140161363338816
hello world
140161363338816
hello world
hello world1
hollo world2
hollo world2
end
```

我们可以看到局部静态变量和全局静态成员都初始化成功。
从前面的报错可以看出：`non-local variable`声明为`__thread`需要动态初始化，那local就不需要喽。

> non-local variable ‘Temp’ declared ‘__thread’ needs dynamic initialization.

把`test`改成如下试一试：

```cpp
void test(){
    std::cout << "test : " << ::pthread_self()<< endl; 
    __thread local_ T;
    Temp = new local_();
    Temp->show();
    delete Temp;
}
```

也可以跑通：

```cpp
main : 139799995848512
test : 139799995844160
139799995844160
hello world
139799995844160
hello world
hello world1
hollo world2
hollo world2
end
```

__thread被声明为局部变量的时候**仍然会发生构造和析构**，所以传言被打破了。

在[9]中我们可以看到以下文字；

> - The thread_local keyword is only allowed for **objects** declared at namespace scope, objects declared at block scope, and static data members. **It indicates that the object has thread storage duration.** It can be combined with static or extern to specify internal or external linkage (except for static data members which always have external linkage), respectively, but that additional static doesn’t affect the storage duration.
> - **仅在命名空间范围内声明的对象，在块范围内声明的对象和静态数据成员才允许使用thread_local关键字**。 它指示对象具有线程存储持续时间。 可以将其与static或extern组合以分别指定内部或外部链接（始终具有外部链接的静态数据成员除外），但是附加的static不会影响存储时间。

其中的粒度是对象，可以看到明确的说明了:**指示对象具有线程存储持续时间。**

> - thread storage duration. The storage for the object is allocated when the thread begins and deallocated when the thread ends. Each thread has its own instance of the object. Only objects declared thread_local have this storage duration. thread_local can appear together with static or extern to adjust linkage. See Non-local variables and Static local variables for details on initialization of objects with this storage duration.
> - 线程存储持续时间。 对象的存储在线程开始时分配，并在线程结束时释放。 每个线程都有其自己的对象实例。 只有声明为thread_local的对象才具有此存储时间。 thread_local可以与static或extern一起出现以调整链接。 **有关使用此存储持续时间初始化对象的详细信息，请参见非局部变量和静态局部变量。**

官网中并没有提到延迟初始化，但是在[10]中提到了如下文字：

> - If relevant, constant initialization is applied.Otherwise, non-local static and thread-local variables are zero-initialized.
> - 如果相关，则应用常量初始化。否则non-local static 和 thread-local变量会零初始化。

## 结论

通过以上测试与查阅资料，得出以下结论。

1. **执行阶段的效率问题。__thread不会发生函数调用，而thread_local对变量的一次访问就是一次函数调用**。（非官方）
2. **thread_local可以延迟初始化**。（没使用就不声明可能是被编译器优化掉了，不过我开的是 -O0）。（非官方）
3. **__thread在某些平台上支持，比如GNU，clang等，但是有些平台不支持。thread_local作为C++11的特性，基本都被支持**。
4. **__thread在实现非本地变量的时候（非POD类型）需要动态初始化。而thread_local在任何情况（\**命名空间范围内声明的对象，在块范围内声明的对象和静态数据成员\**）都可以静态初始化（class存在有效的默认构造函数），不需要我们动态初始化**。
5. **两个关键字都支持类的构造与析构**。

作者水平有限，有问题的地方还请大家给出宝贵的建议。

参考：

1. 博文《[linux编程 - C/C++每线程（thread-local）变量的使用](https://blog.csdn.net/jasonchen_gbd/article/details/51367650)》
2. 问答《[Using __thread in c++0x ：stackoverflow](https://stackoverflow.com/questions/7047226/using-thread-in-c0x)》
3. 文档《[Thread-Local Storage ：文档](https://gcc.gnu.org/onlinedocs/gcc-3.3.1/gcc/Thread-Local.html)》
4. 博文《[C ++ 11：GCC 4.8 thread_local 性能惩罚？(C++11: GCC 4.8 thread_local Performance Penalty?)](https://www.it1352.com/460620.html)》
5. 博文《[c++ 线程局部变量thread_local](https://blog.csdn.net/d_guco/article/details/86562943)》
6. https://gcc.gnu.org/onlinedocs/gcc-4.7.1/gcc/Thread_002dLocal.html
7. 《[关于__thread和__type__(var)两个gcc扩展](https://www.jianshu.com/p/13ebab5cd5b2)》
8. 《[__thread关键字](https://blog.csdn.net/liuxuejiang158blog/article/details/14100897)》
9. https://en.cppreference.com/w/cpp/language/storage_duration
10. https://en.cppreference.com/w/cpp/language/initialization#Non-local_variables