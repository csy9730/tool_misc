# [C++11 锁 lock](https://www.cnblogs.com/diegodu/p/7099300.html)

## 互斥(Mutex: Mutual Exclusion)

下面的代码中两个线程连续的往int_set中插入多个随机产生的整数。

``` cpp
std::set int_set;
auto f = [&int_set]() {    
    try {        
        std::random_device rd;        
        std::mt19937 gen(rd());        
        std::uniform_int_distribution<> dis(1, 1000);        
        for(std::size_t i = 0; i != 100000; ++i) {            
            int_set.insert(dis(gen));        
        }    
    } catch(...) {}
};
std::thread td1(f), td2(f);
td1.join();td2.join();
```

由于std::set::insert不是多线程安全的，多个线程同时对同一个对象调用insert其行为是未定义的(通常导致的结果是程序崩溃)。因此需要一种机制在此处对多个线程进行同步，保证任一时刻至多有一个线程在调用insert函数。
C++11提供了4个互斥对象(C++14提供了1个)用于同步多个线程对共享资源的访问。

| 类名                           | 描述                                                         |
| ------------------------------ | ------------------------------------------------------------ |
| std::mutex                     | 最简单的互斥对象。                                           |
| std::timed_mutex               | 带有超时机制的互斥对象，允许等待一段时间或直到某个时间点仍未能获得互斥对象的所有权时放弃等待。 |
| std::recursive_mutex           | 允许被同一个线程递归的Lock和Unlock。                         |
| std::recursive_timed_mutex     | 顾名思义(bù jiě shì)。                                       |
| std::shared_timed_mutex(C++14) | 允许多个线程共享所有权的互斥对象，如读写锁，本文不讨论这种互斥。 |

## 锁(Lock)

这里的锁是动词而非名词，互斥对象的主要操作有两个加锁(lock)和释放锁(unlock)。当一个线程对互斥对象进行lock操作并成功获得这个互斥对象的所有权，在此线程对此对象unlock前，其他线程对这个互斥对象的lock操作都会被阻塞。修改前面的代码在两个线程中对共享资源int_set执行insert操作前先对互斥对象mt进行加锁操作，待操作完成后再释放锁。这样就能保证同一时刻至多只有一个线程对int_set对象执行insert操作。

``` cpp
std::set int_set;
std::mutex mt;
auto f = [&int_set, &mt]() {    
    try {        
        std::random_device rd;        
        std::mt19937 gen(rd());        
        std::uniform_int_distribution<> dis(1, 1000);        
        for(std::size_t i = 0; i != 100000; ++i) {            
            mt.lock();            
            int_set.insert(dis(gen));            
            mt.unlock();        
        }    
    } catch(...) {}
};
std::thread td1(f), td2(f);
td1.join();td2.join();
```

### 使用RAII管理互斥对象

在使用锁时应避免发生死锁(Deadlock)。前面的代码倘若一个线程在执行第10行的int_set.insert时抛出了异常，会导致第11行的unlock不被执行，从而可能导致另一个线程永远的阻塞在第9行的lock操作。类似的情况还有比如你写了一个函数，在进入函数后首先做的事情就是对某互斥对象执行lock操作，然而这个函数有许多的分支，并且其中有几个分支要提前返回。因此你不得不在每个要提前返回的分支在返回前对这个互斥对象执行unlock操作。一但有某个分支在返回前忘了对这个互斥对象执行unlock，就可能会导致程序死锁。
为避免这类死锁的发生，其他高级语言如C#提供了`lock`关键字、Java提供了`synchronized`关键字，它们都是通过`finally`关键字来实现的。比如对于C#

```
lock(x){    // do something}
```

等价于

``` java
System.Object obj = (System.Object)x;
System.Threading.Monitor.Enter(obj);try{    
    // do something
}
finally{    
    System.Threading.Monitor.Exit(obj);
}
```

然而C++并没有try-finally，事实上C++并不需要finally。C++通常使用RAII(Resource Acquisition Is Initialization)来自动管理资源。如果可能应总是使用标准库提供的互斥对象管理类模板。

| 类模板                  | 描述                                                         |
| ----------------------- | ------------------------------------------------------------ |
| std::lock_guard         | 严格基于作用域(scope-based)的锁管理类模板，构造时是否加锁是可选的(不加锁时假定当前线程已经获得锁的所有权)，析构时自动释放锁，所有权不可转移，对象生存期内不允许手动加锁和释放锁。 |
| std::unique_lock        | 更加灵活的锁管理类模板，构造时是否加锁是可选的，在对象析构时如果持有锁会自动释放锁，所有权可以转移。对象生命期内允许手动加锁和释放锁。 |
| std::shared_lock(C++14) | 用于管理可转移和共享所有权的互斥对象。                       |

使用std::lock_guard类模板修改前面的代码，在lck对象构造时加锁，析构时自动释放锁，即使insert抛出了异常lck对象也会被正确的析构，所以也就不会发生互斥对象没有释放锁而导致死锁的问题。

