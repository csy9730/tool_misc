# [linux之DMA-BUF API使用指南（转）](https://www.cnblogs.com/reality-soul/articles/4755696.html)



# DMA-BUF API使用指南

by JHJ([jianghuijun211@gmail.com](mailto:jianghuijun211@gmail.com))

转载出自：<http://blog.csdn.net/crazyjiang>

本文将会告诉驱动开发者什么是dma-buf共享缓冲区接口，如何作为一个生产者及消费者使用共享缓冲区。

任何一个设备驱动想要使用DMA共享缓冲区，就必须为缓冲区的生产者或者消费者。

如果驱动A想用驱动B创建的缓冲区，那么我们称B为生成者，A为消费者。

生产者：

- 实现和管理缓冲区的操作函数[1]；
- 允许其他消费者通过dma-buf接口函数共享缓冲区；
- 实现创建缓冲区的细节；
- 决定在什么存储设备上申请内存；
- 管理scatterlist的迁徙；

消费者：

- 作为一个缓冲区的消费者；
- 无需担心缓冲区是如何/在哪里创建的；
- 需要一个可以访问缓冲区scatterlist的机制，将其映射到自己的地址空间，这样可以让自己可以访问到内存的同块区域，实现共享内存。

## 数据结构

dma_buf是核心数据结构，可以理解为生产者对象。

struct dma_buf {
        size_t size;
        struct file *file;
        struct list_head attachments;
        const struct dma_buf_ops *ops;
        /* mutex to serialize list manipulation and attach/detach */
        struct mutex lock;
        void *priv;
};

其中
size为缓冲区大小
file为指向共享缓冲区的文件指针
attachments为附着在缓冲区上的设备（消费者）
ops为绑定在该缓冲区的操作函数
priv为生产者的私有数据

dma_buf_attachment可以理解为是消费者对象。

struct dma_buf_attachment {
        struct dma_buf *dmabuf;
        struct device *dev;
        struct list_head node;
        void *priv;
};

其中
dmabuf为该消费者附着的共享缓冲区
dev为设备信息
node为连接其他消费者的节点
priv为消费者私有数据

这两个数据结构的关系如下所示。

![img]() 

## 外设的dma-buf操作函数

dma_buf共享缓冲区接口的使用具体包括以下步骤：

1. 生产者发出通知，其可以共享一块缓冲区；
2. 用户空间获取与该共享缓冲区关联的文件描述符，将其传递给潜在的消费者；
3. 每个消费者将其绑定在这个缓冲区上；
4. 如果需要，缓冲区使用者向消费者发出访问请求；
5. 当使用完缓冲区，消费者通知生产者已经完成DMA传输；
6. 当消费者不再使用该共享内存，可以脱离该缓冲区；

 

\1.    生产者共享缓冲区

消费者发出通知，请求共享一块缓冲区。

*struct dma_buf ****dma_buf_export***(void \*priv, struct dma_buf_ops \*ops, size_t size, int flags)*

如果函数调用成功，则会创建一个数据结构dma_buf，返回其指针。同时还会创建一个匿名文件绑定在该缓冲区上，因此这个缓冲区可以由其他消费者共享了（实际上此时缓冲区可能并未真正创建，这里只是创建了一个抽象的dma_buf）。

\2.    用户空间获取文件句柄并传递给潜在消费者

用户程序请求一个文件描述符（fd），该文件描述符指向和缓冲区关联的匿名文件。用户程序可以将文件描述符共享给驱动程序或者用户进程程序。

*int **dma_buf_fd**(struct dma_buf \*dmabuf)*

该函数创建为匿名文件创建一个文件描述符，返回"fd"或者错误。

\3.    消费者将其绑定在缓冲区上

现在每个消费者可以通过文件描述符fd获取共享缓冲区的引用。

*struct dma_buf ***dma_buf_get**(int fd)*

该函数返回一个dma_buf的引用，同时增加它的refcount（该值记录着dma_buf被多少消费者引用）。

获取缓冲区应用后，消费者需要将它的设备附着在该缓冲区上，这样可以让生产者知道设备的寻址限制。

*struct dma_buf_attachment ***dma_buf_attach**(struct dma_buf \*dmabuf, struct device \*dev)*

该函数返回一个attachment的数据结构，该结构会用于scatterlist的操作。

dma-buf共享框架有一个记录位图，用于管理附着在该共享缓冲区上的消费者。

