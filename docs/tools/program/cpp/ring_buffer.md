# ring buffer

```
push ( push_back)
pop (pop_front)
read ( front)
write = push_back
```

环形缓冲区，相当于先进先出”（FIFO）的数据管理方式。

- 固定的容量：传统的环形缓冲区通常具有固定的容量，当数据量超过其容量时，新的数据会覆盖旧的数据。虽然这可以实现内存的高效利用，但也可能导致数据的丢失。
- 复杂的同步机制：在多线程或多进程的环境中，环形缓冲区需要使用复杂的同步机制来保证数据的一致性和完整性，这可能会增加编程的复杂性。
- 不支持随机访问：环形缓冲区通常只支持对头部和尾部的数据进行操作，不支持对中间数据的随机访问。


``` cpp
template<typename T>
class RingBufferToy{
public:
	int push(T&){}
	int pop(T&) {}
    bool empty() const {
        return !full_ && (head_ == tail_);
    }

    bool full() const {
        return full_;
    }
    unsigned int _front_idx=0;
    unsigned int _rear_idx=0;
	T arr[64];
}
```