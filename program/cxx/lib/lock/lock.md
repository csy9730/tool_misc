# lock

- <condition_variable>
- <future>
- <mutex>
- <atomic>

- 自旋锁 （适用于系统内核编程）
- 互斥锁 （适用于应用编程场景，资源唯一）
- 信号量 （适用于操作系统的资源分配, 资源数量可以大于1）
- 条件变量
- atomic 原子指令
    - CAS (compare and swap)


### mutex

| 类名                           | 描述                                                         |
| ------------------------------ | ------------------------------------------------------------ |
| std::mutex                     | 最简单的互斥对象。                                           |
| std::timed_mutex               | 带有超时机制的互斥对象，允许等待一段时间或直到某个时间点仍未能获得互斥对象的所有权时放弃等待。 |
| std::recursive_mutex           | 允许被同一个线程递归的Lock和Unlock。                         |
| std::recursive_timed_mutex     | 顾名思义(bù jiě shì)。                                       |
| std::shared_timed_mutex(C++14) | 允许多个线程共享所有权的互斥对象，如读写锁，本文不讨论这种互斥。 |


#### usage

``` cpp
void usage(){
    for(std::size_t i = 0; i != 100000; ++i) {
        mt.lock();
        int_set.insert(dis(gen));
        mt.unlock();
    }
}
```

#### mutex RAII proxy

然而C++并没有try-finally，事实上C++并不需要finally。C++通常使用RAII(Resource Acquisition Is Initialization)来自动管理资源。如果可能应总是使用标准库提供的互斥对象管理类模板。

| 类模板                  | 描述                                                         |
| ----------------------- | ------------------------------------------------------------ |
| std::lock_guard         | 严格基于作用域(scope-based)的锁管理类模板，构造时是否加锁是可选的(不加锁时假定当前线程已经获得锁的所有权)，析构时自动释放锁，**所有权不可转移**，对象生存期内不允许手动加锁和释放锁。 |
| std::unique_lock        | 更加灵活的锁管理类模板，构造时是否加锁是可选的，在对象析构时如果持有锁会自动释放锁，**所有权可以转移**。对象生命期内允许手动加锁和释放锁。 |
| std::shared_lock(C++14) | 用于管理可转移和共享所有权的互斥对象。                       |

使用std::lock_guard类模板修改前面的代码，在lck对象构造时加锁，析构时自动释放锁，即使insert抛出了异常lck对象也会被正确的析构，所以也就不会发生互斥对象没有释放锁而导致死锁的问题。

#### code

``` cpp
namespace std {
  class mutex;
  class recursive_mutex;
  class timed_mutex;
  class recursive_timed_mutex;
  template<class Mutex> class lock_guard;
  template<class... MutexTypes> class scoped_lock;
  template<class Mutex> class unique_lock;
}
``` 
``` cpp
class mutex {
  public:
    constexpr mutex() noexcept;
    ~mutex();
 
    mutex(const mutex&) = delete;
    mutex& operator=(const mutex&) = delete;
 
    void lock();
    bool try_lock();
    void unlock();
}
```

### condition_variable
``` cpp
namespace std {
  class condition_variable;
  class condition_variable_any;
 
  void notify_all_at_thread_exit(condition_variable& cond, unique_lock<mutex> lk);
 
  enum class cv_status { no_timeout, timeout };
}
``` 

#### condition_variable
``` cpp
namespace std {
  class condition_variable {
  public:
    condition_variable();
    ~condition_variable();
 
    condition_variable(const condition_variable&) = delete;
    condition_variable& operator=(const condition_variable&) = delete;
 
    void notify_one() noexcept;
    void notify_all() noexcept;
    void wait(unique_lock<mutex>& lock);
    template<class Pred>
      void wait(unique_lock<mutex>& lock, Pred pred);
    template<class Clock, class Duration>
      cv_status wait_until(unique_lock<mutex>& lock,
                           const chrono::time_point<Clock, Duration>& abs_time);
    template<class Clock, class Duration, class Pred>
      bool wait_until(unique_lock<mutex>& lock,
                      const chrono::time_point<Clock, Duration>& abs_time, Pred pred);
    template<class Rep, class Period>
      cv_status wait_for(unique_lock<mutex>& lock,
                         const chrono::duration<Rep, Period>& rel_time);
    template<class Rep, class Period, class Pred>
      bool wait_for(unique_lock<mutex>& lock,
                    const chrono::duration<Rep, Period>& rel_time, Pred pred);
 
    using native_handle_type = /* implementation-defined */;
    native_handle_type native_handle();
  };
}
```

#### 线程安全队列
多读多写的线程安全队列有以下几种实现方式：

1. 互斥锁
2. 互斥锁+条件变量：BlockQueue
3. 内存屏障：SimpleLockFreeQueue
4. CAS 原子操作：ArrayLockFreeQueue（也可以理解成 RingBuffer）