## [UNC - Microsoft Windows](https://www.cnblogs.com/awpatp/archive/2010/02/05/1664172.html)

定义

========

UNC是一种命名惯例, 主要用于在Microsoft Windows上指定和映射网络驱动器. UNC命名惯例最多被应用于在局域网中访问文件服务器或者打印机

 

UNC命名语法

========

UNC命名使用特定的标记法来识别网络资源. UNC命名由三个部分组成- 服务器名, 共享名, 和一个可选的文件路径. 这三个部分通过backslash连接起来, 如下:

\\server\share\file_path

 

这里的server部分引用的是由DNS或者WINS网络服务维护的字符串. 服务器名是由system administrator设定的.

 

share部分引用了由系统管理员创建的一个label. 在绝大多数版本的windows中, 比如说, 共享名admin$指的是操作系统安装的根路径(通常是C:\WINNT 或 C:\WINDOWS).

 

file部分引用在共享点之下的本地子文件夹.

 

UNC命名实例

========

\\teela\admin$ (to reach C:\WINNT)

\\teela\admin$\system32 (to reach C:\WINNT\system32)

\\teela\temp (to reach C:\temp)

 

通过使用Windows Exlorer或者DOM命令行, 再加上恰当的安全证明, 你可以通过指定UNC名字来映射网络驱动器, 远程地访问一台计算机上的文件夹.