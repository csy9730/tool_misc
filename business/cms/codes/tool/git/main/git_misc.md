# git

### 代码变更操作
文件状态：
1.  未跟踪
2.  未修改
3.  修改
4.  暂存
### 文件根据所在区域
文件根据所在区域分为：

* 工作区（work，可编辑状态），
    * 工作区未标记文件 (untracked)
    * 工作区已标记文件（可编辑状态）
        * 已编辑更改状态
        * 未更新状态
* 本地分支 .git/ 
    * 暂存区（cache，stage changed），
    * 索引区 （Index，） 版本库（commit），
    * 存区 ( stash)
* 远程分支（remote）


0. 回收站，黑洞
1. untracked
2. edited tracked 未添加到暂存区的跟踪文件
3. newest tracked 添加到暂存区的已同步的跟踪文件
4. 索引区和工作区的文件
   1. Index
   2. 工作区

- 1-> 3  `git add`
- 2 -> 3 `git add` 
- 3-> 4 `git commit` 
- 3 -> 1
- 3 -> 2
- 4 -> 3
- 1-> 0 `git clean `

### add & commit 
`git status` ， 查看1 和 2

`git add` 添加abc文件到索引区、暂存区



### reset

默认使用  --mixed 模式 



保留更改内容  `git reset foo`  3 -> 2

删除更改内容,注意，不支持还原单个文件夹。 `git reset --hard ` .  3 -> 0

2 -> 1 `git reset `

```
git reset --soft HEAD^  # 4a~1， 4b -> 3
git reset --mixed HEAD^ # 4a~1 ;4b -> 1,2 ; 3-〉1,2
git reset --hard HEAD^  # 4^  3-> 0 2-> 0 1->0
```

> --soft
> Does not touch the index file or the working tree at all (but resets the head to <commit>, just like all modes do). This leaves all your changed files "Changes to be committed", as git status would put it.
> 
> --mixed
> Resets the index but not the working tree (i.e., the changed files are preserved but not marked for commit) and reports what has not been updated. This is the default action.
> 
> If -N is specified, removed paths are marked as intent-to-add (see git-add[1]).
> 
> --hard
> Resets the index and working tree. Any changes to tracked files in the working tree since <commit> are discarded. Any untracked files or directories in the way of writing any tracked files are simply deleted.


### 还原删除
删除跟踪文件 `git rm foo`, `git clean foo & git add foo`  ~~4b-> 0; =>3~~

还原被删除文件 `git checkout foo`  4b = 4a

清理未跟踪文件 1-> 0 `git clean -df foo`
### branch
``` bash
git checkout master
git merge xxx_id
```



## 1

true file 
blob
tree
commit
branch 
tag



blob 和真实文件是什么关系，一对一的关系？

树对应文件夹树 ，近似一对一的关系。对应任意个blob

更改文件的访问权限，会改变blob？ blob不会改变，只会修改tree

提交，在树的基础上添加了文本信息。和树是1对1关系？ 

就相当于生成了当前项目的一个快照（snapshot），生成快照又称为完成一次提交。

问题，提交说明文本是否会改变哈希值？会改变哈希值


多个提交，组成链表 ，branch 分支 ，也可以理解成提交组成的树（有向无环图）

## misc

- git_status
- git_init
- git_add
- git_commit
- git_reset
- git_clean
- git_reflog
- git_log
- git_remote