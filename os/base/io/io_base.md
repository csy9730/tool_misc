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
### NonBlocking IO.
### IO multiplexer
#### multiplexer
多路转换器是硬件机制。

multiplexer，MUX  多路转换器，多路复用器将来自若干单独分信道的独立信号复合起来，在一公共信道的同一方向上进行传输的设备。

demultiplexer，deMUX  解复用，多路输出选择器恢复复用信号中的合成信号，并将这些信号在各自独立的信道中还原的设备。

#### select
select 基于NIO，select 相当于内核代理，可以返回任意一个完成的结果。
也就是，让 select 共享了 上层的多个连接的等待阶段。

使用select以后最大的优势是用户可以在一个线程内同时处理多个socket的IO请求

而在同步阻塞模型中，必须通过多线程的方式才能达到这个目的。

select主要缺陷是，对单个进程打开的文件描述是有一定限制的，它由FD_SETSIZE设置，默认值是1024，虽然可以通过编译内核改变，但相对麻烦，另外在检查数组中是否有文件描述需要读写时，采用的是线性扫描的方法，即不管这些socket是不是活跃的，我都轮询一遍，所以效率比较低。
#### poll
poll本质和select没有区别，但其采用链表存储，解决了select最大连接数存在限制的问题，但其也是采用遍历的方式来判断是否有设备就绪，所以效率比较低，另外一个问题是大量的fd数组在用户空间和内核空间之间来回复制传递，也浪费了不少性能。
### SIGIO
只有unix系统支持
#### epoll

epoll在Linux2.6内核正式提出，是基于事件驱动的I/O方式，相对于select来说，epoll没有描述符个数限制，使用一个文件描述符管理多个描述符，将用户关心的文件描述符的事件存放到内核的一个事件表中，这样在用户空间和内核空间的copy只需一次。


epoll和kqueue是更先进的IO复用模型，其也没有最大连接数的限制(1G内存，可以打开约10万左右的连接)，并且仅仅使用一个文件描述符，就可以管理多个文件描述符，并且将用户关系的文件描述符的事件存放到内核的一个事件表中（底层采用的是mmap的方式），这样在用户空间和内核空间的copy只需一次。另外这种模型里面，采用了类似事件驱动的回调机制或者叫通知机制，在注册fd时加入特定的状态，一旦fd就绪就会主动通知内核。这样以来就避免了前面说的无脑遍历socket的方法，这种模式下仅仅是活跃的socket连接才会主动通知内核，所以直接将时间复杂度降为O(1)。

#### kqueue
mac系统的kqueue
### AIO

异步IO (asynchronous I/O (the POSIX aio_functions))

*nix系统很少有支持的，windows的IOCP是此模型
#### IOCP

## misc

IO模型的抽象，总得来说有两种设计模式，分别是Reactor and Proactor模式