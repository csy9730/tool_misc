# [访问Docker仓库](https://www.cnblogs.com/wade-luffy/p/6497502.html)



仓库（Repository）是集中存放镜像的地方，分公共仓库和私有仓库。一个容易与之混淆的概念是注册服务器（Registry）。实际上注册服务器是存放仓库的具体服务器，一个注册服务器上可以有多个仓库，而每个仓库下面可以有多个镜像。从这方面来说，可将仓库看做一个具体的项目或目录。

例如对于仓库地址private-docker.com/ubuntu来说，private-docker.com是注册服务器地址，ubuntu是仓库名。

### Docker Hub公共镜像市场

目前Docker官方维护了一个公共镜像仓库https://hub.docker.com，其中已经包括超过15000的镜像。大部分镜像需求，都可以通过在Docker Hub中直接下载镜像来实现。

**1.登录**

可以通过命令行执行docker login命令来输入用户名、密码和邮箱来完成注册和登录。注册成功后，本地用户目录的.dockercfg中将保存用户的认证信息。

登录成功的用户可以上传个人制造的镜像。

**2.基本操作**

用户无需登录即可通过docker search命令来查找官方仓库中的镜像，并利用docker pull命令来将它下载到本地。

例如以centos为关键词进行搜索：$ docker search centos

![img](https://images2015.cnblogs.com/blog/990532/201703/990532-20170303163418782-2067171408.png)

根据是否为官方提供，可将这些镜像资源分为两类。另外，在查找的时候通过-s N参数可以指定仅显示评价为N星以上的镜像。

一种是类似centos这样的基础镜像，称为基础或根镜像。这些镜像是由Docker公司创建、验证、支持、提供。这样的镜像往往使用单个单词作为名字。

一种是比如ansible/centos7-ansible镜像，它是由Docker用户ansible创建并维护的，带有用户名称为前缀，表明是某用户下的某仓库。可以通过用户名称前缀user_name/镜像名来指定使用某个用户提供的镜像。

下载官方centos镜像到本地，$ docker pull centos

用户也可以在登录后通过docker push命令来将本地镜像推送到Docker Hub。

**3.自动创建**

自动创建（Automated Builds）功能对于需要经常升级镜像内程序来说，十分方便。

有时候，用户创建了镜像，安装了某个软件，如果软件发布新版本则需要手动更新镜像。而自动创建允许用户通过Docker Hub指定跟踪一个目标网站（目前支持GitHub或BitBucket）上的项目，一旦项目发生新的提交，则自动执行创建。

要配置自动创建，包括如下的步骤：

1）创建并登录Docker Hub，以及目标网站；*在目标网站中连接帐户到Docker Hub；

2）在Docker Hub中配置一个“自动创建”；

3）选取一个目标网站中的项目（需要含Dockerfile）和分支；

4）指定Dockerfile的位置，并提交创建。

之后，可以在Docker Hub的“自动创建”页面中跟踪每次创建的状态。

### 时速云镜像市场

国内不少云服务商都提供了Docker镜像市场，下面以时速云为例（https://hub.tenxcloud.com），介绍如何使用这些市场。 

1.查看镜像

访问https://hub.tenxcloud.com，即可看到已存在的仓库和存储的镜像，包括Ubuntu、Java、Mongo、MySQL、Nginx等热门仓库和镜像。时速云官方仓库中的镜像会保持跟DockerHub中官方镜像的同步。

2.下载镜像

下载镜像也是使用docker pull命令，但是要在镜像名称前添加注册服务器的具体地址。格式为index.tenxcloud.com//:。

例如，要下载Docker官方仓库中的node:latest镜像，可以使用如下命令：$ docker pull index.tenxcloud.com/docker_library/node:latest

正常情况下，镜像下载会比直接从DockerHub下载快得多。

通过docker images命令来查看下载到本地的镜像：$ docker images

下载后，可以更新镜像的标签，与官方标签保持一致，方便使用：

$ docker tag index.tenxcloud.com/docker_library/node:latest node:latest

另外，阿里云等服务商也已经提供了Docker镜像的下载服务，用户可以根据服务质量自行选择。

### 搭建本地私有仓库

1.使用registry镜像创建私有仓库

安装Docker后，可以通过官方提供的registry镜像来简单搭建一套本地私有仓库环境：

$ docker run -d -p 5000:5000 registry

这将自动下载并启动一个registry容器，创建本地的私有仓库服务。

默认情况下，会将仓库创建在容器的/tmp/registry目录下。可以通过-v参数来将镜像文件存放在本地的指定路径。

例如下面的例子将上传的镜像放到/opt/data/registry目录：

$ docker run -d -p 5000:5000 -v /opt/data/registry:/tmp/registry registry

此时，在本地将启动一个私有仓库服务，监听端口为5000。

2.管理私有仓库

首先查看其地址为10.0.2.2:5000。然后在虚拟机系统（Ubuntu 14.04）里测试上传和下载镜像。

在Ubuntu 14.04系统查看已有的镜像：

$ docker images

REPOSITORY           TAG       IMAGE ID            CREATED      VIRTUAL SIZE

ubuntu               14.04     ba5877dc9bec        6 days ago   199.3 MB

使用docker tag命令将这个镜像标记为10.0.2.2:5000/test

$ docker tag ubuntu:14.04 10.0.2.2:5000/test

$ docker images

REPOSITORY           TAG       IMAGE ID            CREATED      VIRTUAL SIZE

ubuntu                    14.04     ba5877dc9bec        6 days ago   199.3 MB

10.0.2.2:5000/test   latest    ba5877dc9bec        6 days ago   199.3 MB

使用docker push上传标记的镜像：

$ docker push 10.0.2.2:5000/test

用curl查看仓库10.0.2.2:5000中的镜像：

$ curl http://10.0.2.2:5000/v1/search

{"num_results": 1, "query": "", "results": [{"description": "", "name": "library/test"}]}

在结果中可以看到{"description"：""，"name"："library/test"}，表明镜像已经成功上传了。

现在可以到任意一台能访问到10.0.2.2地址的机器去下载这个镜像了。比较新的Docker版本对安全性要求较高，会要求仓库支持SSL/TLS证书。对于内部使用的私有仓库，可以自行配置证书或关闭对仓库的安全性检查。

首先，修改Docker daemon的启动参数，添加如下参数，表示信任这个私有仓库，不进行安全证书检查：

DOCKER_OPTS="--insecure-registry 10.0.2.2:5000"

之后重启Docker服务，并从私有仓库中下载镜像到本地：

$ sudo service docker restart

$ docker pull 10.0.2.2:5000/test

$ docker images

REPOSITORY              TAG         IMAGE ID       CREATED      VIRTUAL SIZE

10.0.2.2:5000/test      latest      ba5877dc9bec   6 days ago   199.3 MB

下载后，还可以添加一个更通用的标签ubuntu:14.04：

$ docker tag 10.0.2.2:5000/test ubuntu:14.04

如果要使用安全证书，用户也可以从较知名的CA服务商（如verisign）申请公开的SSL/TLS证书，或者使用openssl等软件来自行生成。