# intel dpdk api ring 模块源码详解

## 摘要

intel dpdk 提供了一套ring 队列管理代码，支持单生产者产品入列，单消费者产品出列；多名生产者产品入列，多产品消费这产品出列操作；

我们以app/test/test_ring.c文件中的代码进行讲解，test_ring_basic_ex()函数完成一个基本功能测试函数；

## 1、ring的创建

1. rp = rte_ring_create("test_ring_basic_ex", RING_SIZE, SOCKET_ID_ANY, 
2. ​    RING_F_SP_ENQ | RING_F_SC_DEQ); 

调用rte_ring_create函数去创建一个ring，

第一参数"test_ring_basic_ex"是这个ring的名字，

第二个参数RING_SIZE是ring的大小;

 第三个参数是在哪个socket id上创建 ，这指定的是任意；

第四个参数是指定此ring支持单入单出；



我看一下rte_ring_create函数主要完成了哪些操作；

1. rte_rwlock_write_lock(RTE_EAL_TAILQ_RWLOCK); 

执行读写锁的加锁操作；

1. mz = rte_memzone_reserve(mz_name, ring_size, socket_id, mz_flags); 

预留一部分内存空间给ring，其大小就是RING_SIZE个sizeof(struct rte_ring)的尺寸；
```
1. r = mz->addr; 
2.  
3. /* init the ring structure */ 
4. memset(r, 0, **sizeof(\*r));** 
5. rte_snprintf(r->name, **sizeof(r->name), "%s", name);** 
6. r->flags = flags; 
7. r->prod.watermark = count; 
8. r->prod.sp_enqueue = !!(flags & RING_F_SP_ENQ); 
9. r->cons.sc_dequeue = !!(flags & RING_F_SC_DEQ); 
10. r->prod.size = r->cons.size = count; 
11. r->prod.mask = r->cons.mask = count-1; 
12. r->prod.head = r->cons.head = 0; 
13. r->prod.tail = r->cons.tail = 0; 
14.  
15. TAILQ_INSERT_TAIL(ring_list, r, next); 
```

将获取到的虚拟地址给了ring，然后初始化她，prod 代表生成者，cons代表消费者；

生产者最大可以生产count个，其取模的掩码是 count-1； 目前是0个产品，所以将生产者的头和消费者头都设置为0；其尾也设置未0；

1. rte_rwlock_write_unlock(RTE_EAL_TAILQ_RWLOCK); 

执行读写锁的写锁解锁操作；



## 2、ring的单生产者产品入列

1. rte_ring_enqueue(rp, obj[i]) 

ring的单个入列；

1. __rte_ring_sp_do_enqueue 

最终会调用到上面这个函数，进行单次入列，我们看一下它的实现；

1. prod_head = r->prod.head; 
2. cons_tail = r->cons.tail; 

暂时将生产者的头索引和消费者的尾部索引交给临时变量；

1. free_entries = mask + cons_tail - prod_head; 

计算还有多少剩余的存储空间；

1. prod_next = prod_head + n; 
2. r->prod.head = prod_next; 

如果有足够的剩余空间，我们先将临时变量prod_next 进行后移，同事将生产者的头索引后移n个；

1. /* write entries in ring */ 
2. **for (i = 0; likely(i < n); i++)** 
3.   r->ring[(prod_head + i) & mask] = obj_table[i]; 
4. rte_wmb(); 

执行写操作，将目标进行入队操作，它并没有任何大数据量的内存拷贝操作，只是进行指针的赋值操作，因此dpdk的内存操作很快，应该算是零拷贝；

1. r->prod.tail = prod_next; 

成功写入之后，将生产者的尾部索引赋值为prox_next ，也就是将其往后挪到n个索引；我们成功插入了n个产品；目前是单个操作，索引目前n=1；



## 3、ring的单消费者产品出列

1. rte_ring_dequeue(rp, &obj[i]); 

同样出队也包含了好几层的调用，最终定位到__rte_ring_sc_do_dequeue函数；

1. cons_head = r->cons.head; 
2. prod_tail = r->prod.tail; 

先将消费者的头索引和生产者的头索引赋值给临时变量；

1. entries = prod_tail - cons_head; 

计算目前ring中有多少产品；

1. cons_next = cons_head + n; 
2. r->cons.head = cons_next; 

如果有足够的产品，就将临时变量cons_next往后挪到n个值，指向你想取出几个产品的位置；同时将消费者的头索引往后挪到n个；这目前n=1；因为是单个取出；

1. /* copy in table */ 
2. rte_rmb(); 
3. **for (i = 0; likely(i < n); i++) {** 
4.   obj_table[i] = r->ring[(cons_head + i) & mask]; 
5. } 


执行读取操作，同样没有任何的大的数据量拷贝，只是进行指针的赋值；

1. r->cons.tail = cons_next; 

最后将消费者的尾部索引也像后挪动n个，最终等于消费者的头索引；



## 4、ring的多生产者产品入列

 多生产者入列的实现是在 __rte_ring_mp_do_enqueue()函数中；在dpdk/lib/librte_ring/rte_ring.h 文件中定义；其实这个函数和单入列函数很相似；
