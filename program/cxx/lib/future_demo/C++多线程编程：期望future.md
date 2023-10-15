# C++多线程编程：期望future

[![深度学习可好玩了](https://picx.zhimg.com/v2-7245460484da95a56ddba8dc44b1c7cf_l.jpg?source=172ae18b)](https://www.zhihu.com/people/deep-learner-66)

[深度学习可好玩了](https://www.zhihu.com/people/deep-learner-66)![img](https://pic1.zhimg.com/v2-4812630bc27d642f7cafcd6cdeca3d7a.jpg?source=88ceefae)

43 人赞同了该文章



目录

收起

std::future

std::promise

std::packaged_task

std::async

处理异常

std::shared_future

实战：多线程实现快速排序

时钟与限定等待时间

其余内容见：

[深度学习可好玩了：C++高性能编程：概览133 赞同 · 1 评论文章](https://zhuanlan.zhihu.com/p/548300959)

在并发编程中，我们通常会用到一组非阻塞的模型：promise\future。在python、js、java中都提供future\promise，是现代语言常用的非阻塞编程模型。

> 先来看一个经典的烧茶水问题。烧茶水有三步：烧开水、买茶叶、泡茶叶。为节约时间，烧开水可以和买茶叶同时进行，泡茶叶必须在前两者完成后才能进行。

许多场景都可以抽象成烧茶水这样的异步模型，比如：

> IO请求。cpu拉起io任务后，继续做手上的工作，io任务完成后，修改某个信号，cpu每执行一条指令都查看该信号是否改变，若检测到改变，再做响应后处理。

------

下面我们正式介绍future\promise的含义：

- future表示一个可能还没有实际完成的**异步任务的结果**，针对这个结果可以添加回调函数以便在任务执行成功或失败后做出对应的操作；（回调就是自己写了却不调用，给别人调用的函数）
- promise交由任务执行者，任务执行者**通过promise可以标记任务完成或者失败**；

所以说，future\promise编程模型本质上还是message pass（任务线程与主线程消息传递）。在future模型中阻塞和非阻塞都有：**拉起一个新线程**（非阻塞），在主线程`.get()`（阻塞）。整个流程见下图：

![img](https://pic1.zhimg.com/80/v2-a2a18d224893562269dc98581b1a6110_720w.webp)

------

message pass的编程范式，我们可见多了，先来思考一下有哪几种编写方法：

- 利用条件变量。在任务线程完成时调用`notify_one()`，在主函数中调用`wait()`；
- 利用flag（原子类型）。在任务完成时修改flag，在主线程中阻塞，不断轮询flag直到成功；

上面第一种上锁会带来一定开销，好处是适合长时间阻塞，第二种适合短时间阻塞。

那么c++11 future采用哪一种呢？答案是第二种，future内定义了一个原子对象，主线程通过自旋锁不断轮询，此外会进行sys_futex系统调用。futex是linux非常经典的同步机制，锁冲突时在用户态利用自旋锁，而需要挂起等待时到内核态进行睡眠与唤醒。

------

其实future/promise最强大的功能是能够：

- **获得结果返回值；**
- **处理异常**（如果任务线程发生异常）；
- **链式回调**（目前c++标准库不支持链式回调，不过folly支持）；

**获得结果返回值**

获得结果返回值的方法有很多，但都不如future/promise优雅。

我们也可以提供拉起一个新的`std::thread`来获得结果返回值（通过返回指针），但这种写法很容易出错，举个例子：

```cpp
 #include <chrono>
 #include <thread>
 #include <iostream>
 
 void threadCompute(int* res)
 {
     std::this_thread::sleep_for(std::chrono::seconds(1));
     *res = 100;
 }
 
 int main()
 {
     int res;
     std::thread th1(threadCompute, 2, &res);
     th1.join();
     std::cout << res << std::endl;
     return 0;
 }
```

用std::thread的缺点是：

- 通过`.join`来阻塞，本文例子比较简单，但代码一长，线程一多，忘记调用`th1.join()`，就会捉襟见肘；
- 使用指针传递数据非常危险，因为互斥量不能阻止指针的访问，而且指针的方式要更改接口，比较麻烦 ；

------

那么future/promise又是如何获得返回值的呢？通过future，future可以看成存储器，存储一个未来返回值。

先在主线程内创建一个promise对象，从promise对象中获得future对象；

再将promise引用传递给任务线程，在任务线程中对promise进行`set_value`，主线程可通过future获得结果。

------

### std::future

`std::future`提供了一个重要方法就是`.get()`，这将阻塞主线程，直到future就绪。注意：`.get()`方法只能调用一次。

此外，`std::future`不支持拷贝，支持移动构造。c++提供的另一个类`std::shared_future`支持拷贝。

可以通过下面三个方式来获得`std::future`。

- `std::promise`的get_future函数
- `std::packaged_task`的get_future函数
- `std::async` 函数

### std::promise

来看一个例子：

```cpp
 #include <iostream>
 #include <functional>
 #include <future>
 #include <thread>
 #include <chrono>
 #include <cstdlib>
 
 void thread_comute(std::promise<int>& promiseObj) {
     std::this_thread::sleep_for(std::chrono::seconds(1));
     promiseObj.set_value(100); // set_value后，future变为就绪。
 }
 
 int main() {
     std::promise<int> promiseObj;
     std::future<int> futureObj = promiseObj.get_future();
     std::thread t(&thread_set_promise, std::ref(promiseObj)); 
     // 采用std::ref引用传值
     std::cout << futureObj.get() << std::endl; // 会阻塞
    
     t.join();
     return 0;
 }
```

### std::packaged_task

`std::package_task`类似于`std::functional`，特殊的是，自动会把返回值可以传递给`std::future`。

`std::package_task`类似于`std::functional`，所以不会自动执行，需要显示的调用。

因为 `std::packaged_task` 对象是一个可调用对象， 可以：

- 封装在 std::function 对象中；
- 作为线程函数传递到 std::thread 对象中；
- 作为可调用对象传递另一个函数中；
- 可以直接进行调用 ；

我们经常用 std::packaged_task 打包任务， 并在它被传到别处之前的适当时机取回期望值。

下面我们来编写一个GUI界面线程。GUI往往需要一个线程去轮询任务队列，看是否需要处理任务；还有一个线程处理鼠标等IO响应，把`std::packaged_task`作为回调函数，放入任务队列。

```cpp
#include <deque>
#include <mutex>
#include <future>
#include <thread>
#include <utility>

std::mutex m;
std::deque<std::packaged_task<void()> > tasks;

 bool gui_shutdown_message_received();
 void get_and_process_gui_message();

 void gui_thread() // 1
 {
     while(!gui_shutdown_message_received()) // 如果用户关闭界面，就退出
     {
         get_and_process_gui_message(); // get用户操作
         std::packaged_task<void()> task;
         {
             std::lock_guard<std::mutex> lk(m); // 上局部锁
             if(tasks.empty()) // 轮询直到不为空
                 continue;
             task=std::move(tasks.front()); // 取FIFO任务队列第一个
             tasks.pop_front();
         }
         task(); // task是packaged_task，执行该任务，并把返回值给future对象
     }
 }

 std::thread gui_bg_thread(gui_thread); // 启动后台线程

 template<typename Func>
 std::future<void> post_task_for_gui_thread(Func f) 
 {
     std::packaged_task<void()> task(f); // 作为回调函数
     std::future<void> res=task.get_future(); // 获得future对象
     std::lock_guard<std::mutex> lk(m);     
     tasks.push_back(std::move(task)); // 放入任务对列
     return res; // future对象后续将得到task的返回值
 }
```

### std::async

`std::async`是模板函数，是C++标准更进一步的高级封装，用起来非常方便。将直接返回一个future对象。

我们可以用`std::async`来实现分部求和。

```cpp
 int Sum_with_MultiThread(int from, int to, size_t thread_num) {
     int ret = 0;
     int n = thread_num ? (to - from) / thread_num : (to - from);
     std::vector<std::future<int64_t>> v;
     for (; from <= to; ++from) {
       v.push_back(std::async(Sum, from, from + n > to ? to : from + n));
       from += n;
     }
     for (auto &f : v) {
       ret += f.get();
     }
     return ret;
  }
 
```

此外，`std::async`比`std::thread`更安全！`std::thread`当创建太多线程时，会导致创建失败，进而程序崩溃。

而`std::async`就没有这个顾虑，为什么呢？这就要讲`std::async`的启动方式了，也就是`std::async`的第一个参数：`std::launch::deferred`【延迟调用】和`std::launch::async`【强制创建一个线程】。

1. `std::launch::deferred`:
   表示线程入口函数调用被延迟到`std::future`对象调用`wait()`或者`get()`函数 调用才执行。
   如果`wait()`和`get()`**没有调用**，则不会创建新线程，也不执行函数；
   如果调用`wait()`和`get()`，实际上**也不会创建新线程**，而是在主线程上继续执行；
2. `std::launch::async`:
   表示强制这个异步任务在 **新线程**上执行，在调用`std::async()`函数的时候就开始创建线程。
3. `std::launch::deferred|std::launch::async`:
   这里的“|”表示或者。如果没有给出launch参数，默认采用该种方式。
   操作系统会自行评估选择async or defer，如果系统资源紧张，则采用defer，就不会创建新线程。避免创建线程过长，导致崩溃。

嘶，async默认的launch方式将由操作系统决定，这样好处是不会因为开辟线程太多而崩溃，但坏处是这种不确定性会带来问题，参考[《effective modern c++》](https://zhuanlan.zhihu.com/p/349349488)：`这种不确定性会影响thread_local变量的不确定性，它隐含着任务可能不会执行，它还影响了基于超时的wait调用的程序逻辑`。

note：**所以如果我们确定是异步执行的话，最好显示给出launch方式**！

------

std::async在使用时不仅要注意launch的不确定性，还有一个坑：**async返回的future对象的析构是异步的**。

见下面代码，当async返回的future对象是右值时，要进行析构，此时阻塞了。至于为什么要阻塞析构，感兴趣的可以google

```cpp
 #include <iostream>
 #include <future>
 #include <thread>
 #include <chrono>
 
 int main() {
     std::cout << "Test 1 start" << std::endl;
     auto fut1 = std::async(std::launch::async, [] { std::this_thread::sleep_for(std::chrono::milliseconds(5000)); std::cout << "work done 1!\n"; 
     return 1;}); // 这一步没有阻塞，因为async的返回的future对象用于move构造了fut1，没有析构
     
     std::cout << "Work done - implicit join on fut1 associated thread just ended\n\n";
     
     std::cout << "Test 2 start" << std::endl;
     std::async(std::launch::async, [] { std::this_thread::sleep_for(std::chrono::milliseconds(5000)); std::cout << "work done 2!" << std::endl; });// 这一步竟然阻塞了！因为async返回future对象是右值，将要析构，而析构会阻塞
     std::cout << "This shold show before work done 2!?" << std::endl;
     return 0;
 }
```

### 处理异常

期望编程范式的一大好处是能够接住异常，这是`std::thread`不可比拟的优势

- `std::async`处理异常

future.get()可以获得async中的异常，外部套一个try/catch。至于是原始的异常对象， 还是一个拷贝，不同的编译器和库将会在这方面做出不同的选择 。

```cpp
 void foo()
 {
   std::cout << "foo()" << std::endl;
   throw std::runtime_error("Error");
 }
 
 int main()
 {
   try
   {
     std::cout << "1" << std::endl;
     auto f = std::async(std::launch::async, foo);
     f.get();
     std::cout << "2" << std::endl;
   }
   catch (const std::exception& ex)
   {
     std::cerr << ex.what() << std::endl;
   }
 }
```

- `std::packaged_task`处理异常

`std::packaged_task`与`std::async`一样，也是把异常传递给future对象，可以用上面一样的方式捕获。

- `std::promise`处理异常

`std::promise`处理异常与上面两者不同，当它存入的是一个异常而非一个数值时， 就需要调用set_exception()成员函数， 而非set_value()。这样future才能捕获异常。

```cpp
 try{
     some_promise.set_value(calculate_value());
 }
 catch(...){
     some_promise.set_exception(std::current_exception());
 } 
```

------

此外，任何情况下， 当期望值的状态还不是“就绪”时， 调用`std::promise`或`std::packaged_task`的析构函数， 将会存储一个与`std::future_errc::broken_promise`错误状态相关的`std::future_error`异常。如下：

```cpp
 // std::packaged_task<>
 std::future<void> future;
 try {
     // 提前销毁task
     {
         std::packaged_task<void()> task([] {
             std::cout << "do packaged task." << std::endl;
         });
         future = task.get_future();
     }
     future.get();
 }
 catch (const std::future_error &e) {
     std::cout << "Packaged task exception: " << e.what() << std::endl;
 }
 
 // std::promise<>
 try {
     // 提前销毁promise
     {
         std::promise<void> promise;
         future = promise.get_future();
     }
     future.get();
 }
 catch (const std::future_error &e) {
     std::cout << "Promise exception: " << e.what() << std::endl;
 }
```

### std::shared_future

`std::future`缺点是只能get一次，也就是说只能被一个线程获得计算结果。那如何让多个线程都获得计算结果呢？

c++标准祭出`std::shared_future`，相比std::future，它支持拷贝。

注意，每个线程都拥有自己对应的拷贝对象，这样就不会有data race的问题，多个线程访问共享同步结果是安全的。

![img](https://pic2.zhimg.com/80/v2-d47d17002bd285b371bc8714efb6e58d_720w.webp)

那么如何创建一个`std::shared_future`呢？从`std::future`转移所有权即可。std::future可以用过move语义、share()成员函数转移所有权。

如下：

```cpp
 std::promise<int> p;
 std::future<int> f(p.get_future());
 assert(f.valid()); // 1 期望值 f 是合法的，说明f此时有所有权
 std::shared_future<int> sf(std::move(f));
 assert(!f.valid()); // 2 期望值 f 现在是不合法的，说明已经转移所有权
 assert(sf.valid()); // 3 sf 现在是合法的，说明获得了所有权
```

当然，我们也可以用std::promise.get_future来构建shared_future

```cpp
 std::promise<std::string> p;
 std::shared_future<std::string> sf(p.get_future()); // 右值构造函数，转移所有权
 // 等价于 auto sf=p.get_future().share();
```

### 实战：多线程实现快速排序

快排相比都很熟悉，下面先看一下普通的顺序执行版本：

```cpp
 template<typename T>
 std::list<T> sequential_quick_sort(std::list<T> input)
 {
   if(input.empty())
   {
     return input;
   }
   std::list<T> result;
   result.splice(result.begin(),input,input.begin());  
   // splice是剪切操作，把input.begin()元素剪切到result.begin()位置
   
   T const& pivot=*result.begin();  // 选定基准
 
   auto divide_point=std::partition(input.begin(),input.end(),
              [&](T const& t){return t<pivot;});  // 找到比基准小的点
 
   std::list<T> lower_part;
   lower_part.splice(lower_part.end(),input,input.begin(),divide_point);  
   //把input.begin()到divide_point，剪切到lower_part.end()处
     
   auto new_lower(sequential_quick_sort(std::move(lower_part)));  // 递归
   auto new_higher(sequential_quick_sort(std::move(input)));  // 递归
     
   result.splice(result.end(),new_higher);  // 合并higher
   result.splice(result.begin(),new_lower);  // 合并lower
   return result;
 }
```

那么上面版本哪里可以并行呢？new_lower和new_higher可以并行

我们只需更改部分代码为：

```cpp
 std::future<std::list<T> > new_lower(  
      std::async(&parallel_quick_sort<T>,std::move(lower_part))); // 异步
 auto new_higher(parallel_quick_sort(std::move(input)));  // 同步
 
 result.splice(result.end(),new_higher);  // 
 result.splice(result.begin(),new_lower.get());  // 
```

采用async我们可以充分利用多核，而且async还有一个好处是，系统会帮你决定是否创建新线程，这可以避免因线程数太多而导致的崩溃。

比如，十次递归调用，将会创建1024个执行线程。当运行库认为任务过多时(已影响性能)，这些任务应该在使用get()函数获取的线程上运行，而不是在新线程上运行，这样就能避免任务向线程传递的开销。

当然上面的代码也可以用线程池来实现，此外，对于快排有更高级的多线程模型，这里的例子不是最理想的。

## 时钟与限定等待时间

C++11标准中的``头文件提供了功能完善、高精度的时钟，相比ctime可以做到微妙级的计时。

主要定义了三种类型：

- `durations`时间间隔；
- `clocks` 时钟。包括`system_clock`、`steady_clock`、`high_resolution_clock` ；
- `time points`时间点；

之前介绍的很多同步模型都支持wait_for、wait_utill两个方法，当发生超时，不再等待。如：

```cpp
std::future<int> fut = std::async(do_some_thing);
std::chrono::milliseconds span(100); // durations
fut.wait_for(span); // 参数是时间间隔
```



发布于 2022-08-13 15:10

