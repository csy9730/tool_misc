# [编写自己的 GitHub Action，体验自动化部署](https://www.cnblogs.com/zkqiang/p/12217522.html)



> 本文将介绍如何使用 GitHub Actions 部署前端静态页面，以及如何自己创建一个 Docker 容器 Action。

## 简介 Actions

GitHub Actions 是 GitHub 官方推出的持续集成/部署模块服务（CI/CD），和 jenkins、Travis CI 是同一类产品定位。

但 Actions 的最大优势，就是它是与 GitHub 高度整合的，只需一个配置文件即可自动开启服务。甚至你不需要购买服务器 —— GitHub Actions 自带云环境运行，包括私有仓库也可以享用，而且云环境性能也十分强劲。

当然这也意味着项目必须存放在 GitHub 才能享受这项服务。如果你的 GitHub 上有一些项目需要部署，那不妨把构建、上传等工作放到 Actions 里。比如最近我有个前端项目需要打包成静态文件，然后上传到腾讯云 COS 里，这是典型的自动化部署应用场景，我们可以借助 Actions 实现一劳永逸。

## 配置 workflow

前文说到，开启 GitHub Actions 只需一个配置文件，这个文件就是 workflow（工作流），它需要存在仓库目录下 `.github/workflows/*.yml`，文件名任意，但需要是一个 YAML 配置文件。

这个文件用来规定自动化操作在什么时候触发启动，然后需要做哪些事情，比如这样：

```yaml
name: Deploy

on:
  push:
    branches:
      - master

jobs:
  build:
    runs-on: ubuntu-latest

    steps:
      - name: Checkout master
        uses: actions/checkout@v2
        with:
          ref: master

      - name: Setup node
        uses: actions/setup-node@v1
        with:
          node-version: "10.x"

      - name: Build project
        run: yarn && yarn build

      - name: Upload COS
        uses: zkqiang/tencent-cos-action@master
        with:
          args: delete -r -f / && upload -r ./dist/ /
          secret_id: ${{ secrets.SECRET_ID }}
          secret_key: ${{ secrets.SECRET_KEY }}
          bucket: ${{ secrets.BUCKET }}
          region: ap-shanghai
```

首先配置里所有 `name` 都是可以自定义的，只是用于可视化中进行识别。

`on`: 用来指定启动触发的事件，`push` 则表示在监听到 `git push` 到指定分支时触发。如此之外还可以是 `pull_request`。

`jobs`: 是工作任务，可以包含多个 job，并且每个 job 是独立的虚拟环境。不同 job 之间默认是并行的，如果想顺序执行，可以这样 `build-job: needs: test-job`。

`runs-on`: 用来指定执行系统环境，不仅有常用的 Linux 发行版，还可以是 macOS 或 Windows。

`steps`: 表示每个 job 需要执行的步骤，比如这里我分成了四步：拉取分支 → 安装 Node 环境 → 构建项目 → 上传 COS。

`uses`: 指的是这一步骤需要先调用哪个 Action。

Action 是组成工作流最核心最基础的元素。每个 Action 可以看作封装的独立脚本，有自己的操作逻辑，我们只需要 `uses` 并通过 `with` 传入参数即可。

比如 `actions/checkout@v2` 就是官方社区贡献的用来拉取仓库分支的 Action，你不需要考虑安装 git 命令工具，只需要把分支参数传入即可。

更多 Action 你可以通过 GitHub 顶部的 Marketplace 里找到，不过问题来了，我在其中搜索腾讯 COS 并没有找到相关 Action。

腾讯官方提供了 `coscmd` 命令行工具，是基于 Python 开发，很可惜没有二进制版本。因此如果使用在 Actions 中，就必须有 Python 环境，有两种思路：

1. 在 Steps 里加入 `actions/setup-python` 这一步骤安装 Python 环境，然后再使用 `pip install coscmd`；
2. 将上面的步骤封装成独立的 Action，之后直接 `uses` 即可。

第一种很简单，可以在 steps 里加入：

```yaml
steps:
- uses: actions/setup-python@v1
  with:
    python-version: '3.x'
    architecture: 'x64'

- name: Install coscmd
  run: pip install -U coscmd

- name: Upload COS
  run: |
    coscmd config ....
    coscmd upload -r ./dist/ /
```

但是我选择了第二种，顺便了解如何创建自己的 Action。

## 创建 Docker 容器 Action

官方提供了两种方式创建 Action，一种是使用 JavaScript 环境创建，另一种是通过 Docker 容器创建。`coscmd` 既然依赖 Python，这里使用 Docker 容器更简单一些。

### 创建 Dockerfile

那我们首先创建一个 Dockerfile:

```dockerfile
FROM python:3.7-slim

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

RUN pip install --upgrade --no-cache-dir coscmd

COPY "entrypoint.sh" "/entrypoint.sh"
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
```

