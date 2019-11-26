#Git使用
###入门
官网地址：http://git-scm.com/
套件
* git.exe
* mingw32环境
* GUI：tortoiseGit
* GUI：git for windows

gitlab安装，可以安装tortoiGit或git for windows

###初始化帐号
git config --global user.name lilei
git config --global user.email lilei@abc.cn
git config --global core.autocrlf false
git config --global core.safecrlf false
git config --global core.quotepath false

###初始化ssh

1. ssh-keygen -t rsa -b 4096
2. 默认在usr/.ssh目录下生成id_rsa.hub公钥 和 id_rsa私钥文件
3. 登录gitlab网站，点profiles Settings-ssh key
4. 黏贴公钥文件内容，并上传
5. 无须输入密码即可配置本地仓库


###本地仓库配置
新建本地repo仓库。
* 本地初始化      git init
* 拷贝初始化      git clone url 

```
git clone git@gitlab:zal/zal_lib.git
```
git init初始化操作，在当前目录新建.git文件夹。

```
git init
git add *.c
git add README
git commit -m 'initial project version'
```
.git文件夹包含所有变更，可以自由复制黏贴同时保存变更历史。
git本地配置保存在 %userprofile%\.gitconfig
###文件状态
1. 未跟踪
2. 未修改
3. 修改
4. 暂存

![18333fig0201-tn.png](./img/18333fig0201-tn.png "")
操作：
* add
* rm
* status
* stage
* ignore
* diff
* mv

移除跟踪但不删除文件
git rm --cached readme.txt

#####log
git log 使用udfb翻页查看，q退出当前
#####diff
1.1 比较工作区与暂存区
　　git diff 不加参数即默认比较工作区与暂存区
1.2 比较暂存区与最新本地版本库（本地库中最近一次commit的内容）
　　git diff --cached  [<path>...] 
1.3 比较工作区与最新本地版本库
　　git diff HEAD [<path>...]  如果HEAD指向的是master分支，那么HEAD还可以换成master
1.4 比较工作区与指定commit-id的差异
　　git diff commit-id  [<path>...] 
1.5 比较暂存区与指定commit-id的差异
　　git diff --cached [<commit-id>] [<path>...] 
1.6 比较两个commit-id之间的差异
　　git diff [<commit-id>] [<commit-id>]
1.7 使用git diff打补丁
　　git diff > patch //patch的命名是随意的，不加其他参数时作用是当我们希望将我们本仓库工作区的修改拷贝一份到其他机器上使用，但是修改的文件比较多，拷贝量比较大，
　此时我们可以将修改的代码做成补丁，之后在其他机器上对应目录下使用 git apply patch 将补丁打上即可
　git diff --cached > patch //是将我们暂存区与版本库的差异做成补丁
　  git diff --HEAD > patch //是将工作区与版本库的差异做成补丁
　git diff Testfile > patch//将单个文件做成一个单独的补丁
拓展：git apply patch 应用补丁，应用补丁之前我们可以先检验一下补丁能否应用，git apply --check patch 如果没有任何输出，那么表示可以顺利接受这个补丁
　　　　　　　另外可以使用git apply --reject patch将能打的补丁先打上，有冲突的会生成.rej文件，此时可以找到这些文件进行手动打补丁
#####ignore
```bash
 *.[oa]

 # 忽略*.b和*.B文件，my.b除外
*.[bB]
!my.b
 # 忽略dbg文件和dbg目录
 dbg
 # 忽略*.o和*.a文件
``` 

git status
查看track状态。
git add -i 

###版本操作
代码区分为：
* 工作区（可编辑状态），    working directory
* 暂存区（stage changed），        index 
* 版本库（commit），    git directory
* 远程分支（push成功）,remote directory

stage changed： 暂存区改变，更新暂存区存档？
sign off 签名确认？
commit 本地分支执行变更？


git push branches 上传本地分支到远程分支
当有新建文件时，容易push fail。
此时需要打勾Force Overwrite选项。
![gitPush.jpg](./img/gitPush.jpg "")

local merge ？
网页端发起合并merge请求
master管理员处理合并请求

git rebase
git commit
需要调用vim写更新文本。
git commit --amend，修改上次提交注释 
 
git log 以补丁形式显示更新记录，支持各种filter显示，-n，--since，-- 加路径

git reset
git checkout
git squash 合并提交
重写历史
git blame
git bitset 二分法找bug
git submodule
### 远程操作
git remote -v 查看
git remote add shortname url
git pull 可以下载别的版本更新
git fetch
### tag
补录标签
git tag -a v1.2 9fceb02
###缓存
git stash 
git stash list
git stash drop
git stash apply
###分支操作
无分支操作，等效成链表结构
有分支结构，树形结构

head是指针，可以指向任意commit节点
提交后 HEAD 随着分支一起向前移动
master指针，指向master主线节点
单线合并merge，简单移动master指针即可
钻石合并diamond merge，需要两个分支和共同祖先一起合并
合并冲突，需要人工处理冲突，


git branch -a 
branch - create 创建分支
branch -d 删除分支
branch - checkout 切换分支
效果：并且直接把分支的改变应用or覆盖到repo的所有文件上。

git fetch 获取更新，更新叠加到本地分支
git prune 剪枝

#####管理员操作
初始化项目
合并merge请求

git merge --abort

###question

###misc

gitk：gui界面

gui的命令默认全部，无法部分选择?
bash命令可以选择执行命令。

git config --global alias.last 'log -1 HEAD'
git config --global alias.visual '!gitk'
git config --global alias.unstage 'reset HEAD --'


#####冲突处理
cd到文件目录，
```
git add .
git commit
```

###help

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
