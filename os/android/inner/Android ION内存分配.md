# [Android ION内存分配](https://www.cnblogs.com/willhua/p/10029280.html)



# The Android ION memory allocator

[英文原文](https://lwn.net/Articles/480055/)

### ION heaps

#### ION设计的目标

为了避免内存碎片化，或者为一些有着特殊内存需求的硬件，比如GPUs、display controller以及camera等，在系统启动的时候，会为他们预留一些memory pools，这些memory pools就由**ION**来管理。通过**ION**就可以在硬件以及user space之间实现**zero-copy**的内存share。

#### ION的实现

**ION**通过**ION heaps**来展示presents它对应的memory pools。不同的Android硬件可能会要求不同的**ION heaps**实现，默认的**ION**驱动会提供如下三种不同的**ION heaps**实现：

1. ION_HEAP_TYPE_SYSTEM: memory allocated via vmalloc_user()
2. ION_HEAP_TYPE_SYSTEM_CONTIG: memory allocated via kzalloc
   . ION_HEAP_TYPE_CARVEOUT: carveout memory is physically contiguous and set aside at boot.
   开发者可以自己实现更多的**ION heaps**。比如**NVIDIA**就提交了一种**ION_HEAP_TYPE_IOMMU**的heap，这种heap带有**IOMMU**功能。
   不管哪一种**ION heaps**实现，他们都必须实现如下接口：

```c++
   struct ion_heap_ops {
	int (*allocate) (struct ion_heap *heap,
			 struct ion_buffer *buffer, unsigned long len,
			 unsigned long align, unsigned long flags);
	void (*free) (struct ion_buffer *buffer);
	int (*phys) (struct ion_heap *heap, struct ion_buffer *buffer,
		     ion_phys_addr_t *addr, size_t *len);
	struct scatterlist *(*map_dma) (struct ion_heap *heap,
			 struct ion_buffer *buffer);
	void (*unmap_dma) (struct ion_heap *heap, 
	         struct ion_buffer *buffer);
	void * (*map_kernel) (struct ion_heap *heap, 
	         struct ion_buffer *buffer);
	void (*unmap_kernel) (struct ion_heap *heap, 
	         struct ion_buffer *buffer);
	int (*map_user) (struct ion_heap *heap, struct ion_buffer *buffer,
			 struct vm_area_struct *vma);
   };
```

简单来说，接口的各个函数功能如下：

- `allocate()`和`free()`分别用来从heap中**分配**或者**释放**一个`ion_buffer`对象
- 对于物理连续的内存，`phys()`用来得到`ion_buffer`对象的**物理内存地址**及其**大小**。如果heap没有提供物理连续的内存，那么它也可以不用提供这个接口。其中，`ion_phys_addr_t`将来会被定义在*/include/linux/types.h*中的`phys_addr_t`替代。
- `map_dma()`和`unmap_dma()`分别来用使`ion_buffer`对象为[DMA（Direct Memory Access，直接内存存取。顾名思义，不占用cpu资源，从一个硬件存储区域把一部分连续的数据复制到另一个硬件存储区域）](https://blog.csdn.net/kris_fei/article/details/72628692)做好准备或者取消做好准备
- `map_kernel()`和`unmap_kernel()`分别用来把physical memory映射(map)到内核虚拟地址空间(kernel virtual address space)或者取消映射
- `map_user()`用来把physical memory映射(map)到用户内存空间(user space)。为什么没有对应的`unmap_user()`呢？因为，这个映射用一个file descriptor来表示，当这个file descriptor关闭的时候，这个映射关系就自动取消了。

------

### 在user space使用ION

#### 使用场景

典型的，在用户空间使用的设备访问库(user space device access libraries)一般使用**ION**来分配大块连续的media buffers。比如，still camera library分配一个capture buffer来供camera device使用。当这个buffer填满video data的时候，这个library就能把这块buffer传递给kernel，然后让JPEG硬编码模块来处理。

#### 具体使用细节

在user space 的C/C++程序能够能够分配**ION**内存之前，它必须获得访问`/dev/ion`的权限。通过调用`open("/dev/ion", O_RDONLY)`就可获得一个以handle形式返回的file descriptor，这个file descriptor用来代表一个**ION client**。注意，虽然传给`open`一个`O_RDONLY`参数，但是你仍然可对这块memory进行写操作。在一个user process中最多有一个client。当有了一个client之后，就可以开始分配**ION**内存。为了分配内存，client必须填满下面的`ion_allocation_data`结构，`handle`除外，因为它是output参数。其他三个参数分别指明内存的大小、对齐方式以及flags。flags是一个bit mask，用来说明可以从哪些heaps中分配想要的内存。其决定顺序由系统启动时，通过`ion_device_add_heap()`添加的heap顺来决定。比如，ION_HEAP_TYPE_CARVEOUT是在ION_HEAP_TYPE_CONTIG之前被add的，那么如果`flags = ION_HEAP_TYPE_CONTIG | ION_HEAP_TYPE_CARVEOUT`，那么就是先尝试分配ION_HEAP_TYPE_CARVEOUT类型的heap，如果不行，再尝试分配ION_HEAP_TYPE_CONTIG类型的heap。（）

```c++
   struct ion_allocation_data {
        size_t len;
        size_t align;
        unsigned int flags;
        struct ion_handle *handle;
   }
```

user space通过`ioctl()`系统接口来与**ION**交互。在client填充`ion_allocatoin_data`结构之后，就可以通过调用`int ioctl(int client_fd, ION_IOC_ALLOC, struct ion_allocation_data *allocation_data)`来allocate a buffer。这个调用介绍之后，分配的buffer会通过`ion_allocatoin_data`的`handle`来返回，但是CPU不可以访问这个buffer。这个`handle`只可以通过调用`int ioctl(int client_fd, ION_IOC_SHARE, struct ion_fd_data *fd_data);`来获得一个用来share的file descriptor。这里，`client_fd`参数是前面通过`open`获得的一个对应`/dev/ion` file descriptor，`fd_data`是如下的数据结构，其`handle`对应`ion_allocation_data::handle`，是input参数；`fd`则是output参数，可以用来share。
当一个user process中的client分享(share)了这个`fd`之后，在其他user process中(当然，也可share给创建这个`fd`的client自己)，为了获得这个shared buffer，先必须通过调用`open("/dev/ion", O_RDONLY)`获得一个client。(注：**ION**通过线程的PID来track各个client， 尤其是process中的"group leader"线程的PID。在相同的process中重复调用`open("/dev/ion", O_RDONLY)`只会获得指向kernel同一个client的another file descriptor)。获得client之后，然后再通过`mmap()`函数来把这个`fd`映射到address space of process([mmap函数参考1](http://man7.org/linux/man-pages/man2/mmap.2.html)，[参考2](http://www.cnblogs.com/xmphoenix/archive/2011/08/20/2146938.html))。如果要释放这个`fd`对应的buffer，在调用`mmap()`的process中，先要通过`munmap()`来取消`mmap()`的效果。然后在之前share这个`fd`的client中，需要通过`int ioctl(int client_fd, ION_IOC_FREE, struct ion_handle_data *handle_data);`来关闭这个`fd`对应的file descriptor。其中，`ion_handle_data`表示前面通过`ION_IOC_ALLOC`命令获得的`handle`，其定义如下：

```c++
     struct ion_handle_data {
	     struct ion_handle *handle;
     }
```

这个`ION_IOC_FREE`命令会导致对应的`handle`的计数减1。当`handle`计数为0的时候，其指向的`ion_handle`对象就会被销毁，并且相关的**ION bookkeeping**数据结构也会更新。

##### Demo

在这个Demo中，`fd`在同一个client中被share使用：[来源](http://devarea.com/android-ion/#.W_lnfOgzaH8)

```
#include<stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <sys/mman.h>

#include "/home/developer/kernel3.4/goldfish/include/linux/ion.h"

void main()
{
	struct ion_fd_data fd_data;
	struct ion_allocation_data ionAllocData;
	ionAllocData.len=0x1000;
	ionAllocData.align = 0;
	ionAllocData.flags = ION_HEAP_TYPE_SYSTEM;

	int fd=open("/dev/ion",O_RDWR);
	ioctl(fd,ION_IOC_ALLOC, &ionAllocData);
	fd_data.handle = ionAllocData.handle;
	ioctl(fd,ION_IOC_SHARE,&fd_data); 
    int *p = mmap(0,0x1000,PROT_READ|PROT_WRITE,MAP_SHARED,fd_data.fd,0);
	p[0]=99;
	perror("test");
	printf("hello all %d\n",p[0]);
}
```

------

### 在kernel中share ION buffer

在kernel中支持multiple clients，每一个使用**ION**功能的driver都可以在kernel中对应一个client。一个kernel driver通过调用`struct ion_client *ion_client_create(struct ion_device *dev, unsigned int heap_mask, const char *debug_name)`来获得一个**ION** client handle（注意，前面在user space中通过`open("/dev/ion", O_RDONLY)`返回的client是`int`类型）。`dev`参数是一个和`/dev/ion`相关的**global ION device**，`heap_mask`参数和之前提到的`ion_allocation_data`的`flags`成员一样的含义。
当在user space中通过`ION_IOC_SHARE`命令得到一个buffer的file descriptor并把它传递给kernel之后，kernel driver通过调用`struct ion_handle *ion_import_fd(struct ion_client *client, int fd_from_user);`来把这个fd变成一个`ion_handle`对象，这个对象就是这个driver中对相应的buffer一个client-local reference。`ion_import_fd`方法会根据这个buffer的物理地址来查找：在本client中是否已经obtained一个对应此buffer的`ion_handle`，如果是的话，那么就可以简单的增加这个`ion_handle`的引用计数即可。
有些硬件只能通过physical addresses来操作physically-contiguous buffers，那么，这些对应的drivers就需要通过调用`int ion_phys(struct ion_client *client, struct ion_handle *handle, ion_phys_addr_t *addr, size_t *len)`来把`ion_handle`转变成一个physical buffer。当然，如果这个buffer不是physically contiguous，那么这个调用就会失败。
当处理一个来自client的调用时，**ION**会validates 输入的 file descriptor, client and handle arguments。比如**ION**会确保 file descriptor是由`ION_IOC_SHARE`命令创建的；比如当`ion_phys()`调用时，**ION**会检测这个buffer是否在这个client对应有访问权限list中，如果不是，那么就会返回错误。这样的验证机制能够减少可能的unwanted accesses以及疏忽的内存泄露。
**ION**通过debugfs提供可视化的debug，它通过在/sys/kernel/debug/ion下面，使用stored files来记录相应的heaps和clients，并使用symbolic names或者PIDs来标志。

### 比较ION和DMABUF

本节部分翻译。

- **ION**和**DMABUF**都是通过传递一个匿名file descriptor对象，给其他client一个基于引用计数的访问权限，从而达到分享内存的目的。
- **ION**通过一个可分享和追踪的方式从预留的memory pool中分配内存。
- **DMABUF**更多的专注于buffer导入、导出以及同步的方式来实现在**NON-ARM**架构上的buffer的分享。
- **ION**目前**只支持Android kernel**
- **ION**所有的user-space program都可以通过*/dev/ion*接口来分配**ION**内存。但是在Android会通过验证user和group IDs的方式来阻止对**ION**的非授权访问。

### 参考

[The Android ION memory allocator](https://lwn.net/Articles/480055/)
[Good PDF](http://web.cse.ohio-state.edu/~xuan.3/courses/694/Memory-Management.pdf)
[Integrating the ION memory allocator](https://lwn.net/Articles/565469/)
[ION.C](https://android.googlesource.com/platform/system/core/+/master/libion/ion.c)
[ION.H](https://android.googlesource.com/platform/system/core/+/master/libion/original-kernel-headers/linux/ion.h)
[DEMO](http://devarea.com/android-ion/#.W_qMsegzaH9)
[CSDN](https://blog.csdn.net/jacky_perf/article/details/51992664)

/************************* Stay hungry, Stay foolish. [@willhua ](http://www.cnblogs.com/willhua/)************************/



分类: [Android](https://www.cnblogs.com/willhua/category/962852.html)

标签: [OpenCL](https://www.cnblogs.com/willhua/tag/OpenCL/), [Android](https://www.cnblogs.com/willhua/tag/Android/)