
# sysfs、udev 和 它们背后的 Linux 统一设备模型

2017-10-08 12:39

本文发自 [http://www.binss.me/blog/sysfs-udev-and-Linux-Unified-Device-Model/](https://www.binss.me/blog/sysfs-udev-and-Linux-Unified-Device-Model/)，转载请注明出处。

## 引子 —— sysfs 诞生之前

一切皆文件，这是 Linux 的哲学之一。设备当然也不例外，它们往往被抽象成文件，存放在 `/dev` 目录下供用户进程进行操作。用户通过这些设备文件，可以实现对硬件进行相应的操作。而这些设备文件，需要由对应的设备文件系统来负责管理。

在 kernel 2.6 之前，完成这一使命的是 devfs。devfs 是 Linux 2.4 引入的一个虚拟的文件系统，挂载在 `/dev` 目录下。可以动态地为设备在 `/dev` 下创建或删除相应的设备文件，只生成存在设备的节点。

然而它存在以下缺点：

- 可分配的设备号数目 (major / minor) 受到限制
- 设备映射不确定，一个设备所对应的设备文件可能发生改变
- 设备名称在内核或模块中写死，违反了内核开发的原则
- 缺乏热插拔机制

随着 kernel 的发展，从 Linux 2.6 起，devfs 被 sysfs + udev 所取代。sysfs + udev 在设计哲学和现实中的易用性都比 devfs 更优，自此 sysfs + udev 的组合走上 mainline ，直至目前(4.9.40)，依然作为 Linux 的设备管理手段。

## sysfs

sysfs 是一个基于内存的虚拟的文件系统，由 kernel 提供，挂载到 /sys 目录下(用 mount 查看得到 `sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)`)，负责以设备树的形式向 user space 提供直观的设备和驱动信息。

sysfs 以不同的视角展示当前系统接入的设备：

- /sys/block 历史遗留问题，存放块设备，提供以设备名 (如 sda) 到 / sys/devices 的符号链接

- /sys/bus 按总线类型分类，在某个总线目录之下可以找到连接该总线的设备的符号链接，指向 / sys/devices。

  某个总线目录之下的 drivers 目录包含了该总线所需的所有驱动的符号链接

  对应 kernel 中的 struct bus_type

- /sys/class 按设备功能分类，如输入设备在 /sys/class/input 之下，图形设备在 /sys/class/graphics 之下，是指向 /sys/devices 目录下对应设备的符号链接

  对应 kernel 中的 struct class

- /sys/dev 按设备驱动程序分层(字符设备 / 块设备)，提供以 major:minor 为名到 /sys/devices 的符号链接

  对应 kernel 中的 struct device_driver

- /sys/devices 包含所有被发现的注册在各种总线上的各种物理设备。

  所有的物理设备都按其在总线上的拓扑结构来显示，除了 platform devices 和 system devices 。

  platform devices 一般是挂在芯片内部高速或者低速总线上的各种控制器和外设，能被 CPU 直接寻址。

  system devices 不是外设，他是芯片内部的核心结构，比如 CPU，timer 等，他们一般没有相关的 driver，但是会有一些体系结构相关的代码来配置他们

  对应 kernel 中的 struct device

- /sys/firmware 提供对固件的查询和操作接口(关于固件有专用于固件加载的一套 API)。

- /sys/fs 描述当前加载的文件系统，提供文件系统和文件系统已挂载设备信息。

- /sys/hypervisor 如果开启了 Xen，这个目录下会提供相关属性文件。

- /sys/kernel 提供 kernel 所有可调整参数，但大多数可调整参数依然存放在 sysctl(/proc/sys/kernel)。

- /sys/module 所有加载模块 (包括内联、编译进 kernel、外部的模块) 的信息，按模块类型分类。

- /sys/power 电源选项，可用于控制整个机器的电源状态，如写入控制命令进行关机、重启等。

sysfs 支持多视角查看，通过符号链接，同样的信息可以出现在多个目录下。

以硬盘 sda 为例，既可以在块设备目录 `/sys/block/` 下找到，又可以在所有设备目录 `/sys/devices/pci0000:00/0000:00:10.0/host32/target32:0:0/` 下找到，

查看 sda1 设备目录下的内容：

```
$ ll /sys/block/sda/
drwxr-xr-x 11 root root    0 Feb  3 04:32 ./
drwxr-xr-x  3 root root    0 Feb  3 04:32 ../
-r--r--r--  1 root root 4096 Feb  3 04:32 alignment_offset
lrwxrwxrwx  1 root root    0 Feb  3 04:32 bdi -> ../../../../../../../virtual/bdi/8:0/
-r--r--r--  1 root root 4096 Feb  3 04:32 capability
-r--r--r--  1 root root 4096 Feb  3 04:32 dev
lrwxrwxrwx  1 root root    0 Feb  3 04:32 device -> ../../../2:0:0:0/
-r--r--r--  1 root root 4096 Feb  3 04:32 discard_alignment
-r--r--r--  1 root root 4096 Feb  3 04:32 events
-r--r--r--  1 root root 4096 Feb  3 04:32 events_async
-rw-r--r--  1 root root 4096 Feb  3 04:32 events_poll_msecs
-r--r--r--  1 root root 4096 Feb  3 04:32 ext_range
drwxr-xr-x  2 root root    0 Feb  3 04:32 holders/
-r--r--r--  1 root root 4096 Feb  3 04:32 inflight
drwxr-xr-x  2 root root    0 Feb  3 04:32 integrity/
drwxr-xr-x  2 root root    0 Feb  3 04:32 power/
drwxr-xr-x  3 root root    0 Feb  3 04:32 queue/
-r--r--r--  1 root root 4096 Feb  3 04:32 range
-r--r--r--  1 root root 4096 Feb  3 04:32 removable
-r--r--r--  1 root root 4096 Feb  3 04:32 ro
drwxr-xr-x  5 root root    0 Feb  3 04:32 sda1/
drwxr-xr-x  5 root root    0 Feb  3 04:32 sda2/
drwxr-xr-x  5 root root    0 Feb  3 04:32 sda5/
-r--r--r--  1 root root 4096 Feb  3 04:32 size
drwxr-xr-x  2 root root    0 Feb  3 04:32 slaves/
-r--r--r--  1 root root 4096 Feb  3 04:32 stat
lrwxrwxrwx  1 root root    0 Feb  3 04:32 subsystem -> ../../../../../../../../class/block/
drwxr-xr-x  2 root root    0 Feb  3 04:32 trace/
-rw-r--r--  1 root root 4096 Feb  3 04:32 uevent
```

目录以文件的形式提供了设备的信息，比如 `dev` 记录了主设备号和次设备号，`size` 记录了分区大小，`uevent` 存放了 uevent 的标识符等：

```
$ cat /sys/block/sda/size
41943040
```

## 统一设备模型

sysfs 的功能基于 Linux 的统一设备模型，其由以下结构构成：

### kobject

统一设备模型中最基本的对象。

```
struct kobject {
    const char      *name;                      // 名称，将在 sysfs 中作为文件名
    struct list_head    entry;                  // 加入 kset 链表的结构
    struct kobject      *parent;                // 父节点指针，构成树状结构
    struct kset     *kset;                      // 指向所属 kset
    struct kobj_type    *ktype;                 // 类型
    struct kernfs_node  *sd;                    // 指向所属 (sysfs) 目录项
    struct kref     kref;                       // 引用计数
#ifdef CONFIG_DEBUG_KOBJECT_RELEASE
    struct delayed_work release;
#endif
    unsigned int state_initialized:1;           // 是否已经初始化
    unsigned int state_in_sysfs:1;              // 是否已在 sysfs 中显示
    unsigned int state_add_uevent_sent:1;       // 是否已经向 user space 发送 ADD uevent
    unsigned int state_remove_uevent_sent:1;    // 是否已经向 user space 发送 REMOVE uevent
    unsigned int uevent_suppress:1;             // 是否忽略上报(不上报 uevent)
};
```

其中， kobj_type 结构如下：

```
struct kobj_type {
    void (*release)(struct kobject *kobj);      // 析构函数，kobject 的引用计数为 0 时调用
    const struct sysfs_ops *sysfs_ops;          // 操作函数，当用户读取 sysfs 属性时调用 show()，写入 sysfs 属性时调用 store()
    struct attribute **default_attrs;           // 默认属性，体现为该 kobject 目录下的文件
    const struct kobj_ns_type_operations *(*child_ns_type)(struct kobject *kobj);   // namespace 操作函数
    const void *(*namespace)(struct kobject *kobj);
};
```

实际上这里实现的类似于对 kobject 的派生，包含不同 kobj_type 的 kobject 可以看做不同的子类。通过实现相同的函数来实现多态。在这的设计下，每一个内嵌 Kobject 的数据结构(如 kset、device、device_driver 等)，都要实现自己的 kobj_type ，并实现其中的函数。

kobj_type 的定义会如实地在 sysfs 中反应，其中的属性 attribute 会以 attribute.name 为文件名在该目录下创建文件，对该文件进行读写会调用 sysfs_ops 中定义的 show() 和 store()

### kset

kobject 的容器，维护了其包含的 kobject 链表，链表的最后一项执向 kset.kobj 。用于表示某一类型的 kobject 。

```
// kobject.h
struct kset {
    struct list_head list;                      // kobject 链表头
    spinlock_t list_lock;                       // 自旋锁，保障操作安全
    struct kobject kobj;                        // 自身的 kobject
    const struct kset_uevent_ops *uevent_ops;   // uevent 操作函数集。kobject 发送 uevent 时会调用所属 kset 的 uevent_ops
};
```

注意和 kobj_type 的关联，kobject 会利用成员 kset 找到自已所属的 kset，设置自身的 ktype 为 kset.kobj.ktype 。当没有指定 kset 成员时，才会用 ktype 来建立关系。

此外，kobject 调用的是它所属 kset 的 uevent 操作函数来发送 uevent，如果 kobject 不属于任何 kset ，则无法发送 uevent。

### device / driver / bus / class

Linux 设备模型的更上一层表述是 device / driver / bus / class 。它们都定义在 include/linux/device.h 中

#### device

device 描述了一项设备，对应的数据结构 device

```
struct device {
    struct device       *parent;


    struct device_private   *p;


    struct kobject kobj;
    const char      *init_name; /* initial name of the device */
    const struct device_type *type;


    struct mutex        mutex;  /* mutex to synchronize calls to
                     * its driver.
                     */


    struct bus_type *bus;       /* type of bus device is on */
    struct device_driver *driver;   /* which driver has allocated this
                       device */
    ...
    struct class        *class;
    ...
};
```

其中维护了类型为 device_private 的指针 p ：

```
struct device_private {
    struct klist klist_children;
    struct klist_node knode_parent;
    struct klist_node knode_driver;
    struct klist_node knode_bus;
    struct list_head deferred_probe;
    struct device *device;
};
```

klist_node 用来作为在所属 driver 链表、所属 bus 链表等中的节点。

设备通过 device_register 来注册到系统中，通过 device_unregister 来从系统中卸载。

#### driver

设备依赖于 driver 来进行驱动，对应的数据结构为 device_driver

```
struct device_driver {
    const char      *name;                      // 驱动名称
    struct bus_type     *bus;                   // 驱动管理设备挂接的总线类型


    struct module       *owner;
    const char      *mod_name;  /* used for built-in modules */


    bool suppress_bind_attrs;   /* disables bind/unbind via sysfs */
    enum probe_type probe_type;


    const struct of_device_id   *of_match_table;
    const struct acpi_device_id *acpi_match_table;


    int (*probe) (struct device *dev);  // 相关函数，统一接口
    int (*remove) (struct device *dev);
    void (*shutdown) (struct device *dev);
    int (*suspend) (struct device *dev, pm_message_t state);
    int (*resume) (struct device *dev);
    const struct attribute_group **groups;


    const struct dev_pm_ops *pm;


    struct driver_private *p;
};
```

其中维护了类型为 driver_private 的指针 p ：

```
struct driver_private {
    struct kobject kobj;
    struct klist klist_devices;
    struct klist_node knode_bus;
    struct module_kobject *mkobj;
    struct device_driver *driver;
};
```

其维护了 driver 自身的私有属性，比如由于它也是 kobject 的子类，因此包含了 kobj 。可通过 driver_create_file / driver_remove_file 来增删属性，属性将直接作用于 p->kobj 。

#### bus

设备总是插在某一条总线上的，对应的数据结构为 bus_type

```
struct bus_type {
    const char      *name;                      // 总线名称
    const char      *dev_name;                  // 该总线下设备的前缀名称
    struct device       *dev_root;
    struct device_attribute *dev_attrs; /* use dev_groups instead */
    const struct attribute_group **bus_groups;
    const struct attribute_group **dev_groups;
    const struct attribute_group **drv_groups;


    int (*match)(struct device *dev, struct device_driver *drv);
    int (*uevent)(struct device *dev, struct kobj_uevent_env *env);
    int (*probe)(struct device *dev);
    int (*remove)(struct device *dev);
    void (*shutdown)(struct device *dev);


    int (*online)(struct device *dev);
    int (*offline)(struct device *dev);


    int (*suspend)(struct device *dev, pm_message_t state);
    int (*resume)(struct device *dev);


    const struct dev_pm_ops *pm;


    const struct iommu_ops *iommu_ops;


    struct subsys_private *p;
    struct lock_class_key lock_key;
};
```

其中维护了类型为 subsys_private 的指针 p ：

```
struct subsys_private {
    struct kset subsys;
    struct kset *devices_kset;
    struct list_head interfaces;
    struct mutex mutex;


    struct kset *drivers_kset;
    struct klist klist_devices;
    struct klist klist_drivers;
    struct blocking_notifier_head bus_notifier;
    unsigned int drivers_autoprobe:1;
    struct bus_type *bus;


    struct kset glue_dirs;
    struct class *class;
};
```

其维护了 bus 自身的私有属性，它维护了 挂接在该总线上的设备集合 devices_kset 和 与该总线相关的驱动程序集合 drivers_kset 。

对应到 sysfs 中，每个 bus_type 对象都对应 /sys/bus 目录下的一个子目录。子目录下必有 devices 和 drivers 文件夹，里面存放指向相应设备和驱动的符号链接。

#### class

此 class 并非 C++ 中的关键字 class ，而是用于表示一种设备分类，对应的数据结构为 class

```
struct class {
    const char      *name;                          // 设备分类名
    struct module       *owner;                     // 所属模块


    struct class_attribute      *class_attrs;
    const struct attribute_group    **dev_groups;
    struct kobject          *dev_kobj;


    int (*dev_uevent)(struct device *dev, struct kobj_uevent_env *env);
    char *(*devnode)(struct device *dev, umode_t *mode);


    void (*class_release)(struct class *class);
    void (*dev_release)(struct device *dev);


    int (*suspend)(struct device *dev, pm_message_t state);
    int (*resume)(struct device *dev);
    int (*shutdown)(struct device *dev);


    const struct kobj_ns_type_operations *ns_type;
    const void *(*namespace)(struct device *dev);


    const struct dev_pm_ops *pm;


    struct subsys_private *p;
};
```

class 只是一种抽象的概念，用于描述接口相似的一类设备。其存在的意义主要是方便用户能够基于设备的功能进行快速的定位，而不必通过思索设备所处的位置、连接方式等来定位设备。

#### 小结

device / driver / bus / class 四者之间存在着这样的关系：

driver 用于驱动 device ，其保存了所有能够被它所驱动的设备链表。

bus 是连接 CPU 和 device 的桥梁，其保存了所有挂载在它上面的设备链表和驱动这些设备的驱动链表。

class 用于描述一类 device ，其保存了所有该类 device 的设备链表。

### attribute

用于定义设备模型中的各项属性。基本属性有两种，分别为普通属性 attribute 和二进制属性 bin_attribute

```
struct attribute {
    const char      *name;              // 属性名
    umode_t         mode;
#ifdef CONFIG_DEBUG_LOCK_ALLOC
    bool            ignore_lockdep:1;
    struct lock_class_key   *key;
    struct lock_class_key   skey;
#endif
};


struct bin_attribute {
    struct attribute    attr;
    size_t          size;
    void            *private;
    ssize_t (*read)(struct file *, struct kobject *, struct bin_attribute *,
            char *, loff_t, size_t);
    ssize_t (*write)(struct file *, struct kobject *, struct bin_attribute *,
             char *, loff_t, size_t);
    int (*mmap)(struct file *, struct kobject *, struct bin_attribute *attr,
            struct vm_area_struct *vma);
};
```

使用 attribute 生成的 sysfs 文件，只能用字符串的形式读写。而 struct bin_attribute 在 attribute 的基础上，增加了 read、write 等函数，因此它所生成的 sysfs 文件可以用任何方式读写。

类似于 bin_attribute ，我们可以用包含 attribute 的方式对 attribute 进行扩展("继承")，定义出 device_attribute 、 class_attribute 或一些设备自定义属性(比如 cpuidle_driver_attr) 等。

### attribute_group

顾名思义就是属性组，将一组属性打包成一个对象，其包含了以 attribute 和 bin_attribute 指针数组。

```
struct attribute_group {
    const char      *name;
    umode_t         (*is_visible)(struct kobject *,
                          struct attribute *, int);
    umode_t         (*is_bin_visible)(struct kobject *,
                          struct bin_attribute *, int);
    struct attribute    **attrs;
    struct bin_attribute    **bin_attrs;
};
```

## sysfs 映射

sysfs 本质上是对 统一设备模型 中各结构的映射。这在前文对统一设备模型的叙述中也略有提到。换句话说，sysfs 本质上就是通过 VFS 的接口去读写 kobject 的层次结构后动态建立的内存文件系统。

让我们来看下代码。

```
int __init sysfs_init(void)
{
    int err;


    sysfs_root = kernfs_create_root(NULL, KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
                    NULL);
    if (IS_ERR(sysfs_root))
        return PTR_ERR(sysfs_root);


    sysfs_root_kn = sysfs_root->kn;


    err = register_filesystem(&sysfs_fs_type);
    if (err) {kernfs_destroy_root(sysfs_root);
        return err;
    }


    return 0;
}
```

从代码实现上看出，当前版本的 sysfs 实际上基于 kernfs 实现。kernfs 是 kernel 3.14 引入的内存文件系统。相比先前的 sysfs，和 VFS 分离，并解决了死锁的老大难问题。在 [sysfs: separate out kernfs](https://lwn.net/Articles/571590/) 一文中，Tejun 将 sysfs 的逻辑层和表示层分离。其中，专门负责创建伪文件系统的表示层被单独拿出来作为 kernfs，从而让其能作为独立组件供其他模块使用。比如 cgroup 从 3.15 起全面转向使用 kernfs，虽然 patch 的提交者同样是 Tejun。

sysfs_init 通过 kernfs_create_root 创建新的 kernfs 层级，然后将其保存在静态全局变量中，供各处使用。然后通过 register_filesystem 将其注册为名为 sysfs 的文件系统。

根据 mount 命令(`sysfs on /sys type sysfs (rw,nosuid,nodev,noexec,relatime)`，该文件系统被挂载到 /sys 目录下，因此 sysfs 的目录和文件都在此目录下。

### 目录映射

kobject 在 sysfs 中对应的是目录(dir)。

当我们注册一个 kobject 时，会调用 kobject_add 。于是

```
kobject_add => kobject_add_varg => kobject_add_internal => create_dir => sysfs_create_dir_ns
```

如果 kobj 有 parent ，则它的父节点为 kobj->parent->sd ，否则为根目录节点 sysfs_root_kn 。于是将其作为参数调用 `kernfs_create_dir_ns(parent, kobject_name(kobj), S_IRWXU | S_IRUGO | S_IXUGO, kobj, ns);` 在父节点目录下创建一个名为 kobj->name 的目录。

由于 sysfs 属于 kernfs ，因此最后调用 kernfs_create_dir_ns 来创建目录。

### 属性映射

属性 在 sysfs 中对应的是文件(file)。

当需要为设备添加属性时，可以调用 device_create_file ，于是：

device_create_file => sysfs_create_file => sysfs_create_file_ns => sysfs_add_file_mode_ns => `__kernfs_create_file` 为属性创建文件，并根据 kobj->ktype->sysfs_ops 为文件绑定对应的读写函数。

创建的文件大小即为存放该属性值的长度，对于普通属性来说，大小为 PAGE_SIZE(4K)，而对于二进制属性来说，大小由属性自定义，即 bin_attribute.size 指定。

当用户对属性文件进行读写时，会调用绑定的读写函数，比如对于 mode 为 SYSFS_PREALLOC 且 kobj->ktype->sysfs_ops 定义了 show 和 store 函数的属性，绑定是 sysfs_prealloc_kfops_rw 。这里的 kobj 指的是该属性的父节点，也就是属性所属设备的 kobj。

于是在读文件时，调用 sysfs_kf_read ，它会根据属性文件找到其父节点类型对应的 sysfs_ops ，然后调用 sysfs_ops.show 。show 需要将输出写到传入的 buf 缓冲区中，并返回写入的长度。

在写文件时，调用 sysfs_kf_write ，它会根据属性文件找到其父节点类型对应的 sysfs_ops ，然后调用 sysfs_ops.store 。 store 可以从传入的 buf 缓冲区中，读取用户写入的长度为 len 的内容。

但是需要注意的是， sysfs_ops 中的 show 和 store 函数并非是读写我们属性所需要的 show 和 store 。因为一个设备只有一个类型，因此 sysfs_ops 打扰 show 和 store 只有一种实现，但实际上 show 和 store 应该根据属性的不同而不同。怎么办呢？绕个弯子：在调用 sysfs_ops.show 和 sysfs_ops.store 时传入属性 attribute 的指针，然后在函数中将指针转换为设备类型对应属性的指针后调用属性的 show 和 store 函数。这也就是 device_attribute 、 class_attribute 或一些设备自定义属性(比如 cpuidle_driver_attr) 中定义有 show 和 store 函数的原因。

### 小结

Linux 的设备模型在 sysfs 体现为：

- Kernel Objects: 目录
- Object Atrributes: 文件(文件内容为属性值)
- Object Relationships: 链接文件

当一个 kobject 被创建并注册的时候，/sys 目录下对应的文件和目录同时被创建。

## uevent

在引子中提到，从 Linux 2.6 起，devfs 被 sysfs + udev 所取代。我们已经知道 sysfs 就是 Linux 统一设备模型的体现，那么 udev 是什么呢？

先贴定义。

udev 是从 Linux 2.6 一直沿用至今的设备管理器，挂载并管理着 `/dev` 。和 devfs 不同的是，它运行在用户态中，允许用户进行自定义配置，并根据配置在收到事件时在 `/dev` 下创建设备文件。

主要由三部分组成：

- libudev 函数库，提供获取设备信息的接口。已集成到 systemd 中

- udevd 处于 user namespace 的管理软件。管理 / dev 下的设备文件。已集成到 systemd 中

  包括以下内容：

  - udisks 通过 dbus 提供对存储设备的访问接口。
  - upower 通过 dbus 提供电源管理的接口。
  - NetworkManager 通过 dbus 提供网络配置的接口。

- udevadm 命令行工具。可用来向 udevd 发送指令。

### udevd

udevd 是 udev 机制的核心。负责动态在 `/dev` 下创建设备文件。

在系统启动时，udev 扫描 sysfs ，然后根据规则创建相应的设备文件。

在之后的运行过程中，udevd 监听设备的热插拔事件 uevent 。在 kernel 编译时，会产生一些类似 modules.usbmap, modules.alias (位于 `/lib/modules//` ) 的文件，用来告知用户态程序在特定设备插入时应该加载什么驱动 / 模块。

当热插拔设备插入时，base platform driver(usb-core, pci, etc) 会产生一个 uevent (此时相应设备在 `/sys` 下的描述文件信息已更新)，包含值为 add 的 ACTION (拔出时为 remove) 和其他环境变量如 idVendor, idProduct, name, subsystem 等，描述了该设备的制造厂商、设备类别和 id 等，由设备驱动负责提供。该 uevent 通过 netlink socket 发送给位于用户态的守护进程 udevd。于是 udevd 会尝试匹配位于 `/etc/udev/rules.d/` 和 `/lib/udev/rules.d/` 目录下的规则，如果匹配，则执行对应的脚本，进行相应的处理，如动态地在 `/dev` 下创建或删除设备文件。

当存储设备通过 USB 连接时，udevd 会通知 udisksd-daemon 去处理，挂载该设备。

当网线插入时，udevd 会通知 NetworkManager-daemon 去进行相应的 IP 配置(dhclient)。

举个例子：

1. 创建 udev 规则文件 /etc/udev/rules.d/81-usb-keyboard.rules ，内容如下：

   ```
   ACTION=="add", ATTRS{name}=="*Keyboard*", SUBSYSTEMS=="input", SYMLINK+="my_kbd" RUN+="/sbin/insmod /my_kbd.ko"
   ```

2. 当该 usb keyboard 插入时，收到 uevent ：

   ```
   ACTION = add
   name =  xxxx-Keyboard-xxxx
   subsystems = input
   idVendor = xxxx
   idProduct = xxxx
   ```

3. udevd 根据 uevent 匹配规则，发现 /etc/udev/rules.d/81-usb-keyboard.rules 匹配，因此运行该规则，创建一个设备的符号链接 /dev/my_kbd ，指向真正的设备，同时加载 my_kbd.ko 模块。

4. 继续匹配规则，凡是符合的规则都会被运行

#### 确定性设备映射

前文提到，devfs 会按顺序给设备分配设备号和设置设备名，使得设备的命名依赖于设备的加载 (插入) 顺序，这次的 sda1 ，可能在下次就成了 sdb1 。导致无法确定某一个设备，比如我在引导菜单设置了根设备为 `/dev/sdb1` ，而下次启动时它变成 `/dev/sda1` 了，导致挂载失败，无法进行系统。

为了解决这个问题，udev 提供了三种命名方式：by-id，by-label，by-uuid

```
$ ll /dev/disk/by-id
total 0
drwxr-xr-x 2 root root 220 May 16 18:48 ./
drwxr-xr-x 7 root root 140 May 16 18:48 ../
lrwxrwxrwx 1 root root   9 May 16 18:48 ata-PLDS_DVD+_-RW_DS-8ABSH_3N3MNPLC007316GS5A04 -> ../../sr0
lrwxrwxrwx 1 root root   9 May 16 18:48 scsi-35000039848408c69 -> ../../sda
lrwxrwxrwx 1 root root  10 May 16 18:48 scsi-35000039848408c69-part1 -> ../../sda1
lrwxrwxrwx 1 root root  10 May 16 18:48 scsi-35000039848408c69-part2 -> ../../sda2
lrwxrwxrwx 1 root root  10 May 17 15:33 scsi-35000039848408c69-part3 -> ../../sda3
lrwxrwxrwx 1 root root   9 May 16 18:48 wwn-0x5000039848408c69 -> ../../sda
lrwxrwxrwx 1 root root  10 May 16 18:48 wwn-0x5000039848408c69-part1 -> ../../sda1
lrwxrwxrwx 1 root root  10 May 16 18:48 wwn-0x5000039848408c69-part2 -> ../../sda2
lrwxrwxrwx 1 root root  10 May 17 15:33 wwn-0x5000039848408c69-part3 -> ../../sda3




$ ll /dev/disk/by-path
total 0
drwxr-xr-x 2 root root 140 May 16 18:48 ./
drwxr-xr-x 7 root root 140 May 16 18:48 ../
lrwxrwxrwx 1 root root   9 May 16 18:48 pci-0000:00:1f.2-ata-6 -> ../../sr0
lrwxrwxrwx 1 root root   9 May 16 18:48 pci-0000:03:00.0-scsi-0:0:0:0 -> ../../sda
lrwxrwxrwx 1 root root  10 May 16 18:48 pci-0000:03:00.0-scsi-0:0:0:0-part1 -> ../../sda1
lrwxrwxrwx 1 root root  10 May 16 18:48 pci-0000:03:00.0-scsi-0:0:0:0-part2 -> ../../sda2
lrwxrwxrwx 1 root root  10 May 17 15:33 pci-0000:03:00.0-scsi-0:0:0:0-part3 -> ../../sda3


$ ll /dev/disk/by-uuid/
total 0
drwxr-xr-x 2 root root 100 May 16 18:48 ./
drwxr-xr-x 7 root root 140 May 16 18:48 ../
lrwxrwxrwx 1 root root  10 May 17 15:33 3805bf9a-3c21-489f-89c0-7c7d28cf92a0 -> ../../sda3
lrwxrwxrwx 1 root root  10 May 16 18:48 7B3C-F069 -> ../../sda1
lrwxrwxrwx 1 root root  10 May 16 18:48 dd3ae5f6-6b76-417d-91ac-43b42c7fe361 -> ../../sda2
```

udev 会根据物理设备的 id / uuid / 总线路径 来识别设备，并为它们在 `/dev` 下创建对应的设备文件。也就是说，设备的名称不依赖于设备插入的时间，是确定的。

#### 用户态动态创建 / 移除设备文件

udev 运行在用户态，脱离驱动层的关联，基于这种设计实现，用户可以通过编写规则来动态删除和修改 `/dev` 下的设备文件，任意命名设备。

每当 udevd 收到 uevent 时就会去匹配规则，一旦匹配上了，执行规则对应的操作。重要软件的 rule 存放在 `/lib/udev/rules.d/` 下，用户自定义的规则放到 `/etc/udev/rules.d/` 下，以 rules 为扩展名。命名规则类似于 grub 脚本，udev 将按数字前缀从小到大进行匹配，依次生效。

匹配主要基于几个字段：

- SUBSYSTEM：设备类型
- ACTION：设备触发的操作，如 add/change/remove
- ATTR / ATTRS：设备的属性，如 class/vendor/ro/removable/size 等等，这些属性其实都能在 `/sys` 下对应的文件读出来。
- KERNEL：kernel 对设备的命名。如 sd*/input*
- ENV：环境设置，用来在多个 rule 之间传递信息

可用于以下用途：

- 设置环境变量(有后续事件需要使用)
- 在 /dev 下创建设备的别名(符号链接)
- 运行特定的指令

### 原理

在这里我们不关心 udev 的具体实现，只关心一个问题：当设备插入 / 拔出时，udevd 为何会收到一个相应的 uevent ？这个 uevent 是谁发出的？

我们在 kobject 系列函数中发现了 kobject_uevent 函数，其负责向 user space 发送 uevent 。

根据文档：

> After a kobject has been registered with the kobject core, you need to announce to the world that it has been created. This can be done with a call to kobject_uevent()> Use the KOBJ_ADD action for when the kobject is first added to the kernel. This should be done only after any attributes or children of the kobject have been initialized properly, as userspace will instantly start to look for them when this call happens.

因此发送 uevent 的时机在设备注册之后，即在 sysfs 中出现设备及其属性信息之后。驱动程序需要负责调用 kobject_uevent 来发送 uevent 。

#### kobject_uevent => kobject_uevent_env

```
=> 获取 kobject 所属的 kset ，如果该 kobject 不属于某个 kset ，则一级一级向上 (parent) 查找
=> 如果 kobj->uevent_suppress 为 true ，表示不发送 uevent ，返回
=> 如果 kset.uevent_ops 定义了 filter ，调用之进行过滤
=> 获取 kset 的名称，如果没有，由于无法提供 uevent 所需的 SUBSYSTEM 信息，返回
=> 初始化环境变量结构 kobj_uevent_env
=> 调用 add_uevent_var 往 kobj_uevent_env 添加环境变量，包括 ACTION / DEVPATH / SUBSYSTEM / 参数传入的其他变量
=> 调用 kset.uevent_ops->uevent 添加 kset 想发送的环境变量
=> 根据 kobject_action 设置 kobj->state_add_uevent_sent 或 kobject->state_remove_uevent_sent 表示已发送
=> 如果内核参数 CONFIG_NET=y，调用 netlink_broadcast_filtered 使用 netlink 发送该 uevent 。参数 portid 为 0， group 为 1 ，表示发送给用户空间的所有进程
=> 如果指定了内核参数 CONFIG_UEVENT_HELPER_PATH ，通过调用 kmod 的 call_usermodehelper 上报。即创建一个进程执行 CONFIG_UEVENT_HELPER_PATH 对应的用户态程序，把 uevent 信息设置为它的环境变量
```

kobj_uevent_env 定义如下，最多支持 UEVENT_NUM_ENVP 个变量，总长度不能超过 UEVENT_BUFFER_SIZE ：

```
#define UEVENT_NUM_ENVP         32  /* number of env pointers */
#define UEVENT_BUFFER_SIZE      2048    /* buffer for the variables */


struct kobj_uevent_env {char *argv[3];
    char *envp[UEVENT_NUM_ENVP];    // 用于保存环境变量地址的指针数组，最多 32 个
    int envp_idx;                   // 访问环境变量指针数组的索引
    char buf[UEVENT_BUFFER_SIZE];   // 保存环境变量的 buffer，最大为 2048
    int buflen;                     // 当前 buf 长度
};
```

uevent 支持的事件类型如下：

```
enum kobject_action {
    KOBJ_ADD,       // 添加
    KOBJ_REMOVE,    // 移除
    KOBJ_CHANGE,    // 状态变化
    KOBJ_MOVE,      // 更改名称或者更改 Parent
    KOBJ_ONLINE,    // 上线
    KOBJ_OFFLINE,   // 下线
    KOBJ_MAX
};
```

驱动可以根据需要在适当时候发送对应类型的 uevent。

根据：

```
static int uevent_net_init(struct net *net)
{
    struct uevent_sock *ue_sk;
    struct netlink_kernel_cfg cfg = {
        .groups = 1,
        .flags  = NL_CFG_F_NONROOT_RECV,
    };


    ue_sk = kzalloc(sizeof(*ue_sk), GFP_KERNEL);
    if (!ue_sk)
        return -ENOMEM;


    ue_sk->sk = netlink_kernel_create(net, NETLINK_KOBJECT_UEVENT, &cfg);
    if (!ue_sk->sk) {printk(KERN_ERR"kobject_uevent: unable to create netlink socket!\n");
        kfree(ue_sk);
        return -ENODEV;
    }
    mutex_lock(&uevent_sock_mutex);
    list_add_tail(&ue_sk->list, &uevent_sock_list);
    mutex_unlock(&uevent_sock_mutex);
    return 0;
}
```

处于用户态的 udevd 只需创建一个 family 为 AF_NETLINK ， protocol 为 NETLINK_KOBJECT_UEVENT 的 socket ，然后监听并接收该地址的的消息即可。

此外，从代码中可以发现，除了通过 netlink 方式告知用户态的 udevd 外，kernel 还能通过创建一个环境变量为 uevent 内容的用户态进程 (通常就是 udev)，然后该进程就会根据环境变量，检查 sysfs ，然后进行相应的操作，如创建设备文件等，实现通知的目的。用户态程序的行为可以参考 busybox 中的 mdev (udev 的简化版) 中的实现，主要在 `util-linux/mdev.c:mdev_main` 。

## 题外话 -- devtmpfs

按照前面的叙述，我们的 `/dev` 文件夹应该是一个 tmpfs ，里面的设备节点由 udevd 收到 kernel 发来的 uevent 后根据 sysfs 和 规则动态创建。然而实际上 `/dev` 的文件系统类型却是 devtmpfs ：

```
udev on /dev type devtmpfs (rw,nosuid,relatime,size=32840592k,nr_inodes=8210148,mode=755)
```

这是什么？根据源码信息，它是 09 年由 Kay Sievers 引入的一个 patch ：

> devtmpfs - kernel-maintained tmpfs-based /dev Devtmpfs lets the kernel create a tmpfs instance called devtmpfs very early at kernel initialization, before any driver-core device is registered. Every device with a major/minor will provide a device node in devtmpfs.

而目前主流发型版的 kernel 似乎都把该选项作为了默认选项：

```
binss@giantvm:~/work/GDB-Kernel$ grep CONFIG_DEVTMPFS .config
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
```

怎么样，是不是很惊喜？devfs 思想又回来啦！

为什么会这样呢？我们都知道，udev 拥有各种各样的优点，这些前文也已经叙述过了。但是其有一个致命的缺点——慢。想象一下，设备节点要经过以下流程才能创建：

用户的 udevd 进行初始化 - 遍历 sysfs / 接收 uevent 信息 - 动态创建设备节点

在设备节点创建完成之前，其他用户态程序几乎不能动。因此这部分时间都被算入是启动时间，这并不是一个小数目，最长可高达几秒。这对于嵌入式系统 (尤其是移动端系统如安卓) 来说是难以接受了。

怎么办呢，只能复古一波，重新让 kernel 来创建设备节点，用户态只需进行 mount 即可，不需要 udev 参与了。根据作者叙述，它还是比 devfs 要高得多的：

> devtmpfs is a much simpler scheme, which really adds very little to the kernel. The implementation is around 300 lines of code, in comparison to roughly 3600 for devfs and 600 for an early version of Richter's mini-devfs.

当然，对于那些需要动态创建的设备节点，依然可以留给 udev 来创建：

> Devtmpfs can be changed and altered by userspace at any time, and in any way needed - just like today's udev-mounted tmpfs.> Unmodified udev versions will run just fine on top of it, and will recognize an already existing kernel-created device node and use it.

## 后记

之所以写下本文，是因在搬砖过程中遇到了和设备热插拔相关的问题，需要了解相关机制，因此一番搜索摘抄，文章喜加一。

实际上 Linux 的设备模型十分复杂，几天下来我还只是略懂皮毛，但由于搬砖关系，暂且放下，待今后要写驱动什么乱七八糟的东西的时候，再作深入学习。

## 参考

https://lwn.net/Articles/331818/

http://www.wowotech.net/device_model/kobject.html

https://www.quora.com/How-is-the-hot-plugging-mechanism-achieved-with-the-platform-devices-in-the-Linux-Kernel