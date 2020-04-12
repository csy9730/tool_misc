# Git使用
[TOC]

### 入门

##### 相关下载
* git.exe
* mingw32，windows系统可用的bash环境
* GUI：tortoiseGit
* GUI：git for windows
* github
* gitlab: https://github.com

##### 初始化帐号
```
git config --global user.name abc
git config --global user.email abc@qq.com
git config --global core.autocrlf false
git config --global core.safecrlf false
git config --global core.quotepath false
```
全局的config 通过vim ~/.gitconfig来查看,位于C:\Users\admin\.gitconfig路径
```
git config user.name "Your Name"
git config user.email you@example.com
# 局部的通过当前路径下的 .git/config文件来查看
```


##### 初始化ssh

1. ssh-keygen -t rsa -b 4096
2. 默认在usr/.ssh目录下生成id_rsa.hub公钥 和 id_rsa私钥文件
3. 登录gitlab网站，点profiles Settings-ssh key
4. 黏贴公钥文件内容，并上传
5. 无须输入密码即可配置本地仓库


#### 本地仓库配置
本地仓库是在当前目录新建.git文件夹，该文件夹包含所有变更的补丁、快照以及镜像，并且可以自由复制黏贴。
git本地配置保存在 %userprofile%\.gitconfig
```
git clone url  # 克隆 url的仓库到本地文件夹,url可以使用本地路径
git init  # 初始化操作，新建空仓库
```



#### 代码变更操作
文件状态：
1.  未跟踪
2.  未修改
3.  修改
4.  暂存

文件根据所在区域分为：
* 未标记区(untracked)
* 工作区（work，可编辑状态），
* 索引区 （Index，）
* 暂存区（cache，stage changed），
* 版本库（commit），
* 远程分支（remote）
* 存区 ( stash)

|untracked|tracked|tracked|tracked|tracked|tracked|
|---|---|---|---|---|----|
|untracked|last commited|modifed|staged|staged modifed|commited|
|  | add |edit|add|edit&add|commit|
|rm|checkout|   reset  | checkout |reset --soft| |

```
git status # 查看track状态。
git add abc  # 添加abc文件到索引区、暂存区
git add .    #  添加当前路径到索引区、暂存区
git rm abc #  从索引区版本库移除abc文件
git rm --cached readme.txt # 从索引区版本库移除但不删除文件
git add -i   #  互动添加文件到暂存区
git add -f . #  无视.gitignore文件约束，添加文件

git ls-files # 查看暂存区
git reset (HEAD ) # 默认使用 --mixed,从暂存区删除所有被修改的文件
git reset HEAD <filename> # 从暂存区删除一个被修改的文件

# 当对上次提交不满意
git reset --soft HEAD^ # 可以让HEAD指针回退，而暂存区和工作区不动
git reset --mixed HEAD^ # 工作区不改变，而暂存区和引用（HEAD指针）回退一次
git reset --hard HEAD^ # 彻底撤销最近的提交，HEAD指针、暂存区、工作区都回到上次的提交状态

 # checkout 影响工作区，属于非常危险的操作。可以指定路径或文件来执行操作，以降低影响工作区域。
git checkout <filename> # 撤销工作区的文件修改,用暂存区的文件覆盖工作区中的文件
git checkout -- path # 指定路径撤销更改

git clean -n  ## 查看待清理的文件
git clean –df   ## 清理工作区     
# -f 删除当前目录下所有untracked文件.不会删除.gitignore文件里面指定的文件夹和文件,
# -d 删除当前目录下所有untracked文件夹
# -x 删除当前目录下所有untracked文件. 会删除.gitignore文件里面指定的文件夹和文件
```

#### commit

```
git commit -m "abc" # 提交
git commit --amend # 提交，与上次的提交合并
git reset --hard ver  # 将版本回退到ver版本，只影响tracked文件
git revert -n  # 通过反做创建一个新的版本，这个版本的内容与我们要回退到的目标版本一样，但是HEAD指针是指向这个新生成的版本，而不是目标版本
```
##### 版本号
版本号表达方式：
* HEAD  （大写）
* HEAD^ ,  HEAD~2
* 0123 t
* branchName
* tagN
* master,origin

HEAD 是指针，可以指向任意commit节点
提交后 HEAD 随着分支一起向前移动
master指针，指向master主线节点


##### log

```
git log # 使用udfb翻页查看，q退出当前
# 支持各种filter显示，-n，--since，-- 加路径
```
##### diff

