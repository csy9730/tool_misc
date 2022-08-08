# ITC



## ITC


线程间通信，
- 共享存储 + 同步机制
	- 全局变量，配合上同步机制（加锁）。
    	- java中，volatile 作为同步机制
    	- mutex lock 作为同步机制
	- 共享内存，配合上同步机制(mutex lock)
- 管道
    - Java提供了四个类来实现管道，分别是PipedReader、PipedWriter、PipedInputStream和PipedOutputStream
    - Java提供了BlockingQueue
- 信号槽（QT框架提供的机制）
	- 同线程，直接调用
	- 跨线程，进入槽队列
- Java线程协作切换
    - wait() & notify()
    - join()
    - await()、signal()、signalAll()
- 使用消息实现通信
    - 在Windows程序设计中，每一个线程都可以拥有自己的消息队列（UI线程默认自带消息队列和消息循环，工作线程需要手动实现消息循环），因此可以采用消息进行线程间通信

## IPC
进程间通信，才需要使用IPC手段，例如queue。
