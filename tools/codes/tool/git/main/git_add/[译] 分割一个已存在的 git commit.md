# [译] 分割一个已存在的 git commit

[江米小枣tonylua](https://juejin.cn/user/3034307821311895/posts)

2018-11-185,453阅读1分钟

原文：[codewithhugo.com/split-an-ex…](https://link.juejin.cn/?target=https%3A%2F%2Fcodewithhugo.com%2Fsplit-an-existing-git-commit%2F)

Git 与其他版本控制系统的主要区别之一，在于其允许用户重写历史。实现这一目的的主要途径则是 `git reabse`，通常还跟随着一句 `git push --force` 以用本地历史重写远端历史。

这里要谈论的是如何用`rebase`、`reset` 和 `commit` 来分割既有的提交。

比方说在一次 commit 中，包含了两个编辑过的文件（A 和 B）；但你只想把其中的 A 引入当前分支，B 则不需要。

使用 `git cherry-pick ` 并不可行，因为它会把 A 和 B 的改变都拉过来。

解决方法是将那次 commit 分成两个，然后只 `cherry-pick` 包含了 A 的那个。

做法如下：

- 运行 `git rebase -i ~` (注意 `~`)，或者 `git rebase -i `
- 在编辑窗口中找到要更改的那次 commit，将其前面的 `pick` 改成 `edit`
- 保存并退出 VIM
- `git reset HEAD~` 以重置阶段性的改变
- `git add [files-to-add]` 所有本次需要用到的文件 (此处就是 A)
- 正常的 `git commit -m `
- 一次或多次的将剩余的文件分别提交
  - `git add [other-files-to-add]``
  - `git commit`
- `git rebase --continue` 以指示分割过程完成并退出变基操作

最后，就可以用 `git cherry-pick ` 将所需的新提交引入我们的分支中了。





--End--



搜索 fewelife 关注公众号

![img](https://p1-jj.byteimg.com/tos-cn-i-t2oaga2asx/gold-user-assets/2018/11/18/167261edc0a6d7ca~tplv-t2oaga2asx-image.image))

转载请注明出处