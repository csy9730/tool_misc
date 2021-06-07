# Android ION源码浅析
[lbtrace](https://www.jianshu.com/u/742d7f638281)关注

0.2562017.12.24 21:59:11字数 1,518阅读 3,389

# Android ION

> ION是Google在Android 4.0上推出的一个通用的内存管理器，目的是为了解决众多厂商的内存管理器碎片化问题。如高通的PMEM、NVIDIA的NVMAP等。用户空间、内核驱动均可以使用ION分配内存，除此之外，ION也提供多个Client之间共享内存。通常，SurfaceFlinger/Camera/Audio等会使用ION。

本文以MSM平台SYSTEM HEAP为例。



![img](https://upload-images.jianshu.io/upload_images/1945694-1a4890aae9209419.png?imageMogr2/auto-orient/strip|imageView2/2/w/710/format/webp)

## Android ION数据结构

### ion_device

```c
struct ion_device {
    struct miscdevice dev;
    struct rb_root buffers;
    struct mutex buffer_lock;
    struct rw_semaphore lock;
    struct plist_head heaps;
    ...
    struct rb_root clients;
    ...
};
```

- dev：具体平台上的ION设备
- buffers：通过红黑树管理所有通过ion分配的ion_buffer
- heaps：ion设备所有的heaps链表，通过plist（priority-sorted list）管理
- clients：红黑树管理使用ion的所有ion_client

### ion_client

```c
struct ion_client {
    struct rb_node node;
    struct ion_device *dev;
    struct rb_root handles;
    struct idr idr;
    struct mutex lock;
    char *name;
    char *display_name;
    int display_serial;
    struct task_struct *task;
    pid_t pid;
    struct dentry *debug_root;
};
```

- ion_client每个进程最多有一个
- node：所有client所在的红黑树节点
- dev：指向ion device
- handles：该client所管理的所有ion_handle红黑树
- task：client所属进程的task_struct

### ion_handle

```c
struct ion_handle {
    struct kref ref;
    struct ion_client *client;
    struct ion_buffer *buffer;
    struct rb_node node;
    unsigned int kmap_cnt;
    int id;
};
```

- ion_handle用于连接client与buffer，修改该结构需要lock所在的client
- ref：引用计数
- client：所属的ion_client
- buffer：该handle使用的ion_buffer
- node：client handles红黑树节点
- id：每个client内唯一的id，由client->idr分配

### ion_buffer

```c
struct ion_buffer {
    struct kref ref;
    union {
        struct rb_node node;
        struct list_head list;
    };
    struct ion_device *dev;
    struct ion_heap *heap;
    unsigned long flags;
    unsigned long private_flags;
    size_t size;
    union {
        void *priv_virt;
        ion_phys_addr_t priv_phys;
    };
    struct mutex lock;
    int kmap_cnt;
    void *vaddr;
    struct sg_table *sg_table;
    struct page **pages;
    struct list_head vmas;
    /* used to track orphaned buffers */
    int handle_count;
    char task_comm[TASK_COMM_LEN];
    pid_t pid;
};
```

- ref：引用计数
- node：ion_device buffers红黑树节点
- heap：buffer来自的heap
- kmap_cnt：ion_buffer映射到内核的次数
- vaddr：如果kmap_cnt不为0，vaddr位内核映射
- dmap_cnt：ion_buffer映射到dma的次数
- sg_table：如果dmap_cnt不为0，为sg table
- vmas：映射到ion_buffer的vma列表
- handle：应用该ion_buffer的handle数
- task_comm： 通过handle引用该ion_buffer的最后一个client所属进程

### ion_heap

```c
struct ion_heap {
    struct plist_node node;
    struct ion_device *dev;
    enum ion_heap_type type;
    struct ion_heap_ops *ops;
    unsigned long flags;
    unsigned int id;
    const char *name;
    struct shrinker shrinker;
    void *priv;
    struct list_head free_list;
    size_t free_list_size;
    spinlock_t free_lock;
    wait_queue_head_t waitqueue;
    struct task_struct *task;

    int (*debug_show)(struct ion_heap *heap, struct seq_file *, void *);
    atomic_t total_allocated;
    atomic_t total_handles;
};
```

- node：ion device通过plist管理所有的ion_heap
- type：ion heap类型
- ops：ion heap的操作
- id：ion heap id同时也表示优先级，id越小优先级越高，参考plist
- free_list：deferred free list
- free_list_size：size of deferred free list
- waitqueue：queue to wait on from deferred free thread
- task：task struct of deferred free thread

### ion_system_heap

```c
struct ion_system_heap {
    struct ion_heap heap;
    struct ion_page_pool **uncached_pools;
    struct ion_page_pool **cached_pools;
};
```

- heap：关联的ion_heap
- uncached_pools：空闲页所在的pool，如果ion heap的flag为uncached从此分配和释放
- cached_pools： 空闲页所在的pool，如果ion heap的flag为cached从此分配和释放

### ion_page_pool

```c
struct ion_page_pool {
    int high_count;
    int low_count;
    struct list_head high_items;
    struct list_head low_items;
    struct mutex mutex;
    gfp_t gfp_mask;
    unsigned int order;
    struct plist_node list;
};
```

- high_count：pool中属于高端内存的内存块数目
- low_count： pool中属于低端内存的内存块数目
- hight_items：pool中属于高端内存的内存块链表
- low_items： pool中属于低端内存的内存块链表
- order：pool中内存块的阶，也就是pool中内存块的大小为(1<<order) * PAGE_SIZE
- list： plist node for list of pools

### 小结



![img](https://upload-images.jianshu.io/upload_images/1945694-1f81f765f6f2f6c5?imageMogr2/auto-orient/strip|imageView2/2/w/402/format/webp)

ION数据结构关系图

## Android ION设备初始化



![img](https://upload-images.jianshu.io/upload_images/1945694-72ebe2eec9818f8f?imageMogr2/auto-orient/strip|imageView2/2/w/680/format/webp)

ION设备初始化流程

1. 解析ion dtsi配置获取系统当前配置的堆
2. 创建ion设备，同时在debugfs中创建ion目录以及ion目录下的heaps以及clients目录，最后 初始化ion device所管理的buffers/clients红黑树以及heaps优先级链表
3. 创建系统当前配置的堆，以system heap为例，创建ion_system_heap以及所管理的page pool
4. 根据堆的标志以及有无shrink函数，分别初始化ion heap的延迟释放ion_buffer链表以及注册shrink函数，根据ion heap的ID也就是优先级将其添加到设备的优先级链表中，在debugfs的ion/heaps下创建以堆名命名的目录
5. 注册show_mem_notifier，用于调试，当cat /sys/kernel/debug/show_mem_notifier时，调试信息将打印在kernel log中

## ION system heap分配内存



![img](https://upload-images.jianshu.io/upload_images/1945694-b23afbe1d25314d6?imageMogr2/auto-orient/strip|imageView2/2/w/761/format/webp)

ION system heap分配内存流程

1. 在使用Ion heap之前，首先要open设备文件，在ion_open中为该进程创建ion_client，初始化ion_client后将其插入到ion dev的clients红黑树中，并未改client创建debugfs
2. 对于ion heap分配，我们从ion_alloc开始分析，在iondev的ion heap优先级链表中搜索我们请求的目标ion heap，如果找到调用ion_buffer_create
3. 在ion_buffer_create中首先创建ion_buffer，然后调用请求堆的allocate函数，这里我们只关心ion_system_heap_allocate
4. 重点分析ion_system_heap_allocate

```c
static int ion_system_heap_allocate(struct ion_heap         *heap, struct ion_buffer *buffer, unsigned long size, unsigned long align, unsigned long flags)
{
    ...
    struct list_head pages;
    struct list_head pages_from_pool;
    struct page_info *info, *tmp_info;
    int i = 0;
    unsigned int nents_sync = 0;
    unsigned long size_remaining = PAGE_ALIGN(size);
    unsigned int max_order = orders[0];
    struct pages_mem data;
    ...
```

- Pages为从PCP/buddy中分配的page链表
- pages_from_pool为从Ion system heap page pool分配的page链表
- data用来记录从PCP/buddy中分配的内存的大小
- size_remaining用来表示本次需要分配的内存大小

```c
    ...
    while (size_remaining > 0) {
        info = alloc_largest_available(sys_heap, buffer, size_remaining, max_order);
        if (!info)
            goto err;

        sz = (1 << info->order) * PAGE_SIZE;

        if (info->from_pool) {
            list_add_tail(&info->list, &pages_from_pool);
        } else {
            list_add_tail(&info->list, &pages);
            data.size += sz;
            ++nents_sync;
        }
        size_remaining -= sz;
        max_order = info->order;
        i++;
    }
    ...
```

- alloc_largest_available每次分配小于size_remaining的最大的2的order次幂的内存，sz表示本次分配的内存大小，如果本次是从pool中分配的添加到pages_from_pool链表中，否则添加到pages链表，i表示分配size_remaining大小的内存用了多少次，nents_sync表示从PCP/buddy中分配内存块的个数（次数），这两个值是为了后面创建scatterlist服务，scatterlist可以认为是一个内存块的链表，后面的do while循环主要是为了将我们分配得到的pages_from_pool和pages两个链表进行合并

```c
    ...
    do {
        info = list_first_entry_or_null(&pages, struct page_info, list);
        tmp_info = list_first_entry_or_null(&pages_from_pool,
                            struct page_info, list);
        if (info && tmp_info) {
            if (info->order >= tmp_info->order) {
                i = process_info(info, sg, sg_sync, &data, i);
                sg_sync = sg_next(sg_sync);
            } else {
                i = process_info(tmp_info, sg, 0, 0, i);
            }
        } else if (info) {
            i = process_info(info, sg, sg_sync, &data, i);
            sg_sync = sg_next(sg_sync);
        } else if (tmp_info) {
            i = process_info(tmp_info, sg, 0, 0, i);
        } else {
            BUG();
        }
        sg = sg_next(sg);

    } while (sg);
    ...
```

- 将pages以及pages_from_pool链表中物理地址连续的内存块按照order大小，分别添加到sg以及sg_sync两个scatterlist中，其中pages中的内存块同时添加到两个scatterlist中，pages_from_pool中的只添加到sg scatterlist中。同时将data->pages初始化为sg_sync scatterlist中所有page页

- 分配到的内存的组织结构图

  

  ![img](https://upload-images.jianshu.io/upload_images/1945694-c7e86d0b707454b4.png?imageMogr2/auto-orient/strip|imageView2/2/w/570/format/webp)

```c
    ...
    ret = msm_ion_heap_pages_zero(data.pages, data.size >> PAGE_SHIFT);
    if (ret) {
        pr_err("Unable to zero pages\n");
        goto err_free_sg2;
    }

    if (nents_sync)
        dma_sync_sg_for_device(NULL, table_sync.sgl, table_sync.nents,
                       DMA_BIDIRECTIONAL);

    buffer->priv_virt = table;
    if (nents_sync)
        sg_free_table(&table_sync);
    msm_ion_heap_free_pages_mem(&data);
    return 0;
    ...
```

- 利用data结构体，将从buddy分配到的所有内存块清零
- 对于dma_sync_sg_for_device，暂未搞懂
- 最后释放table_sync scatterlist以及data
- 在真正分配完内存之后，还需要创建ion_handle，初始化后添加到ion client所管理的handles红黑树中

## ION system heap内存释放

当没有ion client引用ion buffer的时候，ion buffer就会被释放，通过上文我们知道ion buffer的可用内存实际上是由物理地址连续的多个内存块组成的scatterlist。释放的时候，就是遍历该scatterlist，释放该内存块，如果没有设置ION_PRIV_FLAG_SHRINKER_FREE标志，将内存块释放到ion system heap page pool；否则释放到PCP/buddy