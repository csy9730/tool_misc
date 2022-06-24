# 可能是最便捷vscode remote离线部署教程

![img](https://upload.jianshu.io/users/upload_avatars/30068/6b924815-19c4-4561-86ca-d82d34474736.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[大山鼠](https://www.jianshu.com/u/432092fa4c92)关注

2021.01.02 10:23:25字数 1,156阅读 3,516



![img](https://upload-images.jianshu.io/upload_images/30068-23975a3314fb11d9.png?imageMogr2/auto-orient/strip|imageView2/2/w/750/format/webp)

Vim党一直以来是Linux界大神级的存在，无Vim不Linux似乎成为了极客的标志，但过高的门槛也隔绝了很多人进入Linux服务器编程的可能性，直到vscode remote的出现，为Linux服务器开发带来了大众化的曙光。

在vscode remote出现之前，Linux服务器编程无外乎3条路，第一类是vim或emacs大神们通过安装各种插件在键盘上一顿乱舞，普通人表示力所不能及；第二类是xx编辑器+FTP远程挂在目录编辑，断连和文件编辑冲突是常态；第三类是git同步，这可能是最可靠的一种，但一个人用git是不是有点孤单。

但是vscode remote的使用也不是很容易，特别是在离线环境下，配置起来可能有些复杂，网上也有不少教程，但我觉得原理性不强。今天就根据自己的开发经验，给出一个原理性的教程，目的是让不熟悉Linux的人也能使用vscode remote进行远程编程。

## 基础安装包和插件

1. [vscode](https://links.jianshu.com/go?to=https%3A%2F%2Fcode.visualstudio.com%2Fdownload)

2. vscode remote 插件

   

   ![img](https://upload-images.jianshu.io/upload_images/30068-4521f4b2ab3605f7.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

   红色部分是下载链接

3. git-windows

   

   ![img](https://upload-images.jianshu.io/upload_images/30068-a7c10a6c2c4cf826.png?imageMogr2/auto-orient/strip|imageView2/2/w/868/format/webp)

   image.png

## 下载vscode remote服务器程序（重要）

这一步网上有很多教程，但是都很麻烦，需要先在离线环境连接remote-ssh才能进行，本文提供一种简单的方法。

- 查看下载的vscode版本号，如图所示，下载文件的最后几位就是版本号，这里的版本号是1.52.1

  

  ![img](https://upload-images.jianshu.io/upload_images/30068-2cb1d6a724013bc9.png?imageMogr2/auto-orient/strip|imageView2/2/w/726/format/webp)

  image.png

- 访问vscode的github页面（

  https://github.com/microsoft/vscode/releases

  ），找到对应的版本号，然后点击下面的链接。

  

  ![img](https://upload-images.jianshu.io/upload_images/30068-54d799aebc37dada.png?imageMogr2/auto-orient/strip|imageView2/2/w/931/format/webp)

  找到对应版本的release

- 在打开的页面中，记住commit后面的ID

  

  ![img](https://upload-images.jianshu.io/upload_images/30068-ae4d00fcccca92f3.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

  获取版本的commit号码

- 构造下载链接`https://update.code.visualstudio.com/commit:[id]/server-linux-x64/stable`，并下载文件。其中[id]用上一步查到的commit id，在这个例子中，构造出来的下载链接是：

```jsx
https://update.code.visualstudio.com/commit:ea3859d4ba2f3e577a159bc91e3074c5d85c0523
/server-linux-x64/stable
```

下载的文件长这个样



![img](https://upload-images.jianshu.io/upload_images/30068-b5359970caacf669.png?imageMogr2/auto-orient/strip|imageView2/2/w/270/format/webp)

vscode程序包

至此，vscode离线部署的所有依赖安装包就完成了，其中最困难的就是获取服务端的程序，在联网环境下，这个安装包是自动下载的，完全不需要人工参与，但离线环境下不容易找到对应的安装包。

如果你之前的步骤正确，你现在应该已经下载了如下几个文件



![img](https://upload-images.jianshu.io/upload_images/30068-593648b316e5a9b7.png?imageMogr2/auto-orient/strip|imageView2/2/w/371/format/webp)

需要下载的文件

## 配置免密码登录

- 在离线机器安装git，安装的时候有很多选项，不想麻烦就全部选择默认。

- 打开git-bash

  

  ![img](https://upload-images.jianshu.io/upload_images/30068-25aec4d5ebe54072.png?imageMogr2/auto-orient/strip|imageView2/2/w/198/format/webp)

  image.png

- 在终端创建密钥

```undefined
ssh-keygen
```

创建过程一直点回车，使用默认的即可

- 复制公钥到服务器

```css
ssh-copy-id [用户名]@[服务器IP地址]
```

这一步会要求输入服务器密码，输入以后ssh-copy-id程序会将主机的公钥粘贴到服务器的`~/.ssh/local/authorized_key`的文件中。

- 验证免密登录

```css
ssh [用户名]@[服务器IP地址]
```

如果不用输入密码就进入服务器，则免密配置成功。

## 在服务器部署vscode remote

- 复制`vscode-server-linux-x64.tar.gz`到服务器

```ruby
scp [windows下的文件路径] [用户名]@[服务器IP地址]:~/
```

- 登录ssh登录服务器：`ssh [用户名]@[服务器IP地址]`
- 创建文件夹：`mkdir -p ~/.vscode-server/bin`
- 复制文件到文件夹：`mv ~/vscode-server-linux-x64.tar.gz ~/.vscode-server/bin`
- 进入文件夹：`cd ~/.vscode-server/bin`
- 解压文件：`tar -xvf vscode-server-linux-x64.tar.gz`
- 重命名为commit ID：`mv vscode-server-linux-x64 ea3859d4ba2f3e577a159bc91e3074c5d85c0523`，注意实际过程中填写自己在github上复制的ID

至此，在服务器端配置完成了

## 安装和配置vscode 和vscode remote客户端

- 安装vscode，这一步比较简单，之间按照步骤安装即可。

- 安装vscode-remote，参考这篇教程[vscode离线插件下载](https://www.jianshu.com/p/26b707966440)

- 配置vscode-remote，点击加号新建链接

  

  ![img](https://upload-images.jianshu.io/upload_images/30068-715c747f9d36d453.png?imageMogr2/auto-orient/strip|imageView2/2/w/394/format/webp)

  在弹出的框中输入`ssh [用户名]@[服务器IP地址]

  

  ![img](https://upload-images.jianshu.io/upload_images/30068-d8b82a721c990e23.png?imageMogr2/auto-orient/strip|imageView2/2/w/762/format/webp)

  选择存放ssh配置文件的地址，选择第一个默认的即可

  

  ![img](https://upload-images.jianshu.io/upload_images/30068-58bfb56ab6f4942f.png?imageMogr2/auto-orient/strip|imageView2/2/w/768/format/webp)

  点击左侧列表中的小窗口

  

  ![img](https://upload-images.jianshu.io/upload_images/30068-ca391ff982dbc9ba.png?imageMogr2/auto-orient/strip|imageView2/2/w/336/format/webp)

此时会新建一个窗口，证明已经连接成功，点击open folder开启你的远程服务器开发之旅吧。



![img](https://upload-images.jianshu.io/upload_images/30068-bff45dd291780444.png?imageMogr2/auto-orient/strip|imageView2/2/w/498/format/webp)



1人点赞

日记本