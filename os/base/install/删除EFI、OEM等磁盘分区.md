# 删除EFI、OEM等磁盘分区

[![img](https://upload.jianshu.io/users/upload_avatars/11871735/fbfe1bdd-00ea-4d5a-9a44-cd811bcc6cb2?imageMogr2/auto-orient/strip|imageView2/1/w/96/h/96/format/webp)](https://www.jianshu.com/u/20d21953a704)

[步生莲_34ae](https://www.jianshu.com/u/20d21953a704)关注

2018.06.28 18:21:06字数 334阅读 4,290

打开磁盘管理我们发下有一些EFI、OEM等磁盘分区是没有权限删除也没有权限修改的，有时候还占据了大部分的磁盘空间。

当然，这部分没有权限删除的磁盘空间都是非常重要的，如果没有必要建议不要随便删除，因为可能导致电脑无法开机。

那么这部分空间如何而来呢，有可能是因为多次安装操作系统或者安装双系统等操作残留下来的空间。如果确定其没有当然就可以果断删除。

![img](https://upload-images.jianshu.io/upload_images/11871735-7c54182b1e9701e6.png?imageMogr2/auto-orient/strip|imageView2/2/w/754/format/webp)



### 删除步骤

------

1.搜索cmd右键管理员运行

![img](https://upload-images.jianshu.io/upload_images/11871735-fc30c583ed240329.png?imageMogr2/auto-orient/strip|imageView2/2/w/358/format/webp)

管理员运行cmd

2.打开磁盘管理:输入

> diskpart

![img](https://upload-images.jianshu.io/upload_images/11871735-6cfaedfd4e5ae1f5.png?imageMogr2/auto-orient/strip|imageView2/2/w/979/format/webp)

diskpart

3.输入：

> list disk 

按回车（Enter键）→选择需要修改的磁盘,我选择的是磁盘1

> select disk 1



![img](https://upload-images.jianshu.io/upload_images/11871735-ab052205eb2d62e9.png?imageMogr2/auto-orient/strip|imageView2/2/w/979/format/webp)

4.输入 

> list partition

![img](https://upload-images.jianshu.io/upload_images/11871735-8bc6b2fc17802870.png?imageMogr2/auto-orient/strip|imageView2/2/w/979/format/webp)

5.0选择513mb的分区4进行删除

> select partition 4

![img](https://upload-images.jianshu.io/upload_images/11871735-2b923d36b3a59ca5.png?imageMogr2/auto-orient/strip|imageView2/2/w/979/format/webp)

选择分区4

6.输入set id=7，按回车 重新设置分区id，4表示fat32类型的，7表示NTFS类型的，OEM分区类型为11或12，重新设置分区id之后，之前隐藏的OEM分区就显示出来了，可以跟其他磁盘一样进行删除操作

> set id=7