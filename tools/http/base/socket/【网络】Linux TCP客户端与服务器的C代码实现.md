# 【网络】Linux TCP客户端与服务器的C代码实现

[![Boots](https://picx.zhimg.com/v2-3c3e176bb0a84080369901c9d7d27f57_l.jpg?source=172ae18b)](https://www.zhihu.com/people/liu-guo-4)

[Boots](https://www.zhihu.com/people/liu-guo-4)

凡事都有一个度

8 人赞同了该文章



在计算机网络的编程中，OSI参考模型中规定了各层的定义与功能。针对于其中的网络层，传输层，以及应用层这三层，整体称之为网络协议栈，常见有PC平台的TCP/IP，嵌入式平台的lwIP，CycloneTCP等。

关于数据链路层和物理层，这是硬件层面的协议，由网卡和MAC/LLC去实现。

本文中的TCP server 和 client，为基于软件层面(TCP/IP协议栈)的Socket应用开发。

**1 Socket**

套接字（socket）是一个抽象层，应用程序可以通过它发送或接收数据，可对其进行像对文件一样的打开、读写和关闭等操作。套接字允许应用程序将I/O插入到网络中，并与网络中的其他应用程序进行通信。网络套接字是IP地址与端口的组合。

数据结构：注意sockaddr_in 和 sockaddr的区别(**前者具体，后者抽象**)

```c
#ifdef CONFIG_NET_IPv6
struct sockaddr_storage
{
  sa_family_t ss_family;       /* Address family */
  char        ss_data[18];     /* 18-bytes of address data */
};
#else
struct sockaddr_storage
{
  sa_family_t ss_family;       /* Address family */
  char        ss_data[14];     /* 14-bytes of address data */
};
#endif

/* The sockaddr structure is used to define a socket address which is used
 * in the bind(), connect(), getpeername(), getsockname(), recvfrom(), and
 * sendto() functions.
 */

//抽象的socket地址，不区分IPV4，IPV6
//14字节 = 2(端口) + 4(ip地址) + 8(保留)
struct sockaddr
{
  sa_family_t sa_family;       /* Address family: See AF_* definitions */
  char        sa_data[14];     /* 14-bytes of address data */
};

//IPV4协议，将 2(端口) + 4(ip地址)分开表示
struct sockaddr_in
{
  sa_family_t     sin_family;  /* Address family: AF_INET */
  uint16_t        sin_port;    /* Port in network byte order */
  struct in_addr  sin_addr;    /* Internet address */
};

//IPV6
struct sockaddr_in6
{
  sa_family_t     sin6_family; /* Address family: AF_INET6 */
  uint16_t        sin6_port;   /* Port in network byte order */
  struct in6_addr sin6_addr;   /* IPv6 internet address */
};
```

函数接口：

```c
int socket(int domain, int type, int protocol);
int bind(int sockfd, FAR const struct sockaddr *addr, socklen_t addrlen);
int connect(int sockfd, FAR const struct sockaddr *addr, socklen_t addrlen);

int listen(int sockfd, int backlog);
int accept(int sockfd, struct sockaddr *addr, socklen_t *addrlen);

ssize_t send(int sockfd, FAR const void *buf, size_t len, int flags);
ssize_t sendto(int sockfd, FAR const void *buf, size_t len, int flags,
               FAR const struct sockaddr *to, socklen_t tolen);

ssize_t recv(int sockfd, FAR void *buf, size_t len, int flags);
ssize_t recvfrom(int sockfd, FAR void *buf, size_t len, int flags,
                 FAR struct sockaddr *from, FAR socklen_t *fromlen);
```

**2 TCP 与 UDP**

TCP（Transmission Control Protocol，传输控制协议**）**是面向连接的，基于数据流的可靠协议，在正式通信之前必须建立起连接。UDP（User Data Protocol，用户数据报协议）是一个非连接的数据报协议。TCP的服务器模式比UDP的服务器模式多了listen，accept函数。TCP客户端比UDP客户端多了connect函数。

这里只谈TCP的客户端与服务器。



**3 TCP server**

TCP server的实现流程：

1、创建一个socket，用函数socket()；

2、绑定IP地址、端口等信息到socket上，用函数bind();

3、开启监听，用函数listen()；

4、接收客户端上来的连接，用函数accept()；

5、收发数据，用函数send()和recv()，或者read()和write();

6、关闭网络连接；

```c
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <netinet/in.h>

#define SERVPORT 4444
#define BACKLOG 10
#define MAXDATASIZE 15

int main() {
    struct sockaddr_in server_sockaddr;//声明服务器socket存储结构
    int sin_size,recvbytes;
    int sockfd,client_fd;//socket描述符
    char buf[MAXDATASIZE];//传输的数据

    //1.建立socket
    //AF_INET 表示IPV4
    //SOCK_STREAM 表示TCP
    if((sockfd = socket(AF_INET,SOCK_STREAM,0)) < 0) {
        perror("Socket");
        exit(1);
    }

    printf("Socket successful!,sockfd=%d\n",sockfd);

    //以sockaddt_in结构体填充socket信息
    server_sockaddr.sin_family 		= AF_INET;//IPv4
    server_sockaddr.sin_port 		= htons(SERVPORT);//端口
    server_sockaddr.sin_addr.s_addr 	= INADDR_ANY;//本主机的任意IP都可以使用
    bzero(&(server_sockaddr.sin_zero),8);//保留的8字节置零

    //2.绑定 fd与 端口和地址
    if((bind(sockfd,(struct sockaddr *)&server_sockaddr,sizeof(struct sockaddr))) < 0) {
        perror("bind");
        exit(-1);
    }

    printf("bind successful !\n");

    //3.监听
    if(listen(sockfd,BACKLOG) < 0) {
        perror("listen");
        exit(1);
    }

    printf("listening ... \n");

    while(1){
	//4.接收请求,函数在有客户端连接时返回一个客户端socket fd,否则则阻塞
	//优化：这里同样可以使用select,以及poll来实现异步通信
	if((client_fd = accept(sockfd,NULL,&sin_size)) == -1) {
		perror("accept");
		exit(1);
	}

	printf("accept success! client_fd:%d\n",client_fd);

	//5.接收数据
        //注意：这里传入的fd，不是建立的socket fd，而是accept返回的连接客户端 socket fd
	if((recvbytes = recv(client_fd,buf,MAXDATASIZE,0)) == -1) {
		perror("recv");
		exit(1);
	}

	printf("received data : %s\n",buf);
    }

    //6.关闭
    close(sockfd);

}
```

**4 TCP client**

TCP client的实现流程：

1、创建一个socket，用函数socket()；

2、连接服务器，用函数connect()；

3、收发数据，用函数send()和recv()，或者read()和write();

4、关闭网络连接；

```c
#include <sys/types.h>
#include <sys/socket.h>
#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <string.h>
#include <netdb.h>
#include <netinet/in.h>

#define SERVPORT 4444
 
int main(int argc,char *argv[]) {
    int sockfd,sendbytes;
    struct sockaddr_in serv_addr;//需要连接的服务器地址信息

    //1.创建socket
    //AF_INET 表示IPV4
    //SOCK_STREAM 表示TCP
    if((sockfd = socket(AF_INET,SOCK_STREAM,0)) < 0) {
        perror("socket");
        exit(1);
    }

    //填充服务器地址信息
    serv_addr.sin_family 	= AF_INET; //网络层的IP协议: IPV4
    serv_addr.sin_port 		= htons(SERVPORT); //传输层的端口号
    serv_addr.sin_addr.s_addr   = inet_addr("192.168.1.xxx"); //网络层的IP地址: 实际的服务器IP地址
    bzero(&(serv_addr.sin_zero),8); //保留的8字节置零

    //2.发起对服务器的连接信息
    //三次握手,需要将sockaddr_in类型的数据结构强制转换为sockaddr
    if((connect(sockfd,(struct sockaddr *)&serv_addr,sizeof(struct sockaddr))) < 0) {
        perror("connect failed!");
        exit(1);
    }

    printf("connect successful! \n");

    //3.发送消息给服务器端
    if((sendbytes = send(sockfd,"hello",5,0)) < 0) {
        perror("send");
        exit(1);
    }

    printf("send successful! %d \n",sendbytes);

    //4.关闭
    close(sockfd);

}
```

**5 测试**

1、使用gcc 分别编译源文件(gcc -o 可直接输出可执行文件)

![img](https://pic2.zhimg.com/80/v2-f0f6f8269b0219ab2b346ff5d7e1da89_720w.webp)

![img](https://pic3.zhimg.com/80/v2-d91aefdbb2951c2a07ed622f7da96f6a_720w.webp)

2、运行server

![img](https://pic4.zhimg.com/80/v2-26d1034d83f595b6bb9d5c34acb07a93_720w.webp)

3、3次运行client

![img](https://pic2.zhimg.com/80/v2-c5a7f9d8dc40a00feb591d7d784a9491_720w.webp)

![img](https://pic1.zhimg.com/80/v2-b78e6766b3e01eb7b7044c25a48f8ae4_720w.webp)

**6 总结**

**本文只实现了客户端的单向发送功能，没有实现接收功能。另外服务端也只对单个连接进行处理，但是，服务器应该具备高并发，处理大量socket连接的能力。一般可通过多线程以及I/O复用(select，poll，epoll)的方法来实现高并发。**



编辑于 2019-12-14 00:01

[TCP](https://www.zhihu.com/topic/19614026)

[TCP/IP](https://www.zhihu.com/topic/19614019)

[Socket](https://www.zhihu.com/topic/19604051)