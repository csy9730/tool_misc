# ssh-keygen

## help
```
$ ssh-keygen --help |clip
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
- `-comment` `-C` 指定添加的注释 ,默认使用本机的设备名作为 注释。
- `-V validity_interval` 指定证书过期时间?  +1d = allow for one day 只允许一天
- -s key = signing ?
- -I = key identity ?
- -n principal, the name of the user or host?

其他操作：
1. 生成私钥公钥
2. 基于私钥，生成公钥
3. 私钥转换passphrase
### options
### 密钥算法
- `-t`  指定密钥算法：[dsa | ecdsa | ed25519 | rsa]
- [-b bits] [-b 4096] 表示 RSA 密钥长度 4096 bits （默认 2048 bits）。Ed25519 算法不需要指定。

### passphrase 
密语和口令(password)非常相似，但是密语可以是一句话，里面有单词、标点符号、数字、空格或任何你想要的字符。 
好的密语要30个以上的字符，难以猜出，由大小写字母、数字、非字母混合组成。密语可以用 -p 选项修改。 
丢失的密语不可恢复。如果丢失或忘记了密语，用户必须产生新的密钥，然后把相应的公钥分发到其他机器上去。 

- -N new_passphrase 提供一个新的密语。 
- -P passphrase 提供(旧)密语。 
- -p 要求改变某私钥文件的密语而不重建私钥。程序将提示输入私钥文件名、原来的密语、以及两次输入新密语。 

### comment
”注释”字段，可以方便用户标识这个密钥，指出密钥的用途或其他有用的信息。 
创建密钥的时候，注释域初始化为”user@host”，以后可以用 -c 选项修改。

- -C comment 提供一个新注释 
- -c 要求修改私钥和公钥文件中的注释。

#### validity_interval 
改选项可以配置有效时间段

> For example: “+52w1d” (valid from now to 52 weeks and one
>       day from now), “-4w:+4w” (valid from four weeks ago to four
>       weeks from now), “20100101123000:20110101123000” (valid
>       from 12:30 PM, January 1st, 2010 to 12:30 PM, January 1st,
>       2011), “-1d:20110101” (valid from yesterday to midnight,
>       January 1st, 2011), “-1m:forever” (valid from one minute
>       ago and never expiring).


### ssh-keygen其他命令

- `ssh-keygen -A` 批量生成 ssh_host_rsa_key，ssh_host_dsa_key ssh_host_ecdsa_key ssh_host_ed25519_key
- `ssh-keygen -R hostname`  从known_hosts删除 hostname 
- `ssh-keygen -s ssh_ca -I michael -n support -V +1d ~/.ssh/id_ed25519.pub`


### 删除 hostname 
`ssh-keygen -R hostname`
### 生成签名
``` bash
ssh-keygen -f ssh_ca
ssh-keygen -t ed25519 -C "michael from linux-audit.com" -f id_ed25519
ssh-keygen -s ssh_ca -I michael -n support -V +1d id_ed25519.pub

```
### 打印签名内容
```
$ ssh-keygen -L -f id_ed25519-cert.pub
id_ed25519-cert.pub:
        Type: ssh-ed25519-cert-v01@openssh.com user certificate
        Public key: ED25519-CERT SHA256:ElGc/jLlQWHIVmY2xfi8Z49DfSzl1MX6Nhw6aH5pYbw
        Signing CA: RSA SHA256:AmsyuPuKu9LLQOLlPWBzaMDKBY5w8X7H3GbqSFjXAe0
        Key ID: "michael"
        Serial: 0
        Valid: from 2022-01-02T00:18:00 to 2022-01-03T00:19:00
        Principals:
                support
        Critical Options: (none)
        Extensions:
                permit-X11-forwarding
                permit-agent-forwarding
                permit-port-forwarding
                permit-pty
                permit-user-rc
(base)

```
## usage
``` bash
# 1. 静默生成密钥文件
ssh-keygen -t ed25519 -C "strawperrypi" -f pi_ed25519 -q -N ""

# ssh-keygen -C "strawperrypi" -f pi_rsa -q -N ""

# 2. 复制公钥到目标设备
ssh-copy-id -i pi_ed25519.pub my_rasp

```

