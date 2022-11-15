# 记录 WSL 从 C 盘迁移至 D 盘



[![img](https://cdn.learnku.com//uploads/communities/WtC3cPLHzMbKRSZnagU9.png!/both/44x44) Laravel ](https://learnku.com/laravel)/  322 /  5 / 发布于 1年前 / 更新于 1年前



## 前言

WSL 默认安装在 C 盘，随着开发时间的增长，数据越来越多，子系统数据占用高达 60 GB，对于原本 100 GB 的 C 盘，不堪重负，终于只剩下不足 300 MB 的空间，随之而来的就是 PHPStorm 无法打开

为了解决这个问题，需要迁移 WSL 默认存储位置

## 过程

1. 下载工具

- [LxRunOffline](https://github.com/DDoSolitary/LxRunOffline)：一个非常强大的管理子系统的工具

  下载并解压后，在解压目录中打开 PowerShell

2. 查看已安装的子系统

```bash
$ ./LxRunOffline.exe list
```

   

3. 查看子系统所在目录

```bash
$ ./LxRunOffline.exe get-dir -n Ubuntu-18.04
```   

1. 新建目标目录并授权

```bash
$ icacls D:\wsl\installed /grant "cnguu:(OI)(CI)(F)"
```

- 目标目录：`D:\wsl\installed`
- 用户名：`cnguu`

2. 迁移系统

```bash
$ .\LxRunOffline move -n Ubuntu-18.04 -d D:\wsl\installed\Ubuntu-18.04
```

然后耐心等待一大堆 `Warning` 的结束

> 如果报错：`[ERROR] The distro "Ubuntu-18.04" has running processes and can't be operated.`
>
> 需要重启服务：`LxssManager`（快捷键：同时按 `Win + x`，再按 `g`）
>


3. 重注册系统

如果更改登录用户，此时可能无法发现wsl的默认系统，这时需要重新登记系统。
```bash
$ .\LxRunOffline ng -n Ubuntu-18.04 -d D:\wsl\installed\Ubuntu-18.04
```

## 结果

C 盘满血复活


> 不知道是不是错觉，感觉读写文件速度快了很多

> 本作品采用[《CC 协议》](https://learnku.com/docs/guide/cc4.0/6589)，转载必须注明作者和本文链接