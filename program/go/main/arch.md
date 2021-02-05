# arch

般的编程语言往往对工程（项目）的目录结构是没有什么规定的，但是Go语言却在这方面做了相关规定，本节我们就来聊聊Go语言在工程结构方面的有关知识。

我们前面讲搭建Go语言开发环境时提到的环境变量 GOPATH，项目的构建主要是靠它来实现的。这么说吧，如果想要构建一个项目，就需要将这个项目的目录添加到 GOPATH 中，多个项目之间可以使用;分隔。

如果不配置 GOPATH，即使处于同一目录，代码之间也无法通过绝对路径相互调用。
目录结构
一个Go语言项目的目录一般包含以下三个子目录：

    src 目录：放置项目和库的源文件；
    pkg 目录：放置编译后生成的包/库的归档文件；
    bin 目录：放置编译后生成的可执行文件。


三个目录中我们需要重点关注的是 src 目录，其他两个目录了解即可，下面来分别介绍一下这三个目录。
src 目录
用于以包（package）的形式组织并存放 Go 源文件，这里的包与 src 下的每个子目录是一一对应。例如，若一个源文件被声明属于 log 包，那么它就应当保存在 src/log 目录中。

并不是说 src 目录下不能存放 Go 源文件，一般在测试或演示的时候也可以把 Go 源文件直接放在 src 目录下，但是这么做的话就只能声明该源文件属于 main 包了。正常开发中还是建议大家把 Go 源文件放入特定的目录中。

包是Go语言管理代码的重要机制，其作用类似于Java中的 package 和 C/C++ 的头文件。Go 源文件中第一段有效代码必须是package <包名> 的形式，如 package hello。

另外需要注意的是，Go语言会把通过go get 命令获取到的库源文件下载到 src 目录下对应的文件夹当中。
pkg 目录
用于存放通过go install 命令安装某个包后的归档文件。归档文件是指那些名称以“.a”结尾的文件。

该目录与 GOROOT 目录（也就是Go语言的安装目录）下的 pkg 目录功能类似，区别在于这里的 pkg 目录专门用来存放项目代码的归档文件。

编译和安装项目代码的过程一般会以代码包为单位进行，比如 log 包被编译安装后，将生成一个名为 log.a 的归档文件，并存放在当前项目的 pkg 目录下。
bin 目录
与 pkg 目录类似，在通过go install 命令完成安装后，保存由 Go 命令源文件生成的可执行文件。在类 Unix 操作系统下，这个可执行文件的名称与命令源文件的文件名相同。而在 Windows 操作系统下，这个可执行文件的名称则是命令源文件的文件名加 .exe 后缀。
源文件
上面我们提到了命令源文件和库源文件，它们到底是什么呢？

    命令源文件：如果一个 Go 源文件被声明属于 main 包，并且该文件中包含 main 函数，则它就是命令源码文件。命令源文件属于程序的入口，可以通过Go语言的go run 命令运行或者通过go build 命令生成可执行文件。
    库源文件：库源文件则是指存在于某个包中的普通源文件，并且库源文件中不包含 main 函数。

不管是命令源文件还是库源文件，在同一个目录下的所有源文件，其所属包的名称必须一致的。