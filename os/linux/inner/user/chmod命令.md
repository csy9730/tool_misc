# chmod
## chmod


Linux系统上对文件的权限有着严格的控制，用于如果相对某个文件执行某种操作，必须具有对应的权限方可执行成功。
Linux下文件的权限类型一般包括读，写，执行。对应字母为 r、w、x。
Linux下权限的粒度有 拥有者 、群组 、其它组 三种。每个文件都可以针对三个粒度，设置不同的rwx(读写执行)权限。通常情况下，一个文件只能归属于一个用户和组， 如果其它的用户想有这个文件的权限，则可以将该用户加入具备权限的群组，一个用户可以同时归属于多个组。
Linux上通常使用chmod命令对文件的权限进行设置和更改。

**chmod命令**用来变更文件或目录的权限。在UNIX系统家族里，文件或目录权限的控制分别以读取、写入、执行3种一般权限来区分，另有3种特殊权限可供运用。用户可以使用chmod指令去变更文件与目录的权限，设置方式采用文字或数字代号皆可。符号连接的权限无法变更，如果用户对符号连接修改权限，其改变会作用在被连接的原始文件。


### help
``` 
abc@ubuntu:/home/abc $ chmod --help
Usage: chmod [OPTION]... MODE[,MODE]... FILE...
  or:  chmod [OPTION]... OCTAL-MODE FILE...
  or:  chmod [OPTION]... --reference=RFILE FILE...
Change the mode of each FILE to MODE.
With --reference, change the mode of each FILE to that of RFILE.

  -c, --changes          like verbose but report only when a change is made
  -f, --silent, --quiet  suppress most error messages
  -v, --verbose          output a diagnostic for every file processed
      --no-preserve-root  do not treat '/' specially (the default)
      --preserve-root    fail to operate recursively on '/'
      --reference=RFILE  use RFILE's mode instead of MODE values
  -R, --recursive        change files and directories recursively
      --help     display this help and exit
      --version  output version information and exit

Each MODE is of the form '[ugoa]*([-+=]([rwxXst]*|[ugo]))+|[-+=][0-7]+'.

GNU coreutils online help: <http://www.gnu.org/software/coreutils/>
Full documentation at: <http://www.gnu.org/software/coreutils/chmod>
or available locally via: info '(coreutils) chmod invocation'
```


`chmod [-cfvR] [--help] [--version] mode file...`

其他参数([-cfvR]): 指定chmod的其他参数
权限模式(mode)：指定文件的权限模式；
文件(file)：要改变权限的文件。

其他参数说明：
```
-c,--changes：效果类似“-v”参数，但仅回报更改的部分
-f,--quiet,--silent：不显示错误信息
-R,--recursive：递归处理，将指令目录下的所有文件及子目录一并处理
-v,--verbose：显示指令执行过程
--reference=<参考文件或目录>：把指定文件或目录的所属群组全部设成和参考文件或目录的所属群组相同；
--help : 显示辅助说明
--version : 显示版本

<权限范围>+<权限设置>：开启权限范围的文件或目录的该选项权限设置；
<权限范围>-<权限设置>：关闭权限范围的文件或目录的该选项权限设置；
<权限范围>=<权限设置>：指定权限范围的文件或目录的该选项权限设置；
```


### mode权限
权限范围的表示法如下：

`u` User，即文件或目录的拥有者；
`g` Group，即文件或目录的所属群组；
`o` Other，除了文件或目录拥有者或所属群组之外，其他用户皆属于这个范围；
`a` All，即全部的用户，包含拥有者，所属群组以及其他用户；

`r` 读取权限，数字代号为“4”;
`w` 写入权限，数字代号为“2”；
`x` 执行或切换权限，数字代号为“1”；
`-` 不具任何权限，数字代号为“0”；
`s` 特殊功能说明：变更文件或目录的权限。
`X` 表示只有当该文件是个子目录或者该文件已经被设定过为可执行。

`+` 表示增加权限
`-` 表示取消权限
`=` 表示唯一设定权限。

### 十位权限码

后九位解析： 我们知道Linux权限总共有三个属组，这里我们给每个属组使用三个位置来定义三种操作（读、写、执行）权限，合起来则是权限的后九位。 上面我们用字符表示权限，其中 -代表无权限，r代表读权限，w代表写权限，x代表执行权限。
```
-rw------- (600)      只有拥有者有读写权限。
-rw-r--r-- (644)      只有拥有者有读写权限；而属组用户和其他用户只有读权限。
-rwx------ (700)     只有拥有者有读、写、执行权限。
-rwxr-xr-x (755)    拥有者有读、写、执行权限；而属组用户和其他用户只有读、执行权限。
-rwx--x--x (711)    拥有者有读、写、执行权限；而属组用户和其他用户只有执行权限。
-rw-rw-rw- (666)   所有用户都有文件读、写权限。
-rwxrwxrwx (777)  所有用户都有读、写、执行权限。
```

