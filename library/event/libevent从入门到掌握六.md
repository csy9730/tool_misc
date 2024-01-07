# libevent从入门到掌握<六>

[![飞翔的猪](https://pica.zhimg.com/v2-c26f0c4c2483888c45d1ccb03e2dbf70_l.jpg?source=32738c0c)](https://www.zhihu.com/people/zhuang-zhuang-48-52)

[飞翔的猪](https://www.zhihu.com/people/zhuang-zhuang-48-52)

微信公众号: 后台服务器开发，一个在互联网摸爬滚打的攻城狮。

3 人赞同了该文章



libevent从入门到掌握<六>

一、前言

在libevent中，封装了http模块，包括很多相关的接口，主要记录一下简单的http使用方法和接口源码内容；



创建http方式有很多种，这里只是一种简单的方式，仅供参考；



http程序创建步骤：



> 1、初始化event模块
>
> 2、启动http服务端
>
> 3、设置事件处理函数
>
> 4、监听事件



------



二、接口说明

1、 event_init()



不做过多说名，前面文章中有介绍和说明；





2、evhttp_start()



```cpp
/*
 * Start a web server on the specified address and port.
 */

struct evhttp *
evhttp_start(const char *address, ev_uint16_t port)
{
struct evhttp *http = NULL;
//初始化结构体evhttp
http = evhttp_new_object();
if (http == NULL)
return (NULL);
//绑定监听地址和端口
if (evhttp_bind_socket(http, address, port) == -1) {
mm_free(http);
return (NULL);
}

return (http);
}
```



初始化中调用了evhttp_new_object()函数：



```cpp
static struct evhttp*
evhttp_new_object(void)
{
struct evhttp *http = NULL;
//申请内存
if ((http = mm_calloc(1, sizeof(struct evhttp))) == NULL) {
event_warn("%s: calloc", __func__);
return (NULL);
}
//清空时间延时
evutil_timerclear(&http->timeout_read);
evutil_timerclear(&http->timeout_write);
//设置包头和包体的最大值
evhttp_set_max_headers_size(http, EV_SIZE_MAX);
evhttp_set_max_body_size(http, EV_SIZE_MAX);
evhttp_set_default_content_type(http, "text/html; charset=ISO-8859-1");
//设置支持的操作类型
evhttp_set_allowed_methods(http,
    EVHTTP_REQ_GET |
    EVHTTP_REQ_POST |
    EVHTTP_REQ_HEAD |
    EVHTTP_REQ_PUT |
    EVHTTP_REQ_DELETE);

TAILQ_INIT(&http->sockets);
TAILQ_INIT(&http->callbacks);
TAILQ_INIT(&http->connections);
TAILQ_INIT(&http->virtualhosts);
TAILQ_INIT(&http->aliases);

return (http);
}

struct evhttp *
evhttp_new(struct event_base *base)
{
struct evhttp *http = NULL;

http = evhttp_new_object();
if (http == NULL)
return (NULL);
http->base = base;

return (http);
}

/*
 * Start a web server on the specified address and port.
 */

struct evhttp *
evhttp_start(const char *address, ev_uint16_t port)
{
struct evhttp *http = NULL;
//初始化结构体evhttp
http = evhttp_new_object();
if (http == NULL)
return (NULL);
//绑定监听地址和端口
if (evhttp_bind_socket(http, address, port) == -1) {
mm_free(http);
return (NULL);
}

return (http);
}
```



开启服务中，最后一步是绑定和监听IP和端口：

``` cpp
int
evhttp_bind_socket(struct evhttp *http, const char *address, ev_uint16_t port)
{
//什么也没做，直接调用了evhttp_bind_socket_with_handle()函数
struct evhttp_bound_socket *bound =
evhttp_bind_socket_with_handle(http, address, port);
if (bound == NULL)
return (-1);
return (0);
}

struct evhttp_bound_socket *
evhttp_bind_socket_with_handle(struct evhttp *http, const char *address, ev_uint16_t port)
{
evutil_socket_t fd;
struct evhttp_bound_socket *bound;
int serrno;
//申请socket,bind,绑定端口
if ((fd = bind_socket(address, port, 1 /*reuse*/)) == -1)
return (NULL);

if (listen(fd, 128) == -1) {
serrno = EVUTIL_SOCKET_ERROR();
event_sock_warn(fd, "%s: listen", __func__);
evutil_closesocket(fd);
EVUTIL_SET_SOCKET_ERROR(serrno);
return (NULL);
}
//accept 处理
bound = evhttp_accept_socket_with_handle(http, fd);

if (bound != NULL) {
event_debug(("Bound to port %d - Awaiting connections ... ",
port));
return (bound);
}

return (NULL);
}
```



------

3、evhttp_set_timeout()



```cpp
void
evhttp_set_timeout(struct evhttp* http, int timeout)
{
//设置读超时
evhttp_set_timeout_(&http->timeout_read,  timeout, -1);
//设置写超时
evhttp_set_timeout_(&http->timeout_write, timeout, -1);
}
```



------

4、evhttp_set_cb()



```cpp
int
evhttp_set_cb(struct evhttp *http, const char *uri,
    void (*cb)(struct evhttp_request *, void *), void *cbarg)
{
struct evhttp_cb *http_cb;

TAILQ_FOREACH(http_cb, &http->callbacks, next) {
if (strcmp(http_cb->what, uri) == 0)
return (-1);
}
//申请内存
if ((http_cb = mm_calloc(1, sizeof(struct evhttp_cb))) == NULL) {
event_warn("%s: calloc", __func__);
return (-2);
}

http_cb->what = mm_strdup(uri);
if (http_cb->what == NULL) {
event_warn("%s: strdup", __func__);
mm_free(http_cb);
return (-3);
}
http_cb->cb = cb;
http_cb->cbarg = cbarg;
//插入事件列表中
TAILQ_INSERT_TAIL(&http->callbacks, http_cb, next);

return (0);
}
```



------



5、event_dispatch()



```c
int
event_dispatch(void)
{
//调用event_loop
return (event_loop(0));
}

int
event_loop(int flags)
{
//调用event_base_loop
return event_base_loop(current_base, flags);
}
```



参考之前的文章event_base_loop(),循环检测事件的发生；



------



三、简单案例

```c
#include <stdio.h>
#include <stdlib.h>
#include <evhttp.h>
#include <event.h>
#include <string.h>
#include "event2/http.h"
#include "event2/event.h"
#include "event2/buffer.h"
#include "event2/bufferevent.h"
#include "event2/bufferevent_compat.h"
#include "event2/http_struct.h"
#include "event2/http_compat.h"
#include "event2/util.h"
#include "event2/listener.h"


void Test_Get(struct evhttp_request *req,void *arg)
{
{
//解析头，进行处理
//这里只做了回复
}
struct evbuffer* retbuff = evbuffer_new();
if(NULL == retbuff)
{
printf("retbuff is NULL\n");
return ;
}
evbuffer_add_printf(retbuff,"Test_Get is OK!");
evhttp_send_reply(req,HTTP_OK,"Client is OK",retbuff);
evbuffer_free(retbuff);
}
void Test_Post(struct evhttp_request *req,void *arg)
{
{
//获取数据，然后进行处理
//evbuffer_pullup()获取数据接口
}
//只做回复
struct evbuffer* retbuff = evbuffer_new();
if(NULL == retbuff)
{
printf("retbuff is NULL\n");
return ;
}
evbuffer_add_printf(retbuff,"Test_post is OK!");
evhttp_send_reply(req,HTTP_OK,"Client is OK",retbuff);
evbuffer_free(retbuff);
}

int main()
{
    short http_port = 8081;
    char *http_addr = "127.0.0.1";

    //初始化
    event_init();
    //启动http服务端
    struct evhttp *http_server = evhttp_start(http_addr,http_port);
    if(http_server == NULL)
    {
        printf("====line:%d,%s\n",__LINE__,"http server start failed.");
        return -1;
    }

    //设置请求超时时间(s)
    evhttp_set_timeout(http_server,5);
    //设置事件处理函数，evhttp_set_cb针对每一个事件(请求)注册一个处理函数，
    //区别于evhttp_set_gencb函数，是对所有请求设置一个统一的处理函数
    evhttp_set_cb(http_server,"/hello/post",Test_Post,NULL);
    evhttp_set_cb(http_server,"/hello/get",Test_Get,NULL);

    //循环监听
    event_dispatch();
    evhttp_free(http_server);

    return 0;
}
```



结果：

![img](https://pic2.zhimg.com/80/v2-985d7aef6621d55d69891a2329524389_1440w.webp)

![img](https://pic4.zhimg.com/80/v2-82a7999e3ca97a32370385359d8ecaf7_1440w.webp)









想了解学习更多C++后台服务器方面的知识，请关注：

微信公众号：**C++后台服务器开发**