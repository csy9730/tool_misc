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
解密

进入工程目录，打开Git Base Here，执行 
```
git-crypt unlock my-crypt-key
```

现在就可以正常查看文件内容了。

## 总结

利用该方式进行文件管理可以保证安全性，只有团队内相关人员才能看到文明文内容，解密只需要第一次进行，之后就没什么改变，直接改文件，git push会自动加密，git pull 会自动解密。