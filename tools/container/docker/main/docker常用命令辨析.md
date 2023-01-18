# docker常用命令辨析

##### docker stop & docker kill

1. Docker引擎通过containerd使用SIGKILL发向容器主进程，等待一段时间后，如果从containerd收到容器退出消息，那么容器Kill成功
2. 在上一步中如果等待超时，Docker引擎将跳过Containerd自己亲自动手通过kill系统调用向容器主进程发送SIGKILL信号。如果此时kill系统调用返回主进程不存在，那么Docker kill成功。否则引擎将一直死等到containerd通过引擎，容器退出。


1. Docker 通过containerd向容器主进程发送SIGTERM信号后等待一段时间后，如果从containerd收到了容器退出消息那么容器退出成功。
2. 在上一步中，如果等待超时，那么Docker将使用Docker kill 方式试图终止容器



- 容器主进程最好需要自己处理SIGTERM信号，因为这是你优雅退出的机会。如果你不处理，那么在Docker stop里你会收到Kill，你未保存的数据就会直接丢失掉。
- Docker stop和Docker kill返回并不意味着容器真正退出成功了，必须通过docker ps查看。
- 对于通过restful与docker 引擎链接的客户端，需要在docker stop和kill restful请求链接上加上超时。对于docker cli用户，需要有另外的机制监控Docker stop或Docker kill命令超时卡死
- 处于D状态一致卡死的进程，内核无法杀死，docker系统也救不了它。只有重启系统才能清除。

##### docker stop & docker pause
`docker stop container_id`与`docker pause container_id`都可以起到停止容器运行的目的, 但其中有一些不同。


`docker pause`命令暂停指定容器中的所有进程。在 Linux 上，这使用 cgroups freezer。传统上，当挂起一个进程时，会使用 SIGSTOP 信号，这个信号可以被被挂起的进程观察到

https://docs.docker.com/engine/reference/commandline/pause/


`docker stop`命令。容器内的主进程会收到 SIGTERM，在一个宽限期后，会收到 SIGKILL。

https://docs.docker.com/engine/reference/commandline/stop/#options

补充
- SIGTERM是终止信号。默认行为是终止进程，但它也可以被捕获或忽略。目的是要终止进程，无论是否优雅，但首先要让它有机会进行清理。
- SIGKILL是终止信号。唯一的行为是立即终止进程。由于进程无法捕获信号，因此无法清除，因此这是最后的信号。
- SIGSTOP是暂停信号。唯一的行为是暂停进程；信号不能被捕获或忽略。Shell 使用暂停（及其对应项，通过 SIGCONT 恢复）来实现作业控制。

##### Docker exec vs attach 区别
docker exec在容器内会起一个新的进程。

docker attach 只会把标准输出输入连接到容器内的PID。

1
``` bash
# 先创建一个ubuntu container
docker run -dit ubuntu
```
　　
2
```
docker exec -t <container-id> bash
```
3
```
docker attach <container-id>
```
　

`docker exec` 和`docker attach` 都可以进到container的shell,  但是有区别。

docker exec在容器内会起一个新的进程。

docker attach 只会把标准输出输入连接到容器内的PID1 . Attach就像投屏，如果你从两个终端attach到一个container，当你在一个终端输入的时候，内容会出现在另一个终端，两个终端是连接在同一个tty上的。

用attach方式进到container，当从终端退出来的时候，container是会被关闭的，即输入exit或者Ctrl+D后容器直接退出会导致**container的停止**。 

exec是不会这样的，不同终端连接到不同的tty，退出终端的时候不会关闭container的main process.

总结：不期望退出终端时容器终止的情况下，建议使用exec。

[https://blog.51cto.com/u_15057807/3656878](https://blog.51cto.com/u_15057807/3656878)


##### 退出docker attach终端
如何退出`docker attach`终端，不杀死容器？

- CTRL-c方式
- CTRL-p CTRL-q方式
- 要另起一个终端，把docker attach进程杀死就可以了

##### docker run 与docker start的区别
docker run 只在第一次运行时使用，将镜像放到容器中，以后再次启动这个容器时，只需要使用命令`docker start`即可。docker run相当于执行了两步操作：
1. 将镜像放入容器中（docker create）
2. 然后将容器启动，使之变成运行时容器（docker start）。


而docker start的作用是，重新启动已存在的镜像。也就是说，如果使用这个命令，我们必须事先知道这个容器的ID，或者这个容器的名字，我们可以使用`docker ps`找到这个容器的信息。
##### docker run
-d表示后台启动 不加-d是在前台启动。
##### docker ps
docker ps
查看正在运行的容器的各种信息

```
➜  ssd_mobilenet_v1 docker ps
CONTAINER ID        IMAGE               COMMAND                  CREATED             STATUS              PORTS                     NAMES
f5bc42f6546e        huginn/huginn       "/scripts/init"          9 days ago          Up 9 days           0.0.0.0:16030->3000/tcp   stupefied_turing
b5a6fddb3303        diygod/rsshub       "dumb-init -- npm ..."   9 days ago          Up 9 days           0.0.0.0:6112->1200/tcp    rsshub2
2b3b2ee838c1        ubuntu              "bash"                   16 months ago       Up 39 minutes                                 agitated_noether
```


docker ps -q
查看正在运行的容器id
```
f5bc42f6546e
b5a6fddb3303
2b3b2ee838c1
```

`docker ps -q` 适合用于bash编程 。
``` bash
docker stop $(docker ps -q) # stop停止所有容器
```



docker ps –a
查看所有的容器

##### docker logs
```
docker logs -f -t --since=“2018-02-08” --tail=100 cce06fc3c633 查看容器中启动的日志
```