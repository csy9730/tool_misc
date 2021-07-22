# apt remove linux

```     
(base) ➜  /snap sudo apt-get remove linux-image-4.15.0-142-generic  linux-image-4.15.0-106-generic linux-image-4.15.0-108-generic linux-image-4.15.0-109-generic linux-image-4.15.0-111-generic linux-image-4.15.0-112-generic linux-image-4.15.0-115-generic linux-image-4.15.0-117-generic linux-image-4.15.0-118-generic linux-image-4.15.0-121-generic linux-image-4.15.0-122-generic linux-image-4.15.0-123-generic linux-image-4.15.0-126-generic linux-image-4.15.0-128-generic linux-image-4.15.0-129-generic linux-image-4.15.0-132-generic linux-image-4.15.0-135-generic linux-image-4.15.0-136-generic linux-image-4.15.0-137-generic
Reading package lists... Done
Building dependency tree
Reading state information... Done
Package 'linux-image-4.15.0-106-generic' is not installed, so not removed
Package 'linux-image-4.15.0-108-generic' is not installed, so not removed
Package 'linux-image-4.15.0-109-generic' is not installed, so not removed
Package 'linux-image-4.15.0-111-generic' is not installed, so not removed
Package 'linux-image-4.15.0-112-generic' is not installed, so not removed
Package 'linux-image-4.15.0-115-generic' is not installed, so not removed
Package 'linux-image-4.15.0-117-generic' is not installed, so not removed
Package 'linux-image-4.15.0-118-generic' is not installed, so not removed
Package 'linux-image-4.15.0-121-generic' is not installed, so not removed
Package 'linux-image-4.15.0-122-generic' is not installed, so not removed
Package 'linux-image-4.15.0-123-generic' is not installed, so not removed
Package 'linux-image-4.15.0-128-generic' is not installed, so not removed
Package 'linux-image-4.15.0-129-generic' is not installed, so not removed
Package 'linux-image-4.15.0-132-generic' is not installed, so not removed
Package 'linux-image-4.15.0-135-generic' is not installed, so not removed
Package 'linux-image-4.15.0-136-generic' is not installed, so not removed
Package 'linux-image-4.15.0-137-generic' is not installed, so not removed
Package 'linux-image-4.15.0-126-generic' is not installed, so not removed
The following additional packages will be installed:
  linux-image-unsigned-4.15.0-142-generic
Suggested packages:
  fdutils linux-doc-4.15.0 | linux-source-4.15.0 linux-tools
The following packages will be REMOVED:
  linux-image-4.15.0-142-generic linux-modules-extra-4.15.0-142-generic
The following NEW packages will be installed:
  linux-image-unsigned-4.15.0-142-generic
0 upgraded, 1 newly installed, 2 to remove and 32 not upgraded.
Need to get 8,091 kB of archives.
After this operation, 181 MB disk space will be freed.
Do you want to continue? [Y/n] y
Get:1 http://us.archive.ubuntu.com/ubuntu bionic-security/main amd64 linux-image-unsigned-4.15.0-142-generic amd64 4.15.0-142.146 [8,091 kB]
Fetched 8,091 kB in 20s (397 kB/s)
(Reading database ... 316314 files and directories currently installed.)
Removing linux-modules-extra-4.15.0-142-generic (4.15.0-142.146) ...
Removing linux-image-4.15.0-142-generic (4.15.0-142.146) ...
/etc/kernel/prerm.d/dkms:
dkms: removing: nvidia 460.80 (4.15.0-142-generic) (x86_64)

-------- Uninstall Beginning --------
Module:  nvidia
Version: 460.80
Kernel:  4.15.0-142-generic (x86_64)
-------------------------------------

Status: Before uninstall, this module version was ACTIVE on this kernel.

nvidia.ko:
 - Uninstallation
   - Deleting from: /lib/modules/4.15.0-142-generic/updates/dkms/
 - Original module
   - No original module was found for this module on this kernel.
   - Use the dkms install command to reinstall any previous module version.


nvidia-modeset.ko:
 - Uninstallation
   - Deleting from: /lib/modules/4.15.0-142-generic/updates/dkms/
 - Original module
   - No original module was found for this module on this kernel.
   - Use the dkms install command to reinstall any previous module version.


nvidia-drm.ko:
 - Uninstallation
   - Deleting from: /lib/modules/4.15.0-142-generic/updates/dkms/
 - Original module
   - No original module was found for this module on this kernel.
   - Use the dkms install command to reinstall any previous module version.


nvidia-uvm.ko:
 - Uninstallation
   - Deleting from: /lib/modules/4.15.0-142-generic/updates/dkms/
 - Original module
   - No original module was found for this module on this kernel.
   - Use the dkms install command to reinstall any previous module version.

depmod...

DKMS: uninstall completed.
dkms: removing: virtualbox 5.2.42 (4.15.0-142-generic) (x86_64)

-------- Uninstall Beginning --------
Module:  virtualbox
Version: 5.2.42
Kernel:  4.15.0-142-generic (x86_64)
-------------------------------------

Status: Before uninstall, this module version was ACTIVE on this kernel.

vboxdrv.ko:
 - Uninstallation
   - Deleting from: /lib/modules/4.15.0-142-generic/updates/dkms/
 - Original module
   - No original module was found for this module on this kernel.
   - Use the dkms install command to reinstall any previous module version.


vboxnetadp.ko:
 - Uninstallation
   - Deleting from: /lib/modules/4.15.0-142-generic/updates/dkms/
 - Original module
   - No original module was found for this module on this kernel.
   - Use the dkms install command to reinstall any previous module version.


vboxnetflt.ko:
 - Uninstallation
   - Deleting from: /lib/modules/4.15.0-142-generic/updates/dkms/
 - Original module
   - No original module was found for this module on this kernel.
   - Use the dkms install command to reinstall any previous module version.


vboxpci.ko:
 - Uninstallation
   - Deleting from: /lib/modules/4.15.0-142-generic/updates/dkms/
 - Original module
   - No original module was found for this module on this kernel.
   - Use the dkms install command to reinstall any previous module version.

depmod...

DKMS: uninstall completed.
/etc/kernel/postrm.d/initramfs-tools:
update-initramfs: Deleting /boot/initrd.img-4.15.0-142-generic
/etc/kernel/postrm.d/zz-update-grub:
Sourcing file `/etc/default/grub'
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-4.15.0-147-generic
Found initrd image: /boot/initrd.img-4.15.0-147-generic
Found linux image: /boot/vmlinuz-4.15.0-144-generic
Found initrd image: /boot/initrd.img-4.15.0-144-generic
Found memtest86+ image: /memtest86+.elf
Found memtest86+ image: /memtest86+.bin
Found Windows 10 on /dev/nvme0n1p1
done
Selecting previously unselected package linux-image-unsigned-4.15.0-142-generic.
(Reading database ... 311344 files and directories currently installed.)
Preparing to unpack .../linux-image-unsigned-4.15.0-142-generic_4.15.0-142.146_amd64.deb ...
Unpacking linux-image-unsigned-4.15.0-142-generic (4.15.0-142.146) ...
Setting up linux-image-unsigned-4.15.0-142-generic (4.15.0-142.146) ...
I: /vmlinuz.old is now a symlink to boot/vmlinuz-4.15.0-147-generic
I: /initrd.img.old is now a symlink to boot/initrd.img-4.15.0-147-generic
I: /vmlinuz is now a symlink to boot/vmlinuz-4.15.0-142-generic
I: /initrd.img is now a symlink to boot/initrd.img-4.15.0-142-generic
Processing triggers for linux-image-unsigned-4.15.0-142-generic (4.15.0-142.146) ...
/etc/kernel/postinst.d/dkms:
 * dkms: running auto installation service for kernel 4.15.0-142-generic

