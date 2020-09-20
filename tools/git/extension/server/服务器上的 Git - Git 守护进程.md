# 服务器上的 Git - Git 守护进程

## Git 守护进程

接下来我们将通过 “Git” 协议建立一个基于守护进程的仓库。 对于快速且无需授权的 Git 数据访问，这是一个理想之选。 请注意，因为其不包含授权服务，任何通过该协议管理的内容将在其网络上公开。

如果运行在防火墙之外的服务器上，它应该只对那些公开的只读项目服务。 如果运行在防火墙之内的服务器上，它可用于支撑大量参与人员或自动系统 （用于持续集成或编译的主机）只读访问的项目，这样可以省去逐一配置 SSH 公钥的麻烦。

无论何时，该 Git 协议都是相对容易设定的。 通常，你只需要以守护进程的形式运行该命令：

```console
$ git daemon --reuseaddr --base-path=/srv/git/ /srv/git/
```

`--reuseaddr` 选项允许服务器在无需等待旧连接超时的情况下重启，而 `--base-path` 选项允许用户在未完全指定路径的条件下克隆项目， 结尾的路径将告诉 Git 守护进程从何处寻找仓库来导出。 如果有防火墙正在运行，你需要开放端口 9418 的通信权限。

你可以通过许多方式将该进程以守护进程的方式运行，这主要取决于你所使用的操作系统。

由于在现代的 Linux 发行版中，`systemd` 是最常见的初始化系统，因此你可以用它来达到此目的。 只要在 `/etc/systemd/system/git-daemon.service` 中放一个文件即可，其内容如下：

```console
[Unit]
Description=Start Git Daemon

[Service]
ExecStart=/usr/bin/git daemon --reuseaddr --base-path=/srv/git/ /srv/git/

Restart=always
RestartSec=500ms

StandardOutput=syslog
StandardError=syslog
SyslogIdentifier=git-daemon

User=git
Group=git

[Install]
WantedBy=multi-user.target
```

你可能会注意这里以 `git` 启动的 Git 驻留程序同时使用了 Group 和 User 权限。 按需修改它并确保提供的用户在此系统上。此外，请确保 Git 二进制文件位于 `/usr/bin/git`，必要时可修改此路径。

最后，你需要运行 `systemctl enable git-daemon` 以让它在系统启动时自动运行， 这样也能让它通过 `systemctl start git-daemon` 启动，通过 `systemctl stop git-daemon` 停止。

在其他系统中，你可以使用 `sysvinit` 系统中的 `xinetd` 脚本，或者另外的方式来实现——只要你能够将其命令守护进程化并实现监控。

接下来，你需要告诉 Git 哪些仓库允许基于服务器的无授权访问。 你可以在每个仓库下创建一个名为 `git-daemon-export-ok` 的文件来实现。

```console
$ cd /path/to/project.git
$ touch git-daemon-export-ok
```

该文件将允许 Git 提供无需授权的项目访问服务。