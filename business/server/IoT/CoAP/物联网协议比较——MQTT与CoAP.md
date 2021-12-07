# 物联网协议比较——MQTT与CoAP

[![有人物联网](https://pic4.zhimg.com/v2-b5259398e918a9ddeaedf96a60f23530_xs.jpg)](https://www.zhihu.com/people/you-ren-wu-lian-wang-46)

[有人物联网](https://www.zhihu.com/people/you-ren-wu-lian-wang-46)

联网找有人，靠谱



64 人赞同了该文章

之前我们说过，常见的IoT[物联网通信协议](https://www.zhihu.com/search?q=物联网通信协议&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A153431271})中，HTTP和XMPP这两种协议网络开销较大，MQTT和CoAP则更适合物联网受限环境中设备的通信。

MQTT和CoAP是针对小设备最有前景的两种协议。

今天我们来详细区分下这两种协议。

首先，MQTT和CoAP都比HTTP更适合于受限环境，都可以提供[异步传输机制](https://www.zhihu.com/search?q=异步传输机制&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A153431271})，都可以在IP上运行，都是开放标准，且都有很多种实现方式。

MQTT在传输模式上更为灵活，对[二进制](https://www.zhihu.com/search?q=二进制&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A153431271})数据而言就像是管道，CoAP为面向网络的设计。

## **MQTT**

之前我们有简答介绍过，MQTT为轻量M2M通讯设计的一种发布/订阅消息协议，起初由IBM研发，现在是一种开放标准。（详细内容可以到<https://zhuanlan.zhihu.com/p/152195617> 去了解）

从协议架构上来看，MQTT是客户端/服务器模型，其中每一个传感器为一个客户端，通过TCP连接到服务器，这也称为代理。

MQTT以消息为导向，每个消息是具体的一组数据，对代理是透明的。

每个消息发布至一个地址，称为主题。[客户端](https://www.zhihu.com/search?q=客户端&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A153431271})也许会订阅多种主题，订阅某个主题的每一个客户端会收到所有发布到主题的消息。

举个例子说明一下，设想有一个简单的网络，有一个中间代理（TCP连接服务器）和三个客户端（三个传感器）。

三个客户端分别与代理建立TCP连接。其中，客户端B、C订阅温度主题。

稍后，客户端A给温度主题发布了一个值22.5，代理转发消息给所有订阅客户端。

发布/订阅模型允许MQTT客户端以一对一、一对多和多对一方式进行通讯。

**主题匹配**

MQTT中，主题是[层次结构](https://www.zhihu.com/search?q=层次结构&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A153431271})的，像文件系统（例如：kitchen/oven/temperature）。当注册订阅时允许通配符，但不是发布时，允许整个层次结构被客户端观察。

[通配符](https://www.zhihu.com/search?q=通配符&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A153431271})+匹配任意单个目录名称，#匹配任意数量任意名称目录。

例如：主题kitchen/+/temperature可以匹配kitchen/foo/temperature，但是不能匹配kitchen/foo/bar/temperature，而kitchen/# 可以匹配 kitchen/fridge/compressor/valve1/temperature。

**应用级QoS**

支持三种服务质量等级：触发而遗忘、至少传送一次、仅仅传送一次。

**遗愿遗嘱**

MQTT客户端可以注册一个典型的遗愿遗嘱消息，如果它们断开连接，由代理发送。这些消息可以用于向订阅者发出信号，当设备断开连接时。

**持久化**

MQTT支持在代理上存储持久化消息，当发布消息时，客户端也许会要求代理能够持久化消息。只有最近的持久消息才会被存储。当客户端订阅一个主题时，持久化消息会被发送至客户端。

不像[消息队列](https://www.zhihu.com/search?q=消息队列&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A153431271})，MQTT代理不允许持久化消息在服务器内部备用。



**安全**

MQTT代理也许会要求用户名、密码认证，为确保隐私，TCP连接也许会用SSL/TLS加密。

## **CoAP**



CoAP是一种基于REST架构，应用于物联网的[计算机协议](https://www.zhihu.com/search?q=计算机协议&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A153431271})。



**架构**

类似HTTP，CoAP是文本输出协议，但是不像HTTP，CoAP为受限制的设备设计。

CoAP数据包比HTTP TCP流小得多，比特域与从字符串映射到整型广泛运用以节省空间。数据包易于生成，可以原位解析，不用消耗受限制设备内的额外RAM。

CoAP运行在UDP上，而不是TCP。客户端与服务器通过无连接的数据报进行通讯，在应用栈内实现重传与重排序。无需TCP即可使小型微处理器全部IP网络化，CoAP允许使用UDP广播与多播用于地址。

CoAP遵循客户端/服务器模型，客户端向服务器请求，服务器回送响应，客户端可以GET、PUT、POST和DELETE资源。

CoAP用于通过简单代理与HTTP、RESTFUL网络交互。

因为CoAP基于数据报文，也许会用于SMS或者其他基于分组的通讯协议之上。



**应用级QoS**

[请求与响应](https://www.zhihu.com/search?q=请求与响应&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A153431271})也许会被标记为可确认的或者非确认的，可确认的消息必须由接收方通过ACK包进行确认。

非确认的消息是触发而忘记的。



**内容协商**

像HTTP，CoAP支持内容协商，客户端使用Accept选项表达倾向的资源表示，服务器回复Content-Type选项告知客户端它们接收的东西。和HTTP一样，这允许客户端与服务器独立演进，增加新的表达方式，而互不影响。

CoAP请求也许会使用查询字符串形式。如:?a=b&c=d，这些可以用于给客户端提供搜索、分页与其他特性。



**安全**

因为CoAP建立在UDP而不是TCP之上，SSL/TLS不可用于提供安全性。DTLS[数据报传输层](https://www.zhihu.com/search?q=数据报传输层&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A153431271})安全提供了与TLS同样的保证机制，但是针对UDP之上数据传输。通常来说，具备DTLS能力的CoAP设备支持RSA、AES或者ECC、AES。



**观察**

CoAP拓展了HTTP请求模型，有能力观察资源。当观察标记在CoAP GET请求之上设定时，服务器会继续应答在初始文档已经传输过后。这使得服务器能够将状态变化发生时流向客户端。两边一方结束会取消观察。



**资源发现**

CoAP为资源发现定义[标准机制](https://www.zhihu.com/search?q=标准机制&search_source=Entity&hybrid_search_source=Entity&hybrid_search_extra={"sourceType"%3A"article"%2C"sourceId"%3A153431271})，服务端提供资源列表（同时包括相关的元数据）在/.well-known/core。这些链接以应用/链接格式媒介形式，允许客户端发现提供什么样的资源，并且它们是什么媒介形式。

**对比**

MQTT和CoAP作为IoT协议应用都很广泛，但两者也有很大的区别。

MQTT是多对多通讯协议。用于在不同客户端之间通过中间代理传送消息，解耦生产者与消费者，通过使得客户端发布，让代理决定路由并且拷贝消息。

虽然MQTT支持一些持久化，但最好还是作为实时数据通讯总线使用。

CoAP主要是一个点对点协议，用于在客户端与服务器之间传输状态信息。虽然支持观察资源，但CoAP最好适合状态传输模型，不是完全基于事件。

MQTT客户端建立长连接TCP，CoAP客户端与服务器都发送与接收UDP数据包。

MQTT不提供支持消息打类型标记或者其他元数据帮助客户端理解，MQTT消息可用于任何目的，但是所有的客户端必须知道向上的数据格式以允许通讯。

而CoAP协议则恰好相反。它提供内置支持内容协商与发现，允许设备相互探测以找到交换数据的方式。

总之，两种协议各有缺点，应该根据在自己的实际情况选择合适的协议。

发布于 2020-07-02 18:23

MQTT

通信协议

CoAP