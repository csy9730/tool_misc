# Java方面JDK各版本的区别


## java的版本区别
常用的 java 程序分为 Java SE、Java EE、Java ME三个版本，介绍如下：

\1. Java SE（Java Platform，Standard Edition）
Java SE 以前称为J2SE。它允许开发和部署在桌面、服务器、嵌入式环境和实时环境中使用的 Java 应用程序。Java SE是基础包，但是也包含了支持 Java Web 服务开发的类，并为 Java Platform，Enterprise Edition（Java EE）提供基础。

\2. Java EE（Java Platform，Enterprise Edition）。
这个版本以前称为 J2EE。企业版本帮助开发和部署可移植、健壮、可伸缩且安全的服务器端 Java 应用程序。Java EE 是在 Java SE 的基础上构建的，它提供 Web 服务、组件模型、管理和通信 API，可以用来实现企业级的面向服务体系结构（service-oriented architecture，SOA）和 Web 2.0 应用程序。

\3. Java ME（Java Platform，Micro Edition）。
这个版本以前称为 J2ME。Java ME 为在移动设备和嵌入式设备（比如手机、PDA、电视机顶盒和打印机）上运行的应用程序提供一个健壮且灵活的环境。Java ME 包括灵活的用户界面、健壮的安全模型、许多内置的网络协议以及对可以动态下载的连网和离线应用程序的丰富支持。基于 Java ME 规范的应用程序只需编写一次，就可以用于许多设备，而且可以利用每个设备的本机功能。

说得更简单片面一点：

Java SE 是做电脑上运行的软件。

Java EE 是用来做网站的-（我们常见的JSP技术）

Java ME 是做手机软件的。





在我学习Java开发的时候，Java开发的方向有三个：

1. J2SE 

在那个时候就是Java Swing编程（也就是客户端开发，宇宙级开发工具InteliJ idea据说就是用Java开发的），Java语言由于编译成字节码在JVM运行的特性，号称一次编写，全平台运行，所以可以用来做客户端开发。

1. J2EE

服务器开发，现在Java应用最广的开发方向，Spring cloud微服务这些东西就是Java服务器开发的一些框架。但是Java由于静态语言、编译型语言的特征，主要还是应用在企业级服务器开发领域。

1. J2ME

这个玩意比较偏门，属于嵌入式开发，在Android和iOS系统大红大紫的今天，基本无人问津。

所以题主所问Java开发和J2EE开发的区别，我的回答：从范畴来说，Java开发包括J2EE开发，两者属于内含关系。







## **jdk和jre的区别**

有同学在配置系统时，经常遇到jdk和jre的问题，但是也搞不清两者的区别。这里作为常识了解下，早期不知道也没什么问题。

其实从就两个词的字面就可以区分开，jdk（java development kit）是java的开发工具包，jre (java runtime environment) 是java程序的运行环境。

本地开发的时候也可以运行，但是作为网站或者项目运行时，代码都打个war包或者jar包了，跟开发相关的工具和包就没有用了。

也就是说jre是jdk的一个子集。



运行时使用jre而不使用jdk，一方面是为了减少硬盘空间的使用，另一方面也有一定的安全考虑，防止jdk里的一些执行命令被恶意篡改。当然，现在大部分公司运行时已经不那么区分jdk和jre了，直接在服务器上跑JDK。