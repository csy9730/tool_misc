# [使用hexo搭建github.io博客(一)](https://www.cnblogs.com/liulangmao/p/4323064.html)

使用github.io可以搭建一个自己的博客,把静态文件项目托管到github上,可以写博客,可以使用markdown语法,也可以展示作品.灵活性高.但是有较大的难度.

node,git版本变化日新月异,每段时间都会有不同,而这个小不同可能直接导致搭建失败.这里把我搭建的过程记录下来.如果将来搭建失败,可以参考,下载对应的版本尝试.

 

**我使用的版本(\**win7系统下:\**):**

node: v0.10.22

git: Git-1.9.5-preview20141217  

 

**搭建步骤:**

1.安装好node和git,注册好github账号. 注意:用户名一定不能有大写.

想下载最新的git可以尝试这个地址: http://msysgit.github.io/

想下载我使用的版本,移步我的网盘: http://pan.baidu.com/s/1qWt5u36

 

2.安装hexo:

执行: npm install -g hexo

这里常常安装了一半就卡住装不下去了,fq后就ok了...

 

3.创建hexo文件夹:

自己找一个喜欢的路径,创建hexo文件夹,我的是安装在 E:\hexo 下的. 

cmd窗口切换到对应的目录下,然后执行: hexo init 

也可以在 E:\hexo 下右键,选择git bash,在窗口中执行 hexo init

它就自动安装了需要的文件.

 

4.安装依赖:

继续执行: npm install

安装好了所有的依赖

 

5.完成本地安装:

继续在 E:\hexo 下执行:  hexo generate

继续执行: hexo server

然后在打开浏览器 localhost:4000 ,就可以看到,本地已经安装好了.

 

6.在github上创建博客仓库:

　　6.1新建仓库.

　　右上角的加号点击一下,选择New repository

