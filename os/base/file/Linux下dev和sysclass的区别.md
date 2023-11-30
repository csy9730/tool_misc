# Linux下/dev和/sys/class的区别



> The files in /dev are actual devices files which UDEV creates at run time. The directory /sys/class is exported by the kernel at run time, exposing the hierarchy of the hardware through sysfs.

- /dev 下的文件是真实的设备，由UDEV在运行时创建。
- /sys/class 是由kernel在运行时导出的，目的是通过文件系统暴露出硬件的层级关系。



**From the [libudev and Sysfs Tutorial](http://www.signal11.us/oss/udev/)\**

*excerpt*

> On Unix and Unix-like systems, hardware devices are accessed through special files (also called device files or nodes) located in the /dev directory. These files are read from and written to just like normal files, but instead of writing and reading data on a disk, they communicate directly with a kernel driver which then communicates with the hardware. There are many online resources describing /dev files in more detail. Traditonally, these special files were created at install time by the distribution, using the mknod command. In recent years, Linux systems began using udev to manage these /dev files at runtime. For example, udev will create nodes when devices are detected and delete them when devices are removed (including hotplug devices at runtime). This way, the /dev directory contains (for the most part) only entries for devices which actually exist on the system at the current time, as opposed to devices which could exist.

*another excerpt*

> The directories in Sysfs contain the heirarchy of devices, as they are attached to the computer. For example, on my computer, the hidraw0 device is located under:
>
> ```
> /sys/devices/pci0000:00/0000:00:12.2/usb1/1-5/1-5.4/1-5.4:1.0/0003:04D8:003F.0001/hidraw/hidraw0
> ```
>
> Based on the path, the device is attached to (roughly, starting from the end) configuration 1 (:1.0) of the device attached to port number 4 of device 1-5, connected to USB controller 1 (usb1), connected to the PCI bus. While interesting, this directory path doesn't do us very much good, since it's dependent on how the hardware is physically connected to the computer.
>
> Fortunately, Sysfs also provides a large number of symlinks, for easy access to devices without having to know which PCI and USB ports they are connected to. In /sys/class there is a directory for each different class of device.

## misc

- /dev 设备
- /sys/class
- devfs linux2.6之前使用，从 Linux 2.6 起，devfs 被 sysfs + udev 所取代
- udev udev 是从 Linux 2.6 一直沿用至今的设备管理器，挂载并管理着 `/dev` 
- sysfs 基于内存的虚拟的文件系统，由 kernel 提供
- kernfs  sysfs 实际上基于 kernfs 实现。



- udevadm  udev 管理工具？ 命令行工具。可用来向 udevd 发送指令。



#### udev

udev 是从 Linux 2.6 一直沿用至今的设备管理器，挂载并管理着 `/dev` 。和 devfs 不同的是，它运行在用户态中，允许用户进行自定义配置，并根据配置在收到事件时在 `/dev` 下创建设备文件。

###  /sys/class



几乎所有的类都在 sysfs 中在 /sys/class 下出现. 因此, 例如, 所有的网络接口可在

/sys/class/net 下发现, 不管接口类型. 输入设备可在 /sys/class/input 下, 以及串 行设备在 /sys/class/tty. 一个例外是块设备, 由于历史的原因在 /sys/block.

 

类成员关系常常由高级的代码处理, 不必要驱动的明确的支持. 当 sbull 驱动( 见 16 章) 创建一个虚拟磁盘设备, 它自动出现在 /sys/block. snull 网络驱动(见 17 章)没 有做任何特殊事情给它的接口在 /sys/class/net 中出现. 将有多次, 但是, 当驱动结束 直接处理类.

 

在许多情况, 类子系统是最好的输出信息到用户空间的方法. 当一个子系统创建一个类, 它完全拥有这个类, 因此没有必要担心哪个模块拥有那里发现的属性. 它也用极少的时间 徘徊于更加面向硬件的 sysfs 部分来了解, 它不是一个直接浏览的好地方. 用户会更加 高兴地在 /sys/class/some-widget 中发现信息, 而不是,

/sys/device/pci0000:00/0000:00:10.0/usb2/2-0:1.0.

 

驱动核心输出 2 个清晰的接口来管理类. class_simple 函数设计来尽可能容易地添加新 类到系统. 它们的主要目的, 常常, 是暴露包含设备号的属性来使能设备节点的自动创建. 常用的类接口更加复杂但是同时提供更多特性. 我们从简单版本开始.

#### demo



``` bash
root@CMZ600:/sys/class/gpio# ls /sys/class/net/net2
addr_assign_type      dev_id                ifindex               phydev                statistics
addr_len              dev_port              iflink                phys_port_id          subsystem
address               device                link_mode             phys_port_name        testing
broadcast             dormant               mtu                   phys_switch_id        tx_queue_len
carrier               duplex                name_assign_type      power                 type
carrier_changes       flags                 napi_defer_hard_irqs  proto_down            uevent
carrier_down_count    gro_flush_timeout     netdev_group          queues
carrier_up_count      ifalias               operstate             speed

root@CMZ600:/sys/class/gpio# ls /sys/class/net/net2/operstate
/sys/class/net/net2/operstate

root@CMZ600:/sys/class/gpio# cat /sys/class/net/net2/operstate
up

root@CMZ600:/sys/class/gpio# cat /sys/class/net/net1/operstate
down
```

