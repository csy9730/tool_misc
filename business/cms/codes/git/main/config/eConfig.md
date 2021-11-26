# Git Config

git工具的配置，对应.gitconfig文件。

## main
### domain

配置文件分成几种级别：global，local，system，file，worktree。

- system是系统级配置，对当前设备都适用？ 对应 /etc/gitconfig
- global 是用户级配置， 对应 ~/.gitconfig
- local是局部仓库级，只在当前仓库有效。这是默认优先级。对应.git/config
- worktree和local相似, 属于仓库的分支配置，对应.git/config.worktree
- file是命令行临时指定的配置文件，提供单次的高优先级配置能力。

按照使用范围划分：system > global > local > worktree > file
优先级： system< global <  local< worktree <  file


> When reading, the values are read from the system, global and repository local configuration files by default, and options --system, --global, --local, --worktree and --file <filename> can be used to tell the command to read from only that location (see FILES).



> --global
For writing options: write to global ~/.gitconfig file rather than the repository .git/config, write to $XDG_CONFIG_HOME/git/config file if this file exists and the ~/.gitconfig file doesn’t.
For reading options: read only from global ~/.gitconfig and from $XDG_CONFIG_HOME/git/config rather than from all available files.
See also FILES.

对应 ~/.gitconfig


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


### manager

#### ~/.gitconfig

``` ini
[color]
	ui = true
[user]
	email = foo@abc.com
	name = foo
[filter "lfs"]
	clean = git-lfs clean -- %f
	smudge = git-lfs smudge -- %f
	process = git-lfs filter-process
	required = true
[diff]
	tool = bc2
[difftool]
	prompt = true
[difftool "bc2"]
	path = D:\\GreenSoftware\\runpath\\BC2.bat
[difftool "bc3"]
	path = D:\\GreenSoftware\\runpath\\BC2.bat
[core]
	autocrlf = true
	filemode = true
	safecrlf = true
	quotepath = false
	commitGraph = true
	longpaths = true
[receive]
	advertisePushOptions = true
[gc]
	writeCommitGraph = true
[http]
	proxy = socks5://127.0.0.1:1080
[https]
	proxy = socks5://127.0.0.1:1080
```

#### list

```
D:\projects>git config -l
core.symlinks=false
core.autocrlf=true
core.fscache=true
color.diff=auto
color.status=auto
color.branch=auto
color.interactive=true
help.format=html
rebase.autosquash=true
http.sslbackend=openssl
http.sslcainfo=C:/Program Files/Git/mingw64/ssl/certs/ca-bundle.crt
credential.helper=manager
color.ui=true
user.email=abc@qq.com
user.name=abc
filter.lfs.clean=git-lfs clean -- %f
filter.lfs.smudge=git-lfs smudge -- %f
filter.lfs.process=git-lfs filter-process
filter.lfs.required=true
diff.tool=bc2
difftool.prompt=true
difftool.bc2.path=D:\GreenSoftware\runpath\BC2.bat
difftool.bc3.path=D:\GreenSoftware\runpath\BC2.bat
core.autocrlf=true
core.filemode=true
core.safecrlf=true
core.repositoryformatversion=0
core.filemode=false
core.bare=false
core.logallrefupdates=true
core.symlinks=false
core.ignorecase=true
remote.origin.url=https://github.com/abc/repo.git
remote.origin.fetch=+refs/heads/*:refs/remotes/origin/*
branch.master.remote=origin
branch.master.merge=refs/heads/master
```

#### get
#### add

## help
```
D:\projects>git config -h
usage: git config [<options>]

Config file location
    --global              use global config file
    --system              use system config file
    --local               use repository config file
    --worktree            use per-worktree config file
    -f, --file <file>     use given config file
    --blob <blob-id>      read config from given blob object

Action
    --get                 get value: name [value-regex]
    --get-all             get all values: key [value-regex]
    --get-regexp          get values for regexp: name-regex [value-regex]
    --get-urlmatch        get value specific for the URL: section[.var] URL
    --replace-all         replace all matching variables: name value [value_regex]
    --add                 add a new variable: name value
    --unset               remove a variable: name [value-regex]
    --unset-all           remove all matches: name [value-regex]
    --rename-section      rename section: old-name new-name
    --remove-section      remove a section: name
    -l, --list            list all
    -e, --edit            open an editor
    --get-color           find the color configured: slot [default]
    --get-colorbool       find the color setting: slot [stdout-is-tty]

Type
    -t, --type <>         value is given this type
    --bool                value is "true" or "false"
    --int                 value is decimal number
    --bool-or-int         value is --bool or --int
    --path                value is a path (file or directory name)
    --expiry-date         value is an expiry date

Other
    -z, --null            terminate values with NUL byte
    --name-only           show variable names only
    --includes            respect include directives on lookup
    --show-origin         show origin of config (file, standard input, blob, command line)
    --default <value>     with --get, use default value when missing entry
```

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


### git commit如何修改默认编辑器为vim
答:修改~/.gitconfig(修改这个文件将全局有效)或项目目录中的.git/config(修改此文件只是使当前项目默认使用vim)中增加以下内容：
```
[core]
    editor=vim
```

或者执行以下命令:

`git config --global core.editor "vim"`