```
1.   /* move prod.head atomically */ 
2.   **do {** 
3. ​    /* Reset n to the initial burst count */ 
4. ​    n = max; 
5. ................. 
6.  
7. ​    prod_next = prod_head + n; 
8. ​    success = rte_atomic32_cmpset(&r->prod.head, prod_head, 
9. ​             prod_next); 
10.   } **while (unlikely(success == 0));** 
```

在单生产者中时将生产者的头部和消费者的尾部直接赋值给临时变量，去求剩余存储空间；最后将生产者的头索引往后移动n个，

但在多生产者中，要判断这个头部是否和其他的生产者发出竞争，

​    success = rte_atomic32_cmpset(&r->prod.head, prod_head,
​             prod_next);

是否有其他生产者修改了prod.head，所以这要重新判断一下prod.head是否还等于prod_head，如果等于，就将其往后移动n个，也就是将prod_next值赋值给prod.head;

如果不等于，就会失败，就需要进入do while循环再次循环一次；重新刷新一下prod_head和prod_next 以及prod.head的值 ；



1. /* write entries in ring */ 
2. **for (i = 0; likely(i < n); i++)** 
3.   r->ring[(prod_head + i) & mask] = obj_table[i]; 
4. rte_wmb(); 

执行产品写入操作；

写入操作完成之后，如是单生产者应该是直接修改生产者尾部索引，将其往后顺延n个，但目前是多生产者操作；是怎样实现的呢？

1. /* 
2.  \* If there are other enqueues in progress that preceeded us, 
3.  \* we need to wait for them to complete 
4.  */ 
5. **while (unlikely(r->prod.tail != prod_head))** 
6.   rte_pause(); 
7.  
8. r->prod.tail = prod_next; 



这也先进行判断，判断当前的生产者尾部索引是否还等于，存储在临时变量中的生产者头索引，

如果不等于，说明，有其他的线程还在执行，而且应该是在它之前进行存储，还没来得及更新prod.tail;等其他的生产者更新tail后，就会使得prod.tail==prod_head;

之后再更新，prod.tail 往后挪动n个，最好实现 prod.tail==prod.head==prod_next==prod_head+n;



## 5、ring的多消费者产品出列

多个消费者同时取产品是在__rte_ring_mc_do_dequeue()函数中实现；定义在dpdk/lib/librte_ring/rte_ring.h文件中；

1.   /* move cons.head atomically */ 
2.   **do {** 
3. ​    /* Restore n as it may change every loop */ 
4. ​    n = max; 
5.  
6. ​    cons_head = r->cons.head; 
7. ​    prod_tail = r->prod.tail; 
8. ................... 
9.  
10. ​    cons_next = cons_head + n; 
11. ​    success = rte_atomic32_cmpset(&r->cons.head, cons_head, 
12. ​             cons_next); 
13.   } **while (unlikely(success == 0));** 

和多生产者一样，在外面多包含了一次do while循环，防止多消费者操作发生竞争；

在循环中先将消费者的头索引和生产者的为索引赋值给临时变量；让后判断有多少剩余的产品在循环队列，

如有n个产品，就将临时变量cons_next 往后挪动n个，然后判断目前的消费者头索引是否还等于刚才的保存在临时变量cons_head  中的值，如相等，说明没有发生竞争，就将cons_next赋值给

消费者的头索引  r->cons.head，如不相等，就需要重新做一次do while循环；



1. /* copy in table */ 
2. rte_rmb(); 
3. **for (i = 0; likely(i < n); i++) {** 
4.   obj_table[i] = r->ring[(cons_head + i) & mask]; 
5. } 

在成功更新消费者头索引后，执行读取产品操作，这并没有大的数据拷贝操作，只是进行指针的重新赋值操作；
```
1. /* 
2.  \* If there are other dequeues in progress that preceded us, 
3.  \* we need to wait for them to complete 
4.  */ 
5. **while (unlikely(r->cons.tail != cons_head))** 
6.   rte_pause(); 
7.  
8. __RING_STAT_ADD(r, deq_success, n); 
9. r->cons.tail = cons_next; 
```

读取完成后，就要更新消费者的尾部索引；

为了避免竞争，就要判是否有其他的消费者在更新消费者尾部索引；如果目前的消费者尾部索引不等于刚才保存的在临时变量cons_head 的值，就要等待其他消费者修改这个尾部索引；

如相等，机可以将当前消费者的尾部索引往后挪动n个索引值了，

实现  r->cons.tail=r->cons.head=cons_next=cons_head+n;



## 6、ring的其他判定函数

1. rte_ring_lookup("test_ring_basic_ex") 

验证以test_ring_basic_ex 为名的ring是否创建成功；

1. rte_ring_empty(rp) 

判断ring是否为空；

1. rte_ring_full(rp) 

判断ring是否已经满；

1. rte_ring_free_count(rp) 

判断当前ring还有多少剩余存储空间；

 

 

 