# [Fabric8简介](https://my.oschina.net/xiaominmin/blog/1598406)

[xiaomin0322](https://my.oschina.net/xiaominmin)

[架构](https://my.oschina.net/xiaominmin?tab=newest&catalogId=5730280)

2017/12/30 00:55

阅读数 4.6K

Fabric8简介 博客分类： 架构

![img](https://static.oschina.net/uploads/img/201712/30005531_jSnU.jpg)



## 前言

无意中发现 [Fabric8](https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Ffabric8io%2Ffabric8) 这个 **对于Java友好的开源微服务管理平台** 。

其实这在这里发现的 [Achieving CI/CD with Kubernetes](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fblog.sonatype.com%2Fachieving-ci%2Fcd-with-kubernetes) （by Ramit Surana,on February 17, 2017），其实是先在 [slideshare](https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fwww.slideshare.net%2Framitsurana%2Fachieving-cicd-with-kubernetes) 上看到的，pdf可以 [在此下载](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Folz1di9xf.bkt.clouddn.com%2Fachiveving-ci-cd-with-kubernetes-ramit-surana.pdf) ，大小2.04M。

大家可能以前听过一个叫做 [fabric](https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Ffabric%2Ffabric%2F) 的工具，那是一个 Python (2.5-2.7) 库和命令行工具，用来流水线化执行 SSH 以部署应用或系统管理任务。所以大家不要把fabric8跟fabric搞混，虽然它们之间有一些共同点，但两者完全不是同一个东西， **fabric8不是fabric的一个版本** 。Fabric是用python开发的，fabric8是java开发的。

如果你想了解简化Fabric可以看它的 [中文官方文档](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric-docs-cn.readthedocs.io%2Fzh_CN%2Flatest%2Ftutorial.html) 。



## Fabric8简介

fabric8是一个开源 **集成开发平台** ，为基于 [Kubernetes](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fkubernetes.io%2F) 和 [Jenkins](https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fjenkins.io%2F) 的微服务提供 [持续发布](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Fcdelivery.html) 。

使用fabric可以很方便的通过 [Continuous Delivery pipelines](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Fcdelivery.html) 创建、编译、部署和测试微服务，然后通过Continuous Improvement和 [ChatOps](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Fchat.html) 运行和管理他们。

[Fabric8微服务平台](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Ffabric8DevOps.html) 提供：

- [Developer Console](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Fconsole.html) ，是一个 [富web应用](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fwww.infoq.com%2Fcn%2Fnews%2F2014%2F11%2Fseven-principles-rich-web-app) ，提供一个单页面来创建、编辑、编译、部署和测试微服务。

- [Continuous Integration and Continous Delivery](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Fcdelivery.html) ，使用 [Jenkins](https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fjenkins.io%2F) with a [Jenkins Workflow Library](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2FjenkinsWorkflowLibrary.html) 更快和更可靠的交付软件。

- [Management](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Fmanagement.html) ，集中式管理 [Logging](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Flogging.html) 、 [Metrics](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Fmetrics.html) , [ChatOps](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Fchat.html) 、 [Chaos Monkey](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2FchaosMonkey.html) ，使用 [Hawtio](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fhawt.io%2F) 和 [Jolokia](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fjolokia.org%2F) 管理Java Containers。

- [Integration](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Fipaas.html) *Integration Platform As A Service* with [deep visualisation](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Fconsole.html) of your [Apache Camel](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fcamel.apache.org%2F) integration services, an [API Registry](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2FapiRegistry.html) to view of all your RESTful and SOAP APIs and [Fabric8 MQ](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Ffabric8MQ.html) provides *Messaging As A Service* based on [Apache ActiveMQ](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Factivemq.apache.org%2F) 。

- Java Tools

   帮助Java应用使用 

  Kubernetes

   :

  - [Maven Plugin](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2FmavenPlugin.html) for working with [Kubernetes](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fkubernetes.io%2F) ，这真是极好的
  - [Integration and System Testing](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Ftesting.html) of [Kubernetes](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fkubernetes.io%2F) resources easily inside [JUnit](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fjunit.org%2F) with [Arquillian](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Farquillian.org%2F)
  - [Java Libraries](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2FjavaLibraries.html) and support for [CDI](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Fcdi.html) extensions for working with [Kubernetes](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fkubernetes.io%2F) .



## Fabric8微服务平台

Fabric8提供了一个完全集成的开源微服务平台，可在任何的 [Kubernetes](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fkubernetes.io%2F) 和 [OpenShift](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fwww.openshift.org%2F) 环境中开箱即用。

整个平台是基于微服务而且是模块化的，你可以按照微服务的方式来使用它。

微服务平台提供的服务有：

- 开发者控制台，这是一个富Web应用程序，它提供了一个单一的页面来创建、编辑、编译、部署和测试微服务。
- 持续集成和持续交付，帮助团队以更快更可靠的方式交付软件，可以使用以下开源软件：
  - [Jenkins](https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fjenkins.io%2F) ：CI／CD pipeline
  - [Nexus](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fwww.sonatype.org%2Fnexus%2F) ： 组件库
  - [Gogs](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fgogs.io%2F) ：git代码库
  - [SonarQube](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fwww.sonarqube.org%2F) ：代码质量维护平台
  - [Jenkins Workflow Library](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2FjenkinsWorkflowLibrary.html) ：在不同的项目中复用 [Jenkins Workflow scripts](https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Ffabric8io%2Fjenkins-workflow-library)
  - [Fabric8.yml](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Ffabric8YmlFile.html) ：为每个项目、存储库、聊天室、工作流脚本和问题跟踪器提供一个配置文件
- [ChatOps](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Fchat.html) ：通过使用 [hubot](https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fhubot.github.com%2F) 来开发和管理，能够让你的团队拥抱DevOps，通过聊天和系统通知的方式来 [approval of release promotion](https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Fgithub.com%2Ffabric8io%2Ffabric8-jenkins-workflow-steps%23hubotapprove)
- [Chaos Monkey](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2FchaosMonkey.html) ：通过干掉 [pods](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Fpods.html) 来测试系统健壮性和可靠性
- 管理
  - [日志](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Flogging.html) 统一集群日志和可视化查看状态
  - [metris](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2Fmetrics.html) 可查看历史metrics和可视化



## 参考

[fabric8：容器集成平台——伯乐在线](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fhao.jobbole.com%2Ffabric8%2F)

[Kubernetes部署微服务速成指南—— *2017-03-09* *徐薛彪* 容器时代微信公众号](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fmp.weixin.qq.com%2Fs%3F__biz%3DMzI0NjI4MDg5MQ%3D%3D%26mid%3D2715290731%26idx%3D1%26sn%3Df1fcacb9aa4f1f3037918f03c29c0465%26chksm%3Dcd6d0bbffa1a82a978ccc0405afa295bd9265bd9f89f2217c80f48e1c497b25d1f24090108af%26mpshare%3D1%26scene%3D1%26srcid%3D0410RTk3PKkxlFlLbCVlOKMK%23rd)

上面那篇文章是翻译的，英文原文地址： [Quick Guide to Developing Microservices on Kubernetes and Docker](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Fwww.eclipse.org%2Fcommunity%2Feclipse_newsletter%2F2017%2Fjanuary%2Farticle2.php)

[fabric8官网](https://www.oschina.net/action/GoToLink?url=https%3A%2F%2Ffabric8.io%2F)

[fabric8 get started](https://www.oschina.net/action/GoToLink?url=http%3A%2F%2Ffabric8.io%2Fguide%2FgetStarted%2Fgofabric8.html)



## 后记

我在自己笔记本上装了个minikube，试玩感受将在后续发表。

试玩时需要科学上网。

```
$gofabric8 startusing the executable /usr/local/bin/minikube minikube already running using the executable /usr/local/bin/kubectl Switched tocontext"minikube". Deploying fabric8 to your Kubernetes installation at https://192.168.99.100:8443fordomainin namespace default Loading fabric8 releases from maven repository:https://repo1.maven.org/maven2/ Deploying package: platform version: 2.4.24Now about toinstallpackage https://repo1.maven.org/maven2/io/fabric8/platform/packages/fabric8-platform/2.4.24/fabric8-platform-2.4.24-kubernetes.yml Processing resource kind: Namespace in namespace defaultnameuser-secrets-source-adminFound namespace on kind Secret ofuser-secrets-source-adminProcessing resource kind: Secret in namespace user-secrets-source-adminnamedefault-gogs-git Processing resource kind: Secret in namespace defaultname jenkins-docker-cfg Processing resource kind: Secret in namespace defaultname jenkins-git-ssh Processing resource kind: Secret in namespace defaultname jenkins-hub-api-token Processing resource kind: Secret in namespace defaultname jenkins-master-ssh Processing resource kind: Secret in namespace defaultname jenkins-maven-settings Processing resource kind: Secret in namespace defaultname jenkins-release-gpg Processing resource kind: Secret in namespace defaultname jenkins-ssh-config Processing resource kind: ServiceAccount in namespace defaultname configmapcontroller Processing resource kind: ServiceAccount in namespace defaultname exposecontroller Processing resource kind: ServiceAccount in namespace defaultname fabric8 Processing resource kind: ServiceAccount in namespace defaultname gogs Processing resource kind: ServiceAccount in namespace defaultname jenkins Processing resource kind: Service in namespace defaultname fabric8 Processing resource kind: Service in namespace defaultname fabric8-docker-registry Processing resource kind: Service in namespace defaultname fabric8-forge Processing resource kind: Service in namespace defaultname gogs ... -------------------------Default GOGS admin username/password = gogsadmin/RedHat$1 Checking if PersistentVolumeClaims bind to a PersistentVolume .... Downloading images and waiting toopen the fabric8 console... ------------------------- ..................................................... http://www.tuicool.com/articles/RfQvua3
```

本文转载自：http://m635674608.iteye.com/admin/blogs/2378802