到这步为止，生产者可以选择不在实际的存储设备上分配该缓冲区，而是等待第一个消费者申请共享内存。

\4.    如果需要，消费者发出访问该缓冲区的请求

当消费者想要使用共享内存进行DMA操作，那么它就会通过接口dma_buf_map_attachment来访问缓冲区。在调用map_dma_buf前至少有一个消费者与之关联。

*struct sg_table ** **dma_buf_map_attachment***(struct dma_buf_attachment \*, enum dma_data_direction);*

该函数是dma_buf->ops->map_dma_buf的一个封装，它可以对使用该接口的对象隐藏"dma_buf->ops->"

 *struct sg_table \* (***map_dma_buf**)(struct dma_buf_attachment \*, enum dma_data_direction);*

生产者必须实现该函数。它返回一个映射到调用者地址空间的sg_table，该数据结构包含了缓冲区的scatterlist。

如果第一次调用该函数，生产者现在可以扫描附着在共享缓冲区上的消费者，核实附着设备的请求，为缓冲区选择一个合适的物理存储空间。

基于枚举类型dma_data_direction，多个消费者可能同时访问共享内存（比如读操作）。

如果被一个信号中断，map_dma_buf()可能返回-EINTR。

\5.    当使用完成，消费者通知生成者DMA传输结束

当消费者完成DMA操作，它可以通过接口函数dma_buf_unmap_attachment发送“end-of-DMA”给生产者。

*void* **dma_buf_unmap_attachment***(struct dma_buf_attachment \*, struct sg_table \*);*

该函数是dma_buf->ops->unmap_dma_buf()的封装，对使用该接口的对象隐藏"dma_buf->ops->"。

在dma_buf_ops结构中，unmap_dma_buf定义成

*void (***unmap_dma_buf**)(struct dma_buf_attachment \*, struct sg_table \*);*

unmap_dma_buf意味着消费者结束了DMA操作。生产者必须要实现该函数。

\6.    当消费者不再使用该共享内存，则脱离该缓冲区；

当消费者对该共享缓冲区没有任何兴趣后，它应该断开和该缓冲区的连接。

a.  首先将其从缓冲区中分离出来。

*void* **dma_buf_detach***(struct dma_buf \*dmabuf, struct dma_buf_attachment \*dmabuf_attach);*

此函数从dmabuf的attachment链表中移除了该对象，如果消费者实现了dma_buf->ops->detach()，那么它会调用该函数。

b.  然后消费者返回缓冲区的引用给生产者。

*void **dma_buf_put**(struct dma_buf \*dmabuf);*

该函数减小缓冲区的refcount。

如果调用该函数后refcount变成0，该文件描述符的"release"函数将会被调用。它会调用dmabuf->ops->release()，企图释放生产者为dmabuf申请的内存。

**注意事项：**

a.  attach-detach及{map,unmap}_dma_buf成对执行非常重要。

attach-detach函数调用可以让生产者明确当前消费者对物理内存的限制。如果可能，它会在不同的存储设备上申请或/和移动物理页框。

b.  如果有必要，需要将缓冲区移动到另一个物理地址空间。

如果

- 至少有一个map_dma_buf存在，
- 该缓冲区已经分配了物理内存，

此时另一个消费者打算使用该缓冲区，生产者可能允许其请求。

如果生产者允许其请求：

如果新的消费者有严格的DMA寻址限制，而且生产者可以处理这些限制，那么生产者会在map_dma_buf里等待剩余消费者完成缓冲区访问。一旦所有消费者都完成了访问并且unmap了缓冲区，生产者可以将该缓冲区转移到严格的物理地址空间，然后再次允许{map,unmap}_dma_buf操作移动后的共享缓冲区。

如果生产者不能满足新消费者的寻址限制，调用dma_buf_attach() 则会返回失败。

## 内核处理器访问dma-buf缓冲区对象

允许处理器在内核空间作为一个消费者访问dma-buf对象的原因如下：

- 撤销/回退操作。比如一个设备连接到USB总线上，在发送数据前内核需要将第一个数据移除。
- 对其他消费者而言这个是全透明的。比如其他用户空间消费者注意不到一个 dma-buf是否做过一次撤销/回退操作。

在内核上下文访问dma_buf需要下面三个步骤：

\1.  访问前的准备工作，包括使相关cache无效，使处理器可以访问缓冲区对象；

