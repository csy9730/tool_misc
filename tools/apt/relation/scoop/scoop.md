# scoop

[https://scoop.sh/](https://scoop.sh/)
> A command-line installer for Windows


[scoop](https://github.com/lukesampson/scoop)

本文将简单介绍scoop的使用，并包含设计原理的分析推断。

## install
要求powershell3或以上版本， .NET Framework 4.5或以上版本。
scoop 高版本要求powershell>5.0

在 PowerShell 中输入下面内容，保证允许本地脚本的执行：

`set-executionpolicy remotesigned -scope currentuser`

然后执行下面语句进行安装：

`iex (new-object net.webclient).downloadstring('https://get.scoop.sh')`

即可安装scoop。

[gitee scoop](https://gitee.com/zlata/scoop)

### 安装到指定目录
安装到指定目录(D:\tool\scoop)
``` powershell
[environment]::setEnvironmentVariable('SCOOP','D:\tool\scoop','User')
$env:SCOOP='D:\tool\scoop'
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')
```

指定-g安装目录(D:\tool\scoop_global)
```
[environment]::setEnvironmentVariable('SCOOP_GLOBAL','D:\tool\scoop_global','Machine')
$env:SCOOP_GLOBAL='D:\tool\scoop_global'
scoop install -g app
```

## core

### 用户级安装
默认安装路径`C:\Users\<user>\scoop`

```
C:\Users\admin\scoop
- apps
    - scoop
    - sudo
    - ...
- buckets
    - main/
        .git/
    - extra/
        .git/
- cache/
    - *.zip, *.7z, *.exe
- shims
    - scoop
    - scoop.cmd
    - scoop.ps1
    - wget.exe
    - wget.shims

```

- apps/ 目录放所有安装的应用文件夹
- apps/scoop 安装的scoop文件夹
- apps/scoop/current 真实安装的scoop文件夹
- apps/wget/current 指向真实安装的wget文件夹
- apps/wget/1.21.3 安装的1.21.3版本的wget文件夹
- buckets/ 目录放所有软件桶的git仓库
- buckets/main 主软件桶的git仓库
- buckets/extra extra软件桶的git仓库
- cache/  从软件桶下载的软件安装包
- shims/ 安装软件的快捷方式文件夹
- shims/scoop 基于scoop.ps1的封装
- shims/scoop.cmd 基于scoop.ps1的cmd封装
- shims/scoop.ps1 scoop的全局入口，指向scoop的真实入口
- apps/scoop/current/bin/scoop.ps1 scoop的真实入口
- shims/wget.exe wget的伪入口，依赖wget.shims
- shims/wget.shims wget的入口配置, 指向wget的真实入口
- apps/wget/current/wget.exe  wget的真实入口
- apps/wget/current/manifest.json 从软件桶中获得的包信息。
- apps/wget/current/install.json 软件安装信息
- persist/ ,这个目录下面放的是已安装软件的配置文件, 后续更新软件的时候这部分内容不会修改.

### 系统级安装
C:\ProgramData\scoop
- apps/
- shims/

和用户级安装类似，只是调整了apps和shims文件夹的路径。

#### scoop
可执行程序路径：`C:\Users\admin\scoop\apps\scoop\current\bin\scoop.ps1`

命令行调用的路径：
```
$ C:\Users\admin>where scoop
C:\Users\admin\scoop\shims\scoop
C:\Users\admin\scoop\shims\scoop.cmd
```

#### apps/wget/current/wget.shims
``` ini
path = "C:\Users\admin\scoop\apps\wget\current\wget.exe"

```
#### apps/wget/current/install.json
``` json
{
    "bucket": "main",
    "architecture": "64bit"
}
```
### apps/wget/current

apps/wget/current和apps/wget/1.21.3，两者的关系是符号链接。

scoop安装wget时会自动生成，用以下命令也能手动生成符号链接
``` batch
mklink /d apps/wget/current apps/wget/1.21.3
```

## usage

### 常见安装包
```
scoop install sudo
sudo scoop install 7zip git openssh --global
scoop install aria2 curl grep sed less touch
scoop install python ruby go perl 
```

### 基本命令
``` bash
scoop help            # 帮助
scoop list            # 查看当前已安装软件
scoop info app        # 查看软件信息
scoop install app     # 安装软件
scoop search app      # 搜索软件
scoop uninstall app   # 卸载软件
scoop update app      # 更新指定软件
scoop update *        # 更新安装的软件和scoop

# 设置代理(http)
scoop config proxy 127.0.0.1:4412
```

#### scoop install
指定安装32位的软件:
```
scoop install snipaste -a 32bit
```

help
```

C:\Project\mylib\tool_misc>scoop install --help
Usage: scoop install <app> [options]

Options:
  -g, --global                    Install the app globally
  -i, --independent               Don't install dependencies automatically
  -k, --no-cache                  Don't use the download cache
  -u, --no-update-scoop           Don't update Scoop before installing if it's outdated
  -s, --skip                      Skip hash validation (use with caution!)
  -a, --arch <32bit|64bit|arm64>  Use the specified architecture, if the app supports it
```

安装默认使用cache目录的文件，开启--no-cache可以避免使用缓存。

#### scoop list
scoop list命令可以扫描app/目录下的所有文件夹，得到所有安装的软件，根据install.json和manifest.json得到安装成功信息。

```

C:\Project\mylib\tool_misc>scoop list
Installed apps:

Name                Version      Source Updated             Info
----                -------      ------ -------             ----
7zip                22.01        main   2022-12-30 09:41:27
adb                 33.0.3       main   2022-12-30 10:45:53
aria2                                   2022-12-30 10:09:44 Install failed
cacert              2022-10-11   main   2022-12-30 10:01:00
cmder               1.3.21       main   2022-12-30 14:31:02
cpu-z                                   2023-01-03 16:40:51 Install failed
dvc                                     2023-01-05 23:10:08 Install failed
graphviz            7.0.5        main   2023-01-12 13:37:34
nodejs              19.3.0       main   2022-12-30 10:20:33
rustdesk            1.1.9        extras 2023-01-14 11:49:15
sudo                0.2020.01.26 main   2022-12-30 09:33:15
vncviewer           6.22.826     extras 2023-01-14 11:45:59
wget                1.21.3       main   2022-12-30 10:01:22
zal_obfs            1.21.3       local  2022-12-30 13:49:01
advanced-ip-scanner 2.5.4594.1   extras 2023-01-05 13:33:02 Global install
cpuz_x32            1.87.0              2023-01-28 10:41:52 Global install
innounp             0.50         main   2023-01-05 15:10:09 Global install
sudo                0.2020.01.26 main   2023-01-28 10:03:03 Global install
```


## bucket
安装完成后，还需要添加软件源，不然会有好些软件能search到但是不能install.
scoop拥有多个bucket，每个bucket相当于多个软件集合，scoop自带了main bucket，main bucket收集了最常用的软件，包括软件信息，软件下载地址。
``` 
scoop bucket add extras
scoop bucket add versions
scoop bucket add nonportable
```

如果出现以下问题：
```
Checking repo... ERROR 'https://github.com/ScoopInstaller/Versions' doesn't look like a valid git repository

Error given:
fatal: unable to access 'https://github.com/ScoopInstaller/Versions/': Failed to connect to github.com port 443: Timed out
```
是因为网络不好，需要使用代理才能访问。

```
C:\>scoop bucket  known
main
extras
versions
nightlies
nirsoft
php
nerd-fonts
nonportable
java
games
jetbrains
```

- main - 默认仓库
- extras - 默认仓库的补充超级强大
- games - 游戏仓库
- nerd-fonts - Nerd Fonts
- nirsoft - A subset of the 250 Nirsoft apps
- java - Installers for Oracle Java, OpenJDK, Zulu, ojdkbuild, AdoptOpenJDK, Amazon Corretto, BellSoft Liberica & SapMachine
- jetbrains - Installers for all JetBrains utilities and IDEs
- nonportable - Non-portable apps (may require UAC)
- php - Installers for most versions of PHP
- versions - Alternative versions of apps found in other buckets

### 添加镜像仓库

添加bucket本质上就是在用git复制仓库到本地。

``` bash
# main
scoop bucket add main https://codechina.csdn.net/mirrors/ScoopInstaller/Main.git
# extras
scoop bucket add extras https://codechina.csdn.net/mirrors/lukesampson/scoop-extras.git
```

显示本地收录的仓库
```
scoop bucket list
Name        Source                                        Updated             Manifests
----        ------                                        -------             ---------
extras      ~\scoop\buckets\extras                                                    0
local       ~\scoop\buckets\local                                                     0
main        https://github.com/ScoopInstaller/Main        2022/12/30 12:27:32      1136
nonportable https://github.com/ScoopInstaller/Nonportable 2022/12/30 4:30:32        104
versions    ~\scoop\buckets\versions                                                  0
```

#### 镜像内容
https://github.com/ScoopInstaller/Main/-/blob/master/bucket/curl.json

``` json
{
    "version": "7.87.0",
    "description": "Command line tool and library for transferring data with URLs",
    "homepage": "https://curl.haxx.se/",
    "license": "MIT",
    "architecture": {
        "64bit": {
            "url": "https://curl.haxx.se/windows/dl-7.87.0/curl-7.87.0-win64-mingw.tar.xz",
            "hash": "952308b3cf71cf178336a8026b10588f44918003d5a0ccbc1db4c704149a753e",
            "extract_dir": "curl-7.87.0-win64-mingw"
        },
        "32bit": {
            "url": "https://curl.haxx.se/windows/dl-7.87.0/curl-7.87.0-win32-mingw.tar.xz",
            "hash": "e1b0d63024e89d6d62a9ae8b734cb1bfd4f2ab49aeb2143f6d04a29fdbae9295",
            "extract_dir": "curl-7.87.0-win32-mingw"
        }
    },
    "bin": "bin\\curl.exe",
    "checkver": {
        "url": "https://curl.haxx.se/windows/",
        "regex": "Build<\\/b>:\\s+([\\d._]+)"
    },
    "autoupdate": {
        "architecture": {
            "64bit": {
                "url": "https://curl.haxx.se/windows/dl-$version/curl-$version-win64-mingw.tar.xz",
                "extract_dir": "curl-$version-win64-mingw"
            },
            "32bit": {
                "url": "https://curl.haxx.se/windows/dl-$version/curl-$version-win32-mingw.tar.xz",
                "extract_dir": "curl-$version-win32-mingw"
            }
        },
        "hash": {
            "url": "$baseurl/hashes.txt",
            "regex": "SHA256\\($basename\\)=\\s+$sha256"
        }
    }
}
```

可以看到，仓库本身不保存软件源，只保存软件源地址，和相关的配置信息。
这样可以保持仓库的纯净性，可读性，避免大量的二进制文件污染仓库。
缺点是，这样是分布式存储，软件源地址参差不齐，网络环境区别很大，

对于国内用户，可能出现，7zip的源容易下载，而curl的源难以下载的问题。

### 自定义软件
可以看到，只要配置了bucket的json文件和文件下载地址，自己也可以设置软件发布。

在本地路径创建文件夹 C:\Users\admin\scoop\buckets\local\bucket，相当于创建了一个bucket，命名为local。
省去了从远程端使用git拉取bucket仓库的过程。

准备一个压缩包文件zal_obfs.zip, 使用sha256sum命令计算校验码。
```
$ sha256sum zal_obfs.zip
84fa696e40d4c6e7a9b9cbcbedddd553fa8ac2ecb0534e9785c328c96a4a4789 *zal_obfs.zip
```

启动一个文件服务，用来提供压缩包的下载。这里使用`python -m http.server 8888` 建立http服务。

接着在local/bucket目录下创建一个zal_obfs.json文件

``` json
{
    "version": "1.21.3",
    "description": "A command-line utility ",
    "homepage": "http://localhost:8888/zal_obfs/",
    "license": "GPL-3.0-or-later",
    "architecture": {
        "64bit": {
            "url": "http://localhost:8888/zal_obfs.zip",
            "hash": "0cba60b14295154e31443643b98635dd18ed20bd5b8eba5065d29bc5533ba792"
        },
        "32bit": {
            "url": "http://localhost:8888/zal_obfs.zip",
            "hash": "0cba60b14295154e31443643b98635dd18ed20bd5b8eba5065d29bc5533ba792"
        }
    },
    "bin": ["zal_obfs.exe", "zal_deobfs.exe"]
}
```

至此，scoop包的发布工作就完成了，现在可以是命令`scoop install zal_obfs`下载了。

```
Installing 'zal_obfs' (1.21.3) [64bit] from local bucket
Loading zal_obfs.zip from cache
Checking hash of zal_obfs.zip ... ok.
Extracting zal_obfs.zip ... done.
Linking ~\scoop\apps\zal_obfs\current => ~\scoop\apps\zal_obfs\1.21.3
Creating shim for 'zal_obfs'.
Creating shim for 'zal_deobfs'.
'zal_obfs' (1.21.3) was installed successfully!
```
可以看到，成功地安装了程序。

scoop可以自动下载压缩包，解压压缩包到安装目录，为入口程序建立快捷方式。

通过以上的包的发布过程，我们也基本搞懂了scoop安装程序的原理，真的是非常简单又直接。

### 常用软件
```
nodejs adb nginx apache putty-np cmder
ffmpeg frp gcc llvm jenkins mingw

typora
everything
winscp

SpaceSniffer
rufus
FreeCommander
frp
filezilla
sqliespy
vim
sqlite
mobaxterm
```


## help
```
Usage: scoop <command> [<args>]

Some useful commands are:

alias       Manage scoop aliases                                   
bucket      Manage Scoop buckets                                   
cache       Show or clear the download cache                       
checkup     Check for potential problems                           
cleanup     Cleanup apps by removing old versions                  
config      Get or set configuration values                        
create      Create a custom app manifest                           
depends     List dependencies for an app                           
export      Exports (an importable) list of installed apps         
help        Show help for a command                                
hold        Hold an app to disable updates                         
home        Opens the app homepage                                 
info        Display information about an app                       
install     Install apps                                           
list        List installed apps                                    
prefix      Returns the path to the specified app                  
reset       Reset an app to resolve conflicts                      
search      Search available apps                                  
status      Show status and check for new app versions             
unhold      Unhold an app to enable updates                        
uninstall   Uninstall an app                                       
update      Update apps, or Scoop itself                           
virustotal  Look for app's hash on virustotal.com                  
which       Locate a shim/executable (similar to 'which' on Linux) 


Type 'scoop help <command>' to get help for a specific command.
```
## misc
windows下的安装软件有：  scoop ，  chocolate，    nuget， winget
[winget](https://github.com/microsoft/winget-cli/releases)

chocolatey VS scoop
chocolatey权限要求高, scoop 使用-g安装才需要管理员权限, 默认普通用户权限.
scoop可以建软件包仓库, 如果官方仓库里没有想用的软件, 可以自己建一个仓库, 存放自己的软件.
chocolatey很多软件安装位置不固定, 会污染Path