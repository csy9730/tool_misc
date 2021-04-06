# 各种IO复用模式之select，poll，epoll，kqueue，iocp分析

2018-12-17阅读 2.8K0

### 前言

上篇文章，我们介绍了Java IO框架的演变，其实编程语言的IO实现是依赖于底层的操作系统，如果OS内核不支持，那么语言层面也无能为力。任何一个跨平台的编程语言，一定是能够在不同操作系统之间选择使用最优的IO模型，那么不同平台的io策略都有哪些实现呢？本篇文章我们就来了解一下。

### IO模型回顾

IO从概念上来说，总共有5种：

（1）阻塞IO （blocking I/O）

（2）非阻塞IO （nonblocking I/O）

（3）IO多路复用 （I/O multiplexing (select and poll)）

（4）事件驱动IO （signal driven I/O (SIGIO)）

（5）异步IO (asynchronous I/O (the POSIX aio_functions))

上篇文章也说到，不管文件IO还是网络socket的IO，其读写都需要经过两个阶段：

（1） wait for data（准备数据到内核的缓冲区）

（2） copy data from kernel to user （从缓冲区拷贝到用户空间）

##### 阻塞IO图示：

![img](https://ask.qcloudimg.com/http-save/yehe-1903727/dhpu0yiv5b.jpeg?imageView2/2/w/1620)

##### 非阻塞IO图示：

![img](https://ask.qcloudimg.com/http-save/yehe-1903727/njy7vaoz9d.jpeg?imageView2/2/w/1620)

##### 多路复用IO图示：

![img](https://ask.qcloudimg.com/http-save/yehe-1903727/xio0k1b097.jpeg?imageView2/2/w/1620)

##### 事件驱动IO图示：

只有unix系统支持

![img](https://ask.qcloudimg.com/http-save/yehe-1903727/74gwjnk6g7.jpeg?imageView2/2/w/1620)

##### 异步IO图示：

*nix系统很少有支持的，windows的IOCP是此模型

![img](https://ask.qcloudimg.com/http-save/yehe-1903727/d6jjpijsh3.jpeg?imageView2/2/w/1620)

### 五种模型对比

![img](https://ask.qcloudimg.com/http-save/yehe-1903727/s6ary12z8d.jpeg?imageView2/2/w/1620)

从左向右，可以看到用户线程的阻塞是越来越少的，理论上说阻塞越少，其执行效率就越高。

下面我们来看下select，poll，epoll，kqueue，iocp分别属于那种模型：

select，poll属于第三种IO复用模型，iocp属于第5种异步io模型，那么epoll和kqueue呢？

其实与select和poll一样，都属于第三种模型，只是更高级一些，可以看做拥有了第四种模型的某些特性，比如callback的回调机制。

那么epoll，kqueue为什么比select和poll高级呢？ 下面我们来分析一下：

首先他们都属于IO复用模型，I/O多路复用模型就是通过一种机制，一个进程可以监视多个描述符，一旦某个描述符就绪（一般是读就绪或者写就绪），能够通知程序进行相应的读写操作。

select主要缺陷是，对单个进程打开的文件描述是有一定限制的，它由FD_SETSIZE设置，默认值是1024，虽然可以通过编译内核改变，但相对麻烦，另外在检查数组中是否有文件描述需要读写时，采用的是线性扫描的方法，即不管这些socket是不是活跃的，我都轮询一遍，所以效率比较低。

poll本质和select没有区别，但其采用链表存储，解决了select最大连接数存在限制的问题，但其也是采用遍历的方式来判断是否有设备就绪，所以效率比较低，另外一个问题是大量的fd数组在用户空间和内核空间之间来回复制传递，也浪费了不少性能。

epoll和kqueue是更先进的IO复用模型，其也没有最大连接数的限制(1G内存，可以打开约10万左右的连接)，并且仅仅使用一个文件描述符，就可以管理多个文件描述符，并且将用户关系的文件描述符的事件存放到内核的一个事件表中（底层采用的是mmap的方式），这样在用户空间和内核空间的copy只需一次。另外这种模型里面，采用了类似事件驱动的回调机制或者叫通知机制，在注册fd时加入特定的状态，一旦fd就绪就会主动通知内核。这样以来就避免了前面说的无脑遍历socket的方法，这种模式下仅仅是活跃的socket连接才会主动通知内核，所以直接将时间复杂度降为O(1)。

最后来聊聊windows的iocp的异步IO模型，目前很少有支持asynchronous I/O的系统，即使windows上的iocp非常出色，但由于其系统本身的局限性和微软的之前的闭源策略，导致主流市场大部分用的还是unix系统，与mac系统的kqueue和linux系统的epoll相比，iocp做到了真正的纯异步io的概念，即在io操作的第二阶段也不阻塞应用程序，但性能好坏，其实取决于copy数据的大小，如果数据包本来就很小，其实这种优化无足轻重，而kqueue与epoll已经做得很优秀了，所以这可能也是unix或者mac系统至今都没有实现纯异步的io模型主要原因。

### IO设计模式

从上面的几种io机制可以看出来，不同的平台实现的io模型可能都不一样，实际上不管哪一种模型，这中间都可以抽象一层API出来，提供一致的接口，目的是为了更好的支持跨平台编程语言的调用，屏蔽操作系统的差异性。这其中广为人知的有C++的ACE,Libevent这些，他们都是跨平台的，而且他们自动选择最优的I/O复用机制，用户只需调用接口即可。IO模型的抽象，总得来说有两种设计模式，分别是Reactor and Proactor模式，这个我们在下篇文章里面专门讨论，这里不在细说。在Java里面，io版本经历了bio，nio，aio的演变，这个我在上篇文章已经介绍过，其实对应io模型，分别是阻塞io，非阻塞io，异步io，这里需要注意的是异步io仅仅在windows上支持，在linux上还是基于epoll的实现的，并非纯异步。

### 总结

本篇文章结合了io的五种模型，分析了各个主流操作系统的io实现机制并对比了其优缺点，编程语言的io接口，其实是依赖底层的操作系统的实现，为了兼容不同平台的io调用，这里面出现了两种关于高性能io的设计模式，分别是Reactor and Proactor，其都是采用多路复用的思想，来设计抽象IO接口，这个我们在下篇文章会介绍。