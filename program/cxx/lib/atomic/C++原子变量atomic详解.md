# C++原子变量atomic详解

[![Lion Long](https://pica.zhimg.com/v2-8c434683eac8f5e1de89cc0e9ea78277_l.jpg?source=172ae18b)](https://www.zhihu.com/people/long-xu-88-89)

[Lion Long](https://www.zhihu.com/people/long-xu-88-89)![img](https://picx.zhimg.com/v2-4812630bc27d642f7cafcd6cdeca3d7a.jpg?source=88ceefae)

分享C/C++高性能后台程序设计和开发技能

9 人赞同了该文章



目录

收起

一、简介

二、成员函数

2.1、构造函数

2.2、is_lock_free函数

2.3、store函数

2.4、load函数

2.5、exchange函数

2.6、compare_exchange_weak函数

2.7、compare_exchange_strong函数

2.8、专业化支持的操作

三、使用示例

总结

## 一、简介

C++中原子变量（atomic）是一种多线程编程中常用的同步机制，它能够确保对共享变量的操作在执行时不会被其他线程的操作干扰，从而避免竞态条件（race condition）和死锁（deadlock）等问题。

原子变量可以看作是一种特殊的类型，它具有类似于普通变量的操作，但是这些操作都是原子级别的，即要么全部完成，要么全部未完成。C++标准库提供了丰富的原子类型，包括整型、指针、布尔值等，使用方法也非常简单，只需要通过std::atomic<T>定义一个原子变量即可，其中T表示变量的类型。

在普通的变量中，并发的访问它可能会导致数据竞争，竞争的后果会导致操作过程不会按照正确的顺序进行操作。

atomic对象可以通过指定不同的memory orders来控制其对其他非原子对象的访问顺序和可见性，从而实现线程安全。常用的memory orders包括：

- memory_order_relaxed、
- memory_order_acquire、
- memory_order_release、
- memory_order_acq_rel
- memory_order_seq_cst等。

不同的memory orders对应着不同的内存模型和操作语义。

[【官方介绍】](https://link.zhihu.com/?target=http%3A//www.cplusplus.com/reference/atomic/atomic/)。

```cpp
template <class T> struct atomic;
```

## 二、成员函数

### 2.1、构造函数

std::atomic::atomic。

> *（1）默认：*使对象处于未初始化状态。 atomic() noexcept = default;
> *（2）初始化 ：*使用val初始化对象。 constexpr atomic (T val) noexcept;
> *（3）复制 [删除] ：*无法复制/移动对象。 atomic (const atomic&) = delete;

示例：

```cpp
std::atomic<bool> ready (false);
```

### 2.2、is_lock_free函数

is_lock_free函数是一个成员函数，用于检查当前atomic对象是否支持无锁操作。调用此成员函数不会启动任何数据竞争。

语法：

```cpp
bool is_lock_free() const volatile noexcept;
bool is_lock_free() const noexcept;
```

返回值：如果当前atomic对象支持无锁操作，则返回true；否则返回false。

示例：

```cpp
#include <iostream>
#include <atomic>
 
int main()
{
    std::atomic<int> a;
    std::cout << std::boolalpha                // 显示 true 或 false，而不是 1 或 0
              << "std::atomic<int> is "
              << (a.is_lock_free() ? "" : "not ")
              << "lock-free\n";
 
    std::atomic_flag f;
    std::cout << "std::atomic_flag is "
              << (f.is_lock_free() ? "" : "not ")
              << "lock-free\n";
}
```

输出：

```cpp
std::atomic<int> is not lock-free
std::atomic_flag is lock-free
```

示例中，首先定义了一个atomic<int>类型的对象a和一个atomic_flag类型的对象f，并分别调用了它们的is_lock_free函数来检查它们是否支持无锁操作。由于int类型可能会有多个字节，所以它可能需要加锁才能保证原子性，因此a.is_lock_free()返回false；而atomic_flag类型是一个布尔型（只占一个字节），所以它可以使用汇编指令来实现无锁操作，因此f.is_lock_free()返回true。

### 2.3、store函数

std::atomic<T>::store()是一个成员函数，用于将给定的值存储到原子对象中。

它有以下两种语法：

```cpp
void store(T desired, std::memory_order order = std::memory_order_seq_cst) volatile noexcept;
void store(T desired, std::memory_order order = std::memory_order_seq_cst) noexcept;
```

- `desired`：要存储的值。
- `order`：存储操作的内存顺序。默认是`std::memory_order_seq_cst`（顺序一致性）。

存储操作的内存顺序参数：

| value                | 内存顺序               | 描述                                                         |
| -------------------- | ---------------------- | ------------------------------------------------------------ |
| memory_order_relaxed | 无序的内存访问         | 不做任何同步，仅保证该原子类型变量的操作是原子化的，并不保证其对其他线程的可见性和正确性。 |
| memory_order_consume | 与消费者关系有关的顺序 | 保证本次读取之前所有依赖于该原子类型变量值的操作都已经完成，但不保证其他线程对该变量的存储结果已经可见。 |
| memory_order_acquire | 获取关系的顺序         | 保证本次读取之前所有先于该原子类型变量写入内存的操作都已经完成，并且其他线程对该变量的存储结果已经可见。 |
| memory_order_seq_cst | 顺序一致性的顺序       | 保证本次操作以及之前和之后的所有原子操作都按照一个全局的内存顺序执行，从而保证多线程环境下对变量的读写的正确性和一致性。这是最常用的内存顺序。 |
| memory_order_release | 释放关系的顺序         | 保证本次写入之后所有后于该原子类型变量写入内存的操作都已经完成，并且其他线程可以看到该变量的存储结果。 |



示例：

```cpp
#include <iostream>
#include <atomic>

int main()
{
    std::atomic<int> atomic_int(0);

    int val = 10;
    atomic_int.store(val);

    std::cout << "Value stored in atomic object: " << atomic_int << std::endl;

    return 0;
}
```

输出：

```cpp
Value stored in atomic object: 10
```

例子中，首先定义了一个`std::atomic`类型的原子变量`atomic_int`，初始值为0。然后，使用`store()`函数将变量`val`的值存储到`atomic_int`中。最后，打印出存储在原子对象中的值。

需要注意的是，在多线程环境下使用原子变量和操作时，需要使用适当的内存顺序来保证数据的正确性和一致性。因此，`store()`函数中的`order`参数可以用来指定不同的内存顺序。如果不确定如何选择内存顺序，请使用默认值`std::memory_order_seq_cst`，它是最常用和最保险的。



### 2.4、load函数

load函数用于获取原子变量的当前值。它有以下两种形式：

```cpp
T load(memory_order order = memory_order_seq_cst) const noexcept;
operator T() const noexcept;
```

其中，第一种形式是显式调用load函数，第二种形式是通过重载类型转换运算符实现隐式调用。

load函数的参数memory_order表示内存序，也就是对原子变量的读操作要遵循哪种内存模型。C++中定义了多种内存序，包括：

- memory_order_relaxed：最轻量级的内存序，不提供任何同步机制。
- memory_order_acquire：在本线程中，所有后面的读写操作必须在这个操作之后执行。
- memory_order_release：在本线程中，该操作之前的所有读写操作必须在这个操作之前执行。
- memory_order_seq_cst：最严格的内存序，保证所有线程看到的读写操作的顺序都是一致的。

使用load函数时，如果不指定memory_order，则默认为memory_order_seq_cst。

load函数的返回值类型为T，即原子变量的类型。在使用load函数时需要指定类型参数T。如果使用第二种形式的load函数，则无需指定类型参数T，程序会自动根据上下文推断出类型。

示例：

```cpp
std::atomic<int> foo (0);

int x;
do {
    x = foo.load(std::memory_order_relaxed);  // get value atomically
} while (x==0);
```

### 2.5、exchange函数

访问和修改包含的值，将包含的值替换并返回它前面的值。

```cpp
template< class T >
T exchange( volatile std::atomic<T>* obj, T desired );
```

其中，`obj`参数指向需要替换值的atomic对象，`desired`参数为期望替换成的值。如果替换成功，则返回原来的值。

整个操作是原子的（原子读-修改-写操作）：从读取（要返回）值的那一刻到此函数修改值的那一刻，该值不受其他线程的影响。

示例：

```cpp
#include <iostream>       // std::cout
#include <atomic>         // std::atomic
#include <thread>         // std::thread
#include <vector>         // std::vector

std::atomic<bool> ready (false);
std::atomic<bool> winner (false);

void count1m (int id) {
  while (!ready) {}                  // wait for the ready signal
  for (int i=0; i<1000000; ++i) {}   // go!, count to 1 million
  if (!winner.exchange(true)) { std::cout << "thread #" << id << " won!\n"; }
};

int main ()
{
  std::vector<std::thread> threads;
  std::cout << "spawning 10 threads that count to 1 million...\n";
  for (int i=1; i<=10; ++i) threads.push_back(std::thread(count1m,i));
  ready = true;
  for (auto& th : threads) th.join();

  return 0;
}
```

### 2.6、compare_exchange_weak函数

这个函数的作用是比较一个值和一个期望值是否相等，如果相等则将该值替换成一个新值，并返回true；否则不做任何操作并返回false。

```cpp
bool compare_exchange_weak (T& expected, T val,memory_order sync = memory_order_seq_cst) volatile noexcept;
bool compare_exchange_weak (T& expected, T val,memory_order sync = memory_order_seq_cst) noexcept;
bool compare_exchange_weak (T& expected, T val,memory_order success, memory_order failure) volatile noexcept;
bool compare_exchange_weak (T& expected, T val,memory_order success, memory_order failure) noexcept;
```

参数说明：

- expected：期望值的地址，也是输入参数，表示要比较的值；
- val：新值，也是输入参数，表示期望值等于该值时需要替换的值；
- success：表示函数执行成功时内存序的类型，默认为memory_order_seq_cst；
- failure：表示函数执行失败时内存序的类型，默认为memory_order_seq_cst。

该函数的返回值为bool类型，表示操作是否成功。

注意，compare_exchange_weak函数是一个弱化版本的原子操作函数，因为在某些平台上它可能会失败并重试。如果需要保证严格的原子性，则应该使用compare_exchange_strong函数。

示例：

```cpp
#include <iostream>       // std::cout
#include <atomic>         // std::atomic
#include <thread>         // std::thread
#include <vector>         // std::vector

// a simple global linked list:
struct Node { int value; Node* next; };
std::atomic<Node*> list_head (nullptr);

void append (int val) {     // append an element to the list
  Node* oldHead = list_head;
  Node* newNode = new Node {val,oldHead};

  // what follows is equivalent to: list_head = newNode, but in a thread-safe way:
  while (!list_head.compare_exchange_weak(oldHead,newNode))
    newNode->next = oldHead;
}

int main ()
{
  // spawn 10 threads to fill the linked list:
  std::vector<std::thread> threads;
  for (int i=0; i<10; ++i) threads.push_back(std::thread(append,i));
  for (auto& th : threads) th.join();

  // print contents:
  for (Node* it = list_head; it!=nullptr; it=it->next)
    std::cout << ' ' << it->value;
  std::cout << '\n';

  // cleanup:
  Node* it; while (it=list_head) {list_head=it->next; delete it;}

  return 0;
}
```

### 2.7、compare_exchange_strong函数

这个函数的作用和compare_exchange_weak类似，都是比较一个值和一个期望值是否相等，并且在相等时将该值替换成一个新值。不同的是，compare_exchange_strong会保证原子性，并且如果比较失败则会返回当前值。

该函数的定义如下：

```cpp
bool compare_exchange_strong(T& expected, T desired,
                             memory_order success = memory_order_seq_cst,
                             memory_order failure = memory_order_seq_cst) noexcept;
```

参数说明：

- expected：期望值的地址，也是输入参数，表示要比较的值；
- desired：新值，也是输入参数，表示期望值等于该值时需要替换的值；
- success：表示函数执行成功时内存序的类型，默认为memory_order_seq_cst；
- failure：表示函数执行失败时内存序的类型，默认为memory_order_seq_cst。

该函数的返回值为bool类型，表示操作是否成功。

注意，compare_exchange_strong函数保证原子性，因此它的效率可能比compare_exchange_weak低。在使用时应根据具体情况选择适合的函数。

### 2.8、**专业化支持的操作**

| fetch_add | 添加到包含的值并返回它在操作之前具有的值                     |
| --------- | ------------------------------------------------------------ |
| fetch_sub | 从包含的值中减去，并返回它在操作之前的值。                   |
| fetch_and | 读取包含的值，并将其替换为在读取值和 之间执行按位 AND 运算的结果。 |
| fetch_or  | 读取包含的值，并将其替换为在读取值和 之间执行按位 OR 运算的结果。 |
| fetch_xor | 读取包含的值，并将其替换为在读取值和 之间执行按位 XOR 运算的结果。 |

## 三、使用示例

```cpp
// atomic::load/store example
#include <iostream> // std::cout
#include <atomic> // std::atomic, std::memory_order_relaxed
#include <thread> // std::thread
//std::atomic<int> count = 0;//错误初始化
std::atomic<int> count(0); // 准确初始化
void set_count(int x)
{
	std::cout << "set_count:" << x << std::endl;
	count.store(x, std::memory_order_relaxed); // set value atomically
}
void print_count()
{
	int x;
	do {
		x = count.load(std::memory_order_relaxed); // get value atomically
	} while (x==0);
	std::cout << "count: " << x << '\n';
}
int main ()
{
	std::thread t1 (print_count);
	std::thread t2 (set_count, 10);
	t1.join();
	t2.join();
	std::cout << "main finish\n";
	return 0;
}
```

## 总结

原子操作在多线程中可以保证线程安全，而且效率会比互斥量好些。

原子变量支持的基本操作有：

- 加法：a += n或者a.fetch_add(n)
- 减法：a -= n或者a.fetch_sub(n)
- 与、或、异或运算：a &= b、a |= b、a ^= b或者a.fetch_and(b)、a.fetch_or(b)、a.fetch_xor(b)
- 自增、自减运算：++a、--a、a++、a--或者a.fetch_add(1)、a.fetch_sub(1)
- 交换：a.exchange(b)返回原来的值，将a设置为b
- 比较并交换：a.compare_exchange_strong(b, c)或者a.compare_exchange_weak(b, c)，如果a的值等于b，则将a设置为c，返回true，否则返回false。

尽管原子变量是多线程编程中非常重要的同步机制，但是它也存在一些局限性。具体来说，原子变量只能保证单个变量的原子性操作，而不能保证多个变量之间的同步。此外，原子变量也无法解决数据竞争（data race）等问题，因此在使用时需要注意避免这些问题的出现。

![img](https://pic3.zhimg.com/80/v2-b96a76d03a0454cac76b029264ef08a2_720w.webp)



编辑于 2023-05-12 10:40・IP 属地广东

[C++](https://www.zhihu.com/topic/19584970)

[C / C++](https://www.zhihu.com/topic/19601705)

[atomic](https://www.zhihu.com/topic/25669783)