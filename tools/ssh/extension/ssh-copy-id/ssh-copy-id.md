# ssh-copy-id

ssh-copy-id命令 – 复制公钥到远程主机
## help
```
$ ssh-copy-id
Usage: /usr/bin/ssh-copy-id [-h|-?|-f|-n] [-i [identity_file]] [-p port] [[-o <ssh -o options>] ...] [user@]hostname
        -f: force mode -- copy keys without trying to check if they are already installed
        -n: dry run    -- no keys are actually copied
        -h|-?: print this help
```

## 参考实例

拷贝本机公钥到远程主机上面：
```
[root@linuxcool ~]# ssh-copy-id -i /root/.ssh/id_rsa.pub root@192.168.3.22
```