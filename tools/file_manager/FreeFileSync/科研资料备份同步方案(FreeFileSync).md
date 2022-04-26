# 科研资料备份同步方案(FreeFileSync)

[![Dorad](https://pica.zhimg.com/v2-86e232cbcceabf1ee1709657bd3fb7cc_xs.jpg?source=172ae18b)](https://www.zhihu.com/people/2dorad)

[Dorad](https://www.zhihu.com/people/2dorad)

热爱编程的土木狗

72 人赞同了该文章



## Introduction

作为一名科研民工，科研数据无异于身家性命。无论是数据丢失，还是出差旅行，数据的便携性和安全性都是我们日常的痛点。

本篇介绍一种低成本的科研数据备份同步方案，能够完成科研数据的多端同步。得益于我离校前进行过文件同步，目前在家科研资料齐全。故将该方法与大家分享。

主要工具有：移动硬盘一块(1T, 容量根据实际需要购买)+FreeFileSync软件(开源免费)

## Solution

本方案主要是通过 [FreeFileSync](https://link.zhihu.com/?target=https%3A//freefilesync.org/) 软件，对电脑及移动硬盘上的指定文件夹进行增量同步，实现移动硬盘数据与电脑数据的自动同步。如此，携带移动硬盘出差，便可携带所有科研资料。移动硬盘实际成为了一个科研资料库，将移动硬盘插入任意电脑，均可得到完整的科研材料。同时，电脑数据与移动硬盘数据互为备份，极大降低数据丢失的风险。

### Download and install [FreeFileSync](https://link.zhihu.com/?target=https%3A//freefilesync.org/)

> [FreeFileSync](https://link.zhihu.com/?target=https%3A//baike.baidu.com/item/FreeFileSync/8913709) 是一个免费的、开源的文件夹比较和同步软件。支持Windows、Linux、Mac OS X，它也适用于64位操作系统。

软件下载链接: [https://freefilesync.org/download.php](https://link.zhihu.com/?target=https%3A//freefilesync.org/download.php)

软件支持中文，可通过`Tools->Language`进行切换。

![img](https://pic1.zhimg.com/80/v2-fdea9ea7d1a2133c336182bf0390a888_1440w.jpg)FreeFileSync主页面

软件主页面主要包括： - 菜单栏: 完整的功能列表 - 配置文件及展示区: 当前配置及概要 - 同步区A: 同步文件信息A - 同步区B: 同步文件信息B - 同步文件夹设置: 可配置多个需要同步的文件夹 - 同步参数设置: 可设置**比较规则**、**过滤规则**和**同步规则**

![img](https://pic2.zhimg.com/80/v2-e07305f5f1d640fc3d77bf7fa7682d81_1440w.jpg)功能分区

### [FreeFileSync](https://link.zhihu.com/?target=https%3A//freefilesync.org/) Setting

1. 点击`新建`创建新的配置文件。
2. 配置`同步文件夹`。 根据自身需要，分别设置`源文件夹`和`目标文件夹`路径，两者为一对一关系，可以同时同步多个文件夹。
3. 设置`同步设置`规则。 其中包括**比较规则**、**过滤规则**和**同步规则**，可根据自己需要进行修改。这里推荐使用默认的`双向同步`，双向同步则表示当你的移动硬盘和电脑连接同步时，会自动将两边的内容进行比较同步，留下最新的内容，删除旧内容。

![img](https://pic1.zhimg.com/80/v2-0bdfe1f3fc11da855ab61e9457a2e59c_1440w.jpg)比较规则设置

![img](https://pic2.zhimg.com/80/v2-39a59650ba904b05019dc84a73b5e869_1440w.jpg)过滤规则设置(支持正则表达式)

![img](https://pic1.zhimg.com/80/v2-5f7d871d5ef218f8658801fb0c32cbdc_1440w.jpg)同步规则设置

\4. 比较同步文件夹差异性。 点击`比较`进行文件夹内容分析对比。

![img](https://pic3.zhimg.com/80/v2-728cb028ca398b418448b07c7aef1b8e_1440w.jpg)文件比较结果

\5. 同步文件夹。 点击`同步`进行文件夹同步。

![img](https://pic2.zhimg.com/80/v2-ac5a57f55722018f845f7e33e2dfc2fd_1440w.jpg)文件同步

当两个同步文件夹内容发生变化时，通过文件对比可以发现该软件能够准确识别出两边文件的差异，进行增量同步。

![img](https://pic1.zhimg.com/80/v2-ad3c800143f838bc7b9739f6d377655c_1440w.jpg)增量同步效果

\6. 将配置另存为批处理作业。 由于每次打开软件进行手动同步，确实有些麻烦。便捷的方式便是通过批处理的方式进行同步。 将配置文件另存为`批处理作业`, 设置为最小化运行，将其另存到桌面。

![img](https://pic3.zhimg.com/80/v2-de304649b82ecdbac201a2c8e147bdd2_1440w.jpg)另存为批处理作业

![img](https://pic3.zhimg.com/80/v2-4afaf2335d41d322f26260d6599e21f2_1440w.png)另存批处理作业到桌面

\7. 使用`批处理作业`。 双击桌面上的批处理作业，可见系统状态栏会出现`FreeFileSync`的图标，说明软件正在后台进行文件夹同步。

### Automatic Sync Setting

通过上面的操作，当每次需要文件同步时，双击桌面批处理文件即可进行文件夹同步。 但是该方法毕竟始终需要进行人为同步。其实还可通过 **Windows 系统计划任务**方式，定时运行批处理文件，进行定时自动同步。 **Windows 系统计划任务**使用方法:

- [http://www.111com.net/sys/361/90859.htm](https://link.zhihu.com/?target=http%3A//www.111com.net/sys/361/90859.htm)
- [https://freefilesync.org/manual.php?topic=schedule-batch-jobs](https://link.zhihu.com/?target=https%3A//freefilesync.org/manual.php%3Ftopic%3Dschedule-batch-jobs)

通过设置计划任务，即可完成文件自动同步。配置流程大致如下，不赘述。

![img](https://pic3.zhimg.com/80/v2-b7bfa35c198d605e42e54d0bc0cbe9f6_1440w.jpg)计划任务基础信息

![img](https://pic3.zhimg.com/80/v2-298d5baf09222a2b5cbd10bae28aa31e_1440w.jpg)计划任务触发条件

![img](https://pic3.zhimg.com/80/v2-912f657355b21020dc8fc2160104b0c6_1440w.jpg)计划任务执行动作

## Others

需要注意的是，FreeFileSync 进行增量同步时，无法对文件内部内容进行修改。例如，当同步后，分别对同一 word 文档进行修改，再同步时，软件会报错，会提示你两侧内容均发生修改，需要人为决定保留哪一侧的文件。

![img](https://pic3.zhimg.com/80/v2-ae2a4b7a857c547c1e45b5045485b8d6_1440w.jpg)文件冲突示例

## Reference

- [http://tech.wmzhe.com/article/1748.html](https://link.zhihu.com/?target=http%3A//tech.wmzhe.com/article/1748.html)
- [https://www.cnblogs.com/waw/p/9208578.html](https://link.zhihu.com/?target=https%3A//www.cnblogs.com/waw/p/9208578.html)
- [https://www.cnblogs.com/mat-wu/p/10790767.html](https://link.zhihu.com/?target=https%3A//www.cnblogs.com/mat-wu/p/10790767.html)
- [http://www.111com.net/sys/361/90859.htm](https://link.zhihu.com/?target=http%3A//www.111com.net/sys/361/90859.htm)



- **本文作者：** Dorad
- **Email:** cug.xia@gmail.com
- **本文链接：**[https://blog.cuger.cn/p/37685/](https://link.zhihu.com/?target=https%3A//blog.cuger.cn/p/37685/)
- **版权声明：** 本博客所有文章除特别声明外，均采用 [BY-NC-SA](https://link.zhihu.com/?target=https%3A//creativecommons.org/licenses/by-nc-sa/4.0/) 许可协议。转载请注明出处！

编辑于 2020-03-05 13:30

[科研工作者](https://www.zhihu.com/topic/20051839)

[科研](https://www.zhihu.com/topic/19556895)

[科研工具](https://www.zhihu.com/topic/19894723)