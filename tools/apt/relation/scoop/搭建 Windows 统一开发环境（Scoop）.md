# 搭建 Windows 统一开发环境（Scoop）

[![端水大法师](https://pic1.zhimg.com/v2-4b76484345ba673ff06ef0c260515997_l.jpg?source=32738c0c)](https://www.zhihu.com/people/yang-xin-bin-zz)

[端水大法师](https://www.zhihu.com/people/yang-xin-bin-zz)

名义上的生物医学工程博士

91 人赞同了该文章



目录

收起

包管理器

Scoop 的安装

Scoop 的使用（加载扩展库）

Scoop 的管理与配置

## **包管理器**

包管理器（package manager）是开发人员常用的生产力工具，Ubuntu上的 **Apt-Get** 和MacOS上的 **Homebrew** 等的使用都让开发环境的搭建变得无比丝滑。这里的包，可以理解成广义上的软件，不仅包含常见的基于图形用户界面（GUI）的软件，还包含基于命令行界面（CLI）的开发工具。简单说，包管理器就是一个软件自动化管理工具。

如今，Windows也有了历经时间考验的包管理器：**Chocolatey**，**Scoop** 和。其中，**Chocolatey** 整个社区发布的安装脚本有3000多个，而 **Scoop** 官方仓库发布的安装脚本有2000多个。脚本数量上不如 **Chocolatey，**但是 **Scoop** 自定义程度高，扩展性强，可以非常方便的自己定制安装脚本。最关键的是，**Scoop** 的维护完胜前者，前者貌似脚本很多，但其中不少已经没人维护或者不再更新了。

本文涉及如下内容：

- Scoop 的安装；
- Scoop 的使用（加载扩展库）；
- Scoop 的相关配置；

### **Scoop 的安装**

**Scoop** 由澳洲程序员Luke Sampson于2015年创建，其特色之一就是其安装管理不依赖“管理员权限”，这对使用有权限限制的公共计算机的使用者是一大利好。其的安装步骤如下：

**步骤 1：在 PowerShell 中打开远程权限**

```powershell
Set-ExecutionPolicy RemoteSigned -scope CurrentUser
```

**步骤 2：自定义 Scoop 安装目录**

```powershell
irm get.scoop.sh -outfile 'install.ps1'
.\install.ps1 -ScoopDir 'Scoop_Path' -ScoopGlobalDir 'GlobalScoop_Path' -Proxy 'http://<ip:port>'
# 如
# .\install.ps1 -ScoopDir 'C:\Scoop' -ScoopGlobalDir 'C:\Program Files' -NoProxy
```

> **Scoop** 将默认把所有用户安装的 App 和 **Scoop** 本身置于`C:\Users\user_name\scoop`

**步骤 3：更新 Scoop**

```powershell
scoop update
```

国内镜像

```powershell
iwr -useb https://gitee.com/glsnames/scoop-installer/raw/master/bin/install.ps1 | iex
scoop config SCOOP_REPO 'https://gitee.com/glsnames/scoop-installer'
scoop update
```

**步骤 4：安装包（主要是命令行程序）：**

```powershell
scoop install <app_name>
scoop install sudo
```

> Scoop 的基本操作与 Chotolatey 类似。

**步骤 5：通过 `scoop help` 查看使用简介**

![img](https://pic1.zhimg.com/80/v2-bf33c33d3137ceaab7a6e1bc2f69cd54_720w.webp)

更多信息，请访问 Scoop 官网

[Scoopscoop.sh/](https://link.zhihu.com/?target=https%3A//scoop.sh/)

### **Scoop 的使用（加载扩展库）**

**步骤 1：安装 Aria2 来加速下载**

```powershell
scoop install aria2
```

如果使用代理，有时需要通过如下命令关闭 aria2

```powershell
scoop config aria2-enabled false
```

**步骤 2：安装 Git 来添加新仓库**

```powershell
scoop install git
```

**步骤3：添加官方维护的extras库（含大量GUI程序）**

```powershell
scoop bucket add extras
# 国内镜像
# scoop bucket add extras https://gitee.com/scoop-bucket/extras.git
scoop update
```

git 下载如果使用 Scoop 原生的下载协议可能比较慢，建议采用如下迂回方案：

1. 用第三方下载器，如 Motrix 下载；
2. 然后将文件拷贝到 `path to scoop/cache`；
3. 输入 scoop install git，此时会产生一个扩展名为 .download 的文件；
4. 输入 scoop uninstall git；
5. 重命名自己下载的文件名为3中的文件名，但取代 .download 文件；
6. 输入 scoop install git；

**可选步骤：添加我创建并维护的scoopet库（专注服务科研）**

```powershell
scoop bucket add scoopet https://github.com/ivaquero/scoopet.git
scoop update
```

scoopet 库包含的安装脚本分为如下四类：

- 科研工具：如 miniconda（国内镜像），julia（国内镜像），copytranslator，gephi，geogebra，mendeley，netlogo
- 开发辅助：如 cyberduck，virtualbox，vmware
- 日常办公：如 adobe acrobat，wpsoffice，百度网盘，灵格斯词霸
- 社交休闲：如 you-get，网易云音乐，微信

> 详情见 [https://github.com/](https://link.zhihu.com/?target=https%3A//github.com/integzz/scoopet/blob/master/README_CN.md)ivaquero[/scoopet/blob/master/README_CN.md](https://link.zhihu.com/?target=https%3A//github.com/integzz/scoopet/blob/master/README_CN.md)

![img](https://pic3.zhimg.com/80/v2-8da86ca44dc4e071f81f05d7b73b1ffa_720w.webp)

**步骤 4：安装 App**

- 使用`scoop search `命令搜索 App 的具体名称

```powershell
scoop install scoop-completion
scoop install <app_name>
```

- 利用插件`scoop-completion`协助安装

```powershell
scoop install scoop-completion
```

> 使用`scoop-completion`：键入 App 名称的前几个字母后敲击`tab`键进行补全
> `scoop-completion`包含于 scoopet 库中

**步骤 5：查看官方推荐仓库**

```powershell
scoop bucket known

main [默认]
extras [墙裂推荐]
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

这里，推荐一个网站，这个方便全网查询安装脚本所在 bucket

[Apps | Scoopscoop.netlify.app/apps/](https://link.zhihu.com/?target=https%3A//scoop.netlify.app/apps/)

###  **Scoop 的管理与配置**

**管理**

```powershell
# 查看已安装程序
scoop list
# 查看更新
scoop status
# 删除旧版本
scoop cleanup
# 自身诊断
scoop checkup
```

![img](https://pic1.zhimg.com/80/v2-2b41030416b39b0e1fd0a84acb3b0a68_720w.webp)

**命令行推荐**

```powershell
# 使用 Linux 命令行
scoop install gow
# 调用管理员权限
scoop install sudo
# windows 终端模拟器
scoop install cmder
```

**Aria2 的参数**

```powershell
# aria2 在 Scoop 中默认开启
scoop config aria2-enabled true
# 关于以下参数的作用，详见aria2的相关资料
scoop config aria2-retry-wait 4
scoop config aria2-split 16
scoop config aria2-max-connection-per-server 16
scoop config aria2-min-split-size 4M
```



编辑于 2022-11-15 11:36・IP 属地河南



[scoop（包管理）](https://www.zhihu.com/topic/21221300)

[包管理器](https://www.zhihu.com/topic/19650159)

[Microsoft Windows](https://www.zhihu.com/topic/19552612)