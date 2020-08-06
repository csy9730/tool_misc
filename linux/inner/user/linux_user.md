# user


## user manager

创建用户，需要配置 
* 用户名
* 用户目录
* 用户组
* 登录shell
* 密码

```
sudo useradd username -m -s /sbin/nologin -d /home/username -g groupname
-s 设置该账户的登录shell，/sbin/nologin属于不能登陆的shell
-d 设置用户主目录
-g 用户组
-m 创建用户目录

sudo useradd abc -m -d /home/abc  
```


``` bash
# 添加用户，设置密码，
sudo useradd username -p password -d /home/username -g groupname

passwd username # 设置密码 或修改密码
userdel -r auser # 递归删除
userdel auser # 删除了/etc/passwd、/etc/shadow、/etc/group/、/etc/gshadow四个文件里的该账户和组的信息

whoami # 查看当前登录用户名

usermod -s /sbin/nologin username # 禁止用户登录
usermod abc -g admin
passwd testuser # 修改用户密码

```



``` bash
groups # 查看当前登录用户的组内成员
groups gliethttp # 查看gliethttp用户所在的组,以及组内成员
groupadd groupname  # 新建 group
```



## help
``` bash
pi@raspberrypi:/ $ useradd --help
Usage: useradd [options] LOGIN
       useradd -D
       useradd -D [options]

Options:
  -b, --base-dir BASE_DIR       base directory for the home directory of the
                                new account
  -c, --comment COMMENT         GECOS field of the new account
  -d, --home-dir HOME_DIR       home directory of the new account
  -D, --defaults                print or change default useradd configuration
  -e, --expiredate EXPIRE_DATE  expiration date of the new account
  -f, --inactive INACTIVE       password inactivity period of the new account
  -g, --gid GROUP               name or ID of the primary group of the new
                                account
  -G, --groups GROUPS           list of supplementary groups of the new
                                account
  -h, --help                    display this help message and exit
  -k, --skel SKEL_DIR           use this alternative skeleton directory
  -K, --key KEY=VALUE           override /etc/login.defs defaults
  -l, --no-log-init             do not add the user to the lastlog and
                                faillog databases
  -m, --create-home             create the user's home directory
  -M, --no-create-home          do not create the user's home directory
  -N, --no-user-group           do not create a group with the same name as
                                the user
  -o, --non-unique              allow to create users with duplicate
                                (non-unique) UID
  -p, --password PASSWORD       encrypted password of the new account
  -r, --system                  create a system account
  -R, --root CHROOT_DIR         directory to chroot into
  -s, --shell SHELL             login shell of the new account
  -u, --uid UID                 user ID of the new account
  -U, --user-group              create a group with the same name as the user
  -Z, --selinux-user SEUSER     use a specific SEUSER for the SELinux user mapping

```


## 查看所有用户

### passwd
/etc/passwd是一个文本文件，其中包含了登录 Linux 系统所必需的每个用户的信息。它保存用户的有用信息，如用户名、密码、用户 ID、群组 ID、用户 ID 信息、用户的家目录和 Shell 。

* 用户名
* 密码
* 用户 ID
* 群组 ID
* 用户 ID 信息
* 用户的家目录
*  Shell 

/etc/passwd 文件的一行代表一个单独的用户。该文件将用户的信息分为 3 个部分

第一部分是 root 账户，这代表管理员账户，对系统的每个方面都有完全的权力。
第二部分是系统定义的群组和账户，这些群组和账号是正确安装和更新系统软件所必需的。
第三部分在最后，代表一个使用系统的真实用户。uid从1000开始

用户在系统中是分角色的，在Linux 系统中，由于角色不同，权限和所完成的任务也不同；值得注意的是用户的角色是通过UID和识别的，特别是UID；在系统管理中，系统管理员一定要坚守UID 唯一的特性；
root 用户：系统唯一，是真实的，可以登录系统，可以操作系统任何文件和命令，拥有最高权限；
虚拟用户：这类用户也被称之为伪用户或假用户，与真实用户区分开来，这类用户不具有登录系统的能力，但却是系统运行不可缺少的用户，比如bin、daemon、adm、ftp、mail等；这类用户都系统自身拥有的，而非后来添加的，当然我们也可以添加虚拟用户；
普通真实用户：这类用户能登录系统，但只能操作自己家目录的内容；权限有限；这类用户都是系统管理员自行添加的；

``` bash
# cat /etc/passwd
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/bin:/sbin/nologin
daemon:x:2:2:daemon:/sbin:/sbin/nologin
adm:x:3:4:adm:/var/adm:/sbin/nologin
lp:x:4:7:lp:/var/spool/lpd:/sbin/nologin
sync:x:5:0:sync:/sbin:/bin/sync
shutdown:x:6:0:shutdown:/sbin:/sbin/shutdown
halt:x:7:0:halt:/sbin:/sbin/halt
mail:x:8:12:mail:/var/spool/mail:/sbin/nologin
ftp:x:14:50:FTP User:/var/ftp:/sbin/nologin
postfix:x:89:89::/var/spool/postfix:/sbin/nologin
sshd:x:74:74:Privilege-separated SSH:/var/empty/sshd:/sbin/nologin
tcpdump:x:72:72::/:/sbin/nologin
2gadmin:x:500:10::/home/viadmin:/bin/bash
apache:x:48:48:Apache:/var/www:/sbin/nologin
zabbix:x:498:499:Zabbix Monitoring System:/var/lib/zabbix:/sbin/nologin
mysql:x:497:502::/home/mysql:/bin/bash
zend:x:502:503::/u01/zend/zend/gui/lighttpd:/sbin/nologin
rpc:x:32:32:Rpcbind Daemon:/var/cache/rpcbind:/sbin/nologin
2daygeek:x:503:504::/home/2daygeek:/bin/bash
named:x:25:25:Named:/var/named:/sbin/nologin
mageshm:x:506:507:2g Admin - Magesh M:/home/mageshm:/bin/bash
```

### /etc/group
/etc/group文件包含所有组
`cat /etc/group` 查看用户组

### /etc/group