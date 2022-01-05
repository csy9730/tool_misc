# ssh-agent

ssh-agent是一种控制用来保存公钥身份验证所使用的私钥的程序，其实ssh-agent就是一个密钥管理器，运行ssh-agent以后，使用ssh-add将私钥交给ssh-agent保管，其他程序需要身份验证的时候可以将验证申请交给ssh-agent来完成整个认证过程。



## main

1. 本地配置邮箱用户
2. 本地生成rsa公钥私钥
3. 本地添加密钥到ssh-agent
4. 登陆Github, 添加 ssh 。
5. 测试


### 配置
设置邮箱用户
```
git config --global user.name "humingx"
git config --global user.email "humingx@yeah.net"
```

### 生成公钥私钥
生成rsa公钥私钥
``` bash
ssh-keygen -t rsa -C "邮箱地址"
```

```
ssh-keygen -t ed25519 -C "XXX" (XXX为标记,随便起个名称)
(回车,返回结果)
Generating public/private ed25519 key pair.
Enter file in which to save the key (/home/xxx/.ssh/id_ed25519): (文件保存位置,一般默认就好)
(回车,返回结果)
Enter passphrase (empty for no passphrase): (密码,如果想使用时不输密码,留空即可)
(回车,返回结果)
Enter same passphrase again: (再次确认密码,留空的还是直接回车)
(回车,返回结果)
Your identification has been saved in /home/xxx/.ssh/id_ed25519.
Your public key has been saved in /home/xxx/.ssh/id_ed25519.pub.
The key fingerprint is:
SHA256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxx XXX(这几位是最上面填写的名称,在在公钥最后显示)
The key's randomart image is:(返回的随即生成图形)
+--[ED25519 256]--+
|                 |
|                 |
|                 |
|                 |
| xxxxxxxxxxxxxxx |
|ooooooooooooo    |
|                 |
|                 |
|                 |
+----[SHA256]-----+

```

### 添加公钥到授权

``` bash
cat ~/.ssh/id_rsa |clip # windows下复制到剪贴板

cat ~/.ssh/id_rsa>>~/.ssh/authorized_keys
```

### 添加密钥到ssh-agent

**Q**: 执行ssh-add时出现Could not open a connection to your authentication agent
**A**: 

先执行  eval `ssh-agent`  或`eval "$(ssh-agent -s)" ` 
执行
``` bash
# 启动服务
eval `ssh-agent`
# 添加rsa指纹
ssh-add ~/.ssh/rsa
# 查看添加的rsa指纹
ssh-add -l 
```

注意： ssh-agent 只会在一个终端内生效，如何使用更友好方便的方法？

测试ssh-agent是否生效,能否访问github？

``` bash
$ ssh -T git@github.com
The authenticity of host 'github.com (52.74.223.119)' can't be established.
RSA key fingerprint is SHA256:nmTxdCARLvTCspRoiKw6g5hbE1IGOkXUpJWGl7E5SY8.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'github.com,52.74.223.119' (RSA) to the list of known hosts.
Hi abc! You've successfully authenticated, but GitHub does not provide shell access.

```
可以看到：禁止了git用户的login交互式shell，因此未能登录成功，但可以看到身份验证通过。


测试ssh-agent是否生效,能否访问gitee？

``` bash
$ ssh -T gitee@gitee.com
Hi ____! You've successfully authenticated, but GITEE.COM does not provide shell access.
```



可以看到git clone的命令实际上类似scp(基于ssh的cp命令)，即通过git用户访问到git用户主目录，然后寻找账户名(github账户名唯一性)对应的目录，再寻找仓库对应的目录，然后将仓库目录拷贝到指定的本地目录。

因此，这里的account(xiaoxipangren)和登录至哪个git服务器没有任何关系，只是用于在登录服务器后进行仓库定位。有关系的在于，如果想进行push操作，需要将当前的client下的公钥填写至account的SSH Keys配置中。

