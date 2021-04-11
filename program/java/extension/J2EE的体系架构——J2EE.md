# [J2EE的体系架构——J2EE](https://www.cnblogs.com/yutingliuyl/p/7281352.html)

​    J2EE是Java2平台企业版（Java 2 Platform,Enterprise Edition），它的核心是一组技术规范与指南，提供基于组件的方式来设计、开发、组装和部署企业应用。J2EE使用多层分布式的应用模型。



# J2EE分层：

​             ![img](http://img.blog.csdn.net/20140528173127406?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvZGFuZGFuem1j/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/Center)

​    客户层，执行在客户计算机上的组件，用户与系统的接口逻辑，通过http协议的来訪问应用server。
​    表示层，执行在J2EEserver上的组件，通过与业务逻辑层互动。将用户须要的数据以适当的方式输出。
​    业务逻辑层，相同是执行在J2EEserver上的组件。
​    企业信息系统层（EIS），是指执行在EISserver上的软件系统。
​    以上层次一般也指三层应用，也就是客户层+J2EE应用服务层+企业信息系统层。分布在三个不同位置：客户计算机、J2EEserver及后台的数据库或过去遗留下来的系统。
客户层    Web浏览器    也称Webclient， 以标准格式来显示从server传递过来的网页，它们传递给浏览器时已经是HTML或者XML格式，浏览器正确的显示给用户。
​    小应用程序（Applet）    是嵌在浏览器中的一种轻量级client。当web页面不能充分的表现数据或者应用界面的时候，才使用它，Applet是一种替代web页面的手段。可以使用J2SE开发Applet。Applet无法使用J2EE中的各种Service和API。须要执行在client安装了Java虚拟机的Web浏览器上。
​     应用程序client    J2EE应用程序client相对Applet而言。是一个较重量级的client，可以使用大多数的服务和API，它执行在客户机上，能提供强大而灵活易用的用户界面，如使用Swing或AWT创建的图形化的用户界面（GUI）。当然。应用程序可直接訪问执行在业务层的Bean，假设需求同意。也可以打开HTTP连接，建立与执行在Web层上的Servlet之间的通讯。
 
J2EE应用server两大容器    EJB容器+Web容器，即业务逻辑层+表示层
**Web容器**    管理全部的Servlet等Web组件的执行。对响应客户请求和返回结果提供了执行时的支持。
**EJB容器：**    负责全部的EJB的执行。支持EJB组件的事务处理和生命周期管理。以及Bean的查找和其它服务，支持J2EE多层架构的基础结构。是一个控制业务实现的执行期环境，并提供事务服务、持久性、安全性等重要的系统服务，让开发者不必开发基础服务而将注意力集中在业务逻辑的实现。
两大组件Web组件+Ejb组件
**Web组件**    与基于Web的client进行交互，J2EE中有三类Web组件：Servlet、JSP、JavaBean，Servlet是Webserver的功能扩展。接受Web请求，返回动态的Web页面。Web容器中的组件能够使用EJB中的组件来完毕复杂的业务逻辑。值得注意的是静态的HTML页面和Applets不算是Web层组件。
**EJB组件**    包括三种不同类型的EJB：会话Bean、消息驱动Bean、实体Bean
​    第一：会话Bean：着重业务逻辑的实现与控制，负责与Web层通信，给Web层提供訪问业务数据的接口。当client完毕运行过程的时候。会话Bean及相关数据会消失。
​    第二：实体Bean：代表持久数据。数据相当于存储在数据库表中，它负责保存业务数据，给会话Bean訪问业务数据的接口。
​    第三：消息驱动Bean：用于接收、处理客户通过JMS发送过来的消息，同意业务组件接收衣服的JMS消息。
企业信息系统层    负责执行企业信息系统软件，包含ERP、数据库、文件夹服务、其它遗留系统等。
总结    J2EE所包括的各类组件、服务架构及技术层次。均有共同的标准及规格，让各种依循J2EE架构的不同平台之间，存在良好的兼容性。解决过去企业后端使用的信息产品彼此之间无法兼容，企业内部或外部难以互通的窘境。