Kernel preparation unnecessary for this kernel.  Skipping...
applying patch disable_fstack-clash-protection_fcf-protection.patch...patching file Kbuild
Hunk #1 succeeded at 82 (offset 11 lines).


Building module:
cleaning build area...
unset ARCH; [ ! -h /usr/bin/cc ] && export CC=/usr/bin/gcc; env NV_VERBOSE=1 'make' -j6 NV_EXCLUDE_BUILD_MODULES='' KERNEL_UNAME=4.15.0-142-generic IGNORE_XEN_PRESENCE=1 IGNORE_CC_MISMATCH=1 SYSSRC=/lib/modules/4.15.0-142-generic/build LD=/usr/bin/ld.bfd modules........
cleaning build area...

DKMS: build completed.

nvidia.ko:
Running module version sanity check.
 - Original module
   - No original module exists within this kernel
 - Installation
   - Installing to /lib/modules/4.15.0-142-generic/updates/dkms/

nvidia-modeset.ko:
Running module version sanity check.
 - Original module
   - No original module exists within this kernel
 - Installation
   - Installing to /lib/modules/4.15.0-142-generic/updates/dkms/

nvidia-drm.ko:
Running module version sanity check.
 - Original module
   - No original module exists within this kernel
 - Installation
   - Installing to /lib/modules/4.15.0-142-generic/updates/dkms/

nvidia-uvm.ko:
Running module version sanity check.
 - Original module
   - No original module exists within this kernel
 - Installation
   - Installing to /lib/modules/4.15.0-142-generic/updates/dkms/

depmod...

DKMS: install completed.

Kernel preparation unnecessary for this kernel.  Skipping...

Building module:
cleaning build area...
make -j6 KERNELRELEASE=4.15.0-142-generic -C /lib/modules/4.15.0-142-generic/build M=/var/lib/dkms/virtualbox/5.2.42/build.....
cleaning build area...

DKMS: build completed.

vboxdrv.ko:
Running module version sanity check.
 - Original module
   - No original module exists within this kernel
 - Installation
   - Installing to /lib/modules/4.15.0-142-generic/updates/dkms/

vboxnetadp.ko:
Running module version sanity check.
 - Original module
   - No original module exists within this kernel
 - Installation
   - Installing to /lib/modules/4.15.0-142-generic/updates/dkms/

vboxnetflt.ko:
Running module version sanity check.
 - Original module
   - No original module exists within this kernel
 - Installation
   - Installing to /lib/modules/4.15.0-142-generic/updates/dkms/

vboxpci.ko:
Running module version sanity check.
 - Original module
   - No original module exists within this kernel
 - Installation
   - Installing to /lib/modules/4.15.0-142-generic/updates/dkms/

depmod...

DKMS: install completed.
   ...done.
/etc/kernel/postinst.d/initramfs-tools:
update-initramfs: Generating /boot/initrd.img-4.15.0-142-generic
/etc/kernel/postinst.d/zz-update-grub:
Sourcing file `/etc/default/grub'
Generating grub configuration file ...
Found linux image: /boot/vmlinuz-4.15.0-147-generic
Found initrd image: /boot/initrd.img-4.15.0-147-generic
Found linux image: /boot/vmlinuz-4.15.0-144-generic
Found initrd image: /boot/initrd.img-4.15.0-144-generic
Found linux image: /boot/vmlinuz-4.15.0-142-generic
Found initrd image: /boot/initrd.img-4.15.0-142-generic
Found memtest86+ image: /memtest86+.elf
Found memtest86+ image: /memtest86+.bin
Found Windows 10 on /dev/nvme0n1p1
done
```
