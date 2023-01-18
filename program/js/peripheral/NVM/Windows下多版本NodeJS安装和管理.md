# Windows下多版本NodeJS安装和管理



本文介绍 Windows 操作系统中安装和管理多版本 NodeJS 的方法。

------

### 目录

- NVM 简介
- 版本说明
- 安装步骤
- 备注

------

### NVM 简介

[NVM](https://github.com/nvm-sh/nvm) 全称 Node Version Manager，是一个管理 NodeJS 版本的工具。
NVM 默认只支持 Linux 和 OS X，不支持 Windows，针对 Windows 操作系统有 2 个替代方案：

- [nvm-windows](https://github.com/coreybutler/nvm-windows)
- [nodist](https://github.com/marcelklehr/nodist)

本文介绍使用 nvm-windows 安装和管理多版本 NodeJS 的方法。

------

### 版本说明

- nvm-windows `1.1.7`
- NodeJS `10.16.2` & `12.8.0`

------

### 安装步骤

1. 下载 [nvm-windows](https://github.com/coreybutler/nvm-windows/releases)

2. 解压安装，安装前首先要卸载已安装的任何版本的 NodeJS，安装过程需要设置 NVM 的安装路径和 NodeJS 的快捷方式路径，可以选择任意路径。

3. NVM 安装成功后会自动生成环境变量

    

`NVM_HOME ` 和 `NVM_SYMLINK`

- `NVM_HOME` ：NVM 安装路径
- `NVM_SYMLINK` ： NodeJS 快捷方式路径

1. 使用 `cmd` 命令打开命令提示符窗口，输入 `nvm -v` 校验是否安装成功。

```
C:\>nvm -v

Running version 1.1.7.

Usage:

  nvm arch                     : Show if node is running in 32 or 64 bit mode.
  nvm install <version> [arch] : The version can be a node.js version or "latest" for the latest stable version.
                                 Optionally specify whether to install the 32 or 64 bit version (defaults to system arch).
                                 Set [arch] to "all" to install 32 AND 64 bit versions.
                                 Add --insecure to the end of this command to bypass SSL validation of the remote download server.
  nvm list [available]         : List the node.js installations. Type "available" at the end to see what can be installed. Aliased as ls.
  nvm on                       : Enable node.js version management.
  nvm off                      : Disable node.js version management.
  nvm proxy [url]              : Set a proxy to use for downloads. Leave [url] blank to see the current proxy.
                                 Set [url] to "none" to remove the proxy.
  nvm node_mirror [url]        : Set the node mirror. Defaults to https://nodejs.org/dist/. Leave [url] blank to use default url.
  nvm npm_mirror [url]         : Set the npm mirror. Defaults to https://github.com/npm/cli/archive/. Leave [url] blank to default url.
  nvm uninstall <version>      : The version must be a specific version.
  nvm use [version] [arch]     : Switch to use the specified version. Optionally specify 32/64bit architecture.
                                 nvm use <arch> will continue using the selected version, but switch to 32/64 bit mode.
  nvm root [path]              : Set the directory where nvm should store different versions of node.js.
                                 If <path> is not set, the current root will be displayed.
  nvm version                  : Displays the current running version of nvm for Windows. Aliased as v.
```

1. 进入 NVM 安装根目录，查看 `settings.txt` 文件内容

```
root: C:\Dev\nvm
path: C:\Dev\nodejs
```

- `root`：NVM 安装路径
- `path`：NodeJS 快捷方式路径

1. 在 `settings.txt` 文件中添加以下内容

```
arch: 64
proxy:
node_mirror: http://npm.taobao.org/mirrors/node/
npm_mirror: https://npm.taobao.org/mirrors/npm/
```

- `arch`：Windows 操作系统位数
- `proxy`：代理，[淘宝 NodeJS 镜像和 NPM 镜像](https://npm.taobao.org/)

1. 使用 `nvm install 版本号` 命令安装指定版本的 NodeJS

```css
C:\>nvm install v10.16.2
Downloading node.js version 10.16.2 (64-bit)...
Complete
Creating C:\Dev\nvm\temp

Downloading npm version 6.9.0... Complete
Installing npm v6.9.0...

Installation complete. If you want to use this version, type

nvm use 10.16.2
```

1. 安装成功后在 NVM 安装目录下出现一个 `v10.16.2` 文件夹，使用 `nvm list` 命令查看已安装 NodeJS 列表。

```css
C:\>nvm list

    10.16.2
```

1. 再次使用 `nvm install 版本号` 命令安装另一版本的 NodeJS

```css
C:\>nvm install v12.8.0
Downloading node.js version 12.8.0 (64-bit)...
Complete
Creating C:\Dev\nvm\temp

Downloading npm version 6.10.2... Complete
Installing npm v6.10.2...

Installation complete. If you want to use this version, type

nvm use 12.8.0
```

1. 安装成功后在 NVM 安装目录下又多了一个 `v12.8.0` 目录，使用 `nvm list` 命令查看已安装 NodeJS 列表，带 `*` 版本代表当前使用的 NodeJS 版本。

```css
C:\>nvm list

    12.8.0
  * 10.16.2 (Currently using 64-bit executable)
```

1. 使用 `nvm use 版本号` 切换需要使用的 NodeJS 版本，切换成功后可以使用 `node -v` 和 `npm -v` 命令查看是否切换成功。

```css
C:\>nvm use v12.8.0
Now using node v12.8.0 (64-bit)

C:\>node -v
v12.8.0

C:\>npm -v
6.10.2

C:\>nvm use v10.16.2
Now using node v10.16.2 (64-bit)

C:\>node -v
v10.16.2

C:\>npm -v
6.9.0
```

------

### 备注

- NVM 安装成功后可以通过 `nvm -v` 命令查看所有可用的命令。

```dart
C:\>nvm -v

Running version 1.1.7.

Usage:

  nvm arch                     : Show if node is running in 32 or 64 bit mode.
  nvm install <version> [arch] : The version can be a node.js version or "latest" for the latest stable version.
                                 Optionally specify whether to install the 32 or 64 bit version (defaults to system arch).
                                 Set [arch] to "all" to install 32 AND 64 bit versions.
                                 Add --insecure to the end of this command to bypass SSL validation of the remote download server.
  nvm list [available]         : List the node.js installations. Type "available" at the end to see what can be installed. Aliased as ls.
  nvm on                       : Enable node.js version management.
  nvm off                      : Disable node.js version management.
  nvm proxy [url]              : Set a proxy to use for downloads. Leave [url] blank to see the current proxy.
                                 Set [url] to "none" to remove the proxy.
  nvm node_mirror [url]        : Set the node mirror. Defaults to https://nodejs.org/dist/. Leave [url] blank to use default url.
  nvm npm_mirror [url]         : Set the npm mirror. Defaults to https://github.com/npm/cli/archive/. Leave [url] blank to default url.
  nvm uninstall <version>      : The version must be a specific version.
  nvm use [version] [arch]     : Switch to use the specified version. Optionally specify 32/64bit architecture.
                                 nvm use <arch> will continue using the selected version, but switch to 32/64 bit mode.
  nvm root [path]              : Set the directory where nvm should store different versions of node.js.
                                 If <path> is not set, the current root will be displayed.
  nvm version                  : Displays the current running version of nvm for Windows. Aliased as v.
```

- 实际上不使用任何 NodeJS 版本管理工具也可以安装多个版本 NodeJS，方法：安装完一个版本后需要手动重命名安装目录，保证与环境变量路径不一致，然后再安装另一个版本，第二个版本安装好后再把第一个版本的安装目录命名恢复成安装时使用的名字，尽量保证低版本优先安装。这种方法的缺点在于切换 NodeJS 版本需要手动修改环境变量，使用 IDE 稍微好些因为可以手动配置 NodeJS 安装目录，不过在 IDE 中使用命令行工具仍然存在这样的问题。



## misc

windows下安装node版本管理工具及nvm use切换不成功问题解决

window10系统上安装nodejs版本管理工具：

1、下载nvm：https://github.com/coreybutler/nvm-windows/releases

        我下载的是 1.1.6版本中的 nvm-setup.zip

2、解压缩，运行nvm-setup.exe，选择nvm安装路径，下一步选择node安装路径（第一次安装我选择的默认安装路径），依次点击完成

3、cmd运行`nvm -v` 查看是否安装成功，然后安装node版本，`nvm install v7.6.0`，会依次安装node和相应的npm版本，最后运行 `nvm use 7.6.0`，显示切换成功，但是 运行 `node -v`，却依旧没有切换成功

解决方案：

在安装nvm之前我系统上已经安装了一版node，需要卸载node，发现还是不成功，最后在https://github.com/coreybutler/nvm-windows/issues/321 找到了答案，解决方案如下：

重命名node安装目录：

Renamed "C:\Program Files\nodejs" to "C:\Program Files\nodejsx",

Then from an elevated cmd called "nvm use 8.9.1" (any version you got should work..) and it started to work.

Problem seems to be if nodejs directory exists, nvm can not change it to a symlink and 'fails silently' would be nice with a fail and an error message stating the problem.