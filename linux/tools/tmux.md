# tmux

tmux 是常用的终端复用工具，包括会话session，窗口window，面板pane，会话和窗口的区别是会话可以后台执行，窗口是前端显示。
tmux的两大作用：
1. 可以分离会话和窗口，一般用于ssh会话断开重连之后还能记录窗口，通过ssh连接主机执行wget等任务，都是ssh的子任务，ssh断开之后就会销毁，通过在tmux会话下执行wget，可以在ssh断开后也能继续执行。
2. 可以把窗口分离出多个面板
tmux比screen最大的优势就是tmux split后，重新连接session的时候split的pane不变，还有tmux可以以脚本的形式启动并运行一系列复杂的命令

## session
``` bash
tmux # 创建session
tmux new -s $session_name # 创建并指定session名字
tmux new-session -s 会话名  

tmux ls # 查看现有的会话
tmux a # 进入最近的会话
tmux a -t  会话名 # 进入指定会话
tumx kill-session -t 会话名 # 干掉指定会话
tumx kill-server # 干掉所有会话
tumx detach
tumx detach-client # 临时退出session, [Ctrl+b d]
tmux rename # 重命名session
tmux switch -t session-name # 切换会话

```
窗口关闭之后，会话会在后台保留，关机之后会话才会丢失。可以通过插件记录会话，使重启之后也能恢复之前会话

## window


``` bash
tmux new-window # 创建window [Ctrl+b +c]
tumx kill-window # 删除window [Ctrl+b &]
tumx killw
tmux next # 下一个window [Ctrl+b n]
tmux prev # 上一个window [Ctrl+b p]
tmux renamew # 重命名window [Ctrl+b ,]
# 在多个window里搜索关键字 [Ctrl+b f]
# 在相邻的两个window里切换 [Ctrl+b l]

```

## pane
pane在window里，可以有N个pane，并且pane可以在不同的window里移动、合并、拆分
``` bash

# 创建pane
tmux split -h # 横切split pane horizontal [Ctrl+b "]
tmux split # 竖切split pane vertical [Ctrl+b %]
tmux killp # 删除pane [Ctrl+b x]
# 按顺序在pane之间移动 [Ctrl+b o]
tmux display-panes # 显示pane编号 [Ctrl+b q]
tmux lastp # 查看上次 pane
# 上下左右选择pane [Ctrl+b 上/下/左/右]

# 按Ctrl+B，再按[，就可以用鼠标滑轮/或者上下左右方向键/PageUp,PageDown滚动，按q退出。

# 调整pane的大小
# Ctrl+b :resize-pane -U # 向上
# Ctrl+b :resize-pane -D # 向下
# Ctrl+b :resize-pane -L # 向左
# Ctrl+b :resize-pane -R # 向右
# 在上下左右的调整里，最后的参数可以加数字 用以控制移动的大小，例如：
# Ctrl+b :resize-pane -D 50
# 最大化/恢复 [Ctrl+b z]

# 在同一个window里左右移动pane
# （往左边，往上面） [Ctrl+b { ]
# （往右边，往下面）[Ctrl+b }] 
# 更换pane排版 [Ctrl+b Space]

# 移动pane至window [Ctrl+b !]
tmux join-pane -t $window_name # 移动pane合并至某个window
tmux joinp -t 0 
# 按顺序移动pane位置 [Ctrl+b Ctrl+o]

```
## buffer
``` bash

# 粘贴最后一个缓冲区内容 [Ctrl+b ]]
# 选择性粘贴缓冲区 [Ctrl+b = ]
# 列出缓冲区目标 [Ctrl+b :list-buffer]
# 查看缓冲区内容 [Ctrl+b :show-buffer]
```
tmux 复制黏贴分为 鼠标模式和按键模式。通过ctrl+b [ 激活复制模式，

## misc

其他：
``` bash

# 命令行模式 [Ctrl+b :]
# 复制模式 [Ctrl+b []
# 空格标记复制开始，回车结束复制。

# vi模式 [Ctrl+b :set mode-keys vi]
# 显示时间 [Ctrl+b t]
# 快捷键帮助 [Ctrl+b ?] 或 [Ctrl+b :list-keys]
tmux list-commands # tmux内置命令帮助 [Ctrl+b :list-commands]
```


**Q**: 如何处理pane的内容滚动
**A**: 

**Q**: 如何处理tmux嵌套，本地使用tmux，通过远程连接服务器，服务器开启了tmux，如何处理
**A**:  ctrl 在按两次b，可以激活远程的tmux。