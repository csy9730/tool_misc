# 3D打印机设计：关于 CoreXY 与 H-bot 之间的选择

[2019年1月16日](https://blog.libcore.org/?p=291)

[添加评论](https://blog.libcore.org/?p=291#respond)

~~本文总结在最后一段，文中 CoreXY 亦可为 CoreXZ、CoreYZ 等。~~

最近打算以低成本、结构简洁有效、组件标准易于拆装替换为目标设计一台3D打印机，各种方案思索再三，决定使用轮带传动的设计，然后就 CoreXY 和 H-bot 等设计方案上网胡搜一通，这里记录一下各自利弊。

事实上 CoreXY 和 H-bot 是两种在原理上相似的方案，无论选择哪种方案固件配置方式都是完全相同的。原理图如下。



H-bot



CoreXY

如果你初看两种方案的同步带布局，一定会选择同步带布局简单明了的 H-bot 方案——确实，这就是 H-bot 方案的优势所在，美观高效还省钱。而 CoreXY 方案引入了过长的同步带，会对系统精度产生不利的影响，而且设计复杂。

但是大量的爱好者使用的是 CoreXY 方案，整理总结 CoreXY 方案的支持者的留言，他们的理由是 H-bot 方案会产生扭矩，对结构刚度要求极高。

以下为我的理解：

提取两种方案四角同步带轮中心点，连线构成一矩形，可认为其为固定框架。当主动轮转动时，同步带会拉动同步带轮，使框架产生由矩形变成菱形的趋势。

情况 (a) 中，H-bot 的两主动轮通过同一同步带传力于滑块的右端连接点，突然的转动 (甚至反向转动) 会使 H-bot 的框架有左倾的趋势，而 CoreXY 的两同步带都传力于滑块左端连接处，因为蓝色同步带绕架半圈，使得两主动轮因同步带而产生的扭矩刚好反向，即使 CoreXY 方案的框架产生 H 变 A 的趋势。对于框架而言，拉压力真算不得什么。

同理，情况 (b) 中，H-bot 的滑杆上两从动同步轮受力，CoreXY 同理，都是产生变 A 的趋势。

如此，CoreXY 方案的优势，尤其是对于3D打印这种滑块频繁往复运动的类型设计优势就显而易见了。

正如 [reddit 上一位老哥](https://www.reddit.com/r/3Dprinting/comments/43t9oa/what_is_the_advantage_of_corexy_over_other_types/czku67f)所说的：

> The sad is real when the gantry starts waving at you.

~~笑得我肚子疼~~

总结：在普通连接组成框架时，优先考虑 CoreXY 方案；当框架刚度极大 (譬如焊接、整体切割时) 时，优先考虑 H-bot 方案。

 

2019年1月16日

[CC BY-SA](https://creativecommons.org/licenses/by-sa/3.0/deed.zh)

图片来自网络，侵删

[DIY](https://blog.libcore.org/?cat=23)

[3D printer](https://blog.libcore.org/?tag=3d-printer), [3D打印](https://blog.libcore.org/?tag=3d打印), [CoreXY](https://blog.libcore.org/?tag=corexy), [CoreXZ](https://blog.libcore.org/?tag=corexz), [CoreYZ](https://blog.libcore.org/?tag=coreyz), [H-bot](https://blog.libcore.org/?tag=h-bot)