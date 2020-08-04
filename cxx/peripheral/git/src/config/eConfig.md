# Git Config

## main
### domain
> When reading, the values are read from the system, global and repository local configuration files by default, and options --system, --global, --local, --worktree and --file <filename> can be used to tell the command to read from only that location (see FILES).

分为global，local，system

> --global
For writing options: write to global ~/.gitconfig file rather than the repository .git/config, write to $XDG_CONFIG_HOME/git/config file if this file exists and the ~/.gitconfig file doesn’t.
For reading options: read only from global ~/.gitconfig and from $XDG_CONFIG_HOME/git/config rather than from all available files.
See also FILES.

> --system
For writing options: write to system-wide $(prefix)/etc/gitconfig rather than the repository .git/config.
For reading options: read only from system-wide $(prefix)/etc/gitconfig rather than from all available files.
See also FILES.

> --local
For writing options: write to the repository .git/config file. This is the default behavior.
For reading options: read only from the repository .git/config rather than from all available files.
See also FILES.

> --worktree
Similar to --local except that .git/config.worktree is read from or written to if extensions.worktreeConfig is present. If not it’s the same as --local.

> -f config-file
> --file config-file
Use the given config file instead of the one specified by GIT_CONFIG.


## misc
不少开发者可能遇到过这个问题：从git上拉取服务端代码，然后只修改了一处地方，准备提交时，用diff软件查看，却发现整个文件都被修改了。这是git自动转换换行符导致的问题。

原因
不同操作系统使用的换行符是不一样的。Unix/Linux使用的是LF，Mac后期也采用了LF，但Windows一直使用CRLF【回车(CR, ASCII 13, \r) 换行(LF, ASCII 10, \n)】作为换行符。而git入库的代码采用的是LF格式，它考虑到了跨平台协作的场景，提供了“换行符自动转换”的功能：如果在Windows下安装git，在拉取文件时，会自动将LF换行符替换为CRLF；在提交时，又会将CRLF转回LF。但是这个转换是有问题的：有时提交时，CRLF转回LF可能会不工作，尤其是文件中出现中文字符后有换行符时。


解决方案
1.禁用git的自动换行功能：
在本地路径C:\Users\[用户名]\.gitconfig下修改git配置[core]，如果没有就直接添加上去：
``` ini
[core]
autocrlf = false
filemode = false
safecrlf = true
```
git bash命令行也可以修改，最终也是修改.gitconfig配置文件：
分别执行：
``` bash
git config --global core.autocrlf false 
git config --global core.filemode false 
git config --global core.safecrlf true


git config --get core.autocrlf # 显示false
```

git config --global core.autocrlf true --global core.safecrlf false


## misc
在windows平台下git add 的时候经常会出现如下错误

git在windows下，默认是CRLF作为换行符，git add 提交时，检查文本中有LF 换行符（linux系统里面的），则会告警。所以问题的解决很简单，让git忽略该检查即可

`git config --global core.autocrlf warn `

Git提供了一个换行符检查功能（core.safecrlf），可以在提交时检查文件是否混用了不同风格的换行符。这个功能的选项如下：

false - 不做任何检查
warn - 在提交时检查并警告
true - 在提交时检查，如果发现混用则拒绝提交
建议使用最严格的 true 选项。


## Q&A

**Q**: `git clone `执行时出现 `rpc failed`
**A**: 一般是网络不好，可以通过配置提高网络容错。

``` bash
1、查看当前配置命令
git config -l

2、httpBuffer加大
git config --global http.postBuffer 524288000

3、压缩配置
git config --global core.compression -1

4、修改配置文件(可选)
export GIT_TRACE_PACKET=1
export GIT_TRACE=1
export GIT_CURL_VERBOSE=1
```