# gpg


## install

一般无需安装，bash环境基本自带了gnupg，包管理工具apt需要gpg验证安装包的签名。
安装git-bash，附带了 gpg工具，位于 `/usr/bin/gpg`

安装命令
``` bash
apt install gnupg
```


## main


### 概念介绍
- 公钥/私钥
- key 密钥 包含公钥（证书）/私钥
- 子密钥 subkey
- uid 即 user id
- keyserver
- 指纹： 是公钥的后N位。
- 签名
- 失效日期
- 吊销证书 revocation certificate


- 认证 [C]
- 身份验证 [A]
- 签名 [S]  
- 加密 [E]

SSH 登录密钥实际上只用到了 [A] 这一项能力

GPG 密钥的能力中， [C]、[S]、[A] 均属于签名方案，只有 [E] 是加密方案
E用于加密一般文件，S 用于签名/验证一般文件。认证功能C本质上是签名公钥，生成证书，身份验证功能本质上验签证书。
证书含有比公钥更多的附加信息。
当然也能自己认证自己，就是自签名证书。



- 公钥，相当于公司名，所有员工都隶属于公司之下。公司主营业务是给保险柜上锁和解锁。
- 主密钥是董事长，一般不干具体事务，隐藏幕后，核心功能是主抓人事任命（认证），就是可以提权其他密钥。主密钥也可以撤销子私钥。
- 子私钥是核心骨干，可以确认其他密钥的身份（身份验证），确认它是否是自己组织的。
- 签名和加密是实际业务，主要是面向机密文件管理的，相当于公司的业务员，可以押送产品，并确认确实是公司押送的产品。
- 子公钥：子密钥的公钥，相当于员工名片。gpg隐藏子公钥，推荐使用主公钥。

## core


GPG 不允许用户生成子密钥的吊销证书，而是把变更都放在唯一的公钥中，简洁且不易出错。 你只需要编辑“大”密钥，将子密钥单独吊销，然后重新发布公钥即可

看到这里你可能已经明白了，一个 GPG 密钥对之所以可以有这么多能力，是因为它本质上是若干密钥对的集合，只不过它们被封装到了一起。
所有子密钥的有效性，都来自于主密钥的认证。
子密钥可以在没有主密钥的情况下单独使用。

## usage



- 密钥管理
    - 生成公钥密钥对 `gpg --generate-key` / `gpg --full-generate-key`/`--full-gen-key`
    - 生成吊销证书 --gen-revoke `--generate-revocation`
    - 列出密钥 
        - 列出密钥 `--list-keys`, `--list-secret-keys` 
        - `--list-signatures`, 列出认证源？
        - `--fingerprint`
    - 导出  
        - `--export` 
        - `--export-secret-keys` 
        - `--export-secret-subkeys` 
        - `gpg --export-ssh-keys`
    - 导入 `--import`
    - 子钥管理
    - 密钥修改
        - --change-passphrase
        - --sign-key
        - `--edit-key`
    - keyserver
        - 上传公钥到公钥服务器 `--send-keys `
        - `--receive-keys`
        - `--search-keys`
        - `--refresh-keys`
- 密钥使用
    - 加密文件 `gpg --recipient [用户ID] --output demo.en.txt --encrypt demo.txt`
    - 解密文件 `--decrypt`
    - 签名文件 `gpg --sign demo.txt`
        - 签名文件 `--detach-sign`
    - 验证签名 `--verify`  


#### 初始化

#### 生成密钥
```
gpg --gen-key
```
#### 查看

```
gpg --list-sig User1


```

- sec => 'SECret key'
- ssb => 'Secret SuBkey'
- pub => 'PUBlic key'
- sub => 'public SUBkey'

密钥的功能
- C  认证
- A 身份验证，鉴权
- S  sign 签名
- E 加密


#### 导出


`gpg --export -a  --sub`


--export-key，导出公钥（主公钥 --- pub，全部子公钥 --- sub）；

--export-secret-keys，导出私钥（主私钥 --- sec，全部子私钥 --- ssb）；这个选项导出的东西，应该找个地方藏起来，比如加密U盘、保险箱、保险库、有军队把守必须生物识别的严密机构！

