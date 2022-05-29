# [容器时代的持续交付工具---Drone：Drone介绍与安装](https://www.cnblogs.com/dxp909/p/11585020.html)



 

**Drone：Drone is a Container-Native, Continuous Delivery Platform。**

官方给的定义，从上面的定义可以得出两个关键点：

1，**Container-Native：**Cloud-Native是云原生，那Container-Native可以翻译成容器原生，就是说Drone是容器时代的一个产品，是基于容器实现的。

2， **Continuous Delivery：**持续交付，容器是现在快速交付的一个代名词，而Drone是容器化的一种持续交付的平台，其实Drone不仅仅可以实现持续交付，借助一些plugin，也可以实现持续部署。

官方地址：<https://drone.io/>

## **如何安装？**

一、Drone是**Container-Native**的平台，那自然Drone也是使用容器方式来安装的，所以首先要准备容器的运行环境，我们这里使用docker，安装docker具体操作如下：

1，安装需要的软件包

```
`yum install -y yum-utils \device-mapper-persistent-data \lvm2
```

2，配置yum源

```
`yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
```

3，安装docker-ce

```
yum install docker-ce
```

4，启动docker

```
systemctl start docker
```

 

通过以上方式就完成了docker的安装。

 

## 二、安装Drone

Drone分两大部分，一部分是server，一部分是agent，先来看server的安装，通过执行以下指令来启动一个drone server 容器

``` bash
docker run --volume=/data:/data --env=DRONE_AGENTS_ENABLED=true --env=DRONE_GOGS_SERVER={Gogs地址} --env=DRONE_RPC_SECRET={与agent通信的密钥} --env=DRONE_SERVER_HOST={HOST}  --env=DRONE_SERVER_PROTO=http --env=DRONE_USER_CREATE=username:{管理员账号},admin:true--env=DRONE_LOGS_TRACE=true --publish=30000:80 --restart=always   --detach=true --name=drone  drone/drone:1.4.0
```

 

 几个关键配置：

```
DRONE_GOGS_SERVER：这里使用的是gogs作为git仓储，当然drone也支持github,gitlab等一些主流的源码管理平台，不同的平台需要设置不同的环境变量，具体参照官方文档参数名称
DRONE_RPC_SECRET：与agent之间通信的密钥，一定要配置
DRONE_SERVER_HOST：设置drone server使用的host名称，可以是ip地址加端口号
DRONE_SERVER_PROTO：使用的协议http/https
DRONE_USER_CREATE：设置初始的管理员，这个是超级管理员
DRONE_LOGS_TRACE：启动日志，默认是关闭的
```
publish：端口映射
上面指令执行完后，就启动了一个drone server 容器，通过配置的host可以访问系统

下面是安装agent，执行下面的指令来完成：
``` bash
docker run -d -v /var/run/docker.sock:/var/run/docker.sock -e DRONE_RPC_PROTO=http -e DRONE_RPC_HOST={server host} -e DRONE_RPC_SECRET={密钥} -e DRONE_RUNNER_CAPACITY=2 -e DRONE_RUNNER_NAME={Host} --env=DRONE_LOGS_TRACE=true` `-p 3000:3000 --restart=always--name runner drone/agent:1.4.0
```

　　

DRONE_RPC_HOST：上面启动server时配置的host

DRONE_RPC_SECRET：跟server配置的要保持一致

DRONE_RUNNER_CAPACITY：可以同时执行的任务数

DRONE_RUNNER_NAME：一般设置为主机名

到此agent安装完。

 

打开浏览器，输入**DRONE_SERVER_HOST配置的地址，就可以进入系统进行使用**

![img](https://img2018.cnblogs.com/blog/1100622/201909/1100622-20190925163808883-1996603607.png)

 