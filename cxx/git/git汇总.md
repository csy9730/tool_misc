# git 知识点

git 原理

git 使用方法
git 使用技巧

git 扩展
git 扩展使用技巧



## git 使用方法

仓库创建
init/clone/bundle

仓库配置
config

远程仓库(remote) 管理
``` bash
git remote -v  # 查看所有远程仓库
git remote add shortname url # 绑定添加远程仓库
git remote remove origin # 删除远程仓库
git push -u origin master
```



分支管理：
branch /branch -a/checkout /checkout -D

版本管理
commit/diff/log/show/reset/
``` bash
git commit # 执行提交
git reset --soft HEAD^ # 撤销上次提交，把变更放到暂存区
git reset --hard HEAD^ # 删除上次提交
```


历史管理
``` bash
git commit # 执行提交
git reset --hard HEAD^ # 删除上次提交
git revert 
git log
git squash
git rebase
```

tag管理
``` bash
git tag  # 查看标签
git tag -a v1.2 9fceb02 # 补录标签
git tag v1.2 HEAD # 补录标签
git tag -d v1.00  # 删除标签
git push origin --tags   # 推送tag
```

同步管理
push/pull/fetch/merge

补丁patch管理
``` bash

git diff > abc.patch # 生成补丁
git apply abc.patch  # 打上补丁
git apply --check abc.patch # 如果没有任何输出，那么表示可以顺利接受这个补丁
git diff --cached> abc.patch # 是将暂存区与版本库的差异做成补丁
git diff --HEAD >abc.patch # 是将工作区与版本库的差异做成补丁
git diff Testfile > abc.patch # 将单个文件做成一个单独的补丁
git apply --reject abc.patch #可以使用将能打的补丁先打上，有冲突的会生成.rej文件，此时可以找到这些文件进行手动打补丁

git format-patch HEAD^  #生成最近的1次commit的patch
git apply --check 0001-limit-log-function.patch     # 检查patch
git apply *.patch # 批量打多个补丁
git am # git apply  +git add+git commit 
```

索引区/操作：
add/rm/ls-files/gitignore

暂存区操作：
``` bash
git add # 添加工作区的内容到到暂存区
git reset  # 移动暂存区的内容到工作区
git reset --hard # 清空暂存区和工作区
```


stash管理
``` bash
git stash # 储藏当前不清洁的工作区
git stash list # 查看所有储藏
git stash show  # 查看单个储藏
git stash drop stash@{0} # # 删除储藏
git stash apply stash@{2} # 应用stash@{2} 储藏
```

子模块submodule管理

## git 原理

仓库repo：local/remote

head/master/history

branch

Index

cache 暂存区

commit/log

workspace

stash


### 高阶方法
git hook

## git 扩展

ssh 扩展

lfs 大文件扩展

git的图形客户端

git远程托管网站github
git服务： gitlab

