# Git server

在Git服务管理工具这个领域，主要有三种流行的方案，它们分别是 

* Gogs
* gitosis 
* Gitolite
* gitlab
* gitblit： 基于java的git服务器
* git-lfs/git-lfs

Gitosis - 轻量级， 开源项目，使用SSH公钥认证，只能做到库级的权限控制。目前项目已经于2012年停止开发，不再维护。管理公钥, [gitosis](https://github.com/res0nat0r/gitosis)
Gitolite - 轻量级，开源项目，使用SSH公钥认证，能做到分支级的权限控制。
Git + Repo + Gerrit - 超级重量级，集版本控制，库管理和代码审核为一身。可管理大型及超大型项目。
gitlab也能布置到自己服务器上，但是对服务器要求4G的内存着实有些太高


## git core
### user/account
首先来看一个典型的克隆仓库的命令
``` bash
git clone git@github.com:abc/vimlearn.git
scp git@github.com:abc/vimlearn.git # 对比
```

可以看到git clone的命令实际上类似scp(基于ssh的cp命令)，即通过git用户访问到git用户主目录，然后寻找账户名(github账户名唯一性)对应的目录，再寻找仓库对应的目录，然后将仓库目录拷贝到指定的本地目录。

因此，这里的account(abc)和登录至哪个git服务器没有任何关系，只是用于在登录服务器后进行仓库定位。有关系的在于，如果想进行push操作，需要将当前的client下的公钥填写至account的SSH Keys配置中。

git中还涉及一个user.name/user.email的概念，这个user是用来进行多人协作进行标示commit/merge等操作的。默认情况下git使用全局的user.name/email为所有本地仓库记录协作者信息，也可为单个仓库配置不同的user.name/email。


### 账户权限管理
git clone 默认使用一个git@server登录，执行scp的功能
abc账号对应  /home/git/abc 
abc账号的repo仓库对应 /home/git/abc/repo.git
问题，如何使git clone 支持不同账号的不同pem文件访问不同文件夹

即在git用户权限下，为/home/git/abc 和/home/git/abc2 分配不同的目录访问权限，可以使用不同的密码/私钥文件。
这个问题很常见，在大多数网页应用的账号系统都实现了这个功能，允许不同账号访问数据库的特定的记录，区别在于git clone要求只能访问特定的文件夹。

最简单的方式就是添加用户，然后设置用户对某个文件夹得读写权限就行了。这种方式是最简单的。除了创建用户，最好再创建不同的用户组，然后江将不同的项目文件件归属于不同的用户组，最后通过控制账户的所属用户组来实现不同用户对于不同项目的读写权限。

1. 安装git
2. 添加git用户
3. 添加账户目录和仓库目录
4. 修改权限到git用户

``` bash
sudo apt-get install git
# 修改git用户默认打开的shell
sudo adduser git --shell /usr/bin/git-shell 
# 创建 账户目录和仓库目录
cd /home/git/srv
sudo git init --bare sample.git # ~/srv/sample.git
sudo chown -R git:git sample.git

vim /etc/passwd
```

``` bash
$ git clone git@server:/abc/sample.git
Cloning into 'sample'...
warning: You appear to have cloned an empty repository.
```

通过上面用户+用户组的方式就可以管理多个用户了。
但是如果有几十个开发者，那就意味着你要新建几十个用户。就算你不厌其烦的添加了几十个用户，但是管理这几十个用户，也不是一件很方便的时。
在服务器上 Git 不支持目录级别粒度的写入控制。要想实现多个账户公用一个git@server，需要自行维护账户数据库，实现目录级别的文件权限管理。


**Q**: 如何在git server中使用非22端口？
**A**: 
使用以下格式，注意，这时路径使用的绝对路径。
`git clone ssh://git@server:2222/home/git/abc/sample.git`

``` bash
cd ~
mkdir .ssh

```


**Q**: 添加公钥登录,避免每次都要输入账户密码
**A**: 
``` bash
cd /home/git
mkdir .ssh
cd .ssh
ssh-keygen -t rsa -C "git-server"
touch authorized_keys 
cat id_rsa>>authorized_keys
```

临时使用私钥实现账户的仓库拉取
ssh-agent sh -c 'ssh-add ~/.ssh/id_rsa; git clone ssh://git@server:2222/home/git/abc/sample.git'

## github
github 支持 https和git两种方式
``` ini

url = https://github.com/abc/a_repo.git
url = git@github.com:abc/a_repo.git
```


## gitosis

gitosis 是Git下的权限管理工具，通过一个特殊的仓库（gitosis-admin.git）对Git权限进行管理。