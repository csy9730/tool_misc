# ssh tools


- ssh         ssh客户端
- sshd        ssh服务端
- ssh-add     密钥管理，配合 ssh-agent使用
- ssh-agent   密钥管理服务 配合ssh-add使用
- ssh-keygen  生成密钥/公钥文件
- ssh-keyscan
- ssh-pageant
- scp


## ssh-keygen


#### pem.pub file
```
ssh-rsa base64_coding[388] comment

```
### pem file
```
-----BEGIN OPENSSH PRIVATE KEY-----
base64_coding[1700+]
-----END OPENSSH PRIVATE KEY-----
```

## ssh-keyscan
```
$ ssh-keyscan --help
ssh-keyscan: unknown option -- -
usage: ssh-keyscan [-46cDHv] [-f file] [-p port] [-T timeout] [-t type]
                   [host | addrlist namelist]
```

## ssh-pageant
```
$ ssh-pageant --help
Usage: ssh-pageant [options] [command [arg ...]]
Options:
  -h, --help     Show this help.
  -v, --version  Display version information.
  -c             Generate C-shell commands on stdout.
  -s             Generate Bourne shell commands on stdout.
  -S SHELL       Generate shell command for "bourne", "csh", or "fish".
  -k             Kill the current ssh-pageant.
  -d             Enable debug mode.
  -q             Enable quiet mode.
  -a SOCKET      Create socket on a specific path.
  -r, --reuse    Allow to reuse an existing -a SOCKET.
  -t TIME        Limit key lifetime in seconds (not supported by Pageant).

```