--export-secret-subkeys，使用自己的私钥的正确的做法，仅仅导出全部子私钥！当然，还是要加密（并且验证签名）传输到其他电脑上，再导入。

``` bash
gpg --export -o 1.pub -a  -- User1

gpg --export-ssh-key -o 2c.ssh 4E157C9F0CCE6C01
```

### 子密钥管理



```
$ gpg2 --expert --edit-key <KEY ID>
gpg> addkey
```

- addkey 添加子密钥
- adduser 添加用户名



## faq


#### 重新发布公钥证书
什么情况下，需要重新发布公钥证书？

#### gpg-agent


#### 导出SSH 格式的公钥
导出 SSH 格式的公钥，并上传到服务器

```
gpg --export-ssh-keys 64810DE8 > ~/.ssh/gpg_subkey.pub

ssh-copy-id -i ~/.ssh/gpg_subkey.pub 
```

## help


```

admin@kvm MINGW64 ~/Desktop
$ gpg --help
gpg (GnuPG) 2.2.11-unknown
libgcrypt 1.8.4
Copyright (C) 2018 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <https://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.

Home: /c/Users/admin/.gnupg
Supported algorithms:
Pubkey: RSA, ELG, DSA, ECDH, ECDSA, EDDSA
Cipher: IDEA, 3DES, CAST5, BLOWFISH, AES, AES192, AES256, TWOFISH,
        CAMELLIA128, CAMELLIA192, CAMELLIA256
Hash: SHA1, RIPEMD160, SHA256, SHA384, SHA512, SHA224
Compression: Uncompressed, ZIP, ZLIB, BZIP2

Syntax: gpg [options] [files]
Sign, check, encrypt or decrypt
Default operation depends on the input data

Commands:

 -s, --sign                  make a signature
     --clear-sign            make a clear text signature
 -b, --detach-sign           make a detached signature
 -e, --encrypt               encrypt data
 -c, --symmetric             encryption only with symmetric cipher
 -d, --decrypt               decrypt data (default)
     --verify                verify a signature
 -k, --list-keys             list keys
     --list-signatures       list keys and signatures
     --check-signatures      list and check key signatures
     --fingerprint           list keys and fingerprints
 -K, --list-secret-keys      list secret keys
     --generate-key          generate a new key pair
     --quick-generate-key    quickly generate a new key pair
     --quick-add-uid         quickly add a new user-id
     --quick-revoke-uid      quickly revoke a user-id
     --quick-set-expire      quickly set a new expiration date
     --full-generate-key     full featured key pair generation
     --generate-revocation   generate a revocation certificate
     --delete-keys           remove keys from the public keyring
     --delete-secret-keys    remove keys from the secret keyring
     --quick-sign-key        quickly sign a key
     --quick-lsign-key       quickly sign a key locally
     --sign-key              sign a key
     --lsign-key             sign a key locally
     --edit-key              sign or edit a key
     --change-passphrase     change a passphrase
     --export                export keys
     --send-keys             export keys to a keyserver
     --receive-keys          import keys from a keyserver
     --search-keys           search for keys on a keyserver
     --refresh-keys          update all keys from a keyserver
     --import                import/merge keys
     --card-status           print the card status
     --edit-card             change data on a card
     --change-pin            change a card's PIN
     --update-trustdb        update the trust database
     --print-md              print message digests
     --server                run in server mode
     --tofu-policy VALUE     set the TOFU policy for a key

Options:

 -a, --armor                 create ascii armored output
 -r, --recipient USER-ID     encrypt for USER-ID
 -u, --local-user USER-ID    use USER-ID to sign or decrypt
 -z N                        set compress level to N (0 disables)
     --textmode              use canonical text mode
 -o, --output FILE           write output to FILE
 -v, --verbose               verbose
 -n, --dry-run               do not make any changes
 -i, --interactive           prompt before overwriting
     --openpgp               use strict OpenPGP behavior

(See the man page for a complete listing of all commands and options)

Examples:

 -se -r Bob [file]          sign and encrypt for user Bob
 --clear-sign [file]        make a clear text signature
 --detach-sign [file]       make a detached signature
 --list-keys [names]        show keys
 --fingerprint [names]      show fingerprints

Please report bugs to <https://bugs.gnupg.org>.
```