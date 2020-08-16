# misc

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


sudo dpkg -i --force-overwrite /var/cache/apt/archives/python-problem-report_2.0.1-0ubuntu9_all.deb
然后再使用sudo apt-get -f install 即可修复