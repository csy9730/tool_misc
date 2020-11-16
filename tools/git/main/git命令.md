# Git 命令速查表


## **1、常用的Git命令**

命令简要说明
``` bash
git add # 添加至暂存区

git add-interactive # 交互式添加

git apply应用补丁

git am　　应用邮件格式补丁

git annotate同义词，等同于git blame

git archive # 文档归档打包

git bisect二分查找

git blame文件逐行追溯

git branch分支管理

git cat-file版本库对象研究工具

git checkout检出到工作区、切换或创建分支

git cherry-pick提交拣选

git citool # 图形化提交，相当于git gui命令

git clean # 清除工作区未跟踪文件

git clone # 克隆版本库

git commit #提交

git config # 查询和修改配置

git describe # 通过里程碑直观地显示提交ID

git diff # 差异比较

git difftool # 调用图形化差异比较工具

git fetch #获取远程版本库的提交

git format-patch创建邮件格式的补丁文件。参见git am 命令

git grep文件内容搜索定位工具

git gui基于Tcl/Tk的图形化工具，侧重提交等操作

git help帮助

git init版本库初始化

git init-db*同义词，等同于git init

git log显示提交日志

git merge分支合并

git mergetool图形化冲突解决

git mv # 重命名

git pull # 拉回远程版本库的提交

git push # 推送至远程版本库

git rebase # 分支变基

git rebase-interactive # 交互式分支变基

git reflog # 分支等引用变更记录管理

git remote# 远程版本库管理

git repo-config*同义词，等同于 git config

git reset # 重置改变分支“游标”指向

git rev-parse # 将各种引用表示法转换为哈希值等

git revert # 反转提交

git rm # 删除文件

git show显示各种类型的对象

git stage # 等同于git add

git stash # 保存和恢复进度

git status # 显示工作区文件状态

git tag # 里程碑管理
```

## **2.对象库操作相关命令**

命令简要说明
``` bash
git-commit-tree从树对象创建提交

git hash-object从标准输入或文件计算哈希值或创建对象

git ls-files # 显示工作区或暂存区文件

git ls-tree # 显示树对象包含的文件

git mktag读取标准输入创建一个里程碑对象

git mktree读取标准输入创建一个树对象

git read-tree读取树对象到暂存区

git update-index工作区内容注册到暂存区及暂存区管理

git unpack-file创建临时文件包含指定blob的内容

git write-tree从暂存区创建一个树对象
```

## **3.引用操作相关命令**

命令简要说明
```
git check-ref-format检查引用名称是否符合规范

git for-each-ref　　引用迭代器，用于shell编程

git ls-remote显示远程版本库的引用

git name-rev将提交ID显示为友好名称

git peek-remote*过时命令，请使用git ls-remote

git rev-list显示版本范围

git show-branch显示分支列表及拓扑关系

git show-ref显示本地引用

git symbolic-ref显示或者设置符号引用

git update-ref更新引用的指向

git verify-tag校验GPG签名的Tag
```
## **4.版本库管理相关命令**

命令简要说明
```
git count-objects显示松散对象的数量和磁盘占用

git filter-branch版本库重构

git fsck对象库完整性检查

git fsck-object*同义词，等同于git fsck

git gc版本库存储优化

git index-pack从打包文件创建对应的索引文件

git lost-found*过时，请使用git fsck -lost-found

git pack-objects从标准输入读入对象ID，打包到文件

git pack-redundant查找多余的pack文件

git pack-refs将引用打包到.git/packed-refs文件中

git prune从对象库删除过期对象

git prune-packed将已经打包的松散对象删除

git relink为本地版本库中相同的对象建立硬连接

git repack将版本库未打包的松散对象打包

git show-index读取包的索引文件，显示打包文件中的内容

git unpack-objects从打包文件释放文件

git verify-pack校验对象库打包文件
```

## **5.数据传输相关命令**

命令简要说明
```
git fetch-pack执行git fetch或git pull命令时在本地执行此命令，用于从其他版本库获取缺失的对象

git receive-pack执行git push命令时在远程执行的命令，用于接受推送的数据

git send-pack执行git push命令时在本地执行的命令，用于想其他版本库推送数据

git upload-archive执行git archive-remote 命令基于远程版本库创建归档时，远程版本库执行此命令传送归档

git upload-pack执行git fetch 或git pull 命令时在远程执行此命令，将对象打包、上传
```
## **6.邮件相关命令**

命令简要说明
```
git imap-send将补丁通过IMAP发送

git mailinfo从邮件导出提交说明和补丁

git mailsplit将mbox或Maildir格式邮箱中邮件逐一提取为文件

git request-pull创建包含提交间差异和执行PULL操作地址的信息

git send-email发送邮件
```
## **7.协议相关命令**

命令简要说明
```
git daemon实现Git协议

git http-backend实现HTTP协议的CGI程序，支持智能HTTP协议

git instaweb即时启动浏览器通过gitweb浏览当前版本库

git shell受限制的shell，提供仅执行Git命令的SSH访问

git update-server-info更新哑协议需要的辅助文件

git http-fetch通过HTTP协议获取版本库

git http-push通过HTTP/DAV协议推送

git remote-ext由Git命令调用，通过外部命令提供扩展协议支持

git remote-fd由Git命令调用，使用文件描述符作为协议接口

git remote-ftp由Git命令调用，提供对FTP协议的支持

git remote-ftps由Git命令调用，提供对FTPS协议的支持

git remote-http由Git命令调用，提供对HTTP协议的支持

git remote-https由Git命令调用，提供对HTTPS协议的支持

git remote-testgit协议扩展示例脚本
```
## **8.版本转换和交互相关命令**

