# IO

## overview

- 阻塞 blocking 阻塞调用会一直等待远程数据就绪再返回
- 非阻塞 non-blocking 无论在什么情况下都会立即返回

- 同步 需要自行获取结果
- 异步 asynchronous 底层通知结果

- 
- 同步阻塞 最基础的场景
- 同步非阻塞 需要调用方轮询结果
- 异步非阻塞 事件依赖关系通过回调实现，容易滥用导致回调地狱
- 异步阻塞 异步下支持的特殊场景 等效于 await?

- blocking IO - 阻塞IO
- nonblocking IO - 非阻塞IO
- IO multiplexing - IO多路复用
- signal driven IO - 信号驱动IO
- asynchronous IO - 异步IO

不管文件IO还是网络socket的IO，其读写都需要经过两个阶段：

1. wait for data（准备数据到内核的缓冲区）
2. copy data from kernel to user （从缓冲区拷贝到用户空间）

### Blocking IO
阻塞IO
### NonBlocking IO.
非阻塞IO

主要实现接口
- select 多路复用机制
- poll 多路复用机制
- epoll 事件机制


#### file

磁盘文件，进程缓冲区，socket，IO操作，设备都可以抽象成文件。
 **文件描述符**
文件描述符（File descriptor）是计算机科学中的一个术语，是一个用于表述指向文件的引用的抽象化概念。
文件描述符在形式上是一个非负整数。实际上，它是一个索引值，指向内核为每一个进程所维护的该进程打开文件的记录表。当程序打开一个现有文件或者创建一个新文件时，内核向进程返回一个文件描述符。在程序设计中，一些涉及底层的程序编写往往会围绕着文件描述符展开。但是文件描述符这一概念往往只适用于UNIX、Linux这样的操作系统。

#### 缓存I/O

缓存I/O又称为标准I/O，大多数文件系统的默认I/O操作都是缓存I/O。在Linux的缓存I/O机制中，操作系统会将I/O的数据缓存在文件系统的页缓存中，即数据会先被拷贝到操作系统内核的缓冲区中，然后才会从操作系统内核的缓冲区拷贝到应用程序的地址空间。

#### multiplexer
多路转换器是硬件机制。

multiplexer，MUX  多路转换器，多路复用器将来自若干单独分信道的独立信号复合起来，在一公共信道的同一方向上进行传输的设备。

demultiplexer，deMUX  解复用，多路输出选择器恢复复用信号中的合成信号，并将这些信号在各自独立的信道中还原的设备。
### IO multiplexer
基于复用器原理，多路IO复用。
类似 `sig_mux = (sig[0] >0) | (sig[1]>0) |... | (sig[n]>0)`


#### select
select 基于NIO，select 相当于内核代理，可以返回任意一个完成的结果。
也就是，让 select 共享了 上层的多个连接的等待阶段。

使用select以后最大的优势是用户可以在一个线程内同时处理多个socket的IO请求

而在同步阻塞模型中，必须通过多线程的方式才能达到这个目的。

select主要缺陷是，对单个进程打开的文件描述是有一定限制的，它由FD_SETSIZE设置，默认值是1024，虽然可以通过编译内核改变，但相对麻烦，另外在检查数组中是否有文件描述需要读写时，采用的是线性扫描的方法，即不管这些socket是不是活跃的，我都轮询一遍，所以效率比较低。


``` c
/**
 * 
 * \param maxfdp1** 指定待测试的文件描述字个数，它的值是待测试的最大描述字加1。
 *      fd_set`可以理解为一个集合，这个集合中存放的是文件描述符(file descriptor)，即文件句柄
 * \param readset 读的文件描述符集合 (可以把它设为空指针)
 * \param writeset 写的文件描述符集合  (可以把它设为空指针)
 * \param exceptset 异常条件的文件描述符集合  (可以把它设为空指针)
 * \param  timeout 告知内核等待所指定文件描述符集合中的任何一个就绪可花多少时间。
 *      timeval 结构用于指定这段时间的秒数和微秒数
 * 
 * \return 若有就绪描述符返回其数目，若超时则为0，若出错则为-1
 */
int select(int maxfdp1,fd_set *readset,fd_set *writeset,fd_set *exceptset,const struct timeval *timeout);
```


#### poll
poll本质和select没有区别，但其采用链表存储，解决了select最大连接数存在限制的问题，但其也是采用遍历的方式来判断是否有设备就绪，所以效率比较低，另外一个问题是大量的fd数组在用户空间和内核空间之间来回复制传递，也浪费了不少性能。

``` cpp
enum {
    POLLIN,  // 可读（普通或优先带）
    POLLRDNORM,  // 普通可读
    POLLPRI, // 高优先可读
    POLLOUT, // 可读
    POLLERR,
    POLLHUP,
    POLLNVAL,
};

