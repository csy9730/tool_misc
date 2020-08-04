# git多用户

## 多个远程仓库
**Q**: 如何使客户端本地仓库支持推送多个远程仓库？
**A**: 
首先设置使支持多个远程仓库

简单执行 `git remote add origin git@gitee.com:abc/a_repo.git`不行，这个会报冲突的错误
简单的设置`git remote add mirror git@gitee.com:abc/a_repo.git`，虽然可以，但是push的时候麻烦。
``` bash
git pull origin master 
git pull mirror master
git push origin master 
git push mirror master
```

执行以下指令,可以实现同时更新多个远程仓库
``` bash


git remote set-url --add origin git@gitee.com:abc/a_repo.git
git remote set-url --add origin https://github.com/abc/a_repo.git
git remote set-url --add origin ssh://git@server/home/git/abc/a_repo.git
```

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

## 多账户

设置使本地可以保存多个账号（不同域名）登录凭证
* 使用ssh-agent添加多个私钥凭证
* 使用~/.ssh/config 保存多个私钥凭证
* 直接在本地仓库配置文件使用密码



### ssh/config

``` ini
Host github
HostName github.com
User jitwxs
IdentityFile ~/.ssh/id_rsa_github

Host gitlab
HostName gitlab.mygitlab.com
User lemon
IdentityFile ~/.ssh/id_rsa_gitlab
```
该文件分为多个用户配置，每个用户配置包含以下几个配置项：

Host：仓库网站的别名，随意取
HostName：仓库网站的域名（PS：IP 地址应该也可以）
User：仓库网站上的用户名
IdentityFile：私钥的绝对路径



### git/config
  上面通过git remote命令完成一个本地仓库多个远程仓库配置，这些命令实际上都是通过修改.git/config实现的，其实直接修改配置文件可能会更快，直接修改配置文件如下：
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