``` cpp
std::set int_set;std::mutex mt;
auto f = [&int_set, &mt]() {    
    try {        
        std::random_device rd;        
        std::mt19937 gen(rd());        
        std::uniform_int_distribution<> dis(1, 1000);        
        for(std::size_t i = 0; i != 100000; ++i) {            
            std::lock_guard lck(mt);            
            int_set.insert(dis(gen));        
        }    
    } catch(...) {}
};
std::thread td1(f), td2(f);
td1.join();
td2.join();
```

### 互斥对象管理类模板的加锁策略

前面提到std::lock_guard、std::unique_lock和std::shared_lock类模板在构造时是否加锁是可选的，C++11提供了3种加锁策略。

| 策略             | tag type           | 描述                                                   |
| ---------------- | ------------------ | ------------------------------------------------------ |
| (默认)           | 无                 | 请求锁，阻塞当前线程直到成功获得锁。                   |
| std::defer_lock  | std::defer_lock_t  | 不请求锁。                                             |
| std::try_to_lock | std::try_to_lock_t | 尝试请求锁，但不阻塞线程，锁不可用时也会立即返回。     |
| std::adopt_lock  | std::adopt_lock_t  | 假定当前线程已经获得互斥对象的所有权，所以不再请求锁。 |

下表列出了互斥对象管理类模板对各策略的支持情况。

| 策略             | std::lock_guard | std::unique_lock | std::shared_lock |
| ---------------- | --------------- | ---------------- | ---------------- |
| (默认)           | √               | √                | √(共享)          |
| std::defer_lock  | ×               | √                | √                |
| std::try_to_lock | ×               | √                | √                |
| std::adopt_lock  | √               | √                | √                |

下面的代码中std::unique_lock指定了std::defer_lock。

``` cpp
std::mutex mt;
std::unique_lock lck(mt, std::defer_lock);
assert(lck.owns_lock() == false);
lck.lock();
assert(lck.owns_lock() == true);
```

### 对多个互斥对象加锁

在某些情况下我们可能需要对多个互斥对象进行加锁，考虑下面的代码

``` cpp
std::mutex mt1, mt2;// thread 1
{    
    std::lock_guard lck1(mt1);    
    std::lock_guard lck2(mt2);    // do something
}
// thread 2
{    
    std::lock_guard lck2(mt2);    
    std::lock_guard lck1(mt1);    // do something
}
```

如果线程1执行到第5行的时候恰好线程2执行到第11行。那么就会出现

- 线程1持有mt1并等待mt2
- 线程2持有mt2并等待mt1

发生死锁。
为了避免发生这类死锁，对于任意两个互斥对象，在多个线程中进行加锁时应保证其先后顺序是一致。前面的代码应修改成

``` cpp
std::mutex mt1, mt2;// thread 1
{    
    std::lock_guard lck1(mt1);    
    std::lock_guard lck2(mt2);    // do something
}// thread 2

{    
    std::lock_guard lck1(mt1);    
    std::lock_guard lck2(mt2);    
// do something
}
```

更好的做法是使用标准库中的std::lock和std::try_lock函数来对多个Lockable对象加锁。std::lock(或std::try_lock)会使用一种避免死锁的算法对多个待加锁对象进行lock操作(std::try_lock进行try_lock操作)，当待加锁的对象中有不可用对象时std::lock会阻塞当前线程知道所有对象都可用(std::try_lock不会阻塞线程当有对象不可用时会释放已经加锁的其他对象并立即返回)。使用std::lock改写前面的代码，这里刻意让第6行和第13行的参数顺序不同

``` cpp
std::mutex mt1, mt2;// thread 1
{    
    std::unique_lock lck1(mt1, std::defer_lock);    
    std::unique_lock lck2(mt2, std::defer_lock);    
    std::lock(lck1, lck2);    // do something
}

// thread 2
{    
    std::unique_lock lck1(mt1, std::defer_lock);    
    std::unique_lock lck2(mt2, std::defer_lock);    
    std::lock(lck2, lck1);    // do something
}
```

此外std::lock和std::try_lock还是异常安全的函数(要求待加锁的对象unlock操作不允许抛出异常)，当对多个对象加锁时，其中如果有某个对象在lock或try_lock时抛出异常，std::lock或std::try_lock会捕获这个异常并将之前已经加锁的对象逐个执行unlock操作，然后重新抛出这个异常(异常中立)。并且std::lock_guard的构造函数lock_guard(mutex_type& m, std::adopt_lock_t t)也不会抛出异常。所以std::lock像下面这么用也是正确

``` cpp
std::lock(mt1, mt2);
std::lock_guard lck1(mt1, std::adopt_lock);
std::lock_guard lck2(mt2, std::adopt_lock);
```

[好文要顶](javascript:void(0);) [关注我](javascript:void(0);) [收藏该文](javascript:void(0);) [![img](https://common.cnblogs.com/images/icon_weibo_24.png)](javascript:void(0);) [![img](https://common.cnblogs.com/images/wechat.png)](javascript:void(0);)