```
d代表的是目录(directroy)
-代表的是文件(regular file)
s代表的是套字文件(socket)
p代表的管道文件(pipe)或命名管道文件(named pipe)
l代表的是符号链接文件(symbolic link)
b代表的是该文件是面向块的设备文件(block-oriented device file)
c代表的是该文件是面向字符的设备文件(charcter-oriented device file)
```
#### 文件特殊权限
文件特殊权限：SUID、SGID、SBIT
setuid：SUID，全称为set UID，在高位起第三位上表现为s。

当我们普通用户使用passwd进行修改密码的时候，passwd会去访问/etc/shadow，但是普通用户根本没有读写的权限，那怎么办呢？linux在我们运行passwd修改密码的时候，会暂时获取/etc/shadow文件拥有者root的权限，然后对/etc/shadow进行读写访问，访问完之后释放文件拥有者的权限。这就是setuid的魅力。简单来说就是，使用者暂时获取文件(目录)拥有者的权限，使用完再释放。

setgid：SGID和SUID类似，在高起第六位上表现为s。

SGID改变的是执行者的所属组，可以对可执行文件和目录设置。通过对目录设置SGID属性，可以使得访问在该目录下创建的所有文件的所有权，都继承原目录的所有者，而非创建者。因为一旦有用户进入到该目录下，由于具有SGID权限，进入目录后的用户就会变成该目录的所有者，在该目录下创建的所有文件，都以该目录的所有者的身份创建。

利用好这个权限位在很多团队合作的项目上更加方便管理。比如一个共同维护的数据文件夹，为了方便管理，只允许管理员对里面的数据具有改变和删除的权利，但是却有很多用户需要有在该目录下添加数据文件的权利，利用SGID可以很好的解决这一点。

``` bash
chmod u+s filename 	# 设置suid位
chmod u-s filename 	# 去掉suid设置
chmod g+s filename 	# 设置sgid位
chmod g-s filename 	# 去掉sgid设置
```

stick bit：SBID权限同样只对目录有效，在权限位的最低位表现为t。

通过对目录设置SBID权限，并且该目录的权限为777，则所有用户可以在该目录下都可以创建文件，并且文件所有者是自己。但是在SBID权限的目录下，只有root和文件的所有者才能删除该文件，即使文件的属性为777也不能被其他用户删除。这个权限在共享过程中非常实用。共享的文件任何人都有读写的权利，但是只有文件的所有者才能删除该文件。

SUID/SGID/SBIT权限设置

SUID数值为4，SGID数值为2，SBIT数值为1，umask中默认权限中的从左往右第1个值为SUID/SGID/SBIT权限。
### 实例 

Linux用 户分为：拥有者、组群(Group)、其他（other）

``` bash
chmod u+x,g+w afile # 为文件f01设置自己可以执行，组员可以写入的权限
chmod u=rwx,g=rw,o=r afile
chmod 764 afile
chmod a+x afile # 对文件f01的u,g,o都设置可执行属性
```

文件的属主和属组属性设置

``` bash
chown user:market afile # 把文件f01给uesr，添加到market组
ll -d afile   # 查看目录f1的属性
```

[文件权限属性设置](https://man.linuxde.net/sub/文件权限属性设置)
## chown

```
chmod 755 目录　　　　//以root的视角去修改当前目录的权限

chown -R ftp用户名:组名 目录　　//组名可不写，修改目录所属者
```

## chattr
chattr命令
chattr命令
用于设置文件的隐藏属性
语法格式：chattr [选项] 文件
同时还有在命令后追加"+“和”-"的，在上一篇博客有相关介绍。
常用选项：

i：无法对文件进行修改；若对目录设置了该参数，则仅能修改其中的子文件内容而不能新建或删除文件。
a：仅允许补充（追加）内容，无法覆盖/删除内容（Append only）

## lsattr
lsattr命令
用于显示文件的隐藏属性。在Linux系统中，文件的隐藏权限必须使用lsattr命令来查看。
语法格式：lsattr [选项] 文件
（使用此命令，文件被赋予的隐藏权限会全部显示出来。此时，可以按照显示的隐藏权限的类型，使用chattr命令将其去掉）