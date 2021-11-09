# [R语言 查看已加载包、卸除加载包及安装包与卸载包](https://www.cnblogs.com/emanlee/p/13912266.html)



1、**查看已加载的包**

(.packages())

注意外面的括号和前面的点不能省。

包被安装后，在使用前需要加载。加载包使用命令 library(包名)，比如library(codetools)。

查看有哪些包是被加载的，使用命令(.packages()) ，注意小括号和点号不能省略。



2、**卸除已加载的包**

如卸除RMySQL包

detach(“package:RMySQL”)

注意是卸除，不是卸载，也就是说不是把包从R运行环境中彻底删除，只是不希望该包被加载使用。

在包使用函数冲突，检验函数依赖时比较有用。

 

要将已经加载的包卸除。注意不是卸载删除，只是不加载这个包。在包函数冲突时需要。使用命令detach("package:包名")。或则detach("package:包名", unload=TRUE)



3、**安装包**

install.packages(“rjson”)

下载安装名为“rjson”的包。

 

要安装包，可以使用命令install.packages("包名")，或者

install.packages("包名", contriburl="http://url",  dependencies = TRUE)

如果安装的时候要指定安装目录，可以使用install.packages("stepNorm", contriburl="http://url", lib="mydir")



4、**卸载已加载的包**

彻底删除已安装的包：

remove. packages(c(“pkg1”,”pkg2”) , lib = file .path(“path”, “to”, “library”))

注：

“pkg1”,”pkg2”表示包名，即一次可以卸载多个包；

“path”, “to”, “library”表示R的库路径，字符向量，通常情况下只输一个路径即可。使用命令.libPaths()可以查看库路径。示例：

remove.packages(c(‘zoom’),lib=file.path(‘C:\\Program Files\\R\\R-3.2.2\\library’))

 
5、**查看已安装的包**

installed.packages()
library()

使用 library() 可以查看已经安装的包的列表，会打开一个新窗口显示信息。

使用 installed.packages() 可以看到各个包安装的路径，版本号等信息。

也可以使用 .packages(all.available=T)  就在控制台中显示已安装包的名字，只显示包的名字。

要查看已安装包的帮助信息，比如该包中有哪些函数，可使用 help(package="graphics") 。如果该包提供了信息，会以本地网页的形式打开帮助文件。



6、**查看某个包提供的函数**

help(package=’TSA’)

package参数为要查看的包的包名。



7、**查看某个函数属于哪个包**

help(函数名)

在打开的网页中查看属于哪个包。

 

**8、升级包**

update.packages()

 

REF

https://www.cnblogs.com/brown-birds/p/8031734.html



分类: [[31\] R](https://www.cnblogs.com/emanlee/category/679689.html)

[好文要顶](javascript:void(0);) [关注我](javascript:void(0);) [收藏该文](javascript:void(0);) [![img](https://common.cnblogs.com/images/icon_weibo_24.png)](javascript:void(0);) [![img](https://common.cnblogs.com/images/wechat.png)](javascript:void(0);)

![img](https://pic.cnblogs.com/face/sample_face.gif)

[emanlee](https://home.cnblogs.com/u/emanlee/)
[关注 - 79](https://home.cnblogs.com/u/emanlee/followees/)
[粉丝 - 508](https://home.cnblogs.com/u/emanlee/followers/)





[+加关注](javascript:void(0);)

0

0







[« ](https://www.cnblogs.com/emanlee/p/13911925.html)上一篇： [R安装程序包：ERROR: failed to lock directory ‘/usr/lib64/R/library’ for modifying](https://www.cnblogs.com/emanlee/p/13911925.html)
[» ](https://www.cnblogs.com/emanlee/p/13912776.html)下一篇： [error: ISO C++ forbids initialization of member ‘valid’](https://www.cnblogs.com/emanlee/p/13912776.html)

posted @ 2020-11-01 23:04  [emanlee](https://www.cnblogs.com/emanlee/)  阅读(3691)  评论(0)  [编辑](https://i.cnblogs.com/EditPosts.aspx?postid=13912266)  [收藏](javascript:void(0))  [举报](javascript:void(0))









[刷新](javascript:void(0);)