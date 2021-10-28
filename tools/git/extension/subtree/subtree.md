# Git Subtree的使用

![img](https://upload.jianshu.io/users/upload_avatars/1945520/9a975322963a.jpg?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)

[Archerlly](https://www.jianshu.com/u/04c40d5dab4b)关注

12017.03.05 22:32:13字数 1,197阅读 12,575

## 背景

> 项目A与项目B存在公用模块，在项目A中修改Bug或增加新功能需要同步到项目B中，由于存在区别所以还不能完全copy

## 需求分析

------

- 公用代码迁移出去独立的 git 仓库，供其他项目共享代码
- 公用代码原本是什么样，抽取后也是什么样，不像pod会对公用代码进行动态库或静态库的包装
- 公用代码库是可以在不同项目间双向同步的而不是单向同步
- 保留公用代码库的历史提交记录与双向同步记录

> 双向同步的栗子：A项目中依赖了子项目B，最方便的方式自然是直接在A项目里改B子项目对应的目录里的代码，然后测试通过后，直接提交代码，这个更改也提交到B子项目的 Git仓库里。同时子项目B也可以单独提交到 Git 仓库，再在A项目里把子项目B的代码update。

## 现有方案

------

- **Git Submodule**：这是Git官方以前的推荐方案
- **Git Subtree**：从 Git 1.5.2 开始，Git 新增并推荐使用这个功能来管理子项目
- **npm**：node package manager，实际上不仅仅是 node 的包管理工具
- **composer**：暂且认为他是php版npm

虽然 npm，composer，maven 等更侧重于包的依赖管理，以上几个方案都是能够做到在不同项目中同步同一块代码的，但没法双向同步，更适用于子项目代码比较稳定的情形。Git Submodule 和 Git Subtree 都是官方支持的功能，不具有依赖管理的功能，但能满足我们的要求。Git Subtree相对来说会更好一些 。

**submodule 与 subtree对比**

- git submodule
  - 允许其他的仓库指定以一个commit嵌入仓库的子目录
  - 仓库 `clone`下来需要 `init` 和 `update`
  - 会产 `.gitmodule` 文件记录 submodule 版本信息
  - git submodule 删除起来比较费劲
- git subtree
  - 避免以上问题
  - 管理和更新流程比较方便
  - git subtree合并子仓库到项目中的子目录。不用像submodule那样每次子项目修改了后要`init`和`update` 。万一哪次没update就直接`add .` 将`.gitmodule` 也 `commit`上去就悲剧了
  - git v1.5.2以后建议使用git subtree

## 实施步骤

------

*假设P1项目、P2项目共用S项目*
**1. 关联Subtree**
'' cd P1项目的路径
'' git subtree add --prefix=<S项目的相对路径> <S项目git地址> <分支> --squash

> 解释：--squash意思是把subtree的改动合并成一次commit，这样就不用拉取子项目完整的历史记录。--prefix之后的=等号也可以用空格。
```
mkdir foo & cd foo & git init
git subtree add --prefix=yolov3 https://github.com/ultralytics/yolov3 master --squash
```


**2. 更新代码**
P1、P2项目里各种提交commit，其中有些commit会涉及到S目录的更改，但是没关系

**3. 提交更改到子项目**
'' cd P1项目的路径
'' git subtree push --prefix=<S项目的相对路径> <S项目git地址> <分支>
Git 会遍历步骤2中所有的commit，从中找出针对S目录的更改，然后把这些更改记录提交到S项目的Git服务器上，并保留步骤2中的相关S的提交记录到S仓库中

**4. 更新子目录**
''cd P2项目的路径
''git subtree pull --prefix=<S项目的相对路径> <S项目git地址> <分支> --squash

## 拆分已有项目

------

> 需要从现有项目中抽取公共模块单独进行git管理
> *假设已有项目P抽取项目S*
> **1. 提交日志分离**
> ''cd P项目的路径
> ''git subtree split -P <S项目的相对路径> -b <临时branch>
> Git 会遍历所有的commit，分离出与S项目的相对路径相关的commit，并存入临时branch中

**2. 创建子repo**
''mkdir <S项目新路径>
''cd S项目新路径
''git init
''git pull <P项目的路径> <临时branch>
''git remote add origin <S项目的git仓库>
''git push origin -u master

**3. 清理数据**
''cd P项目的路径
''git rm -rf <S项目的相对路径>
''git commit -m '移除相应模块' # 提交删除申请
''git branch -D <临时branch> # 删除临时分支

**4. 添加subtree**
''git subtree add --prefix=<S项目的相对路径> <S项目git地址> <分支> --squash
''git push origin master
执行完第2步时，对应的目录已经剥离出来形成独立的项目了。第3，4步主要是把当前项目的对应的文件给删除，重新在P项目建立Subtree

## Tips

- 相对路径区别大小写

## 参考

- [用 Git Subtree 在多个 Git 项目间双向同步子项目](https://segmentfault.com/a/1190000003969060)
- [Git Subtree 的介绍及使用](http://blog.csdn.net/bingshushu/article/details/51244480)
- [使用Git Subtree集成项目到子项目](http://aoxuis.me/post/2013-08-06-git-subtree)
- [使用git的subtree将已有项目的某个目录分离成独立项目](https://www.queyang.com/blog/archives/519)