# 修复: “Error: Failed to download metadata for repo appstream” – CentOS 8系统错误

发布于2022-03-29 13:05:20阅读 1.9K0



## 前言

CentOS Linux 8 已于 2021 年 12 月 31 日结束生命周期 (EOL)。这意味着 CentOS 8 将不再从 CentOS 官方项目获得开发资源。在 2021 年 12 月 31 日之后，如果您需要更新您的 CentOS，您需要将镜像更改为vault.centos.org，它们将被永久存档。或者，您可能想要升级到 CentOS Stream。

**错误：无法下载 repo ‘appstream’ 的元数据**

如果您仍然管理系统正在运行的 CentOS 8 并尝试使用`dnf update` or更新软件包`yum update`，您将遇到以下错误

```javascript
Error: Failed to download metadata for repo 'appstream': Cannot prepare internal mirrorlist: No URLs in mirrorlist
```

## 方法一

**解决方案：迁移到 CentOS Stream 8 或替代发行版**

现在 CentOS 已经转移到 Stream——一个滚动发布的 Linux 发行版，介于[Fedora的上游开发和](https://getfedora.org/)RHEL 的下游开发 之间——许多用户正在转向CentOS 的替代品。其他人决定通过迁移到 CentOS Stream 8 来坚持使用 CentOS。这两种选择都将解决无法更新 CentOS 8 的问题。

**要从 CentOS 8 迁移到 CentOS Stream 8，请运行以下命令：**

```javascript
dnf --disablerepo '*' --enablerepo=extras swap centos-linux-repos centos-stream-repos
dnf distro-sync
```

## 方法二

将镜像更改为vault.centos.org

**第一步：**进入`/etc/yum.repos.d/`目录。

```javascript
cd /etc/yum.repos.d/
```

**第 2 步：**运行以下命令

```javascript
sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS -*
```

**第 3 步：**现在运行 yum 更新

```javascript
yum update -y
```

而已！

本文参与