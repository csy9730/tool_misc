# 关于对docker run --link的理解

![img](https://upload.jianshu.io/users/upload_avatars/7391909/366f501c-3e75-4b7b-be8b-38cb5f3fcc25?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[Ivanli1990](https://www.jianshu.com/u/2e8fef801176)关注

72017.09.27 17:05:07字数 1,744阅读 140,665

### 前言

在实践中，自己会遇到2个容器之间互相访问通信的问题，这个时候就用到了docker run --link选项。自己也花了一段时间泡官网研究了--link的用法，把自己对--link的理解分享下。注意！docker官方已不推荐使用docker run --link来链接2个容器互相通信，随后的版本中会删除--link，但了解其原理，对如何使2个容器之间互相通信还是有帮助的。

### 1. docker run --link的作用

docker run --link可以用来链接2个容器，使得源容器（被链接的容器）和接收容器（主动去链接的容器）之间可以互相通信，并且接收容器可以获取源容器的一些数据，如源容器的环境变量。

**--link的格式：**

--link <name or id>:alias

其中，name和id是源容器的name和id，alias是源容器在link下的别名。

eg：

**源容器**

```
docker run -d --name selenium_hub selenium/hub
```

创建并启动名为selenium_hub的容器。



![img](https://upload-images.jianshu.io/upload_images/7391909-7fdf076fc71b5336.png?imageMogr2/auto-orient/strip|imageView2/2/w/1101/format/webp)

selenium_hub容器

**接收容器**

```
docker run -d --name node --link selenium_hub:hub selenium/node-chrome-debug
```

创建并启动名为node的容器，并把该容器和名为selenium_hub的容器链接起来。其中：

--link selenium_hub:hub

selenium_hub是上面启动的1cbbf6f07804容器的名字，这里作为源容器，hub是该容器在link下的别名（alias），通俗易懂的讲，站在node容器的角度，selenium_hub和hub都是1cbbf6f07804容器的名字，并且作为容器的hostname，node用这2个名字中的哪一个都可以访问到1cbbf6f07804容器并与之通信（docker通过DNS自动解析）。我们可以来看下：

进入node容器：

```csharp
docker exec -it node /bin/bash

root@c4cc05d832e0:~# ping selenium_hub
PING hub (172.17.0.2) 56(84) bytes of data.
64 bytes from hub (172.17.0.2): icmp_seq=1 ttl=64 time=0.184 ms
64 bytes from hub (172.17.0.2): icmp_seq=2 ttl=64 time=0.133 ms
64 bytes from hub (172.17.0.2): icmp_seq=3 ttl=64 time=0.216 ms

root@c4cc05d832e0:~# ping hub
PING hub (172.17.0.2) 56(84) bytes of data.
64 bytes from hub (172.17.0.2): icmp_seq=1 ttl=64 time=0.194 ms
64 bytes from hub (172.17.0.2): icmp_seq=2 ttl=64 time=0.218 ms
64 bytes from hub (172.17.0.2): icmp_seq=3 ttl=64 time=0.128 ms
```

可见，selenium_hub和hub都指向172.17.0.2。

### 2. --link下容器间的通信

按照上例的方法就可以成功的将selenium_hub和node容器链接起来，那这2个容器间是怎么通信传送数据的呢？另外，前言中提到的接收容器可以获取源容器的一些信息，比如环境变量，又是怎么一回事呢？

源容器和接收容器之间传递数据是通过以下2种方式：

- 设置环境变量
- 更新/etc/hosts文件

##### 2.1 设置环境变量

1. 当使用--link时，docker会自动在接收容器内创建基于--link参数的环境变量：

docker会在接收容器中设置名为<alias>_NAME的环境变量，该环境变量的值为：
<alias>_NAME=/接收容器名/源容器alias

我们进入node容器，看下此环境变量：

``` bash
docker exec -it node /bin/bash
seluser@c4cc05d832e0:/$ env | grep -i hub_name
HUB_NAME=/node/hub
```

可见，确实有名为HUB_NAME=/node/hub的环境变量存在。

另外，docker还会在接收容器中创建关于源容器暴露的端口号的环境变量，这些环境变量有一个统一的前缀名称：

<name>*PORT*<port>_<protocol>

其中：

<name>表示链接的源容器alias
<port>是源容器暴露的端口号
<protocol>是通信协议：TCP or UDP

docker用上面定义的前缀定义3个环境变量：

<name>*PORT*<port>_<protocol>*ADDR<name>PORT<port>*<protocol>*PORT<name>PORT<port>*<protocol>_PROTO

注意，若源容器暴露了多个端口号，则每1个端口都有上面的一组环境变量（包含3个环境变量），即若源容器暴露了4个端口号，则会有4组12个环境变量。

[查看selenium/hub的Dockerfile](https://link.jianshu.com/?t=https://github.com/SeleniumHQ/docker-selenium/blob/master/Hub/Dockerfile)，可见只暴露了4444端口号：

```
EXPOSE 4444
```

我们进入node容器，看这些此环境变量：

```bash
docker exec -it node /bin/bash
seluser@c4cc05d832e0:/$ env | grep -i HUB_PORT_4444_TCP_
HUB_PORT_4444_TCP_PROTO=tcp
HUB_PORT_4444_TCP_ADDR=172.17.0.2
HUB_PORT_4444_TCP_PORT=4444
```

可见，确实有3个以<name>*PORT*<port>*<protocol>*为前缀的环境变量存在。

另外，docker还在接收容器中创建1个名为<alias>_PORT的环境变量，值为*源容器的URL：源容器暴露的端口号中最小的那个端口号*。

我们进入node容器，看下此环境变量：

```bash
docker exec -it node /bin/bash
seluser@c4cc05d832e0:/$ env | grep -i HUB_PORT=
HUB_PORT=tcp://172.17.0.2:4444
```

可见，此环境变量的确存在。

1. 接收容器还会获取源容器暴露的环境变量，这些变量包括：

- 源容器Dockerfile中ENV标签设置的环境变量
- 源容器用docker run命令创建，命令中包含的 -e或--env或--env-file设置的环境变量

docker会在接收容器中创建一些环境变量，这些环境变量是的值是关于源容器本身的环境变量的值。这些环境变量的定义格式为：

<alias>*ENV*<name>

[查看selenium/hub的Dockerfile](https://link.jianshu.com/?t=https://github.com/SeleniumHQ/docker-selenium/blob/master/Hub/Dockerfile)，可见Dockerfile中ENV标签设置的环境变量有：

```
# As integer, maps to "maxSession"
ENV GRID_MAX_SESSION 5
# In milliseconds, maps to "newSessionWaitTimeout"
ENV GRID_NEW_SESSION_WAIT_TIMEOUT -1
# As a boolean, maps to "throwOnCapabilityNotPresent"
ENV GRID_THROW_ON_CAPABILITY_NOT_PRESENT true
# As an integer
ENV GRID_JETTY_MAX_THREADS -1
# In milliseconds, maps to "cleanUpCycle"
ENV GRID_CLEAN_UP_CYCLE 5000
# In seconds, maps to "browserTimeout"
ENV GRID_BROWSER_TIMEOUT 0
# In seconds, maps to "timeout"
ENV GRID_TIMEOUT 30
# Debug
ENV GRID_DEBUG false
```

我们进入selenium_hub容器，看下这些环境变量：

```
root@ubuntu:~# docker exec -it selenium_hub /bin/bash
seluser@1cbbf6f07804:/$ env | grep -i grid_
GRID_DEBUG=false
GRID_TIMEOUT=30
GRID_CLEAN_UP_CYCLE=5000
GRID_MAX_SESSION=5
GRID_JETTY_MAX_THREADS=-1
GRID_BROWSER_TIMEOUT=0
GRID_THROW_ON_CAPABILITY_NOT_PRESENT=true
GRID_NEW_SESSION_WAIT_TIMEOUT=-1
```

我们再进入node容器，看下node容器中关于selenium_hub的<alias>*ENV*<name>环境变量：

```
docker exec -it node /bin/bash
seluser@c4cc05d832e0:/$ env | grep -i hub_env
HUB_ENV_GRID_DEBUG=false
HUB_ENV_GRID_TIMEOUT=30
HUB_ENV_DEBCONF_NONINTERACTIVE_SEEN=true
HUB_ENV_GRID_CLEAN_UP_CYCLE=5000
HUB_ENV_GRID_MAX_SESSION=5
HUB_ENV_TZ=UTC
HUB_ENV_GRID_JETTY_MAX_THREADS=-1
HUB_ENV_DEBIAN_FRONTEND=noninteractive
HUB_ENV_GRID_BROWSER_TIMEOUT=0
HUB_ENV_GRID_THROW_ON_CAPABILITY_NOT_PRESENT=true
HUB_ENV_GRID_NEW_SESSION_WAIT_TIMEOUT=-1
```

可见，selenium_hub容器中的GRID_* 环境变量均在node容器中被创建，只不过名称变为HUB_ENV_GRID_* 而已。

**环境变量的注意事项**
注意，接收容器环境变量中存储的源容器的IP，不会自动更新，即，若源容器重启，则接收容器环境变量中存储的源容器的IP很可能就失效了。所以，docker官方建议使用/etc/hosts来解决上述的IP失效问题。

##### 2.2 更新/etc/hosts文件

docker会将源容器的host更新到目标容器的/etc/hosts中：
我们再进入node容器，查看node容器中的/etc/hosts文件的内容：

```
docker exec -it node /bin/bash
seluser@c4cc05d832e0:/$ cat /etc/hosts
127.0.0.1   localhost
::1 localhost ip6-localhost ip6-loopback
fe00::0 ip6-localnet
ff00::0 ip6-mcastprefix
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
172.17.0.2  hub 1cbbf6f07804 selenium_hub
172.17.0.3  c4cc05d832e0
```

其中172.17.0.3是node容器的ip，并使用node容器的容器id作为host name。另外，源容器的ip和hostname也写进来了，172.17.0.2是selenium_hub容器的ip，hub是容器在link下的alias，后面是hub容器的容器id。

如果重启了源容器，接收容器的/etc/hosts会自动更新源容器的新ip。

### 总结

在--link标签下，接收容器就是通过设置环境变量和更新/etc/hosts文件来获取源容器的信息，并与之建立通信和传递数据的。

在docker的后续版本中，会取消docker run中的--link选项，但了解其如何在2个容器之间建立通信的原理是非常有用的，因为这有助于理解如何用官方推荐的所有容器在同一个network下来通信的方法，以及用docker-compose来链接2个容器来通信的方法。

9月初就用--link方法连接了seleniumhub和seleniumnode容器，但是不明白--link的作用，最近花了几天时间读官方文档，终于算搞清楚了，也把自己的理解在这里分享下。