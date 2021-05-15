# apache和tomcat区别

Apache

Apache HTTP服务器是一个模块化的服务器，可以运行在几乎所有广泛使用的计算机平台上。其属于应用服务器。Apache支持支持模块多，性能稳定，Apache本身是静态解析，适合静态HTML、图片等，但可以通过扩展脚本、模块等支持动态页面等。

（Apche可以支持PHPcgiperl,但是要使用Java的话，你需要Tomcat在Apache后台支撑，将Java请求由Apache转发给Tomcat处理。）

缺点：配置相对复杂，自身不支持动态页面。

Tomcat：

Tomcat是应用（Java）服务器，它只是一个Servlet(JSP也翻译成Servlet)容器，可以认为是Apache的扩展，但是可以独立于Apache运行。

Apache与Tomcat的比较

相同点：

两者都是Apache组织开发的

两者都有HTTP服务的功能

两者都是免费的

不同点：

Apache是专门用了提供HTTP服务的，以及相关配置的（例如虚拟主机、URL转发等等），而Tomcat是Apache组织在符合Java EE的JSP、Servlet标准下开发的一个JSP服务器.

Apache是一个Web服务器环境程序,启用他可以作为Web服务器使用,不过只支持静态网页如(ASP,PHP,CGI,JSP)等动态网页的就不行。如果要在Apache环境下运行JSP的话就需要一个解释器来执行JSP网页,而这个JSP解释器就是Tomcat。

Apache:侧重于HTTPServer ，Tomcat:侧重于Servlet引擎，如果以Standalone方式运行，功能上与Apache等效，支持JSP，但对静态网页不太理想；

Apache是Web服务器，Tomcat是应用（Java）服务器，它只是一个Servlet(JSP也翻译成Servlet)容器，可以认为是Apache的扩展，但是可以独立于Apache运行。

实际使用中Apache与Tomcat常常是整合使用：

如果客户端请求的是静态页面，则只需要Apache服务器响应请求。

如果客户端请求动态页面，则是Tomcat服务器响应请求。

因为JSP是服务器端解释代码的，这样整合就可以减少Tomcat的服务开销。

可以理解Tomcat为Apache的一种扩展。

以上就是apache和tomcat区别的详细内容

## misc

听说的名称：真实名称

apache：apache httpd

tomcat：apache tomcat