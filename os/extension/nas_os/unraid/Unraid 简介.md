# Unraid 简介

[![小迪同学](https://pica.zhimg.com/v2-576e7455a1e20cbe68eefec26719dc6e_l.jpg?source=172ae18b)](https://www.zhihu.com/people/xiaodi-64)

[小迪同学](https://www.zhihu.com/people/xiaodi-64)

5 人赞同了该文章



[Unraid 系统简介2954 播放 · 0 赞同视频![点击可播放视频](https://pic3.zhimg.com/v2-74d1065a8cc2bd2661bb0dbe8518da3b_r.jpg?source=2231c908)](https://www.zhihu.com/zvideo/1408739620964765699)

## **什么是 Unraid**

Unraid 是来自加拿大的一款 Nas 系统，**「按照要使用的硬盘数量」**来收费，6 盘位售价 59 美刀，12 盘位售价 89 美刀，不限硬盘数量售价 129 美刀。

**「官网地址」**[https://unraid.net](https://link.zhihu.com/?target=https%3A//unraid.net/)



![img](https://pic4.zhimg.com/80/v2-18f483bedcb29c9d9fb3c0e7fdcabcbb_1440w.webp)

![img](https://pic3.zhimg.com/80/v2-b48e151180f3450e1e988bec6f50d512_1440w.webp)



## **Unraid 系统特点**

- 系统大小 200 多兆，**「密钥和优盘 ID 绑定」**，系统在优盘内，但是优盘只起引导作用，启动后系统在内存运行；
- **「自带 Docker 和 VMS」**，可以方便的管理安装容器和虚拟机。
- **「Unraid，即不进行硬 Raid。」** 是一种奇特的软 Raid。（网上有很多对 Raid 的详细介绍，这里不再说明）

## **Unraid 的优势**

个人认为商业使用的话，还是要组 Raid，保证数据备份和安全。

但是个人家庭使用的话，尤其是自组 Nas，要频繁折腾，且数据冗余需要多块硬盘，还不如把多的硬盘作为重要数据冷备份盘。

硬 Raid 如果单独拆下一个硬盘，这个盘不可读取，剩下的盘也都不能读取。

Unraid 的软 Raid 特点是只拆分文件夹，不拆分文件，也就是没有硬 Raid 的数据分片功能。单独拆下一个硬盘，文件也都可读可用。

其次，当硬盘处于休眠状态时系统要读取文件，Unraid 只需唤醒文件所在的那个盘即可，而硬 Raid 要**「唤醒所有硬盘」**，因为这个文件在所有的硬盘上。

当然，甲之蜜糖，乙之砒霜。每个人需求不同，各取所需即可。

## **Unraid 的不足**

- 相比群晖强大的用户管理机制，Unraid 的**「用户管理比较简陋」**。
- 得益于强大的系统优化，同配置下，群晖的处理器占用很低，而 Unraid 就要高不少了。（前台界面显示的会高一些，实际可能没有那么高，但也还是比群晖高）
- 其次，一些基本服务群晖系统自带，并且有手机客户端，而 Unraid 需要自己安装，不一定有对应的手机客户端。（折腾党自己安装岂不是更舒服？）
- 数据读写速度局限于单个硬盘 IO，没有硬 Raid 的成倍 IO 提升快。
- 局域网访问速度稍慢。

## **总结**

整体而言，Unraid 是一款挺不错的系统，官方开发很活跃。随着国内用户的增多，系统和论坛也都支持了中文。Unraid 系统安装也很简单，不到一分钟就装好的系统还有谁？

编辑于 2021-08-11 11:10

[网络附加存储（NAS）](https://www.zhihu.com/topic/19571800)

[unraid](https://www.zhihu.com/topic/21634021)