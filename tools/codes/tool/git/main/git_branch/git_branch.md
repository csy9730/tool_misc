# git branch 

#### 查看所有分支
``` bash
git branch -a #  查看所有分支
```

```
  dev
* master
  remotes/local/master
  remotes/mirror/HEAD -> mirror/master
  remotes/mirror/dev
  remotes/mirror/master
  remotes/origin/HEAD -> origin/master
  remotes/origin/master
```

当前分支对应的有 * 号


#### 新建一个分支
以当前分支为模板，复制并新建一个分支 
``` bash
git branch temp

# 复制指定版本到新分支
git branch temp2 7cde313
git branch temp3 HEAD~5
```
不改变当前分支，需要通过`git checkout` 进入新分支

#### 进入分支/提交版本

切换到对应的分支，更改本地文件夹
```
git checkout foo
```

#### 删除分支
```
git branch -d foo
```

#### 覆盖分支
覆盖一个分支 ：删除分支，再复制新建一个分支 
```
git checkout boo
git branch -d foo
git branch foo
```


#### 保存一个无头分支
``` bash
git checkout abcd1234 
git branch temp # 新建一个 temp 分支
git checkout temp # 当前提交的代码放到整个分支 
```
#### 复制一个分支
```
git branch (-c | -C) [<oldbranch>] <newbranch>
```
#### 移动一个分支
```
git branch (-m | -M) [<oldbranch>] <newbranch>
```