```
git diff # 不加参数即默认比较工作区与暂存区
git diff --cached  [<path>...] # 比较暂存区与最新本地版本库
git diff HEAD [<path>...]  　# 比较工作区与最新本地版本库,如果HEAD指向的是master分支，那么HEAD还可以换成master
git diff commit-id  [<path>...]  # 比较工作区与指定commit-id的差异
git diff --cached [<commit-id>] [<path>...] # 比较暂存区与指定commit-id的差异
git diff [<commit-id>] [<commit-id>] # 比较两个commit-id之间的差异
```

##### tag
```
git tag  # 查看标签
git tag -a v1.2 9fceb02 # 补录标签
git tag v1.2 HEAD # 补录标签
git tag -d v1.00  # 删除标签
git push origin --tags   # 推送tag
```
##### stash
```
git stash # 储藏当前不清洁的工作区
# 没有在git 版本控制中的文件，是不能被git stash 存起来的。
git stash list # 查看所有储藏
git stash show  # 查看单个储藏
git stash drop # 删除储藏
git stash drop stash@{0} # # 删除储藏
git stash apply # 应用最远储藏？
git stash apply stash@{2} # 应用stash@{2} 储藏
git stash pop # apply+drop

```
#### 分支操作
```
git branch -a   # 查看分支
git branch - create #创建分支
git branch -d # 删除分支
git branch - checkout # 切换分支
git branch  new_branch #创建new_branch分支
git checkout -b new_branch #创建并切换new_branch分支
# 效果：并且直接把分支的改变应用or覆盖到repo的所有文件上。
git fetch # 获取更新，更新叠加到本地分支
git prune # 剪枝
```

#### remote
```
git remote -v  #查看所有远程仓库
git remote add shortname url # 绑定添加远程仓库
git pull  # 可以下载别的版本更新
git fetch # 获取更新
# git pull = git fetch + git merge
git push branches #上传本地分支到远程分支
# 当有文件冲突时，容易推送失败，此时需要使用-force选项才能推送成功。
git push origin master # 将本地分支推送到与之存在追踪关系的远程分支（通常两者同名）
git push shortname master # 推送本地分支
git push origin master：refs/for/master # 即是将本地的master分支推送到远程主机origin上的对应master分支， origin 是远程主机名，第一个master是本地分支名，第二个master是远程分支名。

 git fetch origin master # 从远程的origin仓库的master分支下载代码到本地的origin master

```

local merge ？
网页端发起合并merge请求
master管理员处理合并请求

![gitPush.jpg](./img/gitPush.jpg "")


##### github权限
1. Guest
2. Reporter
3. Developer
4. Master

初始化项目



### misc

```
git commit # 需要调用vim写更新文本。
git pull # 可以下载别的版本更新
git squash # 合并提交
git blame # 重写历史
git bitset # 二分法找bug
git submodule # 
```

gui的命令默认全部，无法部分选择。
bash命令可以选择文件夹执行命令。

#### ignore文件
```bash
 *.[oa]

 # 忽略*.b和*.B文件，my.b除外
*.[bB]
!my.b
 # 忽略dbg文件和dbg目录
 dbg
 # 忽略*.o和*.a文件
```

#### merge
单线合并merge，简单移动master指针即可
钻石合并diamond merge，需要两个分支和共同祖先一起合并
合并冲突，需要人工处理冲突，

处理合并merge请求
git merge --abort # 

以下情况可以自动merge
1\. 多成员修改不同文件
 2\. 多成员修改相同文件不同区域
 3\. 同时修改文件名和文件内容



##### 冲突处理
```
cd  & vim   # 切换目录，处理冲突文件
git add .   # 使用当前文件覆盖
git commit  # 执行
```


**Q**: git出现Your branch and 'origin/master' have diverged解决方法
**A**: 如果不需要保留本地的修改，只要执行下面两步：
``` bash
git fetch origin
git reset --hard origin/master
```
当我们在本地提交到远程仓库的时候，如果遇到上述问题，我们可以首先使用如下命令：
``` bash
git rebase origin/master
git pull --rebase
git push origin master
```
把内容提交到远程仓库上。

##### 使用强制push的方法

```
hint: Updates were rejected because the tip of your current branch is behind hint: its remote counterpart. Integrate the remote changes (e.g. hint: 'git pull ...') before pushing again. hint: See the 'Note about fast-forwards' in 'git push --help' for detail

# 这样会使远程修改丢失
git push -u origin master -f 

# 2.push前先将远程repository修改pull下来
git pull origin master
git push -u origin master
```


#### patch

