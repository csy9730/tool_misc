# [【git】git利用git-lfs提交大文件](https://www.cnblogs.com/vickylinj/p/16207086.html)

安装 Git 大文件存储 (git-lfs)

```
sudo apt-get install git-lfs
git-lfs install
```

要将任何预先存在的文件转换为 Git LFS，例如其他分支上的文件或您之前的提交历史记录中的文件，请使用 git lfs migrate 命令

```
git lfs migrate import --include="*.exe" 
```

选择要跟踪的文件类型

```
git lfs track "*.exe"
```

更新 git 属性

```
git add .gitattributes
```

推送 

```
git git commit -m "commit message"
git push
```

遇到的问题：

```
Remote “origin” does not support the LFS locking API.
Consider disabling it with :
$git config lfs.https://XXXRemoteGitURLXXX.git/info/lfs.locksverify false
Git LFS (0 of 1 files) 0B/3.22MB
batch response: Post https://XXXRemoteGitURLXXX.git/info/lfs/objects/batch:x509: certificate signed by unknown authority
```

按照提示，执行以下命令取消远程仓库对LFS锁定的不支持：

```
git config lfs. https://XXXRemoteGitURLXXX.git/info/lfs.locksverify false
```

x509是SSL传输的证书标准，应该是ssl认证失败，执行如下命令禁用SSL认证：

```
git config http.sslVerify false
```

再尝试push到远程仓库：

```
git push origin master
```

其他用户使用这个仓库的时候，使用 `git clone` 会拉取普通的文件，但是 LFS 追踪的文件不会被拉下来。如果这些文件本地没有，则需要使用 `git lfs pull` 从远程仓库拉取。

或者

```
GIT_LFS_SKIP_SMUDGE=1
```

再git pull

参考：https://stackoverflow.com/questions/33330771/git-lfs-this-exceeds-githubs-file-size-limit-of-100-00-mb

https://murphypei.github.io/blog/2019/12/git-lfs

 

分类: [git](https://www.cnblogs.com/vickylinj/category/2147202.html)