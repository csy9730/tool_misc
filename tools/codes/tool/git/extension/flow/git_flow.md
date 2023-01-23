# git flow
## branch


　再简单复习各个分支：

* master: 主分支，主要用来版本发布。
* develop：日常开发分支，该分支正常保存了开发的最新代码。
* feature：具体的功能开发分支，只与 develop 分支交互。
* release：release 分支可以认为是 master 分支的未测试版。比如说某一期的功能全部开发完成，那么就将 develop 分支合并到 release 分支，测试没有问题并且到了发布日期就合并到 master 分支，进行发布。
* hotfix：线上 bug 修复分支。

![git flow](https://upload-images.jianshu.io/upload_images/845143-9b3cca0f4eae8fdc.png?imageMogr2/auto-orient/strip|imageView2/2/w/1200/format/webp)
依赖路径关系：
 feat => develop => release => master
箭头左边的会合并进右边，左边更新，右边更稳定。

### master分支
通常，master分支只能从其它分支合并，不能在master分支直接修改。master分支上存放的是随时可供在生产环境中部署的代码（Production Ready state）。当开发活动到一定阶段，产生一份新的可供部署的代码时，master分支上的代码会被更新。同时，每一次更新，最好添加对应的版本号标签（TAG）。
所有在Master分支上的Commit应该打Tag。

```
git checkout master
git merge --squash dev
```

### develop分支
* develop分支是保持当前开发最新成果的分支，一般会在此分支上进行晚间构建(Nightly Build)并执行自动化测试。
* develop分支产生于master分支, 并长期存在。
* 当一个版本功能开发完毕且通过测试功能稳定时，就会合并到master分支上。
* develop分支一般命名为develop
* develop分支是主开发分支，包含所有要发布到下一个Release的代码，主要合并其它分支，比如Feature分支。

### feature分支
feature分支使用规范：
* 可以从develop分支发起feature分支。
* 代码必须合并回develop分支。
* feature分支的命名可以使用除master，develop，release-*，hotfix-*之外的任何名称。
* feature分支（topic分支）通常在开发一项新的软件功能的时候使用，分支上的代码变更最终合并回develop分支或者干脆被抛弃掉（例如实验性且效果不好的代码变更）。
一般而言，feature分支代码可以保存在开发者自己的代码库中而不强制提交到主代码库里。
Feature分支开发完成后，必须合并回Develop分支，合并完分支后一般会删Feature分支，但也可以保留。

### release分支
release分支使用规范：
a、可以从develop分支派生；
b、必须合并回develop分支和master分支；
c、分支命名惯例：release-*；
release分支是为发布新的产品版本而设计的。在release分支上的代码允许做测试、bug修改、准备发布版本所需的各项说明信息（版本号、发布时间、编译时间等）。通过在release分支上进行发布相关工作可以让develop分支空闲出来以接受新的feature分支上的代码提交，进入新的软件开发迭代周期。
当develop分支上的代码已经包含了所有即将发布的版本中所计划包含的软件功能，并且已通过所有测试时，可以考虑准备创建release分支。而所有在当前即将发布的版本外的业务需求一定要确保不能混到release分支内（避免由此引入一些不可控的系统缺陷）。
成功的派生release分支并被赋予版本号后，develop分支就可以为下一个版本服务。版本号的命名可以依据项目定义的版本号命名规则进行。
发布Release分支时，合并Release到Master和Develop， 同时在Master分支上打个Tag记住Release版本号，然后就可以删除Release分支。

release分支和dev分支都可以集成其他分支。release分支合并fixbug分支，dev分支合并feature分支。

### hotfix分支
hotfix分支使用规范：
a、可以从master分支派生；
b、必须合并回master分支和develop分支；
c、分支命名惯例：hotfix-*；
hotfix分支是计划外创建的，可以产生一个新的可供在生产环境部署的软件版本。
当生产环境中的软件遇到异常情况或者发现了严重到必须立即修复的软件缺陷时，就需要从master分支上指定的TAG版本派生hotfix分支来组织代码的紧急修复工作。优点是不会打断正在进行的develop分支的开发工作，能够让团队中负责新功能开发的人与负责代码紧急修复的人并行的开展工作。
hotfix分支基于Master分支创建，开发完后需要合并回Master和Develop分支，同时在Master上打一个tag。

可以发现： hotfix派生于master分支，需要合并回develop分支，逆转了开发路线，很可能出现冲突，出现冲突较难处理。
完成一个bugfix之后，需要把butfix合并到master和develop分支去，这样就可以保证修复的这个bug也包含到下一个发行版中。这一点和完成release分支很相似。

为什么要设置这么多分支？
因为为了对应版本的变化，需要设置这些版本分支。
为了对应临时合并状态，设置了功能分支。

## demo

``` bash
# 需要新建一个new分支并切换：

git checkout -b new

echo 经写了一些东西并提交

echo 要紧急修复某个BUG

git status

# 把当前已经修改的但是还未提交的暂存起来
git stash

```

``` bash
# 切回主分支
git checkout master

# 并新建hotfix分支
git checkout -b hotfix

echo 修复BUG并add与commit

# 切换到主分支，

git checkout master

# 合并hotfix分支，
git merge --no-ff -m "合并hotfix分支" hotfix

# 最后删除hotfix分支
git branch -d hotfix

```

``` bash
git checkout new
git status

# 恢复工作区
git stash pop

echo 继续工作

```

## misc

常见的flow策略：
* git flow
* github flow
* gitlab flow

git flow策略最复杂， github flow策略简洁很多。gitlab flow侧重于master分支。
不过以上策略只侧重于branch，没有使用submodule和subtree。