struct pollfd{
	int fd;			// 文件描述符
	short events;	// 等待的事件
	short revents;	// 实际发生的事件
};

// 监视并等待多个文件描述符的属性变化
int poll(struct pollfd *fds, nfds_t nfds, int timeout);
```

注意：每个结构体的 events 域是由用户来设置，告诉内核我们关注的是什么，而 revents 域是返回时内核设置的，以说明对该描述符发生了什么事件

- nfds：用来指定第一个参数数组元素个数
- timeout：指定等待的毫秒数，无论 I/O 是否准备好，poll() 都会返回.
   - -1 对应永远等待。0 对应立即返回
- 返回值
  - 成功时，poll() 返回结构体中 revents 域不为 0 的文件描述符个数；如果在超时前没有任何事件发生，poll()返回 0；
  - 失败时，poll() 返回 -1，并设置 errno 

### SIGIO
只有unix系统支持
#### epoll

epoll在Linux2.6内核正式提出，是基于事件驱动的I/O方式，相对于select来说，epoll没有描述符个数限制，使用一个文件描述符管理多个描述符，将用户关心的文件描述符的事件存放到内核的一个事件表中，这样在用户空间和内核空间的copy只需一次。




```c
struct epoll_event {
    __uint32_t events;  /* Epoll events */
    epoll_data_t data;  /* User data variable */
};

typedef union epoll_data {
    void *ptr;
    int fd;
    __uint32_t u32;
    __uint64_t u64;
} epoll_data_t;


/** 创建一个epoll句柄，
 * size 表明内核要监听的描述符数量。
 * 
 * 调用成功时返回一个epoll句柄描述符，失败时返回-1。
 */
int epoll_create(int size);

/** 注册要监听的事件类型。四个参数解释如下：
 * 
 * `epfd` 表示epoll句柄
 * `op`  表示fd操作类型，有如下3种: 新建，修改，删除
 * `fd` 是要监听的描述符
 *  event` 表示要监听的事件
 */
int epoll_ctl(int epfd, int op, int fd, struct epoll_event *event);

/** 等待事件的就绪，
 * 成功时返回就绪的事件数目，调用失败时返回 -1，等待超时返回 0。
 * 
 */
