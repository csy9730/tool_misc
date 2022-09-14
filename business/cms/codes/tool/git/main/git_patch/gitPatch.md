# patch


以下有三种方法生成补丁，打补丁的方法。
- 1 (old)
    - diff 生成补丁
    - apply 适用补丁
- 2 (new)
    - format-patch 生成补丁
    - am 适用补丁
- 3
    - bundle 生成补丁
    - pull 适用补丁


#### diff
显示版本变更，可以用来生成补丁。
`git diff >abc.patch`

#### format-patch
`git format-patch COMMIT起点...COMMIT终点`
默认终点 head

等价于 `git diff >abc.patch`

``` bash
git format-patch -1 # 生成 0001-.patch
git format-patch -3 # 生成 0001-.patch， 0002-.patch， 0003-.patch

git format-patch master~3..master # 生成 0001-.patch， 0002-.patch， 0003-.patch

```


推荐使用git format-patch生成git 专用PATCH，因为我们在实际使用中发现，如果使用diff生成通用PATCH，对于删除文件的操作会出现失败的情况。如果没有删除操作的情况下diff的效率及通用性会比较好。

#### apply
检查该PATCH信息, 如：
`git apply --stat 0001-test.patch`

检查该PATCH是否能在指定源代码中合入, 如：
`git apply --check 0001-test.patch`


apply可以打上补丁 
```
git apply 000*.patch

```
该补丁不会提交，只是反映在文件变更。



取消打上的补丁变更 
```
git apply -R 0003.patch 0002.patch 0001.patch
```
#### am

> git-am - Apply a series of patches from a mailbox

[git-am](https://git-scm.com/docs/git-am)

apply 打补丁，并不提交。am命令可以自动提交。

#### bundle pull
bundle方法可以远程发送补丁，并且确保版本号一致。format-patch难以确保版本一致。

## misc
#### 管理

生成master
```bash

git init
echo A > file
git add file
git commit -mA
git tag vA
echo B >> file ; git commit -mB file;git tag vB
echo C >> file ; git commit -mC file;git tag vC
echo D >> file ; git commit -mD file;git tag vD
git show-branch --more=4 master
git format-patch -1
git format-patch -3

git format-patch master~3..master
```

生成branch
```bash
git checkout vB
git branch  alt
echo X>> file ; git commit -mX file;git tag vX
echo Y>> file ; git commit -mY file;git tag vY
echo Z >> file ; git commit -mZ file;git tag vZ

git log --graph --pretty=oneline --abbrev-commit --all

```


冲突处理
```bash
git checkout master
git merge alt

pause
git add file
git commit -m 'all lines'

echo F >> file ; git commit -mF file;git tag vF
```

冲突处理
```bash
git am --skip
git am --abort
git am -3 PATCH/*
pause & vi file
git add file
git am -3 --resolved
 

```




以上操作不支持分支，只支持线性提交。等价于rebase操作？