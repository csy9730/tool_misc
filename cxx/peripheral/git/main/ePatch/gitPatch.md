###patch

blob,tree, commit
git format-patch COMMIT起点..COMMIT终点
默认终点 head
等价于 git diff >abc.patch
#####commit描述
* head
* head^
* head~2
* head~3
* tagA^
* tagA~2
* SHA4^
* SHA4~2
* master~2
* master~2
* branchA~2


非法版本组合：
head~
head^2
###操作

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