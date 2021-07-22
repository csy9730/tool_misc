# ubuntu系统下文件清理

## 1
``` bash
(base) ➜  / df -h |grep G
udev            7.8G     0  7.8G   0% /dev
tmpfs           1.6G  3.8M  1.6G   1% /run
/dev/nvme0n1p7   37G   35G  351M 100% /
tmpfs           7.8G   96M  7.8G   2% /dev/shm
tmpfs           7.8G     0  7.8G   0% /sys/fs/cgroup
/dev/nvme0n1p5  1.9G  169M  1.6G  10% /boot
/dev/sdb2       458G  414G   21G  96% /home
tmpfs           1.6G  140K  1.6G   1% /run/user/1000
/dev/sda1       932G  395G  537G  43% /media/foo/data
/dev/sdb5       466G  400G   66G  86% /media/foo/软件
/dev/nvme0n1p1  178G  143G   36G  81% /media/foo/241450D61450AD14
(base) ➜  /
```


## 2


`du --max-depth=1 -h --exclude=media --exclude=home`

```
cd /
sudo du --max-depth=1 -h --exclude=media --exclude=home

4.0K    ./cdrom
4.0K    ./mnt
1.3G    ./lib
532K    ./root
163M    ./boot
14M     ./bin
4.0K    ./srv
7.7G    ./opt
16K     ./lost+found
du: cannot access './run/user/1000/doc': Permission denied
du: cannot access './run/user/1000/gvfs': Permission denied
3.8M    ./run
18M     ./etc
0       ./sys
4.0K    ./lib64
11G     ./var
15G     ./usr
0       ./dev
8.8G    ./snap
9.4M    ./tmp
12M     ./sbin
du: cannot read directory './proc/10213/task/10213/net': Invalid argument
du: cannot read directory './proc/10213/net': Invalid argument
du: cannot access './proc/16741/task/16741/fd/4': No such file or directory
du: cannot access './proc/16741/task/16741/fdinfo/4': No such file or directory
du: cannot access './proc/16741/fd/3': No such file or directory
du: cannot access './proc/16741/fdinfo/3': No such file or directory
0       ./proc
44G     .
(base) ➜  /

```


``` bash
(base) ➜  / sudo du --max-depth=1 -h --exclude=media --exclude=home 2>/dev/null  |grep G 
1.3G    ./lib
7.7G    ./opt
11G     ./var
15G     ./usr
8.8G    ./snap
44G     .
```

可以发现 var usr和snap的空间占用较大。


### 3
```

(base) ➜  /snap sudo du --max-depth=1 -h 2>/dev/null |grep G
1.1G    ./gnome-3-38-2004
1.1G    ./wps-office-multilang
1.7G    ./gnome-3-34-1804
1.3G    ./gnome-3-28-1804
1.1G    ./gnome-3-26-1604
8.8G    .
```

```

(base) ➜  /var sudo du --max-depth=1 -h 2>/dev/null |grep G
8.0G    ./lib
2.9G    ./log
11G     .
```

```

(base) ➜  /usr sudo du --max-depth=1 -h 2>/dev/null |grep G
5.5G    ./lib
2.3G    ./share
5.6G    ./local
15G     
```

#### snap

```

(base) ➜  /usr snap list --all
Name                  Version                     Rev    Tracking         Publisher           Notes
core                  16-2.51.1                   11316  latest/stable    canonical✓          core
core                  16-2.51                     11187  latest/stable    canonical✓          core,disabled
core18                20210611                    2074   latest/stable    canonical✓          base
core18                20210507                    2066   latest/stable    canonical✓          base,disabled
core20                20210429                    1026   latest/stable    canonical✓          base
gnome-3-26-1604       3.26.0.20210629             104    latest/stable/…  canonical✓          -
gnome-3-26-1604       3.26.0.20210401             102    latest/stable/…  canonical✓          disabled
gnome-3-28-1804       3.28.0-19-g98f9e67.98f9e67  161    latest/stable    canonical✓          -
gnome-3-28-1804       3.28.0-19-g98f9e67.98f9e67  145    latest/stable    canonical✓          disabled
gnome-3-34-1804       0+git.3556cb3               72     latest/stable    canonical✓          -
gnome-3-34-1804       0+git.3556cb3               66     latest/stable    canonical✓          disabled
gnome-3-38-2004       0+git.3d25b9b               39     latest/stable    canonical✓          -
gnome-calculator      3.38.0+git7.c840c69c        826    latest/stable/…  canonical✓          disabled
gnome-calculator      3.38.2+git3.1d166209        884    latest/stable/…  canonical✓          -
gnome-characters      40.0-10-gd54a7df73d         726    latest/stable/…  canonical✓          -
gnome-characters      40.0-9-g14e0faf4d5          723    latest/stable/…  canonical✓          disabled
gnome-logs            3.36.0                      103    latest/stable/…  canonical✓          disabled
gnome-logs            3.36.0                      106    latest/stable/…  canonical✓          -
gnome-system-monitor  40.1-2-ga819fb4b55          163    latest/stable/…  canonical✓          -
gnome-system-monitor  40.1                        160    latest/stable/…  canonical✓          disabled
gtk-common-themes     0.1-52-gb92ac40             1515   latest/stable/…  canonical✓          -
gtk-common-themes     0.1-50-gf7627e4             1514   latest/stable/…  canonical✓          disabled
remmina               v1.4.20+git2.b418a6da4      4978   latest/stable    remmina✓            -
ssh-mitm              0.5.12                      15     latest/stable    ssh-mitm            -
ssh-mitm              0.5.11                      14     latest/stable    ssh-mitm            disabled
termius-app           7.16.0                      80     latest/stable    termius✓            -
wps-office-multilang  10.1.0.6757-multilang       1      latest/stable    schmolli-christian  -
(base) ➜  /usr
```


