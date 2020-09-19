# FQA

**Q**:从所有版本中删除敏感文件
**A**:

``` bash
git filter-branch -f --tree-filter 'rm tools/abc.exe' HEAD 
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch sensorRecogn/titanic.HDF5" --prune-empty --tag-name-filter cat -- --all
git push origin --force
```
注意： 每个仓库都要执行这条过滤指令。这样不同仓库合并时，不会合并错误。



**Q**: git clone 如何拉取部分版本，部分文件？

**A**: 
适合用 git clone --depth=1 的场景：你只是想clone最新版本来使用或学习，而不是参与整个项目的开发工作
```
--depth <depth>
Create a shallow clone with a history truncated to the specified number of commits. Implies --single-branch 
depth选项默认使用单分支。

通过 ` git clone --depth=1 --branch a_br ` 可以只复制一个分支快照，没有git历史。
```



**Q**: git出现Your branch and 'origin/master' have diverged解决方法
"git pull”如何强制覆盖本地文件？

**A**: 如果不需要保留本地的修改，只要执行下面两步：
``` bash
git fetch origin
# git fetch --all
git reset --hard origin/master
```
git fetch从远程下载最新的，而不尝试合并或rebase任何东西。



**Q**: 当我们在本地提交(git push)到远程仓库的时候，如果遇到上述问题，

**A**: 我们可以首先使用如下命令：
``` bash
git rebase origin/master
git pull --rebase
git push origin master
```
把内容提交到远程仓库上。