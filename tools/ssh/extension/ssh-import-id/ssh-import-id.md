# ssh-import-id

ssh-import-id, 你可以使用此方法通过从 GitHub 导入密钥来授予你自己（或其他人）对计算机或服务器的访问权限。例如，我已经在我的 GitHub 帐户中注册了各个 SSH 密钥，因此无需密码即可推送到 GitHub。这些公钥是有效的，因此 ssh-import-id 可以使用它们在我的任何计算机上授权我：
```
$ ssh-import-id gh:bennuttall
```
我还可以使用它来授予其他人访问服务器的权限，而无需询问他们的密钥：
```
$ ssh-import-id gh:waveform80
```


## storm

我还使用了名为 Storm 的工具，该工具可帮助你将 SSH 连接添加到 SSH 配置中，因此你不必记住这些连接细节信息。你可以使用 `pip` 安装它：

```text
$ sudo pip3 install stormssh
```

然后，你可以使用以下命令将 SSH 连接信息添加到配置中：

```text
$ storm add pi3 pi@192.168.1.20
```

然后，你可以只使用 `ssh pi3` 来获得访问权限。类似的还有 `scp file.txt pi3:` 或 `sshfs pi pi3:`。

你还可以使用更多的 SSH 选项，例如端口号：

```text
$ storm add pi3 pi@192.168.1.20:2000
```

你可以参考 Storm 的[文档](https://link.zhihu.com/?target=https%3A//stormssh.readthedocs.io/en/stable/usage.html)轻松列出、搜索和编辑已保存的连接。Storm 实际所做的只是管理 SSH 配置文件 `~/.ssh/config` 中的项目。一旦了解了它们是如何存储的，你就可以选择手动编辑它们。配置中的示例连接如下所示：

```text
Host pi3
   user pi
   hostname 192.168.1.20
   port 22
```
## Zinaer SKM 
Zinaer SKM 的特性
创建，查看和删除你的 SSH 密钥
通过别名管理你所有的 SSH 密钥
选择并设置默认的 SSH 密钥
备份和恢复你所有的 SSH 密钥
多平台支持（Mac OS X and 各种 Linux 平台）
