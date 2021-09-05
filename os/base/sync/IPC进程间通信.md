# [IPC 进程间通信](https://www.cnblogs.com/mulisheng/p/4090184.html)



首先，为IPC、RPC、LPC做一个简单总结，后面将分开介绍。

## 一、关于IPC、RPC、LPC之间的关系。

IPC is a set of methods for the exchange of data among multiple threads in one or more processes.

一言以蔽之，理论上来说，所有跨线程的交互都可以叫做IPC通讯。

IPC分为两类：

> LPC：本地过程调用。
> RPC：远程过程调用。

## 二、IPC (Inter-process communication)

| In computing, inter-process communication (IPC) is a set of methods for the exchange of data among multiple threads in one or more processes. Processes may be running on one or more computers connected by a network. IPC methods are divided into methods for message passing, synchronization, shared memory, and remote procedure calls (RPC). The method of IPC used may vary based on the bandwidth and latency of communication between the threads, and the type of data being communicated. |
| ------------------------------------------------------------ |
| 在计算机中，进程间通信（IPC），是用于在一个进程里或多个进程间的多线程之间的数据交换的一系列方法。这些进程可能运行在同一个计算机里或多个通过网络连接起来的不同计算机里。IPC技术分为：消息传递、同步、共享内存、和远程过程调用（RPC）。进程间通信的方法的选择，可能根据线程间通信的带宽和延迟时间、被传递的数据的类型所决定。 |

#### IPC的优缺点：

| 使用IPC的理由                                                | IPC的缺点 |
| ------------------------------------------------------------ | --------- |
| Information sharing（信息共享、内存共享） Computational speedup（计算提速） Modularity（模块化） Convenience（方便） Privilege separation（权限分离） |           |


  IPC may also be referred to as inter-thread communication and inter-application communication.
  IPC 可能也被当做为 线程间通信（ITC ?）和 程序间通信（IAC ?）。

#### 主要的IPC方法：

| 文件（File）                       |      |
| ---------------------------------- | ---- |
| 信号量（Semaphores）               |      |
| 套接字（Sockets）                  |      |
| 消息队列（Message Queues）         |      |
| 管道（Pipes：有名管道、无名管道）  |      |
| 共享内存（Shared Memory）          |      |
| 信号与中断（Interrupts & Signals） |      |
|                                    |      |
|                                    |      |
|                                    |      |

 

## 三、LPC (Local Procedure Call)

 

#  

#  

## 四、RPC (Remote Procedure Call)

#  

| In computer science, a remote procedure call (RPC) is an inter-process communication that allows a computer program to cause a subroutine or procedure to execute in another address space (commonly on another computer on a shared network) without the programmer explicitly coding the details for this remote interaction.That is, the programmer writes essentially the same code whether the subroutine is local to the executing program, or remote. When the software in question uses object-oriented principles, RPC is called remote invocation or remote method invocation. |
| ------------------------------------------------------------ |
| 在计算机科学中，远程过程调用（RPC）是一种IPC方法，它允许一个计算机里的程序去调用运行在另一个地址空间的一个子程序或者一个过程（通常在通过网络连接的另一个计算机上），而程序猿无需关注编写这种远程通信的协议细节。也就是，程序猿可以写相同的代码不管子程序是在本地去运行程序，还是远程的。当设计到的软件使用了面向对象原则时，RPC也叫做远程调用或远程方法调用。 |

##  

#### RPC技术实现：

