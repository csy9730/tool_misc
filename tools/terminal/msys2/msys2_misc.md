# msys2

## pacman-key
#### pacman gpg signature error
```
Suddenly pacman no longer trusts:

(1/1) checking keys in keyring                     [######################] 100%
downloading required keys...
:: Import PGP key 2048D/A47D45A1, "Alexey Pavlov (Alexpux) <alexpux@gmail.com>", created: 2013-11-10? [Y/n] y
(1/1) checking package integrity                   [######################] 100%
error: mingw-w64-x86_64-libpng: signature from "Alexey Pavlov (Alexpux) <alexpux@gmail.com>" is unknown trust
:: File /var/cache/pacman/pkg/mingw-w64-x86_64-libpng-1.6.12-1-any.pkg.tar.xz is corrupted (invalid or corrupted package (PGP signature)).
Do you want to delete it? [Y/n] n
```

应该是gpg指纹过期了，需要更新本地的gpg指纹。
解决办法
- 更新本地的gpg指纹
- 关闭本地的gpg警告，

更新 msys2.gpg 公钥
``` bash
pacman-key --init
pacman-key --populate msys2
# ==> 正在从 msys2.gpg 添加密匙...
# ==> 正在更新可信数据库...
# gpg: 不需要检查信任度数据库


pacman-key --refresh-keys
```


解决了，具体方法是
打开msys2的/etc/pacman.conf，在文件的中上部分找到一个叫“SigLevel”的选项（不是在下面[core]那里的）在=号的后面修改为 Never 保存，例如：
``` ini
SigLevel = Never
```
就搞定了。


以上方法还是太麻烦，建议直接重装最新版的msys2，新版本的直接内置最新版本仓库的gpg指纹。

#### pacman source

利用Windows资源管理器，打开D:\msys64\etc\pacman.d。在这个路径下有3个配置文件，分别为：mirrorlist.mingw32、mirrorlist.mingw64和mirrorlist.msys。

更新源
修改mirrorlist.msys
利用UltraEdit或者类似工具打开这mirrorlist.msys文件。在最上面，注意是最上面增加
```
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/msys/$arch
```
修改mirrorlist.mingw32
在最上面增加
```
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/i686
```
修改mirrorlist.mingw64
在最上面增加
```
Server = https://mirrors.tuna.tsinghua.edu.cn/msys2/mingw/x86_64
```
应用更新
重新运行D:\msys64\msys2.exe。然后再运行好的环境中输入下列命令，更新即可。现在真的是速度飞快。
```
pacman -Syu
```

#### git-crypt

```
pacman -S git-crypt
```

```
$ ldd /usr/bin/git-crypt.exe
        ntdll.dll => /c/Windows/SYSTEM32/ntdll.dll (0x7ffa8e270000)
        KERNEL32.DLL => /c/Windows/System32/KERNEL32.DLL (0x7ffa8c5f0000)
        KERNELBASE.dll => /c/Windows/System32/KERNELBASE.dll (0x7ffa8ba80000)
        msys-2.0.dll => /usr/bin/msys-2.0.dll (0x180040000)
        msys-stdc++-6.dll => /usr/bin/msys-stdc++-6.dll (0x5e5aa0000)
        msys-gcc_s-seh-1.dll => /usr/bin/msys-gcc_s-seh-1.dll (0x170000)
        msys-gcc_s-seh-1.dll => /usr/bin/msys-gcc_s-seh-1.dll (0x5e8160000)
        msys-crypto-3.dll => not found

```

#### msys-crypto-3.dll
msys-crypto-3.dll 对应 openssl，属于系统的基础依赖，老版本是1.1，2.0，20年后来更新到3.0版本。

```
pacman -Syu openssl
```
#### msys2-devel
MSYS2 自带的开发环境，安装的包叫 msys2-devel
```
pacman -S msys2-devel
```


结果安装了gcc
```
gcc 11.3.0-3
cmake 3.23.2-1
```