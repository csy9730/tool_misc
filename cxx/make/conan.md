# Conan: C++包管理工具
 
 

包管理一直是c/c++项目开发过程中无法触及的痛苦之处。由于出现历史太早，c/c++发展初期并没有现代的包管方案的概念，这部分一直需求一直被忽略。

等到开发者想起要解决这个问题时，发现c/c++与硬件结合太过于紧密，支持太多的平台，在平台适配上有大量的工作需要处理，对于一个编译型语言，需要包管理需要能够正确的处理不同的平台上的二进制兼容问题或者源码编译问题，这导致想基于现有的代码来实现一个现代化的c\c++的包管理系统基本上是一个不可能完成的任务。于是开发者很明智的选择了rust。

尽管如此，人们还是给出了一些折衷的结局方案，包括linx上的apt，mac上的brew，windows上的nutget等方案。其中apt的方案主要解决二进制分发问题，对版本的控制较弱。其中brew/nutget等已经初具一个现代化包管理系统的雏形了。

在这包管理的基础上，出现像conan/vcpkg/buckaroo这样比较优秀的现代化的包管理系统。本文将着重介绍conan的基本概念和主要使用方法。

## Conan核心概念
编译配置
在给定版本的源码情况下，的如何来识别构建的二进制是否兼容，对于c\c++程序来说，这是一个不能完成的任务，因为同一份源码，可以获得完全不同的结果，这回设计到编译器/目标平台等各种因素。甚至一个简单的宏开关，都会导致编译的二进制结果时完全不同的。

Conan通过settings/options来识别一个源码编译出来的结果是否为同一份二进制。一个常见的conan配置如下：

> conan profile show default
Configuration for profile default:
 ``` ini
[settings]
os=Windows
os_build=Windows
arch=x86_64
arch_build=x86_64
compiler=Visual Studio
compiler.version=15
build_type=Release
[options]
[build_requires]
[env]
```
即在给定的profile下，对于同一份源码，应该要生成同样的二进制文件。

## 引用
Conan的另外一个概念叫做reference，reference的组成如下

Pkg/version@user/channel
例如

qt/5.6.3@iceyer/stable
qt/5.6.3@bincrafters/stable
dtkcore/2.0.9@iceyer/stable
dtkcore/2.0.9@iceyer/testing
dtkwidget/2.0.9@iceyer/stable
Pkg和version比较容易理解，代表包名和版本，user代表创建包的用户，stable表示这个包的发布通道。
不同用户创建的包其实没啥关系的，总之一个完整的reference才能代表一份源码。

## 包
有了源码和编译配置，我们很自然的想到了，可以用来构建我们需要的二进制了。Conan中的package是指的根据profile构建出来的二进制文件的集合，这个一定要搞清楚。在一个reference下，我们可以根据不同的参数来构建不同的package，如构建不同os的版本，构建包含不同特性的版本等。用一张官方的图来解释下：

Alt text

通过上面的图，聪明的同学一定发现槽点了：conan是基于python的，并且是和cmake强绑定的… 特别是cmake这种面向字符串编程的工具，似乎有着成为c++构建工具的事实标准的趋势发展。