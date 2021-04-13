# [**Jenkins**的**制品****管理**](https://www.cnblogs.com/undefined22/p/12550912.html)



# **Jenkins**的**制品****管理**

### **制品**是什么？

也叫产出物或工件。**制品**是软件开发过程中产生的多种有形副产品之一。广义的**制品**包括用例、UML图、设计文档等。而狭义的**制品**就可以简单地理解为二进制包。虽然有些代码是不需要编译就可以执行的，但是我们还是习惯于将这些可执行文件的集合称为二进制包。

### **制品****管理**仓库

最简单的**制品****管理**仓库就是将**制品**统一放在一个系统目录结构下。但是很少有人这样做，更多的做法是使用现成的**制品**库。

**制品****管理**涉及两件事情：一是如何将**制品**放到**制品**库中；二是如何从**制品**库中取出**制品**。

目前现成的**制品**库有：Nexus、Artifactory。（nexus经常被用来搭建maven私有仓库）

### docker安装Nexus

查找镜像

```
$ docker search nexus
```

下载镜像

```
$ docker pull sonatype/nexus3
```

启动容器

```
docker run -d --name nexus3 \
 --restart=always \
-p 8081:8081 \
-p 8082:8082  \
-p 8083:8083  \
-p 8084:8084  \
-p 8085:8085   \
-v /opt/nexus-data:/nexus-data \
sonatype/nexus3
```

### archiveArtifacts**制品****管理**

archiveArtifacts步骤能对**制品**进行归档，然后你就可以从**Jenkins**页面上下载**制品**了，如图

![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110618448-209088732.jpg)

Jenkinsfile内容如下：

![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110618769-2068469700.jpg)

archiveArtifacts的参数

• artifacts（必填）：字符串类型，需要归档的文件路径，使用的是Ant风格路径表达式。

• fingerprint（可选）：布尔类型，是否对归档的文件进行签名。

• excludes（可选）：字符串类型，需要排除的文件路径，使用的也是Ant风格路径表达式。

• caseSensitive（可选）：布尔类型，对路径大小写是否敏感。

• onlyIfSuccessful（可选）：布尔类型，只在构建成功时进行归档。

archiveArtifacts步骤并不只用于归档JAR包，事实上，它能归档所有类型的**制品**。

### **管理**Java栈**制品**

1. 使用maven发布**制品**到nexus中

   Maven Deploy插件能将JAR包及POM文件发布到Nexus中

   ![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110619238-85915315.jpg)

   使用Deploy插件发布需要以下几个步骤。

   （1）配置发布地址。在Maven项目的POM文件中加入：

   ![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110619774-215954914.jpg)

   Deploy插件会根据Maven项目中定义的version值决定是使用nexus-snapshot仓库还是nexus-release仓库。当version值是以-SNAPSHOT后缀结尾时，则发布到nexus-snapshot仓库。

   （2）配置访问Nexus的用户名和密码。在Nexus中，我们配置了只有授权的用户名和密码才能发布**制品**。这时需要在Maven的settings.xml中加入配置：

   ![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110620253-1728076753.jpg)

2. 使用Nexus插件发布**制品**

   安装Nexus Platform插件

   （1）进入Manage **Jenkins**→Configure System→Sonatype Nexus页，设置Nexus 3.x的服务器地址，如图

   ![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110620654-557240702.jpg)

   • 在“Credentials”选项处，增加了一个具有发布**制品**到Nexus中的权限的用户名和密码凭证。

   • Server ID字段的值，在Jenkinsfile中会引用。

   设置完成后，单击“Test connection”按钮测试设置是否正确。

   （2）在Jenkinsfile中加入nexusPublisher步骤。

   ![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110621224-986346563.jpg)

    nexusPublisher的参数介绍：

    • nexusInstanceId：在**Jenkins**中配置Nexus 3.x时的Server ID。

    • nexusRepositoryId：发布到Nexus服务器的哪个仓库。

    • mavenCoordinate：Maven包的坐标，packaging值与Maven中的packaging值一致，可以是jar、war、pom、hpi等。

    • mavenAssetList：要发布的文件，如果是pom.xml，则extension必须填“xml”。

   此插件的缺点：

    • 每个Maven项目都可能不同，必须为每个Maven项目写nexusPublisher方法。

    • 对于多模块的Maven项目，nexusPublisher的参数写起来十分啰唆。

