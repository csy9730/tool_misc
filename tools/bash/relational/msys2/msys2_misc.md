# msys2

## pacman-key
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

``` bash
pacman-key --init
pacman-key --populate msys2
pacman-key --refresh-keys
```


解决了，具体方法是
打开msys2的/etc/pacman.conf，在文件的中上部分找到一个叫“SigLevel”的选项（不是在下面[core]那里的）在=号的后面修改为 Never 保存，例如：
SigLevel = Never
就搞定了。

## pacman source

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