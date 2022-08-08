# 看图理解进程间通信IPC

[陈康stozen](https://www.jianshu.com/u/6078656f6748)关注

12017.07.18 10:34:53字数 656阅读 4,494

![img](https://upload-images.jianshu.io/upload_images/5709266-1a6acc8cb9577645.png?imageMogr2/auto-orient/strip|imageView2/2/w/900/format/webp)

## 什么是进程间通讯

**进程间通信(inter-process communication或interprocess communication，简写IPC)是指两个或两个以上进程(或线程)之间进行数据或信号交互的技术方案。**

通常，IPC一般包含客户端和服务器，客户端请求数据，服务器响应请求(比如分布式计算中就是这样)。

## 有哪些IPC方法

### IPC方法适用的环境

![img](https://upload-images.jianshu.io/upload_images/5709266-d543a70327a4de43.png?imageMogr2/auto-orient/strip|imageView2/2/w/802/format/webp)

### 文件(File)

存储在磁盘上的记录，或由文件服务器按需合成的记录，可以由多个进程访问。

![img](https://upload-images.jianshu.io/upload_images/5709266-345a90d5044a49f7.png?imageMogr2/auto-orient/strip|imageView2/2/w/280/format/webp)

### 信号(Signal)

系统消息从一个进程发送到另一个进程，一般不用于传输数据，而是用于远程传输命令。

![img](https://upload-images.jianshu.io/upload_images/5709266-bc52bfc7a89dfee4.png?imageMogr2/auto-orient/strip|imageView2/2/w/790/format/webp)

### 套接字(Socket)

通过网络接口将数据量发送到本机的不同进程或远程计算机。

![img](https://upload-images.jianshu.io/upload_images/5709266-ccc181523c40ec60.png?imageMogr2/auto-orient/strip|imageView2/2/w/390/format/webp)

### Unix域套接字(Unix domain socket)

用于在同一台机器上运行的进程之间的通信。虽然因特网域套接字可用于同一目的，但UNIX域套接字的效率更高。UNIX域套接字仅仅复制数据；它们并不执行协议处理，不需要添加或删除网络报头，无需计算检验和，不要产生顺序号，无需发送确认报文。

![img](https://upload-images.jianshu.io/upload_images/5709266-cc7354cc271845c5.png?imageMogr2/auto-orient/strip|imageView2/2/w/720/format/webp)

### 消息队列(Message queue)

类似于套接字的数据流，但消息有自己的结构，它允许多个进程只需要读写消息队列，而不需要直接相互连接。

![img](https://upload-images.jianshu.io/upload_images/5709266-36b6db62bb6c4a81.png?imageMogr2/auto-orient/strip|imageView2/2/w/623/format/webp)

### 管道(Pipe)

管道是一种半双工的通信方式，数据只能单向流动，而且只能在具有亲缘关系的进程间使用。进程的亲缘关系通常是指父子进程关系。

![img](https://upload-images.jianshu.io/upload_images/5709266-523462cea67e1d73.png?imageMogr2/auto-orient/strip|imageView2/2/w/340/format/webp)

### 命名管道(Named pipe或FIFO)

命名管道可在同一台计算机的不同进程之间或在跨越一个网络的不同计算机的不同进程之间，支持可靠的、单向或双向的数据通信。

![img](https://upload-images.jianshu.io/upload_images/5709266-4eca614f99ac711b.png?imageMogr2/auto-orient/strip|imageView2/2/w/625/format/webp)

### 共享内存(Shared memory)

允许多个进程访问同一个内存块，该内存块作为一个共享缓冲区，供进程间相互通信。

![img](https://upload-images.jianshu.io/upload_images/5709266-29aa3e3d61e30c2a.png?imageMogr2/auto-orient/strip|imageView2/2/w/780/format/webp)

### 消息传递(Message passing)

一般在并发模型中，允许多个程序使用消息队列或者托管通道通信。

![img](https://upload-images.jianshu.io/upload_images/5709266-aed5f7562f4ed162.png?imageMogr2/auto-orient/strip|imageView2/2/w/550/format/webp)

### 内存映射文件(Memory-mapped file)

类似于标准的文件，内存映射文件映射到RAM，可以直接对内存地址进行更改，而不是更改输出流。

![img](https://upload-images.jianshu.io/upload_images/5709266-0c5c38ffb2a1fef2.png?imageMogr2/auto-orient/strip|imageView2/2/w/697/format/webp)



27人点赞



[操作系统原理](https://www.jianshu.com/nb/14484494)