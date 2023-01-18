## [FreeBSD Jails 简介](https://www.cnblogs.com/lisperl/archive/2012/05/07/2487039.html)

FreeBSD Jails是FreeBSD平台上的一种基于容器的虚拟化技术，是对Unix传统的chroot机制的一种扩展。Unix传统的安全模型高效简单，适用于很多应用场景。但是它是基于系统只有没有管理权限的普通用户和有管理权限的根用户这两类用户的情况设计的，它无法很好地处理把一部分管理权限授权给不被信任的用户的情况。Unix后来引入了chroot机制，提供了一种简单的系统隔离功能，但是仅限于文件系统，进程和网络空间都没得到相应的处理。FreeBSD Jails正是在这种情况下出现的，它提供了一种很强的隔离能力，将chroot等已有的机制进行了扩展，可以为进程提供一个虚拟运行环境。[4]在FreeBSD Jails中，一个Jail就是一个容器。在Jail中，进程有自己的文件系统，进程和网络空间。Jail中的进程既不能访问也不可能看到Jail之外的文件、进程和网络资源。

FreeBSD Jails是通过jail系统调用来供用户使用的。Jail在进程调用jail后创建，调用进程自动被置于Jail内，而且不能脱离。进程的后代进程也自动被置于Jail之内。在Jail之内，进程所能访问的文件系统跟chroot机制类似，所能使用的网络资源也仅限于特定的IP地址，进程间通信也仅限于Jail内部的进程。

FreeBSD Jails的实现通过修改FreeBSD 内核相关的代码实现的。主要有以下几个方面[4]

（一）引入struct prison，实现jail系统调用。

Jail系统调用实现比较简单：分配一个prison结构，然后填充相应的参数，将其附加到进程的struct proc上，设置prison的引用数为1，最后调用chroot系统调用完成剩下的工作。

（二）增强chroot机制

传统的chroot机制有一些安全漏洞，在FreeBSD Jails的实现中，增强了chroot机制，以保证Jail内的进程的文件系统视图是正确和可控的。

（三）限制进程间的可见性和通信

FreeBSD中进程的可见性通过两个机制来实现，一个是procfs文件系统，另一个是sysctl树的子树。这两个机制都为Jail做了相应的修改，使得只有同一个jail内的进程可见。FreeBSD中进程之间是否可以相应影响由p_trespass(p1,p2)的返回值决定，在Jails的实现中该函数已经增加了额外的jail检查代码，使得不同jail之间的进程不能相互影响。

（四）限制进程可访问的网络资源

FreeBSD Jails中的进程网络资源的限制，不是通过给jail中的进程创建一个独立的网络空间实现的，而是通过将jail内的进程所能使用的网络资源限定到一个特定的IP地址实现。当jail中的进程试图绑定到socket时，进程的提供的IP地址不会被使用，而是使用预先为该jail配置的IP地址。

（五）让特定的设备驱动知道Jail的存在

一些特定的设备驱动需要Jail的存在，比如pty驱动。Pty提供虚拟终端到ssh、telnet等服务。Jail需要使用pty，所以额外的代码必须被添加使得同一个虚拟终端不会被多个jail使用。

（六）限制Jail内的超级用户的权限

  Jail内也有拥护管理员权限的超级用户，但是该用户的权限必须受到限制。该用户的权限应该是系统超级用户权限的一个子集，而该用户的管理权限也只应该仅限于该Jail内。Jail内的超级用户默认没有特权，不能使用mknod系统调用创建设备，因此Jail内的进程只能使用系统管理员分配的设备。

FreeBSD Jails 的使用

  Jails的使用请参见Jails的man page：http://www.freebsd.org/cgi/man.cgi?query=jail&format=html和FreeBSD 使用手册：http://www.kuqin.com/docs/freebsd-handbook/jails.html

文章未经本人允许，禁止以任何形式复制，转载；使用在其他任何未经本人允许的地方。若要转载请留言联系。

标签: [虚拟化技术](https://www.cnblogs.com/lisperl/tag/虚拟化技术/)