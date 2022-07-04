# Docker Swarm介绍及使用入门

[![img](https://upload.jianshu.io/users/upload_avatars/5673257/903880de-6312-4751-99cd-c1e6b1870164.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)](https://www.jianshu.com/u/29e35e444a73)

[文景大大](https://www.jianshu.com/u/29e35e444a73)关注

0.3112021.11.28 22:21:06字数 2,236阅读 3,265

## 一、Swarm介绍

Docker Swarm是管理跨节点容器的编排工具，相较于Docker Compose而言，Compose只能编排单节点上的容器，Swarm将一群Docker节点虚拟化为一个主机，使得用户只要在单一主机上操作就能完成对整个容器集群的管理工作。如果下载的是最新版的Docker，那么Swarm就已经被包含在内了，无需再安装。

Docker Swarm架构包含两种角色，manager和node，前者是Swarm Daemon工作的节点，包含了调度器、路由、服务发现等功能，负责接收客户端的集群管理请求，然后调度Node进行具体的容器工作，比如容器的创建、扩容与销毁等。 manager本身也是一个node。

![img](https://upload-images.jianshu.io/upload_images/5673257-8ea61494c6044d31.png?imageMogr2/auto-orient/strip|imageView2/2/w/510/format/webp)

Swarm工作示意图

通常情况下，为了集群的高可用，manager个数>=3的奇数，node的个数则是不限制。

## 二、Swarm实例

### 2.1 准备工作

我们需要准备好三个节点，并在各自节点上安装好Docker Engine，才能进行接下来的实例搭建。

此处，我们选择购买阿里云的三个ECS云服务器，它们都是在一个地域里面，对应的私有地址IP和修改的host name分别是：



```css
172.25.206.125 ————作为node1
172.25.206.126 ————作为node2
172.22.147.207 ————作为manager
```

我们首先需要重置root的登录密码，然后ssh登录后，确保相互之间可以ping通，然后再继续下面的操作。一般三台机器如果都在同一个区的话，使用私有地址相互之间肯定是联通的。

然后登录各个容器内部的命令行，进行Docker Engine的安装，该步骤可以参考另外一篇文章：[《CentOS系统安装Docker》](https://www.jianshu.com/p/fea42f6243b8)，安装完成后可以执行`docker --version`进行查看，务必确保全部安装成功以后再进入下面的步骤。

### 2.1 创建集群

在创建集群之前，我们使用`docker node ls`想查看下集群中节点的信息，反馈目前没有节点信息，并且当前节点并不是manager。



```bash
[root@manager ~]# docker node ls
Error response from daemon: This node is not a swarm manager. Use "docker swarm init" or "docker swarm join" to connect this node to swarm and try again.
```

那么我们首先就在manager这个节点上执行如下操作，表示要将它设置为manager，并且设置自己的通讯IP为`172.22.147.207`。



```bash
[root@manager ~]# docker swarm init --advertise-addr 172.22.147.207
Swarm initialized: current node (s0eoali1x32ly22jo85ebeb0w) is now a manager.

To add a worker to this swarm, run the following command:

    docker swarm join --token SWMTKN-1-57msikozxxt44uxz5r8hihmakp4zh1cr89v7zlxhyc8b5iojkt-5ea8uh68jcuy8m6f9ma7x0zg5 172.22.147.207:2377

To add a manager to this swarm, run 'docker swarm join-token manager' and follow the instructions.
```

如上就完成了manager节点的设置，并且得到提示信息如下：

- 可以在其它节点上执行`docker swarm join --token......`来将该节点设置为工作node，并加入到这个swarm集群中；
- 可以在其它节点上执行`docker swarm join-token manager`来获取下一步执行指令，执行该指令后，该节点将设置为manager从节点加入到这个swarm集群中；

我们目前演示的是一个manager，两个工作node的模式，所以在另外两台node1和node2上执行第一个命令即可：



```bash
[root@node1 ~]# docker swarm join --token SWMTKN-1-57msikozxxt44uxz5r8hihmakp4zh1cr89v7zlxhyc8b5iojkt-5ea8uh68jcuy8m6f9ma7x0zg5 172.22.147.207:2377
This node joined a swarm as a worker.
```

如此，一个swarm集群就算搭建完成了。

### 2.2 使用集群

manager是我们管理集群的入口，我们的docker命令都是在manager上执行，node节点上是不能执行dockr命令的，这一点要十分牢记。

- 查看当前节点信息；

  

  ```bash
  [root@manager ~]# docker node ls
  ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
  s0eoali1x32ly22jo85ebeb0w *   manager    Ready     Active         Leader           20.10.11
  7kuhm78bs3zrfkm2n28ukje25     node1      Ready     Active                          20.10.11
  io4qmqb87yzpmmo2mpblj48fp     node2      Ready     Active                          20.10.11
  ```

- 创建一个私有网络，供不同节点上的容器互通使用；网络相关参考[Docker网络互联原理及自定义网络的使用](https://www.jianshu.com/p/d4bb218ec465)

  

  ```bash
  [root@manager ~]# docker network ls
  NETWORK ID     NAME              DRIVER    SCOPE
  45f6a352dcd2   bridge            bridge    local
  2b71198e802e   docker_gwbridge   bridge    local
  679154a40c18   host              host      local
  1ntnd2ruk0tp   ingress           overlay   swarm
  6d6218b5a31f   none              null      local
  [root@manager ~]# docker network create -d overlay niginx_network
  ldb1i69hxdsdo6un8yhaddhnv
  [root@manager ~]# docker network ls
  NETWORK ID     NAME              DRIVER    SCOPE
  45f6a352dcd2   bridge            bridge    local
  2b71198e802e   docker_gwbridge   bridge    local
  679154a40c18   host              host      local
  1ntnd2ruk0tp   ingress           overlay   swarm
  ldb1i69hxdsd   niginx_network    overlay   swarm
  6d6218b5a31f   none              null      local
  ```

- 使用指定的网络部署一个服务；

  

  ```bash
  [root@manager ~]# docker service create --replicas 1 --network niginx_network --name my_nginx -p 80:80 nginx:latest
  q03ljoy94xkdeicb7d9tx422b
  overall progress: 1 out of 1 tasks 
  1/1: running   [==================================================>] 
  verify: Service converged 
  ```

  如上使用nginx:latest镜像创建了一个容器，容器名称为my_nginx，对外暴露80端口；

- 查看运行中的服务列表；

  

  ```bash
  [root@manager ~]# docker service ls
  ID             NAME       MODE         REPLICAS   IMAGE          PORTS
  q03ljoy94xkd   my_nginx   replicated   1/1        nginx:latest   *:80->80/tcp
  ```

- 查看某个服务在哪个节点上运行；

  

  ```bash
  [root@manager ~]# docker service ps my_nginx
  ID             NAME         IMAGE          NODE      DESIRED STATE   CURRENT STATE           ERROR     PORTS
  wf5h6u13zel6   my_nginx.1   nginx:latest   manager   Running         Running 2 minutes ago 
  ```

  除此之外，我们还可以在每一台服务器上使用`docker ps`来看看运行了哪些容器；

- 动态扩缩容某个服务的容器个数；

  

  ```bash
  [root@manager ~]# docker service scale my_nginx=4
  my_nginx scaled to 4
  overall progress: 4 out of 4 tasks 
  1/4: running   [==================================================>] 
  2/4: running   [==================================================>] 
  3/4: running   [==================================================>] 
  4/4: running   [==================================================>] 
  verify: Service converged 
  [root@manager ~]# docker service ls
  ID             NAME       MODE         REPLICAS   IMAGE          PORTS
  q03ljoy94xkd   my_nginx   replicated   4/4        nginx:latest   *:80->80/tcp
  [root@manager ~]# docker service ps my_nginx
  ID             NAME         IMAGE          NODE      DESIRED STATE   CURRENT STATE            ERROR     PORTS
  wf5h6u13zel6   my_nginx.1   nginx:latest   manager   Running         Running 8 minutes ago              
  kke3fl9sxdjm   my_nginx.2   nginx:latest   node1     Running         Running 27 seconds ago             
  0ds3p18dmc9r   my_nginx.3   nginx:latest   node1     Running         Running 27 seconds ago             
  32kyyibu9j12   my_nginx.4   nginx:latest   node2     Running         Running 25 seconds ago
  ```

  使用update命令也是等价的：`docker service update --replicas 3 my_nginx`；

- 下线一个节点，使之不参与任务分派；

  

  ```bash
  [root@manager ~]# docker node update --availability drain node2
  node2
  [root@manager ~]# docker node ls
  ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
  s0eoali1x32ly22jo85ebeb0w *   manager    Ready     Active         Leader           20.10.11
  7kuhm78bs3zrfkm2n28ukje25     node1      Ready     Active                          20.10.11
  io4qmqb87yzpmmo2mpblj48fp     node2      Ready     Drain                           20.10.11
  ```

  值得一提的是，如果某个节点被设置下线，或者因为其它故障宕机了，那么它其上的容器会被转移到其它可运行的节点上，如此来保证始终有指定副本数量的容器在运行。

- 上线一个下线中的节点，使之参与任务分派；

  

  ```bash
  [root@manager ~]# docker node update --availability active node2
  node2
  ```

- 移除一个任务，使得集群中所有该任务的容器都删除；

  

  ```bash
  [root@manager ~]# docker service update --replicas 4 my_nginx
  my_nginx
  overall progress: 4 out of 4 tasks 
  1/4: running   [==================================================>] 
  2/4: running   [==================================================>] 
  3/4: running   [==================================================>] 
  4/4: running   [==================================================>] 
  verify: Service converged 
  [root@manager ~]# docker service ps my_nginx
  ID             NAME             IMAGE          NODE      DESIRED STATE   CURRENT STATE            ERROR     PORTS
  wf5h6u13zel6   my_nginx.1       nginx:latest   manager   Running         Running 18 minutes ago             
  q9soig9jmkik   my_nginx.2       nginx:latest   node2     Running         Running 13 seconds ago             
  hqti23fox6ui   my_nginx.3       nginx:latest   node1     Running         Running 13 seconds ago             
  wgm2xaqd147p   my_nginx.4       nginx:latest   node2     Running         Running 13 seconds ago             
  32kyyibu9j12    \_ my_nginx.4   nginx:latest   node2     Shutdown        Shutdown 7 minutes ago             
  [root@manager ~]# docker service rm my_nginx
  my_nginx
  [root@manager ~]# docker service ps my_nginx
  no such service: my_nginx
  ```

- 节点离开集群；

  

  ```bash
  [root@node1 ~]# docker swarm leave
  Node left the swarm.
  ```

  

  ```bash
  [root@manager ~]# docker node ls
  ID                            HOSTNAME   STATUS    AVAILABILITY   MANAGER STATUS   ENGINE VERSION
  s0eoali1x32ly22jo85ebeb0w *   manager    Ready     Active         Leader           20.10.11
  7kuhm78bs3zrfkm2n28ukje25     node1      Down      Active                          20.10.11
  io4qmqb87yzpmmo2mpblj48fp     node2      Ready     Active                          20.10.11
  ```

- 删除swarm集群；

  

  ```bash
  [root@manager ~]# docker swarm leave
  Error response from daemon: You are attempting to leave the swarm on a node that is participating as a manager. Removing the last manager erases all current state of the swarm. Use `--force` to ignore this message.
  [root@manager ~]# docker swarm leave -f
  Node left the swarm.
  ```

  当最后一个manager节点离开，则swarm集群自动删除。



2人点赞



[容器技术](https://www.jianshu.com/nb/51605895)



更多精彩内容，就在简书APP