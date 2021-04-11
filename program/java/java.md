# java



## install

### demo
``` bash
echo %JAVA_HOME%
C:\Program Files\Java\jdk-11.0.2

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