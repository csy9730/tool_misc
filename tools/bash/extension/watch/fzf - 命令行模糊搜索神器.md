# fzf - 命令行模糊搜索神器

[![img](https://upload.jianshu.io/users/upload_avatars/2222997/500ed1fcf8e2?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)](https://www.jianshu.com/u/2baf4dc0fbe6)

[Whyn](https://www.jianshu.com/u/2baf4dc0fbe6)关注

2019.07.26 23:43:49字数 1,690阅读 10,724

## 前言

[fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 是一款功能强大的命令行模糊搜索工具。

[fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 可以对文件，命令行历史记录，进程，主机名，标签，git 提交等进行模糊搜索。

[fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 的另一个常见的用处就是以插件形式集成到 [Vim](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.vim.org%2F) 上：[fzf.vim](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf.vim)

## 安装

这里简单介绍下源码安装：



```git
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf 
~/.fzf/install
```

更多安装方法，请查看：[Installation](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf%23installation)

## 使用方法

- **基础使用**：[fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 默认会启用用户交互查找，从标准输入流（STDIN）读取，并将匹配内容输出到标准输出流（STDOUT）中：



```rust
find * -type f | fzf
```

[fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 如果没有接受标准输入流，那么就会直接进行文件查找（不包含隐藏文件），可以通过设置`FZF_DEFAULT_COMMAND`修改该默认动作）：



```bash
fzf # 直接输入 fzf，打开文件搜索功能
```

**注**：在 [fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 的用户交互界面中，用户的操作有如下动作可选：

1. 使用`CTRL-J`/`CTRL-K`（或者`CTRL-N`/`CTRL-P`）进行上下选择
2. 使用`Enter`选中条目，`CTRL-C`/`CTRTRL-G`/`ESC`进行退出操作
3. 在多选择模式（`-m`），使用`TAB`和`Shift-TAB`标记多个条目
4. Emacs 风格按键绑定
5. 支持鼠标操作

- **搜索语法**：[fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 默认不支持正则搜索，为了操作更加简单直接，通过空格分隔单词，查找匹配所有字符串（无序）。[fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 还提供了一些增强功能的搜索语法，如下表所示：

| 标记      | 匹配类型         | 描述                           |
| --------- | ---------------- | ------------------------------ |
| `sbtrkt`  | 模糊匹配         | 内容匹配`sbtrkt`（字符匹配）   |
| `'wild`   | 精确匹配(单引号) | 内容包含单词`wild`（单词匹配） |
| `^music`  | 前缀精确匹配     | 以`music`开头                  |
| `.mp3$`   | 后缀精确匹配     | 以`.mp3`结尾                   |
| `!fire`   | 反转匹配         | 内容不包含`fire`               |
| `!^music` | 前缀反转匹配     | 不以`music`开头                |
| `!.mp3$`  | 后缀反转匹配     | 不以`.mp3`结尾                 |

**注**：如果不想使用模糊匹配或者不想"引用"每个文字，可以使用`-e/--exact`选项。注意如果使用`-e/--exact`，那么`'`就变成了解引用，即:`'abc`表示匹配`a`,`b`和`c`（`a,b,c`有序），而不仅仅是匹配`abc`。

- **或操作**：[fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 以空格分隔，默认使用的是 *与操作（无序）*，如果想使用 *或操作*，那么可以使用`|`：



```shell
^core go$ | rb$ | py$ # 表示以`core`开头，且以`go`或`rb`或`py`结尾
```

**注**：`|`前后必须带空格。

- **模糊补全**：在 bash 或 zsh 终端上，可以通过输入`**`来触发 [fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 对文件/目录的模糊补全（查找），如下例子所示：



```shell
# Files under current directory
# - You can select multiple items with TAB key
vim **<TAB>

# Files under parent directory
vim ../**<TAB>

# Files under parent directory that match `fzf`
vim ../fzf**<TAB>

# Files under your home directory
vim ~/**<TAB>


# Directories under current directory (single-selection)
cd **<TAB>

# Directories under ~/github that match `fzf`
cd ~/github/fzf**<TAB>
```

- **命令支持**：在 bash 上，[fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 的模糊补全功能只对一些预定义的命令集有效（具体命令集：`complete | grep _fzf`），但是我们也可以为其他命令设置 [fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 模糊补全功能，如下所示：



```shell
# 为 rg 增加模糊补全，rg -F "def main(" **<TAB>
complete -F _fzf_path_completion -o default -o bashdefault rg
# 为 tree 增加模糊补全，tree  **<TAB>
complete -F _fzf_dir_completion -o default -o bashdefault tree
```

## 按键绑定

[fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 的安装脚本会为 bash，zsh 和 fish 终端设置以下按键绑定：

| 按键     | 描述                           |
| -------- | ------------------------------ |
| `CTRL-T` | 命令行打印选中内容             |
| `CTRL-R` | 命令行历史记录搜索，并打印输出 |
| `ALT-C`  | 模糊搜索目录，并进入（`cd`）   |

## 其他

- **环境变量**：如下表所示：

| name                  | description             | example                                                    |
| --------------------- | ----------------------- | ---------------------------------------------------------- |
| `FZF_DEFAULT_COMMAND` | 输入为 tty 时的默认命令 | `export FZF_DEFAULT_COMMAND='fd --type f'`                 |
| `FZF_DEFAULT_OPTS`    | 设置默认选项            | `export FZF_DEFAULT_OPTS="--layout=reverse --inline-info"` |
| `FZF_CTRL_T_COMMAND`  | 按键映射``行为设置      |                                                            |
| `FZF_CTRL_T_OPTS`     | 按键映射``选项设置      |                                                            |
| `FZF_CTRL_R_OPTS`     | 按键映射``选项设置      |                                                            |
| `FZF_ALT_C_COMMAND`   | 按键映射``行为设置      |                                                            |
| `FZF_ALT_C_OPTS`      | 按键映射``选项设置      |                                                            |

- **界面**：[fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 默认会以全屏方式显示交互界面，可以使用`--height`选项设置交互界面高度：



```shell
vim $(fzf --height 40%)
```

可以通过设置`$FZF_DEFAULT_OPTS`变量更改 [fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 默认行为：



```shell
# 设置 fzf 默认交互界面大小
export FZF_DEFAULT_OPTS='--height 40%' 
```

- **进程 ID 模糊补全**：在使用`kill`命令时，[fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 会自动触发其自动补全功能：



```shell
# Can select multiple processes with <TAB> or <Shift-TAB> keys
kill -9 <TAB>
```

- **主机名补全**：如下例子所示：



```shell
ssh **<TAB>
telnet **<TAB>
```

- **预览窗口**：可以通过提供`--preview`选项打开预览窗口，并设置响应命令输出到预览窗口上：



```shell
# {} is replaced to the single-quoted string of the focused line
fzf --preview 'cat {}' # 预览文件内容
fzf --preview 'rg -F "def main(" -C 3 {}' # 预览 Python 文件 main 函数前后3行代码
```

## 高级配置

- **更改查找引擎**：默认情况下，[fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 使用的查找引擎是系统自带的`find`命令，这里我们可以对其进行更改，换成更高效的查找引擎：



```shell
# 使用 rg 进行搜索
export FZF_DEFAULT_COMMAND='rg --files --hidden'
```

- **执行外部程序**：我们可以通过设置按键映射在 [fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 交互界面直接开启外部进程（`execute`，`execute-silent`）运行我们选中的文件：



```shell
# 在交互界面选中文件后，按下 F1，直接使用 vim 打开
fzf --bind 'f1:execute(vim {})' 
```

- **简化命令**：可以通过定义 shell 脚本简化 [fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 命令执行。比如，下面示例定义了一个函数，结合`ag`实现传参进行模糊搜索，并用 [vim](https://links.jianshu.com/go?to=https%3A%2F%2Fwww.vim.org%2F) 打开：



```shell
# fuzzy grep open via ag
vg() {
  local file

  file="$(ag --nobreak --noheading $@ | fzf -0 -1 | awk -F: '{print $1}')"

  if [[ -n $file ]]
  then
     vim $file
  fi
}
```

- **自定义全局快捷键触发**：像 [fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 其实已经有为我们提供了一些按键映射，比如``，可以打印出选中文件。现在我们也仿照写一个该功能脚本，全局快捷键设为``：

1）首先先写目录搜索（`fzf`）并打印输出功能脚本：



```bash
# .bashrc
outputDir() {
    local dir
    dir=$(find ${1:-.} -type d 2> /dev/null | fzf +m)
    echo $dir
}
```

2）然后进行全局按键映射：



```bash
# .bashrc
bind '"\er": redraw-current-line'
bind '"\C-g\C-o": "$(outputDir)\e\C-e\er"'
```

**注**：
1）`\e\C-e`：`shell-expand-line`默认按键绑定，这是最容易的方式进行按键绑定，缺点就是它对于别名（`alias`）也会同样进行展开。
2）`redraw-current-line`：在非 [tmux](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Ftmux%2Ftmux) 终端上，该选项必须存在，否则无法清除提示。
3）先`source .bashrc`，然后按快捷键：``，运行结果如下：

![img](https://upload-images.jianshu.io/upload_images/2222997-b4bcee16eee161e2.gif?imageMogr2/auto-orient/strip|imageView2/2/w/659/format/webp)

- **为预览窗口增加语法高亮**：预览窗口支持 ANSI 颜色，因此我们可以为文件内容增加语法高亮。我们借助 [bat](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fsharkdp%2Fbat) 这个库来为我们的文本显示语法高亮功能：
  1）首先，安装 [bat](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fsharkdp%2Fbat) 库。具体步骤请查看文档。
  2）终端输入以下内容：



```shell
fzf --preview '[[ $(file --mime {}) =~ binary ]] &&
                 echo {} is a binary file ||
                 (bat --style=numbers --color=always {} ||
                  highlight -O ansi -l {} ||
                  coderay {} ||
                  rougify {} ||
                  cat {}) 2> /dev/null | head -500'
```

结果如下：

![img](https://upload-images.jianshu.io/upload_images/2222997-a6c573a1e075abee.gif?imageMogr2/auto-orient/strip|imageView2/2/w/659/format/webp)

- **自定义模糊补全**：[fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 目前有提供相关 API 供我们自定义模糊补全功能，具体步骤如下：

1）首先自定义一个函数，使用 [fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf) 提供的 API：`_fzf_complete`提供补全功能：



```bash
# Custom fuzzy completion for "doge" command
#   e.g. doge **<TAB>
_fzf_complete_doge() {
  _fzf_complete "--multi --reverse" "$@" < <(
    echo very
    echo wow
    echo such
    echo doge
  )
}
```

2）在 bash 中，使用`complete`指令链接我们的自定义函数：



```csharp
[ -n "$BASH" ] && complete -F _fzf_complete_doge -o default -o bashdefault doge
```

3）终端输入：`doge **`，结果如下所示：

![img](https://upload-images.jianshu.io/upload_images/2222997-a057bb77a2a84cc6.gif?imageMogr2/auto-orient/strip|imageView2/2/w/661/format/webp)

更多高级配置，请查看：[wiki](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf%2Fwiki)

## 总结

虽然好像写了挺多的，其实总结起来主要就 3 个操作：

- **`fzf`**：直接模糊搜索
- **`\**`**：触发模糊补全
- **按键映射**：``，``，``

## 参考

- [fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fgithub.com%2Fjunegunn%2Ffzf)
- [Key bindings for git with fzf](https://links.jianshu.com/go?to=https%3A%2F%2Fjunegunn.kr%2F2016%2F07%2Ffzf-git%2F)