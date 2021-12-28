# Drone CI：搭建自己CI/CD（一）

[![放不开的时光尾巴](https://pica.zhimg.com/v2-6c52363ac9672e36a3e2b4e15373d388_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/fang-bu-kai-de-shi-guang-wei-ba)

[放不开的时光尾巴](https://www.zhihu.com/people/fang-bu-kai-de-shi-guang-wei-ba)





13 人赞同了该文章

## CI篇：安装与配置

## CI/CD简介

`CI`全称为`Continuous Integration`，意为`持续集成`，是在源代码变更后自动检测、拉取、构建和进行自动化测试的过程，属于开发人员的自动化流程。该解决方案可以解决在一次开发中有太多应用分支，从而导致相互冲突的问题。其基本思路是，自动化监测代码仓库的变化并拉取最新代码、编译构建和自动化测试。`CI`的触发方式可分为以下三种： *轮询：按一定的时间间隔反复询问代码仓库是否发生了变更，若发生了变更则开启CI流程* 定时：定期从代码仓库拉去最新代码并进行构建与测试，不必关心是否有变更发生 * 推送：当代码仓库发生变更时，通过推送的方式(如`webhook`)通知`CI`进行任务，这需要`CI`环境被代码仓库访问到，因此需要一个外网可达地址

`CD`指的是`持续交付(Continuous Delivery)`或`持续部署(Continuous Deployment)`。`持续交付`通常是指开发人员对应用的更改会自动进行错误测试并上传到存储库（如 [GitHub](https://link.zhihu.com/?target=https%3A//redhatofficial.github.io/%23%21/main) 或容器注册表），然后由运维团队将其部署到实时生产环境中。`持续部署`指的是自动将开发人员的更改从存储库发布到生产环境，它以持续交付为基础，实现了管道后续阶段的自动化。 `CI/CD` 既可能仅指持续集成和持续交付构成的关联环节，也可以指持续集成、持续交付和持续部署这三项构成的关联环节。 请参考：[redhat：什么是CI/CD](https://link.zhihu.com/?target=https%3A//www.redhat.com/zh/topics/devops/what-is-ci-cd)

## Drone CI简介

[Drone CI](https://link.zhihu.com/?target=https%3A//drone.io/)官网说：

> Drone is a self-service Continuous Delivery platform for busy development teams. 相对于常见的`Jenkins`，选中 `Drone`的原因在于它非常简洁，不像`Jenkins`那样复杂，同时它拥有可以满足基本需求的能力，并且提供了许多实用的[插件](https://link.zhihu.com/?target=http%3A//plugins.drone.io/)，如`GitHub`，`Email`，`helm`，`微信`，`钉钉`等

![img](https://pic4.zhimg.com/80/v2-8395919351cdd678342d1da82b17262b_720w.jpg)

**需要注意的是，drone 0.8版本和0.1版本差别较大，本文使用1.0版本**

## 安装Drone CI - GitHub

[drone文档](https://link.zhihu.com/?target=https%3A//docs.drone.io/)给出了相对于不同git仓库和部署方式的方案，支持的git仓库有：

![img](https://pic4.zhimg.com/80/v2-3ea9bb6e0a2d9d712838f0d574245fc3_720w.jpg)

拿github来说，drone提供了以下部署方式：

![img](https://pic2.zhimg.com/80/v2-b880bbf785105cf01a3ea76803ba284d_720w.jpg)

本节给出对于**GitHub**的**单机**部署方案，对官方[部署方案](https://link.zhihu.com/?target=https%3A//docs.drone.io/installation/github/single-machine/)做了`docker-compose`方案的补充

### 设置GitHub OAuth Application

- 登陆你的github账户，在右上角点击个人头像，选择`Setting`，选择`Developer settings`，选择`OAuth Application`，选择新建一个application，如下图：

![img](https://pic3.zhimg.com/80/v2-f0c93fa35b043e8cabfbedbbbe83fbfe_720w.jpg)

- HomePage是DroneCI的访问地址，若是Drone由本地部署，那就可以设置为`http://127.0.0.1`
- Authorization callback URL是DoneCI的登陆地址，格式必须是`{{HomePage}}/login`，如`http://127.0.0.1/login`
- 创建成功以后，拿到`Client ID`和`Client Secret`

![img](https://pic3.zhimg.com/80/v2-254bcb2f5f30d978401e2691248e9ada_720w.jpg)

### 下载安装docker和docker-compose

[Docker安装文档](https://link.zhihu.com/?target=https%3A//docs.docker.com/install/)

### 下载drone docker

```bash
docker pull drone/drone:1.0.0-rc.6
```

### 启动drone server

docker 启动:

```text
docker run \  
--volume=/var/run/docker.sock:/var/run/docker.sock \
--volume=/var/lib/drone:/data \
--env=DRONE_GITHUB_SERVER=https://github.com \
--env=DRONE_GITHUB_CLIENT_ID={% your-github-client-id %} \
--env=DRONE_GITHUB_CLIENT_SECRET={% your-github-client-secret %} \
--env=DRONE_RUNNER_CAPACITY=2 \
--env=DRONE_SERVER_HOST={% your-drone-server-host %} \
--env=DRONE_SERVER_PROTO={% your-drone-server-protocol %} \
--env=DRONE_TLS_AUTOCERT=true \
--publish=80:80 \
--publish=443:443 \
--restart=always \
--detach=true \
--name=drone \
drone/drone:1.0.0-rc.6
```

- docker-compse 启动 上面的启动命令是`drone`官方文档的方案，下面给出我使用的`docker compose`的方法
- 创建`.env`文件，这是docker-compose启动时默认读取的文件，用来设置环境变量

```text
DRONE_SERVER_HOST=127.0.0.1     
DRONE_GITHUB_CLIENT_ID=XXXXXXXXXXXXXX     
DRONE_GITHUB_CLIENT_SECRET=XXXXXXXXXX     
DRONE_SERVER_PROTO=http     
DRONE_SECRET_SECRET=ci-drone
```

- 创建`docker-compose.yml`文件

```text
# drone server 部署     
version: "2"     
services:   
    drone-server:     
    image: drone/drone:1.0.0-rc.6    
    ports:      
      - 80:80       
      - 443:443     
    volumes:      
      - /var/run/docker.sock:/var/run/docker.sock      
      - /var/lib/drone:/data    
    restart: always    
    environment:      
      - DRONE_GITHUB_CLIENT_ID=${DRONE_GITHUB_CLIENT_ID}     
      - DRONE_GITHUB_CLIENT_SECRET=${DRONE_GITHUB_CLIENT_SECRET}      
      - DRONE_SERVER_PROTO=${DRONE_SERVER_PROTO}     
      - DRONE_SERVER_HOST=${DRONE_SERVER_HOST}     
      - DRONE_TLS_AUTOCERT=false     
      - DRONE_RUNNER_CAPACITY=8      
      - DRONE_DEBUG=false     
      - DRONE_LOGS_DEBUG=false      
      - DRONE_GIT_ALWAYS_AUTH=false     
      - DRONE_SECRET_SECRET=${DRONE_SECRET_SECRET}
```

- drone配置项说明

- - `DRONE_GITHUB_CLIENT_ID`: 在Github中创建`OAuth Application`时生成的`Client ID`
  - `DRONE_GITHUB_CLIENT_SECRET`: 在Github中创建`OAuth Application`时生成的`Client Secret`
  - `DRONE_SERVER_PROTO`: Drone提供服务的prototype，可选为`http`或`https`
  - `DRONE_SERVER_HOST`: Drone的server地址，设置为`127.0.0.1`作为本地地址，也可以设置为外部可访问的域名或IP地址
  - `DRONE_TLS_AUTOCERT`: 设置是否自动开启安全传输层协议，若设置为`true`，那么drone server proto会设置为使用`https`，`DRONE_SERVER_PROTO`设置为`http`也是无效
  - `DRONE_RUNNER_CAPACITY`: drone提供服务的最大并行度
  - `DRONE_SECRET_SECRET`: 可自由设置
  - Drone用到的端口号有：80和443

- 启动服务

```
docker-compose up
```

或者通过后台的方式运行：

```
docker-compose up -d
```

## 配置CI仓库

- 通过浏览器访问：[http://127.0.0.1](https://link.zhihu.com/?target=http%3A//127.0.0.1/) ，浏览器会重定向到github登陆认证页面

![img](https://pic3.zhimg.com/80/v2-9ac7d52a24f262cb9821cc5b1305e30e_720w.jpg)

使用github账户登陆之后，浏览器被重定向回drone，并被授权访问你的github仓库

![img](https://pic3.zhimg.com/80/v2-91fbbb8147ab6ad866524e929dd5eafe_720w.jpg)



- 选中你要配置的仓库，点击`ACTIVATE`按钮，进入`SETTINGS`卡片，点击`ACTIVATE`按钮开启这个仓库.开启之后可以设置`CI`任务的基本配置。用过`jenkins`的人会发现，这个页面显然简洁一点。 此时，github仓库中会添加一条*webhook*地址，当github仓库发生改变时会通过webhook通知drone server。 不过，问题是这个webhook地址是`DRONE_SERVER_HOST`，如果配置为`127.0.0.1`或外网不可达时，这个`webhook`地址github是访问不到的。不过这不影响`Cron Job`的触发。

- 配置里面有四个主要选项

- Main: 主要配置

- - `Project settings`：设置是否开启仓库保护，若开启，那么每次触发CI自动编译都需要仓库管理员手动确认
  - `Project visibilty`：设置仓库可见性，因为你设置的host地址所有人都可以访问到，并通过自己的github账户登陆，可见性可以保护你的仓库
  - `Configuration`：设置CI任务的yaml配置文件，这里面制定了CI的所有流程，一般放在仓库根目录下，名为`.drone.yaml`，稍后会详细说明

![img](https://pic1.zhimg.com/80/v2-1cd4c89be2135ec9357cdc02d401ad84_720w.jpg)



- Secrets： 如[Drone Secret文档](https://link.zhihu.com/?target=https%3A//docs.drone.io/user-guide/secrets/)中所说，不方便明文存储到代码仓库里的密码值，可以通过`Repository Secrets`，`Encrypted Secrets`和`External Secrets`来存储 这里的Secrets设置可以指定`Repository Secrets`，在`Secret Name`中指定密码名称，`Secret Value`中设置该值。`Allow Pull Requests`是指，当是`pull_request`请求时这个密钥是否可被使用，因为其他人可能会通过`pull request`来触发CI，造成安全隐患。

![img](https://pic1.zhimg.com/80/v2-67ebbc7d731f72fedc19350070bed5fc_720w.jpg)



在`.drone.yaml`中可以通过`from_secret`引用，如下面的`username`和`password`

```yaml
kind: pipeline
      name: default

      steps:
      - name: build
        image: alpine
        environment:
          USERNAME:
            from_secret: username
     PASSWORD:
          from_secret: password
```

- Cron Jobs：定时任务 这里可以通过任务名称，分支名称和时间指定**定期**的CI任务。前文提到，CI触发有三种规则`轮询`，`定期`和`推送`。 *注：但这里的**定期任务**稍微有点怪，**cron job**的执行逻辑是定期触发一次检查，事件是指定分支的最后一次事件，执行的pipline会**验证**trigger规则，不像是通常说的**定期任务**，也不能说是轮询，因为轮询是监测是否有新事件。*
- Badges：编译状态图标 这里提供了CI运行的状态图标，可以放到Git仓库里作为编译状态。不过Drone server的地址就不能简单的设置为`127.0.0.1`了，因为Github访问不到，需要一个外网IP或域名

## .drone.yaml文件声明CI过程

Drone通过Pipline的方式来声明CI的执行过程，如[文档](https://link.zhihu.com/?target=https%3A//docs.drone.io/user-guide/pipeline/)所示。

```yaml
kind: pipeline
name: api
steps:
  # api unit test
  - name: api-test
    image: node:11
    depends_on: [clone]
    commands:
      - cd ./api/
      - npm install --registry https://registry.npm.taobao.org
      - cd ./dgc_sdk && npm install --production
      - cd .. && npm run test
  # web lint
  - name: web-lint
    image: node:10.15.1
    depends_on: [clone]
    commands:
      - cd ./web
      - npm install --registry https://registry.npm.taobao.org
      - npm run lint
trigger:
  branch:
    - master
  event:
    - pull_request
    - push

#stream test
kind: pipeline
name: stream
steps:
  - name: stream test
    image: ccr.ccs.tencentyun.com/star/stream-test-base
    commands:
      - echo 'Hello!'
trigger:
  branch:
    - stream
  event:
        - pull_request
```

- steps指定CI执行的步骤，默认pipline或创建一个叫做`clone`的步骤，它是从git仓库克隆代码大步骤
- 多个step之间可以通过`depends_on`来指定执行顺序，比如先`clone`，后`build`，然后`deploy`
- 同一个`pipline`下的多steps之间默认是**串行**的，实现方式应该是下面的step`depends_on`紧邻的上一个step
- 多`pipline`之间是并行的，同一个`yaml`文件里使用`---`分割多个`pipline`的定义
- triggers是指在什么情况下才会执行ICI任务，比如只对`master`分支的`pull request`和`push`事件触发
- 在每一个`step`中，可以通过`Conditions`来指定在CI过程中是否执行该step，通过`when`关键字指定。`trriger`是指定`pipline`何时被执行，`condition`指定`pipline`中的`step`是否被执行，如：

```yaml
kind: pipeline
    name: default
    steps:
    - name: build
      image: golang
      commands:
      - go build
      - go test
      when:
        branch:
        - master
                - feature/*
```

## 配置完成

- 若是配置了`Cron Job`，那到到该时间点时，会触发CI的任务，此时`pipline`中的`trigger`规则会失效
- 配置Drone CI之后，Github的check功能也会被启用，对每一次`event`都会监控CI的状态

## 注：

- 使用Drone 1.0，与0.8版本差异较大
- 当`trigger`中指定`event`为`pull_request`时，使用的分支为`target branch`；当`trigger`中指定`event`为`tag`时，指定的`branch`规则是无效的
- `Project settings`设置为`Protected`后，每次CI任务都要手动确定
- 关于**gitlab**、**私有 docker 镜像**、**dns**设置，在下一篇继续说

## 参考链接

- [redhat：什么是CI/CD](https://link.zhihu.com/?target=https%3A//www.redhat.com/zh/topics/devops/what-is-ci-cd)
- [Drone文档](https://link.zhihu.com/?target=https%3A//docs.drone.io/)
- [Drone Pipline](https://link.zhihu.com/?target=https%3A//docs.drone.io/user-guide/pipeline/)
- [Drone插件](https://link.zhihu.com/?target=http%3A//plugins.drone.io/)

编辑于 2020-07-25 14:04

持续集成(CI)

持续部署(CD)

赞同 13

4 条评论

分享