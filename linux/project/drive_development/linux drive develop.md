# linux drive develop


## demo

### while query
对于单任务架构，可以简单地使用设备轮询方法。
``` cpp
int serialInt = 0;  // 串口中断标志
int keyInt = 0; // 按键中断标志
int main(int argc, char* argv[])
{
    while (1)
    {
         if (serialInt == 1)
         {
             ProcessSerialInt();
             serialInt = 0;
         }
         if (keyInt == 1)
         {
             ProcessKeyInt();
             keyInt = 0;
         }
         status = CheckXXX();
         switch (status)
         {
             ...
         }
    }
}

```
### no os 
serial.h
``` cpp
extern void SerialInit(void);
extern void SerialSend(const char buf*, int count);
extern void SerialRecv(char buf*, int count);
```
serial.c
``` cpp
void SerialInit(void)
{
    
}
void SerialSend(const char buf*, int count){
    
}
void SerialRecv(char buf*, int count){
    
}
void SerialIsr(void)
{
    // ...
    serialInt = 1;
}

```
### with linux 
``` cpp


```

## arch

确保无操作系统的架构是 
- 应用软件
- 设备驱动
- 硬件

有操作系统的架构是：
- 应用程序
- 操作系统api
- 操作系统
    - 设备通用接口
    - 设备驱动的硬件操作
- 硬件

避免 用户应用程序中，直接嵌入驱动操作语句。

设备分类：
- 字符设备 chrdev 字符设备只能串行依次访问
- 快设备        块设备可以随机访问，以块为操作单位
- 网络设备


## led demo

### s

当系统开启了硬件MMU，需要ToVirtual()  来吧寄存器的物理地址转化成虚拟地址。
``` cpp
#define reg_gpio_ctrl *(volatile int *) (ToVirtual（GPIO_REG_CTRL))
#define reg_gpio_data *(volatile int *) (ToVirtual（GPIO_REG_CTRL))
void LightInit(void)
{
    reg_gpio_ctrl |= （1 《《 你）；
}
void LightOn(void)
{

    reg_gpio_dat |= (1 << n);
}
void LightOff(void)
{
    reg_gpio_dat &= ~ (1 << n);
}
```

### linux LED drive
``` cpp
struct light_dev{
    struct cdev cdev;
    unsigned char value;
}

int light_major = LIGHT_MAJOR;
struct light_dev *light_devp;

int light_open(struct inode*inode, struct file * filp)
{

}
int light_release(struct inode*inode, struct file * filp);

ssize_t light_read(struct file * filp, char __user *buf, size_t count, loff_t * f_pos);
ssize_t light_write(struct file * filp, const char __user *buf, size_t count, loff_t * f_pos);
int light_ioctl(struct inode*inode, struct file * filp, unsigned int cmd, unsigned long arg);

struct file_operations light_fops = {
    .owner = 
    .read = light_read,
    .write = light_wriite,
    .ioctl = light_ioctl,
    .open = light_open,
    .release = light_release,
}

static void light_setup_cdev(struct light_dev *dev,int index)
{
    int err, devno = MKDEV(light_major, index);
    cdev_init(&dev->cdev, &light_fops);
    dev->cdev.owner = THIS_MODULE;
    dev->cdev.ops = &light_fops;
    cdev_add(&dev->cdev, devno, 1);
}

int light_init(void){
    dev_t dev = MKDEV(light_major, 0);
    if (light_major)
        result = register_chrdev_region(dev, 1, "LED");
    else{
        result = alloc_chrdev_region(&dev, 0, 1, "LED");
        light_major = MAJOR(dev);
    }

    light_devp= kmalloc(sizeof(struct lightdev), GFP_KERNEL);
    memset(light_devp, 0, sizeof(struct light_dev));
    light_setup_cdev(light_devp, 0);
}
void light_cleanup(void){
    cdev_del(&light_devp->cdev);
    kfree(light_devp);
    unregister_chrdev_region(MKDEV(light_major, 0), 1);
}

module_init(light_init);
module_exit(light_cleanup);
```

light_open/light_release/light_read/light_write 都是 SPI 函数
light_fops 记录了对应的SPI函数。

module_init 登记了 模块的初始化函数
moduel_exit 登记了 模块的释放函数

对应步骤
1. 创建字符设备
2. 分配内存
3. 分配结构内容

## kernel coding

### demo
``` cpp
#include <linux/init.h>
#include <linux/module.h>

static int __init hello_init(void)
{
    printk(KERN_INFO "hello world enter\n");
    return 0;
}
moduel_init(hello_init);

static void __exit hello_exit(void)
{
    printk(KERN_INFO "hello world exit\n");
}
moduel_exit(hello_exit);

MODULE_LICENSE("GPL v2");
MODUEL_DESCRIPTION("");
MODULE_AUTHOR("");
MODULE_ALIAS("a simplest module");

```

### moduel
模块包括
- 加载函数
    - 模块参数
    - 导出符号  对应 /proc/kallsyms
- 卸载函数

### include

