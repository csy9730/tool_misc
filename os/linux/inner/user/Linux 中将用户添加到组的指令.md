# [Linux 中将用户添加到组的指令](https://www.cnblogs.com/jxhd1/p/6528574.html)

在 Linux 操作系统下，如何添加一个新用户到一个特定的组中？如何同时将用户添加到多个组中？又如何将一个已存在的用户移动到某个组或者给他增加一个组？对于不常用 Linux 的人来讲，记忆 Linux 那繁多的命令行操作真是件不容易的事。

在 Linux 中，增加用户或改变用户的组属性可以使用 `useradd` 或者 `usermod` 命令。`useradd`增加一个新用户或者更新默认新用户信息。`usermod` 则是更改用户帐户属性，例如将其添加到一个已有的组中。

在 Linux 用户系统中存在两类组。第一类是主要用户组，第二类是附加用户组。所有的用户帐户及相关信息都存储在 `/etc/passwd` 文件中，`/etc/shadow` 和 `/etc/group` 文件存储了用户信息。

目录 Contents

- [1 useradd 示例 – 增加一个新用户到附加用户组](https://cnzhx.net/blog/linux-add-user-to-group/#useradd_1)
- [2 useradd 示例 – 增加一个新用户到主要用户组](https://cnzhx.net/blog/linux-add-user-to-group/#useradd_2)
- [3 usermod 示例 – 将一个已有用户增加到一个已有用户组中](https://cnzhx.net/blog/linux-add-user-to-group/#usermod)
- [4 附：管理用户（user）和用户组（group）的相关工具或命令](https://cnzhx.net/blog/linux-add-user-to-group/#commands)

## useradd 示例 – 增加一个新用户到附加用户组[¶](https://cnzhx.net/blog/linux-add-user-to-group/#useradd_1)

新增加一个用户并将其列入一个已有的用户组中需要用到 `useradd` 命令。如果还没有这个用户组，可以先创建该用户组。

命令参数如下：

```
useradd -G {group-name} username
```

例如，我们要创建一个新用户 cnzhx 并将其添加到用户组 developers 中。首先需要以 root 用户身份登录到系统中。先确认一下是否存在 developers 这个用户组，在命令行输入：

```
# grep developers /etc/group
```

输出类似于：

```
developers:x:1124:
```

如果看不到任何输出，那么就需要先创建这个用户组了，使用 `groupadd` 命令：

```
# groupadd developers
```

然后创建用户 cnzhx 并将其加入到 developers 用户组：

```
# useradd -G developers cnzhx
```

为用户 cnzhx 设置密码：

```
# passwd cnzhx
```

为确保已经将该用户正确的添加到 developers 用户组中，可以查看该用户的属性，使用 `id` 命令：

```
# id cnzhx
```

输出类似于：

```
uid=1122(cnzhx) gid=1125(cnzhx) groups=1125(cnzhx),1124(developers)
```

前面命令中用到的大写的 G （-G） 参数就是为了将用户添加到一个附加用户组中，而同时还会为此用户创建一个属于他自己的新组 cnzhx。如果要将该用户同时增加到多个附加用户组中，可以使用英文半角的逗号来分隔多个附加组名（不要加空格）。例如，同时将 cnzhx 增加到 admins, ftp, www, 和 developers 用户组中，可以输入以下命令：

```
# useradd -G admins,ftp,www,developers cnzhx
```

## useradd 示例 – 增加一个新用户到主要用户组[¶](https://cnzhx.net/blog/linux-add-user-to-group/#useradd_2)

要增加用户 cnzhx 到组 developers，可以使用下面的指令：

```
# useradd -g developers cnzhx
# id cnzhx
```

输出类似于：

```
uid=1123(cnzhx) gid=1124(developers) groups=1124(developers)
```

请注意如前面的示例的区别，这里使用了小写字母 g （-g）作为参数，此时用户的主要用户组不再是 cnzhx 而直接就是 developers。

小写字母 g （-g）将新增加的用户初始化为指定为登录组（主要用户组）。此组名必须已经存在。组号（gid）即是此已有组的组号。

## usermod 示例 – 将一个已有用户增加到一个已有用户组中[¶](https://cnzhx.net/blog/linux-add-user-to-group/#usermod)

将一个已有用户 cnzhx 增加到一个已有用户组 apache 中，使此用户组成为该用户的附加用户组，可以使用带 -a 参数的 `usermod` 指令。-a 代表 append， 也就是将用户添加到新用户组中而不必离开原有的其他用户组。不过需要与 -G 选项配合使用：

```
# usermod -a -G apache cnzhx
```

如果要同时将 cnzhx 的主要用户组改为 apache，则直接使用 -g 选项：

```
# usermod -g apache cnzhx
```

如果要将一个用户从某个组中删除，则

```
gpasswd -d user group
```

但是这个时候需要保证 group 不是 user 的主组。

## 附：管理用户（user）和用户组（group）的相关工具或命令[¶](https://cnzhx.net/blog/linux-add-user-to-group/#commands)

1）管理用户（user）的工具或命令

```bash
useradd  # 添加用户adduser  注：添加用户
passwd   # 为用户设置密码
usermod   # 修改用户命令，可以通过usermod 来修改登录名、用户的家目录等等；
pwcov    # 同步用户从/etc/passwd 到/etc/shadow
pwck    # 注：pwck是校验用户配置文件/etc/passwd 和/etc/shadow 文件内容是否合法或完整；
pwunconv  # 注：是pwcov 的立逆向操作，是从/etc/shadow和 /etc/passwd 创建/etc/passwd ，然后会删除 /etc/shadow 文件；
finger   # 注：查看用户信息工具
id     # 注：查看用户的UID、GID及所归属的用户组
chfn    # 注：更改用户信息工具
su     # 注：用户切换工具
sudo    # 注：sudo 是通过另一个用户来执行命令（execute a command as another user），su是用来切换用户，然后通过切换到的用户来完成相应的任务，但sudo 能后面直接执行命令，比如sudo 不需要root 密码就可以执行root 赋与的执行只有root才能执行相应的命令；但得通过visudo 来编辑/etc/sudoers来实现；
visudo   # 注：visodo 是编辑 /etc/sudoers 的命令；也可以不用这个命令，直接用vi 来编辑 /etc/sudoers 的效果是一样的；
sudoedit  # 注：和sudo 功能差不多；
```

2）管理用户组（group）的工具或命令
``` bash
groupadd   # 添加用户组；
groupdel   # 删除用户组；
groupmod   # 修改用户组信息
groups    # 显示用户所属的用户组
grpck
grpconv   # 通过/etc/group和/etc/gshadow 的文件内容来同步或创建/etc/gshadow ，如果/etc/gshadow 不存在则创建；
grpunconv  # 通过/etc/group 和/etc/gshadow 文件内容来同步或创建/etc/group ，然后删除gshadow文件；
```



将一个用户添加到某个组，即可让此用户拥有该组的权限。比如在[配置 VPS 上的 LAMP 服务器](https://cnzhx.net/blog/vps-centos-6-lamp-phpmyadmin/)的时候，运行网站的 apache 用户修改的文件，如果服务器管理用户 cnzhx（可以通过 ssh 登录到服务器）需要修改此文件的话，就可以将 cnzhx 加入到 apache 组中达到目的。

标签: [shell](https://www.cnblogs.com/jxhd1/tag/shell/)