# 使用Docker+Gitea搭建自己的代码托管工具

[服务器](https://codebays.com/category/server) · 2019-10-11 · 2122 次浏览

一个开发团队中，代码托管是刚需，甚至对于个人开发者来说也是刚需。

有些团队出于各种原因会选择各式各样的代码托管平台，如: [GitHub](https://github.com/)、[码云](https://gitee.com/)、[GitLab](https://gitlab.com/explore)等。

还有些团队为了保护私有代码的安全，会自行在公司内网搭建代码管理平台，此时选择的方案比较多，如GitLab CE、Gitea、Gogs等开源软件。

市面上那么多开源的Git代码托管软件，那么我们应该如何选择呢？Gitea官方文档中有一篇文章专门对比了一些常用的Git代码托管软件的特性，感兴趣的同学可以前往查看一下。【[传送门](https://docs.gitea.io/en-us/comparison/)】

一个最简单的选择方法就是：GitLab CE版本功能强大，包括CI/CD工具，但是特别消耗内存；Gitea虽然不包括内建的CI/CD，但是由于对内存的消耗比GitLab小太多了。

本文主要介绍的就是使用Docker来安装和部署Gitea。GitLab的安装，点击前往《[使用DOCKER来将群晖NAS打造成私有GITLAB服务器](https://www.codebays.com/tools/synology/104.html)》

------

## 环境

```
    CentOS7
    Docker
```

## 部署流程

- 安装Docker

```
    yum install -y docker docker-compose
    systemctl enable docker && systemctl start docker
```

- 更改Docker镜像源为【[阿里云容器镜像服务](https://cr.console.aliyun.com/)】

```
    mkdir -p /etc/docker
    echo '{
      "registry-mirrors": ["替换成你自己的镜像加速地址"]
    }' > /etc/docker/daemon.json

    systemctl daemon-reload && systemctl restart docker
```

- 创建存放数据的卷目录

```
    mkdir -p /volumes/gitea && chown -R 1000:1000 /volumes/gitea
    mkdir -p /volumes/gitea-db
```

- 编写docker-compose.yml内容如下

```
version: "2"
networks:
  gitea:
    external: false
services:
  db:
    image: mysql:5.7
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=gitea
      - MYSQL_USER=gitea
      - MYSQL_PASSWORD=gitea
      - MYSQL_DATABASE=gitea
    networks:
      - gitea
    volumes:
      - /volumes/gitea-db:/var/lib/mysql
  gitea:
    image: gitea/gitea:latest
    restart: always
    environment:
      - TZ=Asia/Shanghai
      - USER_UID=1000
      - USER_GID=1000
      - DB_TYPE=mysql
      - DB_HOST=db:3306
      - DB_NAME=gitea
      - DB_USER=gitea
      - DB_PASSWD=gitea
      - LFS_START_SERVER=true
      - DISABLE_SSH=true
      - RUN_MODE=prod
      - APP_NAME=代码托管
    networks:
      - gitea
    volumes:
      - /etc/localtime:/etc/localtime
      - /volumes/gitea:/data
    ports:
      - "13000:3000"
    depends_on:
      - db
```

- 启动容器（进入包含docker-compose.yml文件的目录运行）

```
    docker-compose up -d # 启动容器
    docker-compose ps # 显示已启动的容器
    docker-composer down # 关闭并删除容器
```

- 初始化设置(注：若机器在阿里云上，则需要安全组中将13000端口开放)

```
    浏览器中输入：http://IP地址:13000/install
```

## 官方体验地址

```
    https://try.gitea.io
```

## Gitea官方手册

```
    https://docs.gitea.io/en-us/install-with-docker/
```