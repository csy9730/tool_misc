# windows terminal



这里需要了解一下终端terminal和 shell 的区别：

在命令行中，shell 提供了访问操作系统内核功能的途径，比如说我们所熟悉的 bash、zsh，都是不同的 shell；而终端则为 shell 提供视觉界面（窗口），比如我们所熟悉的 iTerm2、Linux 桌面上的终端工具等。甚至于我们在 VSCode 中所使用的命令行，也是某种意义上的终端。

我们在 Windows 下所使用的 CMD、Powershell 既然是一个终端，也是一个 Shell，还是同名的脚本系统。

## install

可以通过miscroftApps（微软商店）安装。
安装路径为：`C:\Program Files\WindowsApps\Microsoft.WindowsTerminal_0.8.10261.0_x64__8wekyb3d8bbwe\WindowsTerminal.exe`


## misc

linux使用以下的终端工具
fsh/zsh +tmux+ ssh

windows下可以使用的终端软件：
cmd：不支持窗口最大，不支持。。。
powershell：不能完全支持tmux
mintty： 支持tmux，支持窗口最大化，不支持python的标准输出，不能完全支持wsl，
windows terminal：系统版本支持困难，
wsl：复制黏贴需要鼠标右键 vim无clipboard时复制黏贴困难
cmder： 使用ConEmu 核心	
xshell： 收费，
vscode： 输入输出缓冲区太小，支持wsl的vim无clipboard时复制黏贴困难


常用的终端任务：
文件复制/发送， 黏贴/接收， 压缩&解压
文件下载/git clone/curl，文件上传/git push/
file diff ，folder diff，
打开github项目 ，一边 read/write，一边debug/run/compile
