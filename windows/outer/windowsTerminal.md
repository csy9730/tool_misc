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


### other Terminal
windows下可以使用的终端软件：
cmd：不支持窗口最大，啥也不支持。。。
powershell：不能完全支持tmux
mintty： 支持tmux，支持窗口最大化，不支持python的标准输出，不能完全支持wsl，背景颜色丰富
windows terminal：系统版本支持困难，
wsl：复制黏贴需要鼠标右键， wsl的跨vim复制黏贴困难
cmder： 使用ConEmu 核心	，支持migw的bash，不支持mingw的bash的tmux，支持wsl，支持wsl的tmux

vscode： 输入输出缓冲区太小，支持wsl的跨vim复制黏贴
vscode 插件 Remote-WSL 可以在wsl安装vscode远程服务。
通过F1 输入 Remote-WSL 可以 远程vscode窗口，左下角有WSL标志。
体现为，所有路径是以 wsl系统作为基准，
与vscode直接使用wsl作为终端有何区别？
Remote-SSH,Remote-WSL,Remote-Containers

MobaXterm，一个个人免费的终端软件，功能完善，支持ssh/rdp/sftp多种协议
putty，早期的开源的ssh终端，也支持串口。
xshell： 个人免费，商用收费的终端，支持ssh/sftp连接。

xming可以实现windows下通过命令行启动linux程序，在windows下显示窗口


不要用盗版汉化版的ssh软件，不要用盗版汉化版的ssh软件，不要用盗版汉化版的ssh软件！为什么呢？因为可能会中标，有些别有用心的人会修改软件在其中植入木马，窃取你的用户名密码，证书。这三种软件中Xshell和Putty中文版就被人这么干过，相关信息可自行搜索下。

Windows 的 cmd.exe（所使用的终端）很难用、对 Unicode 支持不佳、复制粘贴十分不便、支持的色彩和功能少、不能随意改变大小。

Linux 的终端有很多很多，比如文本界面的虚拟终端、图形界面下的各种终端模拟器，还有运行于终端里的终端如 tmux、screen、fbterm、zhcon 等。它们通常都比较现代，菜单、键盘快捷键什么的一应俱全，字体渲染也比较好（当然不算文本界面和太古老的那些），有些还有很强的定制性（比如xterm、urxvt

### 多面版任务

常用的终端任务：
目录树操作：文件复制/发送， 黏贴/接收， 压缩&解压
目录树操作：file diff ，folder diff，
网络文件夹操作：文件下载/git clone/curl，文件上传/git push/
文档操作，
程序debug，

* 打开github项目 ，一边 read/write，一边debug/run/compile







