# misc

## Can't install ndk-sysroot

```
Ign:1 https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable InRelease
Ign:2 https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games InRelease
Ign:3 https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science InRelease
Hit:4 https://mirrors.tuna.tsinghua.edu.cn/termux/termux-packages-24 stable Release
Hit:5 https://mirrors.tuna.tsinghua.edu.cn/termux/game-packages-24 games Release
Hit:6 https://mirrors.tuna.tsinghua.edu.cn/termux/science-packages-24 science Release
Reading package lists... Done
Building dependency tree
Reading state information... Done
53 packages can be upgraded. Run 'apt list --upgradable' to see them.
Reading package lists... Dones
Building dependency tree
Reading state information... Done
You might want to run 'apt --fix-broken install' to correct these.
The following packages have unmet dependencies:
 libllvm : Depends: ndk-sysroot but it is not installed
E: Unmet dependencies. Try 'apt --fix-broken install' with no packages (or specify a solution).
```

```
➜  sources.list.d  apt-get autoremove
Reading package lists... Done
Building dependency tree
Reading state information... Done
You might want to run 'apt --fix-broken install' to correct these.
The following packages have unmet dependencies:
 libllvm : Depends: ndk-sysroot but it is not installed
E: Unmet dependencies. Try 'apt --fix-broken install' with no packages (or specify a solution).
```


```

➜  sources.list.d
➜  sources.list.d  apt-get install -f
Reading package lists... Done
Building dependency tree
Reading state information... Done
Correcting dependencies... Done
The following package was automatically installed and is no longer required:
  libutil
Use 'apt autoremove' to remove it.
The following additional packages will be installed:
  ndk-sysroot
The following NEW packages will be installed:
  ndk-sysroot
0 upgraded, 1 newly installed, 0 to remove and 53 not upgraded.
11 not fully installed or removed.
Need to get 0 B/1514 kB of archives.
After this operation, 17.6 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
(Reading database ... 14008 files and directories currently installed.)
Preparing to unpack .../ndk-sysroot_21d_aarch64.deb ...
Unpacking ndk-sysroot (21d) ...
dpkg: error processing archive /data/data/com.termux/cache/apt/archives/ndk-sysroot_21d_aarch64.deb (--unpack):
 trying to overwrite '/data/data/com.termux/files/usr/lib/libutil.so', which is also in package libutil 0.4-1
dpkg-deb: error: paste subprocess was killed by signal (Broken pipe)
Errors were encountered while processing:
 /data/data/com.termux/cache/apt/archives/ndk-sysroot_21d_aarch64.deb
E: Sub-process /data/data/com.termux/files/usr/bin/dpkg returned an error code (1)
```


```
➜  ~ apt --fix-broken install
Reading package lists... Done
Building dependency tree
Reading state information... Done
Correcting dependencies... Done
The following package was automatically installed and is no longer required:
  libutil
Use 'apt autoremove' to remove it.
The following additional packages will be installed:
  ndk-sysroot
The following NEW packages will be installed:
  ndk-sysroot
0 upgraded, 1 newly installed, 0 to remove and 0 not upgraded.
11 not fully installed or removed.
Need to get 0 B/1514 kB of archives.
After this operation, 17.6 MB of additional disk space will be used.
Do you want to continue? [Y/n] y
(Reading database ... 13570 files and directories currently installed.)
Preparing to unpack .../ndk-sysroot_21d_aarch64.deb ...
Unpacking ndk-sysroot (21d) ...
dpkg: error processing archive /data/data/com.termux/cache/apt/archives/ndk-sysroot_21d_aarch64.deb (--unpack):
 trying to overwrite '/data/data/com.termux/files/usr/lib/libutil.so', which is also in package libutil 0.4-1
dpkg-deb: error: paste subprocess was killed by signal (Broken pipe)
Errors were encountered while processing:
 /data/data/com.termux/cache/apt/archives/ndk-sysroot_21d_aarch64.deb
E: Sub-process /data/data/com.termux/files/usr/bin/dpkg returned an error code (1)
```

`sudo dpkg -i --force-overwrite /data/data/com.termux/cache/apt/archives/ndk-sysroot_21d_aarch64.deb`
然后再使用`sudo apt-get -f install` 即可修复？

最终解决方案：
```
apt purge ndk-sysroot
apt install ndk-sysroot
```

参考：[Can't install ndk-sysroot #5016](https://github.com/termux/termux-packages/issues/5016)
### unable to install boostrape packages



termux 安装之后第一次执行时，会出现对话框阻塞，导致无法输入。

这是termux在后台从谷歌网站下载样式，由于长时间无法下载导致堵塞。
左侧划出session侧边栏，新建新的session即可。
