# compare_exchange_strong和compare_exchange_weak

[![天上地下](https://pica.zhimg.com/v2-abed1a8c04700ba7d72b45195223e0ff_l.jpg?source=172ae18b)](https://www.zhihu.com/people/cai-peng-xiang-71)

[天上地下](https://www.zhihu.com/people/cai-peng-xiang-71)

学生

## 参考：

[C++11：原子交换函数compare_exchange_weak和compare_exchange_strong_吃素的施子的博客-CSDN博客_c++ exchangeblog.csdn.net/feikudai8460/article/details/107035480/![img](https://pic3.zhimg.com/v2-81e5a05d235b959f34478e243cda9bba_ipico.jpg)](https://link.zhihu.com/?target=https%3A//blog.csdn.net/feikudai8460/article/details/107035480/)

## compare_exchange_strong：

```cpp
bool compare_exchange_strong( T& expected, T desired,
                              std::memory_order success,
                              std::memory_order failure );
bool compare_exchange_strong( T& expected, T desired,
                              std::memory_order success,
                              std::memory_order failure ) volatile;    
bool compare_exchange_strong( T& expected, T desired,
                              std::memory_order order =
                                  std::memory_order_seq_cst );
bool compare_exchange_strong( T& expected, T desired,
                              std::memory_order order =
                                  std::memory_order_seq_cst ) volatile;
```

当前值与期望值(expect)相等时，修改当前值为设定值(desired)，返回true

当前值与期望值(expect)不等时，将期望值(expect)修改为当前值，返回false

## compare_exchange_weak

```cpp
bool compare_exchange_weak( T& expected, T desired,
                            std::memory_order success,
                            std::memory_order failure );
bool compare_exchange_weak( T& expected, T desired,
                            std::memory_order success,
                            std::memory_order failure ) volatile;
bool compare_exchange_weak( T& expected, T desired,
                            std::memory_order order =
                                std::memory_order_seq_cst );
bool compare_exchange_weak( T& expected, T desired,
                            std::memory_order order =
                                std::memory_order_seq_cst ) volatile;
```

**weak版和strong版的区别：**

weak版本的CAS允许偶然出乎意料的返回（比如在字段值和期待值一样的时候却返回了false，并且没有将字段值设置成desire的值），不过在一些循环算法中，这是可以接受的。通常它比起strong有更高的性能。

## 实例：

在非并发条件下，要实现一个栈的Push操作，我们可能有如下操作：

- 1、新建一个节点
- 2、将该节点的next指针指向现有栈顶
- 3、更新栈顶

但是在并发条件下，上述无保护的操作明显可能出现问题。下面举一个例子：

原栈顶为A。（此时栈状态: A->P->Q->...，我们约定从左到右第一个值为栈顶，P->[Q代表p.next](https://link.zhihu.com/?target=http%3A//xn--qp-cf3cn59s.next/) = Q）

线程1准备将B压栈。线程1执行完步骤2后被强占。（新建节点B，并使　[B.next](https://link.zhihu.com/?target=http%3A//b.next/) = A，即B->A）

线程2得到cpu时间片并完成将C压栈的操作，即完成步骤1、2、3。此时栈状态（此时栈状态: C->A->...）

这时线程1重新获得cpu时间片，执行步骤3。导致栈状态变为（此时栈状态: B->A->...）

结果线程2的操作丢失，这显然不是我们想要的结果。

那么我们如何解决这个问题呢？

只要保证步骤3更新栈顶时候，栈顶是我们在步骤2中获得顶栈顶即可。因为如果有其它线程进行操作，栈顶必然改变。

我们可以利用CAS轻松解决这个问题：如果栈顶是我们步骤2中获取顶栈顶，则执行步骤3。否则，自旋（即重新执行步骤2）。

```cpp
template<typename T>
class lock_free_stack
{
private:
  struct node
  {
    T data;
    node* next;

    node(T const& data_): 
     data(data_)
    {}
  };

  std::atomic<node*> head;
public:
  void push(T const& data)
  {
    node* const new_node=new node(data); 
    new_node->next=head.load();  //如果head更新了，这条语句要春来一遍
    while(!head.compare_exchange_weak(new_node->next,new_node));
  }
};
```



原文链接：[C++11：原子交换函数compare_exchange_weak和compare_exchange_strong_吃素的施子的博客-CSDN博客_c++ exchange](https://link.zhihu.com/?target=https%3A//blog.csdn.net/feikudai8460/article/details/107035480/)

发布于 2023-01-28 20:46・IP 属地北京

[C / C++](https://www.zhihu.com/topic/19601705)

[atomic](https://www.zhihu.com/topic/25669783)