# mount

mount 
`mount [选项] <源> <目录>`

说明：
[挂载点]必须是一个已经存在的目录，这个目录可以不为空，但挂载后这个目录下以前的内容将不可用，umount以后会恢复正常。
[设备名称] 可以是一个分区，一个usb设备，光驱，软盘，网络共享等。

常见参数：
-t vfstype 挂载指定的设备类型
-o options	指定挂载系统选项：多个选项可以用","分割.某些选项只有在出现在文件 /etc/fstab 中时才有意义。下列选项可以用于任何要挂载的文件系统(但是并非所有文件系统都关心它们，例如，选项 sync 在今天只对 ext2，ext3 和 ufs 有效)
        ro	以只读方式挂载; 
        rw	以读写方式挂载
        codepage	codepage=XXX代码页
        username	username=user 访问设备的用户名
        password	password=pass 访问设备的密码

-f	测试mount系统，只检查设备和目录，并不真正挂载文件系统
-l	列出所有已经挂载的文件系统列表

## help
```
(base) root@devel:~/Project/tmp$ mount --help

用法：
 mount [-lhV]
 mount -a [选项]
 mount [选项] [--source] <源> | [--target] <目录>
 mount [选项] <源> <目录>
 mount <操作> <挂载点> [<目标>]

挂载文件系统。

选项：
 -a, --all               挂载 fstab 中的所有文件系统
 -c, --no-canonicalize   不对路径规范化
 -f, --fake              空运行；跳过 mount(2) 系统调用
 -F, --fork              对每个设备禁用 fork(和 -a 选项一起使用)
 -T, --fstab <路径>      /etc/fstab 的替代文件
 -i, --internal-only     不调用 mount.<type> 辅助程序
 -l, --show-labels       也显示文件系统标签
 -n, --no-mtab           不写 /etc/mtab
 -o, --options <列表>    挂载选项列表，以英文逗号分隔
 -O, --test-opts <列表>  限制文件系统集合(和 -a 选项一起使用)
 -r, --read-only         以只读方式挂载文件系统(同 -o ro)
 -t, --types <列表>      限制文件系统类型集合
     --source <源>       指明源(路径、标签、uuid)
     --target <目标>     指明挂载点
 -v, --verbose           打印当前进行的操作
 -w, --rw, --read-write  以读写方式挂载文件系统(默认)

 -h, --help              display this help
 -V, --version           display version

源：
 -L, --label <标签>      同 LABEL=<label>
 -U, --uuid <uuid>       同 UUID=<uuid>
 LABEL=<标签>            按文件系统标签指定设备
 UUID=<uuid>             按文件系统 UUID 指定设备
 PARTLABEL=<标签>        按分区标签指定设备
 PARTUUID=<uuid>         按分区 UUID 指定设备
 <设备>                  按路径指定设备
 <目录>                  绑定式挂载的挂载点(参阅 --bind/rbind)
 <文件>                  用于设置回环设备的常规文件

操作：
 -B, --bind              挂载其他位置的子树(同 -o bind)
 -M, --move              将子树移动到其他位置
 -R, --rbind             挂载其他位置的子树及其包含的所有子挂载(submount)
 --make-shared           将子树标记为 共享
 --make-slave            将子树标记为 从属
 --make-private          将子树标记为 私有
 --make-unbindable       将子树标记为 不可绑定
 --make-rshared          递归地将整个子树标记为 共享
 --make-rslave           递归地将整个子树标记为 从属
 --make-rprivate         递归地将整个子树标记为 私有
 --make-runbindable      递归地将整个子树标记为 不可绑定

更多信息请参阅 mount(8)。
```


## misc
```
root@devel:~/tmp$ sudo mount ./bcd ./abc
mount:./abc: ./bcd is not a block device.
```


mkdir /media/csy/sdb5 -p
mount /dev/sdb5 /media/csy/sdb5