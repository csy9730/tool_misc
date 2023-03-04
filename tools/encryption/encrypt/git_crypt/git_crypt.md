# git crypt

[git-crypt](https://github.com/AGWA/git-crypt) 可以在 git 仓库中对数据进行透明的加解密。你选择保护的文件在提交时会加密，而在检出时会解密。git-crypt 使开发者可以自由共享包含公共和私有内容混合的存储库。

## install

安装git-crypt  

下载地址：[https://github.com/oholovko/git-crypt-windows/releases](https://github.com/oholovko/git-crypt-windows/releases)

将git-crypt.exe copy到Git的安装名录：XXX\Git\cmd

mac 和 linux 上安装 git-crypt 都比较简单 `apt install git-crypt`

## usage

使用方法：

### demo
使用git-crypt加密敏感内容
#### git init

新建一个git仓库。
#### 生成密钥

进入到本地工程目录，打开Git Base Here，执行`git-crypt init`，

注意：只管理私钥者执行此命令，生成唯一的私钥，以防多份私钥加密导致出错



该私钥文件位于 .git/git-crypt/keys/default
#### 管理加密文件

创建.gitattributes，管理加密文件

通过创建 gitattributes 文件来指定要 “加密” 的文件。你要为每个要加密的文件分配 “ filter = git-crypt diff = git-crypt” 属性
``` ini
secretfile filter=git-crypt diff=git-crypt
*.key filter=git-crypt diff=git-crypt
secretdir/** filter=git-crypt diff=git-crypt
*.sec filter=git-crypt diff=git-crypt
```

#### push到服务端

将仓库 push到服务端

#### pull
新建文件夹，拉取这个仓库。

可以发现，文件被加密了，无法查看。

#### 导出密钥
导出密钥，发给有需要的同事
```
git-crypt export-key my-crypt-key
```

#### 解密

进入工程目录，打开bash，执行 
```
git-crypt unlock my-crypt-key
```

现在就可以正常查看文件内容了。


### 通过gpg加密解密
该场景适用于多人协作。

首先要求对方导出公钥
``` bash
# 确认本地有密钥
gpg -k
# 导出
gpg --export -o pubfile  you<you@email.com>
```

己方接受对方的公钥文件。
添加一个主密钥副本，该副本已使用您的公共 GPG 密钥加密 (只有这样才能解密)
``` bash
git-crypt add-gpg-user --trusted you<you@email.com>
# 该操作将会把对称密钥加密，保存到仓库
git commit && git push
```

对方解密操作：
``` bash
git clone github.com:foo/my_repo
# 解密仓库
git-crypt unlock
```

原理：添加新密钥（非对称密钥），并不会更改原来的密钥（对称密钥），只是在仓库终添加加密的对称密钥文件，这个方法原理非常简单粗暴。缺点也很明显：对称密钥对于成员过于暴露，只要添加了成员，就永久暴露了对称密钥，想删除成员的访问权，~~只能重做仓库并更改对称密钥？~~。

## 原理
#### 对称密钥加密
基于对称密钥的工具的工作流程可能是最简单的：
 
1. 使用加密工具初始化存储库
2. 指定应视为“秘密”的文件
3. git push透明地加密文件
4. 与需要访问权限的其他用户共享对称密钥
5. 每次用户被撤销访问时旋转密钥


Git-crypt和Transcrypt都提供复杂的密码作为对称密钥。 操作上的挑战是找到一种共享对称密钥的安全方法，并确保每次删除用户时都旋转密钥。

以下是我们的对称密钥兼容工具Git-crypt和Transcrypt之间的一些区别：

Git-crypt与GPG和对称密钥加密兼容
Git-crypt不支持对称密钥旋转，因此，如果将其与对称密钥一起使用，则无法完成第5步
Transcrypt提供了方便的--rekey命令来旋转密钥
## 总结

利用该方式进行文件管理可以保证安全性，只有团队内相关人员才能看到文明文内容，解密只需要第一次进行，之后就没什么改变，直接改文件，git push会自动加密，git pull 会自动解密。