\2.  通过dma_buf map接口函数以页为单位访问对象；

\3.  完成访问时，需要刷新必要的处理器cache，释放占用的资源；

\1.    访问前的准备工作

处理器在内核空间打算访问dma_buf对象前，需要通知生产者。

*int* **dma_buf_begin_cpu_access***(struct dma_buf \*dmabuf, size_t start, size_t len,                                enum dma_data_direction direction)*

生产者可以确保处理器可以访问这些内存缓冲区，生产者也需要确定处理器在指定区域及指定方向的访问是一致性的。生产者可以使用访问区域及访问方向来优化cache flushing。比如访问指定范围外的区域或者不同的方向（用读操作替换写操作）会导致陈旧的或者不正确的数据（比如生产者需要将数据拷贝到零时缓冲区）。

该函数调用可能会失败，比如在OOM（内存紧缺）的情况下。

\2.    访问缓冲区

为了支持处理器可以访问到驻留在高端内存中的dma_buf对象，需要调用一个和kmap类似的接口函数。访问dma_buf需要页对齐。在访问对象前需要先做映射工作，及需要得到一个内核虚拟地址。操作完后，需要取消该对象的映射。

*void ****dma_buf_kmap***(struct dma_buf \*, unsigned long);*

*void* **dma_buf_kunmap***(struct dma_buf \*, unsigned long, void \*);*

该函数有对应的原子操作函数，如下所示。在调用原子操作函数时，生产者和消费者都不能被阻塞。

*void ****dma_buf_kmap_atomic***(struct dma_buf \*, unsigned long);*

*void* **dma_buf_kunmap_atomic***(struct dma_buf \*, unsigned long, void \*);*

生产者在同一时间不能同时调用原子操作函数（在任何进程空间）。

如果访问缓冲区区域不是页对齐的，虽然kmap对应的区域数据得到了更新，但是在这个区域附近的区域数据也相应得到了更新，这个不是我们所希望的。也就是说kmap更新了自己关心的区域外，还更新了其他区域，对于那些区域的使用者来说，数据就已经失效了。

下图给出了一个例子，一共有四个连续的页，其中kmap没有页对齐获取部分缓冲区，即红色部分，由于会同步cache，其附近的区域数据也会被更新，被更新区域的范围和cache行的大小有关系。

![img]()

注意这些调用总是成功的，生产者需要在begin_cpu_access中完成所有的准备，在这其中可能才会有失败。

\3.    完成访问

当消费者完成对begin_cpu_access指定范围内的缓冲区访问，需要通知生产者（刷新cache，同步数据集释放资源）。

*void* **dma_buf_end_cpu_access***(struct dma_buf \*dma_buf,                                        size_t start, size_t len,                                        enum dma_data_direction dir);*

## 用户空间通过mmap直接访问缓冲区

在用户空间映射一个dma-buf对象，主要有两个原因：

- 处理器回退/撤销操作；
- 支持消费者程序中已经存在的mmap接口；

\1.  处理器在一个pipeline中回退/撤销操作

在处理pipeline过程中，有时处理器需要访问dma-buf中的数据（比如创建thumbnail, snapshots等等）。用户空间程序通过使用dma-buf的文件描述符fd调用mmap来访问dma-buf中的数据是一个好办法，这样可以避免用户空间程序对共享内存做一些特殊处理。

进一步说Android的ION框架已经实现了该功能（从用户空间消费者来说它实现了一个和dma-buf很像的东西，使用fds用作文件句柄）。因此实现该功能对于Android用户空间来说是有意义的。

没有特别的接口，用户程序可以直接基于dma-buf的fd调用mmp。

\2.  支持消费者程序中已经存在的mmap接口

与处理器在内核空间访问dma-buf对象目的一样，用户空间消费者可以将生产者的dma-buf缓冲区对象当做本地缓冲区对象一样使用。这对drm特别重要，其Opengl，X的用户空间及驱动代码非常巨大，重写这部分代码让他们用其他方式的mmap，工作量会很大。

*int **dma_buf_mmap**(struct dma_buf \*, struct vm_area_struct \*, unsigned long);*

参考文献

[1] struct dma_buf_ops in include/linux/dma-buf.h 
[2] All interfaces mentioned above defined in include/linux/dma-buf.h 
[3] <https://lwn.net/Articles/236486/> 
[4] Documentation/dma-buf-sharing.txt