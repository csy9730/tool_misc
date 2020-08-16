# deb


## dpkg


 dpkg - package manager for Debian  （debian系统的包管理工具）。

dpkg is a tool to install, build, remove and manage Debian packages，dpkg是Debian的一个底层包管理工具，主要用于对已下载到本地和已安装的软件包进行管理。

dpkg这个机制最早由Debian Linux社区所开发出来的，通过dpkg的机制，Debian提供的软件就能够简单的安装起来，同时能提供安装后的软件信息，实在非常不错。只要派生于Debian的其它Linux distributions大多使用dpkg这个机制来管理，包括B2D，Ubuntu等。

```

dpkg -l

```

## apt

### apt相关文件

var/lib/dpkg/available    文件的内容是软件包的描述信息, 该软件包括当前系统所使用的Debian 安装源中的所有软件包,其中包括当前系统中已安装的和未安装的软件包.

/etc/apt/sources.list  记录软件源的地址（当你执行 sudo apt-get install xxx 时，Ubuntu 就去这些站点下载软件包到本地并执行安装）

/var/cache/apt/archives  已经下载到的软件包都放在这里（用 apt-get install 安装软件时，软件包的临时存放路径）

/var/lib/apt/lists    使用apt-get update命令会从/etc/apt/sources.list中下载软件列表，并保存到该目录

### misc
1. 找到依赖的包用`apt-cache depends packname`来获取。
2. 用`apt-get install dependpackname –reinstall -d`来下载所依赖的包。 -d是表示只下载。
3. 下载包`apt-get install packname –reinstall -d` 
4. 批量安装。用shell命令组合来一键下载所有所依赖的包。


下载包 `apt-get install sl –reinstall -d`
默认下载路径 `/var/cache/apt/archives`
sl_3.03-17build2_amd64.deb




## misc
1、apt和dpkg区别是dpkg绕过apt包管理数据库对软件包进行操作，所以你用dpkg安装过的软件包用apt可以再安装一遍，系统不知道之前安装过了，将会覆盖之前dpkg的安装。

2、dpkg是用来安装.deb文件,但不会解决模块的依赖关系,且不会关心ubuntu的软件仓库内的软件,可以用于安装本地的deb文件。

3、apt会解决和安装模块的依赖问题,并会咨询软件仓库, 但不会安装本地的deb文件, apt是建立在dpkg之上的软件管理工具。

