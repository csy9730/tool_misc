# openstack


IaaS，PaaS，SaaS三层架构
openstack 属于 Iaas层。



openstack是云管理平台，其本身并不提供虚拟化功能，真正的虚拟化能力是由底层的hypervisor（如KVM、Qemu、Xen等）提供。所谓管理平台，就是为了方便使用而已。打一个不恰当的比方，订单管理平台之类的产品，其实就是整合了一系列的sql调用而已。类似的，如果没有openstack，一样可以通过virsh、virt-manager来实现创建虚拟机的操作，只不过敲命令行的方式需要一定的学习成本，对于普通用户不是很友好。


[https://www.openstack.org/](https://www.openstack.org/)