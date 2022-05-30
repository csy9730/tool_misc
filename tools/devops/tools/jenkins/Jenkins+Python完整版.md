# Jenkins+Python完整版

[![img](https://upload.jianshu.io/users/upload_avatars/6620012/62aba910-e108-48a6-8d62-1a581a2ba080.png?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)](https://www.jianshu.com/u/5dc63866c280)

[编程小蝉](https://www.jianshu.com/u/5dc63866c280)关注

0.1382017.08.12 15:16:53字数 1,719阅读 8,834

### 一、简介

一般网站部署的流程 这边是完整流程而不是简化的流程
需求分析—原型设计—开发代码—内网部署-提交测试—确认上线—备份数据—外网更新-最终测试，如果发现外网部署的代码有异常，需要及时回滚
一般是运维来做 功能测试 上线的时间 jenkins 运维 功能测试

### 部署流程

我们可以通过jenkins工具平台实现全自动部署+测试，是一个可扩展的持续集成引擎，是一个开源软件项目，旨在提供一个开放易用的软件平台，使软件的持续集成变成可能。Jenkins非常易于安装和配置，简单易用
简单来说方便如下人员：

1. 开发人员：写好代码，不需要自己进行源码编译、打包等工作，直接将代码分支存放在SVN、GIT仓库即可。 war 源码多 自动把代码放到服务器上面
2. 运维人员：减轻人工干预的错误率，ansible 一键完成了 同时解放运维人员繁杂的上传代码、手动备份、更新
3. 测试人员：可以通过jenkins进行简单的代码及网站测试

- 持续集成的意义(总结 提升工作效率)

1. 持续集成中的任何一个环节都是自动完成的，无需太多的人工干预，有利于减少重复过程以节省时间、费用和工作量
2. 持续集成保障了每个时间点上团队成员提交的代码是能成功集成的。换言之，任何时间点都能第一时间发现软件的集成问题，使任意时间发布可部署的软件成为了可能
3. 持续集成还能利于软件本身的发展趋势，这点在需求不明确或是频繁性变更的情景中尤其重要，持续集成的质量能帮助团队进行有效决策，同时建立团队对开发产品的信心

### 持续集成的组件

1. 一个自动构建过程，包括自动编译、分发、部署和测试
2. 一个代码存储库，即需要版本控制软件来保障代码的可维护性，同时作为构建过程的素材库，例如SVN、GIT代码库
3. 一个jenkins持续集成服务器就是一个配置简单和使用方便的持续集成服务器

### 二、jenkins安装

由于jenkins是使用java代码开发的，所以我们需要安装java容器才能运行jenkins,又因为java的web服务器用的是tomcat，所以我们要安装JDK+Tomcat

- 安装jenkins+tomcat



```csharp
[root@vagrant-centos65 ~]# yum -y install java-1.8.0-openjdk.x86_64

[root@vagrant-centos65 ~]# cd /opt/

[root@vagrant-centos65 opt]# wget http://mirrors.tuna.tsinghua.edu.cn/apache/tomcat/tomcat-7/v7.0.79/bin/apache-tomcat-7.0.79.tar.gz

[root@vagrant-centos65 opt]# tar zxvf apache-tomcat-7.0.79.tar.gz

[root@vagrant-centos65 opt]# mkdir -p /usr/local/tomcat

[root@vagrant-centos65 opt]# mv apache-tomcat-7.0.79/* /usr/local/tomcat
```

- 安装jenkins



```ruby
[root@vagrant-centos65 ~]# cd /opt/

[root@vagrant-centos65 opt]# wget http://mirrors.tuna.tsinghua.edu.cn/jenkins/redhat/jenkins-2.60-1.1.noarch.rpm

[root@vagrant-centos65 opt]# rpm -ivh jenkins-2.60-1.1.noarch.rpm

[root@vagrant-centos65 opt]# /etc/init.d/jenkins start
Starting Jenkins                                           [  OK  ]

[root@vagrant-centos65 opt]# netstat -tnlp | grep 8080

[root@vagrant-centos65 opt]# /etc/init.d/jenkins start
Starting Jenkins                                           [  OK  ]

[root@vagrant-centos65 opt]# netstat -tnlp | grep 8080
tcp        0      0 :::8080                     :::*                        LISTEN     7599/java 
```

![img](https://upload-images.jianshu.io/upload_images/6620012-cb5aece1c192a4bd.png?imageMogr2/auto-orient/strip|imageView2/2/w/765/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-25d82f5b27f1796b.png?imageMogr2/auto-orient/strip|imageView2/2/w/999/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-86a59fbbee875d93.png?imageMogr2/auto-orient/strip|imageView2/2/w/992/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-9acfa3b2580635fd.png?imageMogr2/auto-orient/strip|imageView2/2/w/800/format/webp)

### 三、升级python2.6到python2.7

由于django1.7之后的版本就不支持python2.6了 所有需要我们升级python2.6--python2.7



```csharp
[root@vagrant-centos65 ~]# yum -y install  zlib zlib-devel openssl openssl-devel  sqlite-devel
[root@vagrant-centos65 ~]# wget http://python.org/ftp/python/2.7.3/Python-2.7.3.tar.bz2
[root@vagrant-centos65 ~]# tar -jxvf Python-2.7.3.tar.bz2
[root@vagrant-centos65 ~]# cd Python-2.7.3
[root@vagrant-centos65 Python-2.7.3]# ./configure    --prefix=/usr/local/python2.7
[root@vagrant-centos65 Python-2.7.3]# make && make install
[root@vagrant-centos65 Python-2.7.3]# cd /usr/bin/
[root@vagrant-centos65 bin]# ll | grep python
-rwxr-xr-x.   2 root root      4864 Nov 22  2013 python
lrwxrwxrwx.   1 root root         6 Jan 16  2014 python2 -> python
-rwxr-xr-x.   2 root root      4864 Nov 22  2013 python2.6
[root@vagrant-centos65 bin]# mv python python2.6.bak
[root@vagrant-centos65 bin]# ln -s /usr/local/python2.7/bin/python /usr/bin/python
[root@vagrant-centos65 bin]# vi /usr/bin/yum
#!/usr/bin/python2.6
```

### 五、安装django

- 安装setuptools

  pip的安装需要依赖setuptools，所有需要先安装setuptools



```csharp
[root@vagrant-centos65 bin]# cd /opt/

[root@vagrant-centos65 opt]# wget https://pypi.python.org/packages/61/3c/8d680267eda244ad6391fb8b211bd39d8b527f3b66207976ef9f2f106230/setuptools-1.4.2.tar.gz

[root@vagrant-centos65 opt]# tar zxvf setuptools-1.4.2.tar.gz

[root@vagrant-centos65 opt]# cd setuptools-1.4.2

[root@vagrant-centos65 setuptools-1.4.2]# python setup.py install
```

- 安装pip



```csharp
[root@vagrant-centos65 ~]# cd /opt/

[root@vagrant-centos65 opt]# wget "https://pypi.python.org/packages/source/p/pip/pip-1.5.4.tar.gz#md5=834b2904f92d46aaa333267fb1c922bb" --no-check-certificate

[root@vagrant-centos65 opt]# tar zxvf pip-1.5.4.tar.gz

[root@vagrant-centos65 opt]# cd pip-1.5.4

[root@vagrant-centos65 pip-1.5.4]# python setup.py install

[root@vagrant-centos65 pip-1.5.4]# pip
-bash: pip: command not found

[root@vagrant-centos65 pip-1.5.4]# find / -name pip
/usr/local/python2.7/bin/pip
/usr/local/python2.7/lib/python2.7/site-packages/pip-1.5.4-py2.7.egg/pip

[root@vagrant-centos65 pip-1.5.4]# ln -s /usr/local/python2.7/bin/pip /usr/bin/pip
```

- 安装django



```css
[root@vagrant-centos65 pip-1.5.4]# pip install django
[root@vagrant-centos65 pip-1.5.4]# pip list
Django (1.11.3)
pip (1.5.4)
pytz (2017.2)
setuptools (1.4.2)
wsgiref (0.1.2)
```

六、安装插件

插件管理
如果插件下载失败 更换源 [http://mirror.xmission.com/jenkins/updates/current/update-center.json](https://link.jianshu.com/?t=http://mirror.xmission.com/jenkins/updates/current/update-center.json)
因为我们只需要构建python项目 所以我们这边只需要2个插件

1. git plugin
2. python plugin
3. pipeline

![img](https://upload-images.jianshu.io/upload_images/6620012-9c99c026bfa64b11.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-db8eacd1162ae15d.png?imageMogr2/auto-orient/strip|imageView2/2/w/956/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-a3071fdf7bbca9a2.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-451504a7b3395d66.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

七、创建项目

![img](https://upload-images.jianshu.io/upload_images/6620012-a460be033e620439.png?imageMogr2/auto-orient/strip|imageView2/2/w/814/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-86da1d7ee45dbbeb.png?imageMogr2/auto-orient/strip|imageView2/2/w/831/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-40b22ca7a874d9ca.png?imageMogr2/auto-orient/strip|imageView2/2/w/896/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-bea2ed2a2c850ea6.png?imageMogr2/auto-orient/strip|imageView2/2/w/651/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-2e58a62af078779e.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-cd8eea9e06e716c4.png?imageMogr2/auto-orient/strip|imageView2/2/w/810/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-82175b135741715f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1007/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-ee632047f3d1a40f.png?imageMogr2/auto-orient/strip|imageView2/2/w/1014/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-26d4bb6369ac6c5d.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-6bcb9908f2ffbbca.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-f60aa5400799ecb6.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

- 总结



```undefined
第一步 创建项目

创建任务  名字 master-build   自由代码风格

1. 丢弃旧的构建 (保留7天,最大构建的最大数100)
2. 源码管理  选择git  如果我们需要从码云拉取代码那么我们需要把私钥放到jenkins 公钥放到码云上面去 这样我们就可以拉取我们的代码了
```

- 构建触发器
- poll SCM(日常表 可以根据时间来判断)

H/2 * * * * (2分钟检查一下版本库 如果有更新就不触发 如果没有更新就不触发)
注：Schedule的配置规则是有5个空格隔开的字符组成，从左到右分别代表：分 时 天 月 年。*代表所有，0 20 * * * 表示“在任何年任何月任何天20点0分”进行构建

![img](https://upload-images.jianshu.io/upload_images/6620012-6608ea9474715663.png?imageMogr2/auto-orient/strip|imageView2/2/w/1024/format/webp)

- 构建

execute shell



```bash
cd django    项目目录
python mange.py test 测试代码
```

![img](https://upload-images.jianshu.io/upload_images/6620012-2def8f1ad0a05152.png?imageMogr2/auto-orient/strip|imageView2/2/w/1006/format/webp)

- 构建后的操作

选择 email notifications

输入你的邮箱 选中每次不稳定的构建都发送邮件

![img](https://upload-images.jianshu.io/upload_images/6620012-addcb0602d6dd7c9.png?imageMogr2/auto-orient/strip|imageView2/2/w/778/format/webp)

### 八、创建部署项目

创建一个新的job
itemname : master deploy
copyfrom : master-build 点击ok

![img](https://upload-images.jianshu.io/upload_images/6620012-853ef430567a0633.png?imageMogr2/auto-orient/strip|imageView2/2/w/713/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-1bb362759e0d8eae.png?imageMogr2/auto-orient/strip|imageView2/2/w/1026/format/webp)

- 修改触发器

Build after other projects are built (勾选这一项)
projects to watch (master_build) 当前一个动作构建成功后我才触发

![img](https://upload-images.jianshu.io/upload_images/6620012-7cf746dde7bfaf9d.png?imageMogr2/auto-orient/strip|imageView2/2/w/1013/format/webp)

- 构建

  

  ```bash
  cd testdjango  
  BUILD_ID=DONTKILLME nohup python manage.py runserver 0.0.0.0:8000 &
  ```

  BUILD_ID=DONTKILLME : 在jenkins里面在后台运行的程序都会被jenkins自动杀死 所以需要加上BUILDID这个参数 加了这个参数你的程序就不会被杀死

![img](https://upload-images.jianshu.io/upload_images/6620012-3e5dfa4801cb469a.png?imageMogr2/auto-orient/strip|imageView2/2/w/665/format/webp)

最后提交并构建！

一旦用pycharm修改项目，并push上去，jenkins就会每两分钟检查一次是否改变，如果改变就会触发构建！

![img](https://upload-images.jianshu.io/upload_images/6620012-7c70e9e4057ca083.png?imageMogr2/auto-orient/strip|imageView2/2/w/778/format/webp)

![img](https://upload-images.jianshu.io/upload_images/6620012-f11e9738b2a04063.png?imageMogr2/auto-orient/strip|imageView2/2/w/777/format/webp)

### 创建一个job webhook钩子 只要收到一个push请求 就会发送一个post的请求给jenkins

第一步 创建项目
创建任务 名字 master-build 自由代码风格

1. 丢弃旧的构建 (保留7天,最大构建的最大数100)
2. 源码管理 选择git 如果我们需要从码云拉取代码那么我们需要把私钥放到jenkins 公钥放到码云上面去 这样我们就可以拉取我们的代码了



```jsx
ssh-keygen -t rsa -C "tanzhou@qq.com"
生成公钥和私钥
cat ~/.ssh/id_rsa.pub    发送给码云
cat ~/.ssh/id_rsa        写入到jenkins
```

1. 构建触发器
   poll SCM(日常表 可以根据时间来判断)
   H/2 * * * * (2分钟检查一下版本库 如果有更新就不触发 如果没有更新就不触发)
   注：Schedule的配置规则是有5个空格隔开的字符组成，从左到右分别代表：分 时 天 月 年。*代表所有，0 20 * * * 表示“在任何年任何月任何天20点0分”进行构建
2. 构建
   execute shell



```bash
cd testdjango  #进入项目所在的目录
python mange.py test
```

1. 构建后操作
   选择 email notifications
   输入你的邮箱 选中每次不稳定的构建都发送邮件

### 创建一个构建job

创建一个新的job
itemname : master deploy
copyfrom : master-build 点击ok

------

其他都不需要改 只需要改2个地方

### 第一个地方

- 构建触发器
  Build after other projects are built (勾选这一项)
  projects to watch (master_build) 当前一个动作构建成功后我才触发

### 第二个地方

- 构建



```bash
cd testdjango  
BUILD_ID=DONTKILLME nohup python manage.py runserver 0.0.0.0:8000 &
```

BUILD_ID=DONTKILLME : 在jenkins里面在后台运行的程序都会被jenkins自动杀死 所以需要加上BUILDID这个参数 加了这个参数你的程序就不会被杀死

### linux升级python 由于django1.7之后的版本就不支持python2.6了 所有需要我们升级python2.6--python2.7



```bash
yum -y install  zlib zlib-devel openssl openssl-devel  sqlite-devel
#wget http://python.org/ftp/python/2.7.3/Python-2.7.3.tar.bz2  
#tar -jxvf Python-2.7.3.tar.bz2 
#cd Python-2.7.3  
#./configure    --prefix=/usr/local/python2.7
#make           
#make install  
cd /usr/bin/
mv python  python2.6.bak
ln -s /usr/local/python2.7/bin/python /usr/bin/python
---
install setuptools 
wget https://pypi.python.org/packages/61/3c/8d680267eda244ad6391fb8b211bd39d8b527f3b66207976ef9f2f106230/setuptools-1.4.2.tar.gz
tar xvf  setuptools-1.4.2.tar.gz  
cd setuptools
python setup.py install 
install pip 
wget "https://pypi.python.org/packages/source/p/pip/pip-1.5.4.tar.gz#md5=834b2904f92d46aaa333267fb1c922bb" --no-check-certificate
tar xvf   pip-1.5.4.tar.gz
cd pip-1.5.4
python setup.py install 
ln -s /usr/local/python2.7/bin/pip /usr/bin/pip

pip install django
```

### 免密码登录



```jsx
$ scp ~/.ssh/id_rsa.pub root@<remote_ip>:pub_key //将文件拷贝至远程服务器
$ cat ~/pub_key >>~/.ssh/authorized_keys //将内容追加到authorized_keys文件中， 不过要登录远程服务器来执行这条命令
```

cd /data/django11/testdjango
git pull
BUILD_ID=DONTKILLME nohup python manage.py runserver 0.0.0.0:8000 &
exit

ssh root@172.16.147.21 'bash -x -s' < /data/sh/[startdj.sh](https://link.jianshu.com/?t=http://startdj.sh)

另外，如果是对自动化运维感兴趣的朋友，可以加入群：526929231，一起学习和讨论哦~~



10人点赞



[自动化运维](https://www.jianshu.com/nb/15346051)