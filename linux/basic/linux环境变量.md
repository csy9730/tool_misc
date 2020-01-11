# Linux下设置和查看环境变量
Linux的变量种类
根据变量的作用域，分为以下三种：
1. 本机变量，位于配置文件/etc/profile
2. 用户变量，位于配置文件用户目录下的.bash_profile
3. bash临时变量，关闭shell时失效
按变量的生存周期来划分，Linux变量可分为两类： 
1 永久的：需要修改配置文件，变量永久生效。 
2 临时的：使用`export`命令声明即可，变量在关闭shell时失效。

## 配置变量
以下是变量的创建，读取，更新和删除操作（CRUD)。
### 新建
1 在/etc/profile文件中添加变量【对所有用户生效(永久的)】 
用VI在文件/etc/profile文件中增加变量，该变量将会对Linux下所有用户有效，并且是“永久的”。 
例如：编辑/etc/profile文件，添加CLASSPATH变量

``` bash
# vi /etc/profile 
export CLASSPATH=./JAVA_HOME/lib;$JAVA_HOME/jre/lib
```
注：修改文件后要想马上生效还要运行# source /etc/profile不然只能在下次重进此用户时生效。

2 在用户目录下的.bash_profile文件中增加变量【对单一用户生效(永久的)】 
用VI在用户目录下的.bash_profile文件中增加变量，改变量仅会对当前用户有效，并且是“永久的”。 
例如：编辑guok用户目录(/home/guok)下的.bash_profile 
vi/home/guok/.bash.profile添加如下内容：
`export CLASSPATH=./JAVAHOME/lib;JAVA_HOME/jre/lib`
注：修改文件后要想马上生效还要运行$ source /home/guok/.bash_profile不然只能在下次重进此用户时生效。

3 直接运行export命令定义变量【只对当前shell(BASH)有效(临时的)】 
在shell的命令行下直接使用[export 变量名=变量值] 定义变量，该变量只在当前的shell(BASH)或其子shell(BASH)下是有效的，shell关闭了，变量也就失效了，再打开新shell时就没有这个变量，需要使用的话还需要重新定义。
### 修改
修改环境变量可以直接使用环境变量名进行修改。
例：`MYNAME="ZZLL"`
添加`"export PATH=/usr/local/anconda3/bin:$PATH" `到/etc/profile
### 环境变量的查看
1 使用echo命令查看单个环境变量。例如： 
`echo $PATH `
2 使用env查看所有环境变量。例如： 
`env `
3 使用set查看所有本地定义的环境变量。

### 删除指定的环境变量
set可以设置某个环境变量的值。清除环境变量的值用unset命令。如果未指定值，则该变量值将被设为NULL。示例如下： 
``` bash
export TEST="Test..." #增加一个环境变量TEST
env|grep TEST #此命令有输入，证明环境变量TEST已经存在了 
#此命令没有输出，证明环境变量TEST已经删除
unset  TEST #删除环境变量TEST 
```

## 常用的环境变量


| 环境变量 | 用途 |
| ---- | ---- |
|PATH |决定了shell将到哪些目录中寻找命令或程序 |
|HOME| 当前用户主目录 |
|HISTSIZE　|历史记录数 |
|LOGNAME |当前用户的登录名 |
|HOSTNAME　|指主机的名称 |
|SHELL| 当前用户Shell类型 |
|LANGUGE 　|语言相关的环境变量，多语言可以修改此环境变量 |
|MAIL|　当前用户的邮件存放目录 |
|PS1　|基本提示符，对于root用户是#，对于普通用户是$|