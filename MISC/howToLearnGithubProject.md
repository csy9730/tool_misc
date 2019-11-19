# howToLearnGithubProject

[TOC]

## 程序分类

主要分为 app ， lib  ，framework ， env

env提供可编程可调试的低级别级别的接口，可以简单执行。

lib提供中级别api，不能直接运行 ，需要用户写调用接口代码，。

app 可以直接运行，无需写代码，可以调用lib提供的功能，实现面向用户更高级别的功能。

framework 介于app和lib之间，提供中级别api，可以直接运行功能不完善的简易demo，通过填充内容完善功能。



此外还有 cmdline ，没有界面，通过命令行的形式调用lib。

framework 和lib的区别在于层级不一样，lib层级低，framework可以跨越到高层级

常见的env有bash，cmd，powershell，python，nodejs，

gcc和glibc共同完成env的功能。



ludwig ： 一个cmdline应用，依赖python环境，tensorflow库。

tensorflow 安装方法：nvidia drive，（cuda,cudnn) , anaconda，(numpy,mkl,) tensorflow，



## 掌握层次

掌握程度：

0. pdf 
1. install 【 env， data ，release/src 】
2.  run  【demo  or config or test or bench or args or gui 】
3. src&debug



pdf：查看帮助文档,lib型帮助文档 ，提供api，api实现。

install 包括安装环境，基础库，（准备数据或配置），查看目录结构 ,查看注册表信息。

run dir： 查看缓存文件流

​		配置复杂参数和简单运行 ；

​		参数简单，运行状态复杂,例如复杂gui程序。

debug&src：查看 代码入口和层次结构。应用代码剖析，底层库调用理清条理。



