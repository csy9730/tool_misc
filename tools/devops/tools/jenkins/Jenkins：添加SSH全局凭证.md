# [Jenkins：添加SSH全局凭证](https://www.cnblogs.com/dotnet261010/p/12393917.html)

# 一、什么是凭证

## 1、凭据简介

有许多第三方网站和应用程序可以与Jenkins进行交互，例如代码仓库GitHub等。

此类应用程序的系统管理员可以在应用程序中配置凭证以专供Jenkins使用。通常通过将访问控制应用于这些凭证来完成这项工作，以“锁定Jenkins可用的应用程序功能区域”。一旦Jenkins管理员在Jenkins中添加/配置这些凭证，Jenkins项目就可以使用凭证与这些第三方应用程序进行交互。

Jenkins中保存的凭证可以用于：

- 适用于Jenkins的任何地方（即全局证书）。
- 特定的Jenkins项目。
- 特定的Jenkins用户。

## 2、凭据分类

Jenkins可以保存下面几种凭证：

- Secret text：例如 API Token（例如GitHub的个人access token）。
- Username with password：指的是登录GitHub的用户名和密码，可以作为单独的组件处理，也可以作为username:password格式的冒号分割字符串来处理。
- Secret file：实际上是文件中的秘密内容。
- SSH Username with private key：即使用私钥的SSH 用户名。这是一个SSH 秘钥对。公钥配置在GitHub上面，这里添加私钥。
- Certificate：即证书。一个PKCS#12证书文件和可选的密码。
- Docker Host Certificate Authentication：即Docker主机证书身份验证凭证。

这些凭证的分类可以在全局凭据里面看到：

![img](https://img2020.cnblogs.com/i-beta/1033738/202003/1033738-20200302203504870-2014049220.png)

## 3、凭据安全

为了确保安全，Jenkins中配置的凭据在Jenkins主实例中加密存储（通过Jenkins实例的ID来加密），并且只能通过它们的凭据ID在Pipeline项目中处理。

这样就最大限度地减少了向Jenkins用户暴露实际证书本身的可能性，并且限制了将功能证书从一个Jenkins实例复制到另一个Jenkins实例的能力。

# 二、添加凭据

我们这里以添加SSH Username with private key为例，讲解如何添加一个Jenkins的凭据。

在上面说过，SSH凭据需要一对私钥，所以我们首先需要生成SSH Key。

使用下面的命令可以生成SSH Key：

```
$ ssh-keygen -t rsa -C "your_email@youremail.com"
```

如下图所示：

![img](https://img2020.cnblogs.com/i-beta/1033738/202003/1033738-20200302131710650-1197262430.png)

所有选项都是默认，一直回车即可生成。生成之后在.ssh文件夹下就会生成文件，如下图所示：

![img](https://img2020.cnblogs.com/i-beta/1033738/202003/1033738-20200302132024634-895054440.png)

一共会生成两个文件：

- id_rsa。这个是私钥文件。
- id_rsa.pub。这个是公钥文件，需要配置到GitHub上面。

登录GitHub，然后在账户下面选择“Settings”：

![img](https://img2020.cnblogs.com/i-beta/1033738/202003/1033738-20200302132312881-1104980924.png)

然后选择“SSH and GPG keys”：

![img](https://img2020.cnblogs.com/i-beta/1033738/202003/1033738-20200302132503284-284656164.png)

 然后点击“New SSH key”，把生成的id_rsa.pub文件里面的内容拷贝进来即可：

![img](https://img2020.cnblogs.com/i-beta/1033738/202003/1033738-20200302132748981-239326181.png)

这样就添加完成了SSH key。

![img](https://img2020.cnblogs.com/i-beta/1033738/202003/1033738-20200302133358208-2100840258.png)

Jenkins在拉取git项目代码的时候，如果没有配置“证书凭证Credentials”或者配置的不对，就会出现如下图所示的报错信息：

![img](https://img2018.cnblogs.com/i-beta/1033738/202003/1033738-20200302091431630-1332238190.png)

这时候就需要添加证书凭证Credentials，有两种方式添加证书凭证。

## 1、创建的时候添加

 点击Credentials后面的"Add"，选择“Jenkins”，如下图所示：

![img](https://img2018.cnblogs.com/i-beta/1033738/202003/1033738-20200302091910089-1002474928.png)

 然后选择“SSH Username with private key”，如下图所示：

![img](https://img2018.cnblogs.com/i-beta/1033738/202003/1033738-20200302091957012-801717899.png)

 选择Private Key，如下图所示：

![img](https://img2018.cnblogs.com/i-beta/1033738/202003/1033738-20200302092240451-118238665.png)

把上面生成的私钥复制到这里，给Username起一个名称即可。

![img](https://img2020.cnblogs.com/i-beta/1033738/202003/1033738-20200302171927679-2032817418.png)

最后点击“添加”按钮即可完成添加SSH 凭证。

> 注意：这里在拷贝私钥的时候，一定要把生成的私钥文件里面的所有内容都拷贝进来。

在选择凭证的时候选择刚才添加的凭证，这时就不会在报错了：

![img](https://img2020.cnblogs.com/i-beta/1033738/202003/1033738-20200302172216940-1260333441.png)

## 2、在凭证里面添加

我们也可以在凭据里面添加

![img](https://img2018.cnblogs.com/i-beta/1033738/202003/1033738-20200302092613239-1205721821.png)

同样还是选择“SSH Username with private key”，如下图所示：

![img](https://img2018.cnblogs.com/i-beta/1033738/202003/1033738-20200302092705928-899817050.png)

然后下面的步骤和刚才的就一样了，输入生成的私钥即可。这样就配置好了SSH凭据。

分类: [Jenkins](https://www.cnblogs.com/dotnet261010/category/1539926.html)