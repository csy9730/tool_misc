# README


```bash
g++ future_demo2.cpp  -std=c++11
```

- 实现一个简单的future demo
- 实现一个嵌套的future demo


### ps

std::get_future 适用于一次性任务，简单任务
对于多次结果的任务，初始化条件复杂的任务，更应该自行设计同步方式。

future-promise 分成 future 和 promise 两部分。

- promise 交给工作线程，负责发送结果；
- future 交给监工线程，负责接收结果。

std::future提供了一个重要方法就是.get()，这将阻塞主线程，直到future就绪。注意：.get()方法只能调用一次。



其实future/promise最强大的功能是能够：
- 获得结果返回值；
- 处理异常（如果任务线程发生异常）；
- 链式回调（目前c++标准库不支持链式回调，不过folly支持）；

#### core

message pass的编程范式，我们可见多了，先来思考一下有哪几种编写方法：

- 利用条件变量。在任务线程完成时调用notify_one()，在主函数中调用wait()；
- 利用flag（原子类型）。在任务完成时修改flag，在主线程中阻塞，不断轮询flag直到成功；

上面第一种上锁会带来一定开销，好处是适合长时间阻塞，第二种适合短时间阻塞。

那么c++11 future采用哪一种呢？答案是第二种，future内定义了一个原子对象，主线程通过自旋锁不断轮询，此外会进行sys_futex系统调用。futex是linux非常经典的同步机制，锁冲突时在用户态利用自旋锁，而需要挂起等待时到内核态进行睡眠与唤醒。


#### 4
线程的结束方式

- 主线程处理
  - join
  - detach
  - joinable deconstruction : 线程析构，但此时线程已经运行却没有join() 。此时线程将被强制停止。需要避免这种情况。
  - nobegin deconstruction 
- 信号处理
  - 自行退出 exit
  - 系统发送强制结束信号 kill terminate()
  - 系统给线程发送自杀信号，线程收到后自行退出。需要线程有事件处理函数
