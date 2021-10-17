# qemu

[qemu](https://www.qemu.org/)
>  A generic and open source machine emulator and virtualizer

## install
QEMU is packaged by most Linux distributions:

- Arch: pacman -S qemu
- Debian/Ubuntu: apt-get install qemu
- Fedora: dnf install @virtualization
- Gentoo: emerge --ask app-emulation/qemu
- RHEL/CentOS: yum install qemu-kvm
- SUSE: zypper install qemu

Version numbering

Since version 3.0.0, QEMU uses a time based version numbering scheme:

major
    incremented by 1 for the first release of the year
minor
    reset to 0 with every major increment, otherwise incremented by 1 for each release from git master
micro
    always 0 for releases from git master, incremented by 1 for each stable branch release

The implication of this is that changes in major version number do not have any bearing on the scope of changes included in the release. Non-backward compatible changes may be made in any master branch release, provided they have followed the deprecation policy which calls for warnings to be emitted for a minimum of two releases prior to the change.


### install log
```
(base) foo@foo-:~/venv$ sudo apt-get install qemu
正在读取软件包列表... 完成
正在分析软件包的依赖关系树       
正在读取状态信息... 完成       
下列软件包是自动安装的并且现在不需要了：
  gir1.2-geocodeglib-1.0 libegl1-mesa libfwup1 libllvm8 libwayland-egl1-mesa
  ubuntu-web-launchers
使用'sudo apt autoremove'来卸载它(它们)。
将会同时安装下列软件：
  binfmt-support cpu-checker ibverbs-providers ipxe-qemu
  ipxe-qemu-256k-compat-efi-roms libaio1 libcacard0 libfdt1 libibverbs1
  libiscsi7 libnl-route-3-200 librados2 librbd1 librdmacm1 libspice-server1
  libusbredirparser1 libxen-4.9 libxenstore3.0 msr-tools qemu-block-extra
  qemu-slof qemu-system qemu-system-arm qemu-system-common qemu-system-mips
  qemu-system-misc qemu-system-ppc qemu-system-s390x qemu-system-sparc
  qemu-system-x86 qemu-user qemu-user-binfmt qemu-utils seabios sharutils
建议安装：
  qemu-user-static samba vde2 qemu-efi openbios-ppc openhackware
  openbios-sparc sgabios ovmf debootstrap sharutils-doc bsd-mailx | mailx
下列【新】软件包将被安装：
  binfmt-support cpu-checker ibverbs-providers ipxe-qemu
  ipxe-qemu-256k-compat-efi-roms libaio1 libcacard0 libfdt1 libibverbs1
  libiscsi7 libnl-route-3-200 librados2 librbd1 librdmacm1 libspice-server1
  libusbredirparser1 libxen-4.9 libxenstore3.0 msr-tools qemu qemu-block-extra
  qemu-slof qemu-system qemu-system-arm qemu-system-common qemu-system-mips
  qemu-system-misc qemu-system-ppc qemu-system-s390x qemu-system-sparc
  qemu-system-x86 qemu-user qemu-user-binfmt qemu-utils seabios sharutils
升级了 0 个软件包，新安装了 36 个软件包，要卸载 0 个软件包，有 0 个软件包未被升级。
```
### /usr/bin/qemu*
```

(base) csy@csy-MS-7C67:~/Documents/Mylib/tool_misc$ ls /usr/bin |grep qemu
qemu-aarch64
qemu-alpha
qemu-arm
qemu-armeb
qemu-cris
qemu-hppa
qemu-i386
qemu-img
qemu-io
qemu-m68k
qemu-microblaze
qemu-microblazeel
qemu-mips
qemu-mips64
qemu-mips64el
qemu-mipsel
qemu-mipsn32
qemu-mipsn32el
qemu-nbd
qemu-nios2
qemu-or1k
qemu-ppc
qemu-ppc64
qemu-ppc64abi32
qemu-ppc64le
qemu-s390x
qemu-sh4
qemu-sh4eb
qemu-sparc
qemu-sparc32plus
qemu-sparc64
qemu-system-aarch64
qemu-system-alpha
qemu-system-arm
qemu-system-cris
qemu-system-i386
qemu-system-lm32
qemu-system-m68k
qemu-system-microblaze
qemu-system-microblazeel
qemu-system-mips
qemu-system-mips64
qemu-system-mips64el
qemu-system-mipsel
qemu-system-moxie
qemu-system-nios2
qemu-system-or1k
qemu-system-ppc
qemu-system-ppc64
qemu-system-ppc64le
qemu-system-ppcemb
qemu-system-s390x
qemu-system-sh4
qemu-system-sh4eb
qemu-system-sparc
qemu-system-sparc64
qemu-system-tricore
qemu-system-unicore32
qemu-system-x86_64
qemu-system-x86_64-spice
qemu-system-xtensa
qemu-system-xtensaeb
qemu-tilegx
qemu-x86_64
```

### demo
``` bash
# a iso
wget tinycorelinux.net/12.x/x86/release/CorePlus-current.iso
qemu-system-x86_64 linux.img
```



不建议使用源码安装，虽然版本较新，但依赖库很多，会出现各种问题。可通过软件包管理器`apt-get install qemu`。但是此种安装后，在/usr/bin/目录下只有qemu-system-i386之类的命令工具，并无arm相关的工具，此时需要安装qemu-system-arm，执行命令apt-get install qemu-system。也就是默认安装Qemu是不支持ARM架构的。同时也需要安装qemu-arm，此工具可以直接运行ARM架构的二进制文件，而不必模拟整个SOC。执行命令apt-get install qemu-user。至此，Qemu基本工具都已安装完成，如下图，我们主要是以模拟ARM架构的设备为主。