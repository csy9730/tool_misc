# [git subtree用法 ](https://www.cnblogs.com/minjh/p/15540742.html)

**什么时候需要 Subtree ？**
1、当多个项目共用同一个模块代码，而这个模块代码跟着项目在快速更新的时候
2、把一部分代码迁移出去独立为一个新的 git 仓库，但又希望能够保留这部分代码的历史提交记录。

git subtree的主要命令有：



```
$ git subtree add   --prefix=<prefix> <commit>
$ git subtree add   --prefix=<prefix> <repository> <ref>
$ git subtree pull  --prefix=<prefix> <repository> <ref>
$ git subtree push  --prefix=<prefix> <repository> <ref>
$ git subtree merge --prefix=<prefix> <commit>
$ git subtree split --prefix=<prefix> [OPTIONS] [<commit>]
```



git subtree用法

## 准备

我们先准备一个仓库叫photoshop，一个仓库叫libpng，然后我们希望把libpng作为photoshop的子仓库。
photoshop的路径为`https://github.com/test/photoshop.git`，仓库里的文件有：



```
photoshop
    |
    |-- photoshop.c
    |-- photoshop.h
    |-- main.c
    \-- README.md
```



libPNG的路径为`https://github.com/test/libpng.git`，仓库里的文件有：



```
libpng
    |
    |-- libpng.c
    |-- libpng.h
    \-- README.md
```



 添加之后的父仓库文件结构：



```
photoshop
    |
    |-- sub
         |-- libpng
                |
                |-- libpng.c
                |-- libpng.h
                \-- README.md
    |-- photoshop.c
    |-- photoshop.h
    |-- main.c
    \-- README.md
```



 

## 1. 第一次添加子目录，建立与git项目的关联（在父仓库中新增子仓库）

建立关联总共有2条命令。

语法：`git remote add -f <子仓库名> <子仓库地址>`

解释：其中-f意思是在添加远程仓库之后，立即执行fetch。

语法：`git subtree add --prefix=<子目录名> <子仓库名> <分支> --squash`

解释：–squash意思是把subtree的改动合并成一次commit，这样就不用拉取子项目完整的历史记录。–prefix之后的=等号也可以用空格。

示例：

```
$ git remote add -f libpng https://github.com/test/libpng.git
$ git subtree add --prefix=sub/libpng libpng master --squash
```

#### 2. 从远程仓库更新子目录

更新子目录有2条命令。

语法：`git fetch <远程仓库名> <分支>`

语法：`git subtree pull --prefix=<子目录名> <远程分支> <分支> --squash`

示例：

```
$ git fetch libpng master
$ git subtree pull --prefix=sub/libpng https://github.com/test/libpng.git master --squash
```

#### 3. 从子目录push到远程仓库（确认你有写权限）

推送子目录的变更有1条命令。

语法：`git subtree push --prefix=<子目录名> <远程分支名> 分支`

示例：

```
$ git subtree push --prefix=sub/libpng https://github.com/test/libpng.git master
```

### 4.git subtree split

每次执行 subtree 的 push 命令的时候，总会重新为子目录生成新的提交。然而这造成了一些很麻烦的问题：

1. 每个提交都需要重新计算，因此每次推送都需要把主仓库所有的提交计算一遍，非常耗时；
2. 每次 push 都是重新计算的，因此本地和远端新仓库的提交总是不一样的，关键还没有共同的父级，这导致 git 无法自动为我们解决冲突。

git subtree 提供了 `split` 命令就是为了解决这个问题

当使用了 `split` 命令后，git subtree 将确保对于相同历史的分割始终是相同的提交号。

于是，当需要 push 的时候，git 将只计算 split 之后的新提交；并且下次 split 的时候，以前相同的历史纪录将得到相同的 git 提交号。

示例：

```
$ git subtree split --rejoin --prefix=sub/libpng  --branch new_libpng
$ git push libpng new_libpng:master 
```

 

## 简化git subtree命令

我们已经知道了git subtree 的命令的基本用法，但是上述几个命令还是显得有点复杂，特别是子仓库的源仓库地址，特别不方便记忆。
这里我们把子仓库的地址作为一个remote，方便记忆：

```
$ git remote add -f libpng https://github.com/test/libpng.git
```

然后可以这样来使用git subtree命令：

```
$ git subtree add --prefix=sub/libpng libpng master --squash
$ git subtree pull --prefix=sub/libpng libpng master --squash
$ git subtree push --prefix=sub/libpng libpng master
```

 

分类: [GitHub](https://www.cnblogs.com/minjh/category/2060331.html)

标签: [Git subtree用法与常见问题](https://www.cnblogs.com/minjh/tag/Git subtree用法与常见问题/), [git subtree教程](https://www.cnblogs.com/minjh/tag/git subtree教程/), [Git Subtree 在多个 Git 项目间双向同步子项目](https://www.cnblogs.com/minjh/tag/Git Subtree 在多个 Git 项目间双向同步子项目/)