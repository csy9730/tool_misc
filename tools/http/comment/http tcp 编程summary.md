

# http tcp 编程

## overview

- apache httpd
- nginx
- redis
- memcache
- ace
- netty
- muduo
- asio
- libevent
- libuv

### arch

- bio
- reactor NIO(select/epoll)
- proactor AIO

#### flow
- socket open
  - ​	message in (read)
    - callback
  - ​	message out (write & send)
- socket close



- IO线程
- eventLoop 线程
- callback线程？



#### tcp server



TCP server的实现流程：

- 创建一个socket，用函数socket()；

- 绑定IP地址、端口等信息到socket上，用函数bind();

- 开启监听，用函数listen()；
  - 接收客户端上来的连接，用函数accept()；
  - 收发数据，用函数send()和recv()，或者read()和write();

- 关闭网络连接；



### muduo

在本节的开始，先介绍一个比较独立的组件 TimerQueue，该组件还依赖于 Timer 和 TimerId 两个类，这是 muduo 中与定时器有关的类。一个好的服务器程序应该可以处理 IO 事件、定时事件和信号事件 [游双]。其中 IO 事件前面已经提到了，信号事件过于复杂，而且 Linux 信号与多线程水火不容，[2] 中指出多线程程序中，使用 signal 的第一原则就是不要使用 signal，muduo 中的处理是使用了统一事件源 signalfd 直接将信号转换为文件描述符去处理（大概是，没有仔细研究这一部分）。对于定时事件的处理，也存在两个思路，一种是在事件循环之前查找最近一个要超时的定时器的超时时间，将该时间作为 epoll 的超时时间，在 epoll_wait 返回之后，先处理已经超时的定时器，然后再处理 IO 事件。第二种思路，也是 muduo 的思路，使用 Linux 中提供的 timerfd，用处理 IO 事件的方式来处理定时事件，保证一致性。所以在 muduo 中，三类事件用文件描述符进行了统一，在 Channel 类的开始也有注释。



one loop per thread 是 [2] 中频繁提到的设计思想，其主旨就是一个 IO 事件循环和一个线程绑定，一个线程中只能有一个 IO 循环，一个 IO 循环中的事件只能被该线程管理，事件的回调也只能在该线程中执行。具体落实在 muduo 上，就是 EventLoop 和 Thread 一一对应，也就是 EventLoopThread。EventLoopThread 的核心功能就是通过 startLoop() 启动线程，开启 IO 循环。其中最重要的是需要通过条件变量等待 EventLoop 创建成功并开启 loop()，见 code 7 line 10 和 line 28。
