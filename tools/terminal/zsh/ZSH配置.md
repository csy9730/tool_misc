# ZSH配置

bash用久了，有些地方开始觉得不爽，于是想看看有没有更好的选择。原来在网上瞎逛时，已经很多次看到有人推荐zsh了，加上zsh高度兼容bash，于是就来折腾这个。
不过试验了一下oh-my-zsh，感觉功能太强大了，太多东西不知道怎么配置的，这种过于“不知其所以然”的感觉我不太喜欢。于是自己来折腾，觉得基本够自己用就行了。

## 1. 补全

很多介绍zsh的文章都说zsh相对bash的一个优点是支持命令选项和参数的补全

![img](https://images0.cnblogs.com/blog/163248/201308/11222133-ed2e19e594b9427aa39b527b815fe9c1.png)

![img](https://images0.cnblogs.com/blog/163248/201308/11222049-4b446bb90e8b452eafcc7ff95c5de7ee.png)
（这两幅图来自 [Z使用 Zsh 的九个理由 - 博客 - 伯乐在线](http://blog.jobbole.com/28829/))

其实bash里面如果你安装了[bash-completion](http://bash-completion.alioth.debian.org/‎)这个包的话，很多命令（比如pkill, dpkg, git等等，我的机器上`/etc/bash_completion.d/`下面有[200多个命令的补全配置](http://packages.debian.org/testing/all/bash-completion/filelist)。注意`/etc/bash_completion.d/git`其实是git包提供的，而`/etc/bash_completion.d/mercurial`其实是mercurial包提供的） 。

不过zsh在补全还是有些比bash强的地方，尤其是涉及到交互的地方:

1. 按TAB补全时，能够在多个备选项之间循环，如果备选项不多的话，你只需要不断按TAB就行了，而bash只会列出备选项，你得多输入一个或几个字母直到备选项缩小到一个了它才真正给你补全;
2. 有一定的容错能力: 可以在配置文件中添加一句 `zstyle ':completion::approximate:' max-errors 1 numeric` ，以后输入cd /etc/x11, 按TAB后zsh会给你纠正为/etc/X11 （此条来自 [终极Shell——Zsh — LinuxTOY](http://linuxtoy.org/archives/zsh.html)，那里有详细的说明）;
3. 补全时可以用光标键或者Ctrl-p/Ctrl-n来挑选被选项（即很多文章说到的menu select方式）。不过针对第这一点，就得说到zsh的两个缺点：配置太TMD复杂、说明文档也巨罗嗦，你要是对缺省配置有一点点不满意，或者搞错了， 就很容易陷入泥沼里，有兴趣的自己研究这个文档吧: [Chapter 6: Completion, old and new - A User's Guide to the Z-Shell](http://zsh.sourceforge.net/Guide/zshguide06.html) （P.S. 一篇简单的介绍: [Refining Linux: ZSH Gem #5: Menu selection](http://www.refining-linux.org/archives/40/ZSH-Gem-5-Menu-selection/) )

另外，zsh自带的补全源的确比bash-completion多，我这里`find /usr/share/zsh/functions/Completion -type f | wc -l` 的结果是688个文件（参见 [Debian -- Filelist of package zsh-common/jessie/all](http://packages.debian.org/jessie/all/zsh-common/filelist) )

## 2. 在目录中穿梭(cd命令)

在写代码过程中，会在各个目录之间来回切换，原来用bash时有两点最不爽:

- 对cd命令有TAB补全的功能，但每一级目录都需要按TAB（并且有多个备选项的话需要继续输入才行）还是觉得繁琐，觉得效率不高;
- `pushd/popd/dirs`虽然很有用，但很多时候等你想回到过去的某个目录时，才发现当时忘记`pushd了`

### 2.1 zsh的改进方法

- 首先，假如`/opt/rubystack-1.9/`下面有`apache2`和`apps`这两个目录，输入`cd /opt/rubystack-1.9/a`然后按TAB的话，首先会补齐为apache2，再按TAB会补齐为apps，不需要象bash下面那样继续输入字母;
- 如果你想进入`/opt/rubystack-1.9/apps/redmine`，那么可以先这样输入 `cd /o/r/a/r` 然后按`TAB`，如果这是唯一匹配，那么zsh会补全为`/opt/rubystack-1.9/apps/redmine，但如果还存在一个/opt/rubystack-1.8/apps/redmine，那zsh就会列出来让你挑选;`
- 如果你现在在`/opt/rubystack-1.9/apps/redmine，`但你想进入`/opt/rubystack-1.8/apps/redmine，可以这样: cd 1.9 1.8 这表示将完整路径上的1.9替换为1.8再使用;`
- 你可以打开`auto_pushd`选项(通过命令`setopt auto_pushd`），这样你通过cd切换目录时，zsh会自动将前一个目录加到栈里，这样你就不会因为忘记pushd而遗憾了;
- bash里面可以`cd -`回到上一个目录（即最后一次调用cd时所在的目录），但zsh里面有`cd -2, cd +3这样的用法，并且在输入cd -之后按TAB能够列出目录名供挑选补全。不过需要注意的是，这里-2并不表示倒数第二次调用cd时的目录，而是倒数第二次通过pushd记录的目录，如 果打开了auto_pushd选项，那么这两个的含义倒是一样的;`
- zsh里面将~这个符号的用法进行了扩展，我们可以用`hash -d www=/var/www/html`定义一个路径别名，然后用`cd ~www`就可以进入到`/var/www/html`了

参考资料: [Refining Linux: ZSH Gem #20: Changing directories the pro's way](http://www.refining-linux.org/archives/55/ZSH-Gem-20-Changing-directories-the-pros-way/)

### 2.2 autojump: 快速进入频繁访问的目录（bash/zsh通用）

使用方法

1. 下载这个 <https://github.com/rupa/z/blob/master/z.sh> （这个文件名跟zsh没有必然联系），放到某个位置（比如`/usr/local/lib/z.sh`）;
2. 在`~/.bashrc`或者`~/.zshrc`里面加入一句`source /usr/local/lib/z.sh`，这使得以后的cd命令会被z.sh统计各目录访问频率;
3. 你得按老方法切换目录一阵，以便z.sh能够知道哪些目录是最常用的;
4. 用`z -l`命令即可列出历史上你访问各个目录的频率了;
5. 用`z`*regex* 命令即可进入你频繁访问的目录

## 3. 提示符设置

oh-my-zsh提供了很多很花哨且功能强大的提示符设置，比如显示git当前分支名、提交状态等等:
![img](https://images0.cnblogs.com/blog/163248/201308/11222258-b2eee8d3e256453db3e4a7a7bc7abf1d.png)

### 3.1 基本设置

不过我觉得Debian缺省推荐的(见`/etc/zsh/newuser.zshrc.recommended` )提示符设置就可以了(只是简单地显示用户名、机器名和全路径）

```
autoload -Uz promptinit
promptinit
prompt adam1
```

### 3.2 RPROMPT

不过我有时也想显示一点别的内容，zsh有个RPROMPT环境变量用来设置显示在右边的提示符，可以在有需要的时候即设即用，很方便。比如我用它配置了 用来显示当前git仓库名、分支名和提交状态（也许你又要问我为什么不用oh-my-zsh，那是因为我没看见它显示git仓库名，而这个庞大的东西我不 知道怎么去修改它。甚至下面这段代码我也是抛弃了StackOverflow上[得票最多的答案](http://stackoverflow.com/a/1128583)，而是选了个[得分为0的答案为基础](http://stackoverflow.com/a/1128721)，仅仅因为后面这个我能看懂，能修改它）

```
_git_repo_name() {
  gittopdir=$(git rev-parse --git-dir 2> /dev/null)
  if [[ "foo$gittopdir" == "foo.git" ]]; then
    echo `basename $(pwd)`
  elif [[ "foo$gittopdir" != "foo" ]]; then
    echo `dirname $gittopdir | xargs basename`
  fi
}
_git_branch_name() {
  git branch 2>/dev/null | awk '/^\*/ { print $2 }'
}
_git_is_dirty() {
  git diff --quiet 2> /dev/null || echo '*'
}

setopt prompt_subst 
RPROMPT='$(_git_repo_name) $(_git_branch_name) $(_git_is_dirty)'
```

## 4. 命令历史

4.1 多会话共享历史

我一般会用`tmux`开多个会话，这种情况下记得刚才输入过这个命令，但找了半天没找到才意识到好像是在另外一个window/pane里面输入的。zsh的一个功能特性是`share_history`，这样在一个会话里面可以访问另外一个会话的历史命令了。不过这个特性可能会让人有些不习惯，这样的话可以试试另外两个选项:setopt APPEND_HISTORY或者setopt INC_APPEND_HISTORY.

参考资料: [Refining Linux: ZSH Gem #15: Shared history](http://www.refining-linux.org/archives/49/ZSH-Gem-15-Shared-history/)

### 4.2 a clear history

```
setopt hist_ignore_space
alias cd=" cd"
alias ls=" ls"
```

第一句使得不将以空格开始的命令行记录到历史当中（这在需要在i命令行中明文输入密码时也挺有用，这样不会在历史记录中看到你的密码了）;
后面两句使得cd/ls这些简单的命令就不记录到历史了，这样用history查看的时候是不是更清晰了？

来自 ： <http://chneukirchen.org/blog/archive/2012/02/10-new-zsh-tricks-you-may-not-know.html>

另一个技巧: 每个目录记录自己的history: <<http://linuxtoy.org/archives/zsh_per_dir_hist.html>>

<http://www.lowlevelmanager.com/2012/05/zsh-history-expansion.html>

## 5. 其它设置

### 5.1 通配符带子目录

zsh支持更复杂的文件名匹配，不过我大部分我都没去学，只记住了我认为最有用的一个：

```
grep ":project_menu" **/*.erb
```

这个**会搜索所有的子目录，也就避免了用find了（bash下就得借用find了: `find . -name '*.erb | xargs grep ":project_menu"）`

### 5.2 setopt no_nomatch

这是zsh缺省跟bash不兼容的一个地方。在zsh下，如果你执行`dpkg -l firefox*`，很可能zsh不会列出名字以firefox开头的包，而是告诉你`zsh: no matches found: firefox*`。这是因为zsh缺省情况下始终自己解释这个firefox*，而不会传递给dpkg来解释。

解决这个问题的方法是在~/.zshrc中加入:

```
setopt no_nomatch
```

### 5.3 ~/.inputrc无法工作?

zsh没有使用libreadline，而是自己实现了一套类似的（名字叫做zle - zsh command line editor）。所以你原来在~/.inputrc里面配置的快捷键都不再有效，而是要用zle的语法重新配置一遍（也在~/.zshrc中配置）。

例子1:

```
bindkey "^[0H" beginning-of-line
bindkey "^[OF" end-of-line
```

例子2:

```
#按下F5时自动输入z -l | tail\n
bindkey -s "\e[15~"   "z -l | tail\n" 
```

### 5.4 让M-backspace象bash那样只回删一个单词

这是zsh跟bash不兼容的另一个地方，M-backspace会回删整个参数，而不是像bash/emacs那样只删除一个单词。

解决方法是在~/.zshrc中加入:

```
autoload -U select-word-style 
select-word-style bash
```

（来自: <http://stackoverflow.com/a/1438523> )

 

## 6. 参考资料

\- [系统管理员工具包: 充分利用 zsh](<http://www.ibm.com/developerworks/cn/aix/library/au-satzsh.html>)
\- [幕启：介绍 Z shell](<http://www.ibm.com/developerworks/cn/linux/shell/z/>)
\- [终极Shell——Zsh — LinuxTOY](<http://linuxtoy.org/archives/zsh.html>)
\- [使用 Zsh 的九个理由 - 博客 - 伯乐在线](<http://blog.jobbole.com/28829/>)





分类: [Unix](https://www.cnblogs.com/bamanzi/category/559032.html)

标签: [shell](https://www.cnblogs.com/bamanzi/tag/shell/), [unix](https://www.cnblogs.com/bamanzi/tag/unix/)