### 使用Nexus**管理**Docker镜像

1. Nexus：创建Docker私有仓库

   进入Nexus的仓库列表页：Administration→Repository→Repositories，单击“docker（hosted）”

   ![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110622263-2092118523.jpg)

   指定Docker私有仓库提供HTTP服务的端口为8595。私有仓库的地址为：http：//＜ip>：8595。

   ![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110623407-1580832049.jpg)

2. 创建Docker私有仓库凭证

   将镜像推送到Docker私有仓库是需要用户名和密码的。我们不能将密码明文写在Jenkinsfile中，所以需要创建一个“Username with password”凭证。

3. 构建并发布Docker镜像

   当私有仓库创建好后，我们就可以构建Docker镜像并发布到仓库中了。假设Dockerfile与Jenkinsfile在同一个目录下，我们看一下Jenkinsfile的内容。

   ![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110623904-819629707.jpg)

    withDockerRegistry步骤做的事情实际上就是先执行命令：docker login-u admin-p********http：[//192.168.0.101](https://192.168.0.101/)：8595。其间，所生成的config.json文件会存储在工作空间中。然后再执行闭包内的命令。

   将镜像推送到Nexus中后，在Nexus中可以看到如图

   ![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110624744-814462763.jpg)

   注：由于是私有的非安全（HTTP）的仓库，所以需要配置Docker的daemon.json。

   ![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110625438-1789991685.jpg)

### Nexus raw**制品****管理**

 raw仓库可以被理解为一个文件系统，我们可以在该仓库中创建目录。

1. 创建raw仓库

   进入Administration→Repository→Repositories页

   ![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110629403-1709654001.jpg)

   单击“raw（hosted）”，进入raw仓库创建页。

   输入仓库名称“raw-example”，单击“Create repository”按钮，确认后创建成功。该仓库的地址是：＜你的Nexus地址>/repository/raw-example/。

   ![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110631235-1324985056.jpg)

2. 上传**制品**，获取**制品**

使用HTTP客户端就可以将**制品**上传到raw仓库中。我们使用Linux curl命令。

（1）在**Jenkins**上添加“Username with password”凭证，如图所示。

![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110631915-1119934012.jpg)
（2）在Jenkinsfile中加入上传**制品**的步骤。

![file](https://img2020.cnblogs.com/blog/1973632/202003/1973632-20200323111110543-1230286577.png)

curl命令的格式为：

![file](https://img2020.cnblogs.com/blog/1973632/202003/1973632-20200323111120688-1459669330.png)

如果目录不存在，nexus将会自动创建

1. 在**Jenkins** pipeline中获取原始**制品**时，我们同样使用curl命令。

   ![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110633640-2042435927.jpg)

### 从其他pipeline中拷贝**制品**

1. 安装Copy Artifact插件
2. 代码：从core项目中拿到最后一次构建成功的**制品**。

![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110634217-98882918.jpg)
copyArtifacts步骤的参数详解：

 • projectname（必填）：字符串类型，**Jenkins** job或pipeline名称。

 • selector：BuildSelector类型，从另一个pipeline中拷贝**制品**的选择器，默认拷贝最后一个**制品**。

 • parameters：字符串类型，使用逗号分隔的键值对字符串（name1=value1，name2=value2），用于过滤从哪些构建中拷贝**制品**。

 • filter：字符串类型，Ant风格路径表达式，用于过滤需要拷贝的文件。

 • excludes：字符串类型，Ant风格路径表达式，用于排除不需要拷贝的文件。

 • target：字符串类型，拷贝**制品**的目标路径，默认为当前pipeline的工作目录。

 • optional：布尔类型，如果为true，则拷贝失败，但不影响本次构建结果。

 • fingerprintArtifacts：布尔类型，是否对**制品**进行签名，默认值为true。

 • resultVariableSuffix：上例中，无法得知我们到底拿的是core项目的哪次构建的**制品**。CopyArtifact 插件的设计是将其构建次数放到一个环境变量中。这个环境变量名就是在COPYARTIFACT BUILD NUMBER 后拼上resultVariableSuffix，比如resultVariableSuf fix值为corejob，那么就在pipeline中通过变量COPYARTIFACT BUILD NUMBER corejob拿到源pipeline的构建次数了。

 几种常用的获取选择器：

• lastSuccessful：最后一次构建成功的**制品**。方法签名为lastSuccessful（boolean stable）。stable为true表示只取构建成功的**制品**，为false表示只要构建结果比UNSTABLE好就行。

• specific：指定某一次构建的**制品**。方法签名为specific（String buildNumber）。buildNum ber表示指定取第n次构建的**制品**。

• lastCompleted：最后一次完成构建的**制品**，不论构建的最终状态如何。方法签名为lastCompleted（）。

• latestSavedBuild：最后一次被标记为keep forever的构建的**制品**。方法签名为latestSavedBu ild（）。

### 版本号**管理**

语义化版本格式为：主版本号.次版本号.修订号。版本号递增规则如下：

• 主版本号：当作了不兼容的API修改时。

• 次版本号：当作了向下兼容的功能性新增时。

• 修订号：当作了向下兼容的问题修正时。

先行版本号及版本编译元数据可以加到“主版本号.次版本号.修订号”的后面，作为延伸。以下是常用的修饰词。

• alpha：内部版本。

• beta：测试版本。

• rc：即将作为正式版本发布。

• lts：长期维护。

方便生成版本号的Version Number插件

![file](https://img2020.cnblogs.com/other/1973632/202003/1973632-20200323110635236-1729763615.jpg)

VersionNumber步骤支持以下参数。

• versionNumberString：字符串类型，版本号格式，用于生成版本号。只能使用单引号，以防格式中的占位符被转义。版本号格式支持多种占位符，稍后介绍。

• versionPrefix：字符串类型，版本号的前缀。

• projectStartDate：字符串类型，项目开始时间，格式为yyyy-MM-dd，用于计算项目开始后的月数和年数。

• worstResultForIncrement：字符串类型，如果本次构建状态比上一次构建状态更糟糕，则BUILDS_TODAY、BUILDS_THIS_WEEK、BUILDS_THIS_MONTH、BUILDS_THIS_YEAR占位符的值不会增加。worstResultForIncrement可以设置的值有SUCCESS、UNSTABLE、FAILURE、ABORTED、NOT_BUILT（默认）。此参数较少使用。versionNumberString参数使用占位符生成版本号。部分占位符本身支持参数化。接下来分别介绍它们。

• BUILD DATE FORMATTED：格式化的构建日期，支持参数化，如${BUILD DATEFORMATTED，"yyyy-MM-dd"}。

• BUILD DAY：构建日期，支持X和XX参数。比如是12月2日，${BUILD DAY}将返回2，${BUILD DAY，X}将返回2，${BUILD DAY，XX}将返回03。

• BUILD WEEK：今年构建的星期数，支持X和XX参数。

• BUILD MONTH：今年构建的月数，支持X和XX参数。

• BUILD YEAR：今年构建的年份。

比如构建的时间为2018-12-02，那么BUILD_DAY的值为2，BUILD_WEEK的值为49，BUILD_MONTH的值为12，BUILD_YEAR的值为2018。

接下来是一组和构建数相关的占位符：BUILDS TODAY、BUILDS THIS WEEK、BUILDS THISMONTH、BUILDS THIS YEAR，它们分别表示当天、本星期、本月、本年完成的构建数。

BUILDS ALL TIME表示自从项目开始后完成的总构建数。MONTHS SINCE PROJECT START和YEARS SINCE PROJECT START分别表示自项目开始日期起已过去的日历月数和年数。