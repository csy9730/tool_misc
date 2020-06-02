# 软件包管理工具选Scoop还是Chocolatey？看完这篇就知道了



目前在Windows 10平台上最热门的软件包管理工具就属Scoop和Chocolatey了。这两款工具都有类似的功能集，允许用户在Windows PC上自动安装软件。**但是这两款工具也提供不同的部署模型，那么如何根据你的自身需求来进行挑选呢？相信看完这篇文章你就会有答案了。**

[![img](https://www.cnbeta.com/images/blank.gif)](https://static.cnbetacdn.com/article/2019/0802/071d3705f21d192.jpg)

本文主要比较两款工具的差别，以便于评估哪种方式最适合你。如果你刚刚接触软件包管理工具，那么推荐阅读相关的指导文章，以了解这些工具在实践中的运行方式。

需要注意的是，Scoop和Chocolatey都允许用户使用单个命令，从命令行安装[Windows](https://microsoft.pvxt.net/x9Vg1)程序。在整个安装过程中用户无需手动访问下载站点或者点击图形安装程序。此外这些软件包管理工具还简化了检查和下载更新步骤，因此你可以确保所使用的应用程序始终处于最新状态。

![img](https://www.cnbeta.com/images/blank.gif)

▲ 通过Scoop来安装7-Zip

从外观上来看Scoop和Chocolatey的界面比较相似。不过通过深入发掘你就会发现几个比较小但很重要的差异。其中最重要的差别在于两款工具是针对的不同的用户群。

Chocolatey的自我定位是Windows系统的“软件管理自动化”。它能够在无需人工干预的情况下自动安装超过20种Windows软件包类型，而且开箱即用，支持配置超过7000款主流软件，包括Google Chrome和VLC多媒体播放器等桌面热门应用程序。

[![img](https://www.cnbeta.com/images/blank.gif)](https://static.cnbetacdn.com/article/2019/0802/aa3a7ee1f0b0913.png)

▲ Chocolatey软件包管理工具截图

Scoop同样可以通过单命令安装Windows软件，不过它的适用目标相对来说更狭窄，也更有针对性。这款软件包管理工具更多的时候是帮助开发者安装系统工具时使用，尤其是那些依赖于Linux但在Windows系统上不存在的软件程序。

根据该软件作者的描述，Scoop的定位主要是“开源、命令行的开发者工具”。Scoop同样能够安装诸如Chrome和VLC这样的常规Windows程序，但在做这些事情之前用户需要额外手动添加附加库。

[![img](https://www.cnbeta.com/images/blank.gif)](https://static.cnbetacdn.com/article/2019/0802/87017bc8dac1193.png)

▲ Scoop软件包管理工具截图



对于那些只需要一个软件包管理工具的普通用户来说，Chocolatey应该是最佳的选择。用户不需要进行任何额外配置，就能安装数百款热门应用程序。此外如果用户并不希望使用终端，甚至还能获得GUI图形界面。

不过Chocolatey的普遍适用性也带来了额外的复杂性。Chocolatey依赖于Windows PowerShell及其NuGet包管理器系统，该系统主要用于解决软件库依赖关系。Chocolatey也往往需要管理员权限才能运行使用，这就意味着你将会被UAC弹出窗口打断。

相比之下，Scoop并不使用NuGet而且不会进行全局安装。相反，这些应用程序的范围会被限定在你的用户账户中，并安装到特殊目录以避免路径污染。 Scoop甚至将自己与被视为包管理器的距离保持距离，因为它只是“读取描述如何安装程序及其依赖关系的清单”。

哪个更适合你？

两款软件包安装程序都有各自的优缺点，所以需要根据自己的需求进行选择。如果您想快速简单地安装熟悉的Windows程序，那么Chocolatey可能适合您。其广泛的社区驱动的软件包存储库意味着您无需额外配置的情况下，就可以找到几乎所有流行的Windows程序。

[![img](https://www.cnbeta.com/images/blank.gif)](https://static.cnbetacdn.com/article/2019/0802/29806e3cd309704.jpg)

但是，如果要将程序范围限定为用户帐户，没有管理员权限或主要寻找开发人员工具，Scoop应该是您的首选。它在技术上更简单，对系统的目录结构影响较小，而且比Chocolatey更轻量级。通过添加scoop-extras存储库可以轻松添加对流行的Windows桌面程序的支持。

当然，Chocolatey和Scoop都有许多额外的功能，优点和缺点，我们在这里没有讨论过。特别是，Chocolatey拥有许多针对企业的专业能力，使其更适合企业和系统管理员。同时，Scoop简化的“包”模型意味着应用程序开发人员添加支持相当简单 - Git存储库中的单个文件将通过Scoop实现安装。