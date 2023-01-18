# nvm

nvm node version manager（node版本管理工具）

通过将多个node 版本安装在指定路径，然后通过 nvm 命令切换时，就会切换我们环境变量中 node 命令指定的实际执行的软件路径。

使用场景：比如我们手上同时在做好几个项目，这些项目的需求都不太一样，导致了这些个项目需要依赖的nodejs版本也不同，这种情况下，我们就可以通过nvm来切换nodejs的版本，而不需要频繁地下载/卸载不同版本的nodejs来满足当前项目的要求

nvm是一个node的版本管理工具，可以简单操作node版本的切换、安装、查看。。。等等，与npm不同的是，npm是依赖包的管理工具。


[https://github.com/coreybutler/nvm-windows](https://github.com/coreybutler/nvm-windows)
## install

[https://github.com/coreybutler/nvm-windows/releases](https://github.com/coreybutler/nvm-windows/releases)
## usage
### version

#### available

```
C:\Users\foo>nvm list available

|   CURRENT    |     LTS      |  OLD STABLE  | OLD UNSTABLE |
|--------------|--------------|--------------|--------------|
|    19.3.0    |   18.12.1    |   0.12.18    |   0.11.16    |
|    19.2.0    |   18.12.0    |   0.12.17    |   0.11.15    |
|    19.1.0    |   16.19.0    |   0.12.16    |   0.11.14    |
|    19.0.1    |   16.18.1    |   0.12.15    |   0.11.13    |
|    19.0.0    |   16.18.0    |   0.12.14    |   0.11.12    |
|   18.11.0    |   16.17.1    |   0.12.13    |   0.11.11    |
|   18.10.0    |   16.17.0    |   0.12.12    |   0.11.10    |
|    18.9.1    |   16.16.0    |   0.12.11    |    0.11.9    |
|    18.9.0    |   16.15.1    |   0.12.10    |    0.11.8    |
|    18.8.0    |   16.15.0    |    0.12.9    |    0.11.7    |
|    18.7.0    |   16.14.2    |    0.12.8    |    0.11.6    |
|    18.6.0    |   16.14.1    |    0.12.7    |    0.11.5    |
|    18.5.0    |   16.14.0    |    0.12.6    |    0.11.4    |
|    18.4.0    |   16.13.2    |    0.12.5    |    0.11.3    |
|    18.3.0    |   16.13.1    |    0.12.4    |    0.11.2    |
|    18.2.0    |   16.13.0    |    0.12.3    |    0.11.1    |
|    18.1.0    |   14.21.2    |    0.12.2    |    0.11.0    |
|    18.0.0    |   14.21.1    |    0.12.1    |    0.9.12    |
|    17.9.1    |   14.21.0    |    0.12.0    |    0.9.11    |
|    17.9.0    |   14.20.1    |   0.10.48    |    0.9.10    |

This is a partial list. For a complete list, visit https://nodejs.org/en/download/releases

```

```
C:\Users\foo>nvm root

Current Root: c:\ProgramData\nvm
```

#### 安装指定版本nodejs
安装指定版本nodejs
```
nvm install 命令
```
#### 显示已安装的版本
``` bash
nvm list # 显示已安装的版本（同 nvm list installed）
nvm list installed # 显示已安装的版本
nvm list available # 显示所有可以下载的版本
```

#### 使用指定版本node
nvm use 命令 - 使用指定版本node
``` bash
nvm use 14.5.0 # 使用14.5.0版本node
```
#### current

```
nvm current
```
#### 卸载指定版本
nvm uninstall 卸载指定版本 node
``` bash
nvm uninstall 14.5.0 # 卸载14.5.0版本node
```

#### settings.txt

```
root: h:\ProgramData\nvm
path: C:\Program Files\nodejs
```

## help
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

## misc

### faq

使用nvm , 先卸载之前的node.js