#### 
```


(base) ➜  /snap dpkg --get-selections |grep linux-image
linux-image-4.15.0-101-generic                  deinstall
linux-image-4.15.0-106-generic                  deinstall
linux-image-4.15.0-108-generic                  deinstall
linux-image-4.15.0-109-generic                  deinstall
linux-image-4.15.0-111-generic                  deinstall
linux-image-4.15.0-112-generic                  deinstall
linux-image-4.15.0-115-generic                  deinstall
linux-image-4.15.0-117-generic                  deinstall
linux-image-4.15.0-118-generic                  deinstall
linux-image-4.15.0-121-generic                  deinstall
linux-image-4.15.0-122-generic                  deinstall
linux-image-4.15.0-123-generic                  deinstall
linux-image-4.15.0-126-generic                  deinstall
linux-image-4.15.0-128-generic                  deinstall
linux-image-4.15.0-129-generic                  deinstall
linux-image-4.15.0-132-generic                  deinstall
linux-image-4.15.0-135-generic                  deinstall
linux-image-4.15.0-136-generic                  deinstall
linux-image-4.15.0-137-generic                  deinstall
linux-image-4.15.0-139-generic                  deinstall
linux-image-4.15.0-140-generic                  deinstall
linux-image-4.15.0-141-generic                  deinstall
linux-image-4.15.0-142-generic                  install
linux-image-4.15.0-143-generic                  deinstall
linux-image-4.15.0-144-generic                  install
linux-image-4.15.0-147-generic                  install
linux-image-4.15.0-29-generic                   deinstall
linux-image-4.15.0-64-generic                   deinstall
linux-image-4.15.0-66-generic                   deinstall
linux-image-4.15.0-76-generic                   deinstall
linux-image-4.15.0-88-generic                   deinstall
linux-image-4.15.0-91-generic                   deinstall
linux-image-4.15.0-96-generic                   deinstall
linux-image-4.15.0-99-generic                   deinstall
linux-image-generic                             install


(base) ➜  /snap uname -a
Linux zal-ubuntu 4.15.0-147-generic #151-Ubuntu SMP Fri Jun 18 19:21:19 UTC 2021 x86_64 x86_64 x86_64 GNU/Linux

sudo apt-get remove linux-image-4.15.0-142-generic  linux-image-4.15.0-106-generic linux-image-4.15.0-108-generic linux-image-4.15.0-109-generic linux-image-4.15.0-111-generic linux-image-4.15.0-112-generic linux-image-4.15.0-115-generic linux-image-4.15.0-117-generic linux-image-4.15.0-118-generic linux-image-4.15.0-121-generic linux-image-4.15.0-122-generic linux-image-4.15.0-123-generic linux-image-4.15.0-126-generic linux-image-4.15.0-128-generic linux-image-4.15.0-129-generic linux-image-4.15.0-132-generic linux-image-4.15.0-135-generic linux-image-4.15.0-136-generic linux-image-4.15.0-137-generic 

```


#### log
清理相关log

由于ubuntu日志文件syslog 和 kern.log 时刻在增长，一会儿就使得根目录文件夹不够用了，需使用如下命令清理 

sudo -i 
然后输入密码，执行： 
```
echo > /var/log/syslog

echo > /var/log/kern.log
```