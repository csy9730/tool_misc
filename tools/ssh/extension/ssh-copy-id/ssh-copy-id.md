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


## misc
```
/usr/bin/ssh-copy-id: ERROR: failed to open ID file './vultr_ed25519': No such file or directory
        (to install the contents of './vultr_ed25519.pub' anyway, look at the -f option)
```
命令的输出信息提示没有私钥"id_rsa"文件。可知，ssh-copy-id命令执行时将检查公钥id_rsa.pub所在目录是否存在私钥id_rsa，若没有私钥则会导致命令执行失败。