# [Docker运行操作系统环境(BusyBox&Alpine&Debian/Ubuntu&CentOS/Fedora)](https://www.cnblogs.com/wade-luffy/p/6548164.html)



**目录**

- [BusyBox](https://www.cnblogs.com/wade-luffy/p/6548164.html#_label0)
- [Alpine](https://www.cnblogs.com/wade-luffy/p/6548164.html#_label1)
- Debian/Ubuntu
  - [CentOS/Fedora](https://www.cnblogs.com/wade-luffy/p/6548164.html#_label2_0)
- [总结意见](https://www.cnblogs.com/wade-luffy/p/6548164.html#_label3)

 

------

目前常用的Linux发行版主要包括Debian/Ubuntu系列和CentOS/Fedora系列。前者以自带软件包版本较新而出名；后者则宣称运行更稳定一些。选择哪个操作系统取决于读者的具体需求。同时，社区还推出了完全基于Docker的Linux发行版CoreOS。

使用Docker，只需要一个命令就能快速获取一个Linux发行版镜像，这是以往包括各种虚拟化技术都难以实现的。这些镜像一般都很精简，但是可以支持完整Linux系统的大部分功能。

![img](https://images2015.cnblogs.com/blog/990532/201703/990532-20170314140236682-997662666.png)

[回到顶部](https://www.cnblogs.com/wade-luffy/p/6548164.html#_labelTop)

## BusyBox

BusyBox是一个集成了一百多个最常用Linux命令和工具（如cat、echo、grep、mount、telnet等）的精简工具箱，它只有几MB的大小，很方便进行各种快速验证，被誉为“Linux系统的瑞士军刀”。BusyBox可运行于多款POSIX环境的操作系统中，如Linux（包括Android）、Hurd、FreeBSD等。

在Docker Hub中搜索busybox相关的镜像：

$ docker search busybox

NAME         DESCRIPTION            STARS  OFFICIAL AUTOMATED

busybox       Busybox base image.       755     [OK]

...

读者可以看到最受欢迎的镜像。带有OFFICIAL标记说明是官方镜像。

$ docker pull busybox:latest

下载后，可以看到busybox镜像只有2.433MB：

![img](https://images2015.cnblogs.com/blog/990532/201703/990532-20170314141039838-1201614597.png)

启动一个busybox容器，并在容器内查看挂载信息，如下所示：

![img](https://images2015.cnblogs.com/blog/990532/201703/990532-20170314141007713-875117576.png)

busybox镜像虽然小巧，但包括了大量常见的Linux命令，可以用它快速熟悉Linux命令。

[回到顶部](https://www.cnblogs.com/wade-luffy/p/6548164.html#_labelTop)

## Alpine

Alpine操作系统是一个面向安全的轻型Linux发行版。它不同于通常的Linux发行版，Alpine采用了musl libc和BusyBox以减小系统的体积和运行时资源消耗，但功能上比BusyBox又完善得多。在保持瘦身的同时，Alpine还提供了自己的包管理工具apk，可以通过https://pkgs.alpinelinux.org/packages查询包信息，也可以通过apk命令直接查询和安装各种软件。

Alpine Docker镜像也继承了Alpine Linux发行版的这些优势。相比于其他Docker镜像，它的容量非常小，仅仅只有5MB左右（Ubuntu系列镜像接近200MB），且拥有非常友好的包管理机制。官方镜像来自docker-alpine项目。

目前Docker官方已开始推荐使用Alpine替代之前的Ubuntu作为基础镜像环境。这样会带来多个好处，包括镜像下载速度加快，镜像安全性提高，主机之间的切换更方便，占用更少磁盘空间等。

1.使用官方镜像

由于镜像很小，下载时间往往很短，可以使用docker run指令直接运行一个alpine容器，并指定运行的Linux指令，例如：

$ docker run alpine echo '123'

使用time工具测试在本地没有提前pull镜像的情况下，执行echo命令的时间，仅需要3秒左右。

$ time docker run alpine echo '123'

```
Unable to find image 'alpine:latest' locally latest:
Pulling from library/alpine
e110a4a17941: Pull completeDigest: sha256:3dcdb92d7432d56604d4545cbd324b14e647b
313626d99b889d0626de158f73aStatus: Downloaded newer image for alpine:latest123
real 0m3.367s user 0m0.040s sys 0m0.007s
```

2.迁移至Alpine基础镜像

目前，大部分Docker官方镜像都已经支持Alpine作为基础镜像，因此可以很容易地进行迁移。

例如：

ubuntu/debian -> alpine

python:2.7 -> python:2.7-alpine

ruby:2.3 -> ruby:2.3-alpine

另外，如果使用Alpine镜像替换Ubuntu基础镜像，安装软件包时需要用apk包管理器替换apt工具，如  $ apk add --no-cache

Alpine中软件安装包的名字可能会与其他发行版有所不同，可以在https://pkgs.alpinelinux.org/packages网站搜索并确定安装包的名称。如果需要的安装包不在主索引内，但是在测试或社区索引中，那么可以按照以下方法使用这些安装包：

$ echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

$ apk --update add --no-cache

[回到顶部](https://www.cnblogs.com/wade-luffy/p/6548164.html#_labelTop)

## Debian/Ubuntu

Debian和Ubuntu都是目前较为流行的Debian系的服务器操作系统，十分适合研发场景。Docker Hub上提供了官方镜像，国内各大容器云服务也基本都提供了相应的支持。

**1.Debian系统简介及使用**

Debian是由GPL和其他自由软件许可协议授权的自由软件组成的操作系统，由Debian Project组织维护。Debian计划是一个独立、分散的组织，由3000个志愿者组成，接受世界多个非盈利组织的资金支持，Software in the Public Interest提供支持并持有商标作为保护机构。Debian以其坚守Unix和自由软件的精神，以及给予用户的众多选择而闻名。现在Debian包括了超过25000个软件包并支持12个计算机系统结构。

作为一个大的系统组织框架，Debian下面有多种不同操作系统核心的分支计划，主要为采用Linux核心的Debian GNU/Linux系统，其他还有采用GNU Hurd核心的Debian GNU/Hurd系统、采用FreeBSD核心的Debian GNU/kFreeBSD系统，以及采用NetBSD核心的Debian GNU/NetBSD系统，甚至还有利用Debian的系统架构和工具，采用OpenSolaris核心构建而成的Nexenta OS系统。在这些Debian系统中，以采用Linux核心的Debian GNU/Linux最为著名。

众多的Linux发行版，例如Ubuntu、Knoppix和Linspire及Xandros等，都基于Debian GNU/Linux。

可以使用docker search搜索Docker Hub，查找Debian镜像，结果如下所示：

$ docker search debian

NAME     DESCRIPTION  STARS   OFFICIAL  AUTOMATED

debian     Debian is...     1565   [OK]

...

官方提供了大家熟知的debian镜像以及面向科研领域的neurodebian镜像。

可以使用docker run直接运行debian镜像：

$ docker run -it debian bash

root@668e178d8d69:/# cat /etc/issue

Debian GNU/Linux 8

debian镜像很适合作为基础镜像，用于构建自定义镜像。

**2.Ubuntu系统简介及使用**

Ubuntu是一个以桌面应用为主的GNU/Linux操作系统，其名称来自非洲南部祖鲁语或豪萨语的“ubuntu”一词。Ubuntu意思是“人性”以及“我的存在是因为大家的存在”，是非洲的一种传统价值观。Ubuntu基于Debian发行版和GNOME/Unity桌面环境，与Debian的不同在于它每6个月会发布一个新版本，每2年会推出一个长期支持（Long Term Support，LTS）版本，一般支持3年。

Ubuntu相关的镜像有很多，在Docker Hub上使用-s 10参数进行搜索，只搜索那些被收藏10次以上的镜像：

$ docker search -s 10 ubuntu

NAME             DESCRIPTION       STARS      OFFICIAL AUTOMATED

ubuntu            Official Ubuntu base image          840  [OK]

Dockerfile/ubuntu      Trusted automated Ubuntu (http://www.ubunt...  30  [OK]

crashsystems/gitlab-docker  A trusted, regularly updated build of GitL... 20  [OK]

注意，Docker 1.12版本中已经不支持--stars参数了，可以使用-f stars=N参数。

下面以Ubuntu 14.04为例，演示如何使用该镜像安装一些常用软件。

首先使用-it参数启动容器，登录bash，查看ubuntu的发行版本号：

$ docker run -it ubuntu:14.04 /bin/bash

root@7d93de07bf76:/# lsb_release -a

No LSB modules are available.

Distributor ID: Ubuntu

Description:  Ubuntu 14.04.1 LTS

Release:    14.04

Codename:    trusty

当试图直接使用apt-get安装一个软件的时候，会提示E：Unable to locate package：

root@7d93de07bf76:/# apt-get install curl

Reading package lists... Done

Building dependency tree

Reading state information... Done

E: Unable to locate package curl

这并非系统不支持apt-get命令。Docker镜像在制作时为了精简清除了apt仓库信息，因此需要先执行apt-get update命令来更新仓库信息。更新信息后即可成功通过apt-get命令来安装软件：

root@7d93de07bf76:/# apt-get update

安装curl工具：

root@7d93de07bf76:/# apt-get install curl -y

Reading package lists... Done

Building dependency tree

Reading state information... Done

...

root@7d93de07bf76:/# curl

curl: try 'curl --help' or 'curl --manual' for more information

接下来，再安装apache服务：

root@7d93de07bf76:/# apt-get install -y apache2

启动这个apache服务，然后使用curl来测试本地访问：

root@7d93de07bf76:/# service apache2 start

配合使用-p参数对外映射服务端口，可以允许外来容器访问该服务。



### CentOS/Fedora

**1.CentOS系统简介及使用**

CentOS和Fedora都是基于Redhat的常见Linux分支。CentOS是目前企业级服务器的常用操作系统；Fedora则主要面向个人桌面用户。

CentOS（Community Enterprise Operating System，社区企业操作系统）是基于Red Hat Enterprise Linux源代码编译而成的。由于CentOS与Redhat Linux源于相同的代码基础，所以很多成本敏感且需要高稳定性的公司就使用CentOS来替代商业版Red Hat Enterprise Linux。CentOS自身不包含闭源软件。

在Docker Hub上使用docker search命令来搜索标星至少为25的CentOS相关镜像，如下所示：

$ docker search -f stars=25 centos

NAME   DESCRIPTION   STARS   OFFICIAL  AUTOMATED

centos  The official... 2543   [OK]

jdeathe/centos-ssh     27    [OK]

使用docker run直接运行最新的CentOS镜像，并登录bash：

$ docker run -it centos bash

[root@43eb3b194d48 /]# cat /etc/redhat-release

CentOS Linux release 7.2.1511 (Core)

**2.Fedora系统简介及使用**

Fedora是由Fedora Project社区开发，红帽公司赞助的Linux发行版。它的目标是创建一套新颖、多功能并且自由和开源的操作系统。对用户而言，Fedora是一套功能完备的、可以更新的免费操作系统，而对赞助商Red Hat而言，它是许多新技术的测试平台，被认为可用的技术最终会加入到Red Hat Enterprise Linux中。

在Docker Hub上使用docker search命令来搜索标星至少为2的Fedora相关镜像，结果如下：

$ docker search -f stars=2 fedora

NAME          DESCRIPTION              STARS OFFICIALAUTOMATED

fedora         Official Docker builds of Fedora   433   [OK]

使用docker run命令直接运行Fedora官方镜像，并登录bash：

$ docker run -it fedora bash

[root@196ca341419b /]# cat /etc/redhat-release

Fedora release 24 (Twenty Four)

 

[回到顶部](https://www.cnblogs.com/wade-luffy/p/6548164.html#_labelTop)

## 总结意见

在Docker Hub上还有许多第三方组织或个人上传的Docker镜像。可以根据具体情况来选择。一般来说注意如下几点：

1. 官方镜像体积都比较小，只带有一些基本的组件。精简的系统有利于安全、稳定和高效运行，也适合进行定制。
2. 个别第三方镜像（如tutum，已被Docker收购）质量也非常高。这些镜像通常针对某个具体应用进行配置，比如，包含LAMP组件的Ubuntu镜像。
3. 出于安全考虑，几乎所有官方制作的镜像都没有安装SSH服务，无法使用用户名和密码直接登录。