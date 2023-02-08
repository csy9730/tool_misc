# git_subtree


多仓库管理
1. 直接添加第三方仓库的内容（工作树文件）
2. 直接克隆第三方git仓库
3. 使用 submodule，添加第三方git仓库。
4. 使用 subtree

- 添加第三方仓库的内容，难以管理第三方仓库的更新，难以同步到主仓库，由用户自行维护主仓库的同步，适用于第三方仓库几乎不更新或者主仓库几乎不依赖子仓库更新的情况。
- 克隆第三方git仓库，可以管理第三方仓库的更新，但是第三方的提交号难以反映到主仓库，难以处理历史纪录中，两边仓库版本匹配混乱的问题。适用于第三方仓库低频更新的情况。
- submodule 更加完善，包含了第三方仓库和更新版本信息。使用不方便。
- subtree 相比submodule更加推荐使用subtree，
- 第二种和第三种方式类似，都是处理git仓库；第一种和第四种方式类似，都处理文件夹。

如果子仓库和父仓库都没有破坏性更新，那么用什么方式都一样，无需考虑用subtree和submodule的高阶特性，考虑到破坏性更新，要求子仓库和父仓库同步更新，此时就要考虑父子仓库的依赖性。
### subtree



subtree与submodule的作用是一样的，但是subtree出现得比submodule晚，它的出现是为了弥补submodule存在的问题：

第一： submodule不能在父版本库中修改子版本库的代码，只能在子版本库中修改，是单向的；
第二： submodule没有直接删除子版本库的功能；

而subtree则可以实现双向数据修改。官方推荐使用subtree替代submodule。

subtree的强大之处在于，它可以在父版本库中修改依赖的子版本库。

#### SYNOPSIS
```
git subtree add   -P <prefix> <commit>
git subtree add   -P <prefix> <repository> <ref>
git subtree pull  -P <prefix> <repository> <ref>
git subtree push  -P <prefix> <repository> <ref>
git subtree merge -P <prefix> <commit>
git subtree split -P <prefix> [OPTIONS] [<commit>]
```

- 添加子仓库
- 分离子仓库
- 拉取
- 推送
- merge


### Subtrees vs Submodules
最简单理解两者的方式，subtrees在父仓库是拉取下来的一份子仓库拷贝，而submodule则是一个指针，指向一个子仓库commit。

这两者的差别意味着，不需要推送更新到submodule因为我们直接提交更新到它指向的子仓库，但推送更新到subtree则显得比较复杂，因为父仓库没有子仓库相关的历史信息。

这同样意味着，开发者拉取subtree子仓库代码会比较简单，因为它作为一部分被父仓库管理着。所以我们可以过激地比较：

- submodules， 子仓库推送简单，但父仓库拉取困难，因为submodules是指向子仓库的指针
- subtrees，父仓库推送困难（存在分支合并？），但父仓库拉取简单，因为subtrees是子仓库的拷贝

Submodule 與 Subtree 兩個都是可以將 SubRepo 加入 SuperRepo 的解決方法，但怎麼解決的及實際使用上都有所差異。

簡單來說 Submodule 是用像指標的方式，將 SubRepo 的 HASH 紀錄在 SuperRepo 中，而 Subtree 則是以副本的方式把 SubRepo 某版複製一份到 SuperRepo。

用表格看可能就更清楚了：

||Submodule	|SubTree|
|------	|----|----|
|Cost	|僅佔用 .gitmodule	|佔用等同 SubRepo 的大小的空間|
|Clone SuperRepo	|需多步驟	|原指令|
|Push to SubRepo	|容易，視為兩個獨立的 Repo，可以直接 push	|不容易，因為不知道 SubRepo log，還要比對|
|pull to SubRepo	|不容易，需執行另外執行指令	|容易，因為就只是 Pull SuperRepo|

簡單形容	一個 Repo 中的另一個 Repo	跟原本 Repo 合併，視為一個子目錄

另外也可以用一句話的方式描述：

Submodule: 較易 push，較不易 pull，不佔空間，因為它只紀錄 HASH。
Subtree: 較不易 push，較易 pull，不佔空間，因為是副本。


> submodule is link; subtree is copy 。

Submodule： 子仓库push容易，父仓库pull难？

subtree：子仓库push困难，父仓库pull容易？
