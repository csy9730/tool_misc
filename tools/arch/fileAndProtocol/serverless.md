# 微服务和serverless

microServices本质和SOA （面向服务架构）类似
微服务架构：

与传统的纵向分层不同，侧重点在于横向分层，
纵向分层是 分割不同的表达方式（对象，数据库，持久化），业务模块贯穿所有的层次当中。
横向分层是分割不同的业务模块，每个模块包括所有的表达方式。

宏服务把所有的API服务打包一起，所有服务共享一个版本号，
微服务把所有服务分开，单独使用版本号，更加有利于版本更迭。
微服务在部署方面还会区分区分： VPS提供，容器，容器管理，

## misc

mesh 
SOA

serverless就是云平台，易扩容。
降低对服务器的操控，交给云平台管理，只需要享受微服务的执行。
把部署和运维监控等工作托管给云平台。

FaaS：函数
BaaS：后端
PaaS
serve mesh

IaaS：设备提供作为服务，提供虚拟硬件，可以定制操作系统
PaaS：平台提供作为服务，不能定制系统，可以选择安装程序
SaaS：软件提供作为服务，只能运行给定的程序
SaaS例如： 社交服务FaceBook，Twitter，储存服务Dropbox，
PaaS，面向开发者？需要开发者才能最终到达消费者。

按照面向消费者的上下游层次来看，SaaS最贴合消费者。
一个新行业，利润会从上游逐渐流到下游。