#### struct file
``` cpp
struct file{
    struct inode *f_inode;
    struct path f_path;
    const struct file_operations * f_op;
    spinlock_t f_lock;
    atomic_long_t f_count;
    unsigned int f_flags; // RDONLY, NONBLOCK, SYNC
    loff_t f_pos;
    fmode_t     f_mode; // READ, write
    struct mutex f_pos_lock;
    void *private_data;
    struct fown_struct f_owner;
}

```
#### struct inode 
VFS inode 包含文件访问的权限，属组，大小，生成时间，访问时间，写入时间。是linux 管理文件系统的基本单位
``` cpp
struct inode{
    uid_t i_uid;
    gid_t i_gid;
    umode_t i_mode; // inode对应权限
    dev_t i_rdev;   // 设备对应的设备编号
    struct timespec i_atime;    // 访问时间
    struct timespec i_mtime;    // 修改时间
    struct timespec i_ctime;    // 创建时间
    
    unsigned int i_blkbits;
    blkcnt_t i_blocks;

    union{
        struct blick_device *i_bdev;    // 块设备对应指针
        struct cdev *i_cdev;    // 字符设备对应的指针
    }
};
```
#### dev number
dev设备号共有32位，分为高12位和低20位，对应 minor 和 major
``` cpp
MKDEV(int major, int minor)

int register_chrdev_region(dev_t from , unsigned count, const char *name);

int alloc_chrdev_region(dev_t *dev , unsigned baseminor, unsigned count, const char *name);

int unregister_chrdev_region(dev_t from , unsigned count);
```

register_chrdev_region alloc_chrdev_region 都可以分配设备号，
register_chrdev_region 适用于已知初始设备号的情况，
适用于设备号未知，系统动态分配设备号


#### struct file_operations
``` cpp
struct file_operations{
    loff_t (*llseek) (struct file*, loff_t, int);
    ssize_t (*read) (struct file * filp, char __user *buf, size_t count, loff_t * f_pos);
    ssize_t (*write)(struct file * filp, const char __user *buf, size_t count, loff_t * f_pos);
    unsigned int (*poll)(struct file*, struct *);
    (*mmap)();
    long (*unlocked_ioctl)(struct file*, unsigned int, unsigned long);
};
```

file_operations 相当于 cdev类的重载函数。

#### struct cdev
``` cpp
struct cdev{
    struct kobject kobj;
    struct module *owner;
    struct file_operations *ops;
    struct list_head list;
    dev_t dev;
    unsigned int count;
};
```
cdev 可以理解成 dev开发的基类，


``` cpp
// 相当于cdev的初始化函数
void cdev_init(struct cdev *cdev, struct file_operations *fops))
{
    memset(cdev, 0, sizeof(struct cdev));
    INIT_LIST_HEAD(&cdev->list);
    kobject_init(&cdev->kobj, &ktype_cdev_default);
    cdev->ops = fops;
}
struct cdev* cdev_alloc(void){

}
```
#### private_data

file.private_data 相当于 cdev的 私有数据（子类数据）

如果设备不唯一，使用 private_data 可以轻易扩展成多设备的情况。
``` cpp
#define DEVICE_NUM 10
sttic int globalmem_open(struct inode *inode, struct file*filp)
{
    struct globalmem_dev *dev = container_of(inode->i_cdev, struct globalmem_dev, cdev);
    filp->private_data = dev;
    return 0;
}
static int  __init globalmem_init(void)
{
    register_chrdev_region(devno, DEVICE_NUM, "globalmem");
    for (i=0;i<DEVICE_NUM;i++)
        globalmem_setup_cdev(global_devp+i, i);
    

}
static void __exit globalmem_exit(void)
{
    for (i = 0;i<DEVICE_NUM; i++)
        cdev_del(&(globalmem_devp + i)->cdev);
    //
    unregister_chrdev_region(MKDEV(globalmem_major, 0), DEVICE_NUM);
}
```

### sysfs
### udev & devfs
### tools

lsmod ~~ /proc/modules   /sys/module
insmod
modprobe
depmod 
modinfo
/proc/devices
### funcs
``` cpp
copy_from_user();
copy_to_user();

```
### gcc out-of-order 

编译器可能吧c代码编译
### arm cpu instruction

```
ldrex
strex
dmb
dsb
wfe
sev

```
### atom  operation
``` cpp
// atom set
// atom read
// atom add/sub
// atom self increase/decrease
atomic_dec_and_test
atomic_inc_and_test

```


``` python
def atomic_dec_and_test(x):
    x -= 1
    if x == 0:
        return True
    else:
        x += 1
        return False
```

``` cpp
static atomic_t xx_available = ATOMIC_INIT(1);

static int xxx_open()
{
    if (!atomic_dec_and_test(&xxx_available)){
        atomic_inc(&xxx_available);
        return -1;
    }
    return 0;
}

static int xxx_release(){
    atomic_inc(&xxx_available);
    return 0;
}
```

### spin lock

#### rwlock
#### seqlock
### RCU
read-copy-update
#### semaphore
### mutex
