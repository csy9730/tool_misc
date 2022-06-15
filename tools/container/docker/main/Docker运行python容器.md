# [Docker运行python容器](https://www.cnblogs.com/weifeng1463/p/10356946.html)



　容器是镜像运行的实例，而镜像保存在仓库里，测试或者发布生产环境只需要pull下来即可，相对传统的应用部署，能很好的保持环境的一致，节省运维时间。最近公司内部的java和.net服务也已经全部容器化，实现从开发环境 到 测试环境 再到 生产环境，自动化部署。本文介绍的是python应用运行docker容器。

以django部署到docker 为例

 

### 1.编写Dockerfile文件

每一个镜像都有一个Dockerfile文件对应，Dockerfile定义了如何构建镜像。



```
FROM python:3.6.4

RUN mkdir /code \
&&apt-get update \
&&apt-get -y install freetds-dev \
&&apt-get -y install unixodbc-dev
COPY app /code 
COPY requirements.txt /code
RUN pip install -r /code/requirements.txt -i https://pypi.douban.com/simple
WORKDIR /code

CMD ["/bin/bash","run.sh"]
```



 

FROM：Dockerfile中的一个非常重要的命令，作用是指定一个基础镜像来进行构建流程。比如上面指定了python3.6.4作为基础镜像，后续的一切操作都会以这个镜像作为基础来进行定制，如果不存在，会从官网下载。FROM必须是Dockerfile首个命令。

RUN ：Dockerfile执行命令最核心的部分，在构建镜像的过程中执行参数。

COPY：复制文件。COPY <源路径> <目标路径>

WORKDIR：工作目录，若不存在，会自动帮你创建。

CMD：容器启动命令，Docker 不是虚拟机，容器就是进程。既然是进程，那么在启动容器的时候，需要指定所运行的程序及参数。 CMD 指令就是用于指定默认的容器主进程的启动命令。如果docker run指定了命令参数，这里的cmd将不会起作用。例如docker run -it -name redis docker.io/redis /bin/bash，启动容器不会执行dockerfile中的cmd，因为docker run已经指定了命令参数/bin/bash。

 

### 2.构建镜像 

构建目录，我这里有四个文件和文件夹。

1.app是django项目

2.Dockerfile

3.requirements.txt是项目运行所需要的python库

4.run.sh是运行容器时需要调用的shell脚本

```
[root@CentOS webtest]# ls
app  Dockerfile  requirements.txt  run.sh
```

requirements.txt



```
Django
djangorestframework
pyDes
PyMySQL
redis
requests
pymssql
pyodbc
paramiko
psutil
```



run.sh

```
python /code/app/manage.py runserver 0.0.0.0:8000
```

docker bulid -t <name> . 用于构建镜像。



```
[root@CentOS webtest]# ls
app  Dockerfile  requirements.txt  run.sh
[root@CentOS webtest]# docker build -t webtest . 
...
...
...
Removing intermediate container 9c510e88e659
Step 6/6 : CMD /bin/bash run.sh
---> Running in 0bd29255c648
---> 1dfa2905efac
Removing intermediate container 0bd29255c648
Successfully built 1dfa2905efac
```



构建完成后返回一个镜像id 1dfa2905efac 。

 

### 3.运行容器

启动容器，运行刚才构建的镜像。

docker run -it -p 6500:8000 -v /home/code/webtest:/code --name web --restart always --privileged=true web



```
[root@CentOS webtest]# docker run -it -p 6500:8000 -v /home/code/webtest:/code --name web --restart always --privileged=true web
Performing system checks...

System check identified no issues (0 silenced).

You have 15 unapplied migration(s). Your project may not work properly until you apply the migrations for app(s): admin, auth, contenttypes, sessions.
Run 'python manage.py migrate' to apply them.

August 09, 2018 - 09:56:51
Django version 2.1, using settings 'ShiHangTool.settings'
Starting development server at http://0.0.0.0:8000/
Quit the server with CONTROL-C.
```



​     

​     -p：把容器的8000端口映射到宿主机6500

​     -v：主机的目录/home/code/webtest映射到容器的目录/code

​     --name：给容器起个名字web，webtest是我们刚刚构建的镜像

​     --restart：always 容器退出时总是重启

​     --privileged=true：执行容器内文件需要的权限

 

 

输入 ip:6000/Home/OrderSettle-K8S/

 ![img](https://blogimg-1256334314.cos.ap-chengdu.myqcloud.com/dce40e4a-b2c5-446f-b241-5b23ccbdec0d.png)

运行成功！

 



分类: [docker,kubernetes](https://www.cnblogs.com/weifeng1463/category/1068431.html)

标签: [Docker运行python容器](https://www.cnblogs.com/weifeng1463/tag/Docker%E8%BF%90%E8%A1%8Cpython%E5%AE%B9%E5%99%A8/)

[好文要顶](javascript:void(0);) [关注我](javascript:void(0);) [收藏该文](javascript:void(0);) [![img](https://common.cnblogs.com/images/icon_weibo_24.png)](javascript:void(0);) [![img](https://common.cnblogs.com/images/wechat.png)](javascript:void(0);)

![img](https://pic.cnblogs.com/face/sample_face.gif)

[Oops!#](https://home.cnblogs.com/u/weifeng1463/)
[关注 - 2](https://home.cnblogs.com/u/weifeng1463/followees/)
[粉丝 - 82](https://home.cnblogs.com/u/weifeng1463/followers/)





[+加关注](javascript:void(0);)

0

0







[« ](https://www.cnblogs.com/weifeng1463/p/10355906.html)上一篇： [Dockerfile 构建后端springboot应用并用shell脚本实现jenkins自动构建](https://www.cnblogs.com/weifeng1463/p/10355906.html)
[» ](https://www.cnblogs.com/weifeng1463/p/10356954.html)下一篇： [如何开发一个基于 Docker 的 Python 应用](https://www.cnblogs.com/weifeng1463/p/10356954.html)

posted @ 2019-02-08 23:12  [Oops!#](https://www.cnblogs.com/weifeng1463/)  阅读(7873)  评论(0)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=10356946)  [收藏](javascript:void(0))  [举报](javascript:void(0))



