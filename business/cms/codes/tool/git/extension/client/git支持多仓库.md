# git多用户

## 多个远程仓库
**Q**: 如何使客户端本地仓库支持推送多个远程仓库？
**A**: 
首先设置使支持多个远程仓库

简单执行 `git remote add origin git@gitee.com:abc/a_repo.git`不行，这个会报冲突的错误

- 配置origin以外的其他自定义源（非默认）。
- 配置origin支持多个仓库源

### 异名多仓库
简单的设置`git remote add mirror git@gitee.com:abc/a_repo.git`，虽然可以，但是push的时候麻烦。
``` bash
git pull origin master 
git pull mirror master
git push origin master 
git push mirror master
```

### 同名多仓库
执行以下指令,可以实现同时更新多个远程仓库
``` bash
git remote set-url --add origin git@gitee.com:abc/a_repo.git
git remote set-url --add origin https://github.com/abc/a_repo.git
git remote set-url --add origin ssh://git@server/home/git/abc/a_repo.git
```

上面的命令会立即改变`.git/config`文件
#### .git/config

可以看到配置如下

``` ini
[core]
	repositoryformatversion = 0
	filemode = false
	bare = false
	logallrefupdates = true
	symlinks = false
	ignorecase = true
[submodule]
	active = .
[remote "origin"]
	url = https://github.com/abc/a_repo.git
	fetch = +refs/heads/*:refs/remotes/origin/*
	url = git@gitee.com:abc/a_repo.git
	url = ssh://git@server:2222/home/git/abc/a_repo.git
[branch "master"]
	remote = origin
	merge = refs/heads/master
```


执行`git remote -v`
```
origin  https://github.com/abc/a_repo.git (fetch)
origin  https://github.com/abc/a_repo.git (push)
origin  git@gitee.com:abc/a_repo.git (push)
origin  ssh://git@server:2222/home/git/abc/a_repo.git (push)
```

### 多账户

使用多个账号，需要有多个密码，如何使仓库支持多账户？

设置使本地可以保存多个账号（不同域名）登录凭证

* 使用ssh-agent添加多个私钥凭证
* 使用~/.ssh/config 保存多个私钥凭证
* 直接在本地仓库配置文件使用密码

#### ssh-agent

通过在bash中
``` bash
# 启动服务
eval `ssh-agent`
# 添加rsa指纹
ssh-add ~/.ssh/rsa
# 查看添加的rsa指纹
ssh-add -l 
```

可以把以上脚本，放在git-bash启动时执行。

#### ssh/config

config文件位于`~/.ssh/config`，可以保存pem账户和密码

根据git源地址，可以生成以下配置文件.
例如： `git@github.com:abc/foo.git`

Github这里使用的是虚拟账户git，所以多个虚拟账户共用一个git账户
``` ini
Host github.com
HostName github.com
User git
IdentityFile ~/.ssh/id_rsa_github

```

一个gitlab的例子：
``` ini
Host gitlab
HostName gitlab.mygitlab.com
User lemon
IdentityFile ~/.ssh/id_rsa_gitlab
```
该文件分为多个用户配置，每个用户配置包含以下几个配置项：

- Host：仓库网站的别名，（虽然可以随意取，但是作为一个简名，尽量与目标域名一致，增加匹配度）
- HostName：仓库网站的域名（PS：IP 地址应该也可以）
- User：仓库网站上的用户名
- IdentityFile：私钥的绝对路径!

测试ssh连接：
`ssh -T github.com`

#### .git/config
上面通过`git remote`命令完成一个本地仓库多个远程仓库配置，这些命令实际上都是通过修改.git/config实现的，其实直接修改配置文件可能会更快，直接修改配置文件如下：

``` ini
[core]
        repositoryformatversion = 0
        filemode = true
        bare = false
        logallrefupdates = true
[remote "origin"]
        url = https://${user}:${password}@github.com/abc/a_repo.git
        url = https://${user}:${password}@gitee.com/abc/a_repo.git
        url = https://${user}:${password}@git.coding.net/abc/a_repo.git
        fetch = +refs/heads/*:refs/remotes/origin/*
[branch "master"]
        remote = origin
        merge = refs/heads/master
```

 把上面配置中的“${user}”和“${password}”用你的远程仓库用户名和密码代入即可。

[git多个远程仓库](https://www.cnblogs.com/bwar/p/9297343.html)