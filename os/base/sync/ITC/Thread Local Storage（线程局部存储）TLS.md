# Thread Local Storage（线程局部存储）TLS

[![一束灵光](https://picx.zhimg.com/v2-38011399a74f5ec122eab81682ddea89_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/li-tao-61-83)

[一束灵光](https://www.zhihu.com/people/li-tao-61-83)



腾讯科技 后台策略工程师



4 人赞同了该文章

## **1.概念说明**

线程局部存储（TLS），是一种变量的存储方法，这个变量在它所在的线程内是全局可访问的，但是不能被其他线程访问到，这样就保持了数据的线程独立性。而熟知的全局变量，是所有线程都可以访问的，这样就不可避免需要锁来控制，增加了控制成本和代码复杂度。

## **2.资料**

GCC官方介绍：

[Thread-Local (Using the GNU Compiler Collection (GCC))gcc.gnu.org/onlinedocs/gcc/Thread-Local.html](https://link.zhihu.com/?target=https%3A//gcc.gnu.org/onlinedocs/gcc/Thread-Local.html)

Wiki的详细说明：

[https://en.wikipedia.org/wiki/Thread-local_storage#Windows_implementationen.wikipedia.org/wiki/Thread-local_storage#Windows_implementation](https://link.zhihu.com/?target=https%3A//en.wikipedia.org/wiki/Thread-local_storage%23Windows_implementation)

## **3.使用方法**

目前使用TLS的方法有多种，POSIX的pthread.h提供了一组API来实现此功能

```c
int pthread_key_create(pthread_key_t *key, void (*destructor)(void*));
int pthread_key_delete(pthread_key_t key);
void *pthread_getspecific(pthread_key_t key);
int pthread_setspecific(pthread_key_t key, const void *value);
```

除了API的方式，GCC的编译器也支持语言级别的用法，这样比用API调用，更简单

```c
__thread int i;
extern __thread struct state s;
static __thread char *p
```

## **4.Demo**
使用GCC编译级别支持的方式来实现TLS

```cpp
#include<iostream>
#include<pthread.h>
#include<unistd.h>

using namespace std;
__thread int iVar = 100;

void* Thread1(void *arg)
{
    iVar += 200;
    cout<<"Thead1 Val : "<<iVar<<endl;
}

void* Thread2(void *arg)
{
    iVar += 400;
    sleep(1);
    cout<<"Thead2 Val : "<<iVar<<endl;
}

int main()
{
    pthread_t pid1, pid2;
    pthread_create(&pid1, NULL, Thread1, NULL);
    pthread_create(&pid2, NULL, Thread2, NULL);

    pthread_join(pid1, NULL);
    pthread_join(pid2, NULL);

    return 0;
}
```

编译：

```text
g++ -o tls_cpp tls_test.cpp -lpthread
```

![img](https://pic1.zhimg.com/80/v2-c9cdf1cbecb21ce934ecb0b0b09e7108_720w.png)执行结果

从输出可以看出，两个线程pid1、pid2都用了iVar，但是各自都拥有各自的iVar并计算相应的结果，这样就达到了线程基本的数据独立。

（PS：把__thread int iVar = 100;修改为 int iVar = 100;重新编译后，对比执行试试）

## **5.参考**

[Thread Local Storage---__thread 关键字的使用方法](https://link.zhihu.com/?target=https%3A//blog.csdn.net/haima1998/article/details/51770553)
[https://blog.csdn.net/kevin_darkelf/article/details/78330778](https://link.zhihu.com/?target=https%3A//blog.csdn.net/kevin_darkelf/article/details/78330778)



编辑于 2020-05-22 17:08

线程安全

Storage

并发