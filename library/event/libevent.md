# libevent



[libevent从入门到掌握<一>](https://zhuanlan.zhihu.com/p/87562010)

- event_base() 初始化event_base
- event_set() 初始化event，绑定回调函数
- event_base_set() 将event绑定到指定的event_base上
- event_add() 将event添加到事件链表上，注册延时事件
- event_base_dispatch()  循环、检测、分发事件



- base event框架的主体结构
- ev   事件，包含对应的回调函数，分为单次事件和恒久事件



- event_add 注册事件，可以单独拉起一个线程来注册事件
- event_base_dispatch 同步阻塞，占用一个线程



## demo

``` cpp
#include <stdio.h>
#include <event.h>
#include <time.h>

struct event ev;
struct timeval tv;

void timer_cb(int fd, short event, void *arg)    //回调函数
{
        printf("timer_cb\n");
        event_add(&ev, &tv);    //重新注册
}

int main()
{
        struct event_base *base = event_init();  //初始化libevent库
        tv.tv_sec = 1;
        tv.tv_usec = 0;

        event_set(&ev, -1, 0, timer_cb, NULL);  //初始化event结构中成员
        event_base_set(base, &ev);
        event_add(&ev, &tv);  //将event添加到events事件链表，注册事件
        event_base_dispatch(base);  //循环、分发事件

        return 0;
}
```