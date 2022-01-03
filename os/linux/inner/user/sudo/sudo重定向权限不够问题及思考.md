# sudo重定向权限不够问题及思考


[就是咋地](https://www.jianshu.com/u/8571eac04101)

0.2662018.11.02 17:25:38字数 827阅读 2,771

##### 一、背景

执行命令`sudo echo "xxx" >> /etc/hosts`时，提示Permission denied

##### 二、困惑

见到Permission denied就加sudo的万能大法为何会失效？

##### 三、原因

1.先来看sudo命令
 sudo命令的执行流程是: 当前用户转换到root, 然后以root身份执行（当前）命令, 执行完成后, 直接退回到当前用户.
 在`sudo echo "xxx" >> /etc/hosts`中，echo和>>是被视为两个命令的，所以会出现权限问题

##### 四、解决

1.将echo和>>作为一条命令执行
 利用 "sh -c" 命令，它可以让 bash 将一个字串作为完整的命令来执行，>这样就可以将 sudo 的影响范围扩展到整条命令。具体用法如下：
 `$ sudo sh -c 'echo "又一行信息" >> test.asc'`

2.使用sudo可以触达到的命令
 利用管道和 tee 命令，该命令可以从标准输入中读入信息并将其写入标准输出或文件中，具体用法如下：
 `$ echo "第三条信息" | sudo tee -a test.asc`

##### 参考资料

以下引自博客http://forum.ubuntu.org.cn/viewtopic.php?t=379910

> 其实需要重定向的不仅仅只有echo命令
>
> 众所周知，使用 echo 并配合命令重定向是实现向文件中写入信息的快捷方式。本文介绍如何将 echo 命令与 >sudo 命令配合使用，实现向那些只有系统管理员才有权限操作的文件中写入信息。
>
> 比如要向 test.asc 文件中随便写入点内容，可以：

```
>  $ echo "信息" > test.asc
>
> # 或者
>
> $ echo "信息" >> test.asc
```
> 下面，如果将 test.asc 权限设置为只有 root 用户才有权限进行写操作：

```ruby
$ sudo chown root.root test.asc
```

然后，我们使用 sudo 并配合 echo 命令再次向修改权限之后的 test.asc 文件中写入信息：

```bash
$ sudo echo "又一行信息" >> test.asc
-bash: test.asc: Permission denied
```

这时，可以看到 bash 拒绝这么做，说是权限不够。这是因为重定向符号 “>” 和 ">>" 也是 bash  的命令。我们使用 sudo 只是让 echo 命令具有了 root 权限，但是没有让 “>” 和 ">>" 命令也具有  root 权限，所以 bash 会认为这两个命令都没有像 test.asc 文件写入信息的权限。

解决这一问题的途径有两种。第一种是利用 "sh -c" 命令，它可以让 bash 将一个字串作为完整的命令来执行，>这样就可以将 sudo 的影响范围扩展到整条命令。具体用法如下：

```ruby
$ sudo sh -c 'echo "又一行信息" >> test.asc'
```

另一种方法是利用管道和 tee 命令，该命令可以从标准输入中读入信息并将其写入标准输出或文件中，具体用法如下：

```bash
$ echo "第三条信息" | sudo tee -a test.asc
```

注意，tee 命令的 "-a" 选项的作用等同于 ">>" 命令，如果去除该选项，那么 tee 命令的作用就等同于 ">" 命令。