# [理解 shared_ptr实现copy-on-write（COW）](https://www.cnblogs.com/wangshaowei/p/11649901.html)

看muduo库某个生产者消费者的地方，利用shared_ptr有效减少了锁的范围及无用的拷贝，下面来看一看

#### 消费者
```cpp
// reader 消费者，
shared_ptr<map<string,int> > rd_data ;
{
     MutexLockGuard lock(mutex);　　// 利用局部锁减少锁的粒度
     rd_data = _data;
}
// xxx do stuff
rd_data.doSomething();
 
```
#### 生产者

```cpp
// writer  生产者
MutexLockGuard lock(mutex);
if (!_data.unique()) {　　　　　　
     // 利用智能指针的特性来判断是否有消费者正在处理数据
     shared_ptr<map<string,int> > copy_data(new map<string,int>(*_data));
     _data.swap(copy_data);  // _data这个智能指针所指向的内容已经换成最新的了,但是reader所拥有的那个指针其实指向的的还是老的数据
}
// xx do stuff
_data.doSomething();
```

1) 当reader要获取 `_data`时,shred_ptr引用计数+1
2) 当writer要写`_data`时,判断是否当前线程是`_data`的唯一拥有者,如果不是,那么拷贝一份`_data`,更新新的`_data`,此时reader会读取老的那份`_data`
3) 在shred_ptr引用计数会加减的地方用MutexLockGuard保护



分类: [c++](https://www.cnblogs.com/wangshaowei/category/1179634.html)