使用git diff打补丁
```
git diff > abc.patch # 生成补丁
git apply abc.patch  # 打上补丁
git apply --check abc.patch # 如果没有任何输出，那么表示可以顺利接受这个补丁
git diff --cached> abc.patch # 是将暂存区与版本库的差异做成补丁
git diff --HEAD >abc.patch # 是将工作区与版本库的差异做成补丁
git diff Testfile > abc.patch # 将单个文件做成一个单独的补丁
git apply --reject abc.patch #可以使用将能打的补丁先打上，有冲突的会生成.rej文件，此时可以找到这些文件进行手动打补丁

git format-patch HEAD^  #生成最近的1次commit的patch
git format-patch HEAD^^  #生成最近的2次commit的patch
git apply --check 0001-limit-log-function.patch   　　　  # 检查patch是否能够打上，如果没有任何输出，则说明无冲突，可以打上
git apply *.patch # 批量打多个补丁
git am =git apply  +git add+git commit 
```
##### bundle

```
# 创建GIT打包文件
git bundle create repo.bundle HEAD master
git  bundle verify repo.bundle
# 分发
mkdir dirs & copy repo.bundle dirs/repo2.bundle
cd dirs
# rebuild repo
git clone repo2.bundle  repoDIr
cd repoDir
git log --oneline
```

##### alias
```
git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
git config --global alias.unstage 'reset HEAD --'
```

##### submodule
```
git submodule add <submodule_url>  # 添加子项目
git clone --recurse-submodules <main_project_url>  # 获取主项目和所有子项目源码

git submodule init
git submodule update

rm -rf sm_path  # 删除子模块目录及源码
vi .gitmodules # 删除项目目录下.gitmodules文件中子模块相关条目
vi .git/config # 删除配置项中子模块相关条目
rm .git/module/* # 删除模块下的子模块目录，每个子模块对应一个目录
git rm --cached 子模块名称 # 清理错误
```
### help

```bash
$ git --help
usage: git [--version] [--help] [-C <path>] [-c name=value]
           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]
           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
           <command> [<args>]

These are common Git commands used in various situations:

start a working area (see also: git help tutorial)
   clone      Clone a repository into a new directory
   init       Create an empty Git repository or reinitialize an existing one

work on the current change (see also: git help everyday)
   add        Add file contents to the index
   mv         Move or rename a file, a directory, or a symlink
   reset      Reset current HEAD to the specified state
   rm         Remove files from the working tree and from the index

examine the history and state (see also: git help revisions)
   bisect     Use binary search to find the commit that introduced a bug
   grep       Print lines matching a pattern
   log        Show commit logs
   show       Show various types of objects
   status     Show the working tree status

grow, mark and tweak your common history
   branch     List, create, or delete branches
   checkout   Switch branches or restore working tree files
   commit     Record changes to the repository
   diff       Show changes between commits, commit and working tree, etc
   merge      Join two or more development histories together
   rebase     Reapply commits on top of another base tip
   tag        Create, list, delete or verify a tag object signed with GPG

collaborate (see also: git help workflows)
   fetch      Download objects and refs from another repository
   pull       Fetch from and integrate with another repository or a local branch
   push       Update remote refs along with associated objects

'git help -a' and 'git help -g' list available subcommands and some
concept guides. See 'git help <command>' or 'git help <concept>'
to read about a specific subcommand or concept.
```

####
git基础概念：blob,tree, commit,tag


#### gitk
gitk：gui界面
stage changed： 暂存区改变，更新暂存区存档？
sign off 签名确认？
commit 本地分支执行变更？


##### pull

git错误:You are not currently on a branch
通过git reset和git checkout进行版本回退之后再次git pull抛出以下错误：
``` bash
You are not currently on a branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.

    git pull <remote> <branch>
1
You are not currently on a branch.
Please specify which branch you want to merge with.
See git-pull(1) for details.

    git pull <remote> <branch>
```
意思是当前的版本已经不在master分支了，解决的办法：
``` bash
git status #查看所有变化的文件，把有改动的先删除。
git checkout master #回到主分支。
git pull #拉取最新代码。
```

git push origin master error: cannot spawn sh: No such file or directory
与账号邮箱私密有关

**Q**：从所有历史中搜索已经删除的文件

**A**: `git log --all --full-history -- thefile.txt`

**Q**:从所有版本中删除敏感文件
**A**:

``` bash
git filter-branch -f --tree-filter 'rm tools/abc.exe' HEAD 
git filter-branch --force --index-filter "git rm --cached --ignore-unmatch sensorRecogn/titanic.HDF5" --prune-empty --tag-name-filter cat -- --all
git push origin --force
```

**Q**: 如何查看远程分支的log
**A**:

``` bash
git branch -a
git log  remotes/origin/HEAD
```