int epoll_wait(int epfd, struct epoll_event * events, int maxevents, int timeout);
```

- `op`  表示fd操作类型，有如下3种
  - EPOLL_CTL_ADD 注册新的fd到epfd中
  - EPOLL_CTL_MOD 修改已注册的fd的监听事件
  - EPOLL_CTL_DEL 从epfd中删除一个fd


epoll和kqueue是更先进的IO复用模型，其也没有最大连接数的限制(1G内存，可以打开约10万左右的连接)，并且仅仅使用一个文件描述符，就可以管理多个文件描述符，并且将用户关系的文件描述符的事件存放到内核的一个事件表中（底层采用的是mmap的方式），这样在用户空间和内核空间的copy只需一次。另外这种模型里面，采用了类似事件驱动的回调机制或者叫通知机制，在注册fd时加入特定的状态，一旦fd就绪就会主动通知内核。这样以来就避免了前面说的无脑遍历socket的方法，这种模式下仅仅是活跃的socket连接才会主动通知内核，所以直接将时间复杂度降为O(1)。

~~select/poll必须遍历所有事件，epoll 支持稀疏选出触发事件~~

epoll除了提供select/poll那种IO事件的水平触发（Level Triggered）外，还提供了边缘触发（Edge Triggered），这就使得用户空间程序有可能缓存IO状态，减少epoll_wait/epoll_pwait的调用，提高应用程序效率。

#### kqueue
mac系统的kqueue
### AIO

异步IO (asynchronous I/O (the POSIX aio_functions))

*nix系统很少有支持的，windows的IOCP是此模型
#### IOCP
windows的IOCP
## misc

IO模型的抽象，总得来说有两种设计模式，分别是Reactor and Proactor模式

## IO


每个外设都是通过读写其寄存器来控制的。外设寄存器也称为I/O端口，通常包括：控制寄存器、状态寄存器和数据寄存器三大类。

根据访问外设寄存器的不同方式，可以把CPU分成两大类。
一类CPU（如M68K，Power PC等）把这些寄存器看作内存的一部分，寄存器参与内存统一编址，访问寄存器就通过访问一般的内存指令进行，所以，这种CPU没有专门用于设备I/O的指令。这就是所谓的“I/O内存”方式。

另一类CPU（典型的如X86），将外设的寄存器看成一个独立的地址空间，所以访问内存的指令不能用来访问这些寄存器，而要为对外设寄存器的读／写设置专用指令，如IN和OUT指令。这就是所谓的“ I/O端口”方式。但是，用于I/O指令的“地址空间”相对来说是很小的，如x86 CPU的I/O空间就只有64KB（0－0xffff）。



1.   CPU是i386架构的情况

 在i386系列的处理中，内存和外部IO是独立编址，也是独立寻址的。MEM的内存空间是32位可以寻址到4G，IO空间是16位可以寻址到64K。

 在Linux内核中，访问外设上的IO Port必须通过IO Port的寻址方式。而访问IO Mem就比较罗嗦，外部MEM不能和主存一样访问，虽然大小上不相上下，可是外部MEM是没有在系统中注册的。访问外部IO MEM必须通过remap映射到内核的MEM空间后才能访问。为了达到接口的同一性，内核提供了IO Port到IO Mem的映射函数。映射后IO Port就可以看作是IO Mem，按照IO Mem的访问方式即可。

3.    CPU是ARM或PPC架构的情况

在这一类的嵌入式处理器中，IO Port的寻址方式是采用内存映射，也就是IO bus就是Mem bus。系统的寻址能力如果是32位，IO Port＋Mem（包括IO Mem）可以达到4G。


- CPU是i386 X86
    - 直接支持 IO Port
    - 需要适配（remap映射）才能 IO Mem
- 嵌入式处理器 ARM, Power PC
    - 直接支持内存映射
    - IO Port的寻址方式是采用内存映射模拟实现, IO bus就是Mem bus


- IO Mem 内存映射
- IO Port\

IO bus
#### request_mem_region
``` cpp
/* request_mem_region分配一个开始于start,len字节的I/O内存区。
 * 
 * start
 * len
 * \return 分配成功，返回一个非NULL指针；否则返回NULL。

 * 系统当前所有I/O内存分配信息都在/proc/iomem文件中列出，你分配失败时，可以看看该文件，看谁先占用了该内存区 
*/
struct resource *request_mem_region(unsigned long start, unsigned long len, char *name);
/* release_mem_region用于释放不再需要的I/O内存区 */
void release_mem_region(unsigned long start, unsigned long len); 
/* check_mem_region用于检查I/O内存区的可用性。同样，该函数不安全，不推荐使用 */
int check_mem_region(unsigned long start, unsigned long len);
```

#### ioremap
根据计算机体系和总线不同，I/O 内存可分为可以或者不可以通过页表来存取。若通过页表存取，内核必须先重新编排物理地址，使其对驱动程序可见，这就意味着在进行任何I/O操作之前，你必须调用ioremap；如果不需要页表，I/O内存区域就类似于I/O端口，你可以直接使用适当的I/O函数读写它们。

- 必须 ioremap
- 无需 ioremap

``` cpp
#include <asm/io.h>
/* ioremap 用于将I/O内存区映射到虚拟地址。
 * 
 * 参数phys_addr为要映射的I/O内存起始地址，
 * 参数size为要映射的I/O内存的大小，
 * 
 * 返回值为被映射到的虚拟地址 
*/
void *ioremap(unsigned long phys_addr, unsigned long size);

/* ioremap_nocache为ioremap的无缓存版本。实际上，在大部分体系中，ioremap与ioremap_nocache的实现一样的，因为所有 I/O 内存都是在无缓存的内存地址空间中 */
void *ioremap_nocache(unsigned long phys_addr, unsigned long size);

/* iounmap用于释放不再需要的映射 */
void iounmap(void * addr);
```

#### 端口位宽
8位、16位和32位端口


#### sysfs方式控制GPIO

通过sysfs方式控制GPIO，先访问/sys/class/gpio目录，向export文件写入GPIO编号，使得该GPIO的操作接口从内核空间暴露到用户空间，GPIO的操作接口包括direction和value等，direction控制GPIO方向，而value可控制GPIO输出或获得GPIO输入。文件IO方式操作GPIO，使用到了4个函数open、close、read、write。


#### export & unexport

#### 设置
direction
设置输出还是输入模式

设置为输入：echo “in” > direction
设置为输出：echo “out” > direction


value
输出时，控制高低电平；输入时，获取高低电平

高电平：echo 1 > value
低电平：echo 0 > value


edge
控制中断触发模式，引脚被配置为中断后可以使用poll() 函数监听引脚

非中断引脚： echo “none” > edge
上升沿触发：echo “rising” > edge
下降沿触发：echo “falling” > edge
边沿触发：echo “both” > edge
