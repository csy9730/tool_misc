# github 配置使用 personal access token 认证

![img](https://upload.jianshu.io/users/upload_avatars/8103938/0a1dec9c-bc86-434f-9c3b-ac288f26b20a?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[惜鸟](https://www.jianshu.com/u/da0e38c8c765)关注

0.1022021.08.19 19:10:21字数 815阅读 3,328

# 一. 问题描述

使用如下命令推送代码到 `github` ：

```sh
git push origin main
```

根据提示输入用户名和密码，报如下错误：

```sh
remote: Support for password authentication was removed on August 13, 2021. Please use a personal access token instead.
remote: Please see https://github.blog/2020-12-15-token-authentication-requirements-for-git-operations/ for more information.
```

根据提示信息可以知道，`github` 在 `2021.8.13` 移除了密码认证的支持，它建议使用 `personal access token` 代替密码认证。由于提示中给出的地址无法访问，所以查阅相关文档，下面主要记录一下如何解决这个问题。

# 二. 解决方法

[github docs](https://links.jianshu.com/go?to=https%3A%2F%2Fdocs.github.com%2Fen%2Fgithub%2Fauthenticating-to-github%2Fkeeping-your-account-and-data-secure%2Fcreating-a-personal-access-token) 文档中描述说，在使用命令行或API的时候，应该创建一个个人访问令牌（personal access token）来代替密码，下面详细介绍如何创建 `personal access token`。

## 创建 personal access token

1. 登录 github

2. 在页面右上角点击你的头像，然后点击

    

   ```
   Settings
   ```

   ：

   

   ![img](https://upload-images.jianshu.io/upload_images/8103938-131fb2d6a380c2b5.png?imageMogr2/auto-orient/strip|imageView2/2/w/412/format/webp)

   image.png

3. 在左侧边栏中，点击开发人员设置：

   

   ![img](https://upload-images.jianshu.io/upload_images/8103938-ee09019d9c03beee.png?imageMogr2/auto-orient/strip|imageView2/2/w/332/format/webp)

   image.png

4. 在左侧边栏中，单击个人访问令牌：

   

   ![img](https://upload-images.jianshu.io/upload_images/8103938-12ec5ed230f13366.png?imageMogr2/auto-orient/strip|imageView2/2/w/287/format/webp)

   image.png

5. 单击生成新令牌：

   

   ![img](https://upload-images.jianshu.io/upload_images/8103938-6e33ec83f7172ad0.png?imageMogr2/auto-orient/strip|imageView2/2/w/836/format/webp)

   image.png

6. 为您的令牌指定一个描述性名称：

   

   ![img](https://upload-images.jianshu.io/upload_images/8103938-7352d53cb2834793.png?imageMogr2/auto-orient/strip|imageView2/2/w/464/format/webp)

   image.png

7. 要让您的令牌到期，请选择到期下拉菜单，然后单击默认值或使用日历选择器：

   

   ![img](https://upload-images.jianshu.io/upload_images/8103938-247b381f7c2ed456.png?imageMogr2/auto-orient/strip|imageView2/2/w/589/format/webp)

   image.png

8. 选择您要授予此令牌的范围或权限。要使用您的令牌从命令行访问存储库，请选择repo：

   

   ![img](https://upload-images.jianshu.io/upload_images/8103938-73750f0ed2e92d52.png?imageMogr2/auto-orient/strip|imageView2/2/w/730/format/webp)

   image.png

9. 单击生成令牌：

   

   ![img](https://upload-images.jianshu.io/upload_images/8103938-50553b30ffa8e89a.png?imageMogr2/auto-orient/strip|imageView2/2/w/464/format/webp)

   image.png

   

   ![img](https://upload-images.jianshu.io/upload_images/8103938-18f9797b7fe18c09.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)

   image.png

> 警告：将您的令牌视为密码并保密。使用 API 时，将令牌用作环境变量，而不是将它们硬编码到您的程序中。

## 在命令行上面使用令牌

获得令牌后，您可以在通过 HTTPS 执行 Git 操作时输入它而不是密码。

例如，在命令行中输入以下内容：

```php
$ git clone https://github.com/username/repo.git
Username: your_username
Password: your_token
```

个人访问令牌只能用于 HTTPS Git 操作。如果您的存储库使用 SSH 远程 URL，则需要[将远程从 SSH 切换到 HTTPS](https://links.jianshu.com/go?to=https%3A%2F%2Fdocs.github.com%2Fen%2Fgithub%2Fgetting-started-with-github%2Fmanaging-remote-repositories%2F%23switching-remote-urls-from-ssh-to-https)。

如果系统未提示您输入用户名和密码，则您的凭据可能已缓存在您的计算机上。您可以[更新钥匙串中的凭据以](https://links.jianshu.com/go?to=https%3A%2F%2Fdocs.github.com%2Fen%2Fgithub%2Fgetting-started-with-github%2Fupdating-credentials-from-the-macos-keychain)使用令牌替换旧密码。

## 在 windows 中配置github 凭据

使用 `https` 的方式拉取或者推送代码，每次都需要手动输入用户名和 `personal access token`，为了方便，可以使用 windows 中的凭据管理器保存相关配置，如下图所示：



![img](https://upload-images.jianshu.io/upload_images/8103938-c5fabad6a500c3ed.png?imageMogr2/auto-orient/strip|imageView2/2/w/1110/format/webp)

image.png

如果 github 的凭据已经存在，原来保存的是用户名和密码，需要将原来的密码修改为

 

```
personal access token
```

，通常情况下，我们登录过 github 后就会在这里保存相关的凭据，如果没有可用手动创建，如下图所示：



![img](https://upload-images.jianshu.io/upload_images/8103938-88aac1d02f939ff0.png?imageMogr2/auto-orient/strip|imageView2/2/w/935/format/webp)

image.png



参考文档：
[https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/creating-a-personal-access-token](https://links.jianshu.com/go?to=https%3A%2F%2Fdocs.github.com%2Fen%2Fgithub%2Fauthenticating-to-github%2Fkeeping-your-account-and-data-secure%2Fcreating-a-personal-access-token)