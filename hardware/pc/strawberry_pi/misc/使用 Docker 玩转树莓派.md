# 使用 Docker 玩转树莓派

[![Sundway Sun](https://pic3.zhimg.com/1f5ffb54f5829249e868fdae8b2e21e8_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/sundway)

[Sundway Sun](https://www.zhihu.com/people/sundway)

less is more...



69 人赞同了该文章

我将本指南放在一起，以帮助你使用 Raspberry Pi 上的Docker 1.12（或更新版本）。为了简单起见，我们将使用默认的操作系统为Pi - 称为Raspbian。本指南目前适用于大多数型号的 Raspberry Pi，我建议使用 B 2/3 型或零型。

![img](https://pic2.zhimg.com/80/v2-77bd620b3bf49cc65aea878b3cf54941_1440w.jpg)



现在不知道 Docker 是什么或者可以做什么？可以从[官方文档](https://link.zhihu.com/?target=https%3A//docs.docker.com/engine/understanding-docker/)了解 Docker。

## 准备好在你的树莓派上使用 Docker 了吗？

如果你已经准备好了，可以直接跳过 [Live Swarm Deep Dive](https://link.zhihu.com/?target=https%3A//blog.alexellis.io/live-deep-dive-pi-swarm/), 我们将多个Raspberry Pis连接在一起，创建一个 Docker Swarm。

## 准备SD卡

从 [https://www.raspberrypi.org/downloads/raspbian/](https://link.zhihu.com/?target=https%3A//www.raspberrypi.org/downloads/raspbian/) 下载最新的 Raspbian Jessie Lite 镜像。

> Raspbian Jessie Lite 镜像与常规镜像相同，但仅包含最少的最小数量的包。

我曾经给出在 Mac 和 Linux 上使用 dd 的说明，第三个选项是Windows。现在我推荐 [http://Etcher.io](https://link.zhihu.com/?target=http%3A//Etcher.io) ，它将以与你在PC /笔记本电脑上使用的操作系统相同的方式使用闪存 SD 卡。

在这里下载 [Etcher](https://link.zhihu.com/?target=https%3A//etcher.io/)。

现在按照 Etcher 中的说明刷新 SD 卡。在弹出 SD 卡之前还需要做一件事。



![img](https://pic1.zhimg.com/80/v2-45e142cf71f5d22466e94f373f8e7ca8_1440w.jpg)



为了防止全球范围内的 Raspberry Pis 被黑客入侵，RPI 基金会现在已经在镜像中默认禁用了 SSH。只需在/ boot / ssh 中创建一个文本文件，可以是空白的，或者你可以在其中输入任何内容。

确保它没有扩展名，如 ssh.txt - 它必须只是 ssh。

现在插入SD卡，网络和电源等

## 安装 Docker

一旦您启动了 Raspberry Pi，您将能够通过 bonjour / avahi 服务在网络上找到它。

## 用 SSH 连接

```text
ssh pi@raspberrypi.local
```

密码是 raspberry.

出于安全考虑，建议使用 passwd 命令更改用户 pi 的密码。

## 可选自定义

此时您可能需要编辑 Pi 的主机名。使用编辑器，在下面文件中将 raspberrypi 这个词改为其他的词：

- /etc/hosts
- /etc/hostname

如果您将 Pi 用于无头应用程序，则可以将 GPU 与系统其余部分之间的内存分配减少到 16mb。

编辑 /boot/config.txt 并添加以下行：

```text
gpu_mem=16  
```

## 启动 Docker 安装程序

由 Docker 项目维护的自动脚本将创建一个 systemd 服务文件，并将相关的 Docker 二进制文件复制到 /usr/bin/ 中。

```text
curl -sSL https://get.docker.com | sh
```

直到最近在 Pi 上安装 Docker 是一个非常手动的过程，通常意味着不得不在非常低功耗的设备上从头构建 Docker（这可能需要几个小时）。ARM 爱好者们的辛勤工作 Hipriot 已经帮助 .deb 在 Docker 自己的 CI 进程中成为一流的公民。

如果您想选择使用测试版本，请将 [http://test.docker.com](https://link.zhihu.com/?target=http%3A//test.docker.com) 替换为 [http://get.docker.com](https://link.zhihu.com/?target=http%3A//get.docker.com)。这将会降低一个较新的版本，但仍可能会出现一些与之相关的开放问题。

> 请注意，此工作不会扩展到非 Debian 发行版，例如 Arch Linux 或 Fedora。 Arch Linux for ARM 目前在其包管理器 pacman 中提供了 Docker 1.11。

## 配置 Docker

需要几个手动步骤才能获得最佳体验。

## 将 Docker 设置为自动启动。

```text
sudo systemctl enable docker
```

您现在可以重新启动 Pi，或者通过以下方式启动 Docker 守护程序：

```text
$ sudo systemctl start docker
```

## 启用 Docker 客户端

Docker 客户端只能由 root 或 docker 组的成员使用。将 pi 或您的等效用户添加到 docker 组：

```text
$ sudo usermod -aG docker pi
```

进行此更改后，注销并重新连接到 ssh。

## 使用 Docker

支持 ARM 和 Raspberry Pi 是一项正在进行的项目，这意味着你应该知道几件事情。

## 从 Hub 中拉取镜像

如果从 Docker 集线器下拉 busybox 镜像，它将无法正常工作。这是因为内容是为常规 PC 或 x86_64 架构设计的。在将来版本的 Docker 中，正在为此修复此问题。

我们应该只尝试使用我们知道设计为在 ARM 上工作的镜像。目前没有严格的官方镜像，但 Docker 团队在前缀 [arm32v6](https://link.zhihu.com/?target=https%3A//hub.docker.com/r/arm32v6) 下维护了一些实验镜像。

> 2017年5月30日更新：armhf 帐户已重命名为a rm32v6，因此以后参考使用 arm32v6 前缀。

## 运行你的第一个 ARM 镜像

我们来试试 Docker 的官方 Alpine Linux 镜像 arm32v6 / alpine。 Alpine Linux 是一个非常紧凑的 1.8MB 下载。

```text
$ docker run -ti arm32v6/alpine:3.5 /bin/sh

/ # cat /etc/os-release 
NAME="Alpine Linux"  
ID=alpine  
VERSION_ID=3.5.2  
PRETTY_NAME="Alpine Linux v3.5"  
HOME_URL="http://alpinelinux.org"  
BUG_REPORT_URL="http://bugs.alpinelinux.org"

/ # echo "Hi, this is a tiny Linux distribution!" | base64 
SGksIHRoaXMgaXMgYSB0aW55IExpbnV4IGRpc3RyaWJ1dGlvbiEK

/ # echo "SGksIHRoaXMgaXMgYSB0aW55IExpbnV4IGRpc3RyaWJ1dGlvbiEK" | base64 -d
Hi, this is a tiny Linux distribution!

/ # exit
```

完成后，尝试镜像并键入 exit。

我们推出了一个 BusyBox shell，但是我们可以直接启动任何命令。

这是另一个例子，没有使用 shell - 我们只是直接运行 date binary：

```text
$ docker run arm32v6/alpine:3.5 date
Sun Mar 12 21:00:45 UTC 2017  
```

## 其他基本镜像

由 [Resin.io](https://link.zhihu.com/?target=http%3A//resin.io/) 制作的镜像由[当前的 Docker](https://link.zhihu.com/?target=https%3A//github.com/docker/docker/blob/master/contrib/builder/deb/armhf/raspbian-jessie/Dockerfile) 构建过程用于创建一个可用于所有支持的 Raspberry Pi 版本的基本镜像。它是一个轻量级的 Raspbian Jessie，这使它成为一个不错的选择。

## 构建一个新的镜像

像普通的 Docker 镜像一样构建你的镜像，但使用 resin/ rpi-raspbian 作为您的基础。我们添加 curl 和 ca 证书，并创建一个可以访问 [http://docker.com](https://link.zhihu.com/?target=http%3A//docker.com) 的镜像。

```text
FROM resin/rpi-raspbian:latest  
ENTRYPOINT []

RUN apt-get update && \  
    apt-get -qy install curl ca-certificates

CMD ["curl", "https://docker.com"]  
```

逐行细分:

- FROM - 此语句是文件中的第一个，并选择开始进行更改的基本系统
- ENTRYPOINT [] - Resin 镜像具有预定义的启动指令，因此此行取消了允许我们使用我们自己的。
- 以 RUN 为前缀的每个步骤都由 bash 执行。所以这里我们安装 curl 和普通的 SSL 证书
- 这是容器的启动命令，它由 docker 运行调用

所以构建这样的镜像，然后运行它：

```text
$ docker build -t curl_docker .
$ docker run curl_docker
```

使用 Docker 构建镜像后，你将在库中看到它。使用 docker images 命令可以查看到目前为止所建立的所有镜像。

如果要删除 curl_docker 镜像类型，请执行以下操作：docker rmi curl_docker。

## 与 Alpine Linux 相同

Alpine Linux 不使用 apt-get 打包它的包，而是一个名为 apk 的工具，这里是如何实现同样的事情：

```text
FROM arm32v6/alpine:3.5

RUN apk add --no-cache curl ca-certificates

CMD ["curl", "https://docker.com"]  
```

要构建和运行 Alpine 容器，你可以做完全相同的事情或使用不同的镜像名称：

```text
$ docker build -t curl_docker_alpine .

Sending build context to Docker daemon 2.048 kB  
Step 1/3 : FROM arm32v6/alpine:3.5  
 ---> 4c5b559db95b
Step 2/3 : RUN apk add --no-cache curl ca-certificates  
 ---> Running in 68254b2889a0
fetch http://dl-cdn.alpinelinux.org/alpine/v3.5/main/armhf/APKINDEX.tar.gz  
fetch http://dl-cdn.alpinelinux.org/alpine/v3.5/community/armhf/APKINDEX.tar.gz  
(1/4) Installing ca-certificates (20161130-r0)
(2/4) Installing libssh2 (1.7.0-r2)
(3/4) Installing libcurl (7.52.1-r2)
(4/4) Installing curl (7.52.1-r2)
Executing busybox-1.25.1-r0.trigger  
Executing ca-certificates-20161130-r0.trigger  
OK: 4 MiB in 15 packages  
 ---> ecd945783503
Removing intermediate container 68254b2889a0  
Step 3/3 : CMD curl https://docker.com  
 ---> Running in ed6a0a7afcef
 ---> c911937ccb69
Removing intermediate container ed6a0a7afcef  
Successfully built c911937ccb69

$ docker run curl_docker_alpine
```

## 创建一个 Node.js 应用程序

这个 Docker文 件使用 [http://Resin.io](https://link.zhihu.com/?target=http%3A//Resin.io) 的 Raspbian 镜像作为基础，并从 Node.js 站点下拉 Node 4.5 LTS。

```text
FROM resin/rpi-raspbian:latest  
ENTRYPOINT []

RUN apt-get update && \  
    apt-get -qy install curl \
                build-essential python \
                ca-certificates
WORKDIR /root/  
RUN curl -O \  
  https://nodejs.org/dist/v4.5.0/node-v4.5.0-linux-armv6l.tar.gz
RUN tar -xvf node-*.tar.gz -C /usr/local \  
  --strip-components=1

CMD ["node"]  
```

## 构建和运行镜像

```text
$ docker build -t node:arm .
$ docker run -ti node:arm
>
```

您现在可以测试一些 Node.js 指令，或者在 Github 上分配我的简单的 hello-world 微服务器来进一步。

```text
> process.version
'v4.5.0'  
> var fs = require('fs');
> console.log(fs.readFileSync("/etc/hosts", "utf8"));
> process.exit()
$ 
```

## 使用 GPIO

为了使用额外的硬件和附加板，您需要访问 GPIO引 脚。这些需要在 --privileged 的运行时附加标志，以允许容器写入管理 GPIO 的内存的特殊区域。

标准的 RPi.GPIO 库将通过 Docker 进行工作，包括几个硬件制造商的库。

这是一个使用d efacto RPi.GPIO 库的 Docker 文件示例。

```text
FROM resin/rpi-raspbian:latest  
ENTRYPOINT []

RUN apt-get -q update && \  
    apt-get -qy install \
        python python-pip \
        python-dev python-pip gcc make  

RUN pip install rpi.gpio 
```

构建此镜像作为以后添加 GPIO 脚本的基础。

```text
$ docker build -t gpio-base .
```

可以使用以下 Python 代码将闪烁连接到 GPIO 引脚18的 LED。

```text
import RPi.GPIO as GPIO  
import time  
GPIO.setmode(GPIO.BCM)  
led_pin = 17  
GPIO.setup(led_pin, GPIO.OUT)

while(True):  
    GPIO.output(led_pin, GPIO.HIGH)
    time.sleep(1)
    GPIO.output(led_pin, GPIO.LOW)
    time.sleep(1)
```



![img](https://pic1.zhimg.com/80/v2-f3fc7126878b4b9116c219108b36fa94_1440w.png)



只需使用 ADD 将脚本传输到从 gpio-base 中传输到新映像：

```text
FROM gpio-base:latest  
ADD ./app.py ./app.py

CMD ["python", "app.py"]  
```

您需要以 --privileged 模式运行此容器才能访问 GPIO 引脚

```text
$ docker build -t blink .
$ docker run -ti --privileged blink
```

如果你喜欢，那么如何使一个启用互联网的蜂鸣器或 cheerlight？以下是使用 Python Flask 库创建控制 GPIO 引脚的 Web 服务器的示例：

> [Github：Docker中的GPIO Web服务器](https://link.zhihu.com/?target=https%3A//github.com/alexellis/pizero-docker-demo/tree/master/iotnode)

更多关于与 GPIO 交互的 Raspberry Pi 基金会[入门物理计算工作表](https://link.zhihu.com/?target=https%3A//www.raspberrypi.org/learning/physical-computing-with-python/worksheet/)。

## 反馈和问题

通过 Twitter @alexellisuk 或下面的评论部分与我联系。你想在博客上看到什么？你试过了吗？让我们知道

> [http://Resin.io](https://link.zhihu.com/?target=http%3A//Resin.io)最近改变了他们的基本镜像，而不是使用resin/ rpi-raspbian：jessie 他们建议我们使用 resin / rpi-raspbian：jessie-20160831

参考：

- Star 或 fork 我的 [Docker-arm](https://link.zhihu.com/?target=https%3A//github.com/alexellis/docker-arm) repo 在 Github上 列出了有用的 Dockerfiles 和 Docker Swarm 的信息。
- [用 OTG 网络构建您的 Pi Zero Swarm](https://link.zhihu.com/?target=https%3A//blog.alexellis.io/pizero-otg-swarm/) - 看起来就像以太网一样！
- 托管系列 - [我如何在 Pi 上自主托管此博客](https://link.zhihu.com/?target=http%3A//blog.alexellis.io/tag/blog/)。

原文链接：[https://blog.alexellis.io/getting-started-with-docker-on-raspberry-pi/](https://link.zhihu.com/?target=https%3A//blog.alexellis.io/getting-started-with-docker-on-raspberry-pi/)

编辑于 2017-09-11 15:16

物联网

计算机

软件