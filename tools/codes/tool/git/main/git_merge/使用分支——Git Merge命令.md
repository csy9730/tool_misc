# 使用分支——Git Merge命令

[![杨世伟](https://picx.zhimg.com/v2-67963a18a22ddf396cf6bbdd7123db18_l.jpg?source=172ae18b)](https://www.zhihu.com/people/yang-shi-wei)

[杨世伟](https://www.zhihu.com/people/yang-shi-wei)![img](https://pic1.zhimg.com/v2-4812630bc27d642f7cafcd6cdeca3d7a.jpg?source=88ceefae)

拉黑所有编故事的知乎答主；长期减肥者；CF新入坑；

在Git中merge是用来把分叉的提交历史放回到一起的方式。`git merge`命令用来将你之前使用`git branch`命令创建的分支以及在此分支上独立开发的内容整合为一个分支。

请注意下面的所有命令都会是将其他分支合并到当前所在工作分支上。当前工作分支的内容会由于merge操作产生更新，但是目标分支则完全不受影响。再次强调，这意味着`git merge`通常与其他几个git命令一起使用，包括使用`git checkout`命令来选择当前工作分支，以及使用`git branch -d`命令来删除已经合并过的废弃分支。

## **它是如何运行的**

`git merge`会将多个提交序列合并进一个统一的提交历史。在最常见的使用场景中，`git merge`被用来合并两个分支。在本文档接下来的部分，我们会专注于这种合并场景。在这种场景中，`git merge`接受两个commit指针，通常是两个分支的顶部commit，然后向前追溯到这两个分支最近的一个共同提交。一旦找到这个共同提交，Git就会创建一个新的"merge commit"，用来合并两个分支上各自的提交序列。

比如说我们有一个功能分支由`main`分支派生出来，现在我们希望将这个功能分支合并回`main`分支。

![img](https://pic1.zhimg.com/80/v2-57bf0fea524c5acce87ea41d0e296ec0_720w.webp)

执行合并命令会将指定分支合并到当前工作分支上，我们假设当前工作分支为`main`。Git根据两个分支自行决定合并提交的算法（将在下面具体讨论）。

![img](https://pic4.zhimg.com/80/v2-f1367f5eb6fe5f6fc0cf378576a2503f_720w.webp)

合并commit与普通commit不一样，因为合并commit会有两个父提交。创建一个合并commit时Git会尝试自动将两个独立的提交历史合并为一个。不过当Git发现某一块数据在两边的提交历史中都含有变更，它将无法自动对其进行合并。这种情况被称为版本冲突，此时Git需要人为介入调整才能继续进行合并。

## **准备合并**

在实际进行合并操作之前，需要进行一些准备步骤，以保证合并过程能够顺利进行。

## **确认接收合并的分支**

执行`git status`命令查看当前分支的状态，确保`HEAD`指正指向的是正确的接收合并的分支。如果不是，执行`git checkout`命令切换到正确的分支。在我们的示例中，执行`git checkout main`。

## **获取最新的远程提交**

确保合并操作涉及的两个分支都更新到远程仓库的最新状态。执行`git fetch`拉取远程仓库的最新提交。一旦fetch操作完成，为了保证`main`分支与远程分支同步，还需执行`git pull`命令。

## **合并**

当上面提及的准备工作都已完备，合并就可以正式开始了。执行`git merge `命令，其中<branch>为需要合并到当前分支的目标分支名称。

## **快进合并**

当前工作分支到合并目标分支之间的提交历史是线性路径时，可以进行快进合并。在这种情况下，不需要真实的合并两个分支，Git只需要把当前分支的顶端指针移动到目标分支的顶端就可以了（也就是快进的意思）。在这种情况下快进合并成功的将提交历史合并至一处，毕竟目标分支中的提交此时都包含在当前分支的提交历史中了。对于将功能分支快进合并到`main`分支的流程可以参见下图所示：

![img](https://pic3.zhimg.com/80/v2-959cf431990358bd0afa40def9aa45c6_720w.webp)

然而快进合并在两个分支出现分叉的情况下是不允许执行的。当目标分支相对于当前分支的提交历史不是线性的，Git只能通过三路合并算法来决定如何对两个分支进行合并。三路合并算法需要使用一个专用commit来整合两边的提交历史。这个名词源于Git要想生成合并commit，需要用到三个commits：两个分支的顶端commit，以及它们的共同祖先commit。

![img](https://pic3.zhimg.com/80/v2-fbcab3d2cad2725cbce868b9e3d740fa_720w.webp)

虽然实际上可以选择使用这些不同的合并策略，但是大多数开发者更喜欢快进合并（通过利用 [rebasing ](https://link.zhihu.com/?target=https%3A//www.atlassian.com/git/tutorials/rewriting-history/git-rebase)命令），尤其是用于小功能的开发或者bug修复；反之对于合并长期开发的功能分支，则更倾向于使用三路合并的方式。在第二种场景中，merge产生的合并commit会作为两个分支合并的标志保留在提交历史中。

接下来我们用下面第一个例子来展示如何进行快进合并。下面的命令会先创建一个新分支，在新分支上进行两次提交，然后用快进合并把新分支合并回`main`分支。

```bash
# Start a new feature
git checkout -b new-feature main
# Edit some files
git add <file>
git commit -m "Start a feature"
# Edit some files
git add <file>
git commit -m "Finish a feature"
# Merge in the new-feature branch
git checkout main
git merge new-feature
git branch -d new-feature
```

这个例子中的工作流程通常用于短期功能的开发，这种开发流程更多地被当做是比较独立的一次开发流程，与之对应的则是需要协调和管理的长期功能开发分支。

另外还需注意到，在此例中Git不会对`git branch -d`命令发出警告，因为new-feature的内容已经合并到主分支里了。

在某些情况下，虽然目标分支的提交历史相对于当前分支是线性的，可以进行快进合并，但你仍然希望有一个合并commit来标志合并在此commit发生过，那么可以在执行`git merge`命令时使用`--no-ff`选项。

```bash
git merge --no-ff <branch>
```

以上命令将指定分支合并到当前分支，但总会生成一个合并commit（即便这一合并操作可以快进）。当你需要在仓库的提交历史中标记合并事件时这一命令相当有用。

## **三路合并**

接下来的例子与上面比较像，但是因为`main`分支在feature分支向前发展的过程中，自身也发生的改变，因此在合并时需要进行三路合并。在进行大的功能开发或者有多个开发者同时进行开发时这种场景相当常见。

```bash
Start a new feature
git checkout -b new-feature main
# Edit some files
git add <file>
git commit -m "Start a feature"
# Edit some files
git add <file>
git commit -m "Finish a feature"
# Develop the main branch
git checkout main
# Edit some files
git add <file>
git commit -m "Make some super-stable changes to main"
# Merge in the new-feature branch
git merge new-feature
git branch -d new-feature
```

需注意在这种情况下，由于没有办法直接把`main`的顶端指针移动到`new-feature`分支上，因此Git无法执行快进合并。

在大多数实际工作场景中，`new-feature`应该是一个很大的功能，开发过程持续了相当长的时间，这也就难免同时期在`main`分支上也有新的提交。如果你的功能分支大小像上面的例子一样小，则完全可以使用rebase将`new-feature`分支变基到`main`分支上，然后再执行一次快进合并。这样也会避免在项目提交历史中产生过多的冗余。

## **解决冲突**

如果将要合并的两个分支都修改了同一个而文件的同一个部分内容，Git就无法确定应该使用哪个版本的内容。当这种情况发生时，合并过程会停止在合并commit提交之前，以便给用户留下机会手动修复这些冲突。

在Git的合并过程中，很棒的一点是它使用人们熟知的 编辑 / 暂存 / 提交 这样的工作流程来解决冲突。当碰到合并冲突时，执行`git status`命令会列出哪些文件含有冲突并需要手动解决。比如说当两个分支都修改了`hello.py`文件的同一部分，你会看到类似下面这样的信息：

```bash
On branch main
Unmerged paths:
(use "git add/rm ..." as appropriate to mark resolution)
both modified: hello.py
```

## **冲突是如何显示的**

当Git在合并过程中碰到了冲突，它会编辑受影响的文件中的相关内容，并添加视觉标记用以展示冲突中双方在此部分的不同内容。这些视觉标记为：<<<<<<<,=======,>>>>>>>。要找到冲突发生的具体位置，在文件中搜索这些视觉标记会非常便捷地达成目的。

```bash
here is some content not affected by the conflict
<<<<<<< main
this is conflicted text from main
=======
this is conflicted text from feature branch
>>>>>>> feature branch;
```

通常来说在 ====== 标记之前的内容来自于接收合并的分支，而在这之后的内容来自于要合并的分支。

一旦找到冲突的部分，就可以根据需要来修正冲突。当你完成了冲突的修复并准备好继续进行合并，只需要执行`git add`命令把已经解决好冲突的文件添加暂存区，告诉Git这些冲突已经解决完毕即可。这之后就像正常提交代码一样执行`git commit`完成合并commit。这个过程跟正常情况下提交代码是完全一样的，也就是说对于普通开发者来说处理冲突也是小菜一碟。

还需注意合并冲突只可能出现在三路合并过程中，在快进合并中不会出现冲突。

## **总结**

本文是关于`git merge`命令的概览。在使用Git的过程中，合并是非常重要的操作。本文讨论了合并操作背后的机制，以及快进合并与三路合并的区别。需要读者记住的要点如下：

1. Git 合并流程是把不同的提交序列合并到一个统一的提交历史中
2. Git合并过程中有两个主要的方式：快进合并 和 三路合并
3. 除非两个提交序列中出现冲突，Git通常可以自动对提交进行合并



发布于 2022-02-15 21:04

[Linux](https://www.zhihu.com/topic/19554300)

[Git](https://www.zhihu.com/topic/19557710)

[GitBook](https://www.zhihu.com/topic/20035884)