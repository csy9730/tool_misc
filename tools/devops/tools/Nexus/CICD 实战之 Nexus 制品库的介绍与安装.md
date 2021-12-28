# CICD 实战之 Nexus 制品库的介绍与安装

 发表于 2020-08-08 更新于 2021-12-26 阅读次数： 241 Valine： [0](https://kitety.github.io/posts/introduction-and-installation-of-nexus-product-library-cicd-actual-combat.html#valine-comments)

 本文字数： 2k 阅读时长 ≈ 2 分钟

## 目的

学习 Nexus 制品库的介绍与安装

## 介绍

在前面我们写到，制品库是**承接 CI 构建后的产出制品的仓库**，具有版本管理，历史管理，权限校验等功能。

在这里，我们选用 Nexus3 作为制品库。



## 正式开始

### 拉取镜像

```
docker pull sonatype/nexus3
```

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931105737-image.png)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931105737-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931105737-image.png)



### 启动容器

新建一个名为 nexus 的文件夹，方便我们存放 Nexus 相关数据，并赋予权限。

```
mkdir /home/nexus && chown -R 200 /home/nexus
```

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931112564-image.png)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931112564-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931112564-image.png)



#### 创建容器

```
docker run -d -p 8081:8081 -p 8082:8082 \
--name nexus \
-v /home/nexus:/nexus-data \
--restart always \
sonatype/nexus3
```

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931118609-image.png)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931118609-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931118609-image.png)



- Nexus 主服务端口，我们设置为 8081,；但是还需要新分配一个端口为服务端口，这里采用的是 8082

#### 防火墙

将对应端口添加到防火墙

```
firewall-cmd --zone=public --add-port=8081/tcp --permanent
firewall-cmd --zone=public --add-port=8082/tcp --permanent
systemctl reload firewalld
```

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931126380-image.png)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931126380-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931126380-image.png)



### 访问 Nexus

打开浏览器地址栏，访问 Nexus 的服务地址，这里是 ip:8001。启动时间比较长，可以使用 `docker logs -f nexus` 查看日志，如果显示以下文字 **Started Sonatype Nexus OSS 3.25.1-04** 就代表成功

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931136526-image.png)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931136526-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931136526-image.png)



### 配置 Nexus

我们访问 `ip:8001` 就可以看到界面了。

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931149190-image.png)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931149190-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931149190-image.png)



#### 登录

我们可以使用`默认账号:admin` 登录，默认的密码在 `cat /home/nexus/admin.password` 可以查看。

注意不包含 #号

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931157535-image.png)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931157535-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931157535-image.png)



当我们初次进入之后会让我们设置一下初始密码，和登录的权限。

#### 匿名访问性

设置密码之后需要设置访问性，**我们在任何没有登录的情况下，拉取（推送）制品到制品库，都算匿名访问。**, 在实际生产中是**不安全**的，我们测试可以开启。

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/img/giphy.gif)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931164943-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931164943-image.png)



#### 创建一个 Docker 私服

点击设置，选择左侧菜单中的 Repositories ，点击 Create repository

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/img/giphy.gif)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931174237-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931174237-image.png)



使用搜索 docker 可以快速定位

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931182519-image.png)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931182519-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931182519-image.png)



**制品库的类型**

- proxy: 此类型制品库原则上 “只下载，不允许用户推送”。可以理解为缓存外网制品的制品库。例如，我们在拉取 nginx 镜像时，如果通过 proxy 类型的制品库，则它会去创建时配置好的外网 docker 镜像源拉取（有点像 cnpm）到自己的制品库，然后给你。第二次拉取，则不会下载。起到 缓存 的作用。
- hosted：此类型制品库和 proxy 相反，原则上 **只允许用户推送，不允许缓存 。**这是私有库的核心，只存放自己的私有镜像或制品。
- group：此类型制品库用作以上两种类型的 ** 集合 **，将上面两个库集合为一个使用。

这里我们采用 hosted 类型，点击创建会看到一些输入框，这里做简单的解释。

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931190366-image.png)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931190366-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931190366-image.png)



同时我们还要设置一下权限，在 Security-Realms 的 Docker Bearer Token Realm 选择到右边的激活状态。

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931200624-image.png)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931200624-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931200624-image.png)



### 小试牛刀 - 登录

安装至此，我们在另一台机器上试一下。

在这里，我的架构是两台虚拟机，一台是 gitlab 和 jenkins，一台是 nginx 和 Nexus。所以，我们就在 gitlab 的机器上尝试。

#### 配置文件

我们在 gitlab 配置文件，`vim /etc/docker/daemon.json`

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/img/giphy.gif)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931210306-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931210306-image.png)



```
"insecure-registries" : [
    "192.168.182.4:8082"
  ]
```

最后记得使用 `systemctl restart docker` 重启一下
**注意这里是 json 格式，格式不能错**

#### 登录

登录一下。从图中可以看出。初次登录需要输入账号密码，后续登录就不需要了。

```
docker login 服务IP:端口
```

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/img/giphy.gif)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931223439-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931223439-image.png)



### 小试牛刀 - 推送镜像到制品库

我们可以使用 docker push 推送镜像到私服上面。

docker 在推送一个镜像时，镜像的 Tag (名称：版本号) 必须开头带着镜像库的地址，才可以推送。例如下面两个镜像：
😡 local/jenkins 不能推送
😃 **192.168.182.4:8082/local/jenkins** 可以推送。

#### 制作镜像

\1. 制作一份带镜像库地址的镜像：这个可以做，但是开销太大，需要走一遍制作流程

\2. 使用 docker tag 命令给已有的镜像打个标签：推荐使用，会将已有的镜像归位某个镜像库内。

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/img/giphy.gif)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931234544-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931234544-image.png)



```
docker tag 28c624ccaacf    192.168.182.4:8082/local/jenkins
```

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/img/giphy.gif)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931242511-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931242511-image.png)



#### 推送

```
docker push 192.168.182.4:8082/local/jenkins
```

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/img/giphy.gif)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931252036-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931252036-image.png)



在仓库可以看到上传的

[![image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931260957-image.png)](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931260957-image.png)

[image](https://cdn.jsdelivr.net/gh/kitety/blog_img@master/2020-9-24/1600931260957-image.png)



## 结语

我们在这部分实现了 docker 私服的搭建和 push，接下来我们将构建代码并且推送到私服。敬请期待吧！



你有多久没有爱我了？

- **本文作者：** kitety
- **本文链接：** <https://kitety.github.io/posts/introduction-and-installation-of-nexus-product-library-cicd-actual-combat.html>
- **版权声明：** 本博客所有文章除特别声明外，均采用 [BY-NC-SA](https://creativecommons.org/licenses/by-nc-sa/4.0/) 许可协议。转载请注明出处！