命令简要说明
```
git archimport导入Arch版本库到Git

git bundle提交打包和解包，以便在不同版本库间传递

git cvsexportcommit将Git的一个提交作为一个CVS检出

git cvsimport导入CVS版本库到Git。或者使用cvs2git

git cvsserverGit的CVS协议模拟器，可供CVS命令访问Git版本库

git fast-export将提交导出为git-fast-import格式

git fast-import其他版本库迁移至Git的通用工具

git svnGit作为前端操作Subversion
```
## **9.合成相关的辅助命令**

命令简要说明
```
git merge-base供其他脚本调用，找到两个或多个提交最近的共同祖先

git merge-file针对文件的两个不同版本执行三向文件合并

git merge-index对index中的冲突文件调用指定的冲突解决工具

git merge-octopus合并两个以上分支。参见git merge 的octopus合并策略

git merge-one-file由git merge-index调用的标准辅助程序

git merge-ours合并使用本地版本，抛弃他人版本。参见git merge的ours合并策略

git merge-recursive针对两个分支的三向合并。参见git merge的recursive合并策略

git merge-resolve针对两个分支的三向合并。参见git merge的resolve合并策略

git merge-subtree子树合并。参见git merge的subtree合并策略

git merge-tree显示三向合并结果，不改变暂存区

git fmt-merge-msg供执行合并操作的脚本调用，用于创建一个合并提交说明

git rerere重用所记录的冲突解决方案
```
## **10.杂项**

命令简要说明
```
git bisect-helper由git bisect命令调用，确认二分查找进度

git check-attr显示某个文件是否设置了某个属性

git checkout-index从暂存区拷贝文件至工作区

git cherry查找没有合并到上游的提交

git diff-files比较暂存区和工作区，相当于git diff -raw

git diff-index比较暂存区和版本库，相当于git diff -cached -raw

git diff-tree比较两个树对象，相当于git diff -raw A B

git difftool-helper由git difftool命令调用，默认要使用的差异比较工具

git get-tar-commit-id从git archive创建的tar包中提取提交ID

git gui-askpass命令git gui的获取用户口令输入界面

git notes提交评论管理

git patch-id补丁过滤行号和空白字符后生成补丁唯一的ID

git quiltimport将Quilt补丁列表应用到当前分支

git replace提交替换

git shortlog对git log的汇总输出，适合于产品发布说明

git stripspace删除空行，供其他脚本调用

git submodule子模组管理

git tar-tree过时命令，请使用git archive

git var显示Git环境变量

git web-browse启动浏览器以查看目录或文件

git whatchanged显示提交历史及每次提交的改动

git-mergetool-lib包含于其他脚本，提供合并/差异比较工具的选择和执行

git-parse-remote包含于其他脚本中，提供操作远程版本库的函数

git-sh-setup包含于其他脚本中，提供shell编程的函数库

```
## git help

git 命令
```
语法：
　　git [--version] [--help] [-C <path>] [-c <name>=<value>]
    　　[--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
    　　[-p|--paginate|--no-pager] [--no-replace-objects] [--bare]
    　　[--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
    　　[--super-prefix=<path>]
    　　<command> [<args>]

选项：
    --version               # 打印git程序的版本号
    --help                  # 打印概要和最常用命令的列表
    -C <path>               # 在<path>而不是当前的工作目录中运行git
    -c <name>=<value>       # 将配置参数传递给命令, 给定的值将覆盖配置文件中的值
    --exec-path[=<path>]    # 安装核心Git程序的路径, 可以通过设置GIT_EXEC_PATH环境变量来控制, 如无路径, git将打印当前设置并退出
    --html-path             # 打印Git的HTML文档安装并退出的路径, 不带斜杠
    --man-path              # 打印man(1)此版本Git的手册页的manpath, 并退出
    --info-path             # 打印记录此版本Git的Info文件的安装路径并退出
    -p, --paginate          # 如果标准输出是终端, 则将所有输出管道更少（或如果设置为$ PAGER）, 这将覆盖pager.<cmd> 配置选项
    --no-pager              # 不要将Git输出管道传输到寻呼机
    --no-replace-objects    # 不要使用替换参考来替换Git对象
    --bare                  # 将存储库视为裸存储库, 如果未设置GIT_DIR环境, 则将其设置为当前工作目录
    --git-dir=<path>        # 设置存储库的路径, 可以通过设置GIT_DIR环境变量来控制, 可以是当前工作目录的绝对或相对路径
    --work-tree=<path>      # 设置工作树的路径, 可以通过设置GIT_WORK_TREE环境变量和core.worktree配置变量来控制, 相对于当前工作目录的绝对或相对路径
    --namespace=<path>      # 设置Git命名空间, 相当于设置GIT_NAMESPACE环境变量
    --super-prefix=<path>   # 目前仅供内部使用, 设置一个前缀, 该前缀从存储库到根的路径, 一个用途是给调用它的超级项目的子模块上下文
    --literal-pathspecs     # 字面上处理pathspecs, 相当于设置GIT_LITERAL_PATHSPECS为1
    --glob-pathspecs        # 添加"glob"到所有pathspec, 相当于设置GIT_GLOB_PATHSPECS为1
    --noglob-pathspecs      # 添加"文字"到所有pathspec, 相当于设置GIT_NOGLOB_PATHSPECS为1
    --icase-pathspecs       # 添加"icase"到所有pathspec, 相当于设置GIT_ICASE_PATHSPECS为1
    --no-optional-locks     # 不要执行需要锁定的可选操作, 相当于设置GIT_OPTIONAL_LOCKS为0
```