# ssh tools


- ssh
- ssh-add
- ssh-agent
- sshd
- ssh-keygen
- ssh-keyscan
- ssh-pageant
- scp


## ssh-keygen

```
$ ssh-keygen --help
ssh-keygen: unknown option -- -
usage: ssh-keygen [-q] [-b bits] [-t dsa | ecdsa | ed25519 | rsa]
                  [-N new_passphrase] [-C comment] [-f output_keyfile]
       ssh-keygen -p [-P old_passphrase] [-N new_passphrase] [-f keyfile]
       ssh-keygen -i [-m key_format] [-f input_keyfile]
       ssh-keygen -e [-m key_format] [-f input_keyfile]
       ssh-keygen -y [-f input_keyfile]
       ssh-keygen -c [-P passphrase] [-C comment] [-f keyfile]
       ssh-keygen -l [-v] [-E fingerprint_hash] [-f input_keyfile]
       ssh-keygen -B [-f input_keyfile]
       ssh-keygen -D pkcs11
       ssh-keygen -F hostname [-f known_hosts_file] [-l]
       ssh-keygen -H [-f known_hosts_file]
       ssh-keygen -R hostname [-f known_hosts_file]
       ssh-keygen -r hostname [-f input_keyfile] [-g]
       ssh-keygen -G output_file [-v] [-b bits] [-M memory] [-S start_point]
       ssh-keygen -T output_file -f input_file [-v] [-a rounds] [-J num_lines]
                  [-j start_line] [-K checkpt] [-W generator]
       ssh-keygen -s ca_key -I certificate_identity [-h] [-U]
                  [-D pkcs11_provider] [-n principals] [-O option]
                  [-V validity_interval] [-z serial_number] file ...
       ssh-keygen -L [-f input_keyfile]
       ssh-keygen -A
       ssh-keygen -k -f krl_file [-u] [-s ca_public] [-z version_number]
                  file ...
       ssh-keygen -Q -f krl_file file ...

```

- `-file` 指定生成文件 output_keyfile,  `~/.ssh/id_rsa`
- `-t`  指定密钥算法：[dsa | ecdsa | ed25519 | rsa]
- `-comment -C` 指定添加的注释 ,默认使用本机的设备名作为 注释。
- `-V validity_interval` 指定证书过期时间?  +1d = allow for one day
- -s key = signing ?
- -I = key identity ?
- -n principal, the name of the user or host?

其他操作：
1. 生成私钥公钥
2. 基于私钥，生成公钥
3. 私钥转换passphrase

#### validity_interval
> For example: “+52w1d” (valid from now to 52 weeks and one
>       day from now), “-4w:+4w” (valid from four weeks ago to four
>       weeks from now), “20100101123000:20110101123000” (valid
>       from 12:30 PM, January 1st, 2010 to 12:30 PM, January 1st,
>       2011), “-1d:20110101” (valid from yesterday to midnight,
>       January 1st, 2011), “-1m:forever” (valid from one minute
>       ago and never expiring).

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