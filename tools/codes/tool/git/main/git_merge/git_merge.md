# git merge


- commit 创建版本
- branch 管理分支
- merge 管理分支之间的版本交互
- fetch/pull 管理远程分支和本地分支

## merge


将其他分支合并到当前所在工作分支上。当前工作分支的内容会由于merge操作产生更新，但是目标分支则完全不受影响

```bash
git checkout master
# 合并dev分支
git merge dev

# 合并 dev的最新之前3个的提交
git merge dev~3

# 直接合并到指定提交位置
git merge 0d0b0ff3
```

### 冲突处理

- 快进合并, 单线合并，简单移动master指针即可
- 钻石合并


#### 快进合并
当前工作分支到合并目标分支之间的提交历史是线性路径时，可以进行快进合并
#### 钻石合并
钻石合并(diamond merge)，需要两个分支和共同祖先一起合并
合并冲突，使用三路合并算法，冲突处理不了的情况下，需要人工处理冲突，

```
              main tip ---------
            /                  \
common base                      new merge tip
            \                  /
              feature tip -----
```


#### 三路合并
三路合并算法需要使用一个专用commit来整合两边的提交历史。这个名词源于Git要想生成合并commit，需要用到三个commits：两个分支的顶端commit，以及它们的共同祖先commit。

以下情况可以自动merge
* 多成员修改不同文件
* 多成员修改相同文件不同区域
* 同时修改文件名和文件内容

#### 手工处理

如果将要合并的两个分支都修改了同一个而文件的同一个部分内容，Git就无法确定应该使用哪个版本的内容。当这种情况发生时，合并过程会停止在合并commit提交之前，以便给用户留下机会手动修复这些冲突。


``` bash
# 手工处理请求
# open file by vim or vscode
git add . && git commit


# 放弃当前的冲突合并
git merge --abort 
```

#### 常用的选项

```
--no-ff：禁用fast-forward合并策略，强制Git创建一个新的合并提交。
--squash：将合并结果压缩为一个提交，并且不会保留源分支的提交历史。
-m <message>：指定新的合并提交的提交信息。
```

## faq
### 如何查看分支图

使用gitk。
