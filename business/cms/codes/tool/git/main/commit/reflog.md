# [撤销 git commit --amend](https://segmentfault.com/a/1190000014272359)



想必大家都知道 `git commit --amend` 这条实用命令, 其可以用来修改最后一条提交的 commit message, 也可以追加新的修改.
但有时候不小心 amend 了错误的内容, 如何回退呢?
普通青年一般会用 `git reset` 撤销到上一个提交, 再重新 `git commit` 一次, 这固然是可以的. 但如果工作区此时已经改的面目全非, 这时如果执行 `git reset`, 就很难分的清哪些内容属于被撤销的提交了. 嗯, 这位同学说这种情况可以用 `git stash` 来处理, 是可以解决问题的.
但是, 身为文艺青年, 怎么能用这么不优(zhuang)雅(bi)的方法呢.

先上结论:
如果只 amend 了一次, 那么直接用 `git reset HEAD@{1}` 就可以撤销这次 amend. 如果 amend 多次, 就参考 `git reflog` 进行撤销.

下面以实例介绍如何就地撤销 `git commit --amend`.

## 制造事故现场

首先制造事故现场. 追加空行到项目中的 index.html 文件下:

```
$ echo "" >> index.html 
$ git add .
$ git commit -m "add blank line to index.html"
```

然后再加一行到 index.html, 并 amend 一下:

```
$ echo "this line would break the code" >> index.html 
$ git add .
$ git commit --amend
```

现场已经出现, 我们要撤销 amend 的那个提交.

## 撤销 amend

首先使用 `git reflog` 命令查看操作记录:

```
$ git reflog
c1c1b21 HEAD@{0}: commit (amend): add blank line to index.html
9ff821d HEAD@{1}: commit: add blank line to index.html
b078331 HEAD@{2}: commit: no more commit!
b86e902 HEAD@{3}: commit: so many commit
77e6ce9 HEAD@{4}: commit: this is another commit
ccde039 HEAD@{5}: commit: this is a commit
a49dcf4 HEAD@{6}: clone: from ssh://liux@xxx.xx.xx.xxx:29418/git_test.git
```

看到 amend 操作之前的最后一个操作就是 `HEAD@{1}`.
现在可以用 `git reset` 将当前分支的 HEAD 指向 `HEAD@{1}`, 即可达到撤销 amend 的目的:

```
$ git reset --soft HEAD@{1}
$ git status
On branch master
Your branch is ahead of 'origin/master' by 5 commits.
  (use "git push" to publish your local commits)
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

    modified:   index.html
```

随即使用 `git status` 查看状态, 发现 amend 的内容已经被撤销 (到工作区) 了.
如果想撤销到暂存区, 就用 `git reset --soft HEAD@{1}` .
如果想干掉这个修改, 就用 `git reset --hard HEAD@{1}` .
这和 `git reset` 操作 commit 的情形是一样的.

如果一个 commit 被 amend 了多次, 也可以用这种方法撤销到任意一次 amend 处:

```
$ git reflog
937fd53 HEAD@{0}: commit (amend): add blank line to index.html
7589755 HEAD@{1}: commit (amend): add blank line to index.html
f7ade82 HEAD@{2}: commit (amend): add blank line to index.html
c1c1b21 HEAD@{3}: commit (amend): add blank line to index.html
9ff821d HEAD@{4}: commit: add blank line to index.html
$ git reset --soft HEAD@{2}
```

可以看出, 不止是 amend 操作, 其他操作也可以用这种方法进行撤销.