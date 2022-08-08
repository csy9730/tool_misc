# IPC



- 文件 属于非正规的通信方法
- 匿名管道pipe 半双工的 只能用于父子进程或者兄弟进程之间
- 有名管道(FIFO) 
- 信号(Signal)   虽然支持自定义信号，但是颗粒度太细，不适合作为通信方式。 一般不用于传输数据，而是用于远程传输命令
- 消息队列 (Message Queue)
- 套接字 socket
- unix socket
- 共享内存(Shared memory) 直接操作内存，性能最高。
- 内存映射文件(Memory-mapped file)
- 基于socket 的消息队列 (Message Queue)，例如ZeroMQ, redis
