# java


[https://www.java.com/](https://www.java.com/z)

## install

### linux下安装jdk

- oracle jdk（default-jdk） 原版jdk，由于有版权限制，只能去官网手动下载安装
- openjdk，精简版jdk，可以用命令行安装，但可能有兼容问题


#### download

[https://www.oracle.com/java/technologies/downloads/](https://www.oracle.com/java/technologies/downloads/)

~~[https://www.java.com/zh-CN/download/manual.jsp](https://www.java.com/zh-CN/download/manual.jsp)~~

[https://www.oracle.com/java/technologies/downloads/#java8](https://www.oracle.com/java/technologies/downloads/#java8)

需要去oracle官网，注册帐号才能下载。

根据不同平台下载 
- windows
- linux jdk-8u361-linux-x64.tar.gz


#### install

解压gz文件到安装目录。

#### 环境变量配置

编辑/etc/profile文件，添加以下内容
``` bash
export JAVA_HOME=/usr/local/lib/jdk1.8.0_361
export JRE_HOME=$JAVA_HOME/jre
export CLASSPATH=.:$JAVA_HOME/lib:$JRE_HOME/lib:$CLASSPATH
export PATH=$JAVA_HOME/bin:$JRE_HOME/bin:$PATH
```


#### demo
安装成功之后，测试能否允许

``` bash
echo %JAVA_HOME%
C:\Program Files\Java\jdk-11.0.2
```

``` bash
# java8
D:\Projects>java -version
java version "1.8.0_201"
Java(TM) SE Runtime Environment (build 1.8.0_201-b09)
Java HotSpot(TM) 64-Bit Server VM (build 25.201-b09, mixed mode)

# java11
D:\Projects>java -version
java 11.0.2 2019-01-15 LTS
Java(TM) SE Runtime Environment 18.9 (build 11.0.2+9-LTS)
Java HotSpot(TM) 64-Bit Server VM 18.9 (build 11.0.2+9-LTS, mixed mode)
```

### windows下安装jdk
也是到oracle官网下载安装，基本步骤一样，

#### 环境变量配置
添加环境变量

/etc/profile
``` bash
JAVA_HOME=/usr/local/lib/jdk1.8.0_361
JRE_HOME=%JAVA_HOME/jre
CLASSPATH=.;%JAVA_HOME/lib;%JRE_HOME/lib;%CLASSPATH
PATH=%JAVA_HOME/bin;%JRE_HOME/bin;%PATH
```


~/.bashrc
``` bash
if [ -z "$JAVA_HOME" ];then
    JAVA_HOME=/usr/local/lib/jdk1.8.0_361
    JRE_HOME=%JAVA_HOME/jre
    CLASSPATH=.;%JAVA_HOME/lib;%JRE_HOME/lib;%CLASSPATH
    PATH=%JAVA_HOME/bin;%JRE_HOME/bin;%PATH
else
   #
fi

```


#### win10系统 jdk8 安装闪退 解决方案
win10环境下 jdk8安装点击下一步没反应解决办法。

问题：今天同事安装JDK8，如图，点击下一步，你会发现，窗口没了，鼠标指针变成表示缓冲的蓝色圆圈，过了两秒，啥也没了，多试几次还是这样。搞了好一会，查了多篇资料，终于解决。

解决办法：将输入法切换为系统默认的输入法！！！当前输入法不能为国内输入法。

## Whitelabel Error Page
Whitelabel Error Page
This application has no explicit mapping for /error, so you are seeing this as a fallback.

Sun Apr 11 11:11:32 CST 2021
There was an unexpected error (type=Not Found, status=404).
No message available

## java file arch

```
D:\Projects>where java
C:\Program Files (x86)\Common Files\Oracle\Java\javapath\java.exe
C:\Program Files\Java\jdk-11.0.2\bin\java.exe
C:\Program Files\Java\jre1.8.0_201\bin
```

* java.exe
* javaw.exe
* javawc.exe

### javac
javac 后面跟着的是java文件的文件名，例如 HelloWorld.java。 该命令用于将 java 源文件编译为 class 字节码文件，如： `javac HelloWorld.java`。运行javac命令后，如果成功编译没有错误的话，会出现一个 HelloWorld.class 的文件。

java 后面跟着的是java文件中的类名,例如 HelloWorld 就是类名，如: `java HelloWorld`。


## misc
jre 是java执行环境，jdk 是java 开发环境，jdk包含jre。


ssh是spring struts hibernate三大框架缩写简称，包含spring