# git使用pem

1. git通用配置 git config 
2. 生成专有密钥
3. 
## main

### repo设置
```
git config --global user.name "abc"
git config --global user.email "abc@foo.com"

```

git支持https和git两种传输协议，github分享链接时会有两种协议可选：
`git@github.com:abc/proj.git`

`https://github.com/abc/proj.git`

git使用https协议，每次pull, push都会提示要输入密码，使用git协议，然后使用ssh密钥，这样免去每次都输密码的麻烦


``` bash
$ git remote -v
origin https://github.com/abc/proj.git (fetch)
origin https://github.com/abc/proj.git (push)

$ git remote set-url origin git@github.com:abc/proj.git
```

注意git协议，和传统的ssh协议不同，ssh协议的地址是`ssh://foo@192.168.0.1:22/abc/proj.git`。
~~github的git协议是虚拟ssh协议，用户名统一是git，地址不变，端口号变成了用户名。~~

### 密钥生成


``` bash
cd ~/.ssh
ssh-keygen -t rsa -C "abc@foo.com"
```

- -C 可以指定描述字符串，用户可以随意填写
- -t 指定加密方法


``` bash
# 查看你生成的公钥
cat ~/.ssh/id_rsa.pub
cat ~/.ssh/id_rsa
```

### 绑定公钥

公钥设计服务和授权，需要谨慎设置。
#### github个人账户中使用公钥
1. 登陆你的github帐户。点击你的头像，然后 Settings -> 左栏点击 SSH and GPG keys -> 点击 New SSH key
2. 然后你复制上面的公钥内容，粘贴进“Key”文本域内。 title域，自己随便起个名字。
3. 点击 Add key。

#### 电脑的ssh服务添加ssh公钥

### 私钥配置

私钥无需像公钥这么严格管理。可以简单实用。
注意： 私钥文件需要配置合适的文件访问掩码。


使用自定义别名，可以免去配置ip，端口，用户名，私钥地址的繁琐参数。

以下设置，可以使用一个自定义别名`my_ssh`. 

``` ini
Host my_ssh
    HostName 127.0.0.1
    User foo
    IdentityFile ~/git_rsa
    AddKeysToAgent yes
``` 

- Host：仓库网站的别名，（虽然可以随意取，但是作为一个简名，尽量与目标域名一致，增加匹配度）
- HostName：仓库网站的域名（PS：IP 地址应该也可以）
- User：仓库网站上的用户名
- IdentityFile：私钥的绝对路径!
- Port：端口号，默认是22.



`ssh my_ssh` 等效于 `ssh foo@127.0.0.1 -p 22 -i ~/git_rsa`


#### github gitee的参考配置
``` ini
Host github.com
    HostName github.com
    User git
    IdentityFile ~/git_rsa
    AddKeysToAgent yes

Host gitee.com
    HostName gitee.com
    User git
    IdentityFile ~/gitee/git_rsa
    AddKeysToAgent yes

Host coding.com
    HostName coding.net
    User git
    IdentityFile ~/coding/id_rsa
    Port 22
    AddKeysToAgent yes
```


### 测试连接

#### 标准测试连接

```
$ ssh -T git@github.com -i ~/git_rsa -p 22
Hi user! You've successfully authenticated, but GitHub does not provide shell access.
```


#### 使用别名测试连接
可以免去配置ip，端口，用户名，私钥地址。
```
ssh -T git@github.com
Hi user! You've successfully authenticated, but GitHub does not provide shell access.
```

```
H:\project\mylib\tool_misc>ssh -T git@gitee.com
Hi foo! You've successfully authenticated, but GITEE.COM does not provide shell access.
```

```
H:\project\mylib\tool_misc>ssh coding.com -T
CODING 提示: Hello 所有者, You've connected to coding.net via SSH. This is a Personal Key.
所有者，你好，你已经通过 SSH 协议认证 coding.net 服务，这是一个个人公钥.
公钥指纹：cb:d0:89:a4:8b:b3:01:0a:ee:57:62:8e:95:d5:7a:A2
```

```
$ ssh -T my_gogs
Hi there, You've successfully authenticated, but Gogs does not provide shell access.
If this is unexpected, please log in with password and setup Gogs under another user.
```

#### git 测试

``` bash
git clone git@github.com:foo/111.git

git clone my_gogs:foo/111.git
```

## misc

**Q**: key_load_public: invalid format

**A**: 

`ssh-keygen -f ~/.ssh/id_rsa -y > ~/.ssh/id_rsa.pub`


**Q**: 如果 `ssh  abc@foo` 报错，如何debug？

**A**: 
可以`ssh -v abc@foo`