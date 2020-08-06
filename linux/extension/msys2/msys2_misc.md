# msys2

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