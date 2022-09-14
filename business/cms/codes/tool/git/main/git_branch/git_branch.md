# git branch 

#### 查看所有分支
``` bash
git branch -a #  查看所有分支
```


#### 新建一个分支
以当前分支为模板，复制并新建一个分支 
``` bash
git branch temp
```

#### 进入分支/提交版本
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
