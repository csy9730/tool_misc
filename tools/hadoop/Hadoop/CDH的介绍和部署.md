# CDH的介绍和部署

[![Strive追逐者](https://pica.zhimg.com/v2-b400d5d0c556002eeba1677f705986f1_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/17674043193)

[Strive追逐者](https://www.zhihu.com/people/17674043193)

Keep smiling, as if never sad

37 人赞同了该文章

**CDH：全称Cloudera’s Distribution Including Apache Hadoop。**


**CDH版本衍化**

> hadoop是一个开源项目，所以很多公司在这个基础进行商业化，Cloudera对hadoop做了相应的改变。
>
> Cloudera公司的发行版，我们将该版本称为CDH(Cloudera Distribution Hadoop)。

**Apache Hadoop 不足之处：**

```text
版本管理混乱
部署过程繁琐、升级过程复杂
兼容性差
安全性低
```

**Hadoop 发行版：**

```text
Apache Hadoop
Cloudera’s Distribution Including Apache Hadoop（CDH）
Hortonworks Data Platform (HDP) 
MapR
EMR
```

**Cloudera's Distribution, including Apache Hadoop（CDH）：**

```text
是Hadoop众多分支中的一种，由Cloudera维护，基于稳定版本的Apache Hadoop构建
提供了Hadoop的核心
可扩展存储
分布式计算
基于Web的用户界面
```

![img](https://pic2.zhimg.com/80/v2-ffb6a884d926bb7954c053989c551529_1440w.jpg)

**CDH的优点：**

```text
版本划分清晰
版本更新速度快
支持Kerberos安全认证
文档清晰
支持多种安装方式（Cloudera Manager方式）
```

**安装方式有：**

```text
Cloudera Manager
Yum
Rpm
Tarball
```

**网址：**

```text
CDH5.4
http://archive.cloudera.com/cdh5/
 
Cloudera Manager5.4.3：
http://www.cloudera.com/downloads/manager/5-4-3.html
```

**安装：**

首先准备三台虚拟机：

![img](https://pic3.zhimg.com/80/v2-d545e5cbcc53178e8fbba31dabd0cae6_1440w.jpg)

```text
这给出的内存已经很少了，因为只是模拟，在公司里面，都是物理，内存都是64以上的。。
还有：
首先得在你安装的磁盘中空闲出最少50g的内存，如：
```

![img](https://pic3.zhimg.com/80/v2-4dc161f58eb889e5e191a75f5e7b3726_1440w.jpg)

```text
我现在三台虚拟机什么都没装，也没启动，先启动，
```

![img](https://pic3.zhimg.com/80/v2-965eec766ca29d4c62f3ccc0249bb8da_1440w.jpg)

```text
它会先开辟预存12g占位，这还算少的了。。。。
 
启动后配置好静态IP，这个以前的文章有，然后开始SSH免密钥登录。
三台虚拟机，先把ssh给打理出来。
```

![img](https://pic3.zhimg.com/80/v2-7e5ff6622d4f57117078bb884881e0de_1440w.jpg)

![img](https://pic4.zhimg.com/80/v2-61ca7c474db0308c4e92f44f4d120763_1440w.jpg)

![img](https://pic2.zhimg.com/80/v2-ba2a4233199b394c4975bd9c00094a1d_1440w.png)

![img](https://pic1.zhimg.com/80/v2-e47cd7156818476e2c4705bbddc36474_1440w.jpg)

![img](https://pic2.zhimg.com/80/v2-3db51bce76cbf39e03d3260601d82fbd_1440w.jpg)

```text
然后在node07上自己免密自己，在08上免密07.
最后拷贝公钥文件到06和08：
scp authorized_keys node06:`pwd`
```

![img](https://pic3.zhimg.com/80/v2-55643570faf90feea984ff7440598e86_1440w.jpg)

**然后配置好后安装JDK：**

```text
https://www.cnblogs.com/underwing/p/linux-an-zhuang-rpm-dejdk.html
```

**然后记得对上ntp时间。**

**在安装mysql：**

![img](https://pic3.zhimg.com/80/v2-bd06621fb12f4b9ba6b91e2a733a6d26_1440w.jpg)

![img](https://pic3.zhimg.com/80/v2-e7c41a1f5c30e2dd33aa0fc4b48dc73e_1440w.jpg)

安装完成之后启动：

![img](https://pic1.zhimg.com/80/v2-74b5a50db62f621dd6d8a7694be7dd10_1440w.png)

![img](https://pic1.zhimg.com/80/v2-d8abd805a0211887cc79bb727b245ec8_1440w.jpg)

复制刚才那个路径；设置密码

![img](https://pic3.zhimg.com/80/v2-2ae59c6d371dfd6eef51b9d6f518e2ea_1440w.jpg)

![img](https://pic4.zhimg.com/80/v2-7fb99fe2ef268454fb10d864794bbe6f_1440w.jpg)

![img](https://pic2.zhimg.com/80/v2-b2759613582d93bfa14c1fc4eab33f71_1440w.jpg)

```text
GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' IDENTIFIED BY 'root' WITH GRANT OPTION;
```

![img](https://pic1.zhimg.com/80/v2-18ebb88413ecd357991e4e4e6723c6cc_1440w.png)

**之后三台虚拟机的~下执行命令：**

```text
yum install -y chkconfig python bind-utils psmisc libxsltzlib sqlite cyrus-sasl-plain  cyrus-sasl-gssapi fuse fuse-libs redhat-lsb
```

![img](https://pic2.zhimg.com/80/v2-a94b767b512607ab0d696b2990c008fd_1440w.png)

安装Cloudera Manager Server、Agent

所有节点创建：

![img](https://pic3.zhimg.com/80/v2-cfd6bb968aadf6158a34e86c3ba9c706_1440w.jpg)

![img](https://pic1.zhimg.com/80/v2-e264c3b58a2445515e978bf5b6d27178_1440w.jpg)

然后上传文件：

![img](https://pic2.zhimg.com/80/v2-14209c5cf1226a0110701850b38dab69_1440w.jpg)

文件：

链接：[https://pan.baidu.com/s/19KSjEflWqYuDKN13ZVbklA](https://link.zhihu.com/?target=https%3A//pan.baidu.com/s/19KSjEflWqYuDKN13ZVbklA)

提取码：wm3b

上传后解压：

![img](https://pic1.zhimg.com/80/v2-84e24445f150446ef1e4d8a2ebb56904_1440w.png)

解压后：

![img](https://pic2.zhimg.com/80/v2-8cbae4a658a9b4f8e8c7b36bce81bbb5_1440w.jpg)

![img](https://pic3.zhimg.com/80/v2-e401fba1c055f346361ab6368a0b0e0e_1440w.jpg)

之后给所有节点创建用户：

```text
useradd --system --no-create-home --shell=/bin/false --comment "Cloudera SCM User" cloudera-scm
```

![img](https://pic2.zhimg.com/80/v2-4eba6b66189049bbb025c30117dd0b51_1440w.jpg)

创建Parcel目录，Server节点（node06）：

mkdir -p /opt/cloudera/parcel-repo

chown cloudera-scm:cloudera-scm /opt/cloudera/parcel-repo



![img](https://pic1.zhimg.com/80/v2-de3994c293e447485dca5c0d70f421dc_1440w.jpg)

Agent节点（所有节点）：

mkdir -p /opt/cloudera/parcels

chown cloudera-scm:cloudera-scm /opt/cloudera/parcels

![img](https://pic4.zhimg.com/80/v2-5071ad39d089f1940f6d4387bb5fd6af_1440w.jpg)

![img](https://pic3.zhimg.com/80/v2-1f7b11a8d35abcc8350476a388cce83a_1440w.jpg)

配置CM Server数据库：

拷贝mysql jar文件到目录 /usr/share/java/（没有就创建）

![img](https://pic3.zhimg.com/80/v2-e2de55074d7d9b4be038eee07142d23a_1440w.jpg)

导入mysql，注意jar包名称要修改为mysql-connector-java.jar

![img](https://pic2.zhimg.com/80/v2-13ad08382538007fd7374840b0947609_1440w.jpg)

连接mysql，创建一个用户:

![img](https://pic2.zhimg.com/80/v2-84f55ed0d4d94ac3923e40830e063a29_1440w.jpg)

```text
grant all on *.* to 'temp'@'%' identified by 'temp' with grant option;
```

![img](https://pic1.zhimg.com/80/v2-4fbbd22cf2397f1999c58131feac4100_1440w.jpg)

```text
cd /opt/cloudera-manager/cm-5.4.3/share/cmf/schema/
```

![img](https://pic2.zhimg.com/80/v2-188d2dd9bf48dd989cb57b70e2d31bd5_1440w.jpg)

```text
./scm_prepare_database.sh mysql temp -h node06 -utemp -ptemp --scm-host node06 scm scm scm
```

![img](https://pic3.zhimg.com/80/v2-a7078e9fd64584c61b8b394849ee5a8e_1440w.png)

![img](https://pic1.zhimg.com/80/v2-06e943d445fb4bd24c5cf2b7eb5b48e4_1440w.jpg)

![img](https://pic2.zhimg.com/80/v2-993dcf8db633a83977cc05cd9dc05c6d_1440w.png)

![img](https://pic2.zhimg.com/80/v2-f3c7c86f10e2728a93c3616eb95cc699_1440w.png)

![img](https://pic4.zhimg.com/80/v2-4f5b2bbc927fe5973b4f9e859dc3b653_1440w.png)

![img](https://pic1.zhimg.com/80/v2-80bda723cb84837fd323d53590e0b068_1440w.png)

启动CM Server、Agent:

cd /opt/cloudera-manager/cm-5.4.3/etc/init.d/

./cloudera-scm-server start

![img](https://pic1.zhimg.com/80/v2-eddb05bdcdbf6ba8adacb67ad23662dc_1440w.jpg)

Sever首次启动会自动创建表以及数据，不要立即关闭或重启，否则需要删除所有表及数据重新安装

然后在所有节点上启动agent：

![img](https://pic4.zhimg.com/80/v2-dad0ba3a799325a0dcc810199eb7344b_1440w.png)

./cloudera-scm-agent start

![img](https://pic2.zhimg.com/80/v2-a49ec5588cd0c687f3d231af34023dd1_1440w.png)

格式：数据库类型、数据库、数据库服务器、用户名、密码、cm server服务器

启动时间，短至几分钟，长至十几二十分钟，看电脑配置而定

![img](https://pic3.zhimg.com/80/v2-adc0ec72ef1431e9283ce82578ec6c7a_1440w.jpg)

出现这个端口代表你可以访问了，

![img](https://pic2.zhimg.com/80/v2-23e5631d9fe1512997a0543984c2b385_1440w.jpg)

然后就可以安装你想要安装的了，

![img](https://pic4.zhimg.com/80/v2-43ef05d153673129ddcac5f6debf42e3_1440w.jpg)

![img](https://pic4.zhimg.com/80/v2-5385b821a917abd49f39349235576203_1440w.jpg)

![img](https://pic4.zhimg.com/80/v2-db78f5a4a62d8bf44bce946f0ec12e13_1440w.jpg)

模拟的话我们就只安装几个就好了，我内存也不大，就16g，上面很多都直接能把我安蹦的

![img](https://pic4.zhimg.com/80/v2-c8ed57691cf94f60154a8459857043cb_1440w.jpg)

这是根据你节点分配的，没什么要改的（在公司不一样），一直继续，

![img](https://pic1.zhimg.com/80/v2-6547638dc29bd317cf11705f69c577d0_1440w.jpg)

![img](https://pic1.zhimg.com/80/v2-a1e53de1772580d206428526478f8250_1440w.jpg)

如果其中失败了，就去诊断看原因，去首页，找到安装那个配置，去看下。

![img](https://pic1.zhimg.com/80/v2-242c26e1a37b353751025cbc97573690_1440w.jpg)

![img](https://pic1.zhimg.com/80/v2-507c615161d05ef27e02c69497ddc0d4_1440w.jpg)



发布于 2019-08-10 17:24

[大数据](https://www.zhihu.com/topic/19740929)

[CDH(Cloudera)](https://www.zhihu.com/topic/20210213)

[程序员](https://www.zhihu.com/topic/19552330)

赞同 3713 条评论

分享

喜欢收藏申请转载