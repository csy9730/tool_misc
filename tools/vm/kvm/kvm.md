# kvm & qemu

## kvm

KVM即Kernel Virtual Machine，最初是由以色列公司Qumranet开发。2007年2月被导入Linux 2.6.20核心中，成为内核源代码的一部分。2008年9月4日，Redhat收购了Qumranet，至此Redhat拥有了自己的虚拟化解决方案，之后便舍弃Xen开始全面扶持KVM，从RHEL6开始KVM便被默认内置于内核中。本文介绍KVM虚拟化平台部署及管理。

KVM特点

KVM必须在具备Intel VT或AMD-V功能的x86平台上运行。KVM包含一个为处理器提供底层虚拟化，可加载的核心模块kvm.ko（kvm-intel.ko或kvm-AMD.ko）。使用一个经过修改的QEMU（qemu-kvm），作为虚拟机上层控制和界面。

由于KVM仅是一个简单的虚拟化模块，所以它的内存管理没有自我实现，需借助于Linux内核实现内存管理。KVM能够使用Linux所支持的任何存储，在驱动程序的实现上，直接借助于Linux内核来驱动任何硬件。在性能上KVM继承了Linux很好的性能和伸缩性，在虚拟化性能方面，已经达到非虚拟化原生环境95%左右的性能（官方数据）。KVM拓展性也非常好，客户机和宿主机都可以支持


## qemu

首先KVM（Kernel Virtual Machine）是Linux的一个内核驱动模块，它能够让Linux主机成为一个Hypervisor（虚拟机监控器）。在支持VMX（Virtual Machine Extension）功能的x86处理器中，Linux在原有的用户模式和内核模式中新增加了客户模式，并且客户模式也拥有自己的内核模式和用户模式，虚拟机就是运行在客户模式中。KVM模块的职责就是打开并初始化VMX功能，提供相应的接口以支持虚拟机的运行。

QEMU（quick emulator)本身并不包含或依赖KVM模块，而是一套由Fabrice Bellard编写的模拟计算机的自由软件。QEMU虚拟机是一个纯软件的实现，可以在没有KVM模块的情况下独立运行，但是性能比较低。QEMU有整套的虚拟机实现，包括处理器虚拟化、内存虚拟化以及I/O设备的虚拟化。QEMU是一个用户空间的进程，需要通过特定的接口才能调用到KVM模块提供的功能。从QEMU角度来看，虚拟机运行期间，QEMU通过KVM模块提供的系统调用接口进行内核设置，由KVM模块负责将虚拟机置于处理器的特殊模式运行。QEMU使用了KVM模块的虚拟化功能，为自己的虚拟机提供硬件虚拟化加速以提高虚拟机的性能。

KVM只模拟CPU和内存，因此一个客户机操作系统可以在宿主机上跑起来，但是你看不到它，无法和它沟通。于是，有人修改了QEMU代码，把他模拟CPU、内存的代码换成KVM，而网卡、显示器等留着，因此QEMU+KVM就成了一个完整的虚拟化平台。

KVM只是内核模块，用户并没法直接跟内核模块交互，需要借助用户空间的管理工具，而这个工具就是QEMU。KVM和QEMU相辅相成，QEMU通过KVM达到了硬件虚拟化的速度，而KVM则通过QEMU来模拟设备。

对于KVM来说，其匹配的用户空间工具并不仅仅只有QEMU，~~还有其他的，比如RedHat开发的libvirt、virsh、virt-manager等，QEMU并不是KVM的唯一选择。~~

libvirt virsh啥的都是调用qemu 工作的…在qemu上层

所以简单直接的理解就是：QEMU是个计算机模拟器，而KVM为计算机的模拟提供加速功能。
