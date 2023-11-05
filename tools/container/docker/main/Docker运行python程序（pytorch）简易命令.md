# Docker运行python程序（pytorch）简易命令

分类专栏： linux知识总结 文章标签： docker linux
版权

linux知识总结
专栏收录该内容
2 篇文章0 订阅
订阅专栏
做个笔记，防止忘了！！
文章目录
nvidia-docker 替换 docker

### 容器生命周期管理
docker run：创建一个新的容器并运行一个命令
docker start : 启动一个或多个已经被停止的容器
docker stop :停止一个运行中的容器
docker restart :重启容器
docker kill :杀掉一个运行中的容器
docker rm ：删除一个或多个容器
docker pause :暂停容器中所有的进程。
docker unpause :恢复容器中所有的进程。
docker exec ：在运行的容器中执行命令

### 容器操作命令
docker ps : 列出容器
docker inspect : 获取容器/镜像的元数据
docker top :查看容器中运行的进程信息，支持 ps 命令参数。
docker attach :连接到正在运行中的容器。
docker events : 从服务器获取实时事件
docker logs : 获取容器的日志
docker wait : 阻塞运行直到容器停止，然后打印出它的退出代码。
docker export :将文件系统作为一个tar归档文件导出到STDOUT。
docker cp :用于容器与主机之间的数据拷贝。
docker diff : 检查容器里文件结构的更改。

### 本地镜像
docker images : 列出本地镜像。
docker rmi : 删除本地一个或多少镜像。
docker tag : 标记本地镜像，将其归入某一仓库。

nvidia-docker 替换 docker

容器生命周期管理
docker run：创建一个新的容器并运行一个命令
docker run [OPTIONS] IMAGE [COMMAND] [ARG...]
1
OPTIONS说明：

```
-d: 后台运行容器，并返回容器ID；
-i: 以交互模式运行容器，通常与 -t 同时使用；
-t: 为容器重新分配一个伪输入终端，通常与 -i 同时使用；
–name=“nginx-lb”: 为容器指定一个名称；
–cpuset=“0-2” or --cpuset=“0,1,2”: 绑定容器到指定CPU运行；
```


示例
```
nvidia-docker run -it  nvcr.io/nvidia/pytorch:20.12-py3 /bin/bash
##nvcr.io/nvidia/pytorch:20.12-py3 镜像文件
##/bin/bash 启动容器后，运行此命令
```

```
#使用镜像 nginx:latest，以后台模式启动一个容器,将容器的 80 端口映射到主机的 80 端口,主机的目录 /data 映射到容器的 /data。
docker run -p 80:80 -v /data:/data -d nginx:latest
```

``` bash
docker start # 启动一个或多个已经被停止的容器
docker start myrunoob ## 启动已被停止的容器myrunoob

docker stop :停止一个运行中的容器
docker stop myrunoob ## 停止运行中的容器myrunoob

docker restart :重启容器
docker restart myrunoob ## 重启容器myrunoob

docker kill :杀掉一个运行中的容器
#杀掉运行中的容器mynginx
docker kill -s KILL mynginx
#s :向容器发送一个信号
```

```
docker rm ：删除一个或多个容器
#强制删除容器 db01、db02：
docker rm -f db01 db02
# -f :通过 SIGKILL 信号强制删除一个运行中的容器。

#删除所有已经停止的容器：
docker rm $(docker ps -a -q)

docker pause :暂停容器中所有的进程。
#暂停数据库容器db01提供服务。
docker pause db01

docker unpause :恢复容器中所有的进程。
#恢复数据库容器db01提供服务。
docker unpause db01
```

docker exec ：在运行的容器中执行命令
OPTIONS说明：

-d :分离模式: 在后台运行
-i :即使没有附加也保持STDIN 打开
-t :分配一个伪终端
#在容器 mynginx 中以交互模式执行容器内 /root/runoob.sh 脚本:
runoob@runoob:~$ docker exec -it mynginx /bin/sh /root/runoob.sh
http://www.runoob.com/

```
#在容器 mynginx 中开启一个交互模式的终端:
runoob@runoob:~$ docker exec -i -t  mynginx /bin/bash
root@b1a0703e41e7:/#
```

#查看已经在运行的容器，然后使用容器 ID 进入容器。
docker ps -a 
#通过 exec 命令对指定的容器执行 bash:
docker exec -it 9df70f9a0714 /bin/bash
1
2
3
4
容器操作命令
docker ps : 列出容器
OPTIONS说明：

-a :显示所有的容器，包括未运行的。
-f :根据条件过滤显示的内容。
–format :指定返回值的模板文件。
-l :显示最近创建的容器。
-n :列出最近创建的n个容器。
–no-trunc :不截断输出。
-q :静默模式，只显示容器编号。
-s :显示总的文件大小
输出详情介绍：

