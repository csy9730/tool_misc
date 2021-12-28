# netty

[https://netty.io/](https://netty.io/)

## homepage

Netty is *an asynchronous event-driven network application framework*
for rapid development of maintainable high performance protocol servers & clients.

![img](https://netty.io/images/components.png)

Netty is a NIO client server framework which enables quick and easy development of network applications such as protocol servers and clients. It greatly simplifies and streamlines network programming such as TCP and UDP socket server.

'Quick and easy' doesn't mean that a resulting application will suffer from a maintainability or a performance issue. Netty has been designed carefully with the experiences earned from the implementation of a lot of protocols such as FTP, SMTP, HTTP, and various binary and text-based legacy protocols. As a result, Netty has succeeded to find a way to achieve ease of development, performance, stability, and flexibility without a compromise.

## Features

### Design

- Unified API for various transport types - blocking and non-blocking socket
- Based on a flexible and extensible event model which allows clear separation of concerns
- Highly customizable thread model - single thread, one or more thread pools such as SEDA
- True connectionless datagram socket support (since 3.1)

### Ease of use

- Well-documented Javadoc, user guide and examples
- No additional dependencies, JDK 5 (Netty 3.x) or 6 (Netty 4.x) is enough
  - Note: Some components such as HTTP/2 might have more requirements. Please refer to [the Requirements page](https://netty.io/wiki/requirements.html) for more information.

### Performance

- Better throughput, lower latency
- Less resource consumption
- Minimized unnecessary memory copy

### Security

- Complete SSL/TLS and StartTLS support

### Community

- Release early, release often
- The author has been writing similar frameworks since 2003 and he still finds your feed back precious!

------

Copyright © 2021 [The Netty project](https://netty.io/index.html)