如果不了解 Docker 也没关系，只需要知道 `FROM` 是指定容器环境，然后 `RUN` 去执行 `pip install coscmd` 的操作。最后将仓库目录下的 `entrypoint.sh` 拷贝到容器中，并用 `ENTRYPOINT` 执行，至于这个 sh 文件后面再说 。

### 创建 action.yml

这里定义了 Action 相关的配置：

```yaml
name: 'Tencent COS Action'
description: 'GitHub Action for Tencent COS Command'
author: 'zkqiang <zkqiang@126.com>'
branding:
  icon: 'cloud'
  color: 'blue'
inputs:
  args:
    description: 'COSCMD args'
    required: true
  secret_id:
    description: 'Tencent cloud SecretId'
    required: true
  secret_key:
    description: 'Tencent cloud SecretKey'
    required: true
  bucket:
    description: 'COS bucket name'
    required: true
  region:
    description: 'COS bucket region'
    required: true
runs:
  using: 'docker'
  image: 'Dockerfile'
```

除了一些描述性信息，最重要的是定义 `input: args` 输入参数，也就是 step 里 `with` 传递的参数，可以通过 `required` 设置该参数是否必传。这里传递的参数都是识别和验证对象桶的必需参数。

最后通过 `runs` 指定 docker 环境和 `Dockerfile` 文件。

### 创建 entrypoint.sh

这里需要使用 shell 来写传递参数后的执行逻辑，由于 `coscmd` 本身就是命令行工具，所以我们只需将参数再传给它即可。

```sh
#!/bin/bash

set -e

if [ -z "$INPUT_ARGS" ]; then
  echo 'Required Args parameter'
  exit 1
fi

# ...省略部分代码

coscmd config -a $INPUT_SECRET_ID -s $INPUT_SECRET_KEY -b $INPUT_BUCKET -r $INPUT_REGION -m $THREAD

IFS="&&"
arrARGS=($INPUT_ARGS)

for each in ${arrARGS[@]}
do
  unset IFS
  each=$(echo ${each} | xargs)
  if [ -n "$each" ]; then
  echo "Running command: coscmd ${each}"
  coscmd $each
  fi
done
```

`action.yml` 中的参数会自动转成 `INPUT_` 前缀并且大写的变量传入，因此我们可以直接引用。

验证完参数之后（也可省略，`action.yml` 已判断），先配置 `coscmd config`，然后将 args 参数传入 `coscmd` 即可。另外为了方便使用多条命令，加入了支持 `&&` 连接命令，脚本里需要对其分割。

## 调用自建的 Action

将刚才创建的 Action 推送到 GitHub 上，就调用这个 Action 了，前文的 workflow 配置里也已经包含了：

```yaml
name: Upload COS
uses: zkqiang/tencent-cos-action@master
with:
  args: delete -r / && upload -r ./dist/ /
  secretId: ${{ secrets.SECRET_ID }}
  secretKey: ${{ secrets.SECRET_KEY }}
  bucket: ${{ secrets.BUCKET }}
  region: ap-shanghai
```

`args: delete -r -f / && upload -r ./dist/ /`，相当于先清空对象桶，然后再执行上传。`delete` 和 `upload` 都是 `coscmd` 自己的命令参数，其他命令可以查阅官方文档。

另外有没有注意到 `${{ secrets.XXX }}` 这种参数，并不是具体的值，而是调用了 GitHub Settings 里保存的 secrets，添加方式如下：

![img](https://img2018.cnblogs.com/blog/1627229/202001/1627229-20200120125521965-2108634090.png)

为什么这样做？是因为 workflow 代码在公开仓库中也是任意可见的，如果将 SecretKey 这些信息暴露，等于将 COS 操作权限交出，而存在 settings 里则不会有这个问题。

然后就可以使用 Actions 功能了，向包含 workflow 的仓库 master 分支推送一次代码，如果没有配错的话，过段时间可以在 Actions 栏里看到一列绿色的对号。

![img](https://img2018.cnblogs.com/blog/1627229/202001/1627229-20200120125531732-47426629.png)

## 结语

至此我们了解了如何使用 GitHub Actions 部署，以及如何自己创建一个 Action，可见这一项免费的服务真的非常好用，借助 Action 开源市场也可以大幅简化使用。

当然 CI 的应用不仅仅在部署这方面，绝大部分从开发完成到交付/部署之间的动作也都可以用自动化完成，只要是重复的操作就应该考虑能不能加入自动化来解放双手。

本文 COS Action 的[代码仓库](https://github.com/zkqiang/tencent-cos-action)。

[workflow 官方文档](https://help.github.com/cn/actions/automating-your-workflow-with-github-actions/workflow-syntax-for-github-actions#)

更多的 Actions 可以从 [Marketplace](https://github.com/marketplace) 和 [awesome-actions](https://github.com/sdras/awesome-actions) 里获取。