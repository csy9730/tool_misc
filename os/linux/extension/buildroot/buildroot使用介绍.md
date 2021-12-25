# [buildroot使用介绍](https://www.cnblogs.com/arnoldlu/p/9553995.html)

[buildroot](https://buildroot.org/)是Linux平台上一个构建嵌入式Linux系统的框架。整个Buildroot是由Makefile脚本和Kconfig配置文件构成的。你可以和编译Linux内核一样，通过buildroot配置，menuconfig修改，编译出一个完整的可以直接烧写到机器上运行的Linux系统软件(包含boot、kernel、rootfs以及rootfs中的各种库和应用程序)。

使用buildroot搭建基于qemu的虚拟开发平台，参考《[通过buildroot+qemu搭建ARM-Linux虚拟开发环境](https://www.cnblogs.com/arnoldlu/p/9689585.html)》。

## 1. buildroot入门

首先如何使用buildroot，1.选择一个defconfig；2.根据需要配置buildroot；3.编译buildroot；4.在qemu或者目标板上运行buildroot构建的系统。

## 1.1 buildroot目录介绍

进入buildroot首先映入眼帘的是一系列目录，简要介绍如下：



```
.
├── arch: 存放CPU架构相关的配置脚本，如arm/mips/x86,这些CPU相关的配置，在制作工具链时，编译uboot和kernel时很关键.
├── board
├── boot
├── CHANGES
├── Config.in
├── Config.in.legacy
├── configs: 放置开发板的一些配置参数. 
├── COPYING
├── DEVELOPERS
├── dl: 存放下载的源代码及应用软件的压缩包. 
├── docs: 存放相关的参考文档. 
├── fs: 放各种文件系统的源代码. 
├── linux: 存放着Linux kernel的自动构建脚本. 
├── Makefile
├── Makefile.legacy
├── output: 是编译出来的输出文件夹. 
│   ├── build: 存放解压后的各种软件包编译完成后的现场.
│   ├── host: 存放着制作好的编译工具链，如gcc、arm-linux-gcc等工具.
│   ├── images: 存放着编译好的uboot.bin, zImage, rootfs等镜像文件，可烧写到板子里, 让linux系统跑起来.
│   ├── staging
│   └── target: 用来制作rootfs文件系统，里面放着Linux系统基本的目录结构，以及编译好的应用库和bin可执行文件. (buildroot根据用户配置把.ko .so .bin文件安装到对应的目录下去，根据用户的配置安装指定位置)
├── package：下面放着应用软件的配置文件，每个应用软件的配置文件有Config.in和soft_name.mk。
├── README
├── support
├── system
└── toolchain
```



## 1.2 buildroot配置

通过make xxx_defconfig来选择一个defconfig，这个文件在config目录下。

然后通过make menuconfig进行配置。



```
Target options  --->选择目标板架构特性。
Build options  --->配置编译选项。
Toolchain  ---> 配置交叉工具链，使用buildroot工具链还是外部提供。
System configuration  --->
Kernel  --->
Target packages  --->
Filesystem images  --->
Bootloaders  --->
Host utilities  --->
Legacy config options  --->
```



## 1.3 make命令使用

通过make help可以看到buildroot下make的使用细节，包括对package、uclibc、busybox、linux以及文档生成等配置。



```
Cleaning:
  clean                  - delete all files created by build
  distclean              - delete all non-source files (including .config)

Build:
  all                    - make world
  toolchain              - build toolchain

Configuration:
  menuconfig             - interactive curses-based configurator--------------------------------对整个buildroot进行配置
  savedefconfig          - Save current config to BR2_DEFCONFIG (minimal config)----------------保存menuconfig的配置

Package-specific:-------------------------------------------------------------------------------对package配置
  <pkg>                  - Build and install <pkg> and all its dependencies---------------------单独编译对应APP
  <pkg>-source           - Only download the source files for <pkg>
  <pkg>-extract          - Extract <pkg> sources
  <pkg>-patch            - Apply patches to <pkg>
  <pkg>-depends          - Build <pkg>'s dependencies
  <pkg>-configure        - Build <pkg> up to the configure step
  <pkg>-build            - Build <pkg> up to the build step
  <pkg>-show-depends     - List packages on which <pkg> depends
  <pkg>-show-rdepends    - List packages which have <pkg> as a dependency
  <pkg>-graph-depends    - Generate a graph of <pkg>'s dependencies
  <pkg>-graph-rdepends   - Generate a graph of <pkg>'s reverse dependencies
  <pkg>-dirclean         - Remove <pkg> build directory-----------------------------------------清除对应APP的编译目录
  <pkg>-reconfigure      - Restart the build from the configure step
  <pkg>-rebuild          - Restart the build from the build step--------------------------------单独重新编译对应APP

busybox:
  busybox-menuconfig     - Run BusyBox menuconfig

uclibc:
  uclibc-menuconfig      - Run uClibc menuconfig

linux:
  linux-menuconfig       - Run Linux kernel menuconfig-----------------------------------------配置Linux并保存设置
  linux-savedefconfig    - Run Linux kernel savedefconfig
  linux-update-defconfig - Save the Linux configuration to the path specified
                             by BR2_LINUX_KERNEL_CUSTOM_CONFIG_FILE

Documentation:
  manual                 - build manual in all formats
  manual-pdf             - build manual in PDF
  graph-build            - generate graphs of the build times----------------------------------对编译时间、编译依赖、文件系统大小生成图标
  graph-depends          - generate graph of the dependency tree
  graph-size             - generate stats of the filesystem size
```



# 2. buildroot框架

 Buildroot提供了函数框架和变量命令框架(下一篇文章将介绍细节)，采用它的框架编写的app_pkg.mk这种Makefile格式的自动构建脚本，将被package/pkg-generic.mk 这个核心脚本展开填充到buildroot主目录下的Makefile中去。

最后make all执行Buildroot主目录下的Makefile，生成你想要的image。 package/pkg-generic.mk中通过调用同目录下的pkg-download.mk、pkg-utils.mk文件，已经帮你自动实现了下载、解压、依赖包下载编译等一系列机械化的流程。

你只要需要按照格式写Makefile脚app_pkg.mk，填充下载地址，链接依赖库的名字等一些特有的构建细节即可。 总而言之，Buildroot本身提供构建流程的框架，开发者按照格式写脚本，提供必要的构建细节，配置整个系统，最后自动构建出你的系统。

![img](https://img2018.cnblogs.com/blog/1083701/201809/1083701-20180925083046481-2052342645.png)

对buildroot的配置通过Config.in串联起来，起点在根目录Config.in中。

| 配置选项                 | Config.in位置          |      |
| ------------------------ | ---------------------- | ---- |
| Target options           | arch/Config.in         |      |
| Build options            | Config.in              |      |
| Toolchain                | toolchain/Config.in    |      |
| System configuration     | system/Config.in       |      |
| Kernel                   | linux/Config.in        |      |
| Target packages          | package/Config.in      |      |
| Target packages->Busybox |                        |      |
| Filesystem images        | fs/Config.in           |      |
| Bootloaders              | boot/Config.in         |      |
| Host utilities           | package/Config.in.host |      |
| Legacy config options    | Config.in.legacy       |      |
|                          |                        |      |

 

# 3. 配置Linux Kernel

对Linux内核的配置包括两部分：通过make menuconfig进入Kernel对内核进行选择，通过make linux-menuconfig对内核内部进行配置。

## 3.1 选择Linux内核版本

如下“Kernel version”选择内核的版本、“Defconfig name”选择内核config文件、“Kernel binary formant”选择内核格式、“Device tree source file names”选择DT文件，

在“Linux Kernel Tools”中选择内核自带的工具，比如perf。

![img](https://img2018.cnblogs.com/blog/1083701/201810/1083701-20181008180838464-759974977.png)

可以选择“Custom Git repository”来指定自己的Git库，在“Custom repository version”中指定branch名称。

选择“Using an in-tree defconfig file”，在“Defconfig name”中输入defconfig名称，注意不需要末尾_defconfig。

选择“Use a device tree present in the kernel”，在“Device Tree Source file names”中输入dts名称，不需要.dts扩展名。

### 3.1.1 Kernel binary format

可以选择vmlinux或者uImage。

uImage是uboot专用的映像文件，它是在zImage之前加上一个长度为64字节的“头”，说明这个内核的版本、加载位置、生成时间、大小等信息；其0x40之后与zImage没区别。 

zImage是ARM Linux常用的一种压缩映像文件，uImage是U-boot专用的映像文件，它是在zImage之前加上一个长度为0x40的“头”，说明这个映像文件的类型、加载位置、生成时间、大小等信息。

vmlinux编译出来的最原始的内核elf文件，未压缩。

zImage是vmlinux经过objcopy gzip压缩后的文件， objcopy实现由vmlinux的elf文件拷贝成纯二进制数据文件。

uImage是U-boot专用的映像文件，它是在zImage之前加上一个长度为0x40的tag。 

 选择vmlinux和uImage的区别在于：

```
PATH="/bin..." BR_BINARIES_DIR=/home/.../output/images /usr/bin/make -j9 HOSTCC="/usr/bin/gcc" HOSTCFLAGS="" ARCH=csky INSTALL_MOD_PATH=/home/.../output/target CROSS_COMPILE="/home/.../output/host/bin/csky-abiv2-linux-" DEPMOD=/home/.../output/host/sbin/depmod INSTALL_MOD_STRIP=1 -C /home/.../linux uImage
```

如果是vmlinux，在结尾就是vmlinux。 

## 3.2 对Kernel进行配置

通过make linux-menuconfig可以对内核内部细节进行配置。

让Linux内核带符号表：

> \# CONFIG_COMPILE_TEST is not set
>
> CONFIG_DEBUG_INFO=y

# 4. 配置文件系统APP

对目标板文件系统内容进行配置主要通过make menuconfig进入Target packages进行。

![img](https://img2018.cnblogs.com/blog/1083701/201809/1083701-20180924110714130-1512546028.png)

在Filesystem images中配置文件系统采用的格式，以及是否使用RAM fs。

![img](https://img2018.cnblogs.com/blog/1083701/201810/1083701-20181009111511772-96992464.png)

## 4.1 ramfs

如果选中“initial RAM filesystem linked into linux kernel”，那么文件系统会集成到vmlinux中。

如不选中，则vmlinux中只包括内核，文件系统会以其他形似提供，比如rootfs.cpio。

如果定义了BR2_TARGET_ROOTFS_INITRAMFS，那么在编译的末期需要重新编译内核，将rootfs.cpio加入到vmlinux中。

fs/initramfs/initramfs.mk中：



```
rootfs-initramfs: linux-rebuild-with-initramfs

rootfs-initramfs-show-depends:
    @echo rootfs-cpio

.PHONY: rootfs-initramfs rootfs-initramfs-show-depends

ifeq ($(BR2_TARGET_ROOTFS_INITRAMFS),y)
TARGETS_ROOTFS += rootfs-initramfs
endif
```



在linux/linux.mk中：



```
.PHONY: linux-rebuild-with-initramfs
linux-rebuild-with-initramfs: $(LINUX_DIR)/.stamp_target_installed
linux-rebuild-with-initramfs: $(LINUX_DIR)/.stamp_images_installed
linux-rebuild-with-initramfs: rootfs-cpio
linux-rebuild-with-initramfs:
    @$(call MESSAGE,"Rebuilding kernel with initramfs")
    # Build the kernel.
    $(LINUX_MAKE_ENV) $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) $(LINUX_TARGET_NAME)
    $(LINUX_APPEND_DTB)
    # Copy the kernel image(s) to its(their) final destination
    $(call LINUX_INSTALL_IMAGE,$(BINARIES_DIR))
    # If there is a .ub file copy it to the final destination
    test ! -f $(LINUX_IMAGE_PATH).ub || cp $(LINUX_IMAGE_PATH).ub $(BINARIES_DIR)
```



在打开initramfs的情况下，重新将rootfs.cpio编译进内核vmlinxu中。

然后将uImage之类的文件拷贝到BINARIES_DIR中。

# 5. 添加自己的APP

要添加自己的本地APP， 首先在package/Config.in中添加指向新增APP目录的Config.in；

然后在package中新增目录helloworld，并在里面添加Config.in和helloworld.mk；

最后添加对应的helloworld目录。

## 5.1 添加package/Config.in入口

系统在make menuconfig的时候就可以找到对应的APP的Config.in。



```
diff --git a/package/Config.in b/package/Config.in
index 43d75a9..6ef9fad 100644
--- a/package/Config.in
+++ b/package/Config.in
@@ -1868,5 +1868,8 @@ menu "Text editors and viewers"
        source "package/uemacs/Config.in"
        source "package/vim/Config.in"
 endmenu
+menu "Private package"
+       source "package/helloworld/Config.in"
+endmenu
```



 如果在make menuconfig的时候选中helloworld，在make savedefconfig的时候就会打开BR2_PACKAGE_HELLOWORLD=y。

## 5.2 配置APP对应的Config.in和mk文件

helloworld/Config.in文件，通过make menuconfig可以对helloworld进行选择。

只有在BR2_PACKAGE_HELLOWORLD=y条件下，才会调用helloworld.mk进行编译。

```
config BR2_PACKAGE_HELLOWORLD
    bool "helloworld"
    help
      This is a demo to add local app.
```

buildroot编译helloworld所需要的设置helloworld.mk，包括源码位置、安装目录、权限设置等。

下面的HELLOWORLD的开头也是必须的。



```
################################################################################
#
# helloworld
#
################################################################################

HELLOWORLD_VERSION:= 1.0.0
HELLOWORLD_SITE:= $(CURDIR)/work/helloworld
HELLOWORLD_SITE_METHOD:=local
HELLOWORLD_INSTALL_TARGET:=YES

define HELLOWORLD_BUILD_CMDS
    $(MAKE) CC="$(TARGET_CC)" LD="$(TARGET_LD)" -C $(@D) all
endef

define HELLOWORLD_INSTALL_TARGET_CMDS
    $(INSTALL) -D -m 0755 $(@D)/helloworld $(TARGET_DIR)/bin
endef

define HELLOWORLD_PERMISSIONS
    /bin/helloworld f 4755 0 0 - - - - -
endef

$(eval $(generic-package))
```



如果源码在git上，需要如下设置：

```
 DMA_TEST_VERSION:=master--------------------------------------仓库分支名称
 DMA_TEST_SITE:=http://.../dma.git-----------------------------仓库git地址
 DMA_TEST_SITE_METHOD:=git-------------------------------------获取源码的方式
```

_VERSION结尾的变量是源码的版本号；_SITE_METHOD结尾的变量是源码下载方法；_SITE结尾变量是源码下载地址。

_BUILD_CMDS结尾的变量会在buildroot框架编译的时候执行，用于给源码的Makefile传递编译选项和链接选项，调用源码的Makefile。

_INSTALL_TARGET_CMDS结尾的变量是在编译完之后，自动安装执行，一般是让buildroot把编译出来的的bin或lib拷贝到指定目录。

$(eval$(generic-package)) 最核心的就是这个东西了，一定不能够漏了，不然源码不会被编译，这个函数就是把整个.mk构建脚本，通过Buildroot框架的方式，展开到Buildroot/目录下的Makfile中，生成的构建目标(构建目标是什么，还记得Makefile中的定义吗？)。

## 5.3 编写APP源码

简单的编写一个helloworld.c文件：



``` cpp
#include <stdio.h>

void main(void)
{
    printf("Hello world.\n");
}
```



然后编写Makefile文件：



``` makefile
CPPFLAGS += 
LDLIBS += 

all: helloworld

analyzestack: helloworld.o
    $(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ $(LDLIBS)

clean:
    rm -f *.o helloworld

.PHONY: all clean
```



## 5.4 通过make menuconfig选中APP

通过Target packages -> Private package进入，选中helloworld。

![img](https://img2018.cnblogs.com/blog/1083701/201809/1083701-20180924195618746-501384137.png)

然后make savedefconfig，对helloworld的配置就会保存到qemu_arm_vexpress_defconfig中。

![img](https://img2018.cnblogs.com/blog/1083701/201809/1083701-20180924195818808-1094559337.png)

## 5.5 编译APP

可以和整个平台一起编译APP；或者make helloworld单独编译。

这两个文件在选中此APP之后，都会被拷贝到output/build/helloworld-1.0.0文件夹中。

然后生成的bin文件拷贝到output/target/bin/helloworld，这个文件会打包到文件系统中。

如果需要清空相应的源文件，通过make helloworld-dirclean。

## 5.6 运行APP

在shell中输入helloworld，可以得到如下结果。

![img](https://img2018.cnblogs.com/blog/1083701/201809/1083701-20180924200913500-640718813.png)

添加APP工作完成。

# 6. uboot配置

使用uboot作为bootloader，需要进行一些配置。

在选中U-boot作为bootloader之后，会弹出一系列相关配置。

“U-Boot board name”配置configs的defconfig名称。

“U-Boot Version”选择Custom Git repository，然后在“URL of custom repository”中选择自己的git地址，并在“Custom repository version”中选择git的分支。

在“U-Boot binary format”中选择想要输出的image格式，比如u-boot.img或者u-image.bin。

还可以选择“Intall U-Boot SPL binary image”，选择合适的SPL。

![img](https://img2018.cnblogs.com/blog/1083701/201810/1083701-20181017204700011-662907882.png)

# 7. Finalizing target

在buildroot编译的末期，需要对编译结果进行一些检查或者其他操作。

buildroot预留了两个接口：

BR2_ROOTFS_OVERLAY - 指向一个目录，此目录下的所有文件将会覆盖到output/target下。比如一些配置文件，或者预编译的库等可以在此阶段处理。

BR2_ROOTFS_POST_BUILD_SCRIPT - 一个脚本，更加复杂的对文件进行删除、重命名、strip等等功能。

BR2_ROOTFS_POST_IMAGE_SCRIPT - 对最终生成的images进行打包处理等。

## 7.1 FS Overlay

有些应用或者配置不通过编译，直接采取拷贝的方式集成到rootfs中，可以设置“System configuration”->“Root filesystem overlay directories”。

设置的目录中的内容，会对output/target进行覆盖。

相关处理在Makefile中如下：

```
    @$(foreach d, $(call qstrip,$(BR2_ROOTFS_OVERLAY)), \
        $(call MESSAGE,"Copying overlay $(d)"); \
        rsync -a --ignore-times --keep-dirlinks $(RSYNC_VCS_EXCLUSIONS) \
            --chmod=u=rwX,go=rX --exclude .empty --exclude '*~' \
            $(d)/ $(TARGET_DIR)$(sep))
```

## 7.2 post build

除了fs overlay这种方式，buildroot还提供了一个脚本进行更加复杂的处理。

可以进行文件删除、重命名，甚至对带调试信息的文件进行strip等。

```
    @$(foreach s, $(call qstrip,$(BR2_ROOTFS_POST_BUILD_SCRIPT)), \
        $(call MESSAGE,"Executing post-build script $(s)"); \
        $(EXTRA_ENV) $(s) $(TARGET_DIR) $(call qstrip,$(BR2_ROOTFS_POST_SCRIPT_ARGS))$(sep))
```

一个post_build.sh范例，对一系列文件进行删除和strip操作：



``` bash
#!/bin/sh
#set -x
set +o errexit

cp -a ${BINARIES_DIR}/deepeye1000e_hk.dtb ${BINARIES_DIR}/deepeye1000.dtb

#Strip files in tbc_lists.txt. tbc means 'to be stripped'.
STRIP=${HOST_DIR}/bin/csky-abiv2-linux-strip

for file in `cat ${BR2_EXTERNAL_INTELLIF_PATH}/board/deepeye1000e_hk/tbs_lists.txt`
do
    if [ -e ${TARGET_DIR}${file} ]; then
        echo Strip ${file}.
        ${STRIP} ${TARGET_DIR}${file}
    else
        echo Not found ${file}.
    fi
done

#Delete files in tbd_lists.txt. tbd means 'to be deleted'
for file in `cat ${BR2_EXTERNAL_INTELLIF_PATH}/board/deepeye1000e_hk/tbd_lists.txt`
do
    if [ -e ${TARGET_DIR}${file} ]; then
        echo Delete ${file}.
        rm ${TARGET_DIR}${file}
    else
        echo Not found ${file}.
    fi
done

${BR2_EXTERNAL_INTELLIF_PATH}/board/common/post_build.sh
```



## 7.2 post image

post image在post build之后，更倾向于生成完整的release文件。包括进行一些images打包、debug文件打包等等。

```
.PHONY: target-post-image
target-post-image: $(TARGETS_ROOTFS) target-finalize
    @$(foreach s, $(call qstrip,$(BR2_ROOTFS_POST_IMAGE_SCRIPT)), \
        $(call MESSAGE,"Executing post-image script $(s)"); \
        $(EXTRA_ENV) $(s) $(BINARIES_DIR) $(call qstrip,$(BR2_ROOTFS_POST_SCRIPT_ARGS))$(sep))
```

一个范例如下，对images文件进行打包操作。



``` bash
#!/bin/sh
set -x -e

IMG_DIR=output/images
DEBUG_DIR=${IMG_DIR}/debug
KERNEL_DIR=output/build/linux-master

ROOTFS_CPIO=${IMG_DIR}/rootfs.cpio
KERNEL_IMAGE=${IMG_DIR}/uImage
SPL_IMAGE=${IMG_DIR}/u-boot-spl-bh.bin
UBOOT_IMAGE=${IMG_DIR}/u-boot.bin

IMG_TAR=images.tar.gz
DEBUG_TAR=debug.tar.gz
IMG_MD5=images.md5

rm -f ${IMG_TAR} ${DEBUG_TAR} ${IMG_MD5}

mkdir -p ${DEBUG_DIR}
cp -a ${KERNEL_DIR}/vmlinux ${KERNEL_DIR}/System.map ${ROOTFS_CPIO} ${DEBUG_DIR}/

tar -czf ${IMG_TAR} ${KERNEL_IMAGE} ${SPL_IMAGE} ${UBOOT_IMAGE}
tar -czf ${DEBUG_TAR} -C ${IMG_DIR} debug/

md5sum ${IMG_TAR} > ${IMG_MD5}
```



# 8. buildroot编译性能

buildroot还提供了一些命令，用于分析buildroot编译过程中耗时、依赖关系、文件系统尺寸等等。

通过make help发现相关命令：



```
Documentation:
  manual                 - build manual in all formats
  manual-html            - build manual in HTML
  manual-split-html      - build manual in split HTML
  manual-pdf             - build manual in PDF
  manual-text            - build manual in text
  manual-epub            - build manual in ePub
  graph-build            - generate graphs of the build times
  graph-depends          - generate graph of the dependency tree
  graph-size             - generate stats of the filesystem size
  list-defconfigs        - list all defconfigs (pre-configured minimal systems)
```



## 8.1 编译耗时

执行make graph-build会生成如下文件：

![img](https://img2018.cnblogs.com/blog/1083701/201906/1083701-20190614102518315-1402017455.png)

其中比较有参考意义的文件是build.hist-duration.pdf文件，按照耗时从大到小排列。

通过此图可以明白整个编译流程时间都耗在哪里，针对性进行分析优化，有利于提高编译效率。

![img](https://img2018.cnblogs.com/blog/1083701/201906/1083701-20190614102612322-720489440.png)

## 8.2 编译依赖关系

生成graph-depends.pdf，可以看出各个编译模块之间的依赖关系。

buildroot的库会根据依赖关系被自动下载，通过此图也可以了解某些某块被谁依赖。

![img](https://img2018.cnblogs.com/blog/1083701/201906/1083701-20190614102833551-596126470.png)

## 8.3 编译结果尺寸分析

通过graph-size.pdf文件可以对整个编译结果组成有个大概理解。

![img](https://img2018.cnblogs.com/blog/1083701/201906/1083701-20190614103316314-758596010.png)

另外更有参考意义的是file-size-stats.csv和package-size-stats.csv文件。

通过file和package两个视角，更加详细的了解整个rootfs空间都被那些文件占用。

![img](https://img2018.cnblogs.com/blog/1083701/201906/1083701-20190614103540889-997109446.png)

《[buildroot认知](https://blog.csdn.net/xixihaha331/article/details/62418849)》

联系方式:arnoldlu@qq.com



分类: [Linux相关学习总结](https://www.cnblogs.com/arnoldlu/category/926714.html)