# apt

apt 包管理器

- show 查询指定包的详情
- search
- policy 列出软件的所有来源
- install 安装软件
- remove 卸载软件
- update
- upgrade

## faq

#### 指定版本安装
```
apt policy gdb
gdb:
  Installed: 9.2-0ubuntu1~20.04.1
  Candidate: 9.2-0ubuntu1~20.04.1
  Version table:
 *** 9.2-0ubuntu1~20.04.1 500
        500 http://archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages
        100 /var/lib/dpkg/status
     9.1-0ubuntu1 500
        500 http://archive.ubuntu.com/ubuntu focal/main amd64 Packages

```

```
apt-cache madison gdb
       gdb | 9.2-0ubuntu1~20.04.1 | http://archive.ubuntu.com/ubuntu focal-updates/main amd64 Packages
       gdb | 9.1-0ubuntu1 | http://archive.ubuntu.com/ubuntu focal/main amd64 Packages
```

```
apt-cache showpkg gdb
```
```
sudo apt-get install <package name>=<version>
```
#### 指定glibc版本安装
