# 关于内网常见端口漏洞和windows下wmic

rlenew 2021-04-25 16:53:29  209  收藏
文章标签： 安全 经验分享
版权

[https://blog.csdn.net/rlenew/article/details/116133013](https://blog.csdn.net/rlenew/article/details/116133013)

WMIC是扩展WMI（Windows Management
Instrumentation，Windows管理规范），提供了从命令行接口和批命令脚本执行系统管理的支持。在WMIC出现之前，如果要管理WMI系统，必须使用一些专门的WMI应用，比如SMS，或者使用WMI的脚本编程API，或者使用象CIM
Studio之类的工具。如果不熟悉C++之类的编程语言或VBScript之类的脚本语言，或者不掌握WMI名称空间的基本知识，要使用WMI管理系统是很困难的。WMIC改变了这种情况，为WMI名称空间提供了一个强大的、友好的命令行接口。

常见的使用有

wmic /?  #查看WMIC命令的全局选项，WMIC全局选项可以用来设置wMIC环境的各种属性
wmic process /?  #进程管理的帮助#
wmic process get /?#属性获取操作帮助
wmic service where state="状态" get 属性  #获取某状态的属性名
wmic /namespace:\\root\securitycenter2 path antivirusproduct GET /ALL  #查看系统安全软件信息
wmic product get name  #系统安装软件情况#
wmic environment get Description, VariableValue  #系统环境变量#
wmic onboarddevice get Desciption, DeviceType, Enabled, Status /format:list  #判断是否为虚拟机
1
2
3
4
5
6
7
8
更多的命令地址：https://www.jb51.net/article/49987.htm
内网中常见的漏洞端口：
Port: 445
SMB (Server Message Block) Windows协议族， 主要功能为文件打印共享服务，简单来讲就是共享文件夹。
该端口也是近年来内网横向扩展中比较火的端口，大名鼎鼎的永恒之蓝漏洞就是利用该端口，操作为扫描其是否存在MS17-010漏洞。正常情况下，其命令主要是建立IPC服务()空会话
net use \1192.168.1.2
远程本地认证
net use \192.168.1.2 /user :a\username password
注:a/username中a为工作组情况下的机器命名，可以为任意字符，例如workgroup/ username
域test.local远程认证
net use 1192.168.1.2 /user : test\username password

Port:137、138、 139
NetBios端口，137、138为UDP端口，主要用于内网传输文件，而NetBios/SMB服务的获取主要是通过139端口的。

Port: 135
该端口主要使用DCOM和RPC (Remote Procedure Cal)服务，我们利用这个端口主要做WMI (Windows Management Istrumentation)管理工具的远程操作。
几乎所有的命令都是管理员权限
使用时需要开启wmic服务
如果出现"Invalid Global Switch",需要使用双引号把该加的地方都加上
防火墙最好是关闭状态
远程系统的本地安全策略的“网络访问:本地帐户的共享和安全模式"应设为“经典本地用户以自己的身份验证"
该端口还可以验证是否开启Exchange Server

Port: 53
该端口为DNS服务端口，只要提供域名解析服务使用，该端口在渗透过程中可以寻找一下DNS域传送漏洞，在内网中可以使用DNS协议进行通信传输，隐蔽性更加好

Port: 389
用于LADP (轻量级目录访问协议)，属于TCP/IP协议，在域过程中一般出现在域控上出现该端口，进行权限认证服务，如果拥有对该域的用户，且担心net或者其他爆破方法不可行的情况，
可以尝试使用ADP端口进行爆破。

Port: 88
该端口主要开启Kerberos服务，属于TCPIP协议，主要任务是监听KDC的票据请求，该协议在渗透过程中可以进行黄金票据和白银票据的伪造，以横向扩展某些服务。

Port: 5985
该端口主要介绍WinRM服务，WinRM是Windows对WS Management的实现，WinRM允许远程用户使用工具和脚本对Windows服务器进行管理并获取数据。并且WinRM服务自Windows Vista开始成为Windows的默认组件。
条件:
Windows Vista.上必须手动启动，而Windows Server 2008中服务是默认开启的。
服务在后台开启，但是端口还没有开启监听，所以需要开启端口
使用winrm quickconfig 对WinRM进行配置，开启HTTP和HTTPSS监听，且需要开启防火墙

