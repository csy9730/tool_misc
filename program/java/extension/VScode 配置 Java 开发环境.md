# VScode 配置 Java 开发环境 (VSCode 天下第一!!!!!)

丛继晔 2020-05-03 16:49:46  25755  收藏 85
分类专栏： Java 文章标签： ubuntu java visual studio code
版权
VScode 配置 Java 环境
1. 下载 JDK
方式一：手动下载 JDK
Oracle Java SE
AdoptOpenJdk
Azul Zulu for Azure - Enterprise Edition
方式二： VSCode 中下载 JDK
下载 JAVA 插件扩展
方式一: windows平台下可以直接访问这个地址 直接下载带有 java插件的 vscode
方式二: 在vscode中下载以下插件

Language Support for Java™ by Red Hat
Debugger for Java
Java Test Runner
Maven for Java
Java Dependency Viewer
安装插件完成后按下 Ctrl+Shift+P输入Java: Configure Java Runtime


2. 添加 JDK 环境
下面两种方式只需要配置一种即可，如果两种方式都进行配置，可能会下方的问题出现。
Error: A JNI error has occurred, please check your installation and try again

方式一: 配置 JDK 的系统环境变量。
windows 平台下可以下载 jdk 的exe程序安装，安装时选择将java环境添加到系统环境变量中即可。
Ubuntu 平台下选择 jdk-8u251-linux-x64.tar.gz下载。下载完成后配置环境变量。
sudo gedit ~/.bashrc

export JAVA_HOME=<path-to-your-jdk-path>
# EX: export JAVA_HOME=/opt/jdk1.8.0_251
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
1
2
3
4
5
6
7
方式二: 配置 VSCode 项目的 JDK 路径
在 vscode 的设置中查询 java.home ，选择 settings.json 文件中编辑 将 java.home 的路径设置为你的 JDK 目录.



settings.json

{
    "java.home": "path-to-your-jdk"
}
1
2
3
测试JAVA环境
使用CTRL+SHIFT+P输入Java: create Project，输入项目名，在src文件夹中，选择Run运行Java代码，控制台数据Hello World则为成功