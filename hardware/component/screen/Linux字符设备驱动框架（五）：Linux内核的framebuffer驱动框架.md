# [Linux字符设备驱动框架（五）：Linux内核的framebuffer驱动框架](https://www.cnblogs.com/linfeng-learning/p/9478048.html)





**目录**

- [1. framebuffer简介](https://www.cnblogs.com/linfeng-learning/p/9478048.html#_label0)
- [2. 相关数据结构](https://www.cnblogs.com/linfeng-learning/p/9478048.html#_label1)
- [3. framebuffer驱动框架分析](https://www.cnblogs.com/linfeng-learning/p/9478048.html#_label2)
- [4. fb与应用程序的交互](https://www.cnblogs.com/linfeng-learning/p/9478048.html#_label3)

 

**正文**

/************************************************************************************

*本文为个人学习记录，如有错误，欢迎指正。

*本文参考资料： [
](https://blog.csdn.net/yyplc/article/details/7465569)

*　　　　　　　　[https://www.cnblogs.com/deng-tao/p/6075709.htm](https://www.cnblogs.com/deng-tao/p/6075709.html)l

*　　　　　　　　<https://blog.csdn.net/ultraman_hs/article/details/54985963>[
](https://blog.csdn.net/kokodudu/article/details/17201823)

*　　　　　　　　<https://www.cnblogs.com/xiaojianliu/p/8473095.html>[
](https://www.cnblogs.com/lifexy/p/7542989.html)

*　　　　　　　　<https://blog.csdn.net/qq_28992301/article/details/52727050>

************************************************************************************/

[回到顶部](https://www.cnblogs.com/linfeng-learning/p/9478048.html#_labelTop)

# 1. framebuffer简介

**（1）什么是framebuffer？**

framebuffer，帧缓冲设备（简称fb）是linux内核中虚拟出的一个设备，属于字符设备；它的主设备号为FB_MAJOR = 29，次设备号用来区分内核中不同的framebuffer。Linux内核中最多支持32个framebuffer，设备文件位于/dev/fb*。   

**（2）framebuffer的作用**

framebuffer的主要功能是向应用层提供一个统一标准接口的显示设备。 它将显示设备的硬件结构抽象为一系列的数据结构，应用程序通过framebuffer的读写直接对显存进行操作。用户可以将framebuffer看成是显存的一个映像，将其映射到进程空间后，就可以直接进行读写操作，写操作会直接反映在屏幕上。

对于现代LCD，有一种“多屏叠加”的机制，即一个LCD设备可以有多个独立虚拟屏幕，以达到画面叠加的效果。所以fb与LCD不是一对一的关系，在常见的情况下，一个LCD对应了fb0~fb4。

[回到顶部](https://www.cnblogs.com/linfeng-learning/p/9478048.html#_labelTop)

# 2. 相关数据结构

**（1）struct  fb_info**

Linux内核中使用fb_info结构体变量来描述一个framebuffer，在调用register_framebuffer接口注册framebuffer之前，必须要初始化其中的重要数据成员。

struct  fb_info中成员众多，我们需要着重关注以下成员：

fb_var_screeninfo：代表可修改的LCD显示参数，如分辨率和像素比特数等；

fb_fix_screeninfo：代表不可修改的LCD属性参数，如显示内存的物理地址和长度等；

fb_ops：LCD底层硬件操作接口集。

![img](https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif) struct fb_info

**（2）struct fb_var_screeninfo**

Linux内核中使用struct fb_var_screeninfo来描述可修改的LCD显示参数，如分辨率和像素比特数等。

![img](https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif) struct fb_var_screeninfo

**（3）struct fb_fix_screeninfo**

Linux内核中使用struct fb_fix_screeninfo来描述不可修改的LCD属性参数，如显示内存的物理地址和长度等。

![img](https://images.cnblogs.com/OutliningIndicators/ContractedBlock.gif) struct fb_fix_screeninfo

[回到顶部](https://www.cnblogs.com/linfeng-learning/p/9478048.html#_labelTop)

# 3. framebuffer驱动框架分析

Linux Framebuffer的驱动框架主要涉及以下文件：

1)drivers/video/fbmem.c：主要任务是创建graphics类、注册FB的字符设备驱动（主设备号是29）、提供register_framebuffer接口给具体framebuffer驱动编写着来注册fb设备的；

2)drivers/video/fbsys.c：由是fbmem.c引出来的，处理fb在/sys/class/graphics/fb0目录下的一些属性文件的；

3)drivers/video/modedb.c：由是fbmem.c引出来的，管理显示模式（譬如VGA、720P等就是显示模式）；

4)drivers/video/fb_notify.c：是f由bmem.c引出来的。

**（1）framebuffer的初始化**

Linux内核中将framebuffer的驱动框架实现为模块的形式。framebuffer的初始化函数fbmem_init()被module_init或subsys_initcall修饰，即fbmem_init()会在framebuffer驱动被加载时由Linux内核调度运行。

fbmem_init()函数的主要工作是通过register_chrdev接口向内核注册一个主设备号位29的字符设备。通过class_create在/sys/class下创建graphics设备类，配合mdev机制生成供用户访问的设备文件（位于/dev目录）。



```
static int __init
fbmem_init(void)
{
    proc_create("fb", 0, NULL, &fb_proc_fops);  //向proc文件系统报告驱动状态和参数

    if (register_chrdev(FB_MAJOR,"fb",&fb_fops))//注册字符设备驱动，主设备号是29
        printk("unable to get major %d for fb devs\n", FB_MAJOR);
　　
　　//创建sys/class/graphics设备类，配合mdev生成设备文件
    fb_class = class_create(THIS_MODULE, "graphics");
    if (IS_ERR(fb_class)) {
        printk(KERN_WARNING "Unable to create fb class; errno = %ld\n", PTR_ERR(fb_class));
        fb_class = NULL;
    }
    return 0;
}

#ifdef MODULE
module_init(fbmem_init);
... ...
#else
subsys_initcall(fbmem_init);
#endif
```



**（2）fb_fops**

 在framebuffer的初始化函数fbmem_init()中，调用register_chrdev(FB_MAJOR,"fb",&fb_fops)向内核注册一个主设备号位FB_MAJOR = 29的字符设备，其中fb_fops为fb设备的操作集。



```
static const struct file_operations fb_fops = 
{
    .owner =    THIS_MODULE,
    .read  =    fb_read,
    .write =    fb_write,
    .unlocked_ioctl = fb_ioctl,
    .mmap  =    fb_mmap,
    .open  =    fb_open,
    .release =  fb_release,
    ... ...
};
```



我们着重分析一下fb_fops->fb_open。

假设在注册fb设备过程中生成/dev/input/fb0设备文件，我们来跟踪打开这个设备的过程。

Open(“/dev/input/fb0”)

1）vfs_open打开该设备文件，读出文件的inode内容，得到该设备的主设备号和次设备号；

2）chardev_open 字符设备驱动框架的open根据主设备号得到framebuffer的fb_fops操作集；

3）进入到fb_fops->open, 即fb_open()。从fb_open()函数中可以看出，最终调用的是fb0设备下的fb_ops来对fb0设备进行访问，即fb_info->fb_ops->fb_open。



```
static int fb_open(struct inode *inode, struct file *file)
__acquires(&info->lock)
__releases(&info->lock)
{
    int fbidx = iminor(inode);      //获得次设备号
    struct fb_info *info;           //代表一个framebuffer的全局数据结构
    int res = 0;

    if (fbidx >= FB_MAX)
        return -ENODEV;
    info = registered_fb[fbidx];    //找到对应的fb_info
    file->private_data = info;      //将info存入file的私有数据中，便于用户调用其他接口（mmap、ioctl等）能够找到相应的info
    if (info->fbops->fb_open)       //调用info->fbops->fb_open
　　{
        res = info->fbops->fb_open(info,1);
        if (res)
            module_put(info->fbops->owner);
    }
　　
　　... ...

    return res;
}
```



**（3）framebuffer设备注册/注销接口**

framebuffer驱动加载初始化时需要通过register_framebuffer接口向framebuffer子系统注册自己。

数组struct fb_info *registered_fb[FB_MAX]，是fb驱动框架维护的一个用来管理记录fb设备的数组，里面的元素就是 fb_info 指针，一个fb_info就代表一个fb设备。由此可知，Linux内核最多支持FB_MAX = 32个fb设备。



```
int register_framebuffer(struct fb_info *fb_info)
{
    int i;
    struct fb_event event;
    struct fb_videomode mode;

    if (num_registered_fb == FB_MAX)//如果当前注册的fb设备的数量已经满了，则不能在进行注册了 最大值32
        return -ENXIO;
    ... ...

    //找到一个最小的没有被使用的次设备号
    num_registered_fb++;
    for (i = 0 ; i < FB_MAX; i++)
        if (!registered_fb[i])
            break;
    fb_info->node = i; //将次设备号存放在 fb_info->node 中
    mutex_init(&fb_info->lock);
    mutex_init(&fb_info->mm_lock);
    
    //创建framebuffer设备
    fb_info->dev = device_create(fb_class, fb_info->device, MKDEV(FB_MAJOR, i), NULL, "fb%d", i);

    ... ...

    //初始化framebuffer设备信息，创建fb的设备属性文件
　　 fb_init_device(fb_info);

　　//pixmp相关设置
    if (fb_info->pixmap.addr == NULL) 
　　{
        fb_info->pixmap.addr = kmalloc(FBPIXMAPSIZE, GFP_KERNEL);
        if (fb_info->pixmap.addr) 
　　　　 {
            fb_info->pixmap.size = FBPIXMAPSIZE;
            fb_info->pixmap.buf_align = 1;
            fb_info->pixmap.scan_align = 1;
            fb_info->pixmap.access_align = 32;
            fb_info->pixmap.flags = FB_PIXMAP_DEFAULT;
        }
    }    
    ... ...

    fb_var_to_videomode(&mode, &fb_info->var);  //从fb_info结构体中获取显示模式存放在mode变量中
    fb_add_videomode(&mode, &fb_info->modelist);//添加显示模式
    registered_fb[i] = fb_info;                 //将fb_info 结构体存放到 registered_fb数组中

    ... ...
    fb_notifier_call_chain(FB_EVENT_FB_REGISTERED, &event); //异步通知: 通知那些正在等待fb注册事件发生的进程
    ... ...
    return 0;
}
```



 相应的fb设备的注销接口为unregister_framebuffer()函数。

```
/*
*功能：注销fb设备
*参数：struct fb_info *fb_info：需要注销的fb设备
*/
int unregister_framebuffer(struct fb_info *fb_info);
```

**（4）mmap映射**

 framebuffer驱动最重要的功能就是给用户提供一个进程空间映射到实际的显示物理内存的接口(fb_fops->mmap)。

应用层mmap映射接口会经历以下层次调用：

1）sys_mmap()，虚拟文件系统层（VFS）的映射实现；

2）fb_ops.mmap = fb_mmap，此处的fb_fops为framebuffer驱动框架的操作集；从fb_mmap()函数中可以看出，最终调用的是fb设备的fb_ops中的fb_mmap，即fb_info->fb_fops->fb_mmap。



```
static int fb_mmap(struct file *file, struct vm_area_struct * vma)
{
    int fbidx = iminor(file->f_path.dentry->d_inode); //获取fb的子设备号
    struct fb_info *info = registered_fb[fbidx];      //获取相应的fb_info
    struct fb_ops *fb = info->fbops;                  //fb设备的操作集
   
    ... ...
    if (fb->fb_mmap) {
        int res;
        res = fb->fb_mmap(info, vma);  //调用fb设备操作集下的fb_mmap
        mutex_unlock(&info->mm_lock);
        return res;
    }
　　... ...
    return 0;
}
```



[回到顶部](https://www.cnblogs.com/linfeng-learning/p/9478048.html#_labelTop)

# 4. fb与应用程序的交互

在应用层中，用户可以将fb设备看成是显存的一个映像，将其映射到进程空间后，就可以直接进行读写操作，写操作会直接反映在屏幕上。

在应用程序中，操作/dev/fbn的一般步骤如下：

1）打开/dev/fbn设备文件；

2）用ioctl()操作取得当前显示屏幕的参数，如屏幕分辨率、每个像素点的比特数。根据屏幕参数可计算屏幕缓冲区的大小；

3）用mmap()函数，将屏幕缓冲区映射到用户空间；

4）映射后就可以直接读/写屏幕缓冲区，进行绘图和图片显示；。

5）使用完帧缓冲设备后需要将其释放；

6）关闭文件。

应用示例：



```
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <linux/fb.h>
#include <sys/ioctl.h>
#include <sys/mman.h>

#define FBDEVICE    "/dev/fb0"

#define WHITE        0xffffffff
#define BLACK        0x00000000

void draw_back(unsigned int *pfb, unsigned int width, unsigned int height, unsigned int color)
{
    unsigned int x, y;
    
    for (y=0; y<height; y++)
    {
        for (x=0; x<width; x++)
        {
            *(pfb + y * width + x) = color;
        }
    }
}

int main(void)
{
    int fd = -1;
    unsigned int *pfb = NULL;
    unsigned int width;
    unsigned int height;
    
    struct fb_fix_screeninfo finfo = {0};
    struct fb_var_screeninfo vinfo = {0};

    /************************第1步：打开设备**************************/ 
    fd = open(FBDEVICE, O_RDWR);
    if (fd < 0)
    {
        perror("open");
        return -1;
    }
    printf("open %s success.\n", FBDEVICE);


    /*******************第2步：获取设备的硬件信息********************/ 
    ioctl(fd, FBIOGET_FSCREENINFO, &finfo);//获取LCD的固定属性参数
    /*
    *finfo.smem_start：LCD显存的起始地址
    *finfo.smem_len：LCD显存的字节大小
    */
    printf("smem_start = 0x%x, smem_len = %u.\n", finfo.smem_start, finfo.smem_len);

    
    ioctl(fd, FBIOGET_VSCREENINFO, &vinfo);//获取LCD的可变参数
    /*
    *vinfo.xres：水平分辨率
    *vinfo.yres：垂直分辨率
    *vinfo.xres_virtual：虚拟水平分辨率
    *vinfo.yres_virtual：虚拟垂直分辨率
    *vinfo.bits_per_pixel：像素深度
    */
    printf("xres = %u, yres = %u.\n", vinfo.xres, vinfo.yres);
    printf("xres_virtual = %u, yres_virtual = %u.\n", vinfo.xres_virtual, vinfo.yres_virtual);
    printf("bpp = %u.\n", vinfo.bits_per_pixel);
    
    width = vinfo.xres;
    height = vinfo.yres;
    

    /*************************第3步：进行mmap***********************/ 
    //计算LCD显存大小（单位：字节）
    unsigned long len = vinfo.xres_virtual * vinfo.yres_virtual * vinfo.bits_per_pixel / 8;
    printf("len = %ld\n", len);
    
    pfb = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
    printf("pfb = %p.\n", pfb);


    /********************第4步：进行lcd相关的操作********************/
    draw_back(pfb, width, height, RED);
    

    /***********************第五步：释放显存************************/
    munmap(pfb, len);
    

    /***********************第六步：关闭文件************************/ 
    close(fd);

    return 0;
}
```



\5. LCD驱动程序分析

[驱动程序实例（五）：LCD驱动程序分析（Samsung LCD）](https://www.cnblogs.com/linfeng-learning/p/9486662.html )。



分类: [linux-driver](https://www.cnblogs.com/linfeng-learning/category/1253479.html)

标签: [framebuffer](https://www.cnblogs.com/linfeng-learning/tag/framebuffer/)