| An RPC is initiated by the client, which sends a request message to a known remote server to execute a specified procedure with supplied parameters. The remote server sends a response to the client, and the application continues its process. While the server is processing the call, the client is blocked (it waits until the server has finished processing before resuming execution), unless the client sends an asynchronous request to the server, such as an XHTTP call. There are many variations and subtleties in various implementations, resulting in a variety of different (incompatible) RPC protocols. |
| ------------------------------------------------------------ |
| 一个RPC，由客户端初始化，并发送请求消息给远程服务器，要求服务器运行一个指定的过程并使用客户端提供的参数。远程服务器发送回应消息给客户端，并且程序继续运行它的进程。当服务器正在处理调用动作，客户端会被阻塞（等待直到服务器在回复运行前完成处理工作），除非客户端发送异步请求给服务器，例如一个XHTTP形式的调用。在不同的RPC实现中，有各种的差异和细节，最后形成不同的RPC协议。 |
| An important difference between remote procedure calls and local calls is that remote calls can fail because of unpredictable network problems. Also, callers generally must deal with such failures without knowing whether the remote procedure was actually invoked. Idempotent procedures (those that have no additional effects if called more than once) are easily handled, but enough difficulties remain that code to call remote procedures is often confined to carefully written low-level subsystems. |
| RPC和LPC的一个重要区别是，RPC可能会因为不可预测的网络问题而失败。而且，调用者通常必须处理这些失败，尽管不知道远程过程是否被真正执行了。等幂的过程（就算调用多次也没有附加影响），是非常容易处理的，但是较难的地方在于，写代码去调用远程过程经常受限于小心设计的低层次子系统。 |

## 五、IPC 与 RPC 的区别

> 
> RPC 就是一个进程调用另一个进程的过程（function），IPC 就是一个进程向另一个进程传递消息。
> RPC是一种IPC方法，IPC不仅仅包括RPC。
> RPC主要用于客户端请求调用服务端的一个过程（方法），并将结果作为消息返回。

 

| The biggest difference is that IPC can be presented in any form. It can be in the form of shared memory, it can be in the form of a byte stream, it can be in the form of messages. IPC is some way to send information from one process to another. RPC is specifically a way for one thread to call a function that will be executed by another thread, typically in another process or even on another machine. RPC is technically a form of IPC. (One way processes can communicate with each other is by having one process call a procedure in another process.) |
| ------------------------------------------------------------ |
| 最大的不同就在于，IPC技术的实现可以使用各种方法。可以使用共享内存、可以使用字节流、可以使用消息。IPC就是一种将消息从一个进程发送到另外一个进程的方法。RPC是一种特殊的方法，用于一个线程去调用运行在另一个线程中的一个方法，典型的是在另一个进程中的方法甚至是另一个计算机中的进程中的方法。RPC是一种IPC技术。（进程间能互相通信的一种方法是通过让一个进程调用另一个进程的过程。） |

 

## 六、RPC协议

#### Sequence of events during an RPC （一个RPC调用过程的事件顺序）

1、The client calls the client stub. The call is a local procedure call, with parameters pushed on to the stack in the normal way.

客户端调用客户端桩Stub。这个调用是LPC本地过程调用，并使用正常的方法把参数推到栈里面。

2、The client stub packs the parameters into a message and makes a system call to send the message. Packing the parameters is called marshalling.

客户端桩打包参数到一个消息里面，并且使用一个系统调用来传递该消息。打包参数被称为分装处理。

3、The client's local operating system sends the message from the client machine to the server machine.

客户端的操作系统将该消息从客户端机器发送到服务端机器。

4、The local operating system on the server machine passes the incoming packets to the server stub.

服务端机器的操作系统将发进来的包传给服务端的桩Stub。

5、The server stub unpacks the parameters from the message. Unpacking the parameters is called unmarshalling.

服务端Stub从消息中将参数解包。解包参数被称为解包处理。

6、Finally, the server stub calls the server procedure. The reply traces the same steps in the reverse direction.

最后，服务器Stub调用服务端的过程。回复过程按照相反的步骤进行。

#### Remote Procedure Call Protocol（远程过程调用协议）

它是一种通过网络从远程计算机程序上请求服务，而不需要了解底层网络技术的协议。主要用于分布式系统。

RPC是Client/Server模型。

## 七、口水

本文写得比较简单，因为有些地方自己也没有了解得很深入。算是一个坑，慢慢填。

另外，本文大部分内容来自英文维基百科，翻译水平一般，难免有误，欢迎指正，谢谢。  坑~

再挖个坑：

[![IR7(A\]7JU2X(]$PFV4WY$8M](https://images0.cnblogs.com/blog/507520/201411/111758560229633.png)](https://images0.cnblogs.com/blog/507520/201411/111758550224461.png)
