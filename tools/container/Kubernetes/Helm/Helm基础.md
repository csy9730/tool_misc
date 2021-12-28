# Helm基础

[![蓝白狂想](https://pica.zhimg.com/v2-1f76860e168a6b4b01227155da0dc4f5_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/lan-bai-kuang-xiang)

[蓝白狂想](https://www.zhihu.com/people/lan-bai-kuang-xiang)







## 一、Helm是什么

Helm 是 Kubernetes 的包管理器，是查找、分享和使用软件构建 Kubernetes 的最优方式。Helm 帮助用户管理 Kubernetes 应用——Helm 图表，即使是最复杂的 Kubernetes 应用程序，都可以方便的定义，安装和升级。

## 二、Helm概念

- Chart 是一个Helm包，涵盖了需要在Kubernetes集群中运行应用，工具或者服务的资源定义。 把它想象成Kubernetes对应的Homebrew公式，Apt dpkg，或者是Yum RPM文件。
- 仓库（*Repository*）： 归集和分享chart的地方。
- 发布（Release）：在Kubernetes集群中运行的chart实例。一个chart经常在同一个集群中被重复安装。每次安装都会生成新的 发布。比如MySQL，如果想让两个数据库运行在集群中，可以将chart安装两次。每一个都会有自己的发布版本，并有自己的发布名称。

因此，Helm可以解释为：

- Helm在Kubernetes中安装*Chart*，并且每次安装会创建一个新的*Release*。
- 想查找新chart，可以在Helm Chart *仓库* 搜索。

## 三、Helm入门

## 安装

本文以二进制安装说明。其他安装方式详见：[https://helm.sh/zh/docs/intro/install/](https://link.zhihu.com/?target=https%3A//helm.sh/zh/docs/intro/install/)。

- 下载 [需要的版本](https://link.zhihu.com/?target=https%3A//github.com/helm/helm/releases)
- 解压(`tar -zxvf helm-v*-linux-amd64.tar.gz`)
- `mv linux-amd64/helm /usr/local/bin/helm`

## 初始化仓库

当您已经安装好了Helm之后，您可以添加一个chart 仓库。

```text
# 命令： helm repo add [repo_name] [repo_address]
## 添加官方仓库
$ helm repo add stable https://charts.helm.sh/stable
## 添加falcosecurity仓库
$ helm repo add falcosecurity https://falcosecurity.github.io/charts
```

查看本地仓库：

```text
$ helm repo ls
NAME            URL
stable          https://charts.helm.sh/stable
falcosecurity   https://falcosecurity.github.io/charts
```

当添加完成，将可以看到仓库中的charts列表：

```text
# 命令 helm search repo [repo_name]
$ helm search repo stable
NAME                           CHART VERSION  APP VERSION    DESCRIPTION
stable/acs-engine-autoscaler    2.2.2         2.1.1          DEPRECATED Scales worker nodes                                                                                                                                 within agent pools
stable/aerospike                0.2.8         v4.5.0.5       A Helm chart for Aerospike in                                                                                                                                  Kubernetes
stable/airflow                  4.1.0         1.10.4         Airflow is a platform to                                                                                                                                           programmatically autho...
stable/ambassador               4.1.0         0.81.0         A Helm chart for Datawire                                                                                                                                          Ambassador
# ... and many more
```

## 安装Chart

本文以安装mysql为例说明。

```text
$ helm repo update              # 确定我们可以拿到最新的charts列表

# 安装
$ helm install stable/mysql --generate-name
NAME: mysql-1609565696

# 查看chart基本信息
$ helm show chart stable/mysql

# 查看chart所有信息
$ helm show all stable/mysql

# 查看chart发布情况
$ helm ls
NAME                NAMESPACE   REVISION    UPDATED             STATUS      CHART       APP VERSION
mysql-1609565696    default     1           2021-01-02 13:35:02 deployed    mysql-1.6.9 5.7.30

# 卸载。该命令所有相关资源（service、deployment、 pod等）甚至版本历史。
# 可以使用--keep-history保留历史信息。
$ helm uninstall mysql-1609565696
```

备注：每当执行 helm install 的时候，都会创建一个新的发布版本。 所以一个chart在同一个集群里面可以被安装多次，每一个都可以被独立的管理和升级。

## 帮助

```text
# 帮助
$ helm help
# 命令详细帮助 helm [cmd] -h
$ helm install -h
```

## 四、Helm命令详解

## 'helm search'：查找chart，支持模糊搜索。

```text
# 搜索https://artifacthub.io/中的chart
$ helm search hub
$ helm search hub [chart_name]

# 搜索本地仓库中的chart
$ helm search repo 
$ helm search repo [chart_name]
```

## 'helm install'：安装一个包

```text
$ helm install [RELEASE NAME] [CHART] [flags] # 指定release name
$ helm install [CHART] --generate-name        # 随机生成release name
$ helm status [RELEASE NAME]
```

## 'helm uninstall': 卸载一个发布

```text
$ helm uninstall [RELEASE NAME]
```

## 发布查看

```text
# 查看当前所有部署的发布
$ helm list
# 查看当前所有部署的发布，包括--keep-history 保留的卸载记录
$ helm list --all
```

## 仓库管理

```text
# 命令： helm repo add [repo_name] [repo_address]
$ helm repo add stable https://charts.helm.sh/stable

# 更新仓库
$ helm repo update

# 删除仓库
$ helm repo remove [REPO1 [REPO2 ...]]

# 查看本地仓库
$ helm repo list
NAME            URL
stable          https://charts.helm.sh/stable
falcosecurity   https://falcosecurity.github.io/charts
```

更多命令详见：[https://helm.sh/zh/docs/helm/](https://link.zhihu.com/?target=https%3A//helm.sh/zh/docs/helm/)

## 五、参考资料

- 官方文档：[https://helm.sh/zh/](https://link.zhihu.com/?target=https%3A//helm.sh/zh/)

编辑于 2021-01-02 18:54

Helm

Kubernetes