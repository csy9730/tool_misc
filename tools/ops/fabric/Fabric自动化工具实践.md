# Fabric自动化工具实践

[刘小白DOER](https://www.jianshu.com/u/5813aef5fde2)关注

0.8062021.07.31 19:31:08字数 692阅读 599

​    Fabric依赖paramiko进行ssh交互， Fabric的作者也是paramiko的作者。Fabric对paramiko进行了封装，不需要像使用paramiko一样自己处理ssh连接、任务分发、异常处理等繁琐工作，只需要专注于自己的需求即可。fabric是在paramiko之上又封装了一层，操作起来更加简单易用。Fabric对基本的系统管理操作进行了封装，如命令执行、文件上传、并行操作和异常处理。

## **1、安装Fabric**
```
pip3 install fabric
```
​安装好后，可以使用`python3 -c "import fabric"`来验证安装准确。Fabric既是一个python库，也是一个命令行工具，命令行工具是fab 。



![img](https://upload-images.jianshu.io/upload_images/24447700-9dbf6c462b541e04.png?imageMogr2/auto-orient/strip|imageView2/2/w/1002/format/webp)

​    **需要注意的是，Fabric大于2.0版本已经移除fabric.api模块，接口与1.x版本完全不同。**

## **2、Fabric Connection模块使用**

​    笔者使用的是端口转发的虚拟机ubuntu-server，已经配置了ssh免密，当然也可以使用connect_kwargs来指定连接密码，key_filename来指定密钥。

​    导入Connection模块： from fabric import Connection

​    连接远程服务器：conn = Connection("ubuntu@localhost:333")

​    run运行hostname查看主机名：conn.run("hostname")

​    run查看磁盘使用率：conn.run("df -h / | tail -n1 | awk '{print $5}'")



![img](https://upload-images.jianshu.io/upload_images/24447700-5ef875ed40a00a99.png?imageMogr2/auto-orient/strip|imageView2/2/w/778/format/webp)

## **3、Fabric SerialGroup模块使用**

​    单个命令在多个主机上执行。

​    导入SerialGroup模块：from fabric import SerialGroup

​    多个主机上执行hostname:result = SerialGroup(host1, host2).run('hostname')



![img](https://upload-images.jianshu.io/upload_images/24447700-3ffc58a9c79dbf1c.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

​    我们也可以在py文件中来定义函数操作。



![img](https://upload-images.jianshu.io/upload_images/24447700-30b18973bac2f529.png?imageMogr2/auto-orient/strip|imageView2/2/w/639/format/webp)

​    运行结果如下：



![img](https://upload-images.jianshu.io/upload_images/24447700-8e9b06bbb334722e.png?imageMogr2/auto-orient/strip|imageView2/2/w/616/format/webp)

## **4、入口文件fabfile.py**    

​    Fabric典型的使用方法是创建一个入口文件fabfile.py，在文件中定义多个函数，然后使用fab命令调用这些函数。这些函数在Fabric中叫做task。

​    Fabric默认引用fabfile.py文件，也可以通过“-f”来指定fabfile文件。

​    现在我们将上面的基本重命名为fabfile.py，同时调用task模块，将main函数都定义为task任务，那么没有被@task的函数将不会被认为是任务task。同时，task函数需要有一个参数：Tasks must have an initial Context argument! 不然会报错，笔者在main里面写了个null在里面。



![img](https://upload-images.jianshu.io/upload_images/24447700-efe07208f8ab68b6.png?imageMogr2/auto-orient/strip|imageView2/2/w/542/format/webp)

​    那么就可以使用fab命令在命令行里面操作了。

​    查看可用的任务：fab -l

​    运行main任务：fab main



![img](https://upload-images.jianshu.io/upload_images/24447700-bc76bd8345caf3cf.png?imageMogr2/auto-orient/strip|imageView2/2/w/605/format/webp)

## **5、在上面的代码基础上，测试Connection、SerialGroup、ThreadingGroup**

三种方式是单个连接、串行、多线程并行方式来远程执行。



![img](https://upload-images.jianshu.io/upload_images/24447700-51f6e9d8883b5333.png?imageMogr2/auto-orient/strip|imageView2/2/w/485/format/webp)

测试结果如下：



![img](https://upload-images.jianshu.io/upload_images/24447700-80785e67d53201b6.png?imageMogr2/auto-orient/strip|imageView2/2/w/939/format/webp)





8人点赞



Python应用