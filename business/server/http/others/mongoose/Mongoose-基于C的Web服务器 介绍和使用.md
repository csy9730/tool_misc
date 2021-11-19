# Mongoose-基于C的Web服务器 介绍和使用

![img](https://upload.jianshu.io/users/upload_avatars/171439/eec81a120e64.jpeg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[业翔](https://www.jianshu.com/u/66c902dc074b)关注

0.122019.11.06 17:25:02字数 1,631阅读 5,031

## 前言

由于最近想要使用scheme需要做一个web服务器，从socket开始花费的时间很多，所以就选用一款基于C的web类库，然后用scheme包装它。
我打算选择Mongoose，这篇文章就记录Mongoose的要点。（注意，此Mongoose并非Nodejs中的）

## 简单说明

Mongoose是一个用C语言编写的网络库，它是一把用于嵌入式网络编程的瑞士军刀。它为TCP、UDP、HTTP、WebSocket、CoAP、MQTT实现了事件驱动的非阻塞API，用于客户机和服务器模式功能包括：
跨平台：适用于linux/unix、macos、qnx、ecos、windows、android、iphone、freertos。
自然支持PicoTCP嵌入式TCP/IP堆栈，LWIP嵌入式TCP/IP堆栈。
适用于各种嵌入式板：ti cc3200、ti msp430、stm32、esp8266；适用于所有基于linux的板，如Raspberry PI, BeagleBone等。
单线程、异步、无阻塞核心，具有简单的基于事件的api。

内置协议：
普通TCP、普通UDP、SSL/TLS（单向或双向）、客户端和服务器。
http客户端和服务器。
WebSocket客户端和服务器。
MQTT客户机和服务器。
CoAP客户端和服务器。
DNS客户端和服务器。
异步DNS解析程序。

Mongoose只需微小的静态和运行时占用空间，源代码既兼容ISOC又兼容ISO C++，而且很容易集成。

## 设计理念

Mongoose有三种基本数据结构：
struct mg_mgr是保存所有活动连接的事件管理器；
struct mg_connection描述连接；
struct mbuf描述数据缓冲区（接收或发送的数据）；

connetions可以是listening, outbound 和 inbound。outbound连接由mg_connect()调用创建的。listening连接由mg_bind()调用创建的。inbound连接是侦听连接接受的连接。每个connetion都由struct mg_connection结构描述，该结构有许多字段，如socket、事件处理函数、发送/接收缓冲区、标志等。
使用Mongoose的应用程序应遵循事件驱动应用程序的标准模式：

1. 定义和初始化事件管理器：

```cpp
struct mg_mgr mgr;
 mg_mgr_init(&mgr, NULL);
```

1. 创建连接。例如，一个服务程序需要创建监听连接。

```rust
struct mg_connection *c = mg_bind(&mgr, "80", ev_handler_function);
mg_set_protocol_http_websocket(c);
```

1. 在一个循环里使用calling mg_mgr_poll()创建一个事件循环。

```undefined
 for (;;) {
   mg_mgr_poll(&mgr, 1000);
 }
```

`mg_mgr_poll()` 遍历所有socket,接受新连接，发送和接受数据，关闭连接并调用事件处理函数。

## 内存缓存

每个连接都有一个发送和接收缓存。分别是`struct mg_connection::send_mbuf` 和 `struct mg_connection::recv_mbuf` 。当数据接收后，Mongoose将接收到的数据加到`recv_mbuf`后面，并触发一个`MG_EV_RECV`事件。用户可以使用其中一个输出函数将数据发送回去，如`mg_send()` 或 `mg_printf()`。输出函数将数据追加到`send_mbuf`。当Mongoose成功地将数据写到socket后，它将丢弃`struct mg_connection::send_mbuf`里的数据，并发送一个`MG_EV_SEND`事件。当连接关闭后，发送一个`MG_EV_CLOSE`事件。

## 事件处理函数

每个连接都有一个与之关联的事件处理函数。这些函数必须由用户实现。事件处理器是Mongoose程序的核心元素，因为它定义程序的行为。以下是一个处理函数的样子：

```csharp
static void ev_handler(struct mg_connection *nc, int ev, void *ev_data) {
  switch (ev) {
    /* Event handler code that defines behavior of the connection */
    ...
  }
}
```

- `struct mg_connection *nc` : 接收事件的连接。
- `int ev` : 时间编号，定义在`mongoose.h`。比如说，当数据来自于一个`inbound`连接，ev就是`MG_EV_RECV`。
- `void *ev_data` : 这个指针指向event-specific事件，并且对不同的事件有不同的意义。举例说，对于一个`MG_EV_RECV`事件，`ev_data`是一个`int *`指针，指向从远程另一端接收并保存到接收IO缓冲区中的字节数。`ev_data`确切描述每个事件的意义。Protocol-specific事件通常有`ev_data`指向保存protocol-specific信息的结构体。

注意：`struct mg_connection`有`void *user_data`，他是application-specific的占位符。Mongoose并没有使用这个指针。事件处理器可以保存任意类型的信息。

## 事件

Mongoose接受传入连接、读取和写入数据，并在适当时为每个连接调用指定的事件处理程序。典型的事件顺序是：
对于出站连接：`MG_EV_CONNECT` -> (`MG_EV_RECV`, `MG_EV_SEND`, `MG_EV_POLL` ...) -> `MG_EV_CLOSE`

对于入站连接：`MG_EV_ACCEPT` -> (`MG_EV_RECV`, `MG_EV_SEND`, `MG_EV_POLL` ...) -> `MG_EV_CLOSE`

以下是Mongoose触发的核心事件列表（请注意，除了核心事件之外，每个协议还触发特定于协议的事件）：
`MG_EV_ACCEPT`: 当监听连接接受到一个新的服务器连接时触发。`void *ev_data`是远程端的`union socket_address`。
`MG_EV_CONNECT`: 当`mg_connect()`创建了一个新出站链接时触发，不管成功还是失败。`void *ev_data`是`int *success`。当`success`是0，则连接已经建立，否则包含一个错误码。查看`mg_connect_opt()`函数来查看错误码示例。
`MG_EV_RECV`：心数据接收并追加到`recv_mbuf`结尾时触发。`void *ev_data`是`int *num_received_bytes`。通常，时间处理器应该在`nc->recv_mbuf`检查接收数据，通过调用`mbuf_remove()`丢弃已处理的数据。如果必要，请查看连接标识`nc->flags`(see `struct mg_connection`)，并通过输出函数（如`mg_send()`）写数据到远程端。

警告：Mongoose使用`realloc()`展开接收缓冲区，用户有责任从接收缓冲区的开头丢弃已处理的数据，请注意上面示例中的`mbuf_remove()`调用。

`MG_EV_SEND`: Mongoose已经写数据到远程，并且已经丢弃写入到`mg_connection::send_mbuf`的数据。`void *ev_data`是`int *num_sent_bytes`。

注意：Mongoose输出函数仅追加数据到`mg_connection::send_mbuf`。它们不做任何socket的写入操作。一个真实的IO是通过`mg_mgr_poll()`完成的。一个`MG_EV_SEND`事件仅仅是一个关于IO完成的通知。

`MG_EV_POLL`：在每次调用`mg_mgr_poll()`时发送到所有连接。该事件被用于做任何事情，例如，检查某个超时是否已过期并关闭连接或发送心跳消息等。

`MG_EV_TIMER`: 当`mg_set_timer()`调用后，发送到连接。

## TCP服务器示例

```cpp
#include "mongoose.h"  // Include Mongoose API definitions

// Define an event handler function
static void ev_handler(struct mg_connection *nc, int ev, void *ev_data) {
  struct mbuf *io = &nc->recv_mbuf;

  switch (ev) {
    case MG_EV_RECV:
      // This event handler implements simple TCP echo server
      mg_send(nc, io->buf, io->len);  // Echo received data back
      mbuf_remove(io, io->len);      // Discard data from recv buffer
      break;
    default:
      break;
  }
}

int main(void) {
  struct mg_mgr mgr;

  mg_mgr_init(&mgr, NULL);  // Initialize event manager object

  // Note that many connections can be added to a single event manager
  // Connections can be created at any point, e.g. in event handler function
  mg_bind(&mgr, "1234", ev_handler);  // Create listening connection and add it to the event manager

  for (;;) {  // Start infinite event loop
    mg_mgr_poll(&mgr, 1000);
  }

  mg_mgr_free(&mgr);
  return 0;
}
```





1人点赞



技术