CONTAINER ID: 容器 ID。
IMAGE: 使用的镜像。
COMMAND: 启动容器时运行的命令。
CREATED: 容器的创建时间。
STATUS: 容器状态。
状态有7种：
created（已创建）
restarting（重启中）
running（运行中）
removing（迁移中）
paused（暂停）
exited（停止）
dead（死亡）
PORTS: 容器的端口信息和使用的连接类型（tcp\udp）。
NAMES: 自动分配的容器名称。
过滤查看：

#根据标签过滤
$ docker run -d --name=test-nginx --label color=blue nginx
$ docker ps --filter "label=color"
$ docker ps --filter "label=color=blue"
#根据名称过滤
$ docker ps --filter"name=test-nginx"
#根据状态过滤
$ docker ps -a --filter 'exited=0'
$ docker ps --filter status=running
$ docker ps --filter status=paused
#根据镜像过滤
#镜像名称
$ docker ps --filter ancestor=nginx

#镜像ID
$ docker ps --filter ancestor=d0e008c6cf02
#根据启动顺序过滤
$ docker ps -f before=9c3527ed70ce
$ docker ps -f since=6e63f6ff38b0
1
2
3
4
5
6
7
8
9
10
11
12
13
14
15
16
17
18
19
docker inspect : 获取容器/镜像的元数据
OPTIONS说明：

-f :指定返回值的模板文件。
-s :显示总的文件大小。
–type :为指定类型返回JSON。
docker top :查看容器中运行的进程信息，支持 ps 命令参数。
容器运行时不一定有/bin/bash终端来交互执行top命令，而且容器还不一定有top命令，可以使用docker top来实现查看container中正在运行的进程。

#查看容器mymysql的进程信息。
runoob@runoob:~/mysql$ docker top mymysql
#查看所有运行容器的进程信息。
for i in  `docker ps |grep Up|awk '{print $1}'`;do echo \ &&docker top $i; done
1
2
3
4
docker attach :连接到正在运行中的容器。
attach带上–sig-proxy=false来确保CTRL-D或CTRL-C不会关闭容器。

docker events : 从服务器获取实时事件
docker logs : 获取容器的日志
OPTIONS说明：

-f : 跟踪日志输出
–since :显示某个开始时间的所有日志
-t : 显示时间戳
–tail :仅列出最新N条容器日志
#查看容器mynginx从2016年7月1日后的最新10条日志。
docker logs --since="2016-07-01" --tail=10 mynginx
1
2
docker wait : 阻塞运行直到容器停止，然后打印出它的退出代码。
docker export :将文件系统作为一个tar归档文件导出到STDOUT。
#将id为a404c6c174a2的容器按日期保存为tar文件。
runoob@runoob:~$ docker export -o mysql-`date +%Y%m%d`.tar a404c6c174a2
runoob@runoob:~$ ls mysql-`date +%Y%m%d`.tar
mysql-20160711.tar
1
2
3
4
docker cp :用于容器与主机之间的数据拷贝。
OPTIONS说明：
-L :保持源目标中的链接
实例

#将主机/www/runoob目录拷贝到容器96f7f14e99ab的/www目录下。
docker cp /www/runoob 96f7f14e99ab:/www/
#将主机/www/runoob目录拷贝到容器96f7f14e99ab中，目录重命名为www。
docker cp /www/runoob 96f7f14e99ab:/www
#将容器96f7f14e99ab的/www目录拷贝到主机的/tmp目录中。
docker cp  96f7f14e99ab:/www /tmp/
1
2
3
4
5
6
docker diff : 检查容器里文件结构的更改。
#查看容器mymysql的文件结构更改。
runoob@runoob:~$ docker diff mymysql
1
2
本地镜像
docker images : 列出本地镜像。
OPTIONS说明：

-a :列出本地所有的镜像（含中间映像层，默认情况下，过滤掉中间映像层）；
–digests :显示镜像的摘要信息；
-f :显示满足条件的镜像；
–format :指定返回值的模板文件；
–no-trunc :显示完整的镜像信息；
-q :只显示镜像ID
docker rmi : 删除本地一个或多少镜像。
OPTIONS说明：

-f :强制删除；
–no-prune :不移除该镜像的过程镜像，默认移除
docker tag : 标记本地镜像，将其归入某一仓库。
#将镜像ubuntu:15.10标记为 runoob/ubuntu:v3 镜像。
root@runoob:~# docker tag ubuntu:15.10 runoob/ubuntu:v3
root@runoob:~# docker images   runoob/ubuntu:v3
REPOSITORY          TAG                 IMAGE ID            CREATED             SIZE
runoob/ubuntu       v3                  4e3b13c8a266        3 months ago        136.3 MB
1
2
3
4
5
文章知识点与官方知识档案匹配，可进一步学习相关知识