　　![img](https://images0.cnblogs.com/blog2015/585756/201503/091110018301017.png)

   跳转的后如下填写:(其中Repository name的格式是 '用户名'.github.io ),然后点创建仓库

   ![img](https://images0.cnblogs.com/blog2015/585756/201503/091117267843619.gif)

　　

　　6.2 生成测试页面

　　进入刚才创建的仓库,点击右边菜单中的Settings按钮，在跳转到的页面 Update your site 对应处点击“Automatic page generator”按钮，这样就有了一个github自动生成的页面用来测试的时候使用。之后点击继续。

　　![img](https://images0.cnblogs.com/blog2015/585756/201503/091121564094291.gif)

　　

　　6.3选择主题,点击'Publish page'发布:

　　![img](https://images0.cnblogs.com/blog2015/585756/201503/091125037213815.jpg)

　　

　　6.4发布成功

　　再次回到仓库,点击6.2里的Settings按钮:

　　点击链接就可以看到测试地址页面.

　　![img](https://images0.cnblogs.com/blog2015/585756/201503/091157517683366.png)

7.创建SSH keys

　　7.1 监测是否有已经存在的SSH keys:

　　打开 git bash 终端(可以在  E:\hexo 下右键打开,也可以直接在开始菜单里打开)

　　执行:  $ ls -al ~/.ssh 

 

​    如果有SSH keys: 就会看到如下文件 id_rsa  id_rsa.pub

　　![img](http://img.hb.aicdn.com/365b2c1e8114daece9476344bcfa0bb213b4ce321b52-G96pwE_fw658)

　　(除了我自己生成的这种,官方教程里说,SSH keys也有可能是以下几种文件:

- *id_dsa.pub*
- *id_ecdsa.pub*
- *id_ed25519.pub*

​    )

　　

　　7.2 如果没有的话,就生成一个SSH keys: 粉色部分写自己的邮箱

　　$ ssh-keygen -t rsa -C "*your_email@example.com*" 

　　然后会出现:

　　Generating public/private rsa key pair.

　　Enter file in which to save the key (/Users/*you*/.ssh/id_rsa): 

　　就是让你输入SSH keys要保存在哪里,一般不用改,就直接回车就好了.

　　然后会出现:

　　粉色部分输入一个密码,这个密码后面会用到,所以要记住咯~

　  Enter passphrase (empty for no passphrase): *[Type a passphrase]* 

　　# Enter same passphrase again: *[Type passphrase again]* 

　  

　　7.3 保存SSH keys:

　　创建成功后,他会提示你SSH keys保存在哪里:

　　Your identification has been saved in /Users/*you*/.ssh/id_rsa.

　　# Your public key has been saved in /Users/*you*/.ssh/id_rsa.pub.

　　# The key fingerprint is:

　　# *01:0f:f4:3b:ca:85:d6:17:a1:7d:f0:68:9d:f0:a2:db your_email@example.com*

 

　　7.4 找到SSH keys:

　　根据上一步里告诉你的路径,找到保存SSH keys的地方,我的是在 C:\Users\2000104591\.ssh

　　其中 id_rsa.pub 就是SSH keys 如果为了防止以后找不到,可以把他们自己另存到其它地方

 

\8. 为github仓库添加SSH keys

SSH keys创建好了,我们还要把它添加到仓库里去

打开6.1创建的仓库,点击6.2时点击的右侧的'Settings',再左侧的'Deploy keys':

![img](https://images0.cnblogs.com/blog2015/585756/201503/091121564094291.gif)  ![img](https://images0.cnblogs.com/blog2015/585756/201503/091449002457845.png)

点击'Add deploy key':

![img](https://images0.cnblogs.com/blog2015/585756/201503/091452353089348.png)

然后把7创建的id_rsa.pub里的内容复制到Key里去,Title部分随便填. 点击'Add key'

添加的过程中,还要再输入一次github的密码

![img](https://images0.cnblogs.com/blog2015/585756/201503/091454440425543.png)　　

 

\9. 测试连接

回到git bash

执行: 

$ ssh -T git@github.com

它可能会出现一些乱七八糟的提示,最后是问你yes/no,就输入yes.

如果是这样子叫你输入密码.那这个密码就是在7.2里面设置的那个密码,就输入一下就好了

Enter passphrase for key '/c/Users/2000104591/.ssh/id_rsa':

最后它提示你:

Hi, 用户名/用户名.github.io! You've successfully authenticated, but GitHub does notprovide shell access.

这样就算ok了~~~

 

10.配置_config.yml文件并发布:

在 E:\hexo 下,有一个文件叫 _config.yml ,打开它,拉到最底下,做如下修改:　

```
deploy:
  type: github      //改成github
  repository: https://github.com/jinyanhuan/jinyanhuan.github.io    //改成自己的用户名
  branch: master    
```

配置完以后还是在E:\hexo下执行:

hexo generate

hexo deploy

 

执行完以后,如果报错 **Error**: Deployer not found : github,则执行如下命令:

npm install hexo-deployer-git --save

同时修改 _config.yml :

```
deploy:
  type: git      //改成github   
```

然后再执行:

hexo generate

hexo deploy

然后访问: http://jinyanhuan.github.io/ (用户名改成自己的),就可以看到了.

注意,每次修改本地文件后，需要 hexo generate 才能保存。每次使用命令时，都要在 E:`\hexo `目录下 

 

好了,虽然搞了这么多,但这只是一个开始~~~  慢点继续搭建~~~

\-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

2015 - 02 - 16 补充:

一. 如果需要在多台电脑上安装hexo:

1.执行步骤1-5

2.复制一个原来就有的ssh key到新的电脑.或者在新电脑上生成一个新的ssh key,添加到对应的github博客仓库里.

3.把原来的hexo目录下东西复制到新的电脑里.

 

二. hexo可能更新过了,所以老的hexo可能会报错:

```
{ [Error: Cannot find module './build/Release/DTraceProviderBindings'] code: 'MODULE_NOT_FOUND' }
{ [Error: Cannot find module './build/default/DTraceProviderBindings'] code: 'MODULE_NOT_FOUND' }
{ [Error: Cannot find module './build/Debug/DTraceProviderBindings'] code: 'MODULE_NOT_FOUND' }
```

解决办法,执行:

```
npm install hexo --no-optional
```

 

 

 

以上搭建过程共参考以下文章:

搭建过程:

http://zipperary.com/2013/05/28/hexo-guide-2/

http://jingyan.baidu.com/article/ed2a5d1f3732cb09f7be1745.html

 

SSH keys:

https://help.github.com/articles/generating-ssh-keys/

http://blog.sina.com.cn/s/blog_698b9e160100nwna.html

http://blog.csdn.net/keyboardota/article/details/7603630

http://www.freehao123.com/hexo-node-js/

 

Error:Deployer not found:github

https://github.com/hexojs/hexo/issues/1040

 

后续操作全部转到本人的github.io博客: http://jinyanhuan.github.io/

标签: [github](https://www.cnblogs.com/liulangmao/tag/github/), [hexo](https://www.cnblogs.com/liulangmao/tag/hexo/), [git](https://www.cnblogs.com/liulangmao/tag/git/)