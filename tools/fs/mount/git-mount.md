# git-mount
### git-mount
`C:\Program Files\Git\usr\bin\mount.exe`:

```
$ mount --help
Usage: mount [OPTION] [<win32path> <posixpath>]
       mount -a
       mount <posixpath>

Display information about mounted filesystems, or mount a filesystem

  -a, --all                     mount all filesystems mentioned in fstab
  -c, --change-cygdrive-prefix  change the cygdrive path prefix to <posixpath>
  -f, --force                   force mount, don't warn about missing mount
                                point directories
  -h, --help                    output usage information and exit
  -m, --mount-entries           write fstab entries to replicate mount points
                                and cygdrive prefixes
  -o, --options X[,X...]        specify mount options
  -p, --show-cygdrive-prefix    show user and/or system cygdrive path prefix
  -V, --version                 output version information and exit

Valid options are: acl,auto,binary,bind,cygexec,dos,exec,ihash,noacl,nosuid,notexec,nouser,override,posix=0,posix=1,sparse,text,user

```
### demo

``` bash
mount -o binary,noacl,auto H:/ /mnt/h
mount -o binary,noacl,auto G:/ /mnt/g

mount -o binary,noacl,auto E:/Dataset /h/tmp/mdemo
```
注意： 该挂载在windows的文件系统下看不出变化，只有通过sftp这种协议转换，才能看出路径映射的变化。


```
$ mount
E:/Dataset on /h/tmp/mdemo type ntfs (binary,user)
C:/Program Files/Git on / type ntfs (binary,noacl,auto)
C:/Program Files/Git/usr/bin on /bin type ntfs (binary,noacl,auto)
C:/Users/admin/AppData/Local/Temp on /tmp type ntfs (binary,noacl,posix=0,usertemp)
C: on /c type ntfs (binary,noacl,posix=0,user,noumount,auto)
D: on /d type ntfs (binary,noacl,posix=0,user,noumount,auto)
```